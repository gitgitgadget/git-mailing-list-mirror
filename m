Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261831FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 21:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbcFQVyl (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:54:41 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:38371 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752780AbcFQVyj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 17:54:39 -0400
Received: (qmail 1360 invoked from network); 17 Jun 2016 21:54:36 -0000
Received: (qmail 30380 invoked from network); 17 Jun 2016 21:54:36 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 21:54:36 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 34/38] i18n: init-db: join message pieces
Date:	Fri, 17 Jun 2016 21:54:11 +0000
Message-Id: <1466200455-16951-5-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Join message displayed during repository initialization in one entire
sentence.  That would improve translations since it's easier translate
an entire sentence than translating each piece.

Update Icelandic translation to reflect the changes.  The Icelandic
translation of these messages is used with test
t0204-gettext-reencode-sanity.sh and not updating the translation would
fail the test.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/init-db.c | 17 ++++++++++-------
 po/is.po          | 46 ++++++++++++++++++++++++++++------------------
 2 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index b2d8d40..3a45f0b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -397,13 +397,16 @@ int init_db(const char *template_dir, unsigned int flags)
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 
-		/* TRANSLATORS: The first '%s' is either "Reinitialized
-		   existing" or "Initialized empty", the second " shared" or
-		   "", and the last '%s%s' is the verbatim directory name. */
-		printf(_("%s%s Git repository in %s%s\n"),
-		       reinit ? _("Reinitialized existing") : _("Initialized empty"),
-		       get_shared_repository() ? _(" shared") : "",
-		       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+		if (reinit)
+			printf(get_shared_repository()
+			       ? _("Reinitialized existing shared Git repository in %s%s\n")
+			       : _("Reinitialized existing Git repository in %s%s\n"),
+			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+		else
+			printf(get_shared_repository()
+			       ? _("Initialized empty shared Git repository in %s%s\n")
+			       : _("Initialized empty Git repository in %s%s\n"),
+			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
 	}
 
 	return 0;
diff --git a/po/is.po b/po/is.po
index 8692a8b..b8b34fd 100644
--- a/po/is.po
+++ b/po/is.po
@@ -7,14 +7,15 @@ msgid ""
 msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2010-09-20 14:44+0000\n"
-"PO-Revision-Date: 2010-06-05 19:06 +0000\n"
-"Last-Translator: Ævar Arnfjörð Bjarmason <avarab@gmail.com>\n"
+"POT-Creation-Date: 2016-06-17 18:55+0000\n"
+"PO-Revision-Date: 2016-06-17 19:17+0000\n"
+"Last-Translator: Vasco Almeida <vascomalmeida@sapo.pt>\n"
 "Language-Team: Git Mailing List <git@vger.kernel.org>\n"
 "Language: is\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
+"X-Generator: Poedit 1.8.5\n"
 
 #. TRANSLATORS: This is a test. You don't need to translate it.
 #: t/t0200/test.c:5
@@ -72,22 +73,31 @@ msgstr "TILRAUN: Perl tilraunastrengur"
 msgid "TEST: A Perl test variable %s"
 msgstr "TILRAUN: Perl tilraunastrengur með breytunni %s"
 
-#. TRANSLATORS: The first '%s' is either "Reinitialized
-#. existing" or "Initialized empty", the second " shared" or
-#. "", and the last '%s%s' is the verbatim directory name.
-#: builtin/init-db.c:355
+#: builtin/init-db.c:402
 #, c-format
-msgid "%s%s Git repository in %s%s\n"
-msgstr "%s%s Git lind í %s%s\n"
+msgid "Reinitialized existing shared Git repository in %s%s\n"
+msgstr "Endurgerði Git lind í %s%s\n"
 
-#: builtin/init-db.c:356
-msgid "Reinitialized existing"
-msgstr "Endurgerði"
+#: builtin/init-db.c:403
+#, c-format
+msgid "Reinitialized existing Git repository in %s%s\n"
+msgstr "Endurgerði Git lind í %s%s\n"
+
+#: builtin/init-db.c:407
+#, c-format
+msgid "Initialized empty shared Git repository in %s%s\n"
+msgstr "Bjó til tóma sameiginlega Git lind í %s%s\n"
+
+#: builtin/init-db.c:408
+#, c-format
+msgid "Initialized empty Git repository in %s%s\n"
+msgstr "Bjó til tóma Git lind í %s%s\n"
+
+#~ msgid "Reinitialized existing"
+#~ msgstr "Endurgerði"
 
-#: builtin/init-db.c:356
-msgid "Initialized empty"
-msgstr "Bjó til tóma"
+#~ msgid "Initialized empty"
+#~ msgstr "Bjó til tóma"
 
-#: builtin/init-db.c:357
-msgid " shared"
-msgstr " sameiginlega"
+#~ msgid " shared"
+#~ msgstr " sameiginlega"
-- 
2.6.6

