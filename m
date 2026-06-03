Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62064385503
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482442; cv=none; b=d3K5w1JwUv3PjEBdeZHahVyrZ9vhoR5DywXrjiswwMYZ2PPtw64g43pPdrackhsQt2GYy6jN8L+kot4LbXdEkPWHlqGk9R+D6J32olNBP8mfW9BG8jeyYeJsLZmhcB4SVSQFwoQujnEKsAnSGGEjwObicAWmvPr0/7pmDtO3nhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482442; c=relaxed/simple;
	bh=t6CEvP5ZSl9v8Vq1hUe65uxqWFRs/G7vgd3RZJvYcCQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aWOpIIY15uhgaOax/GIE3tj2KSQh0F55+aBFi1hybWHY08d1MWsBWWUDzod+0Dst+12MlbUfSy1PVpxlVbWhsO3wp3LMIwOqakTrvL3Fqa9WRwZM3vYB7O9m0Zjxu34IzjIL1qHS+HS9vzO3NJCkJv84IgkNKJfUwP43BVrFW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3tsJHyQ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3tsJHyQ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-516d0db9372so109126061cf.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 03:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780482439; x=1781087239; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkc+Xuk8HBoysuafwUprJNvelXl2YgHyvaqwmhtKo98=;
        b=J3tsJHyQphwyA3CrcfXZ74Tdsak15zEKu5uJ12juqfIzC9z/JW5zXEFQPJp234GwLL
         NuV0wE27YJNOI7DSNFHFDQZI3NoNusmGVsuNqmmLkXmw1jyKgCLHL9NwpxYPCfKZKwpf
         iJx5DdJtOEDTd7QFonf0a2YO1JnMbxfLYauMLi3zGLDLXdipO6uuNvu64EdsbmeX7RIK
         BGnFjj/78cLwM6Bru3QHRfjNz15ZvhN28dXP2wM18nCG2hbdYagWRPm6hxS3ChkBCXrx
         xNW7rjED5YeqdT3KplM1nnX6020VQl5OpvMY/L+8OfGyT6er+OGrrjvBfYaF0dSP8jsT
         8GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780482439; x=1781087239;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mkc+Xuk8HBoysuafwUprJNvelXl2YgHyvaqwmhtKo98=;
        b=Qnq+w9MT3FIciCtNXir7gNIOLc32jmRUjb48+jdzW3gHKT9YJ4wVN+72cdNEvyX0lt
         LHo5ibH4oQ1V9a5/0tt+mCEslCUVNDdiN0ODFBYqZMVQi7l443pvhG99rQbIWkQMtycL
         0lp7mcRcchrj45UEJBncGGpG/NEhRKNN/L7Ph9ZJUetC4xtlOhSdwx/w3JOMcRm3QQ5s
         Q6wrt4gz7TLRxLq7rNoXRZaYothzXMl63ThzNj0oTSBVnXB0iCNsdgEx1qiNaTVF+51h
         JvQjy8dAcl+JqtefD4J2iMI/Yh12d/6NmQ4JEWDWjRiuDcavJTZ6iL4j1B5UmZNpEtUa
         VEgw==
X-Gm-Message-State: AOJu0YzokDpCnBLpT1NxBwpLgInTpExRU0+mzM7bW9DQQPwMgR+eH1KM
	6FXNXKnVEMwGQmj3cUX4JXdWl4GccBLz24tWyL619n69+/JxqZSODxMoQ2C7ag==
X-Gm-Gg: Acq92OFRewlglW/c06EekzGBSrTdodsXKGFLOX7jF4jz9F7JmCCbvKLOAvgAewH7LZJ
	wGKwUW6sHfthDL1Wk53cG68lVaA0IGmW4f37+R9st5/kRg2dmxi6tWD0eATb6i7XDSRhSziVPAv
	cP1bfKu9lhd3pBqSd9rs2S+WahhJZxiI4jmrNhg/iwO+3SIZ+VW6GArH6Su3JwHjLRkFKl5bfTR
	z/td2TMvjWXT0SUL4d5mm5oRuibd6bLpRbHNRO6iYZwXkHAYJh1PuLSIDmgTIKhtmD+810eEOK+
	PtmC3hxg9DMBkZUwIgooHtbkxWZItRkxME2YkDgmXbQNeO3NjBKN+4pNfS8QGr0/kUY3njLb0o6
	9xDpr3qfa6LLqHFApxcFdy38WbAnQTml0KOHRg79dQqyJ1svdpRiDM4nEvQS3kMYwjuWXDWwO+M
	ORkzKOfI9BMaqK3zXLddjbBdN0yd2/7/AYMgKX3w==
X-Received: by 2002:a05:622a:8f08:b0:516:e3fc:ed8 with SMTP id d75a77b69052e-51778730096mr29591581cf.46.1780482439191;
        Wed, 03 Jun 2026 03:27:19 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.55.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775da2c56sm19489461cf.21.2026.06.03.03.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:27:18 -0700 (PDT)
Message-Id: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
In-Reply-To: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
References: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
From: "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jun 2026 10:27:16 +0000
Subject: [PATCH v2] rebase: skip branch symref aliases
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Son Luong Ngoc <sluongng@gmail.com>,
    Son Luong Ngoc <sluongng@gmail.com>

From: Son Luong Ngoc <sluongng@gmail.com>

git rebase --update-refs can fail after the normal rebase path has
updated the current branch when another local branch is a symref to it.
This can happen during a default-branch rename where refs/heads/main
points at refs/heads/master while users migrate.

The sequencer queues update-ref commands from local branch decorations.
Commit 106b6885c7 (rebase: ignore non-branch update-refs) filters out
decorations that are not local branches, such as HEAD and tags. A branch
symref is different: it is still a local branch decoration, but if it
resolves to another branch then that target branch is itself present in
the decoration list and will be updated as a concrete branch.

Skip branch decorations whose symrefs resolve to refs/heads/*, because
those targets are already represented by concrete branch decorations.
This prevents aliases from scheduling a second update for the same
branch. Keep symrefs to non-branch targets on the existing path.

Preserve the existing checked-out branch handling before applying these
skips. Such refs still need a todo-list comment instead of an update-ref
command, even when the checked-out ref is the branch being rebased or a
branch symref alias. Use a copy of the resolved HEAD ref so later ref
resolution does not overwrite it.

Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
    rebase: handle --update-refs branch symrefs
    
    Changes since v1:
    
     * Squashed the regression test and fix into a single patch.
     * Reworked the implementation per Phillip's review: skip local branch
       symrefs that are not checked out when their targets resolve to
       refs/heads/*, while preserving the existing behavior for symrefs to
       non-branch targets.
     * Preserved checked-out branch comments before applying the new symref
       skip, so worktrees still get the existing todo-list warning instead
       of an update-ref command.
     * Folded the symref coverage into the existing "--update-refs updates
       refs correctly" test, covering both an alias of HEAD and an alias of
       another branch.
     * Kept the relationship to 106b6885c7 in the commit message: non-local
       decorations are already filtered, and this patch handles the
       remaining local branch decorations that are symref aliases.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2126%2Fsluongng%2Fsl%2Frebase-update-refs-symrefs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2126/sluongng/sl/rebase-update-refs-symrefs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2126

Range-diff vs v1:

 1:  a550923440 < -:  ---------- t3404: add failing branch symref test
 2:  0ab0a71744 ! 1:  68f698225c rebase: skip branch symref aliases
     @@ Metadata
       ## Commit message ##
          rebase: skip branch symref aliases
      
     -    rebase --update-refs records local branch decorations before replaying
     -    commits. If a decoration is a symbolic branch such as refs/heads/main
     -    pointing at refs/heads/master, updating it later dereferences back to
     -    master and can fail because the normal rebase path already moved that
     -    branch.
     +    git rebase --update-refs can fail after the normal rebase path has
     +    updated the current branch when another local branch is a symref to it.
     +    This can happen during a default-branch rename where refs/heads/main
     +    points at refs/heads/master while users migrate.
      
     -    Resolve local branch symref decorations to their referents before
     -    queuing update-ref commands, and skip duplicates. This keeps branch
     -    aliases from scheduling a second update for the same underlying branch
     -    while still using the existing old-OID check for the single queued
     -    update.
     +    The sequencer queues update-ref commands from local branch decorations.
     +    Commit 106b6885c7 (rebase: ignore non-branch update-refs) filters out
     +    decorations that are not local branches, such as HEAD and tags. A branch
     +    symref is different: it is still a local branch decoration, but if it
     +    resolves to another branch then that target branch is itself present in
     +    the decoration list and will be updated as a concrete branch.
     +
     +    Skip branch decorations whose symrefs resolve to refs/heads/*, because
     +    those targets are already represented by concrete branch decorations.
     +    This prevents aliases from scheduling a second update for the same
     +    branch. Keep symrefs to non-branch targets on the existing path.
     +
     +    Preserve the existing checked-out branch handling before applying these
     +    skips. Such refs still need a todo-list comment instead of an update-ref
     +    command, even when the checked-out ref is the branch being rebased or a
     +    branch symref alias. Use a copy of the resolved HEAD ref so later ref
     +    resolution does not overwrite it.
      
          Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
      
     @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
       	const struct name_decoration *decoration = get_name_decoration(&commit->object);
      -	const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
      -						       "HEAD",
     -+	struct ref_store *refs = get_main_ref_store(the_repository);
     -+	const char *head_ref = refs_resolve_ref_unsafe(refs, "HEAD",
     - 						       RESOLVE_REF_READING,
     +-						       RESOLVE_REF_READING,
      -						       NULL,
      -						       NULL);
     -+						       NULL, NULL);
     -+	char *resolved_head_ref = refs_resolve_refdup(refs, "HEAD",
     -+						       RESOLVE_REF_READING,
     -+						       NULL, NULL);
     -+	struct strbuf update_ref = STRBUF_INIT;
     ++	struct ref_store *refs = get_main_ref_store(the_repository);
     ++	char *head_ref = refs_resolve_refdup(refs, "HEAD",
     ++					     RESOLVE_REF_READING,
     ++					     NULL, NULL);
       
       	while (decoration) {
       		struct todo_item *item;
       		const char *path;
     -+		const char *ref = decoration->name;
      +		const char *resolved_ref;
     -+		int is_symref = 0;
      +		int flags = 0;
       		size_t base_offset = ctx->buf->len;
       
       		/*
     -@@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
     - 		 * updated by the default rebase behavior.
     - 		 * Exclude it from the list of refs to update,
     - 		 * as well as any non-branch decorations.
     -+		 *
     -+		 * Resolve branch symrefs after checking for the current HEAD so
     -+		 * that aliases do not schedule duplicate updates for their
     -+		 * referents.
     -+		 *
     +-		 * If the branch is the current HEAD, then it will be
     +-		 * updated by the default rebase behavior.
     +-		 * Exclude it from the list of refs to update,
     +-		 * as well as any non-branch decorations.
       		 * Non-branch decorations may be present if the pretty format
       		 * includes "%d", which would have loaded all refs
       		 * into the global decoration table.
     @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
      +			continue;
      +		}
      +
     -+		if (head_ref && !strcmp(head_ref, ref)) {
     ++		path = branch_checked_out(decoration->name);
     ++
     ++		/*
     ++		 * If the branch is the current HEAD, then it will be
     ++		 * updated by the default rebase behavior. Exclude it from
     ++		 * the list of refs to update, unless it is checked out and
     ++		 * needs a comment in the todo list.
     ++		 */
     ++		if (!path && head_ref && !strcmp(head_ref, decoration->name)) {
      +			decoration = decoration->next;
      +			continue;
      +		}
      +
     -+		strbuf_reset(&update_ref);
     -+		resolved_ref = refs_resolve_ref_unsafe(refs, ref,
     -+						       RESOLVE_REF_READING |
     -+						       RESOLVE_REF_NO_RECURSE,
     ++		resolved_ref = refs_resolve_ref_unsafe(refs, decoration->name,
     ++						       RESOLVE_REF_READING,
      +						       NULL, &flags);
     -+		if ((flags & REF_ISSYMREF) && resolved_ref) {
     -+			if (!starts_with(resolved_ref, "refs/heads/")) {
     -+				decoration = decoration->next;
     -+				continue;
     -+			}
     -+
     -+			strbuf_addstr(&update_ref, resolved_ref);
     -+			ref = update_ref.buf;
     -+			is_symref = 1;
     -+		}
     -+
     -+		if ((is_symref && resolved_head_ref &&
     -+		     !strcmp(resolved_head_ref, ref)) ||
     -+		    string_list_has_string(&ctx->refs_to_oids, ref)) {
     ++		if (!path && resolved_ref && (flags & REF_ISSYMREF) &&
     ++		    starts_with(resolved_ref, "refs/heads/")) {
       			decoration = decoration->next;
       			continue;
       		}
     @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
       
       		/* If the branch is checked out, then leave a comment instead. */
      -		if ((path = branch_checked_out(decoration->name))) {
     -+		if ((path = branch_checked_out(ref))) {
     ++		if (path) {
       			item->command = TODO_COMMENT;
       			strbuf_commented_addf(ctx->buf, comment_line_str,
       					      "Ref %s checked out at '%s'\n",
     --					      decoration->name, path);
     -+					      ref, path);
     - 		} else {
     - 			struct string_list_item *sti;
     - 			item->command = TODO_UPDATE_REF;
     --			strbuf_addf(ctx->buf, "%s\n", decoration->name);
     -+			strbuf_addf(ctx->buf, "%s\n", ref);
     - 
     - 			sti = string_list_insert(&ctx->refs_to_oids,
     --						 decoration->name);
     --			sti->util = init_update_ref_record(decoration->name);
     -+						 ref);
     -+			sti->util = init_update_ref_record(ref);
     - 		}
     - 
     - 		item->offset_in_buf = base_offset;
      @@ sequencer.c: static int add_decorations_to_list(const struct commit *commit,
       		decoration = decoration->next;
       	}
       
     -+	strbuf_release(&update_ref);
     -+	free(resolved_head_ref);
     ++	free(head_ref);
       	return 0;
       }
       
      
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs ignores non-branch decorations' '
     - 	test_cmp expect actual
       '
       
     --test_expect_failure '--update-refs skips branch symrefs to current branch' '
     -+test_expect_success '--update-refs skips branch symrefs to current branch' '
     - 	test_when_finished "
     - 		test_might_fail git rebase --abort &&
     - 		git checkout primary &&
     + test_expect_success '--update-refs updates refs correctly' '
     ++	test_when_finished "
     ++		test_might_fail git symbolic-ref -d refs/heads/no-conflict-branch-alias &&
     ++		test_might_fail git symbolic-ref -d refs/heads/second-alias
     ++	" &&
     + 	git checkout -B update-refs no-conflict-branch &&
     + 	git branch -f base HEAD~4 &&
     + 	git branch -f first HEAD~3 &&
     + 	git branch -f second HEAD~3 &&
     + 	git branch -f third HEAD~1 &&
     ++	git symbolic-ref refs/heads/no-conflict-branch-alias \
     ++		refs/heads/no-conflict-branch &&
     ++	git symbolic-ref refs/heads/second-alias refs/heads/second &&
     + 	test_commit extra2 fileX &&
     + 	git commit --amend --fixup=L &&
     + 
     +@@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs updates refs correctly' '
     + 
     + 	test_cmp_rev HEAD~3 refs/heads/first &&
     + 	test_cmp_rev HEAD~3 refs/heads/second &&
     ++	test_cmp_rev HEAD~3 refs/heads/second-alias &&
     + 	test_cmp_rev HEAD~1 refs/heads/third &&
     + 	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
     ++	test_cmp_rev HEAD refs/heads/no-conflict-branch-alias &&
     ++	test_write_lines refs/heads/no-conflict-branch >expect &&
     ++	git symbolic-ref refs/heads/no-conflict-branch-alias >actual &&
     ++	test_cmp expect actual &&
     ++	test_write_lines refs/heads/second >expect &&
     ++	git symbolic-ref refs/heads/second-alias >actual &&
     ++	test_cmp expect actual &&
     + 
     + 	q_to_tab >expect <<-\EOF &&
     + 	Successfully rebased and updated refs/heads/update-refs.


 sequencer.c                   | 43 +++++++++++++++++++++++++----------
 t/t3404-rebase-interactive.sh | 15 ++++++++++++
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1ee4b2875b..6ab8b47108 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6445,28 +6445,46 @@ static int add_decorations_to_list(const struct commit *commit,
 				   struct todo_add_branch_context *ctx)
 {
 	const struct name_decoration *decoration = get_name_decoration(&commit->object);
-	const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						       "HEAD",
-						       RESOLVE_REF_READING,
-						       NULL,
-						       NULL);
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	char *head_ref = refs_resolve_refdup(refs, "HEAD",
+					     RESOLVE_REF_READING,
+					     NULL, NULL);
 
 	while (decoration) {
 		struct todo_item *item;
 		const char *path;
+		const char *resolved_ref;
+		int flags = 0;
 		size_t base_offset = ctx->buf->len;
 
 		/*
-		 * If the branch is the current HEAD, then it will be
-		 * updated by the default rebase behavior.
-		 * Exclude it from the list of refs to update,
-		 * as well as any non-branch decorations.
 		 * Non-branch decorations may be present if the pretty format
 		 * includes "%d", which would have loaded all refs
 		 * into the global decoration table.
 		 */
-		if ((head_ref && !strcmp(head_ref, decoration->name)) ||
-		    (decoration->type != DECORATION_REF_LOCAL)) {
+		if (decoration->type != DECORATION_REF_LOCAL) {
+			decoration = decoration->next;
+			continue;
+		}
+
+		path = branch_checked_out(decoration->name);
+
+		/*
+		 * If the branch is the current HEAD, then it will be
+		 * updated by the default rebase behavior. Exclude it from
+		 * the list of refs to update, unless it is checked out and
+		 * needs a comment in the todo list.
+		 */
+		if (!path && head_ref && !strcmp(head_ref, decoration->name)) {
+			decoration = decoration->next;
+			continue;
+		}
+
+		resolved_ref = refs_resolve_ref_unsafe(refs, decoration->name,
+						       RESOLVE_REF_READING,
+						       NULL, &flags);
+		if (!path && resolved_ref && (flags & REF_ISSYMREF) &&
+		    starts_with(resolved_ref, "refs/heads/")) {
 			decoration = decoration->next;
 			continue;
 		}
@@ -6478,7 +6496,7 @@ static int add_decorations_to_list(const struct commit *commit,
 		memset(item, 0, sizeof(*item));
 
 		/* If the branch is checked out, then leave a comment instead. */
-		if ((path = branch_checked_out(decoration->name))) {
+		if (path) {
 			item->command = TODO_COMMENT;
 			strbuf_commented_addf(ctx->buf, comment_line_str,
 					      "Ref %s checked out at '%s'\n",
@@ -6501,6 +6519,7 @@ static int add_decorations_to_list(const struct commit *commit,
 		decoration = decoration->next;
 	}
 
+	free(head_ref);
 	return 0;
 }
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 58b3bb0c27..bc0b6a31f7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1979,11 +1979,18 @@ test_expect_success '--update-refs ignores non-branch decorations' '
 '
 
 test_expect_success '--update-refs updates refs correctly' '
+	test_when_finished "
+		test_might_fail git symbolic-ref -d refs/heads/no-conflict-branch-alias &&
+		test_might_fail git symbolic-ref -d refs/heads/second-alias
+	" &&
 	git checkout -B update-refs no-conflict-branch &&
 	git branch -f base HEAD~4 &&
 	git branch -f first HEAD~3 &&
 	git branch -f second HEAD~3 &&
 	git branch -f third HEAD~1 &&
+	git symbolic-ref refs/heads/no-conflict-branch-alias \
+		refs/heads/no-conflict-branch &&
+	git symbolic-ref refs/heads/second-alias refs/heads/second &&
 	test_commit extra2 fileX &&
 	git commit --amend --fixup=L &&
 
@@ -1991,8 +1998,16 @@ test_expect_success '--update-refs updates refs correctly' '
 
 	test_cmp_rev HEAD~3 refs/heads/first &&
 	test_cmp_rev HEAD~3 refs/heads/second &&
+	test_cmp_rev HEAD~3 refs/heads/second-alias &&
 	test_cmp_rev HEAD~1 refs/heads/third &&
 	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
+	test_cmp_rev HEAD refs/heads/no-conflict-branch-alias &&
+	test_write_lines refs/heads/no-conflict-branch >expect &&
+	git symbolic-ref refs/heads/no-conflict-branch-alias >actual &&
+	test_cmp expect actual &&
+	test_write_lines refs/heads/second >expect &&
+	git symbolic-ref refs/heads/second-alias >actual &&
+	test_cmp expect actual &&
 
 	q_to_tab >expect <<-\EOF &&
 	Successfully rebased and updated refs/heads/update-refs.

base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
-- 
gitgitgadget
