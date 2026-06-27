Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DF224D6
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782583349; cv=none; b=KJFuid53aKfC9op3sYnxn9JvdrZ4D3t6s67SfO2p0AZpRb83WN42KFOHUXPhrl6bmgF79TjcrYpbIIq6zk01zSKRW4/AszJHVCewk97Wq546weacEk6YA+u89SYWudcIU1DbJESqSbP8hBQfZcH5RtiVfwIvXcAh6nlKWSv6Wt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782583349; c=relaxed/simple;
	bh=S0e2bu7+qmLM5SZ62cUBrMLUAdRLbgI9FXzT1OPhUDM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u4iPNRpCguYacsnsqVXVavTo02Tt76t0ex++qLulMPvZG/1BfMzFXcYlaOlkHFppl20CKPBsxiNSG24/r7udYGNBosJIg9Ob0qYzuTe96IKAqK7n2ta+KSggo8EMkKLZBHmWpb0ZtGoFG2P5tJMfAWYzIqtYnnE2x5vW3DNZp0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNn7CIkF; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNn7CIkF"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1384ebe7a10so3507174c88.1
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 11:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782583347; x=1783188147; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebxc0o1gyeD+SAYIVmYXrx4cMpckS9wFSbeM85AHTwk=;
        b=gNn7CIkFPrT/oemHnP79ihUgstIX3tKVLxlSorF1RKWdCT8nFyb/WQV8S5lLDEbDjM
         3Br8UDTQVijYxybnZLYKajxTGxtCvoJs79M7SdD1uxyR+WnkYsOjGZB8Wjd+Xck8U0wk
         /lat9lGYj2v/gbkCs+cv+sPjrCxx8At4IX9H39YAu4SkHOHI4qxBI8X6G0wodA7TzukS
         iPtFDbq9gqSwi6BdSeOD0iXXowVuY2SCQHYKvwgSUi2WijzFVeoBMoGQ9k0Gvdk4I4uI
         ++MPJkzMLB+EAalShvf/274fTKBgNqGwiqwSJ/4D1aXUu/6lUi++WJQbNarTQyCugLxn
         RFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782583347; x=1783188147;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ebxc0o1gyeD+SAYIVmYXrx4cMpckS9wFSbeM85AHTwk=;
        b=sTWeTNCFRG6D2Brt+0yfVb4iHOpxbuAW/eiPqxAwZIgJ4HQbOECWj26YOIt/jzjQWZ
         bp5L7+CThy0L2Rp2kTZ9Q+hmeb5esael+LrCwjGX7CC9Yudd4lt3RBbJ5m0eAqv0Mk00
         L6jyIMgbVGgXEDJ5l5kF7PnExC39Pn4pCqs7LhQDDgxVz0Vo4p698nP5wR/5On725KyU
         g/MN++2+aqcWvg0BGWx9n1484ujtVKPS4QSGcfQ38zuUF+UmCuts6MkNCQAzfsPDh2gC
         YmrpWQ7vndwbZpxhceFfMVURgmeC2WMAQiWByVgQFqoH+mB35CfVGLi7cdx/2LuPP5WR
         g3Ew==
X-Gm-Message-State: AOJu0Yzm9AuTAdgxemTqIPF9wsa0lPsoywwA8ICxiJ5urLGgjEYu0T1l
	ceSXKyRPzB7E72XEmxAbuyYFEr9ga0kSw2rrjqvgYule4ZZw7UFW3sQxWEz5nA==
X-Gm-Gg: AfdE7cmeVGj6kkmlzFxGlnGtMNrepjD/txQkbgCCCZw2l8Db0k7mKfQNkVEsrUawYhD
	RcIFFBCK/b8QIasldJKbB5FCaHo0beLnaaUcVOzxPCkyiPz2i6VP4fNnPBAZZGlzO9maB2zc0y8
	jSnD0swsi0WHMa5vV9ZUhv7zvuMuOvMVi0DRIq4EJYYCF8eUFG+RSplTkc6U0oKiZ2WT2KGBNlD
	mnvk2hCHXlYP4lDsDZ2A/0kUABew2tLMUIKyNDAjX/5YjqKaoPgrDJE2SdfhbT4f/71awBsH4bL
	qRRrr2O4BzzOUpg7ypHmlSjmMk/EzSJs5PTcr+BhB99DMsWYMf4zN+rTrBWxQnHynNetn/no/bm
	LuZtlE61r8JfKeEDXh1JC/8eYEmAK1r52UQ+foaIIWEquqZlmcGl8hM/WxV2vuS7+b2iDhTOI08
	4EeJgiiPD1xzfpFjsO
X-Received: by 2002:a05:7022:ebc5:b0:137:feeb:3fc9 with SMTP id a92af1059eb24-139dbb5b2d9mr10791955c88.18.1782583346793;
        Sat, 27 Jun 2026 11:02:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.213.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f318e7sm31659772c88.3.2026.06.27.11.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 11:02:26 -0700 (PDT)
Message-Id: <pull.2331.v3.git.git.1782583345.gitgitgadget@gmail.com>
In-Reply-To: <pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
References: <pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 18:02:23 +0000
Subject: [PATCH v3 0/2] branch/push: suggest intended form when remote/branch slip given
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

When the repository or upstream argument is a slip like "origin/main" or
"origin main", suggest the intended "git push origin main" or "git branch
--set-upstream-to=origin/main" form instead of failing with an unrelated
error.

Changes in v3:

 * Reworded the branch commit message to also show the second confusing
   error (the requested upstream branch 'origin' does not exist) for when
   the operated-on branch does exist.
 * Converted the new t5529 tests from bare grep/! grep to test_grep to fix
   the test-lint failures.
 * Added a brief call-site comment explaining the up-front advice_enabled()
   gate (skips the lookups when the hint is off, while advise_if_enabled()
   still prints the disable-message footer).

Changes in v2:

 * Rewrote both commit messages to lead with the intended command, the easy
   slip, and the resulting error, instead of the terse original.
 * Gated each suggestion on advice_enabled() up front, so a user who
   silenced the hint pays no remote/ref lookups and falls through to the
   original error. Extracted the detection logic into helpers
   (die_if_repo_looks_like_ref, die_if_upstream_looks_like_remote) so each
   call site reads as a single guarded line.

Harald Nordgren (2):
  branch: suggest <remote>/<branch> on upstream slip
  push: suggest <remote> <branch> for a slash slip

 Documentation/config/advice.adoc |  5 +++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/branch.c                 | 32 +++++++++++++++++++++++++++
 builtin/push.c                   | 37 ++++++++++++++++++++++++++++++-
 t/t3200-branch.sh                | 38 ++++++++++++++++++++++++++++++++
 t/t5529-push-errors.sh           | 31 ++++++++++++++++++++++++++
 7 files changed, 144 insertions(+), 1 deletion(-)


base-commit: ab776a62a78576513ee121424adb19597fbb7613
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2331%2FHaraldNordgren%2Fsuggest-remote-branch-slips-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2331/HaraldNordgren/suggest-remote-branch-slips-v3
Pull-Request: https://github.com/git/git/pull/2331

Range-diff vs v2:

 1:  11bcecebf4 ! 1:  9883c28482 branch: suggest <remote>/<branch> on upstream slip
     @@ Commit message
      
              fatal: branch 'main' does not exist
      
     -    pointing at a branch the user never meant to name.
     +    pointing at a branch the user never meant to name. When 'main' does
     +    exist, it instead dies with:
     +
     +        fatal: the requested upstream branch 'origin' does not exist
     +
     +    leaving the user equally puzzled.
      
          When the operated-on branch is missing and '<remote>/<branch>' names
          a real remote-tracking ref, suggest the intended form:
     @@ builtin/branch.c: int cmd_branch(int argc,
       		if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname)) {
       			if (!argc || branch_checked_out(branch->refname))
       				die(_("no commit on branch '%s' yet"), branch->name);
     ++			/*
     ++			 * Check the advice up front to avoid the ref
     ++			 * lookups when the hint is off. The helper still
     ++			 * calls advise_if_enabled() so the hint carries the
     ++			 * standard "disable this message" instructions.
     ++			 */
      +			if (argc == 1 &&
      +			    advice_enabled(ADVICE_SET_UPSTREAM_FAILURE))
      +				die_if_upstream_looks_like_remote(new_upstream, argv[0]);
 2:  49de5a925d ! 2:  dbe4dbc346 push: suggest <remote> <branch> for a slash slip
     @@ builtin/push.c: int cmd_push(int argc,
       		if (!add_remote_or_group(repo, &remote_group)) {
      +			struct remote *r;
      +
     ++			/*
     ++			 * Check the advice up front to avoid the remote
     ++			 * lookup when the hint is off. The helper still
     ++			 * calls advise_if_enabled() so the hint carries the
     ++			 * standard "disable this message" instructions.
     ++			 */
      +			if (advice_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF))
      +				die_if_repo_looks_like_ref(repo);
      +
     @@ t/t5529-push-errors.sh: test_expect_success 'detect empty remote with targeted r
       
      +test_expect_success 'suggest <remote> <branch> for a <remote>/<branch> slip' '
      +	test_must_fail git push origin/main 2>stderr &&
     -+	grep "${SQ}origin/main${SQ} is not a valid push target" stderr &&
     -+	grep "hint: Did you mean to use: git push origin main?" stderr &&
     ++	test_grep "${SQ}origin/main${SQ} is not a valid push target" stderr &&
     ++	test_grep "hint: Did you mean to use: git push origin main?" stderr &&
      +	test_must_fail git -c advice.pushRepoLooksLikeRef=false push origin/main 2>stderr &&
     -+	! grep "Did you mean" stderr
     ++	test_grep ! "Did you mean" stderr
      +'
      +
      +test_expect_success 'suggest <remote> <branch> when the branch has slashes' '
      +	test_must_fail git push origin/feature/x 2>stderr &&
     -+	grep "hint: Did you mean to use: git push origin feature/x?" stderr
     ++	test_grep "hint: Did you mean to use: git push origin feature/x?" stderr
      +'
      +
      +test_expect_success 'no suggestion when prefix is not a configured remote' '
      +	test_must_fail git push not-a-remote/main 2>stderr &&
     -+	! grep "Did you mean" stderr
     ++	test_grep ! "Did you mean" stderr
      +'
      +
      +test_expect_success 'no suggestion for a trailing slash with no branch' '
      +	test_must_fail git push origin/ 2>stderr &&
     -+	! grep "Did you mean" stderr
     ++	test_grep ! "Did you mean" stderr
      +'
      +
      +test_expect_success 'no suggestion when the argument is an existing path' '
      +	test_when_finished "rm -rf origin" &&
      +	git init --bare origin/main &&
      +	git push origin/main HEAD:refs/heads/pushed 2>stderr &&
     -+	! grep "Did you mean" stderr &&
     ++	test_grep ! "Did you mean" stderr &&
      +	git -C origin/main rev-parse --verify refs/heads/pushed
      +'
      +

-- 
gitgitgadget
