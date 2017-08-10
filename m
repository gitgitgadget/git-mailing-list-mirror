Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E313208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbdHJSdS (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:33:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33215 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbdHJSdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:33:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id c65so1397632pfl.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0rBAfLLFaFlWUgG+XFFBr0RUEOuzF1QVvU3ndnx6wKc=;
        b=RXb1+ozbYIoCxr39hkkGr0cCofMb/aCkEsf9YMegbi0tHP/haBWznSnX1O1krZBLuM
         lsxHZu5f7mora0m6c27hdme5T80rHYcvKPMcNjfCaePrWZMBVZS2S55lhYVGNgJruvz2
         ZwrXIVXAQdLuXSeeDFmoayn2CROJzbAnCAmowhzz0JVW39/ZVuNEnmfjSN/SGgojcKue
         U8mP8yz2HXAmYaScxSXmUHlbzyAdTvgkG+xAZ7tJaBGe5LR0lCCxrFdrWbu2Mobr7bmW
         yBx8YN55U/he14it+2LaH/qyRnV58WV09iLWn36nTyOZYodr2S52FG48Vmh9ZaQdxoCY
         3sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0rBAfLLFaFlWUgG+XFFBr0RUEOuzF1QVvU3ndnx6wKc=;
        b=RsdVGIJ746urqt2rbpQ/x8keoDXBDZfWTRRqXKSeKwEh69QZvgSYRqiNVb2b/HO7LV
         xvn6IoKj+z192osE78ytkfSaVegcfXrZLieTJ6uVHGCwz97RM41x03YdlPohIq8Brq34
         VKySkJh3BnO9wXH1LJDxruMJFhinWvNEosUgX0Atm+ckLrVfwzPzVIzAjq4IfDK3ibTs
         UNt/ubZCW4iOwMBlnUF5Hox3F8NpM9oIj3aavS+KSqc2Q73nRVr5pJXDrB8MK2o8KQkK
         m10odBBkAS2cHehc8x4DrBo9dxZLFhWQL1GXCv9JKYj9zaQ+pffBzHQK0zW+FAKn+W0Y
         vo0Q==
X-Gm-Message-State: AHYfb5gSXSmS/AP73vsM1CrvCWRbHLtp8h9scgQRU/ZUNC3sJBDohpXP
        pGLpO8yC+epkPkJ0mZo=
X-Received: by 10.98.76.201 with SMTP id e70mr13471410pfj.262.1502389995932;
        Thu, 10 Aug 2017 11:33:15 -0700 (PDT)
Received: from kewillf-git01.redmond.corp.microsoft.com ([2001:4898:80e8:2::54f])
        by smtp.gmail.com with ESMTPSA id h14sm12953804pgn.34.2017.08.10.11.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Aug 2017 11:33:15 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH v2 1/2] format-patch: have progress option while generating patches
Date:   Thu, 10 Aug 2017 14:32:55 -0400
Message-Id: <20170810183256.12668-2-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.0.rc0.286.g44127d70e4
In-Reply-To: <20170810183256.12668-1-kewillf@microsoft.com>
References: <20170810183256.12668-1-kewillf@microsoft.com>
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

The progress meter as presented in this patch assumes the thousands of
patches to have a fine granularity as well as assuming to require all the
same amount of work/time for each, such that a steady progress bar
is achieved.

We do not want to estimate the time for each patch based e.g.
on their size or number of touched files (or parents) as that is too
expensive for just a progress meter.

This patch allows a progress option to be passed to format-patch
so that the user can be informed the progress of generating the
patch.  This option is then used by the rebase command when
calling format-patch.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c890328b02..6cbe462a77 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -23,6 +23,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
+		   [--progress]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
@@ -283,6 +284,9 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 	range are always formatted as creation patches, independently
 	of this flag.
 
+--progress::
+	Show progress reports on stderr as patches are generated.
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message,
diff --git a/builtin/log.c b/builtin/log.c
index 725c7b8a1a..b07a5529c2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -27,6 +27,7 @@
 #include "version.h"
 #include "mailmap.h"
 #include "gpg-interface.h"
+#include "progress.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -1422,6 +1423,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	char *branch_name = NULL;
 	char *base_commit = NULL;
 	struct base_tree_info bases;
+	int show_progress = 0;
+	struct progress *progress = NULL;
 
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
@@ -1493,6 +1496,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_FILENAME(0, "signature-file", &signature_file,
 				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
+		OPT_BOOL(0, "progress", &show_progress,
+			 N_("show progress while generating patches")),
 		OPT_END()
 	};
 
@@ -1752,8 +1757,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		start_number--;
 	}
 	rev.add_signoff = do_signoff;
+
+	if (show_progress)
+		progress = start_progress_delay(_("Generating patches"), total, 0, 1);
 	while (0 <= --nr) {
 		int shown;
+		display_progress(progress, total - nr);
 		commit = list[nr];
 		rev.nr = total - nr + (start_number - 1);
 		/* Make the second and subsequent mails replies to the first */
@@ -1818,6 +1827,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (!use_stdout)
 			fclose(rev.diffopt.file);
 	}
+	stop_progress(&progress);
 	free(list);
 	free(branch_name);
 	string_list_clear(&extra_to, 0);
-- 
2.14.0.rc0.286.g44127d70e4

