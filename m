Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F015C6FD1F
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 23:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCKXmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 18:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCKXmn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 18:42:43 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3135FEA3
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 15:42:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f11so8207294wrv.8
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 15:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678578155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0OZ5JEOg/cYzU6XTRzzY+FCPI+dkfKo/mn0zJvljC0=;
        b=bc5W9UnerfcU/4IvOYQ64kIt2i6+eIu+Nwb4eC3yz76wqhstJg9STBerv2hwHziN8I
         G7LyFb6AnImhEHmyQQthXwTnmfeEXKoWKxN9YBuRNdi6oN+xA1ermcyyw29cQ2IFA20q
         OwBO+EvzfDVxOF1qtLK7vMZh0sHgEekDVTJezP1VlnURfFp+EwhF0NMijPrcqIw/z1az
         pCUUla48ZgowrFFqdh2oGtX+cOVidAOJg2YtjPf2M8HNHeJGHdWhraIwf1l9KvG8wcbu
         PCTV2l0WTbOaH8A2D7dKQrh+svvu7o21bFp7+JcBN/E/dA6MKws0noEoafJvbA7S85Zl
         itvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678578155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0OZ5JEOg/cYzU6XTRzzY+FCPI+dkfKo/mn0zJvljC0=;
        b=46AFqdb/JZgwRUj5OZVuM3nNYfxAg1YqboFhueOLGlRhnLwKsut16bfIzFil0YyAIH
         GssSRHhoPIp8KbnxnN8Tq4mqiUR82TSzWxk0gGE0f+7KnrwZyh9vGk5iIvbTbNbElB/S
         XVITh9rXGNHDvnQUV6ge2h62xLslAybUdyST96M5sIbPr8aS7uYoGuHk15+pLiPG+84h
         HAAd6QylBzx6CUNuuJtgNoNC1IOxQjaZwXhyo3aSGyzPFv+F2TwAwHaVmbRL0Mu4zuf7
         BgRrC9DzzgcDRar0wry9dswo6jhLMoMd7rSXNG8fbsrbB1KsAVInCoeYhTUMcLi5TB00
         buiw==
X-Gm-Message-State: AO0yUKUgOHuHdMQgsDRMZD4rCjrnSfTIscd0CQ3ufMGRN1qLDt2zLoG6
        STXDg3ipBwtwQGmwVtoAKMPCPdLDkhQ=
X-Google-Smtp-Source: AK7set+Va8tEfZhsv45IKsOTZMENeHVAK0IJzYnizMxKaWQyrz8yHUMOwRiyhkcuOjpWW4aoCKyDMg==
X-Received: by 2002:a5d:5582:0:b0:2ce:a162:784c with SMTP id i2-20020a5d5582000000b002cea162784cmr1984294wrv.65.1678578154697;
        Sat, 11 Mar 2023 15:42:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020a056000104a00b002c70e60eb40sm3595541wrx.11.2023.03.11.15.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 15:42:34 -0800 (PST)
Message-Id: <pull.1467.git.git.1678578153640.gitgitgadget@gmail.com>
From:   "Hugo Sales via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Mar 2023 23:42:33 +0000
Subject: [PATCH] Add `restore.defaultLocation` option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hugo Sales <hugo@hsal.es>, Hugo Sales <hugo@hsal.es>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hugo Sales <hugo@hsal.es>

This options allows control over which of `--worktree` or `--staged` is
applied when `git restore` is invoked with neither

This patch is intended to reduce lost work to accidental `git restore .`
when `git restore --staged .` was intended.

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
    Add restore.defaultLocation option
    
    This options allows control over which of --worktree or --staged is
    applied when git restore is invoked with neither
    
    This patch is intended to reduce lost work to accidental git restore .
    when git restore --staged . was intended.
    
    CC: Ævar Arnfjörð Bjarmason avarab@gmail.com, Jeff King peff@peff.net,
    Victoria Dye vdye@github.com
    
    ------------------------------------------------------------------------
    
    I tried to send with git send-email, but I'm having problems. My mail
    provider is mailbox.org and I'm getting Command unknown: 'AUTH' at
    /usr/lib/git-core/git-send-email line 1691. Apologies if it actually
    went through.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1467%2Fsomeonewithpc%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1467/someonewithpc/master-v1
Pull-Request: https://github.com/git/git/pull/1467

 Documentation/config.txt         |   2 +
 Documentation/config/restore.txt |  13 ++++
 Documentation/git-restore.txt    |  17 +++--
 builtin/checkout.c               |  27 +++++++
 t/t2070-restore.sh               | 124 +++++++++++++++++++++++++++++++
 5 files changed, 178 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/config/restore.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e93aef8626..4359c63794e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -501,6 +501,8 @@ include::config/repack.txt[]
 
 include::config/rerere.txt[]
 
+include::config/restore.txt[]
+
 include::config/revert.txt[]
 
 include::config/safe.txt[]
diff --git a/Documentation/config/restore.txt b/Documentation/config/restore.txt
new file mode 100644
index 00000000000..479fd13ca24
--- /dev/null
+++ b/Documentation/config/restore.txt
@@ -0,0 +1,13 @@
+restore.defaultLocation::
+	Valid values: "worktree", "staged" or "both". Controls the default
+	behavior of `git restore` without `--worktree` or `--staged`. If
+	"worktree", `git restore` without `--worktree` or `--staged` is
+	equivalent to `git restore --worktree`. If "staged", `git restore`
+	without `--worktree` or `--staged` is equivalent to `git restore
+	--staged`. If "both", `git restore` without `--worktree` or `--staged`
+	is equivalent to `git restore --worktree --staged`. Adding an option
+	overrides the default, such that if the option is set to "staged",
+	specifying `--worktree` will only affect the worktree, not both. This
+	option can be used to prevent accidentally losing work by running `git
+	restore .` when `git restore --staged .` was intended.
+	See linkgit:git-restore[1]
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 5964810caa4..28165861f55 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -14,14 +14,18 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Restore specified paths in the working tree with some contents from a
+Restore specified paths in the working tree or index with some contents from a
 restore source. If a path is tracked but does not exist in the restore
 source, it will be removed to match the source.
 
-The command can also be used to restore the content in the index with
+The command can be used to restore the content in the index with
 `--staged`, or restore both the working tree and the index with
 `--staged --worktree`.
 
+The config options `restore.defaultLocation`, which accepts values "worktree",
+"staged" or "both", can be used to control the default behavior for which
+flag(s) apply if neither `--staged` nor `--worktree` is supplied.
+
 By default, if `--staged` is given, the contents are restored from `HEAD`,
 otherwise from the index. Use `--source` to restore from a different commit.
 
@@ -59,9 +63,12 @@ all modified paths.
 --worktree::
 -S::
 --staged::
-	Specify the restore location. If neither option is specified,
-	by default the working tree is restored. Specifying `--staged`
-	will only restore the index. Specifying both restores both.
+	Specify the restore location. If neither option is specified, the
+	default depends on the `'restore.defaultLocation` config option, which
+	can be "worktree" (the default), "staged" or "both", to control which of
+	the two flags is assumed if none are given. Specifying `--worktree` will
+	only restore the worktree. Specifying `--staged` will only restore the
+	index. Specifying both restores both.
 
 -q::
 --quiet::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a5155cf55c1..5067753030b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1922,6 +1922,30 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static const char *checkout_default_index_worktree;
+static int git_restore_config(const char *var, const char *value, void *cb)
+{
+	struct checkout_opts *opts = cb;
+
+	if (!strcmp(var, "restore.defaultlocation")) {
+		git_config_string(&checkout_default_index_worktree, var, value);
+
+		if (!strcmp(checkout_default_index_worktree, "both")) {
+			opts->checkout_index = -2;    /* default on */
+			opts->checkout_worktree = -2; /* default on */
+		} else if (!strcmp(checkout_default_index_worktree, "staged")) {
+			opts->checkout_index = -2;    /* default on */
+			opts->checkout_worktree = -1; /* default off */
+		} else {
+			opts->checkout_index = -1;    /* default off */
+			opts->checkout_worktree = -2; /* default on */
+		}
+		return 0;
+	}
+	return git_xmerge_config(var, value, NULL);
+}
+
+
 int cmd_restore(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
@@ -1942,6 +1966,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
+
 	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
 	opts.empty_pathspec_ok = 0;
@@ -1950,6 +1975,8 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	opts.checkout_worktree = -2; /* default on */
 	opts.ignore_unmerged_opt = "--ignore-unmerged";
 
+	git_config(git_restore_config, &opts);
+
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 7c43ddf1d99..6e9b06e0bf4 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -137,4 +137,128 @@ test_expect_success 'restore --staged invalidates cache tree for deletions' '
 	test_must_fail git rev-parse HEAD:new1
 '
 
+test_expect_success 'restore with restore.defaultLocation unset works as if --worktree given' '
+	test_when_finished git reset --hard HEAD^ &&
+	test_commit root-unset-restore.defaultLocation &&
+	test_commit unset-restore.defaultLocation one one &&
+	> one &&
+
+	git restore one &&
+	test -z $(git status --porcelain --untracked-files=no) &&
+
+	> one &&
+	git add one &&
+	git restore one &&
+	git status --porcelain --untracked-files=no | grep "^M " &&
+
+	> one &&
+	git add one &&
+	git restore --worktree one &&
+	git status --porcelain --untracked-files=no | grep "^M " &&
+
+	git restore --staged one &&
+	git status --porcelain --untracked-files=no | grep "^ M" &&
+
+	> one &&
+	git add one &&
+	git restore --worktree --staged one &&
+	test -z $(git status --porcelain --untracked-files=no)
+'
+
+test_expect_success 'restore with restore.defaultLocation set to worktree works as if --worktree given' '
+	test_when_finished git reset --hard HEAD^ &&
+	test_when_finished git config --unset restore.defaultLocation &&
+	test_commit root-worktree-restore.defaultLocation &&
+	test_commit worktree-restore.defaultLocation one one &&
+	git config restore.defaultLocation worktree &&
+	> one &&
+
+	git restore one &&
+	test -z $(git status --porcelain --untracked-files=no) &&
+
+	> one &&
+	git add one &&
+	git restore one &&
+	git status --porcelain --untracked-files=no | grep "^M " &&
+
+	> one &&
+	git add one &&
+	git restore --worktree one &&
+	git status --porcelain --untracked-files=no | grep "^M " &&
+
+	git restore --staged one &&
+	git status --porcelain --untracked-files=no | grep "^ M" &&
+
+	> one &&
+	git add one &&
+	git restore --worktree --staged one &&
+	test -z $(git status --porcelain --untracked-files=no)
+'
+
+test_expect_success 'restore with restore.defaultLocation set to staged works as if --staged given' '
+	test_when_finished git reset --hard HEAD^ &&
+	test_when_finished git config --unset restore.defaultLocation &&
+	test_commit root-staged-restore.defaultLocation &&
+	test_commit staged-restore.defaultLocation one one &&
+	git config restore.defaultLocation staged &&
+	> one &&
+
+	git restore one &&
+	git status --porcelain --untracked-files=no | grep "^ M" &&
+
+	git restore --staged one &&
+	git status --porcelain --untracked-files=no | grep "^ M" &&
+
+	git add one &&
+	git restore one &&
+	git status --porcelain --untracked-files=no | grep "^ M" &&
+
+	git add one &&
+	git restore --staged one &&
+	git status --porcelain --untracked-files=no | grep "^ M" &&
+
+	git restore --worktree one &&
+	test -z $(git status --porcelain --untracked-files=no) &&
+
+	> one &&
+	git add one &&
+	git restore --worktree --staged one &&
+	test -z $(git status --porcelain --untracked-files=no)
+'
+
+test_expect_success 'restore with restore.defaultLocation set to both works as if --worktree --staged given' '
+	test_when_finished git reset --hard HEAD^ &&
+	test_when_finished git config --unset restore.defaultLocation &&
+	test_commit root-both-restore.defaultLocation &&
+	test_commit both-restore.defaultLocation one one &&
+	git config restore.defaultLocation both &&
+	> one &&
+
+	git restore one &&
+	test -z $(git status --porcelain --untracked-files=no) &&
+
+	> one &&
+	git add one &&
+	git restore --staged one &&
+	git status --porcelain --untracked-files=no | grep "^ M"  &&
+
+	git add one &&
+	git restore one &&
+	test -z $(git status --porcelain --untracked-files=no) &&
+
+	> one &&
+	git add one &&
+	git restore --staged one &&
+	git status --porcelain --untracked-files=no | grep "^ M" &&
+
+	git restore --worktree one &&
+	test -z $(git status --porcelain --untracked-files=no) &&
+
+	> one &&
+	git add one &&
+	git restore --worktree --staged one &&
+	test -z $(git status --porcelain --untracked-files=no)
+'
+
+
 test_done

base-commit: 725f57037d81e24eacfda6e59a19c60c0b4c8062
-- 
gitgitgadget
