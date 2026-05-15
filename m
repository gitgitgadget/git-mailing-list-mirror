Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC33FDBEB
	for <git@vger.kernel.org>; Fri, 15 May 2026 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868468; cv=none; b=uzOZYYEbRp8CD+oOwjE3H+384hb42pi/9ot5UH69h1nxYbSL8NfyL6hHlXQUAsU2jURnIJcV/0LYT1BezOZNf0NXo44cN1xbn7BdCASGdaBoLoJwydFjZK1lyEZG7qChMFHWg/LzRDHcoMC0nAB7MplO2+FHkSsNDGfCTSqfuNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868468; c=relaxed/simple;
	bh=qrBFewLIIJjUiYa+GQ0/i2JFlL5II8xwHhZCTLU6gUg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=o83ghqYjNQpOLrlHCkwwxKJUEFMosjQCJM8ZS5xUtylilY2yCEnNE2cX8BjRC2HsWFpA1EgG07Yg/dgobEsIlGtKp/AROS4PakoK8bqS0U4z3AHinNpLAkCwkdDvstMf2K4PzFF7UeIoLbs0rymvFYUDkg+z8MzF7eBzxV59eE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blBUnqZ3; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blBUnqZ3"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f68f3b075fso451869eec.0
        for <git@vger.kernel.org>; Fri, 15 May 2026 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778868466; x=1779473266; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iw1d/cZDLILWEvYwOaxFpu40VpX21Beh+silGqvXpgg=;
        b=blBUnqZ3mv1qtDAkWOhkN3yK4q5btz28QsD8PfH3D7W4uOlx11UdrC1nO/+j42n1RD
         DP5J9u9Hpbivrsm7LTJ7RLYl+xt0Gic9Dy+lZfv8AYItYRYqHFUMxavBWG4MDISyuzr3
         CxC47WXCsAdQ79EW3TfxvItgrOWzRGdxdTSl0KFLs3bgYTAxlZ/P8ve2HCResOhXnDiJ
         X8veG1bgj1QZFKJBL59BHPdNzwf3ldSwCcwXlG1YLFDOqkEiqh8TQOa3dDtlsvZT0xxp
         uxe5q3VFfe0Kd1eipEqIukCTu2TKjk2AWE1DeD1gW9z2LMxTgtj6TV8bwGvn2HdY5ji6
         dQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778868466; x=1779473266;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iw1d/cZDLILWEvYwOaxFpu40VpX21Beh+silGqvXpgg=;
        b=buQ1SRKeqcEC15j4r2HSSvRdgIf5VK/bwncu6q4M2KA3FqQY/rA9kHsuVzE7GADOyW
         rzU9//sgjEvRXRhK5p7uQkqXpc7OPuwzUkb3CtlWWSHJ1vNnnVRyN6ZuYNPFXiQheTZZ
         zBk6leqtqAMiB8z8uERgwCzJlqv+ackgD3F5anHZPY7mSbHIIFmKa+n4C3OcsMXL3S7O
         VDYtwIJpvjCEAUtwh7l4E5wAYZHcaoRKRYuUrfWtOtbtPOhYpDN+61gcVgN/NWGt1RIg
         Qe+xetLfzwlfjqY7GGTvP9ImsTUtgqJXQszPHpvKEfcvtTd7Er1C33tufRD3KmpBTjH/
         zhNA==
X-Gm-Message-State: AOJu0Yy2rwlzV56WtTA/j6fIXjUrNkrG+JDjEMwbzWevI5DbeTtCJiMr
	gkYX7Y6FNwCnRphBy+UQlJmWttorVpvaFxTO2P4ZoSvaQjqkdDwi4lENcq6wgw==
X-Gm-Gg: Acq92OEJd8R7A8CfVFFll3VnOXUz9K0efHwy6VrtXLx135CDc6b+ZaKZj/rYMHXOEcP
	I/UbFmi0uBYE89ohwnIYd+ekwRJBZJ8YqNh3j3qpH6VtyUK3IiH0vFZiFMgMiMcF69mXN+lkqLx
	Tuz96545O92Uh5c7JYmCeZHdDlmqjZ4eb+DphZOQEqmXjwNbtfJrUEyjA+LbQ6j6ahb8uQmlvZk
	q7SzcRlpEEPJMy2GjlqcPEkv4+Jn9OoX+n7vjKYgfkLyDGOi0GbO75WdHiQfO8qzBMGbFnfwh8L
	fVnY2Qtesxy09OrTglWct8lkep479MePRKSfb36INAXd1a/ICNLzYAf8LEmAGLV7UeLgXkrgCnX
	Lk0Mihx5jPmqp+RrpSFl2ey6l1ebPaaH9jUutI0KlpEIkQF9ldZekabljta4xO/r3PTH2eYkY7N
	RwhMic/u/UTizf0TXpHi4gka1kyudCA0R0NAyEAg==
X-Received: by 2002:a05:7300:6429:b0:2f5:3641:f10f with SMTP id 5a478bee46e88-30398695003mr2742467eec.31.1778868465499;
        Fri, 15 May 2026 11:07:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.239.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6adsm8681794eec.15.2026.05.15.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:07:44 -0700 (PDT)
Message-Id: <pull.2116.git.1778868463992.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 May 2026 18:07:43 +0000
Subject: [PATCH] commit-reach: use the decoration hash for
 tips_reachable_from_bases()
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

tips_reachable_from_bases() walks the commit graph from a set of base
commits to find which tip commits are reachable.  The inner loop does
a linear scan over the tips array to check whether each visited commit
is a tip, making the overall cost O(C * T) where C is commits walked
and T is the number of tips.

Replace the linear scan with the decoration hash for lookups, reducing
the per-commit tip check from O(T) to O(1) and the overall cost from
O(C * T) to O(C + T).

This function is called by `git for-each-ref --merged` and
`git branch/tag --contains/--no-contains` via reach_filter() in
ref-filter.c.

Benchmark on a merge-heavy monorepo (2.3M commits, 10,000 refs):

  Command                           Before    After   Speedup
  for-each-ref --merged HEAD        6.64s     1.66s     4.0x
  for-each-ref --no-merged HEAD     6.75s     1.74s     3.9x
  branch --merged HEAD              0.68s     0.61s      10%
  branch --no-merged HEAD           0.65s     0.61s       8%
  tag --merged HEAD                 0.12s     0.12s       -

The large speedup for for-each-ref is because it checks all 10,000
refs as tips, making the O(T) inner loop expensive.  The branch
subcommand only checks local branches (fewer tips), so the improvement
is smaller.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    commit-reach: use the decoration hash for tips_reachable_from_bases()
    
    This is a single small commit that replaces an O(C*T) linear scan in
    tips_reachable_from_bases() with an O(1) lookup using the decoration
    hash.
    
    The function is called by git for-each-ref --merged and git branch/tag
    --contains/--no-contains via reach_filter() in ref-filter.c. On a
    merge-heavy monorepo with 2.3M commits and 10,000 refs, git for-each-ref
    --merged HEAD goes from 6.6s to 1.7s (4x).
    
    The diff is intentionally minimal (+9/-6) to make the idea easy to
    discuss before polishing. Things I'm not fully happy about:
    
     * Extra block scope { } just to preserve indentation of the inner body
     * Hacking the array index into the decoration value as (void *)(i + 1)
       instead of storing a proper pointer
     * Relying on unsigned wraparound (- 1 on a size_t 0) to check for
       not-found via j < tips_nr
    
    Happy to clean all of these up in a follow-up commit if the approach
    makes sense.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2116%2Fspkrka%2Ftips-reachable-minimal-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2116/spkrka/tips-reachable-minimal-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2116

 commit-reach.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index d3a9b3ed6f..70b056eae0 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1150,6 +1150,7 @@ void tips_reachable_from_bases(struct repository *r,
 	size_t min_generation_index = 0;
 	timestamp_t min_generation;
 	struct commit_list *stack = NULL;
+	struct decoration tip_index = { "tip_index" };
 
 	if (!bases || !tips || !tips_nr)
 		return;
@@ -1173,6 +1174,10 @@ void tips_reachable_from_bases(struct repository *r,
 	QSORT(commits, tips_nr, compare_commit_and_index_by_generation);
 	min_generation = commits[0].generation;
 
+	for (size_t i = 0; i < tips_nr; i++)
+		add_decoration(&tip_index, &commits[i].commit->object,
+			       (void *)(i + 1));
+
 	while (bases) {
 		repo_parse_commit(r, bases->item);
 		commit_list_insert(bases->item, &stack);
@@ -1183,14 +1188,11 @@ void tips_reachable_from_bases(struct repository *r,
 		int explored_all_parents = 1;
 		struct commit_list *p;
 		struct commit *c = stack->item;
-		timestamp_t c_gen = commit_graph_generation(c);
 
 		/* Does it match any of our tips? */
-		for (size_t j = min_generation_index; j < tips_nr; j++) {
-			if (c_gen < commits[j].generation)
-				break;
-
-			if (commits[j].commit == c) {
+		{
+			size_t j = (size_t)lookup_decoration(&tip_index, &c->object) - 1;
+			if (j < tips_nr) {
 				tips[commits[j].index]->object.flags |= mark;
 
 				if (j == min_generation_index) {
@@ -1232,6 +1234,7 @@ void tips_reachable_from_bases(struct repository *r,
 	}
 
 done:
+	clear_decoration(&tip_index, NULL);
 	free(commits);
 	repo_clear_commit_marks(r, SEEN);
 	commit_list_free(stack);

base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
-- 
gitgitgadget
