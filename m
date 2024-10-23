Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B217753
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729643297; cv=none; b=DOUkLc7mSpfuEgPjhlrgpp2k4YpgWCB6nmfVwx3z+VyE+q8rDO9Hw84VEwyXuk0C7sGfVrQOXbNlmEby8kH5Fb29uGuKRkAtjsn4m0rK/WBXbNEHTMfPs/dYW+5imYT4MKpnIh2+Tv/XpTWQVBCQW9ZRMFnXDxm496W7Ezl0u3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729643297; c=relaxed/simple;
	bh=vA1Ic7CgmwIA4aY1czehzuigUKDzURLGqL7T5IYxsYY=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Yx9k96YFj9A3ABLj9kjeyDnWPi6T/VNEbAAvcZQqrZhKIkklOuLldKtCBOe1kKXLXxTXHDGHGrBDQ2s0ts7HrnmMc+tBbtZZK7V0zeZ5qw2cUde/cq99mxsY5a1Q/tj/h+5Rr2zs/Aqt6B1oIyKvC5mTwCdVqJoHVkmscNrvlno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iCiRgd1n; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCiRgd1n"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e292dbfd834so9498230276.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729643294; x=1730248094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zOwW4+6/qTyfwq/VYMpkEg33QVmOmEw8bZ6LrC8Vl1A=;
        b=iCiRgd1n0TkscB9cZMPj1535qBhimXnVv7gctO/SSGoaTn0za0vADYHASE2g3MAT1e
         HJs75OeDZPaVvfcqzuMLTCdlH1NMop37T8O6jmYA0Ed0HaLfTV2YAe4ZaJ/I0dWbhNDF
         SM/eVYxySbvG8kkcc+YEW5Z3/ZA+Z6Yffo/uPrXkUeYrzf7/VMky0o06WRx6qH0uXqIL
         X6yRRyML6+6Wuz+gpzSQ+fvaePharqGn1jF2+s8rr6fCjsxvrMcwHUjSlJ0uGgi7hA8t
         RQ3amHHwMfDCOvjuZG0oosJuhIYNJM2IWMQ4wk9vqZqI6xeRZsMgVz2fcrMM6SB/gQzJ
         RQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729643294; x=1730248094;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOwW4+6/qTyfwq/VYMpkEg33QVmOmEw8bZ6LrC8Vl1A=;
        b=V/d+57IUAqd3E4FjZDEOdJ4JE2iz432ez0S2EGtZORyeBWZPcxOGaMdy3KZafBbT/9
         +YEdqp1LHGhiqvlk91YRei4ooX6cQoYDOvQu+n/tzGmJG5MCWfFXyGD28Cgy1VGdpalG
         QNcm9oEaXkpw7/FHGEzBnAXoMUqsqsNb1v8zQ849oZ4Gk3qvjJpApVhTzoCzdV/p3xMs
         mSRGIhV2CmCtBiz4vUVLPjI6AcLKB0j7neTH2uvxI79ZRjasKR1doIVHJpWgYmTZyH4m
         NKzTruW8Br0wdKj/X8Xx82pkYu8zNLdVmTFB4c4hMdbIuiYlz+RVF8XFm1i30lPi6uXB
         rakw==
X-Gm-Message-State: AOJu0Ywk8OMLhNldBrla+cRftenPjFXzNr7zKNd6HGFH+LCaBvtsEwfx
	GpzvEBgLsyc5zoA/s3dRd0TiotuMmFXhVsHR+ilZEKVhutk/B9d0mRBJo5jV+OruAHeV8bSq3CK
	+EoVvrfyHmE3wHsGWi0U+k91sObhor/FxyVcAVfY9J87TkX7WM3+KZbo2hlgBYQHGE8IZ36OQ+p
	FrS343LFBvVGq2vjwlRu8HdZ84/bpZNnT5tc9lD6hoUWOFdRGeVQUFxyzjqrdL
X-Google-Smtp-Source: AGHT+IGKcdvaw6EmS69xCQcIGtnfqHE+owGixX0eKZtj93krau4k88DRiRrV5mEQxj14xHTymPHTfiJTv1lngs5a39I=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:5223:ac1b:7297:c5f1])
 (user=emilyshaffer job=sendgmr) by 2002:a25:bcce:0:b0:e17:8e4f:981a with SMTP
 id 3f1490d57ef6-e2e3a6e3c27mr781276.11.1729643293631; Tue, 22 Oct 2024
 17:28:13 -0700 (PDT)
Date: Tue, 22 Oct 2024 17:28:05 -0700
In-Reply-To: <20241003223546.1935471-1-emilyshaffer@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023002806.367082-1-emilyshaffer@google.com>
Subject: [PATCH v2] fetch-pack: don't mark COMPLETE unless we have the full object
From: Emily Shaffer <emilyshaffer@google.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, Calvin Wan <calvinwan@google.com>, 
	Han Young <hanyang.tony@bytedance.com>, Jonathan Tan <jonathantanmy@google.com>, 
	sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"

When fetching, we decide which objects to skip asking for marking
certain commit IDs with the COMPLETE flag. This flag is set in
fetch-pack.c:mark_complete(), which is called from a few different
functions who decide what to mark or not mark. mark_complete() is
insulated against null pointer deref and repeatedly writing the same
commit to the list of objects to skip; because it's the central function
which decides that an object is COMPLETE and doesn't need to be fetched,
let's also insulate it against corruption where the object is not
present (even though we think it is).

Without this check, it's possible to reach a corrupted state where
fetches can infinitely loop because we decide to skip fetching, but we
don't actually have the skipped commit in our object store.

This manifested at $DAYJOB in a repo with the following features:
 * blob-filtered partial clone enabled
 * commit graph enabled
 * ref Foo pointing to commit object 6aaaca
 * object 6aaaca missing[1]

With these prerequisites, we noticed that `git fetch` in the repo
produced an infinite loop:
1. `git fetch` tries to fetch, but thinks it has all objects, so it
   noops.
2. At the end of cmd_fetch(), we try to write_commit_graph_reachable().
3. write_commit_graph_reachable() does a reachability walk, including
   starting from Foo
4. The reachability walk tries to peel Foo, and notices it's missing
   6aaaca.
5. The partial clone machinery asks for a per-object JIT fetch of
   6aaaca.
6. `git fetch` (child process) is asked to fetch 6aaaca.
7. We put together the_repository->parsed_objects, adding all commit IDs
   reachable from local refs to it
   (fetch-pack.c:mark_complete_and_common_refs(), trace region
   mark_complete_local_refs). We see Foo, so we add 6aaaca to
   the_repository->parsed_objects and mark it as COMPLETE.
8. cmd_fetch notices that the object ID it was asked for is already
   known, so does not fetch anything new.
9. GOTO 2.

The culprit is that we're assuming all local refs already must have
objects in place. Let's not assume that, and explicitly check
has_object() before marking objects as COMPLETE.

NEEDSWORK: It could be valuable to emit a trace event when we try to
mark_complete() an object where we don't actually has_object() (to
understand how often we're having to heal from corruption).

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>

1: That commit object went missing as a byproduct of this partial clone
   gc issue:
   https://lore.kernel.org/git/20241001191811.1934900-1-calvinwan@google.com/

---


On the list, Junio and Robert Coup suggested that we should notice cases
when the list of object IDs we are trying to fetch gets filtered to
nothing during a lazy fetch. However, this turned out to be quite tricky
to implement - fetch-by-OID stores the OID in a ref object, so it's
challenging to guess that the ref we care about is an OID instead of a
normal ref. It also required some heuristic approach to catch the exact
moment after we removed COMPLETE objects from the list we wanted to
fetch, and to notice that the wrong objects were missing from that list.

(From the list of alternatives I included with v1, v1 was approach iii;
Junio and Robert suggested iv; this patch holds something close to ii.)

Jonathan Tan suggested that instead, we could be more careful about what
we mark COMPLETE or not; it seems like this is pretty straightforward to
do.

I do wonder if it's a layering violation to do the has_object() check in
mark_complete(), which is otherwise a pretty stupid function; I included
it there because all of the other flavors of mark_complete_* eventually
boil down to mark_complete(), so we wouldn't need to remember to check
for object existence any other time we're trying to do this COMPLETE
marking thing.

Note that I added a test to guarantee this behavior works, but without
commit graph enabled, the test passes both before and after; I guess
maybe it's better to add an explicit regression test for the
combination? But, this test fails with reftable - because we don't have
a way (that I know of) to force-create a ref with a bad ID, to force
this error condition. In the test as written I'm writing to
.git/refs/heads/bar directly; that doesn't work for reftable. But `git
update-ref` is too smart to let me set a ref to garbage. Any tips there
are welcome.

The CI run is at
https://github.com/nasamuffin/git/actions/runs/11470039702 - it seems
the reftable tests are the only things failing.

Also, I am sending this version, but if there are any additional
comments or it requires more changes, please expect Jonathan Tan to take
over driving this patch the rest of the way for me. As previously
stated[2], I'll be OOO after this Friday for most of the rest of the
year; the rest of this week I'm trying to get the rest of my
non-upstream loose ends tied up, so I won't have time to do another
iteration. See folks around Christmastime :)

 - Emily

2: https://lore.kernel.org/git/CAJoAoZnovapqMcu72DGR40jRRqRn57uJVTJg82kZ_rohtGDSfQ@mail.gmail.com/

Cover letter from v1 follows:

There are a few alternative approaches for this issue that I talked
about with some folks at $DAYJOB:

i. Just disabling the commit graph rewrite allows this to fall
eventually into a path where the fetch actually succeeds. I didn't like
this solution - it's just whack-a-mole - so I didn't look too hard into
why it succeeds that way. It *could* make sense to disable commit graph
rewrite when we do a JIT fetch with blob or tree filter provided - but
if later we want to implement commit filter (something we've talked
about at Google) then I'd worry about this situation coming up again.

ii. We could decide not to mark local refs (and commits reachable from
them) as COMPLETE in the_repository->parsed_objects. I didn't try this
solution out, and I'm not sure what the performance implications are,
but Jonathan Tan likes this solution, so I may try it out and see what
breaks shortly.

iii. We could do all the JIT fetches with --refetch. In my opinion, this
is the safest/most self-healing solution; the JIT fetch only happens
when we really know we're missing the object, so it doesn't make sense
for that fetch to be canceled by any cache. It doesn't have performance
implications as far as I can guess (except that I think we still build
the parsed_objects hash even though we are going to ignore it, but we
already were doing that anyway). Of course, that's what this patch does.

iv. We could do nothing; when cmd_fetch gets a fetch-by-object-id but
decides there is nothing more to do, it could terminate with an error.
That should stop the infinite recursion, and the error could suggest the
user to run `git fsck` and discover what the problem is. Depending on
the remediation we suggest, though, I think a direct fetch to fix this
particular loop would not work.

I'm curious to hear thoughts from people who are more expert than me on
partial clone and fetching in general, though.

This change is also still in RFC, for two reasons:

First, it's intermittently failing tests for me locally, in weirdly
flaky ways:

- t0410-partial-clone.sh fails when I run it from prove, but passes when
  I run it manually, every time.
- t5601-clone.sh and t5505-remote.sh fail nonsensically on `rm -rf` that
  should succeed (and does succeed if I stop the test with test_pause),
  which makes me think there's something else borked in my setup, but
  I'm not sure what.
- t5616-partial-clone.sh actually does fail in a way that I could see
  having to do with this change (since I guess we might download more
  packs than usual), but I was so confused by the other two errors I
  haven't looked closely yet.

And secondly, I didn't write tests verifying the breakage and that this
change fixes it yet, either.

I'm going to work on both those things in the background, but I wanted
to get the description and RFC out early so that folks could take a look
and we could decide which approach is best.

Thanks,
 - Emily
---
 fetch-pack.c             |  4 +++-
 t/t0410-partial-clone.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f752da93a8..8cb2ce4c54 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -603,7 +603,9 @@ static int mark_complete(const struct object_id *oid)
 {
 	struct commit *commit = deref_without_lazy_fetch(oid, 1);
 
-	if (commit && !(commit->object.flags & COMPLETE)) {
+	if (commit &&
+	    !(commit->object.flags & COMPLETE) &&
+	    has_object(the_repository, oid, 0)) {
 		commit->object.flags |= COMPLETE;
 		commit_list_insert(commit, &complete);
 	}
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 818700fbec..95de18ec40 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -241,6 +241,36 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
 	grep "fetch< fetch=.*ref-in-want" trace
 '
 
+test_expect_success 'fetching missing objects pointed to by a local ref' '
+	rm -rf reliable-server unreliable-client &&
+	test_when_finished rm -rf reliable-server unreliable-client &&
+	test_create_repo reliable-server &&
+	git -C reliable-server config uploadpack.allowanysha1inwant 1 &&
+	git -C reliable-server config uploadpack.allowfilter 1 &&
+	test_commit -C reliable-server foo &&
+
+	git clone --filter=blob:none "file://$(pwd)/reliable-server" unreliable-client &&
+
+	# to simulate the unreliable client losing a referenced object by
+	# corruption, create the object on the server side, then create only a
+	# reference to that object on the client side (without providing the
+	# object itself).
+	test_commit -C reliable-server bar &&
+	HASH=$(git -C reliable-server rev-parse HEAD) &&
+	echo "$HASH" >unreliable-client/.git/refs/heads/bar &&
+
+	# the object is really missing
+	# check if we can rev-parse a partial SHA. partial so we do not fetch it,
+	# but barely partial (trim only the last char) so that we do not collide
+	test_must_fail git -C unreliable-client rev-parse ${HASH%%?} &&
+
+	# trigger a remote fetch by checking out `bar`
+	git -C unreliable-client switch bar &&
+
+	# and now we have the missing object
+	git -C unreliable-client rev-parse ${HASH%%?}
+'
+
 test_expect_success 'fetching of missing objects from another promisor remote' '
 	git clone "file://$(pwd)/server" server2 &&
 	test_commit -C server2 bar &&

Range-diff against v1:
1:  092be0a655 ! 1:  4db6bbb4cd promisor-remote: always JIT fetch with --refetch
    - ## promisor-remote.c ##
    -@@ promisor-remote.c: static int fetch_objects(struct repository *repo,
    - 	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
    - 		     "fetch", remote_name, "--no-tags",
    - 		     "--no-write-fetch-head", "--recurse-submodules=no",
    --		     "--filter=blob:none", "--stdin", NULL);
    -+		     "--filter=blob:none", "--refetch", "--stdin", NULL);
    - 	if (!git_config_get_bool("promisor.quiet", &quiet) && quiet)
    - 		strvec_push(&child.args, "--quiet");
    - 	if (start_command(&child))
    + ## fetch-pack.c ##
    +@@ fetch-pack.c: static int mark_complete(const struct object_id *oid)
    + {
    + 	struct commit *commit = deref_without_lazy_fetch(oid, 1);
    + 
    +-	if (commit && !(commit->object.flags & COMPLETE)) {
    ++	if (commit &&
    ++	    !(commit->object.flags & COMPLETE) &&
    ++	    has_object(the_repository, oid, 0)) {
    + 		commit->object.flags |= COMPLETE;
    + 		commit_list_insert(commit, &complete);
    + 	}
    +
    + ## t/t0410-partial-clone.sh ##
    +@@ t/t0410-partial-clone.sh: test_expect_success 'fetching of missing objects works with ref-in-want enabled'
    + 	grep "fetch< fetch=.*ref-in-want" trace
    + '
    + 
    ++test_expect_success 'fetching missing objects pointed to by a local ref' '
    ++	rm -rf reliable-server unreliable-client &&
    ++	test_when_finished rm -rf reliable-server unreliable-client &&
    ++	test_create_repo reliable-server &&
    ++	git -C reliable-server config uploadpack.allowanysha1inwant 1 &&
    ++	git -C reliable-server config uploadpack.allowfilter 1 &&
    ++	test_commit -C reliable-server foo &&
    ++
    ++	git clone --filter=blob:none "file://$(pwd)/reliable-server" unreliable-client &&
    ++
    ++	# to simulate the unreliable client losing a referenced object by
    ++	# corruption, create the object on the server side, then create only a
    ++	# reference to that object on the client side (without providing the
    ++	# object itself).
    ++	test_commit -C reliable-server bar &&
    ++	HASH=$(git -C reliable-server rev-parse HEAD) &&
    ++	echo "$HASH" >unreliable-client/.git/refs/heads/bar &&
    ++
    ++	# the object is really missing
    ++	# check if we can rev-parse a partial SHA. partial so we do not fetch it,
    ++	# but barely partial (trim only the last char) so that we do not collide
    ++	test_must_fail git -C unreliable-client rev-parse ${HASH%%?} &&
    ++
    ++	# trigger a remote fetch by checking out `bar`
    ++	git -C unreliable-client switch bar &&
    ++
    ++	# and now we have the missing object
    ++	git -C unreliable-client rev-parse ${HASH%%?}
    ++'
    ++
    + test_expect_success 'fetching of missing objects from another promisor remote' '
    + 	git clone "file://$(pwd)/server" server2 &&
    + 	test_commit -C server2 bar &&
-- 
2.47.0.105.g07ac214952-goog

