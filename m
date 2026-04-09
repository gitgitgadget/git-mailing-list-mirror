Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C731C8BE9
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762240; cv=none; b=dsoWzLmHlZHQgX3iiwbqXnpxat1iC0qkvIWq5Oz05gRi/j/tUa1I4t6Lf/5XIfnCwDRX/vTrU17WcTxz53Nji1nI/RwXm9jTk81wdKr71I48cuR2NiqeSWb805xjm+9T+9zvn66QuLfdwkODXph/lvxYka3Pho7MrlpZfbrpp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762240; c=relaxed/simple;
	bh=S/ZRzi3b8PZGUD4O2bKCuHlPzPM56x4e2T88TDQL258=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N077zIMC+pAhBREHl9hJJzUYDAldXYsI4rzdZwmRLHwWIpMYTMKOmRB8v+SprrXnrsirtZQgpunM/joosJAOOfmnzii4KwJJfKOnkiFbJQBuiFmIQGcBdb4yGTpdK+FlJeC+qYQmH6mwtVxJTELYxb8AuBbDEDcSNFJ5SyCDw5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNQn76/D; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNQn76/D"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b6b0500e06so1644819eec.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775762237; x=1776367037; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti0VP9LOio4NOQCrHSPTPzOhI8k1KDm8Yl3+bL/jFeo=;
        b=jNQn76/DNvM8HmoAH7Y22oU/72qx5DBCT0QJfoDW6ZGZqAINPYIvJTrgiTnifqxmSy
         bUyoAaoeyXcSUeyPWL31h8OXebnFCSgJPAwilke4fD9/OA5Qa1WaupUKiIJY5qx1GXpr
         aOpRUMITf+6h64j9au8RknERGhH3sSD05zTDUAr3QpJt+yg6hgco5rDHXpeMHcJIi9ot
         VGnqJiWd3F9u3JGjdNdsTRmxfg8c7l7RChRlZc2ldmxs16K/QFJZBR/y9oUpBSa5FD/p
         md8rCuU5vsieUf+TLGnOvyTSKcBMLo1aXdtLIRgeIxSomkVO68g29hkum74d0C9mpDcU
         ZhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762237; x=1776367037;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ti0VP9LOio4NOQCrHSPTPzOhI8k1KDm8Yl3+bL/jFeo=;
        b=YVu7nrCdXqH7QRo1ZvGrwqXY/2pgiFJBFOMyuN6td6YBdbEaKmwJ5UA3cDGw4gQVvW
         wvt6p3USJlgqOnweXJNUy9Jl5zqp0NmcDMXzHga2mZffNkHCyEUi7R45EpD3QmtC8cf+
         QpiZytdf5MVk/3t8uz3AzZ2yJTLw4Q0s2aPLBR9gHjx35DI+FuQ5nQAylG6PRAjvSZVg
         7a7eELIkGMTkA5pvE0HtqIn24t9rMQG8pzvKmoUOu4Pwsdw0ZNrkeHt5HNFL4oJmfOM6
         WNfIUAR1S6z3aJsUMNoqs1zm8jSCCWMZaFBt4KLsuvFJnO1Dd/H4c/pPZj4tfatl7hsw
         LnSg==
X-Gm-Message-State: AOJu0Yz98fRrAHPdNpFtiMAIYuHRST9GOqHwgI8TaaGo5EeWyHa5elQI
	KwyJYf0NGgasH3OGuA0wzDxENA9/RzLn6fa/FRRlrl272nKcSu9hSb4NB6Mz8Q==
X-Gm-Gg: AeBDieuE6hr/gL7pfd2Yug583mAjcC7mLL8lIp4njQOkIGkz037tHEG+P/e9C998Sd/
	C5nBfgkd1YPUr2ZlbtHy47xZB3qoojAa987GQYntbBecrHzp7XdZGLaOsP8O0c+GE98HfrQfA7Y
	RI6XrVs//Gj7S+fskFrQNXwLyf2TpcwaNyJrvsy1wvH0Z9i+UijUfXTPrs80lRmRvMQRIdIByot
	/J0SCNZvUiPusSGoUgLEj2YYXAwc5BZvS68LHpfFRPSAcgcEhPbBgGa9Es9B86AQZrsRHj2ObPc
	Dyb+kFzEkl/7Ft0gv5KUZKyMsWXYANe3rH/CyLMe52PydPVlHEjoGollFQnIbs0Fpj/IncgiFEi
	38kKQZjiycr2SFzDoSHyN8/ue8uu+N+qiZxx5NNrpp9UwgcmcR/ZtTSYnsmI/U4ihMkwSNTmT5s
	yXP+dGvvuXQ31SANITO40RegLig/MQ
X-Received: by 2002:a05:7300:7316:b0:2d0:239a:23cb with SMTP id 5a478bee46e88-2d5891766c4mr201907eec.16.1775762237298;
        Thu, 09 Apr 2026 12:17:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db64c4sm884378eec.27.2026.04.09.12.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:17:16 -0700 (PDT)
Message-Id: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
References: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 19:17:11 +0000
Subject: [PATCH v8 0/4] checkout: 'autostash' for branch switching
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Harald Nordgren (4):
  stash: add --ours-label, --theirs-label, --base-label for apply
  sequencer: allow create_autostash to run silently
  sequencer: teach autostash apply to take optional conflict marker
    labels
  checkout: -m (--merge) uses autostash when switching branches

 Documentation/git-checkout.adoc |  58 +++++-----
 Documentation/git-stash.adoc    |  11 +-
 Documentation/git-switch.adoc   |  33 +++---
 builtin/checkout.c              | 138 ++++++++++------------
 builtin/stash.c                 |  32 ++++--
 sequencer.c                     |  67 ++++++++---
 sequencer.h                     |   4 +
 t/t3420-rebase-autostash.sh     |  24 +++-
 t/t3903-stash.sh                |  37 ++++++
 t/t7201-co.sh                   | 195 ++++++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 ++
 xdiff-interface.h               |   1 +
 xdiff/xmerge.c                  |   6 +-
 14 files changed, 463 insertions(+), 157 deletions(-)


base-commit: b15384c06f77bc2d34d0d3623a8a58218313a561
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v8
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v7:

 1:  284075600a ! 1:  8fcf377820 stash: add --ours-label, --theirs-label, --base-label for apply
     @@ t/t3903-stash.sh: test_expect_success 'restore untracked files even when we hit
      +		echo upstream >file &&
      +		git add file &&
      +		git commit -m upstream &&
     -+		test_must_fail git stash apply --ours-label=UP --theirs-label=STASH &&
     -+		grep "^<<<<<<< UP" file &&
     -+		grep "^>>>>>>> STASH" file
     ++		test_must_fail git -c merge.conflictStyle=diff3 stash apply --ours-label=UP --theirs-label=STASH &&
     ++		test_grep "^<<<<<<< UP" file &&
     ++		test_grep "^||||||| Stash base" file &&
     ++		test_grep "^>>>>>>> STASH" file
     ++	)
     ++'
     ++
     ++test_expect_success 'apply with empty conflict labels' '
     ++	git init empty_labels &&
     ++	(
     ++		cd empty_labels &&
     ++		echo base >file &&
     ++		git add file &&
     ++		git commit -m base &&
     ++		echo stashed >file &&
     ++		git stash push -m "stashed" &&
     ++		echo upstream >file &&
     ++		git add file &&
     ++		git commit -m upstream &&
     ++		test_must_fail git stash apply --ours-label= --theirs-label= &&
     ++		test_grep "^<<<<<<<$" file &&
     ++		test_grep "^>>>>>>>$" file
      +	)
      +'
      +
       test_expect_success 'stash create reports a locked index' '
       	test_when_finished "rm -rf repo" &&
       	git init repo &&
     +
     + ## xdiff/xmerge.c ##
     +@@ xdiff/xmerge.c: static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
     + 			      int size, int i, int style,
     + 			      xdmerge_t *m, char *dest, int marker_size)
     + {
     +-	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
     +-	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
     +-	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
     ++	int marker1_size = (name1 && *name1 ? strlen(name1) + 1 : 0);
     ++	int marker2_size = (name2 && *name2 ? strlen(name2) + 1 : 0);
     ++	int marker3_size = (name3 && *name3 ? strlen(name3) + 1 : 0);
     + 	int needs_cr = is_cr_needed(xe1, xe2, m);
     + 
     + 	if (marker_size <= 0)
 2:  64261e3cb6 = 2:  86cf68d024 sequencer: allow create_autostash to run silently
 3:  c0d6b4b4c0 ! 3:  78300e0e9a sequencer: teach autostash apply to take optional conflict marker labels
     @@ sequencer.c: void create_autostash_ref_silent(struct repository *r, const char *
       
      -static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
      +static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     -+				    const char *label1, const char *label2,
     -+				    const char *label_ancestor)
     ++				    const char *label_ours, const char *label_theirs,
     ++				    const char *label_base)
       {
       	struct child_process child = CHILD_PROCESS_INIT;
       	int ret = 0;
     @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int atte
       		child.no_stderr = 1;
       		strvec_push(&child.args, "stash");
       		strvec_push(&child.args, "apply");
     -+		if (label1)
     -+			strvec_pushf(&child.args, "--ours-label=%s", label1);
     -+		if (label2)
     -+			strvec_pushf(&child.args, "--theirs-label=%s", label2);
     -+		if (label_ancestor)
     -+			strvec_pushf(&child.args, "--base-label=%s", label_ancestor);
     ++		if (label_ours)
     ++			strvec_pushf(&child.args, "--ours-label=%s", label_ours);
     ++		if (label_theirs)
     ++			strvec_pushf(&child.args, "--theirs-label=%s", label_theirs);
     ++		if (label_base)
     ++			strvec_pushf(&child.args, "--base-label=%s", label_base);
       		strvec_push(&child.args, stash_oid);
       		ret = run_command(&child);
       	}
     @@ sequencer.c: int apply_autostash(const char *path)
       static int apply_save_autostash_ref(struct repository *r, const char *refname,
      -				    int attempt_apply)
      +				    int attempt_apply,
     -+				    const char *label1, const char *label2,
     -+				    const char *label_ancestor)
     ++				    const char *label_ours, const char *label_theirs,
     ++				    const char *label_base)
       {
       	struct object_id stash_oid;
       	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
     @@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const cha
       	oid_to_hex_r(stash_oid_hex, &stash_oid);
      -	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
      +	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
     -+				       label1, label2, label_ancestor);
     ++				       label_ours, label_theirs, label_base);
       
       	refs_delete_ref(get_main_ref_store(r), "", refname,
       			&stash_oid, REF_NO_DEREF);
     @@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const cha
      +}
      +
      +int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     -+				    const char *label1, const char *label2,
     -+				    const char *label_ancestor)
     ++				    const char *label_ours, const char *label_theirs,
     ++				    const char *label_base)
      +{
      +	return apply_save_autostash_ref(r, refname, 1,
     -+					label1, label2, label_ancestor);
     ++					label_ours, label_theirs, label_base);
       }
       
       static int checkout_onto(struct repository *r, struct replay_opts *opts,
     @@ sequencer.h: int save_autostash_ref(struct repository *r, const char *refname);
       int apply_autostash_oid(const char *stash_oid);
       int apply_autostash_ref(struct repository *r, const char *refname);
      +int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     -+				    const char *label1, const char *label2,
     -+				    const char *label_ancestor);
     ++				    const char *label_ours, const char *label_theirs,
     ++				    const char *label_base);
       
       #define SUMMARY_INITIAL_COMMIT   (1 << 0)
       #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 4:  1c29e19971 ! 4:  aa18313362 checkout: -m (--merge) uses autostash when switching branches
     @@ Documentation/git-checkout.adoc: $ git checkout mytopic
      +When the `--merge` (`-m`) option is in effect and the locally
      +modified files overlap with files that need to be updated by the
      +branch switch, the changes are stashed and reapplied after the
     -+switch.  If the stash application results in conflicts, they are not
     -+resolved and the stash is saved to the stash list:
     ++switch.  If this process results in conflicts, a stash entry is saved
     ++and made available in `git stash list`:
       
       ------------
       $ git checkout -m mytopic
     @@ Documentation/git-checkout.adoc: $ git checkout mytopic
      
       ## Documentation/git-switch.adoc ##
      @@ Documentation/git-switch.adoc: variable.
     - 	If you have local modifications to one or more files that are
     - 	different between the current branch and the branch to which
     - 	you are switching, the command refuses to switch branches in
     + 
     + `-m`::
     + `--merge`::
     +-	If you have local modifications to one or more files that are
     +-	different between the current branch and the branch to which
     +-	you are switching, the command refuses to switch branches in
      -	order to preserve your modifications in context.  However,
      -	with this option, a three-way merge between the current
      -	branch, your working tree contents, and the new branch is
     @@ Documentation/git-switch.adoc: variable.
      -paths are left unmerged, and you need to resolve the conflicts
      -and mark the resolved paths with `git add` (or `git rm` if the merge
      -should result in deletion of the path).
     -+	order to preserve your modifications in context.  With this
     -+	option, the conflicting local changes are automatically
     -+	stashed before the switch and reapplied afterwards.  If the
     -+	local changes do not overlap with the differences between
     -+	branches, the switch proceeds without stashing.  If
     -+	reapplying the stash results in conflicts, the entry is
     -+	saved to the stash list.  Resolve the conflicts and run
     -+	`git stash drop` when done, or clear the working tree
     -+	(e.g. with `git reset --hard`) before running `git stash pop`
     -+	later to re-apply your changes.
     ++	If you have local modifications to one or more files that
     ++	are different between the current branch and the branch to
     ++	which you are switching, the command normally refuses to
     ++	switch branches in order to preserve your modifications in
     ++	context.  However, with this option, the conflicting local
     ++	changes are automatically stashed before the switch and
     ++	reapplied afterwards.  If the local changes do not overlap
     ++	with the differences between branches, the switch proceeds
     ++	without stashing.  If reapplying the stash results in
     ++	conflicts, the entry is saved to the stash list.  Resolve
     ++	the conflicts and run `git stash drop` when done, or clear
     ++	the working tree (e.g. with `git reset --hard`) before
     ++	running `git stash pop` later to re-apply your changes.
       
       `--conflict=<style>`::
       	The same as `--merge` option above, but changes the way the
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +	git clean -f &&
      +
      +	fill 0 x y z >same &&
     ++	git stash list >stash-before &&
      +	git checkout -m side >actual 2>&1 &&
      +	test_grep ! "Created autostash" actual &&
     ++	git stash list >stash-after &&
     ++	test_cmp stash-before stash-after &&
      +	fill 0 x y z >expect &&
      +	test_cmp expect same
      +'
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +
      +	fill DIRTY a b c INSERTED d >file &&
      +
     ++	git stash list >stash-before &&
      +	git checkout -m nonoverlap_base 2>stderr &&
      +	test_grep "Applied autostash" stderr &&
      +	test_grep ! "resulted in conflicts" stderr &&
      +
     ++	git stash list >stash-after &&
     ++	test_cmp stash-before stash-after &&
     ++
      +	fill DIRTY a b c d >expect &&
      +	test_cmp expect file &&
      +

-- 
gitgitgadget
