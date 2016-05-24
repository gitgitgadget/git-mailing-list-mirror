From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v8 1/3] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Tue, 24 May 2016 12:51:22 +0530
Message-ID: <20160524072124.2945-2-pranit.bauva@gmail.com>
References: <20160524072124.2945-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 09:23:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b56g4-0003mW-4m
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 09:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbcEXHWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 03:22:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33172 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbcEXHWv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 03:22:51 -0400
Received: by mail-pf0-f194.google.com with SMTP id b124so738238pfb.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Io2bJUC6V4Yn+RnWD62gVxocPYgf76kLJKneYY7zQmc=;
        b=Z0vOvCCX/fIFUwl2aE4eBfWqGhOGfj6QryH44QYoiitD/AjUSRYfDtAC/e9XWA9cSA
         fhUPsPV1ORwR/yCZOmlkNlN6Dsig61hKf8DV4wUBYhY6PtEcY7XO8laP0qtMXxDWXPob
         y1qxJHZPUKtSIXd4tvQdaEZzJ4r2m/xyyQSDaaMSiw8W9akABCgVeuYjrgGwkQ/zJOBw
         jwLlxdpBGj5yggGi2/F3tBusEff+x6gTK3smh0e6wT19tQGzkRRGfmdM7+ynzdadcDjE
         QRDODpNw7YoVfzIfWfootbjTUd7fBitCvutD89D6OgnuSRvJgkyXpXLskzQKQRcKOZkT
         PKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Io2bJUC6V4Yn+RnWD62gVxocPYgf76kLJKneYY7zQmc=;
        b=duvQTc+3XwTlUqGixPCIOhcQkzjuYYo4kFlERAQnY/gC8HUr8q0hp0cWm8qlLKf3AS
         A/1TRS2OA16dan4w6kq0uHOvpNliyed0FZrBrO5GjWnu+8cybi8hl2r3q52VarQocb/1
         Ys0Xx9Bw6HTPDImo8jY3FrToLQORNdRnT0vS8FFHziMlvSiinQh1v83aB2FQYW1K/RzX
         iYdhCrP38kQ0lY1iOsLYw2pJGzINtE3afPT85GhBOYsAXzlRep9Ga4P8JcjtX3MreLb0
         iFQRdp/8GyJ77/VLYmQ/hH5eoA+ZxHAXvdU1BCzmpEJw/OPPVLFGJ9PKI+BBrlNn6hUh
         Nkxw==
X-Gm-Message-State: ALyK8tKSWi/+ihIg9A2TN18ymukgIEXaaeFi6GdcVyuqOZB0VnB88xsKSzFjP/s5pcuAjw==
X-Received: by 10.98.4.195 with SMTP id 186mr4519850pfe.154.1464074570875;
        Tue, 24 May 2016 00:22:50 -0700 (PDT)
Received: from localhost.localdomain ([183.87.83.48])
        by smtp.gmail.com with ESMTPSA id a5sm2491900pat.19.2016.05.24.00.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 00:22:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160524072124.2945-1-pranit.bauva@gmail.com>
In-Reply-To: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
References: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295422>

`--next-all` is meant to be used as a subcommand to support multiple
"operation mode" though the current implementation does not contain any
other subcommand along side with `--next-all` but further commits will
include some more subcommands.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229..8111c91 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -10,11 +10,11 @@ static const char * const git_bisect_helper_usage[] = {
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	int next_all = 0;
+	enum { NEXT_ALL = 1 } cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "next-all", &next_all,
-			 N_("perform 'git bisect next'")),
+		OPT_CMDMODE(0, "next-all", &cmdmode,
+			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -23,9 +23,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
 
-	if (!next_all)
+	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
 
-	/* next-all */
-	return bisect_next_all(prefix, no_checkout);
+	switch (cmdmode) {
+	case NEXT_ALL:
+		return bisect_next_all(prefix, no_checkout);
+	default:
+		die("BUG: unknown subcommand '%d'", cmdmode);
+	}
+	return 0;
 }
-- 
2.8.3
