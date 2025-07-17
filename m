Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CEE1FDE01
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716067; cv=none; b=I01Ytsr1t77ECyjhLKf2+DDtAfMn0TGqAvkxPXYpagIMG98x0j+Dc+NHmnVULzz0KwUqv0PbhddzBuZdJilTe9ef4Lh1GrRBeUYHIEhCnQfM01uxpgbU0Vr1R4ZIw4mVfdGrRdRtReZNUzzN/vRcv3YCjD6mRNVsywij24olmcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716067; c=relaxed/simple;
	bh=+7xFYWfreG/MuFJVS9FZ8TPpdGM8KS8BMzcfcMSCGaU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SbIV+NsEMlw2xuF+5jRswzt57QbopEOicmMxxFb0vECoiOJkIz1+6JoeAS/xKo5cUfkBzSBmLPxxFACfdwsgSjX/v3Vlo4QBM98JranHKlZXgf65JrqBJa2yDCcnHvuufivhEAV8kjHHcXetMaSK2YyPNUYTnpKVKL79wMbErYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbm75BEp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbm75BEp"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ab112dea41so224423f8f.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752716064; x=1753320864; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQZ/jafN9HGyNDQKMyZqkxbvNJEb7Wb4jy3LyL5q1h0=;
        b=Pbm75BEpbeICeFT7AG3VsCjFgtEckVNIJBoB5iHiAH9sHmfPrZB2RQAVfJ+2g1Womh
         n2phwa7Zjw5aL8x6OWHHY2t1z22/muZqGDhUjzLkgsErw4VIoq39XzkNHx1CddC2FQIE
         GCHCdVHL+JlbZzRWPrU7t6iW71/xNXPIBCQKGJfLAWMDbqKoKa4tMhq6srjNbbuKhL8Y
         RVYql70mIiAXmUnU3oOCJrL0twqO8UWDY5aitaA0xA/AI1QdNmNBTRZjp2C7yOnrpea8
         bkDQIXKQPUHan3tu9cYLLOOInTNxQCwj3J9HxZBW99YGCSyt6LKhlYNOAjIxcCangY0K
         +Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716064; x=1753320864;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQZ/jafN9HGyNDQKMyZqkxbvNJEb7Wb4jy3LyL5q1h0=;
        b=IGKnZkbm/6q6iyUlg31efgivTO/6YgHnAKbHSP0e4HJEG2P8yTVToirIJN/cEZUlZD
         itZ5xYd89N10u5nNxV120f44cv599t63yjtddtiNuo24rwY027EPluGHq7CCf8uEBp3/
         Un+UCY9V4RyN772kOI0lcnnEQbzynMn4ElarJLz+2BBd2W+Ft+qbQKLmL5b8TeDVVAMN
         YNWDgWXwTFicXEaMm/VStlIpWQ7ZNHEH6xcZG+Bi3L9iP6x4faBj59GhfafyG6UalMAi
         84+84GpGrTIPDxQhmTVsXx8ep3GlDsoayyeU0ZzctVZA9s/hmi7LJpzVZXHx9nBHRqIV
         q/Kw==
X-Gm-Message-State: AOJu0YxbPnxijGsiqgRO1+Uqcf6zQovFOhvA/iIpg9ydsBZBC10wQa6T
	ItAH+YSMVAjgHTZuYbRZiw43IKWXoQTO03Ev3hESG31JW+vwuekCWmbp0KRWyg==
X-Gm-Gg: ASbGncukRKUcrkIfSamUBTjD84dMYz0NTSOhpIsAqnrPfbaacDKoOthkqjzZ9rh7UfG
	Zh9ilqmde6Lb4yh++I54SqaQPTJPZUFRinp1k9r8HCFbbVplGglD4+J8f+gVRoGmK5UEuyq1jO8
	9RHJ5ogcX/YMBxWGOgiHW1kAdSceVIsRbMT5aLMApElJGvyDoMVWlcfu3nxPFplvAZz3VfNA6k4
	Ju7KopJINRrQBMgtWILTSIAIUCVgCy/qApy9fBQf7djeCyPQNMowID/MYfyDRSJRaUvtfXahdBR
	NxfXSQViGCbrIHOn4iLLpcCqL0kgNijwpCncMowzkf5KzPYAg7zT/kzMNjF5BgFob9GQQNm2ZRV
	q/evDquWmAm9d3gx5whjmCBY=
X-Google-Smtp-Source: AGHT+IE/m7k5CScs5r0cYc4+Irnaq8KAPYRVnOWtkehXGnZOQIUXXASlRYTI8fCHa/2vJ9+8T0NIEw==
X-Received: by 2002:a05:6000:2304:b0:3b3:9c75:bb0e with SMTP id ffacd0b85a97d-3b60dd64b7bmr4313272f8f.11.1752716063790;
        Wed, 16 Jul 2025 18:34:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc229asm19265849f8f.35.2025.07.16.18.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:34:23 -0700 (PDT)
Message-Id: <82c24ce51980d85e1a53e746b462397e6e6c908a.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 01:34:14 +0000
Subject: [PATCH v2 8/8] sparse-checkout: make 'clean' clear more files
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'git sparse-checkout clean' command is designed to be a one-command
way to get the worktree in a state such that a sparse index would
operate efficiently. The previous change demonstrated that files outside
the sparse-checkout that were committed due to a merge conflict would
persist despite attempts to run 'git sparse-checkout clean' and instead
a 'git sparse-checkout reapply' would be required.

Instead of requiring users to run both commands, update 'clean' to be
more ruthless about tracked sparse directories. The key here is to make
sure that the SKIP_WORKTREE bit is removed from more paths in the index
using update_sparsity() before compressing the index to a sparse one
in-memory.

The tricky part here is that update_sparsity() was previously assuming
that it would be in 'update' mode and would change the worktree as it
made changes. However, we do not want to make these worktree changes at
this point, instead relying on our later logic (that integrates with
--dry-run and --verbose options) to perform those steps.

One side-effect here is that we also clear out staged files that exist
in the worktree, but they would also appear in the verbose output as
part of the dry run.

The final test in t1091 demonstrates that we no longer need the
'reapply' subcommand for merge resolutions. It also fixes an earlier
case where 'git add --sparse' clears the SKIP_WORKTREE bit and avoids a
directory deletion.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/sparse-checkout.c          |  8 ++++++++
 t/t1091-sparse-checkout-builtin.sh | 24 +++++++++++++++++-------
 unpack-trees.c                     |  2 +-
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index f38a0809c098..1d1d5208a3ba 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -962,6 +962,7 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	size_t worktree_len;
 	int force = 0, dry_run = 0, verbose = 0;
 	int require_force = 1;
+	struct unpack_trees_options o = { 0 };
 
 	struct option builtin_sparse_checkout_clean_options[] = {
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
@@ -990,6 +991,13 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	if (repo_read_index(repo) < 0)
 		die(_("failed to read index"));
 
+	o.verbose_update = verbose;
+	o.update = 0; /* skip modifying the worktree here. */
+	o.head_idx = -1;
+	o.src_index = o.dst_index = repo->index;
+	if (update_sparsity(&o, NULL))
+		warning(_("failed to reapply sparse-checkout patterns"));
+
 	if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY) ||
 	    repo->index->sparse_index == INDEX_EXPANDED)
 		die(_("failed to convert index to a sparse index; resolve merge conflicts and try again"));
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 116ad7c9a20e..4b9078d90a61 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -1104,6 +1104,7 @@ test_expect_success 'clean with staged sparse change' '
 
 	cat >expect <<-\EOF &&
 	Would remove deep/deeper2/
+	Would remove folder1/
 	EOF
 
 	git -C repo sparse-checkout clean --dry-run >out &&
@@ -1115,6 +1116,7 @@ test_expect_success 'clean with staged sparse change' '
 	# deletes deep/deeper2/ but leaves folder1/ and folder2/
 	cat >expect <<-\EOF &&
 	Removing deep/deeper2/
+	Removing folder1/
 	EOF
 
 	# The previous test case checked the -f option, so
@@ -1124,7 +1126,7 @@ test_expect_success 'clean with staged sparse change' '
 	test_cmp expect out &&
 
 	test_path_is_missing repo/deep/deeper2 &&
-	test_path_exists repo/folder1 &&
+	test_path_is_missing repo/folder1 &&
 	test_path_exists repo/folder2
 '
 
@@ -1147,7 +1149,11 @@ test_expect_success 'sparse-checkout operations with merge conflicts' '
 		git commit -a -m "left" &&
 
 		git checkout -b merge &&
-		git sparse-checkout set deep/deeper1 &&
+
+		touch deep/deeper2/extra &&
+		git sparse-checkout set deep/deeper1 2>err &&
+		grep "contains untracked files" err &&
+		test_path_exists deep/deeper2/extra &&
 
 		test_must_fail git merge -m "will-conflict" right &&
 
@@ -1159,15 +1165,19 @@ test_expect_success 'sparse-checkout operations with merge conflicts' '
 		git merge --continue &&
 
 		test_path_exists folder1/even/more/dirs/file &&
+		test_path_exists deep/deeper2/extra &&
+
+		cat >expect <<-\EOF &&
+		Removing deep/deeper2/
+		Removing folder1/
+		EOF
 
 		# clean does not remove the file, because the
 		# SKIP_WORKTREE bit was not cleared by the merge command.
 		git sparse-checkout clean -f >out &&
-		test_line_count = 0 out &&
-		test_path_exists folder1/even/more/dirs/file &&
-
-		git sparse-checkout reapply &&
-		test_path_is_missing folder1
+		test_cmp expect out &&
+		test_path_is_missing folder1 &&
+		test_path_is_missing deep/deeper2
 	)
 '
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 0e9813bddf04..b8814af1b07c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2138,7 +2138,7 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
 	index_state_init(&o->internal.result, o->src_index->repo);
 
 	/* Sanity checks */
-	if (!o->update || o->index_only || o->skip_sparse_checkout)
+	if (o->index_only || o->skip_sparse_checkout)
 		BUG("update_sparsity() is for reflecting sparsity patterns in working directory");
 	if (o->src_index != o->dst_index || o->fn)
 		BUG("update_sparsity() called wrong");
-- 
gitgitgadget
