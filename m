Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4671CB533
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289985; cv=none; b=FPzNsx6HcI2i7lhuZNRqjuly7Vb5FTRLFgG+1FikEXk26QWDQ9Qr4wKwlUL31t6PlbpYKQpYb+X034F8sOCqlxpt8r9oqFXsrxHwOobrvcl8fA4YCX0HVIkUbUmiKtIfw/ciDDzZ9Osijd3JeJdGfhlDNAWtAC+Su55k3Aw4mFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289985; c=relaxed/simple;
	bh=BxDCrNFOhADVLSIXpJTStX2dfF21lwE4pAciQAG8cJ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ruo12sxXC+YWRAz4+O8iaQdIaursCeasYtwHbVj+JJ40JnhOp5AAu4Mc68M/Uhtya3yYInDWQpwZxZ4QzTU/6wai5itjCz4Wq6RlZtJ2tWnumx2rt6R+QVdHNH+MkXyKSOuL2TtZCQm2MEQqjZFGUtVIh6OFpQhVE3TcDxJrrk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL1JnwM5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL1JnwM5"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a866d3ae692so251935666b.0
        for <git@vger.kernel.org>; Mon, 02 Sep 2024 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725289981; x=1725894781; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yscUuo+dHIOieRmsRGEYjgqr4XN7WbAK+tak2KRgiSI=;
        b=VL1JnwM5WNl3IQAiGh/n9q854QnIEYahjJ+ys5AXTtByqQtbET5JlB9alfsI2Xo6cJ
         6H0DrivhpanrMG0lluXyyLw8wjkULHzt40jb3oNtbU7HZTXU+xq0EtGDf6ryVa4hTfWo
         t9uQ/imc+6+PmuinPNNZR4UrNgoDiB0i2BfUHEw4cyXhbxf+wr0dQxrFJsIt8smPLITe
         2ufiu2OZ0+D4Ong7wgL4vHu+GFzPZDxilVfQjIp0481Ukb/txhXNlzIN7ud9OFsODJ77
         yDqF2lv0fGEp+LAVMdgSPbsumeMDW5lZ2G2jXI1dl58faeQM1v+PsGmkQAdFpoL8Zdl5
         73UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725289981; x=1725894781;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yscUuo+dHIOieRmsRGEYjgqr4XN7WbAK+tak2KRgiSI=;
        b=X3JN01tmNp1vBRud+7iv0RQ13O0AbptddSNWf9NlpOuWFoI3Ft4r2uw6yUpB4OmGKX
         qBGE69YXP9NSkwyhI7RByyQvm+vlwmpdlY7KOwN0j9Ht65tM4mTijcCMPLBoJ7T+8Kj7
         X9ywhAP5pihf+tUkHsUTxsDrggmKC4hPiYn4A5/FWfqVfF6R9BMuMJ0cSFuW/SpMRrcq
         Y3O5n8s2k7UUa35WWj6mDz2ZSEI0NmZ1SyLyeTQCpsM1MiZzLC3yJ54XfUOHAndoOnED
         oJJ6XGab7slRQEDZxHrs/kljN3bko8axabYfQsZdMdATLkI9l76HC0g7FNZz3W3tOxrD
         NUhQ==
X-Gm-Message-State: AOJu0Yy3SgsshqNM/ZATfGryTjFr7V7aI6vO0O+ZBC9IVKyHnURPu7dN
	Hq0APr+4B7o6T6tfXmwQZr5YyADfSFSJ+/vzAzfNT/hVng6C8yEn4gmBRA==
X-Google-Smtp-Source: AGHT+IFvrR4rGQMKqHHAbZsJTaEh7xEx5PanCJU7fsIxHgnuxGTKnxDOieYVo0acgwMOvSmxfvHu0g==
X-Received: by 2002:a05:6402:1e8b:b0:5be:e6a6:4cc3 with SMTP id 4fb4d7f45d1cf-5c21ed3e9e4mr15801531a12.14.1725289980770;
        Mon, 02 Sep 2024 08:13:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226cd4bcbsm5388800a12.74.2024.09.02.08.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:13:00 -0700 (PDT)
Message-Id: <pull.1772.v2.git.1725289979450.gitgitgadget@gmail.com>
In-Reply-To: <pull.1772.git.1723641747309.gitgitgadget@gmail.com>
References: <pull.1772.git.1723641747309.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Sep 2024 15:12:59 +0000
Subject: [PATCH v2] rebase: apply and cleanup autostash when rebase fails to
 start
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If "git rebase" fails to start after stashing the user's uncommitted
changes then it forgets to restore the stashed changes and remove the
state directory. To make matters worse, running "git rebase --abort" to
apply the stashed changes and cleanup the state directory fails because
the state directory only contains the "autostash" file and is missing
the "head-name" and "onto" files required by read_basic_state().

Fix this by applying the autostash and removing the state directory if
the pre-rebase hook or initial checkout fail. This matches what
finish_rebase() does at the end of a successful rebase. If the user
modifies any files after the autostash is created it is possible there
will be conflicts when the autostash is applied. In that case
apply_autostash() saves the stash in a new entry under refs/stash and so
it is safe to remove the state directory containing the autostash file.

New tests are added to check the autostash is applied and the state
directory is removed if the rebase fails to start. Checks are also added
to some existing tests in order to ensure there is no state directory
left behind when a rebase fails to start and no autostash has been
created.

Reported-by: Brian Lyles <brianmlyles@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase: apply and cleanup autostash when rebase fails to start
    
    Thanks to Junio and Patrick for their comments on V1. I've updated the
    commit message to correct the typos found by Patrick and added an
    explanation of why it is safe to remove the state directory.
    
    In his review Patrick suggested removing the backwards jump after
    applying the autostash and cleaning up the state directory in favor of a
    variable that tracks if we need to apply the autostash. I've decided not
    to do that as I think having to set a variable before jumping to a
    cleanup label is more complicated and error prone. There are similar
    backward jumps in builtin/stash.c:show_stash() and
    config.c:git_config_set_multivar_in_file_gently()
    
    Thanks to Brian for reporting this. This patch is based on maint, when
    merging with master there is an easily resolved conflict with a change
    from 'ps/config-wo-the-repository' which modifies an adjacent line.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1772%2Fphillipwood%2Frebase-fix-autostash-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1772/phillipwood/rebase-fix-autostash-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1772

Range-diff vs v1:

 1:  f5b46082047 ! 1:  c76c05092aa rebase: apply and cleanup autostash when rebase fails to start
     @@ Commit message
          rebase: apply and cleanup autostash when rebase fails to start
      
          If "git rebase" fails to start after stashing the user's uncommitted
     -    changes then it forgets to restore the stashed changes and remove state
     -    directory. To make matters worse running "git rebase --abort" to apply
     -    the stashed changes and cleanup the state directory fails because the
     -    state directory only contains the "autostash" file and is missing the
     -    "head-name" and "onto" required by read_basic_state().
     +    changes then it forgets to restore the stashed changes and remove the
     +    state directory. To make matters worse, running "git rebase --abort" to
     +    apply the stashed changes and cleanup the state directory fails because
     +    the state directory only contains the "autostash" file and is missing
     +    the "head-name" and "onto" files required by read_basic_state().
      
          Fix this by applying the autostash and removing the state directory if
     -    the pre-rebase hook or initial checkout fail. New tests are added to
     -    check the autostash is applied and the state directory is removed if the
     -    rebase fails to start. Checks are also added to some existing tests in
     -    order to ensure there is no state directory left behind when a rebase
     -    fails to start and no autostash has been created.
     +    the pre-rebase hook or initial checkout fail. This matches what
     +    finish_rebase() does at the end of a successful rebase. If the user
     +    modifies any files after the autostash is created it is possible there
     +    will be conflicts when the autostash is applied. In that case
     +    apply_autostash() saves the stash in a new entry under refs/stash and so
     +    it is safe to remove the state directory containing the autostash file.
     +
     +    New tests are added to check the autostash is applied and the state
     +    directory is removed if the rebase fails to start. Checks are also added
     +    to some existing tests in order to ensure there is no state directory
     +    left behind when a rebase fails to start and no autostash has been
     +    created.
      
          Reported-by: Brian Lyles <brianmlyles@gmail.com>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>


 builtin/rebase.c            | 39 +++++++++++++++++++++++++++++-------
 t/t3400-rebase.sh           |  8 ++++++--
 t/t3413-rebase-hook.sh      |  4 +++-
 t/t3420-rebase-autostash.sh | 40 +++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e3a8e74cfc2..ac23c4ddbb0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -526,6 +526,23 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 	return 0;
 }
 
+static int cleanup_autostash(struct rebase_options *opts)
+{
+	int ret;
+	struct strbuf dir = STRBUF_INIT;
+	const char *path = state_dir_path("autostash", opts);
+
+	if (!file_exists(path))
+		return 0;
+	ret = apply_autostash(path);
+	strbuf_addstr(&dir, opts->state_dir);
+	if (remove_dir_recursively(&dir, 0))
+		ret = error_errno(_("could not remove '%s'"), opts->state_dir);
+	strbuf_release(&dir);
+
+	return ret;
+}
+
 static int finish_rebase(struct rebase_options *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
@@ -1726,7 +1743,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (require_clean_work_tree(the_repository, "rebase",
 				    _("Please commit or stash them."), 1, 1)) {
 		ret = -1;
-		goto cleanup;
+		goto cleanup_autostash;
 	}
 
 	/*
@@ -1749,7 +1766,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (options.switch_to) {
 				ret = checkout_up_to_date(&options);
 				if (ret)
-					goto cleanup;
+					goto cleanup_autostash;
 			}
 
 			if (!(options.flags & REBASE_NO_QUIET))
@@ -1775,8 +1792,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	/* If a hook exists, give it a chance to interrupt*/
 	if (!ok_to_skip_pre_rebase &&
 	    run_hooks_l("pre-rebase", options.upstream_arg,
-			argc ? argv[0] : NULL, NULL))
-		die(_("The pre-rebase hook refused to rebase."));
+			argc ? argv[0] : NULL, NULL)) {
+		ret = error(_("The pre-rebase hook refused to rebase."));
+		goto cleanup_autostash;
+	}
 
 	if (options.flags & REBASE_DIFFSTAT) {
 		struct diff_options opts;
@@ -1821,9 +1840,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
 	ropts.default_reflog_action = options.reflog_action;
-	if (reset_head(the_repository, &ropts))
-		die(_("Could not detach HEAD"));
-	strbuf_release(&msg);
+	if (reset_head(the_repository, &ropts)) {
+		ret = error(_("Could not detach HEAD"));
+		goto cleanup_autostash;
+	}
 
 	/*
 	 * If the onto is a proper descendant of the tip of the branch, then
@@ -1851,9 +1871,14 @@ run_rebase:
 
 cleanup:
 	strbuf_release(&buf);
+	strbuf_release(&msg);
 	strbuf_release(&revisions);
 	rebase_options_release(&options);
 	free(squash_onto_name);
 	free(keep_base_onto_name);
 	return !!ret;
+
+cleanup_autostash:
+	ret |= !!cleanup_autostash(&options);
+	goto cleanup;
 }
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ae34bfad607..972ea85febc 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -145,7 +145,9 @@ test_expect_success 'Show verbose error when HEAD could not be detached' '
 	test_when_finished "rm -f B" &&
 	test_must_fail git rebase topic 2>output.err >output.out &&
 	test_grep "The following untracked working tree files would be overwritten by checkout:" output.err &&
-	test_grep B output.err
+	test_grep B output.err &&
+	test_must_fail git rebase --quit 2>err &&
+	test_grep "no rebase in progress" err
 '
 
 test_expect_success 'fail when upstream arg is missing and not on branch' '
@@ -422,7 +424,9 @@ test_expect_success 'refuse to switch to branch checked out elsewhere' '
 	git checkout main &&
 	git worktree add wt &&
 	test_must_fail git -C wt rebase main main 2>err &&
-	test_grep "already used by worktree at" err
+	test_grep "already used by worktree at" err &&
+	test_must_fail git -C wt rebase --quit 2>err &&
+	test_grep "no rebase in progress" err
 '
 
 test_expect_success 'rebase when inside worktree subdirectory' '
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index e8456831e8b..426ff098e1d 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -110,7 +110,9 @@ test_expect_success 'pre-rebase hook stops rebase (1)' '
 	git reset --hard side &&
 	test_must_fail git rebase main &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
-	test 0 = $(git rev-list HEAD...side | wc -l)
+	test 0 = $(git rev-list HEAD...side | wc -l) &&
+	test_must_fail git rebase --quit 2>err &&
+	test_grep "no rebase in progress" err
 '
 
 test_expect_success 'pre-rebase hook stops rebase (2)' '
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 63e400b89f2..b43046b3b0d 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -82,6 +82,46 @@ testrebase () {
 	type=$1
 	dotest=$2
 
+	test_expect_success "rebase$type: restore autostash when pre-rebase hook fails" '
+		git checkout -f feature-branch &&
+		test_hook pre-rebase <<-\EOF &&
+		exit 1
+		EOF
+
+		echo changed >file0 &&
+		test_must_fail git rebase $type --autostash -f HEAD^ &&
+		test_must_fail git rebase --quit 2>err &&
+		test_grep "no rebase in progress" err &&
+		echo changed >expect &&
+		test_cmp expect file0
+	'
+
+	test_expect_success "rebase$type: restore autostash when checkout onto fails" '
+		git checkout -f --detach feature-branch &&
+		echo uncommitted-content >file0 &&
+		echo untracked >file4 &&
+		test_when_finished "rm file4" &&
+		test_must_fail git rebase $type --autostash \
+							unrelated-onto-branch &&
+		test_must_fail git rebase --quit 2>err &&
+		test_grep "no rebase in progress" err &&
+		echo uncommitted-content >expect &&
+		test_cmp expect file0
+	'
+
+	test_expect_success "rebase$type: restore autostash when branch checkout fails" '
+		git checkout -f unrelated-onto-branch^ &&
+		echo uncommitted-content >file0 &&
+		echo untracked >file4 &&
+		test_when_finished "rm file4" &&
+		test_must_fail git rebase $type --autostash HEAD \
+							unrelated-onto-branch &&
+		test_must_fail git rebase --quit 2>err &&
+		test_grep "no rebase in progress" err &&
+		echo uncommitted-content >expect &&
+		test_cmp expect file0
+	'
+
 	test_expect_success "rebase$type: dirty worktree, --no-autostash" '
 		test_config rebase.autostash true &&
 		git reset --hard &&

base-commit: 39bf06adf96da25b87c9aa7d35a32ef3683eb4a4
-- 
gitgitgadget
