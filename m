Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B92C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 20:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiAYU1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 15:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiAYU1F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 15:27:05 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F5DC06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 12:27:05 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id o72-20020a17090a0a4e00b001b4e5b5b6c0so2374376pjo.5
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 12:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aIjaabNBdKLaYUkRrvCoIHLdHK/NE75i0yNQSa6L/nw=;
        b=FMDaw2Kxly2LxcFwvhFABdxQKor/a22C1rfc7MgCAGa83nATHTJwo6zrgK1KPMIVf8
         u6ASGF1Barq0PsoECShxYIlk0C/pZPk2f4/OLM85HLNiy/vpPfT1FRs0rOv4/1+6gZe6
         DTtvD90F3JZtW95WZAyMMxFnz97odoZ9e69Z/9Rw5RULpd8tqidmoocaVKPLsG8YjhPS
         XA0x0etGTcL3AKyhY0xvJ5FfwXhOVOAPvtffAsurnNlFmUOhPbCgz0wabrPczlFt2W0T
         T+RpmuVBmPLat0KFlhcltNBJ9FFo8zwu04Bh2+2Xl2N10HxLzVV/TEvEeHjKh89ZDOlm
         1mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aIjaabNBdKLaYUkRrvCoIHLdHK/NE75i0yNQSa6L/nw=;
        b=vZVqb9ZcKCNOTrNIJg7cGImC2QCTo5cWlKxHM3KYRsJWFgoa9tMgFFiPXVuruJzNKd
         8Rx78pAf6bgavwoR+lhH9pk/m2ryEjLT8qe7MHz+RVMDMObc3mC5j4U2NhIFFC4MEEjc
         TpgkKrm48/w8NfCDZTzSd84wZmDL34TFZ9//HYzZP3rY4gek53dB62quvaeIwa+IKOAV
         jDYFN/3Cm7Gfm9j+tbqN2IOVE32XZA1iv9ddN2y0slet2dtIWvo3Q+GkHQwuCuosW/tx
         nKqjODUC+7ZOD79RvenLakaoRrctYiOVsTjHoJEBOeL+wUzypPPjPXRwuY5D77IhLsjT
         NedQ==
X-Gm-Message-State: AOAM530n9t0sDWtyx6By6VVOOzZxzbyt0H8UwuWMAh46l1A7Rl9gFDKf
        F4l3me2gFHQ/uwwTtsPUjpRdnqL/5wEAcw==
X-Google-Smtp-Source: ABdhPJyyb1zx8rSF8jrtohGEPIb63I4aLvC2I30053u3z7/K0gRAJVVwp+sYtbX5RtmQqScPIES0drdrQVGd2w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4d82:: with SMTP id
 oj2mr627505pjb.1.1643142424782; Tue, 25 Jan 2022 12:27:04 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:26:54 -0800
In-Reply-To: <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
Message-Id: <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com> <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
Subject: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5 07/11]
 rebase: do not attempt to remove startup_info->original_cwd)
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Since rebase spawns a `checkout` subprocess, make sure we run that from
> the startup_info->original_cwd directory, so that the checkout process
> knows to protect that directory.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  sequencer.c          | 2 ++
>  t/t2501-cwd-empty.sh | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index ea96837cde3..83f257e7fa4 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4228,6 +4228,8 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
>  
>  	cmd.git_cmd = 1;
>  
> +	if (startup_info->original_cwd)
> +		cmd.dir = startup_info->original_cwd;
>  	strvec_push(&cmd.args, "checkout");
>  	strvec_push(&cmd.args, commit);
>  	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
> diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
> index b1182390ba3..52335a8afe9 100755
> --- a/t/t2501-cwd-empty.sh
> +++ b/t/t2501-cwd-empty.sh
> @@ -166,11 +166,11 @@ test_expect_success 'cherry-pick fails if cwd needs to be removed' '
>  '
>  
>  test_expect_success 'rebase does not clean cwd incidentally' '
> -	test_incidental_dir_removal failure git rebase reverted
> +	test_incidental_dir_removal success git rebase reverted
>  '
>  
>  test_expect_success 'rebase fails if cwd needs to be removed' '
> -	test_required_dir_removal failure git rebase fd_conflict
> +	test_required_dir_removal success git rebase fd_conflict
>  '
>  
>  test_expect_success 'revert does not clean cwd incidentally' '
> -- 
> gitgitgadget

This commit (which is already in master) introduces a bug that breaks
rebase when rebasing inside a subdirectory of a worktree. You can see
that the below test fails with:

  error: The following untracked working tree files would be overwritten by merge:
          a/b/c
  Please move or remove them before you merge.

This only affects subdirectories in worktrees, i.e. rebasing anywhere in
the `main-wt` directory is fine, and rebasing from the top of `other-wt`
is fine, but `other-wt/any/other/dir` fails.

I haven't tracked down the root cause yet, but judging from the commit,
I would suppose that the checkout is being spawned in the wrong
directory, causing the files to not be cleaned up.

---
 t/t3400-rebase.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 23dbd3c82e..8b8b66538b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -416,4 +416,33 @@ test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink'
 	mv actual_logs .git/logs
 '
 
+test_expect_success 'rebase when inside worktree subdirectory' '
+	git init main-wt &&
+	(
+		cd main-wt &&
+		git commit --allow-empty -m "initial" &&
+		# create commit with foo/bar/baz
+		mkdir -p foo/bar &&
+		touch foo/bar/baz &&
+		git add foo/bar/baz &&
+		git commit -m "add foo/bar/baz" &&
+		# create commit with a/b/c
+		mkdir -p a/b &&
+		touch a/b/c &&
+		git add a/b/c &&
+		git commit -m "add a/b/c" &&
+		# create another branch for our other worktree
+		git branch other &&
+		git worktree add ../other-wt other &&
+		(
+			cd ../other-wt &&
+			mkdir -p random/dir &&
+			(
+				cd random/dir &&
+				git rebase --onto HEAD^^ HEAD^  # drops the HEAD^ commit
+			)
+		)
+	)
+'
+
 test_done
-- 
2.35.0.rc0.227.g00780c9af4-goog
