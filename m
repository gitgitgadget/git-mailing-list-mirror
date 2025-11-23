Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DF18C332
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763926558; cv=none; b=QL1ltLiql6+c5GCFms4S78h7S9U/4Gcj1YXiwqD9HHbnDbCrCejZ0v/mwc8uGDIp0aUFvuUt6MtYfqmklwRwx9BQGDXnSYcnoip+7+Y38W3IrBEt8ZpAAv/qs4+ZAzZXNO9Jgb7jOA9kZo97vFGTWvVLF2QMyNlT/8aWdSvRNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763926558; c=relaxed/simple;
	bh=Q64tUhDi5avUEmW0n7Tcb+6rYSmQQ5+Gg5imNSSkHJE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=cK60KwmDQ7AQnWdyR8J+ADN8oska6C+Sb9NzqBE0IFChVAfPhyqRekIOwtUUFSGKSAMc8Nh3yPxzvYqsPEMW67iBnGr2k/92R5PEFWeZJksgfPlddmsRW8G9oQsDluji4M9VxXa8WYwh+tDftaB4xymwprJPr4TSWLm5+GvQc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkD8Y0U/; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkD8Y0U/"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b22b1d3e7fso376195185a.3
        for <git@vger.kernel.org>; Sun, 23 Nov 2025 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763926554; x=1764531354; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+uev4kb+70Wk8fZxu/EbRZAzWVQrXzrM8Rx8EpUNxI=;
        b=hkD8Y0U/mKsdZ8MSrcmh3TPVScoStvP9PmYMCZXkLqOsFpXTzTGCxV644I+OufX4AW
         2/80lGU2SJUQ4G+d/fbrI3NZgRteZWczpE/pM+2THc+yIqFeLuKSyQPLk+KQwh1CHUt8
         YzSywyU3Ksm7/lEX1mx3Q+D6Nry6BGmpE0GTpwf5HFOPqaUaR1Xc4M7ndCGuZbHPeRDb
         vq3z3L326Bc8fAecK28ZzankGvvF5wgZfprMuOoJEAPUuBpGW0pfD0/agiISvavYr01F
         7MZ0+6Nf04ljjF9BszbMgoORRwRwAXbtIlGMP7hMJZ4X4YuFGahAM1+WpuZlCP3gib7n
         zr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763926554; x=1764531354;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y+uev4kb+70Wk8fZxu/EbRZAzWVQrXzrM8Rx8EpUNxI=;
        b=JZb9Qx27nhzKhJkd9vXdPY6SfvfW1ODgltH1miO5KxwzkyF2i39jbN8HJ9D3rS2qdv
         Ug9qM0kvGoXCBmGmwPgwdaqz6qV0DhqppPpAcM95FUPjx+d9mBzz0wpP+5G6N1jAcTwG
         jnu3jDKJlMZbZzRlf4kwF7I0Z9YY7Ynljr2sJbfMmRzgEkI4wq+OkN+mL0C5lZQ4SuA6
         xQ7lHgwS9HkCrUr2AUi3e9/Cvqx906a/wJfXKA0dwjl4BDMqXakUV0MwY+PIUSx8Tbcr
         759cOMAnkxI9/r0FQ1tBicxgBiFCM1JyEVZbAdvtwjnfOF+ID7snF4Jgm7QkmqwKkjU8
         JrEg==
X-Gm-Message-State: AOJu0Yx1BcLxFxjMZcuu1842gV7yqVxfr1WwCDIk9SqcfybSRApFBZzm
	+Tj0/udUEG3wEaqaq7BAB45ElRUP+juXU9jUkmEQcCQKl6KTSXZaJrm0Wpnicg==
X-Gm-Gg: ASbGncskCjXevvpHPc+W3Yf4dMjkV2SpeMCBUQbLVGWl0a/1+4GBdSoX/R3Sh41YsDE
	xh4DajlUCSc9P/SkPoHem//hzXNO/radqfupdD3/UGTz7AMTfJFfH1U+gztQdnJhKEwhd6l9qLj
	byVmUSkT+j1y2U125GLxFxHkkS54E3UHMqZ9t9cHzeSKd/GLhR/ybFdQZquPONzQ+BE7qxfWVpB
	mB1ZvFCrzAeaRcqyTACLKm0Ulwc3wOcCa02mKB3T6kRNwRrW/NfDfPMQvoKlD8ftbDQ2teGDwmo
	atvXoAPBaogMOa9L3X+N9Oc3jTdEoDWuYAr9yRoExZ5ETZbyHidP9SXmgTvy5dK+tHZuJu4fZVR
	cZAf/7MMz5iPekz2+8FJz7EVO9Hxdg0aD7haahfcrXDq6P2C+NdJdPbW8OmA5XD/H5oDzy8Fvkt
	JLhzwU/xM38Kl6i//AoLFzQG9j
X-Google-Smtp-Source: AGHT+IEUBPa5IITZ0xNvggq4K99toyWF26tKSJHYDBLAmsdxBgPeG3SciIPO+fHaWtHtiGIKmmO8VA==
X-Received: by 2002:a05:620a:4611:b0:8b2:f82f:c630 with SMTP id af79cd13be357-8b33d2681f0mr1166028985a.31.1763926554372;
        Sun, 23 Nov 2025 11:35:54 -0800 (PST)
Received: from [127.0.0.1] ([135.119.237.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c17basm809094785a.29.2025.11.23.11.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 11:35:53 -0800 (PST)
Message-Id: <pull.2107.v2.git.git.1763926552033.gitgitgadget@gmail.com>
In-Reply-To: <pull.2107.git.git.1763807914242.gitgitgadget@gmail.com>
References: <pull.2107.git.git.1763807914242.gitgitgadget@gmail.com>
From: "Samo =?UTF-8?Q?Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 23 Nov 2025 19:35:52 +0000
Subject: [PATCH v2] shallow: set borders which are all reachable after clone
 shallow since
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

When shallow cloning based on a date, it happens that not all
shallow border commits are reachable.

Original implementation of a generic shallow boundary finder
based on rev-list sets a commit (from the initial list of border
commit candidates) to be the border commit as soon as it finds one
of its parentis that wasn't on the list of initial candidates. This
results in a successful shallow clone, where some of its declared
border commits may not be reachable and they would not actually exist
in the cloned repository. Thus the result may contradict existing
comment in the code, which correctly states that such commmit should
not be considered border.

One can inspect such case by running the added test scenario:
- 'clone shallow since all borders reachable'

The modified implementation of a generic shallow boundary finder
based on rev-list ensures that all shallow border commits are reachable
also after being grafted. This is achieved by inspecting all parents
of each initial border commit candidate. The border commit candidate
is set border only when all its parents wern't on the initial list of
candidates. Otherwise the border commit candidate is not set as border
however its parents that weren't on the list of candidates are set as
borders.

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
    Fixed --shallow-since generating descendant borders
    
    When shallow cloning based on a date, it happens that a list of commits
    is received, where some of the list border commits actually descend one
    from another. In such cases borders need to be expanded by additional
    parents and excluding the child as border.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2107%2Fspog%2Ffix-shallow-since-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2107/spog/fix-shallow-since-v2
Pull-Request: https://github.com/git/git/pull/2107

Range-diff vs v1:

 1:  aaeff44f83 ! 1:  479692c386 Fixed --shallow-since generating descendant borders
     @@ Metadata
      Author: Samo Pogačnik <samo_pogacnik@t-2.net>
      
       ## Commit message ##
     -    Fixed --shallow-since generating descendant borders
     +    shallow: set borders which are all reachable after clone shallow since
      
     -    When shallow cloning based on a date, it happens that a list
     -    of commits is received, where some of the list border commits
     -    actually descend one from another. In such cases borders need
     -    to be expanded by additional parents and excluding the child
     -    as border.
     +    When shallow cloning based on a date, it happens that not all
     +    shallow border commits are reachable.
     +
     +    Original implementation of a generic shallow boundary finder
     +    based on rev-list sets a commit (from the initial list of border
     +    commit candidates) to be the border commit as soon as it finds one
     +    of its parentis that wasn't on the list of initial candidates. This
     +    results in a successful shallow clone, where some of its declared
     +    border commits may not be reachable and they would not actually exist
     +    in the cloned repository. Thus the result may contradict existing
     +    comment in the code, which correctly states that such commmit should
     +    not be considered border.
     +
     +    One can inspect such case by running the added test scenario:
     +    - 'clone shallow since all borders reachable'
     +
     +    The modified implementation of a generic shallow boundary finder
     +    based on rev-list ensures that all shallow border commits are reachable
     +    also after being grafted. This is achieved by inspecting all parents
     +    of each initial border commit candidate. The border commit candidate
     +    is set border only when all its parents wern't on the initial list of
     +    candidates. Otherwise the border commit candidate is not set as border
     +    however its parents that weren't on the list of candidates are set as
     +    borders.
      
          Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
      
     @@ shallow.c: struct commit_list *get_shallow_commits_by_rev_list(struct strvec *ar
       	 * commit A is processed first, then commit B, whose parent is
       	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
       	 * itself is considered border at step 2, which is incorrect.
     -+	 * We must also consider that B has multiple parents, some of
     -+	 * them not being in the not_shallow_list, but must be added
     -+	 * as border commits to the result.
     ++	 *
     ++	 * We must also consider that B has multiple parents which may
     ++	 * not all be marked NOT_SHALLOW (as they weren't traversed into
     ++	 * the not_shallow_list from revs in the first place). Because of
     ++	 * that an additional step is required to reconsider B as border.
     ++	 * A commit from the not_shallow_list is considered border only
     ++	 * when ALL its parents weren't on the not_shallow_list.
     ++	 * When one or more parents of a commit from the not_shellow_list
     ++	 * also come from that list, the commit is not considered border,
     ++	 * but its non-listed parents are considered border commits.
      +	 *
      +	 * The general processing goes like this:
     -+	 * 1. Above we've coloured the whole not_shallow_list of commits
     -+	 *    with 'not_shallow'.
     ++	 * 1. Above we've painted the whole not_shallow_list of commits
     ++	 *    NOT_SHALLOW.
      +	 * 2. For each commit from the not_shallow_list (the code below)
     -+	 *    we colour 'shallow' the commit and its parents, which are not
     -+	 *    already coloured 'not_shallow'.
     -+	 * 3. Commits with all parents being coloured only 'shallow' remain
     ++	 *    we paint SHALLOW this commit and its parent for all its
     ++	 *    parents that had not yet been painted NOT_SHALLOW.
     ++	 * 3. Commits with all parents being painted only SHALLOW remain
      +	 *    shallow and are being added to result list.
     -+	 * 4. Commits without all parents being coloured only 'shallow' are
     -+	 *    being excluded as borders, however their parents coloured only
     -+	 *    'shallow' are being added to the result borders list.
     ++	 * 4. Commits without all parents being painted only SHALLOW are
     ++	 *    being excluded as borders, however their parents painted only
     ++	 *    SHALLOW are being added to the result borders list.
       	 */
       	for (p = not_shallow_list; p; p = p->next) {
       		struct commit *c = p->item;
     @@ shallow.c: struct commit_list *get_shallow_commits_by_rev_list(struct strvec *ar
       	}
       	free_commit_list(not_shallow_list);
       
     +
     + ## t/t5500-fetch-pack.sh ##
     +@@ t/t5500-fetch-pack.sh: test_expect_success 'shallow since with commit graph and already-seen commit' '
     + 	)
     + '
     + 
     ++test_expect_success 'clone shallow since all borders reachable' '
     ++	test_create_repo shallow-since-all-borders-reachable &&
     ++	(
     ++	rm -rf shallow123 &&
     ++	cd shallow-since-all-borders-reachable &&
     ++	GIT_COMMITTER_DATE="2025-08-19 12:34:56" git commit --allow-empty -m one &&
     ++	GIT_COMMITTER_DATE="2025-08-20 12:34:56" git switch -c branch &&
     ++	GIT_COMMITTER_DATE="2025-08-21 12:34:56" git commit --allow-empty -m two &&
     ++	GIT_COMMITTER_DATE="2025-08-22 12:34:56" git commit --allow-empty -m three &&
     ++	GIT_COMMITTER_DATE="2025-08-23 12:34:56" git switch main &&
     ++	GIT_COMMITTER_DATE="2025-08-24 12:34:56" git merge branch --no-ff &&
     ++	GIT_COMMITTER_DATE="2025-08-26 12:34:56" git clone --shallow-since "2025-08-21 12:34:56" "file://$(pwd)/." ../shallow123 &&
     ++	cd ../shallow123 &&
     ++	echo "Shallow borders:" &&
     ++	cat .git/shallow &&
     ++	$(for commit in $(cat .git/shallow); do git rev-list $commit 1>/dev/null || exit 1; done)
     ++	)
     ++'
     ++
     + test_expect_success 'shallow clone exclude tag two' '
     + 	test_create_repo shallow-exclude &&
     + 	(


 shallow.c             | 42 +++++++++++++++++++++++++++++++++++++++---
 t/t5500-fetch-pack.sh | 19 +++++++++++++++++++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/shallow.c b/shallow.c
index 55b9cd9d3f..2929ac90ee 100644
--- a/shallow.c
+++ b/shallow.c
@@ -251,21 +251,57 @@ struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
 	 * commit A is processed first, then commit B, whose parent is
 	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
 	 * itself is considered border at step 2, which is incorrect.
+	 *
+	 * We must also consider that B has multiple parents which may
+	 * not all be marked NOT_SHALLOW (as they weren't traversed into
+	 * the not_shallow_list from revs in the first place). Because of
+	 * that an additional step is required to reconsider B as border.
+	 * A commit from the not_shallow_list is considered border only
+	 * when ALL its parents weren't on the not_shallow_list.
+	 * When one or more parents of a commit from the not_shellow_list
+	 * also come from that list, the commit is not considered border,
+	 * but its non-listed parents are considered border commits.
+	 *
+	 * The general processing goes like this:
+	 * 1. Above we've painted the whole not_shallow_list of commits
+	 *    NOT_SHALLOW.
+	 * 2. For each commit from the not_shallow_list (the code below)
+	 *    we paint SHALLOW this commit and its parent for all its
+	 *    parents that had not yet been painted NOT_SHALLOW.
+	 * 3. Commits with all parents being painted only SHALLOW remain
+	 *    shallow and are being added to result list.
+	 * 4. Commits without all parents being painted only SHALLOW are
+	 *    being excluded as borders, however their parents painted only
+	 *    SHALLOW are being added to the result borders list.
 	 */
 	for (p = not_shallow_list; p; p = p->next) {
 		struct commit *c = p->item;
 		struct commit_list *parent;
+		int must_not_be_shallow = 0;
 
 		if (repo_parse_commit(the_repository, c))
 			die("unable to parse commit %s",
 			    oid_to_hex(&c->object.oid));
 
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
+		if (must_not_be_shallow) {
+			c->object.flags &= ~shallow_flag;
+			for (parent = c->parents; parent; parent = parent->next)
+				if (parent->item->object.flags & shallow_flag) {
+					parent->item->object.flags |= not_shallow_flag;
+					commit_list_insert(parent->item, &result);
+				}
+		} else {
+			for (parent = c->parents; parent; parent = parent->next)
+				parent->item->object.flags &= ~shallow_flag;
+			commit_list_insert(c, &result);
+		}
 	}
 	free_commit_list(not_shallow_list);
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 2677cd5faa..12209887fb 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -904,6 +904,25 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	)
 '
 
+test_expect_success 'clone shallow since all borders reachable' '
+	test_create_repo shallow-since-all-borders-reachable &&
+	(
+	rm -rf shallow123 &&
+	cd shallow-since-all-borders-reachable &&
+	GIT_COMMITTER_DATE="2025-08-19 12:34:56" git commit --allow-empty -m one &&
+	GIT_COMMITTER_DATE="2025-08-20 12:34:56" git switch -c branch &&
+	GIT_COMMITTER_DATE="2025-08-21 12:34:56" git commit --allow-empty -m two &&
+	GIT_COMMITTER_DATE="2025-08-22 12:34:56" git commit --allow-empty -m three &&
+	GIT_COMMITTER_DATE="2025-08-23 12:34:56" git switch main &&
+	GIT_COMMITTER_DATE="2025-08-24 12:34:56" git merge branch --no-ff &&
+	GIT_COMMITTER_DATE="2025-08-26 12:34:56" git clone --shallow-since "2025-08-21 12:34:56" "file://$(pwd)/." ../shallow123 &&
+	cd ../shallow123 &&
+	echo "Shallow borders:" &&
+	cat .git/shallow &&
+	$(for commit in $(cat .git/shallow); do git rev-list $commit 1>/dev/null || exit 1; done)
+	)
+'
+
 test_expect_success 'shallow clone exclude tag two' '
 	test_create_repo shallow-exclude &&
 	(

base-commit: debbc87557487aa9a8ed8a35367d17f8b4081c76
-- 
gitgitgadget
