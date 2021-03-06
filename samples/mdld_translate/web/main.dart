import 'package:console_log_handler/console_log_handler.dart';

import 'package:dryice/dryice.dart';

import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:l10n/l10n.dart';

import 'package:mdl/mdl.dart';
import 'package:mdl/mdlobservable.dart';

// 1.) Add the generated messages-File
import 'package:mdl_translate_sample/locale/messages.dart';

import 'main.reflectable.dart';

// Simple Translation-Table for testing
// Make sure that each language has at least one element
//final L10NTranslate translate = new L10NTranslate.withTranslations( {
//    "de": {
//        "Translate me": "Übersetze mich"
//    },
//
//    "en": {
//        "Translate me": ""
//    }
//});

@inject
class Application extends MaterialApplication {
    //final Logger _logger = new Logger('main.Application');

    final ObservableProperty<bool> checkAttribute = new ObservableProperty<bool>(false);

    Application() {
    }

    @override
    void run() {

    }

    //- private -----------------------------------------------------------------------------------

}

main() async {
    final Logger _logger = new Logger('main.Application');

    configLogging();
    initializeReflectable();

    // 2.) Set your language (en,de,fr...)
    final String locale = await findSystemLocale();
    translate.locale = Intl.shortLocale(locale);

    Intl.defaultLocale = locale;
    initializeDateFormatting(locale);

    registerMdl();

    _logger.info("Locale: ${locale}");
    
    final MaterialApplication application = await componentFactory().
        rootContext(Application)
        .addModule(new SampleModule())
        .run();

    application.run();
}


/**
 * Demo Module
 */
class SampleModule extends Module {
    configure() {
        // 3.) Configure Translator
        bind(Translator).toInstance(translate);
    }
}
