Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF1EC19F2C
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiHAVPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiHAVPI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:15:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0841C419A1
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:15:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z16so15535604wrh.12
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oErV39Ln4p2mM+CNPmuoTUqIvjmR9dGkcIkYXHeUTtA=;
        b=k6niEOm6JAFIH6wrz+j8NHS1FjFYKiXDLO0KTpwb/5uaV01qgvWFiig+82FYTSjf01
         q9lJQSt2MeQTvGw9rmawqO821kXb7dWk0xZZ1mFs4t8maqvUIzp6NW6i3TLp+cB8TOag
         O/iVijnP+OH98E6zfiv4LNBldaVktDoU0Fm/GEMg5kNUr5l/ReGcyJdmZ1ol/zvfoetu
         s8fJVYZW5YENRA0HwZ/b34wwpb+ZCQ5jhviG0XSaKtfzad909up1P75HgDFO2nWnng0T
         rV7riWbEnYFLYJzejrdezcdGioAvsAD5Wb7VPMGzqdmxMixtHt+pZB92jYlMmKSRDbsm
         9KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oErV39Ln4p2mM+CNPmuoTUqIvjmR9dGkcIkYXHeUTtA=;
        b=PqLraDa2Oz9cUGETYwiHyTqtUNFDcYS6066C4LFiJ3XBS3xNCa+qLKUF42U1Oln8Jm
         q44zXjP/emLrFOlC3bKdPgHTlT48feRvxeSUG8B/Cg7Xfhwwur2fd68450IVJQYlmeX0
         g7SuMpjjutNljbGoY5RJq6zws1I/iDfx39OHHpNq5GEHjjDfoLLK2TeFZDezoX4xt6j8
         Noap9TKL5WGWVUgHL9lnpcVX17hhgB4/a3cTcCs6fwPxW5VRkkmXtbM0qVaiig7mHj9Q
         FHzWd62oFJBWx0Tg/ZsASUERBYli8PFOxXo7qM8AWKffppMJCh9UTJrpJDVg6ypUhNEm
         P4OA==
X-Gm-Message-State: ACgBeo0hMHfHMagdYoWjeEzeoutPpbHKlFxxnH0bJfYEtZfC2Xib70Ed
        kTWVij7QB8kIVOb5arxS+7WoCT0OE/8=
X-Google-Smtp-Source: AA6agR469iakm8zY0uRcPy9knV6dVlAbSdChGffLPCrPK5ZIccAbwLnbTPobD+QCk391wHSeLpDABw==
X-Received: by 2002:adf:f94b:0:b0:21e:46fe:bcdb with SMTP id q11-20020adff94b000000b0021e46febcdbmr10885214wrr.143.1659388505057;
        Mon, 01 Aug 2022 14:15:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d6e54000000b0021e5e5cd3a8sm12832663wrz.87.2022.08.01.14.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:15:04 -0700 (PDT)
Message-Id: <d6527049a4f62f3b1f008706443a11a0e0816074.1659388498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 21:14:56 +0000
Subject: [PATCH 5/7] builtin/bugreport.c: add '--no-report' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a '--no-report' option to 'git bugreport' to avoid writing the
'git-bugreport-<suffix>.txt' file. This gives users the option of creating
only the diagnostic archive with '--diagnose' and mirroring the behavior of
the original 'scalar diagnose' as closely as possible.

If a user specifies '--no-report' *without* also specifying '--diagnose',
the 'git bugreport' operation is a no-op; a warning message is printed and
the command returns with a non-error exit code.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-bugreport.txt |  6 ++++++
 builtin/bugreport.c             | 16 +++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index b55658bc287..5eae7a4f950 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -58,6 +58,12 @@ OPTIONS
 	archive is written to the same output directory as the bug report and is
 	named 'git-diagnostics-<formatted suffix>'.
 
+--no-report::
+	Do not write out a 'git-bugreport-<suffix>.txt' file. This option is
+	intended for use with `--diagnose` when only the diagnostic archive is
+	needed. If `--no-report` is used without `--diagnose`, `git bugreport`
+	is a no-op.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index dea11f91386..5ecff70276a 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -361,7 +361,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	int report = -1;
 	time_t now = time(NULL);
 	struct tm tm;
-	int diagnose = 0;
+	int diagnose = 0, skip_summary = 0;
 	char *option_output = NULL;
 	char *option_suffix = "%Y-%m-%d-%H%M";
 	const char *user_relative_path = NULL;
@@ -371,6 +371,8 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	const struct option bugreport_options[] = {
 		OPT_BOOL(0, "diagnose", &diagnose,
 			 N_("generate a diagnostics zip archive")),
+		OPT_BOOL(0, "no-report", &skip_summary,
+			 N_("do not create a summary report")),
 		OPT_STRING('o', "output-directory", &option_output, N_("path"),
 			   N_("specify a destination for the bugreport file(s)")),
 		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
@@ -381,6 +383,11 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, bugreport_options,
 			     bugreport_usage, 0);
 
+	if (skip_summary && !diagnose) {
+		warning(_("Nothing to do!"));
+		return 0;
+	}
+
 	/* Prepare the path to put the result */
 	prefixed_filename = prefix_filename(prefix,
 					    option_output ? option_output : "");
@@ -415,6 +422,13 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 		strbuf_release(&zip_path);
 	}
 
+	if (skip_summary) {
+		free(prefixed_filename);
+		strbuf_release(&buffer);
+		strbuf_release(&report_path);
+		return 0;
+	}
+
 	/* Prepare the report contents */
 	get_bug_template(&buffer);
 
-- 
gitgitgadget

