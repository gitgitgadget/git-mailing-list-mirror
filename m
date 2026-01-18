Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83AA41
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703649; cv=none; b=qea+uWvM9mWhSuEYtR89XxcYCOJFoogz1yBwLkzxSCSdwrrY1AxMweIWht+6/NyQ0hlEY2vEEUetZNpxTcJLqKWat5XLv5TWsU86homMvegdBLLnR6P01thywAyxJ32I3PWuYa1UYjGRuNw6e7oih+I5KsHfc1wYbDQqY62tFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703649; c=relaxed/simple;
	bh=Jg965G9x6VdfTpN7cDkohNhTY1YPeUqk6VX1cLDLU5c=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=f6YZp7LQoGXhkyYA8lHGkTJMgxUW1194xTg5rwqHjmXeT72e57i83yubP0Djd38zs9dgcuUvXV1ce467X0TuGgvliYedxPjenQO/Ug+A+YcAV29gwDLk5I1Fg7J5TwcUVs9pBmGgSUWHuQNgOm1kw1O61Lb3DI0t4LFsDJIvKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFoH2pYm; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFoH2pYm"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6ae4c2012so2384428eec.0
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 18:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768703647; x=1769308447; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XLvDxJ9+QXS7LppbU7sHcvsF1kRFJyvYUsMyC8XOjys=;
        b=LFoH2pYmUvEN8rXMg3tvkHkqnZjGGR1D3WMRSjDDUgpf/HxUf/VMrVkK4cuNTX29Bj
         0hFCRM+peIpWThRcX8B8YjrqDCCfHm+L1HCVjnQ2kTJWhCM5ayJ2qFNrmHDFwjvOPpY5
         khX44DmVBElKMYinP0wIQtAS2AHT9lDUYN/BDaVNyTw0yI/SbfU9XID7G7K7JCMFvYFR
         cL2nwXt+w4v5TtSQIpjF2TY2CmOXj91kytYEcNovJGJZKhO12gtaubs5Dy/uy9iTeneV
         VnOLrSGUnr0VkBjmiJeSOJK1KTSGj53+egnHM5OdYJIENJL5bsUsMfntWSvEyX6Ya3AN
         xVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768703647; x=1769308447;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLvDxJ9+QXS7LppbU7sHcvsF1kRFJyvYUsMyC8XOjys=;
        b=OYdEoe7Uem341UDS61Na0iqTzP3j8QgxKi3UXWd8nMKQatax3tkxFyeYv5xb6SBsXi
         W2a0fUJPWK1+kZnN2vPH7E7VN3kUAikDtojxVxaIIP7aglJhe2aewimAwjeVhgBBrVdJ
         dD8La5P90jFNYd36sgk2hsWPdZIOfIv1Qb53StwpbjErCuZlhlCPeRy+T26SAMf0nTgE
         ztiRf/VIZ5t8nZMdhVzquj7/qIV+N/gg31Bf2h0sIwPTjtbYZVA1zL/hcvIiF0AdGGVW
         aABzWWwKlYQzIdaTEstMe4lP5lv6OTUw/IHpEprlrKegFJav4taUrhwRr3Krhv+xefQ4
         /TUA==
X-Gm-Message-State: AOJu0Yxoi7Ib+jMdfcAOzrOJy6FVK4pjyxgeHIU9WS35OHF6n45kBBWv
	G8BWq4dXIJDdFF9cnUhjSB1uDjJRzNKMmw51JbfpEKOkYfeGR7hVxX2qZpvY0A==
X-Gm-Gg: AY/fxX4LLZUKM8qwEoJU8slDQ5cPQPI2/DuuZIhiwk3onPsdcv258WGsVinNr+x0ThT
	RuM1dJb0PycYgvD+WNpjAw2JwHX6Kepz9wB7n3jj/KCCz1qBvjC4LyhQJDl5j30GA/hDkcqPX3A
	vVZpSm6vwMk8dhDy0+BFoyvs98USDxKSuOHvjlZGFnNGpXMVlyVNUGakQg4FYXuPW45Rl9KBjjU
	N6MxD5XhLQ1Dcj+hAICdzryHgMajnj3CeFC2KT0nx8kKJmGjw8Ionm9P9+SvLExY7UNTP59t4mb
	m0fiaVhgxLE9MC6nXxqM15G+JfSSJMGBHvvUzY9X7dutbuvROQuU7o0NumYQWHWc2VpDwka4V/Y
	2EowrOzIG08HPS3Jdd83CmIFItodaQ/j/5n0Cfi/py96CvIwX3tHJ4+5Hkw7o4rdr3LJ41qDiVx
	Z4MyXTWTEXoOwXpnKDSBV9TwvL
X-Received: by 2002:a05:7300:238b:b0:2ab:c279:9dce with SMTP id 5a478bee46e88-2b6b3ed91b5mr7407506eec.7.1768703646470;
        Sat, 17 Jan 2026 18:34:06 -0800 (PST)
Received: from [127.0.0.1] ([172.182.195.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3619a94sm7708888eec.20.2026.01.17.18.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 18:34:05 -0800 (PST)
Message-Id: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Jan 2026 02:34:05 +0000
Subject: [PATCH] revision: add --maximal option
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When inspecting a range of commits from some set of starting references, it
is sometimes useful to learn which commits are not reachable from any other
commits in the selected range.

One such application is in the creation of a sequence of bundles for the
bundle URI feature. Creating a stack of bundles representing different
slices of time includes defining which references to include. If all
references are used, then this may be overwhelming or redundant. Instead,
selecting commits that are maximal to the range could help defining a
smaller reference set to use in the bundle header.

Add a new '--maximal' option to restrict the output of a revision range to
be only the commits that are not reachable from any other commit in the
range, based on the reachability definition of the walk.

This is accomplished by adding a new 28th bit flag, CHILD_VISITED, that is
set as we walk. This does extend the bit range in object.h, but using an
earlier bit may collide with another feature.

The tests demonstrate the behavior of the feature with a positive-only
range, ranges with negative references, and walk-modifying flags like
--first-parent and --exclude-first-parent-only.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    revision: add --maximal option
    
    My motivation for this feature is very similar to the bundle URI
    application. I can get around it by creating a tool that uses git
    rev-list --parents and then uses a hashset to collect the parent list
    and filter out any commits that ever appear as parents. It would be more
    efficient to use Git's native revision-walking feature.
    
    This does bring the object struct up to a 32-bit boundary with 28 flag
    bits, 3 type bits, and a parsed bit. That's the biggest concern I have
    about this update adding a new flag bit. I would understand if this
    feature is not worth running out of room for extensions there.
    
    I considered looking through the earlier bit positions to see the impact
    of an overlap, but they certainly looked potentially risky to reuse.
    
    I wonder if anyone else has thought about this as a useful technique.
    For instance, it could be part of a strategy for choosing commits for
    reachability bitmaps.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2032%2Fderrickstolee%2Fmaximal-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2032/derrickstolee/maximal-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2032

 Documentation/rev-list-options.adoc |  4 ++
 object.h                            |  4 +-
 revision.c                          |  9 +++-
 revision.h                          |  5 +-
 t/t6600-test-reach.sh               | 75 +++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 453ec59057..f0d2ab32a9 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -444,6 +444,10 @@ The following options affect the way the simplification is performed:
 	times; if so, a commit is included if it is any of the commits
 	given or if it is an ancestor or descendant of one of them.
 
+`--maximal`::
+	Restrict the output commits to be those that are not reachable
+	from any other commits in the revision range.
+
 A more detailed explanation follows.
 
 Suppose you specified `foo` as the _<paths>_.  We shall call commits
diff --git a/object.h b/object.h
index 4bca957b8d..dfe7a1f0ea 100644
--- a/object.h
+++ b/object.h
@@ -64,7 +64,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15               23------27
+ * revision.h:               0---------10         15               23--------28
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
@@ -86,7 +86,7 @@ void object_array_init(struct object_array *array);
  * builtin/unpack-objects.c:                                 2021
  * pack-bitmap.h:                                              2122
  */
-#define FLAG_BITS  28
+#define FLAG_BITS  29
 
 #define TYPE_BITS 3
 
diff --git a/revision.c b/revision.c
index 1858e093ee..29864426d6 100644
--- a/revision.c
+++ b/revision.c
@@ -1150,7 +1150,8 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			struct commit *p = parent->item;
 			parent = parent->next;
 			if (p)
-				p->object.flags |= UNINTERESTING;
+				p->object.flags |= UNINTERESTING |
+						   CHILD_VISITED;
 			if (repo_parse_commit_gently(revs->repo, p, 1) < 0)
 				continue;
 			if (p->parents)
@@ -1204,7 +1205,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			if (!*slot)
 				*slot = *revision_sources_at(revs->sources, commit);
 		}
-		p->object.flags |= pass_flags;
+		p->object.flags |= pass_flags | CHILD_VISITED;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
 			if (list)
@@ -2381,6 +2382,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->first_parent_only = 1;
 	} else if (!strcmp(arg, "--exclude-first-parent-only")) {
 		revs->exclude_first_parent_only = 1;
+	} else if (!strcmp(arg, "--maximal")) {
+		revs->maximal = 1;
 	} else if (!strcmp(arg, "--ancestry-path")) {
 		revs->ancestry_path = 1;
 		revs->simplify_history = 0;
@@ -4125,6 +4128,8 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 {
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
+	if (revs->maximal && (commit->object.flags & CHILD_VISITED))
+		return commit_ignore;
 	if (revs->unpacked && has_object_pack(revs->repo, &commit->object.oid))
 		return commit_ignore;
 	if (revs->no_kept_objects) {
diff --git a/revision.h b/revision.h
index b36acfc2d9..e5c2c82145 100644
--- a/revision.h
+++ b/revision.h
@@ -52,7 +52,9 @@
 #define NOT_USER_GIVEN	(1u<<25)
 #define TRACK_LINEAR	(1u<<26)
 #define ANCESTRY_PATH	(1u<<27)
-#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR | PULL_MERGE)
+#define CHILD_VISITED	(1u<<28)
+#define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR \
+				      | PULL_MERGE | CHILD_VISITED)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
@@ -198,6 +200,7 @@ struct rev_info {
 			cherry_mark:1,
 			bisect:1,
 			ancestry_path:1,
+			maximal:1,
 
 			/* True if --ancestry-path was specified without an
 			 * argument. The bottom revisions are implicitly
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 6638d1aa1d..a759409756 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -762,4 +762,79 @@ test_expect_success 'for-each-ref is-base: --sort' '
 		--sort=refname --sort=-is-base:commit-2-3
 '
 
+test_expect_success 'rev-list --maximal (all positive)' '
+	# Only one maximal.
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-4-2
+	refs/heads/commit-4-4
+	refs/heads/commit-8-4
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/commit-8-4)
+	EOF
+	run_all_modes git rev-list --maximal --stdin &&
+
+	# All maximal.
+	cat >input <<-\EOF &&
+	refs/heads/commit-5-2
+	refs/heads/commit-4-3
+	refs/heads/commit-3-4
+	refs/heads/commit-2-5
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/commit-5-2)
+	$(git rev-parse refs/heads/commit-4-3)
+	$(git rev-parse refs/heads/commit-3-4)
+	$(git rev-parse refs/heads/commit-2-5)
+	EOF
+	run_all_modes git rev-list --maximal --stdin &&
+
+	# Mix of both.
+	cat >input <<-\EOF &&
+	refs/heads/commit-5-2
+	refs/heads/commit-3-2
+	refs/heads/commit-2-5
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/commit-5-2)
+	$(git rev-parse refs/heads/commit-2-5)
+	EOF
+	run_all_modes git rev-list --maximal --stdin
+'
+
+test_expect_success 'rev-list --maximal (range)' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-2-5
+	refs/heads/commit-6-4
+	^refs/heads/commit-4-5
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/commit-6-4)
+	EOF
+	run_all_modes git rev-list --maximal --stdin &&
+
+	# first-parent changes reachability: the first parent
+	# reduces the second coordinate to 1 before reducing the
+	# first coordinate.
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-2-5
+	refs/heads/commit-6-4
+	^refs/heads/commit-4-5
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/commit-6-4)
+	$(git rev-parse refs/heads/commit-2-5)
+	EOF
+	run_all_modes git rev-list --maximal --stdin \
+		--first-parent --exclude-first-parent-only
+'
+
 test_done

base-commit: b5c409c40f1595e3e590760c6f14a16b6683e22c
-- 
gitgitgadget
