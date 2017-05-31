Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E102F1FD09
	for <e@80x24.org>; Wed, 31 May 2017 15:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdEaPEo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 11:04:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34776 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdEaPEm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 11:04:42 -0400
Received: by mail-pg0-f67.google.com with SMTP id u187so2195214pgb.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AEJcVU42maUFDPIGlqjbbYxvOLgV7i0Zk4iZw16VPCs=;
        b=XjZoWFeknK56SpxkE7x2SpGGXQJsEpD6mPHPfTEEKOk1ltVh3KYwoGGqDcN9v7xnS0
         Xl0eci5jqAEo4/VrBPenoCXmY9CrO5K2yXvsDKQJCf/kgH685hZNHTkP2DwV+OsYWA+3
         fReEwrQGPAKfUr6vlIyvmwbCDOps5wH8VRDgZun3FUVCNZPy/dk0rzZYE4jv3Msh5BIS
         GEDF18A+u8K2msb55Jhl3EwoU5L3e+PXqrKD3mmVHNLzhjhnEHSZ83liYLQM3b+iL+ty
         C4uqkajD6Fr1jVYmSiIxsKZjJ0/7SYntSckvLBSEv4+lxZ6wwfS0VwvzeEWAnRRV04WL
         s7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AEJcVU42maUFDPIGlqjbbYxvOLgV7i0Zk4iZw16VPCs=;
        b=cuuCM/VLPrdaZXOnlMKXOl5i92poLGuCYJ+M4k6Rw/gCSmtDIdsPV/ycLw6ZUPBh2p
         zEjATgHYUo766Fzd1zpjJEPwP+pJidJjG1PHyeq7L6PpM1PdEoPvfqNqdAms8XpbaY+Z
         YQ+ZNdw/1rFdMLZXXb3Oa7Pj1WGV72KDNae0AN0EUcvjYn4JOiHRIrs5OuMfOH1FPdIV
         mV1QHJAtZOBCdsKX3s4gI/o5ft3Z5JTozaJT16eu/8Pa0bPUDWMnt22MRg0LUi8eJtvi
         Yh65J7C8braK1XQIWWTMQwezKh3gU2Bwu75CgVjwXaeVDvde7aJPAqSQepWw8c6Qydot
         KJ7g==
X-Gm-Message-State: AODbwcDtzHJcqMU8qT2Daq1OQ0tF4x38USv4ypeOYiObnaFJV+KW1Yxf
        9hiKNtAijFhYSkCx2ys=
X-Received: by 10.98.59.2 with SMTP id i2mr30558503pfa.50.1496243081446;
        Wed, 31 May 2017 08:04:41 -0700 (PDT)
Received: from kewillf-git.redmond.corp.microsoft.com ([2001:4898:80e8:f::3b6])
        by smtp.gmail.com with ESMTPSA id g20sm30213737pfk.21.2017.05.31.08.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 08:04:40 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 1/2] format-patch: have progress option while generating patches
Date:   Wed, 31 May 2017 08:04:26 -0700
Message-Id: <20170531150427.7820-2-kewillf@microsoft.com>
X-Mailer: git-send-email 2.13.0.92.g73a4ce6a77
In-Reply-To: <20170531150427.7820-1-kewillf@microsoft.com>
References: <20170531150427.7820-1-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When generating patches for the rebase command if the user does
not realize the branch they are rebasing onto is thousands of
commits different there is no progress indication after initial
rewinding message.

This patch allows a progress option to be passed to format-patch
so that the user can be informed the progress of generating the
patch.  This option will then be used by the rebase command when
calling format-patch.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 Documentation/git-format-patch.txt |  8 ++++++++
 builtin/log.c                      | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c890328b02..ee5f99f606 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -23,6 +23,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
+		   [--progress]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
@@ -260,6 +261,7 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 -q::
 --quiet::
 	Do not print the names of the generated files to standard output.
+	Progress is not reported to the standard error stream.
 
 --no-binary::
 	Do not output contents of changes in binary files, instead
@@ -283,6 +285,12 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 	range are always formatted as creation patches, independently
 	of this flag.
 
+--progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message,
diff --git a/builtin/log.c b/builtin/log.c
index 631fbc984f..02c50431b6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -26,6 +26,7 @@
 #include "version.h"
 #include "mailmap.h"
 #include "gpg-interface.h"
+#include "progress.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -1409,6 +1410,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	char *branch_name = NULL;
 	char *base_commit = NULL;
 	struct base_tree_info bases;
+	int show_progress = 0;
+	struct progress *progress = NULL;
 
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
@@ -1480,6 +1483,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_FILENAME(0, "signature-file", &signature_file,
 				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
+		OPT_BOOL(0, "progress", &show_progress,
+			 N_("show progress")),
 		OPT_END()
 	};
 
@@ -1739,8 +1744,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		start_number--;
 	}
 	rev.add_signoff = do_signoff;
+
+	if (show_progress && !quiet)
+		progress = start_progress(_("Generating patch"), total);
 	while (0 <= --nr) {
 		int shown;
+		display_progress(progress, total - nr);
 		commit = list[nr];
 		rev.nr = total - nr + (start_number - 1);
 		/* Make the second and subsequent mails replies to the first */
@@ -1805,6 +1814,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (!use_stdout)
 			fclose(rev.diffopt.file);
 	}
+	stop_progress(&progress);
 	free(list);
 	free(branch_name);
 	string_list_clear(&extra_to, 0);
-- 
2.13.0.92.g73a4ce6a77

