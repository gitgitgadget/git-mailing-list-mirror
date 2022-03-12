Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAB4C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 00:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiCLAKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 19:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiCLAJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 19:09:59 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17CF2272C4
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id p9so15169820wra.12
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DspDRb6NZBmohCcSNRq0bTEHDzymCAfESSKeqqjCETY=;
        b=gKihNj1bhuaagbM7N9hYZkwBZ6rkW2BnLkxGyQAQL1ku6J1prp2KuQlrHNEpiOXBlz
         dT5wML6J3Zn94YfEwJRXMSDsOyqWeXZLgm+6WzOYJjkOvPw5oAglVmefh34XuMKPK/0J
         LKZQwF8DnPorRokrMmSREviohLjm1powKm1vMyu+msqnClklrRkw5Ot3TWCrhpLLFhMH
         J2f5gp46q6XM41oq/PjZSzCRhUwAMRm+Cvrecw4d7SsT0YQpUMjVKyMfFAbcx3870BLe
         w3sHe7z5X0eqKoplBiJZ/HXHQE1DqX6nTj8QYCPZoGvOb4D56JVXMpRRmS43fhjmgFQR
         BuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DspDRb6NZBmohCcSNRq0bTEHDzymCAfESSKeqqjCETY=;
        b=m+5/JRrk8C/Yoz8+p6E9dkHpPbdgHR9OHhE4q5ClUwPbi+xDvs9Xu0t1Ak+fNUqPoS
         vGzvs4u3MqEVjR/7K+yS993yyIZQYyR+gJP+yPy3HwQ0LC/ckv5cpPH9BMSWmn35WpWa
         g8o/GT9L2FyCyZ2o0KUCsqNI1q5xsHpjbm7xaQiyMVu6A/lFNFNPHGjOxQZ3aUmDY/p5
         kic6gKncABtSnbVEQbxr9EqQlTn1WyQfyV54uQPwxblNzGxQo0LjWQNGjCJZyekgMgg4
         Rwhs5NfQamxdHAXG9AlbCsYySjrcehL2I1cUd5JgBkvVrb/JAuatMLjoJeeNLDhNebox
         lk5A==
X-Gm-Message-State: AOAM533GNIn/5GMq92NU0Sq0Ei3XiVsAtf4ChTj8wP4lbee73Eac/831
        PMvznN/F6gNHpIaM+kDpJR7tTlWoNZs=
X-Google-Smtp-Source: ABdhPJyGQP454JgrGbHSGaRNbADR1+YRA6McIKiJxhmwWgqMwGAEMlQ1OrEAnZh9CEy/5HViZFkJng==
X-Received: by 2002:a5d:4b85:0:b0:1f0:9661:9263 with SMTP id b5-20020a5d4b85000000b001f096619263mr8846122wrt.574.1647043732996;
        Fri, 11 Mar 2022 16:08:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc44a000000b003899263bab1sm7971995wmi.20.2022.03.11.16.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:08:52 -0800 (PST)
Message-Id: <bda93703013e3576101079d6aa4b821ae4c73fb7.1647043729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 00:08:46 +0000
Subject: [PATCH 2/5] reset: introduce --[no-]refresh option to --mixed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a new --[no-]refresh option that is intended to explicitly determine
whether a mixed reset should end in an index refresh.

A few years ago, [1] introduced behavior to the '--quiet' option to skip the
call to 'refresh_index(...)' at the end of a mixed reset with the goal of
improving performance. However, by coupling behavior that modifies the index
with the option that silences logs, there is no way for users to have one
without the other (i.e., silenced logs with a refreshed index) without
incurring the overhead of a separate call to 'git update-index --refresh'.
Furthermore, there is minimal user-facing documentation indicating that
--quiet skips the index refresh, potentially leading to unexpected issues
executing commands after 'git reset --quiet' that do not themselves refresh
the index (e.g., internals of 'git stash', 'git read-tree').

To mitigate these issues, '--[no-]refresh' and 'reset.refresh' are
introduced to provide a dedicated mechanism for refreshing the index. When
either is set, '--quiet' and 'reset.quiet' revert to controlling only
whether logs are silenced and do not affect index refresh.

[1] 9ac8125d1a (reset: don't compute unstaged changes after reset when
    --quiet, 2018-10-23)

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-reset.txt |  9 +++++
 builtin/reset.c             | 13 ++++++-
 t/t7102-reset.sh            | 77 +++++++++++++++++++++++++++++++++----
 3 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 6f7685f53d5..89ddc85c2e4 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -110,6 +110,15 @@ OPTIONS
 	`reset.quiet` config option. `--quiet` and `--no-quiet` will
 	override the default behavior.
 
+--refresh::
+--no-refresh::
+	Proactively refresh the index after a mixed reset. If unspecified, the
+	behavior falls back on the `reset.refresh` config option. If neither
+	`--[no-]refresh` nor `reset.refresh` are set, the default behavior is
+	decided by the `--[no-]quiet` option and/or `reset.quiet` config.
+	If `--quiet` is specified or `reset.quiet` is set with no command-line
+	"quiet" setting, refresh is disabled. Otherwise, refresh is enabled.
+
 --pathspec-from-file=<file>::
 	Pathspec is passed in `<file>` instead of commandline args. If
 	`<file>` is exactly `-` then standard input is used. Pathspec
diff --git a/builtin/reset.c b/builtin/reset.c
index a420497a14f..7f667e13d71 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -392,6 +392,7 @@ static int git_reset_config(const char *var, const char *value, void *cb)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int refresh = -1;
 	int patch_mode = 0, pathspec_file_nul = 0, unborn;
 	const char *rev, *pathspec_from_file = NULL;
 	struct object_id oid;
@@ -399,6 +400,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	int intent_to_add = 0;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "refresh", &refresh,
+				N_("skip refreshing the index after reset")),
 		OPT_SET_INT(0, "mixed", &reset_type,
 						N_("reset HEAD and index"), MIXED),
 		OPT_SET_INT(0, "soft", &reset_type, N_("reset only HEAD"), SOFT),
@@ -421,11 +424,19 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	git_config(git_reset_config, NULL);
 	git_config_get_bool("reset.quiet", &quiet);
+	git_config_get_bool("reset.refresh", &refresh);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
+	/*
+	 * If refresh is completely unspecified (either by config or by command
+	 * line option), decide based on 'quiet'.
+	 */
+	if (refresh < 0)
+		refresh = !quiet;
+
 	if (pathspec_from_file) {
 		if (patch_mode)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
@@ -517,7 +528,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
 			the_index.updated_skipworktree = 1;
-			if (!quiet && get_git_work_tree()) {
+			if (refresh && get_git_work_tree()) {
 				uint64_t t_begin, t_delta_in_ms;
 
 				t_begin = getnanotime();
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index d05426062ec..5e68180f3b2 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -462,14 +462,77 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 	git diff-index --cached --exit-code HEAD
 '
 
+test_index_refreshed () {
+
+	# To test whether the index is refresh, create a scenario where a
+	# command will fail if the index is *not* refreshed:
+	#   1. update the worktree to match HEAD & remove file2 in the index
+	#   2. reset --mixed to unstage the change from step 1
+	#   3. read-tree HEAD~1 (which differs from HEAD in file2)
+	# If the index is refreshed in step 2, then file2 in the index will be
+	# up-to-date with HEAD and read-tree will succeed (thus failing the
+	# test). If the index is *not* refreshed, however, the staged deletion
+	# of file2 from step 1 will conflict with the changes from the tree read
+	# in step 3, resulting in a failure.
+
+	# Step 0: start with a clean index
+	git reset --hard HEAD &&
+
+	# Step 1
+	git rm --cached file2 &&
+
+	# Step 2
+	git reset $1 --mixed HEAD &&
+
+	# Step 3
+	git read-tree -m HEAD~1
+}
+
 test_expect_success '--mixed refreshes the index' '
-	cat >expect <<-\EOF &&
-	Unstaged changes after reset:
-	M	file2
-	EOF
-	echo 123 >>file2 &&
-	git reset --mixed HEAD >output &&
-	test_cmp expect output
+	# Verify default behavior (with no config settings or command line
+	# options)
+	test_index_refreshed &&
+'
+test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
+	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
+	# determine refresh behavior
+
+	# Config setting
+	test_must_fail test_index_refreshed -c reset.quiet=true &&
+	test_index_refreshed -c reset.quiet=true &&
+
+	# Command line option
+	test_must_fail test_index_refreshed --quiet &&
+	test_index_refreshed --no-quiet &&
+
+	# Command line option overrides config setting
+	test_must_fail test_index_refreshed -c reset.quiet=false --quiet &&
+	test_index_refreshed -c reset.refresh=true --no-quiet
+'
+
+test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
+	# Verify that --[no-]refresh and `reset.refresh` control index refresh
+
+	# Config setting
+	test_index_refreshed -c reset.refresh=true &&
+	test_must_fail test_index_refreshed -c reset.refresh=false &&
+
+	# Command line option
+	test_index_refreshed --refresh &&
+	test_must_fail test_index_refreshed --no-refresh &&
+
+	# Command line option overrides config setting
+	test_index_refreshed -c reset.refresh=false --refresh &&
+	test_must_fail test_index_refreshed -c reset.refresh=true --no-refresh
+'
+
+test_expect_success '--mixed --refresh overrides --quiet refresh behavior' '
+	# Verify that *both* --refresh and `reset.refresh` override the
+	# default non-refresh behavior of --quiet
+	test_index_refreshed --refresh --quiet &&
+	test_index_refreshed --refresh -c reset.quiet=true &&
+	test_index_refreshed -c reset.refresh=true --quiet &&
+	test_index_refreshed -c reset.refresh=true -c reset.quiet=true
 '
 
 test_expect_success '--mixed preserves skip-worktree' '
-- 
gitgitgadget

