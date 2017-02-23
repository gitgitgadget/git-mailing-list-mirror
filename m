Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93AB3201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 08:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbdBWINp (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 03:13:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:60516 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdBWINo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 03:13:44 -0500
Received: (qmail 31735 invoked by uid 109); 23 Feb 2017 08:12:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 08:12:32 +0000
Received: (qmail 25751 invoked by uid 111); 23 Feb 2017 08:12:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 03:12:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 03:12:30 -0500
Date:   Thu, 23 Feb 2017 03:12:30 -0500
From:   Jeff King <peff@peff.net>
To:     bs.x.ttp@recursor.net
Cc:     git@vger.kernel.org
Subject: [PATCH 1/4] ident: mark error messages for translation
Message-ID: <20170223081230.4u4xpebfhmr2h4gk@sigill.intra.peff.net>
References: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already translate the big "please tell me who you are"
hint, but missed the individual error messages that go with
it.

Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ident.c b/ident.c
index ac4ae02b4..dde82983a 100644
--- a/ident.c
+++ b/ident.c
@@ -357,13 +357,13 @@ const char *fmt_ident(const char *name, const char *email,
 			if (strict && ident_use_config_only
 			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
 				fputs(_(env_hint), stderr);
-				die("no name was given and auto-detection is disabled");
+				die(_("no name was given and auto-detection is disabled"));
 			}
 			name = ident_default_name();
 			using_default = 1;
 			if (strict && default_name_is_bogus) {
 				fputs(_(env_hint), stderr);
-				die("unable to auto-detect name (got '%s')", name);
+				die(_("unable to auto-detect name (got '%s')"), name);
 			}
 		}
 		if (!*name) {
@@ -371,7 +371,7 @@ const char *fmt_ident(const char *name, const char *email,
 			if (strict) {
 				if (using_default)
 					fputs(_(env_hint), stderr);
-				die("empty ident name (for <%s>) not allowed", email);
+				die(_("empty ident name (for <%s>) not allowed"), email);
 			}
 			pw = xgetpwuid_self(NULL);
 			name = pw->pw_name;
@@ -382,12 +382,12 @@ const char *fmt_ident(const char *name, const char *email,
 		if (strict && ident_use_config_only
 		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
 			fputs(_(env_hint), stderr);
-			die("no email was given and auto-detection is disabled");
+			die(_("no email was given and auto-detection is disabled"));
 		}
 		email = ident_default_email();
 		if (strict && default_email_is_bogus) {
 			fputs(_(env_hint), stderr);
-			die("unable to auto-detect email address (got '%s')", email);
+			die(_("unable to auto-detect email address (got '%s')"), email);
 		}
 	}
 
@@ -403,7 +403,7 @@ const char *fmt_ident(const char *name, const char *email,
 		strbuf_addch(&ident, ' ');
 		if (date_str && date_str[0]) {
 			if (parse_date(date_str, &ident) < 0)
-				die("invalid date format: %s", date_str);
+				die(_("invalid date format: %s"), date_str);
 		}
 		else
 			strbuf_addstr(&ident, ident_default_date());
-- 
2.12.0.rc2.597.g959f68882

