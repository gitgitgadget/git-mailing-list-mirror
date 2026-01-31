Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564B31329B
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876935; cv=none; b=QuVdTQBm0ReXbWx1K8H/sdg5UM27TRMAQtF6ETcmgmY52siDfPZMsECtpDwr2xZfqtTJT8sucpCwRt6TTj67MbfUZhRzrT9kyRn/FIBFMHHZLc/Uq+8hTzs81OvsNiGUl++WtiVaoVNbAnlk1HLX3zHADHplQxV7QfimfHUYAwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876935; c=relaxed/simple;
	bh=jBhRn+bdP9hCLy4B3QIsGF2E03S4ecDx8EawsEnCe9k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=CmGCg5RgAQVONBwb8eA32CZE1RLhS3iQcwDmufYvbIvH3t4fLFSKRC34s4m1NpyFadlH0Cebo3WShKvq4Z6ptz05UHF7r0C/fYLT6UsdESrScON6/iXIAUh6LNUD6qXdho7kWgtmDTMImvDJzN0MkqF60DKgeSdzMqyiXwgov7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzOvJ83u; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzOvJ83u"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c6aaf3cd62so333129485a.3
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 08:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769876932; x=1770481732; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BmtEUj0GnoisWhqQsjf5/Y8Z+Cm6VifjG/svqEhLMM=;
        b=MzOvJ83ude170ou9f8q1esUrTJ4JFdKUuqvxjLJyjGV/6eMBBZPtym2LAigPuEVMqZ
         Jx8U3YQaECO58Rkg1mg4XSwEeo6JWFbT/pBAUDaGrY1ruElCMMHmZgbuYW60Bui75d/g
         c20RgmUYiinQfHshTzrHZN8j4ECb4xkopim1nYXkc4Nk0TPooaxV/gAS19PPsKIcFRZc
         IlftnjJxcQQxLXGUkpjmyDfLbNDM+GiXAvFP8NwK5ldxmJS/QibldhP078I/PT/DH4c8
         hI8KItUqIpqMw4UTD/kqKoigR1vdMQ7s2+6vUXH5qKghSUYYuAZYuz2dTjs7QQKtleq0
         VXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769876932; x=1770481732;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6BmtEUj0GnoisWhqQsjf5/Y8Z+Cm6VifjG/svqEhLMM=;
        b=b5v4EIy1Samg8c+D6vusgSFstB3Wj30XaTsRVwLosfsEbf+npJnUSE/MHDF34hZfF4
         vnjPaXoUhNwHea/ZoErfkDcH9snG3kyVIv8FGlXrmjQ7/qZUGSfsTgJ8GHXm9+3Tq8XR
         PYi/dCkX/2pxWmMwik9QSt5fYPF/93XvA5iAlV5NZzcCtK/xnBiGE8IXqz/AQSry6r/j
         aRVvahtxQ7M3CRWGVH0Ix2+lgS1zL3E+EwkCJoRn1zo6Cpu0fjlkFmVjG3c1Cf7dCxUw
         KXT4hFppbVKngs4q8XXYzbXbv8LjT7tuFWaY/gYyjY75JzJspWjXZH8yWYh3Fvddo+IB
         +N2w==
X-Gm-Message-State: AOJu0YzUC5wC4HpL3yAirpIq1y63VVLcsSYgDXnP+Xb+KSnLnQsPJWWI
	JkDJTIhxlkBSOY2lPf26ft5J5K7gh+f5553k1//LUxqzjiQD26Xqagp2PJnGHw==
X-Gm-Gg: AZuq6aIvKc+iTL/ixHeyhm1cqv014G2b0KzRFc3vH8RLyXHpXHdzWpCcsxeOWJfNnJX
	LlwLF+9wBkMi72tqYLHPdr4fwjJow6MOhKNh/R2TyvOaColEFs02v6buQ2Y3SA64UjqEcgyIVUy
	ZF4ndb9reCx+YIUwX0JmI2zRs4awEUwyA37GTedG7h2Sc8PkJyanJbJWisVt85fX0u56t9kicoM
	I/Sfj/tJ+qMZFvY7GeKs+Pd/De1nJkqaxzkerl6vP1GCZoGcSbV9B5MWFf7PSjtsU7osGPB3s5V
	+4kG4DWLOVV3ydcWsdHdTjIARuA6+wQAkXJLLtPV4kRLZLYCwBWAb8ogTK1ucqZsUghFzAQA6ot
	JynQAfJf00JKFajhRv9fhGPH64GVTNNgz3O6BYnKZh6R5lJf+mEc7f8aYGof3YjJjf6Up/v7d6K
	qwMwW6/YKOcoTVjm+V7zAHxKMV
X-Received: by 2002:a05:620a:17aa:b0:8c6:b2ce:f46 with SMTP id af79cd13be357-8c9eb1fc03cmr802967585a.14.1769876931757;
        Sat, 31 Jan 2026 08:28:51 -0800 (PST)
Received: from [127.0.0.1] ([135.232.232.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7ba8fsm852285085a.3.2026.01.31.08.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 08:28:51 -0800 (PST)
Message-Id: <pull.2107.v3.git.git.1769876930544.gitgitgadget@gmail.com>
In-Reply-To: <pull.2107.v2.git.git.1763926552033.gitgitgadget@gmail.com>
References: <pull.2107.v2.git.git.1763926552033.gitgitgadget@gmail.com>
From: "Samo =?UTF-8?Q?Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Jan 2026 16:28:50 +0000
Subject: [PATCH v3] shallow: ensure all boundary commits are reachable with
 --shallow-since
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
Cc: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
    =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

When performing a shallow clone based on a date, it is possible for some
declared shallow boundary commits to be unreachable.

The original implementation of the generic shallow boundary finder based
on rev-list marks a commit (from the initial list of boundary candidates)
as shallow as soon as it finds one parent that is not in the initial
candidate list. This can result in a successful shallow clone where some
declared boundary commits are not reachable and therefore do not exist
in the cloned repository.

In such cases, the result contradicts the existing code comment, which
correctly states that boundary commit candidates with a parent in the
same candidate list must not be considered boundary commits.

The added test case 'clone shallow-since all shallows reachable' exposes
the problem. For example:

0. Original repository
   Graph:
   *   e5fbe33 (HEAD -> main) Apr_4th_13:14:15
   |\
   | * 72f5b73 (branch) Apr_3rd_13:14:15
   |/
   * 0ba76c8 Apr_2nd_13:14:15
   * f58ea3a Apr_1st_13:14:15

1. Clone with --shallow-since="2005-04-03 13:14:15"
   Shallows:
     e5fbe33724032807ab2d8636d4c9161f6716882d
     72f5b73c5fec9a728adc42c23de1b87bb5b3ab16
   Graph:
     * e5fbe33 (grafted, HEAD -> main, ...) Apr_4th_13:14:15

   Note that the second shallow commit,
   72f5b73c5fec9a728adc42c23de1b87bb5b3ab16,
   is not reachable.

Update the generic shallow boundary finder to ensure that all shallow
boundary commits are reachable. This is done by inspecting all parents of
each initial boundary candidate. A candidate is marked shallow only if
all of its parents are not in the initial candidate list. Otherwise, the
candidate itself is not marked shallow, but its parents that are not in
the candidate list are marked as boundary commits instead.

With the same example, the corrected behavior results in:

1. Clone with --shallow-since="2005-04-03 13:14:15"
   Shallows:
     72f5b73c5fec9a728adc42c23de1b87bb5b3ab16
     0ba76c8b72273477b59026bea93fcc792bf48747
   Graph:
     *   e5fbe33 (HEAD -> main, ...) Apr_4th_13:14:15
     |\
     | * 72f5b73 (grafted) Apr_3rd_13:14:15
     * 0ba76c8 (grafted) Apr_2nd_13:14:15

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
    Fixed --shallow-since generating descendant borders
    
    When shallow cloning based on a date, it happens that a list of commits
    is received, where some of the list border commits actually descend one
    from another. In such cases borders need to be expanded by additional
    parents and excluding the child as border.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2107%2Fspog%2Ffix-shallow-since-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2107/spog/fix-shallow-since-v3
Pull-Request: https://github.com/git/git/pull/2107

Range-diff vs v2:

 1:  479692c386 ! 1:  34df169b67 shallow: set borders which are all reachable after clone shallow since
     @@ Metadata
      Author: Samo Pogačnik <samo_pogacnik@t-2.net>
      
       ## Commit message ##
     -    shallow: set borders which are all reachable after clone shallow since
     +    shallow: ensure all boundary commits are reachable with --shallow-since
      
     -    When shallow cloning based on a date, it happens that not all
     -    shallow border commits are reachable.
     +    When performing a shallow clone based on a date, it is possible for some
     +    declared shallow boundary commits to be unreachable.
      
     -    Original implementation of a generic shallow boundary finder
     -    based on rev-list sets a commit (from the initial list of border
     -    commit candidates) to be the border commit as soon as it finds one
     -    of its parentis that wasn't on the list of initial candidates. This
     -    results in a successful shallow clone, where some of its declared
     -    border commits may not be reachable and they would not actually exist
     -    in the cloned repository. Thus the result may contradict existing
     -    comment in the code, which correctly states that such commmit should
     -    not be considered border.
     +    The original implementation of the generic shallow boundary finder based
     +    on rev-list marks a commit (from the initial list of boundary candidates)
     +    as shallow as soon as it finds one parent that is not in the initial
     +    candidate list. This can result in a successful shallow clone where some
     +    declared boundary commits are not reachable and therefore do not exist
     +    in the cloned repository.
      
     -    One can inspect such case by running the added test scenario:
     -    - 'clone shallow since all borders reachable'
     +    In such cases, the result contradicts the existing code comment, which
     +    correctly states that boundary commit candidates with a parent in the
     +    same candidate list must not be considered boundary commits.
      
     -    The modified implementation of a generic shallow boundary finder
     -    based on rev-list ensures that all shallow border commits are reachable
     -    also after being grafted. This is achieved by inspecting all parents
     -    of each initial border commit candidate. The border commit candidate
     -    is set border only when all its parents wern't on the initial list of
     -    candidates. Otherwise the border commit candidate is not set as border
     -    however its parents that weren't on the list of candidates are set as
     -    borders.
     +    The added test case 'clone shallow-since all shallows reachable' exposes
     +    the problem. For example:
     +
     +    0. Original repository
     +       Graph:
     +       *   e5fbe33 (HEAD -> main) Apr_4th_13:14:15
     +       |\
     +       | * 72f5b73 (branch) Apr_3rd_13:14:15
     +       |/
     +       * 0ba76c8 Apr_2nd_13:14:15
     +       * f58ea3a Apr_1st_13:14:15
     +
     +    1. Clone with --shallow-since="2005-04-03 13:14:15"
     +       Shallows:
     +         e5fbe33724032807ab2d8636d4c9161f6716882d
     +         72f5b73c5fec9a728adc42c23de1b87bb5b3ab16
     +       Graph:
     +         * e5fbe33 (grafted, HEAD -> main, ...) Apr_4th_13:14:15
     +
     +       Note that the second shallow commit,
     +       72f5b73c5fec9a728adc42c23de1b87bb5b3ab16,
     +       is not reachable.
     +
     +    Update the generic shallow boundary finder to ensure that all shallow
     +    boundary commits are reachable. This is done by inspecting all parents of
     +    each initial boundary candidate. A candidate is marked shallow only if
     +    all of its parents are not in the initial candidate list. Otherwise, the
     +    candidate itself is not marked shallow, but its parents that are not in
     +    the candidate list are marked as boundary commits instead.
     +
     +    With the same example, the corrected behavior results in:
     +
     +    1. Clone with --shallow-since="2005-04-03 13:14:15"
     +       Shallows:
     +         72f5b73c5fec9a728adc42c23de1b87bb5b3ab16
     +         0ba76c8b72273477b59026bea93fcc792bf48747
     +       Graph:
     +         *   e5fbe33 (HEAD -> main, ...) Apr_4th_13:14:15
     +         |\
     +         | * 72f5b73 (grafted) Apr_3rd_13:14:15
     +         * 0ba76c8 (grafted) Apr_2nd_13:14:15
      
          Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
      
       ## shallow.c ##
     +@@ shallow.c: static void show_commit(struct commit *commit, void *data)
     + }
     + 
     + /*
     +- * Given rev-list arguments, run rev-list. All reachable commits
     +- * except border ones are marked with not_shallow_flag. Border commits
     +- * are marked with shallow_flag. The list of border/shallow commits
     +- * are also returned.
     ++ * Given rev-list arguments, run rev-list. All reachable commits except
     ++ * shallow boundary commits are marked with not_shallow_flag.
     ++ * Returned is a list of boundary commits marked with shallow_flag only.
     +  */
     + struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
     + 						    int shallow_flag,
      @@ shallow.c: struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
     - 	 * commit A is processed first, then commit B, whose parent is
     - 	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
     - 	 * itself is considered border at step 2, which is incorrect.
     + 	if (!not_shallow_list)
     + 		die("no commits selected for shallow requests");
     + 
     +-	/* Mark all reachable commits as NOT_SHALLOW */
     ++	/* Mark all reachable (listed) commits as NOT_SHALLOW */
     + 	for (p = not_shallow_list; p; p = p->next)
     + 		p->item->object.flags |= not_shallow_flag;
     + 
     + 	/*
     +-	 * mark border commits SHALLOW + NOT_SHALLOW.
     +-	 * We cannot clear NOT_SHALLOW right now. Imagine border
     +-	 * commit A is processed first, then commit B, whose parent is
     +-	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
     +-	 * itself is considered border at step 2, which is incorrect.
     ++	 * Mark shallow commits from the list as SHALLOW + NOT_SHALLOW.
     ++	 * Do not clear NOT_SHALLOW flags immediately. Consider two listed
     ++	 * commits, B and its parent A, where A is shallow. If A is processed
     ++	 * first and its NOT_SHALLOW flag is cleared immediately, B would later
     ++	 * be incorrectly marked SHALLOW when processed.
     ++	 *
     ++	 * Also, listed commits may have multiple parents, and not all parents
     ++	 * are necessarily listed (as they were not all traversed into the
     ++	 * not_shallow_list from the revs in the first place — not marked
     ++	 * NOT_SHALLOW). Therefore:
      +	 *
     -+	 * We must also consider that B has multiple parents which may
     -+	 * not all be marked NOT_SHALLOW (as they weren't traversed into
     -+	 * the not_shallow_list from revs in the first place). Because of
     -+	 * that an additional step is required to reconsider B as border.
     -+	 * A commit from the not_shallow_list is considered border only
     -+	 * when ALL its parents weren't on the not_shallow_list.
     -+	 * When one or more parents of a commit from the not_shellow_list
     -+	 * also come from that list, the commit is not considered border,
     -+	 * but its non-listed parents are considered border commits.
     ++	 * - A listed commit is marked SHALLOW only if none of its parents are
     ++	 *   listed.
     ++	 * - If at least one parent of a listed commit is also listed, the
     ++	 *   commit itself is not marked SHALLOW; however, any of its non-listed
     ++	 *   parents are marked SHALLOW.
      +	 *
     -+	 * The general processing goes like this:
     -+	 * 1. Above we've painted the whole not_shallow_list of commits
     -+	 *    NOT_SHALLOW.
     -+	 * 2. For each commit from the not_shallow_list (the code below)
     -+	 *    we paint SHALLOW this commit and its parent for all its
     -+	 *    parents that had not yet been painted NOT_SHALLOW.
     -+	 * 3. Commits with all parents being painted only SHALLOW remain
     -+	 *    shallow and are being added to result list.
     -+	 * 4. Commits without all parents being painted only SHALLOW are
     -+	 *    being excluded as borders, however their parents painted only
     -+	 *    SHALLOW are being added to the result borders list.
     ++	 * Processing overview:
     ++	 * 1. All listed commits have already been marked NOT_SHALLOW are not
     ++	 *    cleared until all shallow commits have been identified.
     ++	 *
     ++	 * 2. For each listed commit:
     ++	 *    - Mark the commit SHALLOW if it has any parent that is not listed.
     ++	 *    - Mark all non-listed parents as SHALLOW.
     ++	 *    - If the commit has at least one listed parent, it is excluded
     ++	 *      from the shallow result; however its parents marked only SHALLOW
     ++	 *      are added instead.
     ++	 *    - If all parents are marked only SHALLOW, the commit remains SHALLOW
     ++	 *      and is added to the shallow result.
       	 */
       	for (p = not_shallow_list; p; p = p->next) {
       		struct commit *c = p->item;
     @@ shallow.c: struct commit_list *get_shallow_commits_by_rev_list(struct strvec *ar
       		if (repo_parse_commit(the_repository, c))
       			die("unable to parse commit %s",
       			    oid_to_hex(&c->object.oid));
     ++		if (!c->parents)
     ++			continue;
       
       		for (parent = c->parents; parent; parent = parent->next)
      -			if (!(parent->item->object.flags & not_shallow_flag)) {
     @@ shallow.c: struct commit_list *get_shallow_commits_by_rev_list(struct strvec *ar
      -				break;
      +				parent->item->object.flags |= shallow_flag;
       			}
     ++
      +		if (must_not_be_shallow) {
      +			c->object.flags &= ~shallow_flag;
      +			for (parent = c->parents; parent; parent = parent->next)
     -+				if (parent->item->object.flags & shallow_flag) {
     -+					parent->item->object.flags |= not_shallow_flag;
     ++				if ((parent->item->object.flags & shallow_flag) &&
     ++				    !(parent->item->object.flags & not_shallow_flag))
      +					commit_list_insert(parent->item, &result);
     -+				}
      +		} else {
      +			for (parent = c->parents; parent; parent = parent->next)
      +				parent->item->object.flags &= ~shallow_flag;
     @@ shallow.c: struct commit_list *get_shallow_commits_by_rev_list(struct strvec *ar
       	}
       	free_commit_list(not_shallow_list);
       
     + 	/*
     +-	 * Now we can clean up NOT_SHALLOW on border commits. Having
     ++	 * Now we can clean up NOT_SHALLOW on shallow commits. Having
     + 	 * both flags set can confuse the caller.
     + 	 */
     + 	for (p = result; p; p = p->next) {
      
       ## t/t5500-fetch-pack.sh ##
      @@ t/t5500-fetch-pack.sh: test_expect_success 'shallow since with commit graph and already-seen commit' '
       	)
       '
       
     -+test_expect_success 'clone shallow since all borders reachable' '
     -+	test_create_repo shallow-since-all-borders-reachable &&
     ++test_expect_success 'clone shallow-since all shallows reachable' '
     ++	test_create_repo shallow-since-all-shallows-reachable &&
      +	(
     -+	rm -rf shallow123 &&
     -+	cd shallow-since-all-borders-reachable &&
     -+	GIT_COMMITTER_DATE="2025-08-19 12:34:56" git commit --allow-empty -m one &&
     -+	GIT_COMMITTER_DATE="2025-08-20 12:34:56" git switch -c branch &&
     -+	GIT_COMMITTER_DATE="2025-08-21 12:34:56" git commit --allow-empty -m two &&
     -+	GIT_COMMITTER_DATE="2025-08-22 12:34:56" git commit --allow-empty -m three &&
     -+	GIT_COMMITTER_DATE="2025-08-23 12:34:56" git switch main &&
     -+	GIT_COMMITTER_DATE="2025-08-24 12:34:56" git merge branch --no-ff &&
     -+	GIT_COMMITTER_DATE="2025-08-26 12:34:56" git clone --shallow-since "2025-08-21 12:34:56" "file://$(pwd)/." ../shallow123 &&
     -+	cd ../shallow123 &&
     -+	echo "Shallow borders:" &&
     -+	cat .git/shallow &&
     -+	$(for commit in $(cat .git/shallow); do git rev-list $commit 1>/dev/null || exit 1; done)
     ++		rm -rf shallow123 &&
     ++		cd shallow-since-all-shallows-reachable &&
     ++		GIT_COMMITTER_DATE="2005-04-01 13:14:15" git commit --allow-empty -m Apr_1st &&
     ++		GIT_COMMITTER_DATE="2005-04-02 13:14:15" git commit --allow-empty -m Apr_2nd &&
     ++		GIT_COMMITTER_DATE="2005-04-03 13:14:15" git switch -c branch &&
     ++		GIT_COMMITTER_DATE="2005-04-03 13:14:15" git commit --allow-empty -m Apr_3rd &&
     ++		GIT_COMMITTER_DATE="2005-04-04 13:14:15" git switch main &&
     ++		GIT_COMMITTER_DATE="2005-04-04 13:14:15" git merge branch --no-ff -m Apr_4th &&
     ++		git clone --shallow-since "2005-04-03 13:14:15" "file://$(pwd)/." ../shallow123 &&
     ++		cd ../shallow123 &&
     ++		for commit in $(cat .git/shallow 2> /dev/null)
     ++		do
     ++			git rev-list $commit 1>/dev/null || exit 1
     ++		done
      +	)
      +'
      +


 shallow.c             | 67 ++++++++++++++++++++++++++++++++++---------
 t/t5500-fetch-pack.sh | 20 +++++++++++++
 2 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/shallow.c b/shallow.c
index 55b9cd9d3f..cd99e5777f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -208,10 +208,9 @@ static void show_commit(struct commit *commit, void *data)
 }
 
 /*
- * Given rev-list arguments, run rev-list. All reachable commits
- * except border ones are marked with not_shallow_flag. Border commits
- * are marked with shallow_flag. The list of border/shallow commits
- * are also returned.
+ * Given rev-list arguments, run rev-list. All reachable commits except
+ * shallow boundary commits are marked with not_shallow_flag.
+ * Returned is a list of boundary commits marked with shallow_flag only.
  */
 struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
 						    int shallow_flag,
@@ -241,36 +240,76 @@ struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
 	if (!not_shallow_list)
 		die("no commits selected for shallow requests");
 
-	/* Mark all reachable commits as NOT_SHALLOW */
+	/* Mark all reachable (listed) commits as NOT_SHALLOW */
 	for (p = not_shallow_list; p; p = p->next)
 		p->item->object.flags |= not_shallow_flag;
 
 	/*
-	 * mark border commits SHALLOW + NOT_SHALLOW.
-	 * We cannot clear NOT_SHALLOW right now. Imagine border
-	 * commit A is processed first, then commit B, whose parent is
-	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
-	 * itself is considered border at step 2, which is incorrect.
+	 * Mark shallow commits from the list as SHALLOW + NOT_SHALLOW.
+	 * Do not clear NOT_SHALLOW flags immediately. Consider two listed
+	 * commits, B and its parent A, where A is shallow. If A is processed
+	 * first and its NOT_SHALLOW flag is cleared immediately, B would later
+	 * be incorrectly marked SHALLOW when processed.
+	 *
+	 * Also, listed commits may have multiple parents, and not all parents
+	 * are necessarily listed (as they were not all traversed into the
+	 * not_shallow_list from the revs in the first place — not marked
+	 * NOT_SHALLOW). Therefore:
+	 *
+	 * - A listed commit is marked SHALLOW only if none of its parents are
+	 *   listed.
+	 * - If at least one parent of a listed commit is also listed, the
+	 *   commit itself is not marked SHALLOW; however, any of its non-listed
+	 *   parents are marked SHALLOW.
+	 *
+	 * Processing overview:
+	 * 1. All listed commits have already been marked NOT_SHALLOW are not
+	 *    cleared until all shallow commits have been identified.
+	 *
+	 * 2. For each listed commit:
+	 *    - Mark the commit SHALLOW if it has any parent that is not listed.
+	 *    - Mark all non-listed parents as SHALLOW.
+	 *    - If the commit has at least one listed parent, it is excluded
+	 *      from the shallow result; however its parents marked only SHALLOW
+	 *      are added instead.
+	 *    - If all parents are marked only SHALLOW, the commit remains SHALLOW
+	 *      and is added to the shallow result.
 	 */
 	for (p = not_shallow_list; p; p = p->next) {
 		struct commit *c = p->item;
 		struct commit_list *parent;
+		int must_not_be_shallow = 0;
 
 		if (repo_parse_commit(the_repository, c))
 			die("unable to parse commit %s",
 			    oid_to_hex(&c->object.oid));
+		if (!c->parents)
+			continue;
 
 		for (parent = c->parents; parent; parent = parent->next)
-			if (!(parent->item->object.flags & not_shallow_flag)) {
+			if (parent->item->object.flags & not_shallow_flag) {
+				must_not_be_shallow = 1;
+			} else {
 				c->object.flags |= shallow_flag;
-				commit_list_insert(c, &result);
-				break;
+				parent->item->object.flags |= shallow_flag;
 			}
+
+		if (must_not_be_shallow) {
+			c->object.flags &= ~shallow_flag;
+			for (parent = c->parents; parent; parent = parent->next)
+				if ((parent->item->object.flags & shallow_flag) &&
+				    !(parent->item->object.flags & not_shallow_flag))
+					commit_list_insert(parent->item, &result);
+		} else {
+			for (parent = c->parents; parent; parent = parent->next)
+				parent->item->object.flags &= ~shallow_flag;
+			commit_list_insert(c, &result);
+		}
 	}
 	free_commit_list(not_shallow_list);
 
 	/*
-	 * Now we can clean up NOT_SHALLOW on border commits. Having
+	 * Now we can clean up NOT_SHALLOW on shallow commits. Having
 	 * both flags set can confuse the caller.
 	 */
 	for (p = result; p; p = p->next) {
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 2677cd5faa..44e274281a 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -904,6 +904,26 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	)
 '
 
+test_expect_success 'clone shallow-since all shallows reachable' '
+	test_create_repo shallow-since-all-shallows-reachable &&
+	(
+		rm -rf shallow123 &&
+		cd shallow-since-all-shallows-reachable &&
+		GIT_COMMITTER_DATE="2005-04-01 13:14:15" git commit --allow-empty -m Apr_1st &&
+		GIT_COMMITTER_DATE="2005-04-02 13:14:15" git commit --allow-empty -m Apr_2nd &&
+		GIT_COMMITTER_DATE="2005-04-03 13:14:15" git switch -c branch &&
+		GIT_COMMITTER_DATE="2005-04-03 13:14:15" git commit --allow-empty -m Apr_3rd &&
+		GIT_COMMITTER_DATE="2005-04-04 13:14:15" git switch main &&
+		GIT_COMMITTER_DATE="2005-04-04 13:14:15" git merge branch --no-ff -m Apr_4th &&
+		git clone --shallow-since "2005-04-03 13:14:15" "file://$(pwd)/." ../shallow123 &&
+		cd ../shallow123 &&
+		for commit in $(cat .git/shallow 2> /dev/null)
+		do
+			git rev-list $commit 1>/dev/null || exit 1
+		done
+	)
+'
+
 test_expect_success 'shallow clone exclude tag two' '
 	test_create_repo shallow-exclude &&
 	(

base-commit: debbc87557487aa9a8ed8a35367d17f8b4081c76
-- 
gitgitgadget
