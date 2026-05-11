Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7E3A4F37
	for <git@vger.kernel.org>; Mon, 11 May 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504361; cv=none; b=Z9JFiSLWqeYvitDCTowLn0J+KvZcBqXsnsbr9H+N7iOwdjWoVxA0aQg7ZwiLrWmUuAfem+dgTbINOx0lmFp5bZZ/bubOqgy9WDWPscBeMe0cP8NovckcRFKgyJ78Ze2swKR/ynZx/W0lTcrNKi1fPEeb1A0pb3IGCEIsf59J8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504361; c=relaxed/simple;
	bh=ghiPTC0ola8hlA/o0HiUnVt1G/+02++pF51S0JnVbIo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sGIcRXEENVSFU9MlYKh61R2gIluv0vBnpqVJ/CX3aQUnKpCz5ezqi9Jmpzf7NFxDvUWIt9XlupPXN08QMUg9mVALxTFyFh10qwofKFf1/2YWNBPThYFkqel+sYbEjXUH5ROkjN3AJYDAhjypW5sxe6KMZORW9PaGhSKwGcRkeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0E9esS4; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0E9esS4"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12ddbe104ccso3767596c88.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778504358; x=1779109158; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VY2NL1IVN6EfjLAyQRq9VwYn6NDC+eKEt2rg8giq660=;
        b=H0E9esS4dmiCMX2HrH2nIZw93OfWwSjUrBBaEZ1VG46kGsEJ1dSPDt8IseAJpxeEdP
         RIApmC4Hl8tE4E5bwKe3hYAqDsromHM+C/ZXfO/esOFVCyWEmtpTcgREiowLTtz/Gi4+
         Gc7PJoMXpfxcFV3iPAb1s2bz4hLkCi+6llauyVhb6Kkxc+PjsqejDRrUAEHXo5zkm3ZN
         RxW0IbIb6VPq1Ti/GASlbtiR5ljE2JFD3/g0YcdRg3m3z8jHGRiDg3J3Kw+GDHgiHIIr
         hpPnUeGXGo7yZe+lzhssMkghuEOopnzzUYKCNAIEhGJTXygDkbvLlOLI+VmakCrGs+4Q
         4Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778504358; x=1779109158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VY2NL1IVN6EfjLAyQRq9VwYn6NDC+eKEt2rg8giq660=;
        b=ZjnWfc+53aseOQLihPr4fyeGv7TCGnFg+uPQK8OIfCoNNv4gcGuJbAKO8FVp4wGQ4p
         AKx/gApci4cn1OVjX1+RqTU0arLzf/5d5ZerEEaSRoIha1/8g+368iyHqkyhN18RasFJ
         N1+YKPkUqqhEe+5rtOesaOYnW/ep3gHRpFD1kja2MqmOhpp5t/4QOPkLiZRWj6YKTvxy
         Hz/BCTdLuFO36eMLCJz7V/Fp0zdx5ELHe30ucgF2YVkeaWz4eu/AgLDayPhirutX6EvL
         YT9Be/lrX9NsATA7KbpnT5CA5Wx9/0haFA07Od+2tDQCmbzXZ7ylRu805zABvWGA76/z
         +hCg==
X-Gm-Message-State: AOJu0Yxlkkhn6AzX6c9+W2q1Lt7GfwCiaCE6Nat0OPirAeN65NYH0xAz
	ZMZbv9FjH83Qpzb1g1yUSFfERzQj7rnuWxzyBk/6GAr5qX/Tkv7RMEBDxaL3aw==
X-Gm-Gg: Acq92OHMPi0yFK+/eNCXnekC8xIF5jjtFYextg3Ho1XHOjKpB95O5nAmeCs4oL7yN/g
	uJoY27kDlFUT92LwFlx3sNPqeBvhDc7lsCC9GJFKJisGXWrtPQCPoeZx7IuzELA6MWD+kAQiS9a
	HwRaaGq46H392e/bJPMGWMeD6mqbN7i2tgDwUrClRAXfxytISCxcoOxA7e8xr+36faJX3AIZSvU
	I5vfMZl9b4AuRBC7IiuOIxkkDtLyzf5KWNZftNtMMfh5HQ0P1qGOC7ICMQ9P661pFgjbSEzz0SR
	2w/ztx6sZyIKJ4W39gas2m5aYUtdpbf3m3M272oiW9TgLNiHfoilOpD5vaR9gQIgqITaH3VCGoa
	FdEygH1vtSapiwmXT72DQKyeJVHnSZfmcJJ+c/vfGkgtju8sZHIdXg8VnoeVJhuc5T13hgy/kLW
	nYi667N3siojxoPjvnSBEv4rj39ALtpyabxpY=
X-Received: by 2002:a05:7022:3d05:b0:12d:de3f:d853 with SMTP id a92af1059eb24-1318ec61008mr11463325c88.44.1778504358046;
        Mon, 11 May 2026 05:59:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.83])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1329fc4bf3fsm10886533c88.5.2026.05.11.05.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:59:17 -0700 (PDT)
Message-Id: <19f1605067e26c8e393c6c2e341844bcb3dc1b41.1778504352.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2109.v4.git.1778504352.gitgitgadget@gmail.com>
References: <pull.2109.v3.git.1778498532730.gitgitgadget@gmail.com>
	<pull.2109.v4.git.1778504352.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 12:59:12 +0000
Subject: [PATCH v4 2/2] commit-reach: early exit paint_down_to_common for
 single merge-base
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
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Commits not in the commit-graph get GENERATION_NUMBER_INFINITY and
sort to the top of the priority queue.  After those, commits with
finite generation numbers are popped in non-increasing order.
When MERGE_BASE_FIND_ALL is not set the first doubly-painted commit
with a finite generation is therefore a best merge-base: no commit
still in the queue can be a descendant of it.  Skip the expensive
STALE drain in this case.

Add MERGE_BASE_FIND_ALL to the merge_base_flags enum.  Callers that
need every merge-base (repo_get_merge_bases_many, repo_get_merge_bases,
repo_in_merge_bases_many, remove_redundant_no_gen) pass the flag to
preserve existing behavior.  git merge-base (without --all) passes 0,
triggering the early exit.

On a 2.2M-commit merge-heavy monorepo with commit-graph:

  HEAD vs ~500:   5,229ms -> 24ms
  HEAD vs ~1000:  4,214ms -> 39ms
  HEAD vs ~5000:  3,799ms -> 46ms
  HEAD vs ~10000: 3,827ms -> 61ms

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/merge-base.c  |  3 ++-
 commit-reach.c        | 19 +++++++++++++++----
 commit-reach.h        |  7 ++++++-
 t/t6600-test-reach.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 9b50b4660e..a87011c6cd 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -11,11 +11,12 @@
 
 static int show_merge_base(struct commit **rev, size_t rev_nr, int show_all)
 {
+	enum merge_base_flags flags = show_all ? MERGE_BASE_FIND_ALL : 0;
 	struct commit_list *result = NULL, *r;
 
 	if (repo_get_merge_bases_many_dirty(the_repository, rev[0],
 					    rev_nr - 1, rev + 1,
-					    0, &result) < 0) {
+					    flags, &result) < 0) {
 		commit_list_free(result);
 		return -1;
 	}
diff --git a/commit-reach.c b/commit-reach.c
index 766ba1156a..5a52be90a6 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -97,6 +97,14 @@ static int paint_down_to_common(struct repository *r,
 			if (!(commit->object.flags & RESULT)) {
 				commit->object.flags |= RESULT;
 				tail = commit_list_append(commit, tail);
+				/*
+				 * The queue is generation-ordered; no
+				 * remaining common ancestor can be a
+				 * descendant of this one.
+				 */
+				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
+				    generation < GENERATION_NUMBER_INFINITY)
+					break;
 			}
 			/* Mark parents of a found merge stale */
 			flags |= STALE;
@@ -247,7 +255,8 @@ static int remove_redundant_no_gen(struct repository *r,
 				min_generation = curr_generation;
 		}
 		if (paint_down_to_common(r, array[i], filled,
-					 work, min_generation, 0, &common)) {
+					 work, min_generation,
+					 MERGE_BASE_FIND_ALL, &common)) {
 			clear_commit_marks(array[i], all_flags);
 			clear_commit_marks_many(filled, work, all_flags);
 			commit_list_free(common);
@@ -477,7 +486,8 @@ int repo_get_merge_bases_many(struct repository *r,
 			      struct commit **twos,
 			      struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, n, twos, 1, 0, result);
+	return get_merge_bases_many_0(r, one, n, twos, 1,
+				     MERGE_BASE_FIND_ALL, result);
 }
 
 int repo_get_merge_bases_many_dirty(struct repository *r,
@@ -495,7 +505,8 @@ int repo_get_merge_bases(struct repository *r,
 			 struct commit *two,
 			 struct commit_list **result)
 {
-	return get_merge_bases_many_0(r, one, 1, &two, 1, 0, result);
+	return get_merge_bases_many_0(r, one, 1, &two, 1,
+				     MERGE_BASE_FIND_ALL, result);
 }
 
 /*
@@ -540,7 +551,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 	struct commit_list *bases = NULL;
 	int ret = 0, i;
 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
-	enum merge_base_flags mb_flags = 0;
+	enum merge_base_flags mb_flags = MERGE_BASE_FIND_ALL;
 
 	if (ignore_missing_commits)
 		mb_flags |= MERGE_BASE_IGNORE_MISSING_COMMITS;
diff --git a/commit-reach.h b/commit-reach.h
index a3f2cd80eb..3f3a563d8a 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -19,9 +19,14 @@ int repo_get_merge_bases_many(struct repository *r,
 			      struct commit_list **result);
 enum merge_base_flags {
 	MERGE_BASE_IGNORE_MISSING_COMMITS = (1 << 0),
+	MERGE_BASE_FIND_ALL               = (1 << 1),
 };
 
-/* To be used only when object flags after this call no longer matter */
+/*
+ * To be used only when object flags after this call no longer matter.
+ * Without MERGE_BASE_FIND_ALL and with generation numbers available,
+ * returns after finding the first merge-base, skipping the STALE drain.
+ */
 int repo_get_merge_bases_many_dirty(struct repository *r,
 				    struct commit *one, size_t n,
 				    struct commit **twos,
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index dc0421ed2f..51c23b7683 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -882,4 +882,44 @@ test_expect_success 'rev-list --maximal-only matches merge-base --independent' '
 	test_cmp expect.sorted actual.sorted
 '
 
+# The following tests verify the early-exit optimisation in
+# paint_down_to_common when merge-base is invoked without --all.
+# Each test checks all four commit-graph configurations.
+
+merge_base_all_modes () {
+	test_when_finished rm -rf .git/objects/info/commit-graph &&
+	git merge-base "$@" >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-full .git/objects/info/commit-graph &&
+	git merge-base "$@" >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-half .git/objects/info/commit-graph &&
+	git merge-base "$@" >actual &&
+	test_cmp expect actual &&
+	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
+	git merge-base "$@" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'merge-base without --all (unique base)' '
+	git rev-parse commit-5-3 >expect &&
+	merge_base_all_modes commit-5-7 commit-8-3
+'
+
+test_expect_success 'merge-base without --all is one of --all results' '
+	test_when_finished rm -rf .git/objects/info/commit-graph &&
+
+	cp commit-graph-full .git/objects/info/commit-graph &&
+	git merge-base --all commit-5-7 commit-4-8 commit-6-6 commit-8-3 >all &&
+	git merge-base commit-5-7 commit-4-8 commit-6-6 commit-8-3 >single &&
+	test_line_count = 1 single &&
+	grep -F -f single all &&
+
+	cp commit-graph-half .git/objects/info/commit-graph &&
+	git merge-base --all commit-5-7 commit-4-8 commit-6-6 commit-8-3 >all &&
+	git merge-base commit-5-7 commit-4-8 commit-6-6 commit-8-3 >single &&
+	test_line_count = 1 single &&
+	grep -F -f single all
+'
+
 test_done
-- 
gitgitgadget
