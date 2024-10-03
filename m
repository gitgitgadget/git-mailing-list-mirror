Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D21ABEB4
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994958; cv=none; b=a/sWmy39cTR9PALVkwMt/UFCvdlKbtnIUnkwvjzwcmQOZfZMMnuwT5Du0S75U+ylTakZaCevoKw4QfFQT8JBgLQ+ZYBZwlr7Pq/KvpxzdRY0wf/H/j44t6Z/+74apa5sXXnE44E+porDEp1dXhXO8Lgc6Yx10dGPPjktfRm0xD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994958; c=relaxed/simple;
	bh=Dk00s98uP4nfYnR2G9m/i1fLRVij9+AEvsv5dUZafIA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pJouArg/WkuJxmdEiai4V9B7aafgjZfbP1VtEQLKV3kgQXKK1NelnxdVonduS4fopQIyshUdEIj+wrM8z870Ve9AKsLWnjejD6+Zps53pqvaIZvoIF8rzjTft3nddSALancttDN/vY7UGj+60Eurzc8j8P9Gtxnx/I2KIy4F/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fc07i6+k; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fc07i6+k"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25cd76fb92so2673468276.3
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 15:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727994956; x=1728599756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fBhx6aLRxhxQmKOZufQjUeALKTX6QMyAdQ1BHZP8UtM=;
        b=Fc07i6+kzFbPzt8r6RM1UxtM0mBmhnjHQcTFOtn9Bw8l1Hwvd6kxW28b4ezWKxSNug
         vLtgSRYU0IcRcCs6XW6MTsSVcnd/S4XX72GRWtpvLXbt+0L1oWottkVbhZziloCDVWuM
         yFTFvDGnCz3Qq6AKptIxIfWm4MpDJ8kjl4XCHXblCPxZQ4fCHx+ShyxYWQf8+7cMb2KL
         4D9lzKussUGLdeyaG8vdtSPCtt8HExWAa+EOhYV10scGuFh6nQeg6V5tk+1G6GxTb0Jv
         xwSYtTJtomvHNTcN2YYrGgocS6Z0xwfgFi5RyumC4Y3BA9RjBrXAf40CCdgg6YFMcpnG
         C31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994956; x=1728599756;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBhx6aLRxhxQmKOZufQjUeALKTX6QMyAdQ1BHZP8UtM=;
        b=YpN+wsZjgr0ui3PEjYtFS2VFb4cmfqhjfBdDKfcPwNFHf4N/nMxb0ycMsKuvRkChwD
         VGvUo9xCh/Fj3i4+rRnNHKLFdXRnYP0IBfxayHg0zMDXQBW4dGOfO6kgiZ43Mp+7E2Bl
         MliVG0NVeL/xsJqzY4+9lemTpDV71H1ZhnT3ogL4dPXnxQMh+wT77EGTwaPbyQtqCQVk
         zsu/LKJ/diAypca0Z0Xzp3/mgtFzWJUvZbWMTbvazsmsbV/npBl7ovCCZci3bUUnW+AX
         F15R0DclnDp1kffxOH0cIpWoE6Ln5M6/ji5hBfr4k1LQVpTjuDrS8RPaT4VVl9ULQK0R
         tFYw==
X-Gm-Message-State: AOJu0YwLF54bJs5WVg93uUarsB6rylGiUw6cfUkRm5zU1BlgTOfugSo2
	eIW5bj6fvzuwU9/xn29LKhveRdTbTIyYNjyww6rXPt3tTpBR4+yhjARwF1T8XsQN2aLEIbFV/er
	/gkLxpVoVNKOm/Yon1Gs9JVee9ZSb5YlOAhynbHXepvl7Km4rhPNVEk51Iw0zX7M4UCgjC4HHrf
	KemHjHyrqTT9PEtYLaHBCF59cULDY2bS+LaNpTwD0s4Pp3sOFcDcClmTORH0QX
X-Google-Smtp-Source: AGHT+IFikeJOtbkV3B+eMg/w1EBhKYg4VN8C4bOO7pUhU/SvB6+1UPbYHQnTcsVZNRr0tqzUP0wb6poFwP7rsKy7Ub4=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:e2f8:2728:c78a:470a])
 (user=emilyshaffer job=sendgmr) by 2002:a5b:10e:0:b0:e25:6656:c144 with SMTP
 id 3f1490d57ef6-e289393e38cmr506276.9.1727994955418; Thu, 03 Oct 2024
 15:35:55 -0700 (PDT)
Date: Thu,  3 Oct 2024 15:35:46 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003223546.1935471-1-emilyshaffer@google.com>
Subject: [RFC PATCH] promisor-remote: always JIT fetch with --refetch
From: Emily Shaffer <emilyshaffer@google.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, Calvin Wan <calvinwan@google.com>, 
	Han Young <hanyang.tony@bytedance.com>, Jonathan Tan <jonathantanmy@google.com>, 
	sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"

By the time we decide we need to do a partial clone fetch, we already
know the object is missing, even if the_repository->parsed_objects
thinks it exists. But --refetch bypasses the local object check, so we
can guarantee that a JIT fetch will fix incorrect local caching.

This manifested at $DAYJOB in a repo with the following features:
 * blob-filtered partial clone enabled
 * commit graph enabled
 * ref Foo pointing to commit object 6aaaca
 * object 6aaaca missing[a]

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
objects in place. Using --refetch means we ignore that assumption during
JIT fetch.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>

---

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

a: That commit object went missing as a byproduct of this partial clone
   gc issue that Calvin, Jonathan, Han Young, and others have been
   investigating:
   https://lore.kernel.org/git/20241001191811.1934900-1-calvinwan@google.com/
---
 promisor-remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 9345ae3db2..cf00e31d3b 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -43,7 +43,7 @@ static int fetch_objects(struct repository *repo,
 	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
 		     "fetch", remote_name, "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
-		     "--filter=blob:none", "--stdin", NULL);
+		     "--filter=blob:none", "--refetch", "--stdin", NULL);
 	if (!git_config_get_bool("promisor.quiet", &quiet) && quiet)
 		strvec_push(&child.args, "--quiet");
 	if (start_command(&child))
-- 
2.47.0.rc0.187.ge670bccf7e-goog

