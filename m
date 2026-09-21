Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB147044C
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001170; cv=none; b=u0Dt1/IX19EcBx6cyCTiwEZsMQHjZ181lc3WpEiyq5zZTnb9tEd3qYLesB5nQpu2goM7x95RwZ2TGhmCcIBBWnG7l2+B+ndJa1eOjNR7F0VzejrhWZcD+/1pBfELVfEJd9lOomBgQNscEeRZkAeCDfHItwf0BQvJ21MnXceiwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001170; c=relaxed/simple;
	bh=OfOlEq1SW8KaJHABd5N7cjCopmf1leD5aSpOEopu3O8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jWb3sjpnQAK0/NwRpzL//spb5WA5w6DRL9I3mXV5dq7tgM3DM3gHBLAYXGNZGBq/N9Lr8wn5xRGVlltLxE9pCXIPmlgdSyO3VnU/qWUYpQhqJcqXN6VswmNQ8LNwunWJ09ps1rauMNX90joeTUOoEoKvdihPcdcUBe+Y3KWCtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/F6HQKG; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/F6HQKG"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso2529872a12.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790001168; x=1790605968; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7fG0BzlxOQh59AMQiCsCWvS8KTHSXhVHzaIHhrwf6fI=;
        b=m/F6HQKG+tADVDRlY/gAQloQmXXsYzNpUWdv886xTydepbDz3vxF+e2fb2Q1v140YD
         koWeAZFpfRi3Sd1PLcJIGk/ZbMXMIlhqwaBiJFiCE6+7/4XZDK0yEMPA+pWww9Rg2nZw
         0zcgLGIKrDNkWZIjjr5LzxASapxOLbe1BAWXzmcy1PmuNoxsJryK79Jj+0OoIPWCVLSs
         Rsvql4f3g5yYI4tnqQcSY5j2M2i7BRYuNECK+5LEoZawEYVHWjtnF2vuuvrKzgouq3rq
         lauAlfZ4eekllJmZQJMuRrehtwRlNX8mUgyhY2H10hrDZkydEouVRRupbe3zsHHl7S8h
         DOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790001168; x=1790605968;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fG0BzlxOQh59AMQiCsCWvS8KTHSXhVHzaIHhrwf6fI=;
        b=CiqGvJ+57q0dyQukcTb0k5WnRzlZG5fAo8z/SFZiNIF8Xu5+yfYkrXvqfnMgioj5Gp
         zq3NOopuhfBcD0ZvVyq4AGvDjZ0LVYvdkMUtlTr3v+wEbmZ3MoQVwuPF/TGAhy0iUW70
         IBZ07RuS/2iwnajBwWeF6nBwXbJlFbdREbqJRPn3ZFO1jqGL5dxUlf5hmQUfmzfv542t
         PuhsScG6PA3vx8OaSpkDdGVV6dG8vow3/Ai9/p6jfloU6GE7XnxrF+HybHoO4RwlX7jP
         k55R84KAEFbQ2gsVwAdYXQnMnCCbTOPta2wz1Ikm1U1kOQBYDmgiCvI0TX1/GFInuuZ/
         KOYA==
X-Gm-Message-State: AFuF++nSRbrZbZYwofQ/JqvzAlDki18BasZQMMVxmHl4PkmzNdTpqoo5
	J3ExXwoJJIVtjKB1Ntqdw4SXfRSOtHOZzu+UBdrbfktL/EA6DToOZEw8B91CoA==
X-Gm-Gg: AYBFou1BqzMOK7CPFGZTcyn7U3vl3yNxw8M6DG8JKMEq1/0Bvg88tnJAfZ8BHsfTxET
	BdL1uLvEdO72Pijxe9mg+uuPpGcOA/WjqL7wRbCe75Gb1Tg1Iv+36XT/sELaoai90FQbXVkkzHn
	eKzyfUpKVw+o/cgQ4BvpYrtEILMMKa/swj8lsNavJQ1shBgyHZrAqG69grimbHJkGZqlQLE98Oq
	8BjoKM+6urIoFQAGkwa2sjyPqCk/bsRHgCNlMqnlBeiPO1Eo62eO+C9PE0cN11VfqVCCvnfws5G
	iYvSdzZ+D2gLSdiCoRIb++oKXWxasALtypZHleA9DOZtxAcnVufjql09+vXPhvZi2omgxEvD7CJ
	Fa/1noPovVFN5UsBKVwKmpi3g7Mg5r76Qu5o+WF3DfaGxF+Hy9f5fd4cTIdVDrt2ub4F3wvd9FW
	tKKeRH8tj4kVjxB8vS2G92f97ueLsYyjrMZ5gSb/NscP17dVj1i6wPKcGcL6Q0cTYA1T0KG2cCO
	md0tngmcg==
X-Received: by 2002:a17:90b:48c5:b0:39d:f247:bb3 with SMTP id 98e67ed59e1d1-39e54e7c1camr18022468a91.21.1790001168157;
        Mon, 21 Sep 2026 07:32:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.67.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a063f33101sm346709a91.2.2026.09.21.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:32:47 -0700 (PDT)
Message-Id: <pull.2223.v2.git.1790001166646.gitgitgadget@gmail.com>
In-Reply-To: <pull.2223.git.1789252459520.gitgitgadget@gmail.com>
References: <pull.2223.git.1789252459520.gitgitgadget@gmail.com>
From: "Jiri Kuncar via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Sep 2026 14:32:46 +0000
Subject: [PATCH v2] pull: avoid segfault when commit lookup fails
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
Cc: Jiri Kuncar <jiri@kuncar.dev>,
    Jiri Kuncar <jiri.kuncar@gmail.com>

From: Jiri Kuncar <jiri.kuncar@gmail.com>

get_can_ff() and already_up_to_date() pass the result of
lookup_commit_reference() straight to commit_list_insert() and
repo_is_descendant_of() without checking it.  When the object
behind HEAD or one of the merge heads cannot be parsed, e.g. because
a loose object was left truncated by a fetch or gc racing on the
same repository, lookup_commit_reference() returns NULL and
"git pull" segfaults instead of reporting the corruption.

Treat a failed lookup as "cannot fast-forward" and "not up to date",
so that the caller falls through to the normal merge path, which
already diagnoses the broken object and fails cleanly.

An alternative would be to report the breakage at each lookup site,
which could give a more precise diagnosis.  The minimal guards are
preferred because they do no more than is needed to avoid the
crash, and will be easy to drop once "git pull" is reworked to
resolve object names into commit objects early and pass those
around, at which point there will not be multiple lookups of the
same object name to guard in the first place.

The test corrupts the loose object in place rather than removing
it: a missing object that is still recorded in the commit-graph is
caught by the consistency check in fetch-pack before "git pull"
reaches the fast-forward check, so removing it would not exercise
the crash.

Signed-off-by: Jiri Kuncar <jiri.kuncar@gmail.com>
---
    pull: avoid segfault when commit lookup fails
    
    Changes since v1:
    
     * Rewrite the commit message per SubmittingPatches (imperative mood,
       present-tense problem statement, alternatives considered), as pointed
       out by Junio.
     * Drop the "test -f"/"chmod"/truncate steps from the test in favour of
       "rm -f && echo garbage >", the idiom already used in t1450. Plain "rm
       -f" alone does not reproduce the crash: a missing object that is
       still in the commit-graph is caught by fetch-pack's consistency check
       before "git pull" reaches get_can_ff(), so the object has to remain
       present but unparseable. Documented this in a test comment and in the
       log message.
     * Drop the redundant "git fetch" in the test setup; "git clone" already
       populates refs/remotes/origin/*.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2223%2Fjirikuncar%2Fjk%2Fpull-null-merge-head-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2223/jirikuncar/jk/pull-null-merge-head-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2223

Range-diff vs v1:

 1:  db6ecf62ec ! 1:  c00ae9d699 pull: avoid crash of invalid merge head
     @@ Metadata
      Author: Jiri Kuncar <jiri.kuncar@gmail.com>
      
       ## Commit message ##
     -    pull: avoid crash of invalid merge head
     +    pull: avoid segfault when commit lookup fails
      
     -    Adds NULL guards for lookup_commit_reference() to avoid segfaults.
     +    get_can_ff() and already_up_to_date() pass the result of
     +    lookup_commit_reference() straight to commit_list_insert() and
     +    repo_is_descendant_of() without checking it.  When the object
     +    behind HEAD or one of the merge heads cannot be parsed, e.g. because
     +    a loose object was left truncated by a fetch or gc racing on the
     +    same repository, lookup_commit_reference() returns NULL and
     +    "git pull" segfaults instead of reporting the corruption.
      
     -    Those invalid references are possibly caused by parallel fetches or
     -    gc racing on the same repository.
     +    Treat a failed lookup as "cannot fast-forward" and "not up to date",
     +    so that the caller falls through to the normal merge path, which
     +    already diagnoses the broken object and fails cleanly.
      
     -    This effectively treats failed lookup as "not up to date" so caller
     -    falls to a normal merge, which reports the broken object instead of
     -    crashing.
     +    An alternative would be to report the breakage at each lookup site,
     +    which could give a more precise diagnosis.  The minimal guards are
     +    preferred because they do no more than is needed to avoid the
     +    crash, and will be easy to drop once "git pull" is reworked to
     +    resolve object names into commit objects early and pass those
     +    around, at which point there will not be multiple lookups of the
     +    same object name to guard in the first place.
     +
     +    The test corrupts the loose object in place rather than removing
     +    it: a missing object that is still recorded in the commit-graph is
     +    caught by the consistency check in fetch-pack before "git pull"
     +    reaches the fast-forward check, so removing it would not exercise
     +    the crash.
      
          Signed-off-by: Jiri Kuncar <jiri.kuncar@gmail.com>
      
     @@ t/t5520-pull.sh: test_expect_success 'git pull --rebase against local branch' '
      +	git clone up dn &&
      +	(
      +		cd dn &&
     -+		git -c fetch.unpackLimit=1000 fetch origin \
     -+			"+refs/heads/*:refs/remotes/origin/*" &&
      +		git commit-graph write --reachable &&
      +		oid=$(git rev-parse refs/remotes/origin/sideA) &&
      +		obj=.git/objects/$(test_oid_to_path "$oid") &&
     -+		test -f "$obj" &&
     -+		chmod u+w "$obj" &&
     -+		>"$obj" &&
     ++
     ++		# Corrupt the object instead of removing it: a missing
     ++		# object that is still in the commit-graph is caught by
     ++		# fetch before pull ever reaches the fast-forward check.
     ++		rm -f "$obj" &&
     ++		echo garbage >"$obj" &&
      +		test_must_fail git pull --no-rebase origin sideA sideB
      +	)
      +'


 builtin/pull.c  | 10 +++++++++-
 t/t5520-pull.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index db3ee0aab3..80e79daeb9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -800,8 +800,12 @@ static int get_can_ff(struct object_id *orig_head,
 
 	orig_merge_head = &merge_heads->oid[0];
 	head = lookup_commit_reference(the_repository, orig_head);
-	commit_list_insert(head, &list);
+	if (!head)
+		return 0;
 	merge_head = lookup_commit_reference(the_repository, orig_merge_head);
+	if (!merge_head)
+		return 0;
+	commit_list_insert(head, &list);
 	ret = repo_is_descendant_of(the_repository, merge_head, list);
 	commit_list_free(list);
 	if (ret < 0)
@@ -820,12 +824,16 @@ static int already_up_to_date(struct object_id *orig_head,
 	struct commit *ours;
 
 	ours = lookup_commit_reference(the_repository, orig_head);
+	if (!ours)
+		return 0;
 	for (size_t i = 0; i < merge_heads->nr; i++) {
 		struct commit_list *list = NULL;
 		struct commit *theirs;
 		int ok;
 
 		theirs = lookup_commit_reference(the_repository, &merge_heads->oid[i]);
+		if (!theirs)
+			return 0;
 		commit_list_insert(theirs, &list);
 		ok = repo_is_descendant_of(the_repository, ours, list);
 		commit_list_free(list);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 27f38ab3c8..b3ab8f4c94 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -888,4 +888,31 @@ test_expect_success 'git pull --rebase against local branch' '
 	test_cmp expect file2
 '
 
+test_expect_success 'pull does not crash when a merge head does not resolve' '
+	test_when_finished "rm -rf up dn" &&
+	git init up &&
+	(
+		cd up &&
+		test_commit base &&
+		git switch -c sideA &&
+		test_commit a &&
+		git switch -c sideB base &&
+		test_commit b
+	) &&
+	git clone up dn &&
+	(
+		cd dn &&
+		git commit-graph write --reachable &&
+		oid=$(git rev-parse refs/remotes/origin/sideA) &&
+		obj=.git/objects/$(test_oid_to_path "$oid") &&
+
+		# Corrupt the object instead of removing it: a missing
+		# object that is still in the commit-graph is caught by
+		# fetch before pull ever reaches the fast-forward check.
+		rm -f "$obj" &&
+		echo garbage >"$obj" &&
+		test_must_fail git pull --no-rebase origin sideA sideB
+	)
+'
+
 test_done

base-commit: fa7f9290efe2bd22dd736689597b474b93798e11
-- 
gitgitgadget
