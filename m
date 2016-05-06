From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v5 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Fri,  6 May 2016 20:19:26 +0530
Message-ID: <1462546167-1125-2-git-send-email-pranit.bauva@gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
 <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
Cc: christian.couder@gmail.com, chriscool@tuxfamily.org,
	larsxschneider@gmail.com, Johannes.Schindelin@gmx.de,
	sunshine@sunshineco.com, git@vger.kernel.org,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 06 16:52:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayh7c-0001nI-29
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 16:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758246AbcEFOwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 10:52:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33874 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757956AbcEFOwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 10:52:42 -0400
Received: by mail-pf0-f194.google.com with SMTP id 145so10613262pfz.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jcxFS4aUSxKcOJi0JVi20aY8w3uzZGJOPJ2dtxTUHn8=;
        b=E7iI3FhjwwWC18wiTAHE/4eoV1+fvy2/rzk6j44ZBr2QD0QTDAE4G47nqKFKJptkhE
         bgu96sy85Q+EHoJ4FwLzAWEvH3m86ZQMmtmTV5bHjhEeVqv/I4TNTWGLFlPkmgx7Frfm
         7juvT2qO+LrbUbaHumlGCVS6UGsb2hN/QrvydpxgJ4lUi5RCjvXS0EZol4GZBl2IDlHV
         lZfghWvG4GcM8ImHpY0Us5PoYHBPxJxWRRgjHhmYnsAVxRreVc5iSYQJn2OF4BnkJSVe
         RzTigmq3HO+py7D5TE/d5akjdn1kEmXwAKTV/YMb/3z2jw0VIbsTGLIiEDyWBAzku/T0
         G37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jcxFS4aUSxKcOJi0JVi20aY8w3uzZGJOPJ2dtxTUHn8=;
        b=YYA6sOEP1TbMUcVht77yEphU4QRY82yyAsO8iqbYnbTXpGansD65sGtslbEcgB4+xV
         PEMV+KVnkc+8oef5Ax5voxuPgI4p2QBlCa1QLzzLrLNwaaWd2F9Z5AROlNVu4PghKywJ
         AH8GmucIICoieSHnMNtgZngZXqRxCcWQpDWW1jcmUUGriBFZ9Mt8syutWDWKhGByH7As
         n0W4TEL2SLMlPI0lsba4m1axldMqWAIWdHJ2uw095yQp5y5FpgAat6Y2K8ZjdkEeJ6nV
         G0YREwmC+bVbgUdk44er0jnFaoQ0hq6AvoQD9hZMW7G8LK0Epw0Z+9aBIwZBS44jZYxA
         7zWQ==
X-Gm-Message-State: AOPr4FXhnALkrZnvADWftSjIQaDOyT3Us5A6ZymbIcTa2NxOpDHTbqSsHnywNKX5sQfzFg==
X-Received: by 10.98.17.9 with SMTP id z9mr29740861pfi.40.1462546361590;
        Fri, 06 May 2016 07:52:41 -0700 (PDT)
Received: from localhost.localdomain ([183.87.140.254])
        by smtp.gmail.com with ESMTPSA id dh4sm21775410pad.37.2016.05.06.07.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 May 2016 07:52:40 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293786>

`--next-all` is meant to be used as a subcommand to support multiple
"operation mode" though the current implementation does not contain any
other subcommand along side with `--next-all` but further commits will
include some more subcommands.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229..d8de651 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -8,13 +8,17 @@ static const char * const git_bisect_helper_usage[] = {
 	NULL
 };
 
+enum subcommand {
+	NEXT_ALL = 1
+};
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	int next_all = 0;
+	int subcommand = 0;
 	int no_checkout = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "next-all", &next_all,
-			 N_("perform 'git bisect next'")),
+		OPT_CMDMODE(0, "next-all", &subcommand,
+			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -23,9 +27,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
 
-	if (!next_all)
+	if (!subcommand)
 		usage_with_options(git_bisect_helper_usage, options);
 
-	/* next-all */
-	return bisect_next_all(prefix, no_checkout);
+	switch (subcommand) {
+	case NEXT_ALL:
+		return bisect_next_all(prefix, no_checkout);
+	default:
+		die("BUG: unknown subcommand '%d'", subcommand);
+	}
+	return 0;
 }
-- 
2.8.1
