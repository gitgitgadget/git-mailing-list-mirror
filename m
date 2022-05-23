Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D357C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 01:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiEWB0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 21:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiEWBZx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 21:25:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB2D37A09
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:51 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b135so610656pfb.12
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AnBMZKGajiLDJUky8IQbo46EnbcmE+P4rHYYKYG2YGY=;
        b=INxwN4gYSISAd3m60Xd+WzZdvNWmmsRG3CldcGeti4ugv8611+w2wFACDrlf/YLfqY
         ATqkSjr3KUnxZov4akzsludcQs5WDZFPW/OGpkU2ULpPfusXMV6izZw/rBjXtp5vwQ1R
         w+0B/rVXteyfypnedMbhVTcKvAsJow1ZrX19QNBk4pnSBuwYsAPOOYtkZqXcivAHoj8q
         81RIbWuys7YqcBjif3bApapd8XEP7fv+zz5bY4AMM3AhcKJruEkh9NSxuWkGJ5jnDRED
         Pa82cYLVtDQTDyFZYa7IOdF5yc04lEztfl/VtAhdAekAEz9GHzSTGYNDOMYNKUa3wnmu
         hTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AnBMZKGajiLDJUky8IQbo46EnbcmE+P4rHYYKYG2YGY=;
        b=zw6MXIvjuOPBtmj9HiriE77K38Yl7SyZMzb+Y/DlKfet5QbdRkUdDGT93kAJK6MjOe
         4ozvT8wFsYkJLppKbt2Mcr/4mB9SYaBTj8JFm24VXhjsavRjQJn1OWIFa7CBVNBtgvDs
         ceyM0LWgjwCnySzH5TAvi1A/36a8qKq2/DUSHeuvon4BHvoWshHAXCjpVVILlmx202HE
         x7DJkBrshTgvkliztbYHCUk0k5y7OQs8HnjW5Ht8Tt4zeNfj2OrEcG+Qrd10mZHP/s2i
         JXP6vmTkKtWHGXDYAWS0j2olF5C3BXSu1lO8hvX8ytjM6XHv675cgfiYJh42Nq+x5J1W
         9Pwg==
X-Gm-Message-State: AOAM530jTqCijl4MZpS3Xl/QAYXnYbZp5V5FuTcmEqAjNnTfFkVnDfxa
        dYHOY+TjxK+XF/pzsCuPaZE=
X-Google-Smtp-Source: ABdhPJwsU/umhSN1J7Sq7RXSpHoR9+WB9Du/6g5cT8DnfzaIS/Zr7JrU/GE/6WZjBV0f89h7ZKUdYA==
X-Received: by 2002:a65:6888:0:b0:3f5:f0e3:c443 with SMTP id e8-20020a656888000000b003f5f0e3c443mr18228435pgt.396.1653269151336;
        Sun, 22 May 2022 18:25:51 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7985a000000b00518142f8c37sm6027566pfq.171.2022.05.22.18.25.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2022 18:25:50 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 9/9] l10n: Document the new l10n workflow
Date:   Mon, 23 May 2022 09:25:31 +0800
Message-Id: <20220523012531.4505-10-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220519081548.3380-1-worldhello.net@gmail.com>
References: <20220519081548.3380-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Change the "flow" of how translators interact with the l10n repository
at [1] to adjust it for a new workflow of not having a po/git.pot file
in-tree at all, and to not commit line numbers to the po/*.po files
that we do track in tree.

The current workflow was added in a combination of dce37b66fb0 (l10n:
initial git.pot for 1.7.10 upcoming release, 2012-02-13) and
271ce198cd0 (Update l10n guide, 2012-02-29).

As noted in preceding commits I think that it came about due to
technical debt I'd left behind in how the "po/git.pot" file was
created, and a mis-impression that the file:line comments were needed
as anything more than a transitory translation aid.

As the updated po/README.md shows the new workflow is substantially
the same, the difference is that translators no longer need to
initially pull from the l10n coordinator for a new po/git.pot, they
can simply use git.git's canonical source repository.

The l10n coordinator is still expected to announce a release to
translate, which presumably would always be Junio's latest release
tag. I'm not certain if this part of the process is actually
important. I.e. the delta translation-wise between that tag and
"master" is usually pretty small, so perhaps translators can just work
on "master" instead.

1. https://github.com/git-l10n/git-po/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 po/README.md | 230 ++++++++++++++++++++++++++-------------------------
 1 file changed, 117 insertions(+), 113 deletions(-)

diff --git a/po/README.md b/po/README.md
index 19fabb4acf..74856ca5bf 100644
--- a/po/README.md
+++ b/po/README.md
@@ -9,8 +9,14 @@ coordinates our localization effort in the l10 coordinator repository:
 
     https://github.com/git-l10n/git-po/
 
-The two character language translation codes are defined by ISO\_639-1, as
-stated in the gettext(1) full manual, appendix A.1, Usual Language Codes.
+We will use XX as an alias to refer to the language translation code in
+the following paragraphs, for example we use "po/XX.po" to refer to the
+translation file for a specific language. But this doesn't mean that
+the language code has only two letters. The language code can be in one
+of two forms: "ll" or "ll\_CC". Here "ll" is the ISO 639 two-letter
+language code and "CC" is the ISO 3166 two-letter code for country names
+and subdivisions. For example: "de" for German language code, "zh\_CN"
+for Simplified Chinese language code.
 
 
 ## Contributing to an existing translation
@@ -39,72 +45,74 @@ language, so that the l10n coordinator only needs to interact with one
 person per language.
 
 
-## Core translation
+## Translation Process Flow
 
-The core translation is the smallest set of work that must be completed
-for a new language translation. Because there are more than 5000 messages
-in the template message file "po/git.pot" that need to be translated,
-this is not a piece of cake for the contributor for a new language.
+The overall data-flow looks like this:
 
-The core template message file which contains a small set of messages
-will be generated in "po-core/core.pot" automatically by running a helper
-program named "git-po-helper" (described later).
+    +-------------------+             +------------------+
+    | Git source code   | ----(2)---> | L10n coordinator |
+    | repository        | <---(5)---- | repository       |
+    +-------------------+             +------------------+
+                    |                     |    ^
+                   (1)                   (3)  (4)
+                    V                     v    |
+               +----------------------------------+
+               |        Language Team XX          |
+               +----------------------------------+
 
-```shell
-git-po-helper init --core XX.po
-```
+- Translatable strings are marked in the source file.
+- Language teams can start translation iterations at any time, even
+  before the l10n window opens:
 
-After translating the generated "po-core/XX.po", you can merge it to
-"po/XX.po" using the following commands:
+  + Pull from the master branch of the source (1)
+  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
+  + Translate the message file "po/XX.po"
 
-```shell
-msgcat po-core/XX.po po/XX.po -s -o /tmp/XX.po
-mv /tmp/XX.po po/XX.po
-git-po-helper update XX.po
-```
+- The L10n coordinator pulls from source and announces the l10n window
+  open (2)
+- Language team pulls from the l10n coordinator, starts another
+  translation iteration against the l10n coordinator's tree (3)
 
-Edit "po/XX.po" by hand to fix "fuzzy" messages, which may have misplaced
-translated messages and duplicate messages.
+  + Run "git pull --rebase" from the l10n coordinator
+  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
+  + Translate the message file "po/XX.po"
+  + Squash trivial l10n git commits using "git rebase -i"
 
+- Language team sends pull request to the l10n coordinator (4)
+- L10n coordinator checks and merges
+- L10n coordinator asks the result to be pulled (5).
 
-## Translation Process Flow
 
-The overall data-flow looks like this:
+## Dynamically generated POT files
 
-    +-------------------+            +------------------+
-    | Git source code   | ---(1)---> | L10n coordinator |
-    | repository        | <---(4)--- | repository       |
-    +-------------------+            +------------------+
-                                          |      ^
-                                         (2)    (3)
-                                          V      |
-                                     +------------------+
-                                     | Language Team XX |
-                                     +------------------+
+POT files are templates for l10n contributors to create or update their
+translation files. We used to have the "po/git.pot" file which was
+generated by the l10n coordinator, but this file had been removed from
+the tree.
 
-- Translatable strings are marked in the source file.
-- L10n coordinator pulls from the source (1)
-- L10n coordinator updates the message template "po/git.pot"
-- Language team pulls from L10n coordinator (2)
-- Language team updates the message file "po/XX.po"
-- L10n coordinator pulls from Language team (3)
-- L10n coordinator asks the result to be pulled (4).
+The two POT files "po/git.pot" and "po/git-core.pot" can be created
+dynamically when necessary.
 
+L10n contributors use "po/git.pot" to prepare translations for their
+languages, but they are not expected to modify it. The "po/git.pot" file
+can be generated manually with the following command:
 
-## Maintaining the "po/git.pot" file
+```shell
+make po/git.pot
+```
 
-(This is done by the l10n coordinator).
+The "po/git-core.pot" file is the template for core translations. A core
+translation is the minimum set of work necessary to complete a
+translation of a new language. Since there are more than 5000 messages
+in the full set of template message file "po/git.pot" that need to be
+translated, this is not a piece of cake for new language contributors.
 
-The "po/git.pot" file contains a message catalog extracted from Git's
-sources. The l10n coordinator maintains it by adding new translations with
-msginit(1), or update existing ones with msgmerge(1).  In order to update
-the Git sources to extract the messages from, the l10n coordinator is
-expected to pull from the main git repository at strategic point in
-history (e.g. when a major release and release candidates are tagged),
-and then run "make pot" at the top-level directory.
+The "core" template file "po/git-core.pot" can be generated manually
+by running:
 
-Language contributors use this file to prepare translations for their
-language, but they are not expected to modify it.
+```shell
+make po/git-core.pot
+```
 
 
 ## Initializing a "XX.po" file
@@ -115,32 +123,14 @@ If your language XX does not have translated message file "po/XX.po" yet,
 you add a translation for the first time by running:
 
 ```shell
-msginit --locale=XX
+make po-init PO_FILE=po/XX.po
 ```
 
-in the "po/" directory, where XX is the locale, e.g. "de", "is", "pt\_BR",
-"zh\_CN", etc.
-
-Then edit the automatically generated copyright info in your new "XX.po"
-to be correct, e.g. for Icelandic:
-
-```diff
-@@ -1,6 +1,6 @@
--# Icelandic translations for PACKAGE package.
--# Copyright (C) 2010 THE PACKAGE'S COPYRIGHT HOLDER
--# This file is distributed under the same license as the PACKAGE package.
-+# Icelandic translations for Git.
-+# Copyright (C) 2010 Ævar Arnfjörð Bjarmason <avarab@gmail.com>
-+# This file is distributed under the same license as the Git package.
- # Ævar Arnfjörð Bjarmason <avarab@gmail.com>, 2010.
-```
-
-And change references to PACKAGE VERSION in the PO Header Entry to
-just "Git":
+where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
 
-```shell
-perl -pi -e 's/(?<="Project-Id-Version: )PACKAGE VERSION/Git/' XX.po
-```
+The newly generated message file "po/XX.po" is based on the core pot
+file "po/git-core.pot", so it contains only a minimal set of messages
+and it's a good start for a new language contribution.
 
 Once you are done testing the translation (see below), commit the result
 and ask the l10n coordinator to pull from you.
@@ -153,19 +143,53 @@ and ask the l10n coordinator to pull from you.
 If you are replacing translation strings in an existing "XX.po" file to
 improve the translation, just edit the file.
 
-If there's an existing "XX.po" file for your language, but the repository
-of the l10n coordinator has newer "po/git.pot" file, you would need to first
-pull from the l10n coordinator (see the beginning of this document for its
-URL), and then update the existing translation by running:
+If you want to find new translatable strings in source files of upstream
+repository and propagate them to your "po/XX.po", run command:
 
 ```shell
-msgmerge --add-location --backup=off -U XX.po git.pot
+make po-update PO_FILE=po/XX.po
 ```
 
-in the "po/" directory, where "XX.po" is the file you want to update.
+It will:
 
-Once you are done testing the translation (see below), commit the result
-and ask the l10n coordinator to pull from you.
+- Call "make po/git.pot" to generate new "po/git.pot" file
+- Call "msgmerge --add-location --backup=off -U po/XX.po po/git.pot"
+  to update your "po/XX.po"
+- The "--add-location" option for msgmerge will add location lines,
+  and these location lines will help translation tools to locate
+  translation context easily.
+
+Once you are done testing the translation (see below), it's better
+to commit a location-less "po/XX.po" file to save repository space
+and make a user-friendly patch for review.
+
+To save a location-less "po/XX.po" automatically in repository, you
+can:
+
+First define a new attribute for "po/XX.po" by appending the following
+line in ".git/info/attributes":
+
+```
+/po/XX.po filter=gettext-no-location
+```
+
+Then define the driver for the "gettext-no-location" clean filter to
+strip out both filenames and locations from the contents as follows:
+
+```shell
+git config --global filter.gettext-no-location.clean \
+           "msgcat --no-location -"
+```
+
+For users who have gettext version 0.20 or higher, it is also possible
+to define a clean filter to preserve filenames but not locations:
+
+```shell
+git config --global filter.gettext-no-location.clean \
+           "msgcat --add-location=file -"
+```
+
+You're now ready to ask the l10n coordinator to pull from you.
 
 
 ## Fuzzy translation
@@ -196,6 +220,14 @@ common errors, e.g. missing printf format strings, or translated
 messages that deviate from the originals in whether they begin/end
 with a newline or not.
 
+L10n coordinator will check your contributions using a helper program
+(see "PO helper" section below):
+
+```shell
+git-po-helper check-po po/XX.po
+git-po-helper check-commits <rev-list-opts>
+```
+
 
 ## Marking strings for translation
 
@@ -370,29 +402,6 @@ l10n workflow.
 To build and install the helper program from source, see
 [git-po-helper/README][].
 
-Usage for git-po-helper:
-
-- To start a new language translation:
-
-  ```shell
-  git-po-helper init XX.po
-  ```
-
-- To update your "XX.po" file:
-
-  ```shell
-  git-po-helper update XX.po
-  ```
-
-- To check commit log and syntax of "XX.po":
-
-  ```shell
-  git-po-helper check-po XX.po
-  git-po-helper check-commits
-  ```
-
-Run "git-po-helper" without arguments to show usage.
-
 
 ## Conventions
 
@@ -436,13 +445,8 @@ additional conventions:
 - Initialize proper filename of the "XX.po" file conforming to
   iso-639 and iso-3166.
 
-- Must complete a minimal translation based on the "po-core/core.pot"
-  template. Using the following command to initialize the minimal
-  "po-core/XX.po" file:
-
-  ```shell
-  git-po-helper init --core <your-language>
-  ```
+- Must complete a minimal translation based on the "Core
+  translation". See that section above.
 
 - Add a new entry in the "po/TEAMS" file with proper format, and check
   the syntax of "po/TEAMS" by running the following command:
-- 
2.36.0.1.g15c4090757

