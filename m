Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255172070F
	for <e@80x24.org>; Mon, 19 Sep 2016 13:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935947AbcISNJY (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:09:24 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:57015 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1760574AbcISNJV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 09:09:21 -0400
Received: (qmail 23247 invoked from network); 19 Sep 2016 13:09:19 -0000
Received: (qmail 31275 invoked from network); 19 Sep 2016 13:09:19 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 19 Sep 2016 13:09:17 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>
Subject: [PATCH 4/6] i18n: ident: mark hint for translation
Date:   Mon, 19 Sep 2016 13:08:19 +0000
Message-Id: <1474290501-2743-4-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
References: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark env_hint for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 ident.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/ident.c b/ident.c
index e20a772..92c3cca 100644
--- a/ident.c
+++ b/ident.c
@@ -331,17 +331,17 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 }
 
 static const char *env_hint =
-"\n"
-"*** Please tell me who you are.\n"
-"\n"
-"Run\n"
-"\n"
-"  git config --global user.email \"you@example.com\"\n"
-"  git config --global user.name \"Your Name\"\n"
-"\n"
-"to set your account\'s default identity.\n"
-"Omit --global to set the identity only in this repository.\n"
-"\n";
+N_("\n"
+   "*** Please tell me who you are.\n"
+   "\n"
+   "Run\n"
+   "\n"
+   "  git config --global user.email \"you@example.com\"\n"
+   "  git config --global user.name \"Your Name\"\n"
+   "\n"
+   "to set your account\'s default identity.\n"
+   "Omit --global to set the identity only in this repository.\n"
+   "\n");
 
 const char *fmt_ident(const char *name, const char *email,
 		      const char *date_str, int flag)
@@ -356,13 +356,13 @@ const char *fmt_ident(const char *name, const char *email,
 		if (!name) {
 			if (strict && ident_use_config_only
 			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
-				fputs(env_hint, stderr);
+				fputs(_(env_hint), stderr);
 				die("no name was given and auto-detection is disabled");
 			}
 			name = ident_default_name();
 			using_default = 1;
 			if (strict && default_name_is_bogus) {
-				fputs(env_hint, stderr);
+				fputs(_(env_hint), stderr);
 				die("unable to auto-detect name (got '%s')", name);
 			}
 		}
@@ -370,7 +370,7 @@ const char *fmt_ident(const char *name, const char *email,
 			struct passwd *pw;
 			if (strict) {
 				if (using_default)
-					fputs(env_hint, stderr);
+					fputs(_(env_hint), stderr);
 				die("empty ident name (for <%s>) not allowed", email);
 			}
 			pw = xgetpwuid_self(NULL);
@@ -381,12 +381,12 @@ const char *fmt_ident(const char *name, const char *email,
 	if (!email) {
 		if (strict && ident_use_config_only
 		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
-			fputs(env_hint, stderr);
+			fputs(_(env_hint), stderr);
 			die("no email was given and auto-detection is disabled");
 		}
 		email = ident_default_email();
 		if (strict && default_email_is_bogus) {
-			fputs(env_hint, stderr);
+			fputs(_(env_hint), stderr);
 			die("unable to auto-detect email address (got '%s')", email);
 		}
 	}
-- 
2.7.4

