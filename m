Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BBCECAAD2
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 09:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343992AbiHZJjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbiHZJjl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 05:39:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D85D1E0B
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 02:39:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so533683wms.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=ZmVdsax1U7DugzWwlXsVvugjEwC680jK/Qnbw4xSEr4=;
        b=ZahBUP+qBVdFl28CVWdthAF4TTE1/it3jx3ZND3434rF6Hv+H+WVh2IY/+LdZptesw
         09lBxO/VboeLDEvj8TXtYeCc1LH7yITYW/EwGogxx6G9Po//lBL/VOyF18Bz8FLI15/C
         jQSO+oz7j3XhNuoJKKiaAHwVIEf7nLxFZuV9QYydaKj6h85c8O5nCdsoZR/lx/V/Q07N
         XSvWCBCqhRTwZPGlcjnlJVl4NqKRaELyRWWuR7vxnpR43gnYQJJlZzV6BTi3agY/Y1Ql
         x1ft9fyo/DixmUTX7+89gySdlgHfxta/yo9d5YxTx1W7M4L2uaMEN7O050P1O1wgY01+
         AeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=ZmVdsax1U7DugzWwlXsVvugjEwC680jK/Qnbw4xSEr4=;
        b=wA5EH0m1Z6XwrflRTPhrcrWV2d9Y/0spPtXSQlNUyq0FM9ySKpugXob/ZclegUgvHY
         Qm9a3Kz3HkT1kBsn6MtTiU1V+ZbqRvKoFKQiPMtWwTXCTG9uv1TUn9kHsrvMf2J7y5JE
         UmsBWYq+VEeGE4YS3kOlh+WpbV5Nw34SywByml6dQfTCyOuhbDlGv7deivu6Kn3oi55Y
         a2qC+UUOU4bImzFU58+LJEMZXzmaWUROsVpp76AXJe56kjdyKkAAMo2RvRp5jJhm5gEf
         5IE3DeFFj+kQoYtMDZkKm3cl1B3APuq0ZfyvAK18+nv+c+F30x5YDhbzNk8hOEUfGGYB
         uMMw==
X-Gm-Message-State: ACgBeo1E4Aw4016mZG0ZTd48nlkOth1+M/KH0OYxMKR+DUmgvRzXN4AQ
        YvVaFnr93RwU+aokaJnStTC4Ur6B2R8=
X-Google-Smtp-Source: AA6agR7iQ+BrGEVuQJ29b69MHMIInct365mLwUVLJA5j44N63mI79pc++L+LKUwsQfb12rRywWZWQA==
X-Received: by 2002:a05:600c:4a09:b0:3a6:9a22:3979 with SMTP id c9-20020a05600c4a0900b003a69a223979mr4230672wmp.57.1661506776474;
        Fri, 26 Aug 2022 02:39:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a673055e68sm8973807wma.0.2022.08.26.02.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:39:35 -0700 (PDT)
Message-Id: <a52ad40e0155caf8285b86ec26bbd47cd2240466.1661506770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1335.v2.git.1661506770.gitgitgadget@gmail.com>
References: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
        <pull.1335.v2.git.1661506770.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Aug 2022 09:39:30 +0000
Subject: [PATCH v2 3/3] range-diff: optionally accept pathspecs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `git range-diff` command can be quite expensive, which is not a
surprise given that the underlying algorithm to match up pairs of
commits between the provided two commit ranges has a cubic runtime.

Therefore it makes sense to restrict the commit ranges as much as
possible, to reduce the amount of input to that O(N^3) algorithm.

In chatty repositories with wide trees, this is not necessarily
possible merely by choosing commit ranges wisely.

Let's give users another option to restrict the commit ranges: by
providing a pathspec. That helps in repositories with wide trees because
it is likely that the user has a good idea which subset of the tree they
are actually interested in.

Example:

	git range-diff upstream/main upstream/seen HEAD -- range-diff.c

This shows commits that are either in the local branch or in `seen`, but
not in `main`, skipping all commits that do not touch `range-diff.c`.

Note: Since we piggy-back the pathspecs onto the `other_arg` mechanism
that was introduced to be able to pass through the `--notes` option to
the revision machinery, we must now ensure that the `other_arg` array is
appended at the end (the revision range must come before the pathspecs,
if any).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt |  4 ++
 builtin/range-diff.c             | 66 ++++++++++++++++++++++++--------
 range-diff.c                     |  2 +-
 t/t3206-range-diff.sh            | 13 ++++++-
 4 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index fe350d7f405..0b393715d70 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 	[--no-dual-color] [--creation-factor=<factor>]
 	[--left-only | --right-only]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
+	[[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -19,6 +20,9 @@ DESCRIPTION
 This command shows the differences between two versions of a patch
 series, or more generally, two commit ranges (ignoring merge commits).
 
+In the presence of `<path>` arguments, these commit ranges are limited
+accordingly.
+
 To that end, it first finds pairs of commits from both commit ranges
 that correspond with each other. Two commits are said to correspond when
 the diff between their patches (i.e. the author information, the commit
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 71319ed1d84..e2a74efb42a 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -38,9 +38,10 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	struct option *options;
-	int res = 0;
+	int i, dash_dash = -1, res = 0;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 	struct object_id oid;
+	const char *three_dots = NULL;
 
 	git_config(git_diff_ui_config, NULL);
 
@@ -48,7 +49,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	options = parse_options_concat(range_diff_options, diffopt.parseopts);
 	argc = parse_options(argc, argv, prefix, options,
-			     builtin_range_diff_usage, 0);
+			     builtin_range_diff_usage, PARSE_OPT_KEEP_DASHDASH);
 
 	diff_setup_done(&diffopt);
 
@@ -56,8 +57,20 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	if (!simple_color)
 		diffopt.use_color = 1;
 
-	if (argc == 3) {
-		if (get_oid_committish(argv[0], &oid))
+	for (i = 0; i < argc; i++)
+		if (!strcmp(argv[i], "--")) {
+			dash_dash = i;
+			break;
+		}
+
+	if (dash_dash == 3 ||
+	    (dash_dash < 0 && argc > 2 &&
+	     !get_oid_committish(argv[0], &oid) &&
+	     !get_oid_committish(argv[1], &oid) &&
+	     !get_oid_committish(argv[2], &oid))) {
+		if (dash_dash < 0)
+			; /* already validated arguments */
+		else if (get_oid_committish(argv[0], &oid))
 			usage_msg_optf(_("not a revision: '%s'"),
 				       builtin_range_diff_usage, options,
 				       argv[0]);
@@ -72,8 +85,16 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
 		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
-	} else if (argc == 2) {
-		if (!is_range_diff_range(argv[0]))
+
+		strvec_pushv(&other_arg, argv +
+			     (dash_dash < 0 ? 3 : dash_dash));
+	} else if (dash_dash == 2 ||
+		   (dash_dash < 0 && argc > 1 &&
+		    is_range_diff_range(argv[0]) &&
+		    is_range_diff_range(argv[1]))) {
+		if (dash_dash < 0)
+			; /* already validated arguments */
+		else if (!is_range_diff_range(argv[0]))
 			usage_msg_optf(_("not a commit range: '%s'"),
 				       builtin_range_diff_usage, options,
 				       argv[0]);
@@ -84,25 +105,40 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 		strbuf_addstr(&range1, argv[0]);
 		strbuf_addstr(&range2, argv[1]);
-	} else if (argc == 1) {
-		const char *b = strstr(argv[0], "..."), *a = argv[0];
+
+		strvec_pushv(&other_arg, argv +
+			     (dash_dash < 0 ? 2 : dash_dash));
+	} else if (dash_dash == 1 ||
+		   (dash_dash < 0 && argc > 0 &&
+		    (three_dots = strstr(argv[0], "...")))) {
+		const char *a, *b;
 		int a_len;
 
-		if (!b)
+		if (dash_dash < 0)
+			; /* already validated arguments */
+		else if (!(three_dots = strstr(argv[0], "...")))
 			usage_msg_optf(_("not a symmetric range: '%s'"),
-				       builtin_range_diff_usage, options,
-				       argv[0]);
+					 builtin_range_diff_usage, options,
+					 argv[0]);
 
-		a_len = (int)(b - a);
-		if (!a_len) {
+		if (three_dots == argv[0]) {
 			a = "HEAD";
 			a_len = strlen(a);
+		} else {
+			a = argv[0];
+			a_len = (int)(three_dots - a);
 		}
-		b += 3;
-		if (!*b)
+
+		if (three_dots[3])
+			b = three_dots + 3;
+		else
 			b = "HEAD";
+
 		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
 		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
+
+		strvec_pushv(&other_arg, argv +
+			     (dash_dash < 0 ? 1 : dash_dash));
 	} else
 		usage_msg_opt(_("need two commit ranges"),
 			      builtin_range_diff_usage, options);
diff --git a/range-diff.c b/range-diff.c
index f63b3ffc200..124dd678c38 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -57,9 +57,9 @@ static int read_patches(const char *range, struct string_list *list,
 		     "--pretty=medium",
 		     "--notes",
 		     NULL);
+	strvec_push(&cp.args, range);
 	if (other_arg)
 		strvec_pushv(&cp.args, other_arg->v);
-	strvec_push(&cp.args, range);
 	cp.out = -1;
 	cp.no_stdin = 1;
 	cp.git_cmd = 1;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index d12e4e4cc6c..459beaf7d9c 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -162,7 +162,7 @@ test_expect_success 'A^! and A^-<n> (unmodified)' '
 '
 
 test_expect_success 'A^{/..} is not mistaken for a range' '
-	test_must_fail git range-diff topic^.. topic^{/..} 2>error &&
+	test_must_fail git range-diff topic^.. topic^{/..} -- 2>error &&
 	test_i18ngrep "not a commit range" error
 '
 
@@ -772,6 +772,17 @@ test_expect_success '--left-only/--right-only' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ranges with pathspecs' '
+	git range-diff topic...mode-only-change -- other-file >actual &&
+	test_line_count = 2 actual &&
+	topic_oid=$(git rev-parse --short topic) &&
+	mode_change_oid=$(git rev-parse --short mode-only-change^) &&
+	file_change_oid=$(git rev-parse --short mode-only-change) &&
+	grep "$mode_change_oid" actual &&
+	! grep "$file_change_oid" actual &&
+	! grep "$topic_oid" actual
+'
+
 test_expect_success 'submodule changes are shown irrespective of diff.submodule' '
 	git init sub-repo &&
 	test_commit -C sub-repo sub-first &&
-- 
gitgitgadget
