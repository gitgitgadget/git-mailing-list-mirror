Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4741F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfDYJqT (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:46:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38654 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfDYJqS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:46:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so10878599pfo.5
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59iuLm52UHt/nzH4KqSUP1XxVskwnmtAyOnbaNlzGJo=;
        b=m1XhNL3wTouVHidTjcCiUKBl7B7LhXmPiua1AxtBR6ENRmRmC0TkfZTmMjxCm9UPV1
         FiYN0VaYTRjhbWQSAn7p0aw8jAhJIa1swBl7SvHwcNETQkU/sYk3YNOQ2Wu/qKIG3vgE
         MKurD8qq9iJ5h9m+FxgnnDbChFU04BOfSisS3zhsbZhWFwn8VyGeOqUPhw7YL2SmE/gr
         JE4/nVR7mucgOnBNSrU0ztg7Xvtx03I7M3Vy3G4jn/hGGjZY5k89wiNuPd+6ocpFMhpl
         cuud+HWUpPgB7p10z69MTlvsizhMWbRrfzj0kMObBxczHFuav52VoJw97uieW8HAJ+kh
         pYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59iuLm52UHt/nzH4KqSUP1XxVskwnmtAyOnbaNlzGJo=;
        b=pmVGgDrq9LS2ZvDbQn2f2hQuDymOvMUDb8KxScqRgo0u0NwlntbVEWMbeO9HetKHcD
         dpANjrGjShFEwfEvGmL6qil/mOiISSQoqEqxzOvvUKe7Pj3mNB4LZZPQZwkAnlgUKuLU
         Yq+Ofc0THhVbwXB1Y2dNDZd6UZ/iSWlJRTwZ6qYUFmE0lQII/CKBGHWXZNkbhvI/N7Sq
         tSVNMoAu2HnvBcA97vp3P4FPR04bmP9AdhPF3kmS9hNLPot0Vxo5kOHenNLv8/2UmKxF
         uiNYWawQD5qYSAX290B24aWG8xiBRv3bqVdingOUHoMuhYesOcd2qtMGbU+O4/1caQJE
         TuAg==
X-Gm-Message-State: APjAAAXXOcvmIxfFupvQkIrK/Cugse7/1X88Y6T43MrOkrS/cFonRUVJ
        eVDk+dwsSmqIOETnq2dSxKw=
X-Google-Smtp-Source: APXvYqyJ+wdBtm3Dicakom/RP5KCHaHPomgNYYzLqEtnxHYS+J3eDPo0c+c4bE3Z5HV03KdNQWD+PA==
X-Received: by 2002:a65:6658:: with SMTP id z24mr6717241pgv.323.1556185577790;
        Thu, 25 Apr 2019 02:46:17 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id j5sm28911311pfe.15.2019.04.25.02.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:46:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:46:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 02/16] restore: take tree-ish from --source option instead
Date:   Thu, 25 Apr 2019 16:45:46 +0700
Message-Id: <20190425094600.15673-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another departure from 'git checkout' syntax, which uses -- to
separate ref and pathspec. The observation is restore (or "git
checkout -- <pathspec>") is most often used to restore some files from
the index. If this is correct, we can simplify it by taking away the
ref, so that we can write

    git restore some-file

without worrying about some-file being a ref and whether we need to do

    git restore -- some-file

for safety. If the source of the restore comes from a tree, it will be
in the form of an option with value, e.g.

    git restore --source=this-tree some-file

This is of course longer to type than using "--". But hopefully it
will not be used as often, and it is clearly easier to understand.

dwim_new_local_branch is no longer set (or unset) in cmd_restore_files()
because it's irrelevant because we don't really care about dwim-ing.
With accept_ref being unset, dwim can't happen.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 98dc2ded38..5aba345712 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -39,7 +39,7 @@ static const char * const switch_branch_usage[] = {
 };
 
 static const char * const restore_usage[] = {
-	N_("git restore [<options>] [<branch>] -- <file>..."),
+	N_("git restore [<options>] [--source=<branch>] <file>..."),
 	NULL,
 };
 
@@ -59,6 +59,7 @@ struct checkout_opts {
 	int overlay_mode;
 	int dwim_new_local_branch;
 	int discard_changes;
+	int accept_ref;
 	int accept_pathspec;
 	int switch_branch_doing_nothing_is_ok;
 	int only_merge_on_switching_branches;
@@ -76,6 +77,7 @@ struct checkout_opts {
 	int branch_exists;
 	const char *prefix;
 	struct pathspec pathspec;
+	const char *from_treeish;
 	struct tree *source_tree;
 };
 
@@ -1410,6 +1412,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 {
 	struct branch_info new_branch_info;
 	int dwim_remotes_matched = 0;
+	int parseopt_flags = 0;
 
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
@@ -1421,8 +1424,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
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
@@ -1481,7 +1489,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	 * including "last branch" syntax and DWIM-ery for names of
 	 * remote branches, erroring out for invalid or ambiguous cases.
 	 */
-	if (argc) {
+	if (argc && opts->accept_ref) {
 		struct object_id rev;
 		int dwim_ok =
 			!opts->patch_mode &&
@@ -1493,6 +1501,18 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
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
@@ -1576,6 +1596,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.only_merge_on_switching_branches = 0;
+	opts.accept_ref = 1;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
 	opts.can_switch_when_in_progress = 1;
@@ -1611,6 +1632,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
+	opts.accept_ref = 1;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
 	opts.only_merge_on_switching_branches = 1;
@@ -1631,15 +1653,19 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 int cmd_restore(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	struct option *options = NULL;
+	struct option *options;
+	struct option restore_options[] = {
+		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
+			   N_("where the checkout from")),
+		OPT_END()
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.dwim_new_local_branch = 1;
-	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
-- 
2.21.0.854.ge34a79f761

