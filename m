Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18546364DC
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113468; cv=none; b=SJAZS0gvww721REvU0zIeAXNkD81vq34szaH8/sJZtLugpfyZv2YLFv7MmhylZgxE+dz36/X1+vzix8fXEHTJpZ454efgC4vdgztan/Tbb6C5olW94e752aQwpl1FTdXOI9eRhgYZvnCoLm3do4CHopyA4Ns+QGaMbjIOxMSyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113468; c=relaxed/simple;
	bh=4MhjPZCuKVpNh0EyRH5/rOo2hBA243eDsP43+gwPevU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kgDlHy6fPri9mOaB1mpLhMsduwmXGU2+XgMLnHpkhKkcuztQoJRmHtwiJBB7LtahSHtufPdedCjpzW4zSVHdNcP23sAW8IpDbSIxiuay+YbTKzg8MPJCJkoKGmCQtryrLMryxXUNMCRS5K4whkQpZW1UPQb1xxB4a6hOU9MjOEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWIaCzuG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWIaCzuG"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d18931a94so3948730f8f.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 01:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709113465; x=1709718265; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnIxzez0lIanLyqGuOlIkiD3HmL+wsRoVicOjde7vUU=;
        b=fWIaCzuGBGLB0E8ik9XFHs2prH96LbpBG4cgf7FXWohKVHpEEHgYg8Hl/7k/xVq0lf
         +ocSKukXV/wggP15aBH9adQClMfbjbwNef4KkTwmZ4OjPMAh6sdg8SOZWSY5UuFIYs+e
         Cs0iEKy4VFKN6mwXkp8Ib3OLo8YvdNqfn/+cQh+brzmq/gVK+XB0cfe+0nYIvGMMgv1y
         atfiN8mHeMsZSbsYQnbDzxzEi0bSc2tkfyC/B3sq/9bKBCTmRUgM3xMBm/K0XTCwATSJ
         17gqjp9aV/3yMY5WpeYm0JIPmonAnslbOYRTRTrBJHB8+tlzVjBuqbbbLbO9V7tqssRN
         pO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113465; x=1709718265;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnIxzez0lIanLyqGuOlIkiD3HmL+wsRoVicOjde7vUU=;
        b=f9GbdrWIhMQIAkTlfWvCpHwWtupKfF9O0GfmL4h3uJq6btmzOZGJKeNR6PfolAzDDF
         aispnnGDHUJ2OSXlEj9AogIr6lCj/xtliiU4+1WtZI2/lsQyjQ0wv0HKqkXKbgyIZa7T
         5M4rGzjPab8WX1fnDjveZ3hfxVPI6f8jtNvwf5GUdxFOdiFWy+PsXr/DwJPxAx6Xxm4g
         uc7VtIdxkwJjqVD2uiS20PlX8Z8g48FBo3tCLZsacfcvDUIAzH7dK8GPt3sT4S/x0c3B
         L3CHdQJWv3ST1/KxN4noZVgCTxH2jes+jAlezj2ICyeY89cliavNmms7p7eo7xBdhfzX
         BWQQ==
X-Gm-Message-State: AOJu0YyIJoktRnhTm2i05FpaHDV0Z2h68safolOfEvCEqX+U1qw8klkX
	+vFZ/I+JaKR78piJLFHzWmi6wzsEZhR96+tHcvbOhWqxIy2dAfuLKrdxAWJt
X-Google-Smtp-Source: AGHT+IGJFNzCiNj86LvoxpMBxohDN4hxHgChmEGCquIdK0CP2Z0S0T5Y8eRrzu+7vNqsY4D8rFbsVw==
X-Received: by 2002:adf:e0c6:0:b0:33b:8358:2694 with SMTP id m6-20020adfe0c6000000b0033b83582694mr8040430wri.5.1709113464748;
        Wed, 28 Feb 2024 01:44:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cl7-20020a5d5f07000000b0033dc931eb06sm11384429wrb.0.2024.02.28.01.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:44:23 -0800 (PST)
Message-ID: <837aa5a89c640427a5de064da93f1de4934d8212.1709113458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Feb 2024 09:44:10 +0000
Subject: [PATCH v4 04/11] commit-reach(paint_down_to_common): prepare for
 handling shallow commits
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Dirk Gouders <dirk@gouders.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `git fetch --update-shallow` needs to test for commit ancestry, it
can naturally run into a missing object (e.g. if it is a parent of a
shallow commit). For the purpose of `--update-shallow`, this needs to be
treated as if the child commit did not even have that parent, i.e. the
commit history needs to be clamped.

For all other scenarios, clamping the commit history is actually a bug,
as it would hide repository corruption (for an analysis regarding
shallow and partial clones, see the analysis further down).

Add a flag to optionally ask the function to ignore missing commits, as
`--update-shallow` needs it to, while detecting missing objects as a
repository corruption error by default.

This flag is needed, and cannot replaced by `is_repository_shallow()` to
indicate that situation, because that function would return 0 in the
`--update-shallow` scenario: There is not actually a `shallow` file in
that scenario, as demonstrated e.g. by t5537.10 ("add new shallow root
with receive.updateshallow on") and t5538.4 ("add new shallow root with
receive.updateshallow on").

Note: shallow commits' parents are set to `NULL` internally already,
therefore there is no need to special-case shallow repositories here, as
the merge-base logic will not try to access parent commits of shallow
commits.

Likewise, partial clones aren't an issue either: If a commit is missing
during the revision walk in the merge-base logic, it is fetched via
`promisor_remote_get_direct()`. And not only the single missing commit
object: Due to the way the "promised" objects are fetched (in
`fetch_objects()` in `promisor-remote.c`, using `fetch
--filter=blob:none`), there is no actual way to fetch a single commit
object, as the remote side will pass that commit OID to `pack-objects
--revs [...]` which in turn passes it to `rev-list` which interprets
this as a commit _range_ instead of a single object. Therefore, in
partial clones (unless they are shallow in addition), all commits
reachable from a commit that is in the local object database are also
present in that local database.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 5ff71d72d51..7112b10eeea 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -53,7 +53,8 @@ static int queue_has_nonstale(struct prio_queue *queue)
 static struct commit_list *paint_down_to_common(struct repository *r,
 						struct commit *one, int n,
 						struct commit **twos,
-						timestamp_t min_generation)
+						timestamp_t min_generation,
+						int ignore_missing_commits)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result = NULL;
@@ -108,6 +109,13 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 			if (repo_parse_commit(r, p)) {
 				clear_prio_queue(&queue);
 				free_commit_list(result);
+				/*
+				 * At this stage, we know that the commit is
+				 * missing: `repo_parse_commit()` uses
+				 * `OBJECT_INFO_DIE_IF_CORRUPT` and therefore
+				 * corrupt commits would already have been
+				 * dispatched with a `die()`.
+				 */
 				return NULL;
 			}
 			p->object.flags |= flags;
@@ -143,7 +151,7 @@ static struct commit_list *merge_bases_many(struct repository *r,
 			return NULL;
 	}
 
-	list = paint_down_to_common(r, one, n, twos, 0);
+	list = paint_down_to_common(r, one, n, twos, 0, 0);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -214,7 +222,7 @@ static int remove_redundant_no_gen(struct repository *r,
 				min_generation = curr_generation;
 		}
 		common = paint_down_to_common(r, array[i], filled,
-					      work, min_generation);
+					      work, min_generation, 0);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
 		for (j = 0; j < filled; j++)
@@ -504,7 +512,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 
 	bases = paint_down_to_common(r, commit,
 				     nr_reference, reference,
-				     generation);
+				     generation, ignore_missing_commits);
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
-- 
gitgitgadget

