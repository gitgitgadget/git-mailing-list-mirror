Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4813C9C0
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409552; cv=none; b=QH8uKfCEcNUo0hKYjfx76Yz72ZFzNkp62NA3WdNM0YprlyDrQ4cVmY0GeRTyF/ZvCcdmETFzjzYeROCaw5Lw1BTioHPxMr/KGoAuIzJq5PMLsoSozXeSuTA1VB3TGiV4KO3hKwE8PXHbRYkphZKjE6KZR5HODMVbjmn3PiSi1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409552; c=relaxed/simple;
	bh=Cf5OPCpHZm1KLv/OEDZla0WLUl6T9WBKYAg5T/0lgoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ou2vbbDt+NCUjFAiJaSHaxXugHEP0Av+Z9cUGCTGvTzJpST2saVb7bdcM8JQlb+SLjzkzOSFMzCveqI387G+BefaE1O4/o5M7XTlA2WrVMToXTFR94E9eUWeSnAmIk0ZzCpUDhCZVmlq6MDn8eKzVL/WrXMj5AoG6V7SXNRjQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rv+AxUTt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rv+AxUTt"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28ef71f0d8so2801736276.0
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730409545; x=1731014345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=03e1Z5/EZLOXnqH4j4bUOHX/qQ8kt1qPHdjzRPNsrlU=;
        b=rv+AxUTtA44Ou7HrpTLtmJ2K0mkCP4TqGSEl4s76y4P73vccBbLC9LnNiHrIy0hwId
         R6dKRPMAdXD2ohsRBai6cr6K/OlSCTjldOgWaVbjtnxu7qfsE29iW61bO1mscUUZ6tCF
         jWpjJRzh8DffKks0ApR6OgW1jxgYaZeqJXGrapSrV/xzwnm/LpHiJsB1ez0lY1qSET35
         7od1H8jZeItyEQCogWpM71TN47b3of/LudJnsLKv0BcFYQA8jqRfIgZBk/SmWPvdDKFv
         2X1ekCJLTu9Hpg8hg39ews8han1S+dz6uGidefrAXAsTc6PGb4gp15LxT0E7Usn+dOPe
         UGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409545; x=1731014345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03e1Z5/EZLOXnqH4j4bUOHX/qQ8kt1qPHdjzRPNsrlU=;
        b=fwBp9jHbaMrTOgZncna1woY0vsWcMNVpxNhFEr6Ja0EK60P/wakA7HyRbPrwnf3avu
         Qvmtwlk+oR2tfXg04r1nP2vWJQlwa5W29S0t4gsEh9q1eL/17AfbU4tXzaWe8dKt+dgQ
         k/s7+kLqOQJJtNLBGVOPiuxntVCF1MwMHIanh6QqgpIitJx3xp/taxNH0mFNXVHuTDaE
         RaVFt7d2HGJoY7Vo+aHwfvrSr4CdJOIKXPYQY13FP1dxd63sQ/yZfENT77A0BiNE8sRi
         wlxw8ezJvxuff5c/OOROqTOcuUanu69ihYBa9kz/rQo7gNLOrCGKA0ToR6wky9IAp4XF
         K4mQ==
X-Gm-Message-State: AOJu0YyZGXdll8X4U87EkrarKP9Mbl/DWCZaQawY6GA7sx9sZrH8oLMk
	gz0G5BO7YvOXf91G6GXQ1OQVdZXfi6lGNoL5PjIURKVVswUBBBb438PlxuiQxLbSjnEYoDe6WSm
	uHnay2DJTSLXa0ytnaRUZ4+/hT3WfVW1xMruzZPWDryfEks6Jcvy6L/xI5S8amR05VSk3DKn9mI
	s3mxx/PTDFGrWDUfzAJ74rNK+qmfaeGe2ttWEO6QlfSU7GGNxdJWQ936MCaUrBM0Cgdg==
X-Google-Smtp-Source: AGHT+IEsOy9WW3YbxGRBohn+vRUy6/81YiMOaN65U+vMZoFGoNicHQ5sXhnzGVOfQT60Hn9n5Ky55GOZJZQUBcOTs4dp
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:1f26:d3e7:169a:dbab])
 (user=jonathantanmy job=sendgmr) by 2002:a25:b324:0:b0:e1c:ed3d:7bb7 with
 SMTP id 3f1490d57ef6-e330253c596mr710276.1.1730409544883; Thu, 31 Oct 2024
 14:19:04 -0700 (PDT)
Date: Thu, 31 Oct 2024 14:18:59 -0700
In-Reply-To: <cover.1730235646.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1730235646.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <cover.1730409376.git.jonathantanmy@google.com>
Subject: [PATCH v2 0/2] When fetching, die if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com, me@ttaylorr.com, 
	hanxin.hx@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Thanks everyone for your review comments. I've updated the patch 1
commit message as Josh requested. I'll reply individually to comments on
patch 2.

Jonathan Tan (2):
  Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
  fetch-pack: warn if in commit graph but not obj db

 fetch-pack.c                               | 42 +++++++++++-----------
 t/t5330-no-lazy-fetch-with-commit-graph.sh |  2 +-
 2 files changed, 23 insertions(+), 21 deletions(-)

Range-diff against v1:
1:  4dea8933cf ! 1:  34e87b8388 Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
    @@ Commit message
     
         This reverts commit a6e65fb39caf18259c660c1c7910d5bf80bc15cb.
     
    +    This revert simplifies the next patch in this patch set.
    +
         The commit message of that commit mentions that the new function "will
         be used for the bundle-uri client in a subsequent commit", but it seems
         that eventually it wasn't used.
2:  1027ff2cb7 ! 2:  631b9a8677 fetch-pack: warn if in commit graph but not obj db
    @@ Commit message
         action, because the object is present in the commit graph file but not in
         the object DB.
     
    -    Therefore, detect when this occurs and print a warning. (Note that
    -    we cannot proceed to include this object in the list of objects to
    -    be fetched without changing at least the fetch negotiation code:
    -    what would happen is that the client will send "want X" and "have X"
    -    and when I tested at $DAYJOB with a work server that uses JGit, the
    -    server reasonably returned an empty packfile. And changing the fetch
    -    negotiation code to only use the object DB when deciding what to report
    -    as "have" would be an unnecessary slowdown, I think.)
    +    Therefore, make it a fatal error when this occurs. (Note that we cannot
    +    proceed to include this object in the list of objects to be fetched
    +    without changing at least the fetch negotiation code: what would happen
    +    is that the client will send "want X" and "have X" and when I tested
    +    at $DAYJOB with a work server that uses JGit, the server reasonably
    +    returned an empty packfile. And changing the fetch negotiation code to
    +    only use the object DB when deciding what to report as "have" would be
    +    an unnecessary slowdown, I think.)
     
         This was discovered when a lazy fetch of a missing commit completed with
         nothing actually fetched, and the writing of the commit graph file after
         every fetch then attempted to read said missing commit, triggering a
         lazy fetch of said missing commit, resulting in an infinite loop with no
         user-visible indication (until they check the list of processes running
    -    on their computer). With this fix, at least a warning message will be
    -    printed. Note that although the repo corruption we discovered was caused
    -    by a bug in GC in a partial clone, the behavior that this patch teaches
    -    Git to warn about applies to any repo with commit graph enabled and with
    -    a missing commit, whether it is a partial clone or not.
    +    on their computer). With this fix, there is no infinite loop. Note that
    +    although the repo corruption we discovered was caused by a bug in GC in
    +    a partial clone, the behavior that this patch teaches Git to warn about
    +    applies to any repo with commit graph enabled and with a missing commit,
    +    whether it is a partial clone or not.
    +
    +    t5330, introduced in 3a1ea94a49 (commit-graph.c: no lazy fetch in
    +    lookup_commit_in_graph(), 2022-07-01), tests that an interaction between
    +    fetch and the commit graph does not cause an infinite loop. This patch
    +    changes the exit code in that situation, so that test had to be changed.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## fetch-pack.c ##
    -@@ fetch-pack.c: static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
    - #define ALTERNATE	(1U << 1)
    - #define COMMON		(1U << 6)
    - #define REACH_SCRATCH	(1U << 7)
    -+#define COMPLETE_FROM_COMMIT_GRAPH	(1U << 8)
    - 
    - /*
    -  * After sending this many "have"s if we do not get any new ACK , we
     @@ fetch-pack.c: static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
    + 		cb(negotiator, cache.items[i]);
      }
      
    ++static void die_in_commit_graph_only(const struct object_id *oid)
    ++{
    ++	die(_("You are attempting to fetch %s, which is in the commit graph file but not in the object database.\n"
    ++	      "This is probably due to repo corruption.\n"
    ++	      "If you are attempting to repair this repo corruption by refetching the missing object, use 'git fetch --refetch' with the missing object."),
    ++	      oid_to_hex(oid));
    ++}
    ++
      static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
     -					       int mark_tags_complete)
    -+					       int mark_additional_complete_information)
    ++					       int mark_tags_complete_and_check_obj_db)
      {
      	enum object_type type;
      	struct object_info info = { .typep = &type };
    @@ fetch-pack.c: static void for_each_cached_alternate(struct fetch_negotiator *neg
      	commit = lookup_commit_in_graph(the_repository, oid);
     -	if (commit)
     +	if (commit) {
    -+		if (mark_additional_complete_information)
    -+			commit->object.flags |= COMPLETE_FROM_COMMIT_GRAPH;
    ++		if (mark_tags_complete_and_check_obj_db) {
    ++			if (!has_object(the_repository, oid, 0))
    ++				die_in_commit_graph_only(oid);
    ++		}
      		return commit;
     +	}
      
    @@ fetch-pack.c: static struct commit *deref_without_lazy_fetch(const struct object
      			if (!tag->tagged)
      				return NULL;
     -			if (mark_tags_complete)
    -+			if (mark_additional_complete_information)
    ++			if (mark_tags_complete_and_check_obj_db)
      				tag->object.flags |= COMPLETE;
      			oid = &tag->tagged->oid;
      		} else {
    -@@ fetch-pack.c: static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
    - 	save_commit_buffer = old_save_commit_buffer;
    - }
    - 
    -+static void warn_in_commit_graph_only(const struct object_id *oid)
    -+{
    -+	warning(_("You are attempting to fetch %s, which is in the commit graph file but not in the object database."),
    -+		oid_to_hex(oid));
    -+	warning(_("This is probably due to repo corruption."));
    -+	warning(_("If you are attempting to repair this repo corruption by refetching the missing object, use 'git fetch --refetch' with the missing object."));
    -+}
    -+
    - /*
    -  * Returns 1 if every object pointed to by the given remote refs is available
    -  * locally and reachable from a local ref, and 0 otherwise.
    -@@ fetch-pack.c: static int everything_local(struct fetch_pack_args *args,
    - 				      ref->name);
    - 			continue;
    - 		}
    -+		if (o->flags & COMPLETE_FROM_COMMIT_GRAPH) {
    -+			if (!has_object(the_repository, remote, 0))
    -+				warn_in_commit_graph_only(remote);
    -+		}
    - 		print_verbose(args, _("already have %s (%s)"), oid_to_hex(remote),
    - 			      ref->name);
    - 	}
     
    - ## object.h ##
    -@@ object.h: void object_array_init(struct object_array *array);
    - /*
    -  * object flag allocation:
    -  * revision.h:               0---------10         15               23------27
    -- * fetch-pack.c:             01    67
    -+ * fetch-pack.c:             01    6-8
    -  * negotiator/default.c:       2--5
    -  * walker.c:                 0-2
    -  * upload-pack.c:                4       11-----14  16-----19
    + ## t/t5330-no-lazy-fetch-with-commit-graph.sh ##
    +@@ t/t5330-no-lazy-fetch-with-commit-graph.sh: test_expect_success 'fetch any commit from promisor with the usage of the commit
    + 	test_commit -C with-commit any-commit &&
    + 	anycommit=$(git -C with-commit rev-parse HEAD) &&
    + 	GIT_TRACE="$(pwd)/trace.txt" \
    +-		git -C with-commit-graph fetch origin $anycommit 2>err &&
    ++		test_must_fail git -C with-commit-graph fetch origin $anycommit 2>err &&
    + 	! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
    + 	grep "git fetch origin" trace.txt >actual &&
    + 	test_line_count = 1 actual
-- 
2.47.0.163.g1226f6d8fa-goog

