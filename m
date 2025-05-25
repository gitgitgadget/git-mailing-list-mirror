Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7F1ACEAC
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204837; cv=none; b=euWPRGbsFxm9u1OcJlxmYDEuvcdNGQEJJmRgF1K3VwUoZNhmdpfi40m5gUmeCIOOO8HQp/1MZfM1CsoHu1kRBHFycxdH9nmKY/cpCXLFpw9LjYMiW4NymvMJi6z6pGF+n9bYwQGcHar73al6fa23EXxc5agbF6OBcsZVWrp1uIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204837; c=relaxed/simple;
	bh=bI8vluEvLb4HIOS8dfQmsxrmLXWzBDvYv/kAQ8FbhUI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Dz23VP0yT+UfOyMMep5O0lazpDADy972yMx1imlLnb74Q/STDZwi9WW4SwiuCfV1GyEKv7jQpwKedvj/WfZN/RpuZmchf7+5oQeU0uXNHk3+mFQ0o2styJO1GNSgRp9zdFfynltR+xsQA163SmhntR2gP/iXYfvrxqT2sO5px9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+t5nk3H; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+t5nk3H"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a374f727dbso1499570f8f.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748204834; x=1748809634; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltY9gvAEfW8kDa5bjt+q32Vt3c3Dp3yrYGcrhSNzpls=;
        b=a+t5nk3HOy1N1uiPCC6NaA20Yb1uZK0WQ4Mg0vwW8+JRBX620TIYByFnEsa1SMM0S5
         rx1aYLQ3BOL2sGtk+u49QfrMiAWymxI7jM0dKXiroYRNOauxPiFXc7EbHXLfR95vPki4
         CPzVgRyLVFh3xTGyVAg6IUMXN792gRbxFW8eJocP7bONNPfcM6cYMKKJ8msXJ4ANnwlx
         uAMp3tSddsYl8H2yZ5BPnxHg/xZrHGmzTibGGaofKPX5cUMk0S7HV/KrWt322slHcdjs
         VIgxf1kw9DdAyGMeu+S3Ocm0yFsgnuX1c34lsvGwu02cNexepSQYIdNU3+ezm+LpApEs
         PLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748204834; x=1748809634;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltY9gvAEfW8kDa5bjt+q32Vt3c3Dp3yrYGcrhSNzpls=;
        b=iMtVjeuoa4w+1f50MLFl80aCcuC3jKg+nku99ISCDyKKfIGc/G6gPApDtf6DQ0K5QJ
         N6WjYnGLRzMd9hTrcKoJlQO7IETU7JPlyw0MzoCZBGPDE5/0VCk+MwyiuzxgqdHQwYKi
         67wvQ2iIIE1sGZLNajMK/ZoqknZc7IG1Oed0GCAhdP4iDoxqDc+saKiQyEuvTkt5S0q8
         Ovg9kpvt+vZ6mGreoPTdsWARqEViz+ZtM1Nnoxiu4W4zP23QNBBCU0U4VHfESOJgbt8+
         BARRg0Zot3+igFgs1o35LuhB3eA1nIueaE4QfI31Ud1mS0D6+mujpybtJbRoFiAgMBC3
         X1gQ==
X-Gm-Message-State: AOJu0YzqqpjZf2OP9KTzwN+FEury+DNyz2eHpxyilrtwk3SLHuvaX1kU
	oGrWquqRx/adqpVbBjMFt0AdEHqUIplkTkVHkxOb38lEKyjuNotTY3K3cZbOcw==
X-Gm-Gg: ASbGncv4qMnJVz9d1lpyKxiu60f0QMF/SgrNX/5tM64dY82fxWkG490H4K06YbnNy3Z
	KxVr2/fc3X65BdUAbdd68FNcS2npniCQTzvEETLcBjeg/cUESx17vXAFSuOpUcd42gQzgK1B6qa
	57Gpk8WyxQqvBpulDYg0JPIfLO2NVYPToWvQ3rG3gz66P0zQdBaYkI8FQp/0RlVhEd3aZH/GrfK
	XVJo0U33E8ki6fuK15gxSfcXI325VEcYprf0k6TIrPXT7US1OxfnvJrKANs/ckSNVX4F/tlMhAh
	hA6gciupLXfhYttsc+DicAwz15u1jnsUPHBRFTvcFk0dosM4DxQsLUgo4NP72cc=
X-Google-Smtp-Source: AGHT+IFqmTeDUcv5Bvkz/TcFWHEqgb77UwYC0AS3UHdmn59e6KXa1Xd20zT0kII+xRC1gRJA/RMd/w==
X-Received: by 2002:a5d:584c:0:b0:3a4:d4cd:b06 with SMTP id ffacd0b85a97d-3a4d4cd0d7cmr2256468f8f.34.1748204833503;
        Sun, 25 May 2025 13:27:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4cfa20c03sm4527483f8f.7.2025.05.25.13.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 13:27:13 -0700 (PDT)
Message-Id: <7a2f6fafd80e79416f4f4730909c30a1ddddbd6f.1748204829.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
References: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 20:27:03 +0000
Subject: [PATCH 3/9] doc: convert merge options to new synopsis format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/merge-options.adoc  | 108 +++++++++++++++---------------
 Documentation/rerere-options.adoc |   4 +-
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/Documentation/merge-options.adoc b/Documentation/merge-options.adoc
index 0022185201fc..9b3c7d6df4ef 100644
--- a/Documentation/merge-options.adoc
+++ b/Documentation/merge-options.adoc
@@ -1,23 +1,23 @@
---commit::
---no-commit::
+`--commit`::
+`--no-commit`::
 	Perform the merge and commit the result. This option can
-	be used to override --no-commit.
+	be used to override `--no-commit`.
 ifdef::git-pull[]
 	Only useful when merging.
 endif::git-pull[]
 +
-With --no-commit perform the merge and stop just before creating
+With `--no-commit` perform the merge and stop just before creating
 a merge commit, to give the user a chance to inspect and further
 tweak the merge result before committing.
 +
 Note that fast-forward updates do not create a merge commit and
-therefore there is no way to stop those merges with --no-commit.
+therefore there is no way to stop those merges with `--no-commit`.
 Thus, if you want to ensure your branch is not changed or updated
-by the merge command, use --no-ff with --no-commit.
+by the merge command, use `--no-ff` with `--no-commit`.
 
---edit::
--e::
---no-edit::
+`--edit`::
+`-e`::
+`--no-edit`::
 	Invoke an editor before committing successful mechanical merge to
 	further edit the auto-generated merge message, so that the user
 	can explain and justify the merge. The `--no-edit` option can be
@@ -35,17 +35,17 @@ they run `git merge`. To make it easier to adjust such scripts to the
 updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
 set to `no` at the beginning of them.
 
---cleanup=<mode>::
+`--cleanup=<mode>`::
 	This option determines how the merge message will be cleaned up before
 	committing. See linkgit:git-commit[1] for more details. In addition, if
-	the '<mode>' is given a value of `scissors`, scissors will be appended
+	the _<mode>_ is given a value of `scissors`, scissors will be appended
 	to `MERGE_MSG` before being passed on to the commit machinery in the
 	case of a merge conflict.
 
 ifdef::git-merge[]
---ff::
---no-ff::
---ff-only::
+`--ff`::
+`--no-ff`::
+`--ff-only`::
 	Specifies how a merge is handled when the merged-in history is
 	already a descendant of the current history.  `--ff` is the
 	default unless merging an annotated (and possibly signed) tag
@@ -53,13 +53,13 @@ ifdef::git-merge[]
 	hierarchy, in which case `--no-ff` is assumed.
 endif::git-merge[]
 ifdef::git-pull[]
---ff-only::
+`--ff-only`::
 	Only update to the new history if there is no divergent local
 	history.  This is the default when no method for reconciling
 	divergent histories is provided (via the --rebase=* flags).
 
---ff::
---no-ff::
+`--ff`::
+`--no-ff`::
 	When merging rather than rebasing, specifies how a merge is
 	handled when the merged-in history is already a descendant of
 	the current history.  If merging is requested, `--ff` is the
@@ -81,40 +81,40 @@ With `--ff-only`, resolve the merge as a fast-forward when possible.
 When not possible, refuse to merge and exit with a non-zero status.
 endif::git-merge[]
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
-	GPG-sign the resulting merge commit. The `keyid` argument is
+`-S[<key-id>]`::
+`--gpg-sign[=<key-id>]`::
+`--no-gpg-sign`::
+	GPG-sign the resulting merge commit. The _<key-id>_ argument is
 	optional and defaults to the committer identity; if specified,
 	it must be stuck to the option without a space. `--no-gpg-sign`
 	is useful to countermand both `commit.gpgSign` configuration variable,
 	and earlier `--gpg-sign`.
 
---log[=<n>]::
---no-log::
+`--log[=<n>]`::
+`--no-log`::
 	In addition to branch names, populate the log message with
-	one-line descriptions from at most <n> actual commits that are being
+	one-line descriptions from at most _<n>_ actual commits that are being
 	merged. See also linkgit:git-fmt-merge-msg[1].
 ifdef::git-pull[]
 	Only useful when merging.
 endif::git-pull[]
 +
-With --no-log do not list one-line descriptions from the
+With `--no-log` do not list one-line descriptions from the
 actual commits being merged.
 
 include::signoff-option.adoc[]
 
---stat::
--n::
---no-stat::
+`--stat`::
+`-n`::
+`--no-stat`::
 	Show a diffstat at the end of the merge. The diffstat is also
 	controlled by the configuration option merge.stat.
 +
-With -n or --no-stat do not show a diffstat at the end of the
+With `-n` or `--no-stat` do not show a diffstat at the end of the
 merge.
 
---squash::
---no-squash::
+`--squash`::
+`--no-squash`::
 	Produce the working tree and index state as if a real merge
 	happened (except for the merge information), but do not actually
 	make a commit, move the `HEAD`, or record `$GIT_DIR/MERGE_HEAD`
@@ -123,16 +123,16 @@ merge.
 	the current branch whose effect is the same as merging another
 	branch (or more in case of an octopus).
 +
-With --no-squash perform the merge and commit the result. This
-option can be used to override --squash.
+With `--no-squash` perform the merge and commit the result. This
+option can be used to override `--squash`.
 +
-With --squash, --commit is not allowed, and will fail.
+With `--squash`, `--commit` is not allowed, and will fail.
 ifdef::git-pull[]
 +
 Only useful when merging.
 endif::git-pull[]
 
---[no-]verify::
+`--[no-]verify`::
 	By default, the pre-merge and commit-msg hooks are run.
 	When `--no-verify` is given, these are bypassed.
 	See also linkgit:githooks[5].
@@ -140,21 +140,21 @@ ifdef::git-pull[]
 	Only useful when merging.
 endif::git-pull[]
 
--s <strategy>::
---strategy=<strategy>::
+`-s <strategy>`::
+`--strategy=<strategy>`::
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
 	If there is no `-s` option, a built-in list of strategies
 	is used instead (`ort` when merging a single head,
 	`octopus` otherwise).
 
--X <option>::
---strategy-option=<option>::
+`-X <option>`::
+`--strategy-option=<option>`::
 	Pass merge strategy specific option through to the merge
 	strategy.
 
---verify-signatures::
---no-verify-signatures::
+`--verify-signatures`::
+`--no-verify-signatures`::
 	Verify that the tip commit of the side branch being merged is
 	signed with a valid key, i.e. a key that has a valid uid: in the
 	default trust model, this means the signing key has been signed by
@@ -165,22 +165,22 @@ ifdef::git-pull[]
 Only useful when merging.
 endif::git-pull[]
 
---summary::
---no-summary::
-	Synonyms to --stat and --no-stat; these are deprecated and will be
+`--summary`::
+`--no-summary`::
+	Synonyms to `--stat` and `--no-stat`; these are deprecated and will be
 	removed in the future.
 
 ifndef::git-pull[]
--q::
---quiet::
-	Operate quietly. Implies --no-progress.
+`-q`::
+`--quiet`::
+	Operate quietly. Implies `--no-progress`.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Be verbose.
 
---progress::
---no-progress::
+`--progress`::
+`--no-progress`::
 	Turn progress on/off explicitly. If neither is specified,
 	progress is shown if standard error is connected to a terminal.
 	Note that not all merge strategies may support progress
@@ -188,8 +188,8 @@ ifndef::git-pull[]
 
 endif::git-pull[]
 
---autostash::
---no-autostash::
+`--autostash`::
+`--no-autostash`::
 	Automatically create a temporary stash entry before the operation
 	begins, record it in the ref `MERGE_AUTOSTASH`
 	and apply it after the operation ends.  This means
@@ -197,7 +197,7 @@ endif::git-pull[]
 	with care: the final stash application after a successful
 	merge might result in non-trivial conflicts.
 
---allow-unrelated-histories::
+`--allow-unrelated-histories`::
 	By default, `git merge` command refuses to merge histories
 	that do not share a common ancestor.  This option can be
 	used to override this safety when merging histories of two
diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-options.adoc
index c3321ddea248..b0b920144a6c 100644
--- a/Documentation/rerere-options.adoc
+++ b/Documentation/rerere-options.adoc
@@ -1,5 +1,5 @@
---rerere-autoupdate::
---no-rerere-autoupdate::
+`--rerere-autoupdate`::
+`--no-rerere-autoupdate`::
 	After the rerere mechanism reuses a recorded resolution on
 	the current conflict to update the files in the working
 	tree, allow it to also update the index with the result of
-- 
gitgitgadget

