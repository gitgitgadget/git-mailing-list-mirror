From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v7 1/3] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Mon, 23 May 2016 20:18:46 +0530
Message-ID: <1464014928-31548-2-git-send-email-pranit.bauva@gmail.com>
References: <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
 <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	chriscool@tuxfamily.org, christian.couder@gmail.com,
	sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 16:50:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4rBr-00084B-I3
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 16:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109AbcEWOuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 10:50:39 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36461 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040AbcEWOui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 10:50:38 -0400
Received: by mail-pa0-f67.google.com with SMTP id eu11so1121634pad.3
        for <git@vger.kernel.org>; Mon, 23 May 2016 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lsPiTNhi6mOxB8d2iBEqMJKi2eKtqi/4SVkHXlaMJDs=;
        b=Q2o0TLSZmW3W9o+ZjuiVrLhj9k+33y2WhG72MZd3yA8XZcc49jEfnVP3DO5wTck3gR
         aFFwL53hlDyt4fxAG1kcPjJQ4LPzn3R/v3g5qUuLwzFkb/sSm88fDJpr90SGYkxtXWAC
         z61tileFRMuy9mwu+5i/5wPFRr9/MORR3W4kLrDSGvXyBUQylWKiNJ1ys9ozlcBkxX09
         Ij/GADo5n5n1XcAz7vTlv0NrW9PZmh9PzfAjHirSGplaH5hpeZQCzmBuo5dBpCJ/sH9L
         wgeST9shTGmQ890HIC6UG55g9v3/61IfjvxHJ642BymjUir8bEvYCA3//Q4TuU040e5e
         0Hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lsPiTNhi6mOxB8d2iBEqMJKi2eKtqi/4SVkHXlaMJDs=;
        b=DInDLGsAOWW1cqRd9SQpr1VOjOkWHZJgrAAiOFwT3gEgcFEC+nDN1/YF7tIvOUQzGd
         woxjElfUkyKRZzGn9Tkhh81lF+Di6mcY8O9cveIQfsMlGOFZ+A3GvV6Lvx8GObtZCyxJ
         5g+HyEBbuUgrZidgTrlMgAvTV0G/GdBeea3cGo8J4RTxr8X3ztNDi5isLK4fBZPpLStV
         /9voKzS/NeV9JXDNZiiGKTWj7EoWYFmxshg7ohGma0DseTCkHJFqGMYixCIA57J/sf7p
         fcBowSuUkSy0ZvPgPUnFdUJ2+6JylH7wfDNvjD4oDshNVKnL83/7QwCbm8swGABKGD3N
         ekjw==
X-Gm-Message-State: ALyK8tJUIIP2hopvSdYFZL4F3Hs80f2IpMdk+lQFzOSO2a2vzjb1AnHRPPfw+m5fep3NlA==
X-Received: by 10.66.145.228 with SMTP id sx4mr23281295pab.131.1464015037541;
        Mon, 23 May 2016 07:50:37 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id x89sm47301031pfa.87.2016.05.23.07.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 May 2016 07:50:36 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295328>

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
2.8.2
