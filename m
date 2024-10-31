Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8CC191F75
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409556; cv=none; b=HbvHBEYozaB+bceMGrUUySloVKEtGdXYIrCVpgXnfBFLSqJNPhHgnDv1Vn5pe/1cu9PU1ZPJKAFoCOW7Zz8jGvd/hvp1JS4P7HuycF5JFinT0kYK/9KT3a2LR6132e3Q3hOHQMmXJr4OoDDd74Z2jdcYjJxipDaKnu4vtXZqCZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409556; c=relaxed/simple;
	bh=0XWeid/+kBpctSDC4avXsy8dmU746/RxWNUDEXTdZsM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVCetnC9TqKM12Lcos4bHUADB5hw6m4fwRcKOH6IeQqL/ZDQ1v8FSlQv8NNHevLzU9NZ/8nc4hDoArvq2ytsO1a60HGnzu6up5LlxaCiQ3TNseBQ1cesLOz2dsGWCRfi01DUYZB1yN+j/BR2k4v1kbHvKTOiQOllhwpBQiUWJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drw7wAcI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drw7wAcI"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30ceaa5feeso2409755276.2
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730409549; x=1731014349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvRCsHxcr3nn+bvTO+M9jog77YIFVOy4tlGc2NPn2/c=;
        b=drw7wAcI+1SThu5SQxMcr7oYvK+OjnsQZ6lEIJGB8b0gFX2NfAWK/IuBYzDFyRBauf
         07keeHkb0K5DSnp/LlEE0Fm3gt4z9Jknz1ohi1jr6g4/YaMvMrcpH1iHQjzGyRKe7bcp
         dISimofbtuLjZT/mImvPE7kh6NQII2ld8Ix1EpwqG74b3Wx2KqUSErmZEz8k/TDBy0ut
         zKBiLAgQaKgU0L5cxjow3ArF+NxrPKfrMK5/UDC927QU/6FWnafNpQeNVc5n+Az5ASq+
         ZeQUsP8b3ow8qqt8q9hSDR8BbcB2bRC26KIMa2yJFB0+xMXNHhIZA7s1phPvJ7DfAX2n
         XjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409549; x=1731014349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvRCsHxcr3nn+bvTO+M9jog77YIFVOy4tlGc2NPn2/c=;
        b=SD9hhcNagSliSxy2xfD3vBD5dqsttkgJdrjFbcW1fYCDTUup0H9XS8/QyDwRbmn73H
         CsvhKR8+9dD/kxjB4S2oTcCgsB9hzaIX20W2zn80fRi5yfWmPKvbjHLTZ8Vm8tU/x3wp
         3nsxbH3Syk3xjDsU3CZSiHGEH/Z9x/KJn5ER0BtkXwFW2Aw4KRqXCkCi4i6dnyQYHeLK
         HCc+tA2969PJXFyuKi/zeSxTa9AcWiIvZW6/v4dCgiHJkLSzEd0mAOgS3OlSRP0IGB/0
         x5UwI3vBR6C8suXYN6vG0oz6ZVvR4XPsH2eTrvpPPPIFC8YiEVHzhcxT9O2F29Iyg8Yq
         T/Uw==
X-Gm-Message-State: AOJu0Yw5krE6wFr4pmVED2iSZ87Aom3BFpvFlRTC9UGOqd1bXTYe1P6y
	0oSYB3jIk1lHX2QN104D73lWN67NywT27uE30EMWI16++mc7oxDcOBf9UG+lmwb0/xSUjYPRzYm
	j/KkMpNUcJpoEr/x2QlYwUqWGIDZlkN7EJga1YXdo9r6LeaFtBd02OOBC6mxcd5UY4/FAh708+r
	DpNWF0o0cBjHCSGnpsdcKDIPsfnXZz7nIneh66XwM97XFcrIf8RSZpbbMR4bV+rgyWEQ==
X-Google-Smtp-Source: AGHT+IGNlOqVe81r0TZH8YBYYV+ClctDC7W+6rdPw1djjp8cyuC2nev1co2iwi3AFVCxT9gbaEp6EtLEe3iYp41M2LGW
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:1f26:d3e7:169a:dbab])
 (user=jonathantanmy job=sendgmr) by 2002:a25:3602:0:b0:e22:3aea:6eb5 with
 SMTP id 3f1490d57ef6-e3302686c15mr2057276.7.1730409548592; Thu, 31 Oct 2024
 14:19:08 -0700 (PDT)
Date: Thu, 31 Oct 2024 14:19:01 -0700
In-Reply-To: <cover.1730409376.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1730235646.git.jonathantanmy@google.com> <cover.1730409376.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <631b9a86778f15b7086e5f17fe850ffa151dd341.1730409376.git.jonathantanmy@google.com>
Subject: [PATCH v2 2/2] fetch-pack: warn if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com, me@ttaylorr.com, 
	hanxin.hx@bytedance.com
Content-Type: text/plain; charset="UTF-8"

When fetching, there is a step in which sought objects are first checked
against the local repository; only objects that are not in the local
repository are then fetched. This check first looks up the commit graph
file, and returns "present" if the object is in there.

However, the action of first looking up the commit graph file is not
done everywhere in Git, especially if the type of the object at the time
of lookup is not known. This means that in a repo corruption situation,
a user may encounter an "object missing" error, attempt to fetch it, and
still encounter the same error later when they reattempt their original
action, because the object is present in the commit graph file but not in
the object DB.

Therefore, make it a fatal error when this occurs. (Note that we cannot
proceed to include this object in the list of objects to be fetched
without changing at least the fetch negotiation code: what would happen
is that the client will send "want X" and "have X" and when I tested
at $DAYJOB with a work server that uses JGit, the server reasonably
returned an empty packfile. And changing the fetch negotiation code to
only use the object DB when deciding what to report as "have" would be
an unnecessary slowdown, I think.)

This was discovered when a lazy fetch of a missing commit completed with
nothing actually fetched, and the writing of the commit graph file after
every fetch then attempted to read said missing commit, triggering a
lazy fetch of said missing commit, resulting in an infinite loop with no
user-visible indication (until they check the list of processes running
on their computer). With this fix, there is no infinite loop. Note that
although the repo corruption we discovered was caused by a bug in GC in
a partial clone, the behavior that this patch teaches Git to warn about
applies to any repo with commit graph enabled and with a missing commit,
whether it is a partial clone or not.

t5330, introduced in 3a1ea94a49 (commit-graph.c: no lazy fetch in
lookup_commit_in_graph(), 2022-07-01), tests that an interaction between
fetch and the commit graph does not cause an infinite loop. This patch
changes the exit code in that situation, so that test had to be changed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c                               | 19 ++++++++++++++++---
 t/t5330-no-lazy-fetch-with-commit-graph.sh |  2 +-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6728a0d2f5..fe1fb3c1b7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -122,16 +122,29 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
 		cb(negotiator, cache.items[i]);
 }
 
+static void die_in_commit_graph_only(const struct object_id *oid)
+{
+	die(_("You are attempting to fetch %s, which is in the commit graph file but not in the object database.\n"
+	      "This is probably due to repo corruption.\n"
+	      "If you are attempting to repair this repo corruption by refetching the missing object, use 'git fetch --refetch' with the missing object."),
+	      oid_to_hex(oid));
+}
+
 static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
-					       int mark_tags_complete)
+					       int mark_tags_complete_and_check_obj_db)
 {
 	enum object_type type;
 	struct object_info info = { .typep = &type };
 	struct commit *commit;
 
 	commit = lookup_commit_in_graph(the_repository, oid);
-	if (commit)
+	if (commit) {
+		if (mark_tags_complete_and_check_obj_db) {
+			if (!has_object(the_repository, oid, 0))
+				die_in_commit_graph_only(oid);
+		}
 		return commit;
+	}
 
 	while (1) {
 		if (oid_object_info_extended(the_repository, oid, &info,
@@ -143,7 +156,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 
 			if (!tag->tagged)
 				return NULL;
-			if (mark_tags_complete)
+			if (mark_tags_complete_and_check_obj_db)
 				tag->object.flags |= COMPLETE;
 			oid = &tag->tagged->oid;
 		} else {
diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
index 5eb28f0512..feccd58324 100755
--- a/t/t5330-no-lazy-fetch-with-commit-graph.sh
+++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
@@ -39,7 +39,7 @@ test_expect_success 'fetch any commit from promisor with the usage of the commit
 	test_commit -C with-commit any-commit &&
 	anycommit=$(git -C with-commit rev-parse HEAD) &&
 	GIT_TRACE="$(pwd)/trace.txt" \
-		git -C with-commit-graph fetch origin $anycommit 2>err &&
+		test_must_fail git -C with-commit-graph fetch origin $anycommit 2>err &&
 	! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
 	grep "git fetch origin" trace.txt >actual &&
 	test_line_count = 1 actual
-- 
2.47.0.163.g1226f6d8fa-goog

