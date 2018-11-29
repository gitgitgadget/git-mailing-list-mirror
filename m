Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E78211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeK3JGW (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38884 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeK3JGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id p86so2634364lfg.5
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFl9RLhgjAEyYNcW8xqweiXbEfejU8kUxccfMHPX+/M=;
        b=kNMoi7CP2LoXgyIG9NPwPFYJzcEBP39wYpqUaXqyytAbuRDePGC2h0pC3wgf+L5xXJ
         js1tsplneNfCD2nBkIf37k1ZJQavtZ2B7MPjifi4eYjcqOXoa2hSZ1oQLIrMMYIf2xTS
         41bgFAuyoxvhcKGgaBW3Xhh6x2iVCncuPNn651VFs09RawTfjnwqgWHme9v2NfVNsAm1
         4ROFXaeYAB0U+NbvDWPbQQDgs9rJP5utdqOu6rjfCci+C5yXYAOr3WNxbaUX2mjEccI8
         dPqUi2dzUGFUyOzUxZ4PypXr/oi0/FEykvNhaZCrqdDN9Fw8iGZtQlb/VDB3etgdG44C
         qpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFl9RLhgjAEyYNcW8xqweiXbEfejU8kUxccfMHPX+/M=;
        b=X6UwpBhpuR3z/Qt5I51ng3we1wGUOtKEU6sDXu5jg2cuiJ6iXVb4bsaxzpZzB1I44Y
         C1DuxlthwgMczMOi3fO/CL55ICF73N3YyukkKCun/L+SEDyxT9A386CO68u+ZTBnSeT3
         7yXnnwyJAl+Yo6UHI58sw1s0jjIBNWm0cVtx+UC8DDary1VCTsnvFYKFt3SBbQPdfHPl
         H00EZnuA6dJbUnuKz408UiFVn7xa0R5YhVdROeEpdhAZwIoNtd59Ib4dXIn04308Vrkf
         OLFWqtU+EF4tZ9H2Qz1gOox+qoEY9yKNuKF3LjnSIBl+eWoInUswZLI+27UToEfLgVFk
         ssGA==
X-Gm-Message-State: AA+aEWYLPkOo/YKBJMvs+zo1p8eNhyio6Ho2FYPdx2lLo9W9yMv6w/5g
        FI67hO4DYM1uyMv1vxSpnYU=
X-Google-Smtp-Source: AFSGD/WQFRtLu1v4XSRzNt3KhLqSQ67hApSNoX+X/JeU1EKtIiv4uRl/t/H0E0NPKlJ4BhdPtu3Dhw==
X-Received: by 2002:a19:1019:: with SMTP id f25mr2081608lfi.54.1543528766090;
        Thu, 29 Nov 2018 13:59:26 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:25 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 12/14] restore-files: take tree-ish from --from option instead
Date:   Thu, 29 Nov 2018 22:58:47 +0100
Message-Id: <20181129215850.7278-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another departure from 'git checkout' syntax, which uses -- to
separate ref and pathspec. The observation is restore-files (or "git
checkout ,, <pathspec>") is most often used to restore some files from
the index. If this is correct, we can simplify it by taking a way the
ref, so that we can write

    git restore-files some-file

without worrying about some-file being a ref and whether we need to do

    git restore-files -- some-file

for safety. If the source of the restore comes from a tree, it will be
in the form of an option with value, e.g.

    git restore-files --from=this-tree some-file

This is of course longer to type than using "--". But hopefully it
will not be used as often, and it is clearly easier to understand.

dwim_new_local_branch is no longer set (or unset) in cmd_restore_files()
because it's irrelevant because we don't really care about dwim-ing.
With accept_ref being unset, dwim can't happen.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index fbfebba2d9..7ff9951818 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -39,7 +39,7 @@ static const char * const switch_branch_usage[] = {
 };
 
 static const char * const restore_files_usage[] = {
-	N_("git restore-files [<options>] [<branch>] -- <file>..."),
+	N_("git restore-files [<options>] [--from=<branch>] <file>..."),
 	NULL,
 };
 
@@ -56,6 +56,7 @@ struct checkout_opts {
 	int ignore_other_worktrees;
 	int show_progress;
 	int dwim_new_local_branch;
+	int accept_ref;
 	int accept_pathspec;
 	int switch_branch_doing_nothing_not_ok;
 
@@ -75,6 +76,7 @@ struct checkout_opts {
 	int branch_exists;
 	const char *prefix;
 	struct pathspec pathspec;
+	const char *from_treeish;
 	struct tree *source_tree;
 };
 
@@ -1337,6 +1339,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 {
 	struct branch_info new_branch_info;
 	int dwim_remotes_matched = 0;
+	int parseopt_flags = 0;
 
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
@@ -1347,8 +1350,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
-	argc = parse_options(argc, argv, prefix, options, usagestr,
-			     PARSE_OPT_KEEP_DASHDASH);
+	if (!opts->accept_pathspec && !opts->accept_ref)
+		BUG("make up your mind, you need to take _something_");
+	if (opts->accept_pathspec && opts->accept_ref)
+		parseopt_flags = PARSE_OPT_KEEP_DASHDASH;
+
+	argc = parse_options(argc, argv, prefix, options,
+			     usagestr, parseopt_flags);
 
 	if (opts->show_progress < 0) {
 		if (opts->quiet)
@@ -1402,7 +1410,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	 * including "last branch" syntax and DWIM-ery for names of
 	 * remote branches, erroring out for invalid or ambiguous cases.
 	 */
-	if (argc) {
+	if (argc && opts->accept_ref && opts->accept_pathspec) {
 		struct object_id rev;
 		int dwim_ok =
 			!opts->patch_mode &&
@@ -1414,6 +1422,18 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 					     &dwim_remotes_matched);
 		argv += n;
 		argc -= n;
+	} else if (!opts->accept_ref && opts->from_treeish) {
+		struct object_id rev;
+
+		if (get_oid_mb(opts->from_treeish, &rev))
+			die(_("could not resolve %s"), opts->from_treeish);
+
+		setup_new_branch_info_and_source_tree(&new_branch_info,
+						      opts, &rev,
+						      opts->from_treeish);
+
+		if (!opts->source_tree)
+			die(_("reference is not a tree: %s"), opts->from_treeish);
 	}
 
 	if (argc) {
@@ -1492,6 +1512,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_not_ok = 0;
+	opts.accept_ref = 1;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
 
@@ -1520,6 +1541,7 @@ int cmd_switch_branch(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
+	opts.accept_ref = 1;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_not_ok = 1;
 	opts.implicit_detach = 0;
@@ -1537,14 +1559,19 @@ int cmd_switch_branch(int argc, const char **argv, const char *prefix)
 int cmd_restore_files(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	struct option *options = NULL;
+	struct option *options;
+	struct option restore_options[] = {
+		OPT_STRING(0, "from", &opts.from_treeish, "<tree-ish>",
+			   N_("where the checkout from")),
+		OPT_END()
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.dwim_new_local_branch = 1;
+	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
-- 
2.20.0.rc1.380.g3eb999425c.dirty

