Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA3219A81
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770922699; cv=none; b=P4seNdlXdDlmtfMV0DE9XPs38FcpL/Izyk544Qh2AwysFU0weoh5yrdFipBd3t0GhtEcYHAFAybsvxaMaST5jafQ5nk3WJ0SkdjJf54Yo5yGQgNuTGu8m2qmXhI7NLPyCYt+M23an3JPWYedL1Dfc4u+AWOr0BX57VYqlbwr+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770922699; c=relaxed/simple;
	bh=XK2eJzUL0PsRiGAg2GWrcRA8gG3Vb4dmmqKquatiV2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PnzQyNKjhClb8ZJamN7wwvlAEtoq5Ukb6Gpn3/x34ZbrQGNHUGfwy2y1cRxIQjDmExaKpbxfuBMdpP0kZgyxZKN+Kj4qAtG9WIWXfAA1kUpm+HopFFQJNq3coxeGcw0N2+JG7sO2IgUd4gjag5rG51BQdKppK2e+O/vDaMSDWBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rYBLWv29; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vr1tuPOz; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rYBLWv29";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vr1tuPOz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A16E31D001B3;
	Thu, 12 Feb 2026 13:58:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 12 Feb 2026 13:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770922696; x=1771009096; bh=b+6xRLR+xk
	QTnQ/0aH41ozkJ4+IRFWLy6ISkHqe4/2w=; b=rYBLWv29/qzFKDmsPShaCKVrGA
	CAYVRaaU9IwDrHtzT3U9gfiJRe+Nq8VmK2Kj/8jgvmpxa91ztu730V+r4DtYXXGl
	uWb57ye2pQ6jlkHTIRV0D1fVW5Zsix6mgw+NOjroMXbaCgz5IoTVXrWZhSYhvrNv
	QnpmSanVGEl4PdPp84VBJ4fd2qc+i95sfvdetQHSWo7RsU4WbXuWbWHx7Efbc77Z
	oe8j31Trx0XM6Dq3bgGFLu+2xPJ6G0W1rEtxjjO86UIdJ/H9Gt6sOT6FpmATv1Lb
	48x7yhfcOnkdO3xZuoYjelwhbPN+snRw4I6z4DNlnvzGAE5SzRME2785OJIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770922696; x=1771009096; bh=b+6xRLR+xkQTnQ/0aH41ozkJ4+IRFWLy6IS
	kHqe4/2w=; b=vr1tuPOze8LTOUbaPbcwwd132yBG1zVLtC6jIaB25t4MEKGai6X
	qWKlf+zsa/H26d+Aaq26rt8xBq5JL6k5+1gvB9itnfz+WjSJbGEs1vHtXqOfYBm+
	YrErT0S63NY7TTCd7WfPS/g84pB00wt0cTb+muEvqzNEucD7Y4VpJK5vB0Y4wnI6
	7eE/GbsztYdzswuww/Sll8m271gLgqye84aBiuvxLbHaHA389s2lNuVhwEETgM1R
	HPrmqEYwUHjii53pLdkPPtnp4bSKlAmv0npWQiMgu+qryWzvoUSO9itzVyKNpzN0
	+spAShqtdPvfhBs0VgY6EtT5I675LHkkJ/A==
X-ME-Sender: <xms:yCKOaQDwvh6IYBb5LUd45xuMZAylPtsgtYAaXkEjWnzaPavAmUWeWg>
    <xme:yCKOaVw4ahdXmQsyjY25mJDNY3gza7J3UOvwK4Ph1L0GBTydoD0ls9HRy9Js93_Uq
    EqZxKpl4hMJCzvvsSxe7Ru7X-OlrQj5OaNnFQdF1Ofq1wKqvbwQwg>
X-ME-Received: <xmr:yCKOadAqdwxP8nqoewPm7d0GU_RbwWBCKEL3DLdk5hKZempLUSCu2Hcod0yrfiVI0uE0XM9on_xDL5qXT9pm88JGPv_UgVNcjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeiudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeevvdeiieduteevuedtieeuheejve
    dvfedvvefggfeiheehleeugeelfeefgfehtdenucffohhmrghinhepughifhhftghorhgv
    qdgsrhgvrghkrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghnhigrnhhgrdhtohhnhiessg
    ihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yCKOaSaWVaF00-TRsHEhjG_9I9j7w7MiAgThBwGAX1ISxZigUo7fMg>
    <xmx:yCKOaViT8P_1jcVuqT35zsZZfuuAprxNqoRQ9kB-OdWKcvjE3tIwMQ>
    <xmx:yCKOaU7WwrC5pE_U9ZRFB9B-6b2_l4lGyXHVTI1l-_F9EE_dQEI24g>
    <xmx:yCKOac4TluYkwrAQ2LArv7wCVBk1sY2UZtDghODX8z94CmqF5HxdxA>
    <xmx:yCKOaaY7vZIKY3eH2plXaZlelPULp_3yShFIgHtb-F-mERUZfDmebmkN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 13:58:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] diffcore-break: prevent dangling pointer
In-Reply-To: <20260212072002.2347-2-hanyang.tony@bytedance.com> (Han Young's
	message of "Thu, 12 Feb 2026 15:20:02 +0800")
References: <20260211041128.48412-1-hanyang.tony@bytedance.com>
	<20260212072002.2347-1-hanyang.tony@bytedance.com>
	<20260212072002.2347-2-hanyang.tony@bytedance.com>
Date: Thu, 12 Feb 2026 10:58:14 -0800
Message-ID: <xmqqseb5okl5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han Young <hanyang.tony@bytedance.com> writes:

> After we have freed the file pair, we should set the queue reference to null.
> This prevents us from encountering a dangling pointer later on.

I sense that "This prevents ... later on" needs further be
clarified, since it is totally unclear what "later on" refers to.
We are done with the old filepair, and have no reason to revisit the
q->queue[] item ourselves, but somebody later attempts to use it.
Who is it and why does it do so?  That is a natural question readers
of the above description would ask, isn't it?

    Side note: I am guessiong that this is similar to the problem
    fixed with recent 56d388e6 (diff: avoid segfault with freed
    entries, 2025-12-29), where pointers in diff_queue->queue[] that
    point at file pairs that have been freed were mistakenly used by
    diff_queued_diff_prefetch() to populate them.  Is a prefetch
    happening in "git reset --mixed" that calls read_from_tree()
    which calls update_index_from_diff() via do_diff_cache()?

> The test uses git reset to trigger prefetching after break-rewrites have freed
> the file pair.
>
> Signed-off-by: Han Young <hanyang.tony@bytedance.com>
> ---
>  diffcore-break.c              |  1 +
>  t/t4067-diff-partial-clone.sh | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/diffcore-break.c b/diffcore-break.c
> index c4c2173f30..9b11fe2fa0 100644
> --- a/diffcore-break.c
> +++ b/diffcore-break.c
> @@ -222,6 +222,7 @@ void diffcore_break(struct repository *r, int break_score)
>  				free(p); /* not diff_free_filepair(), we are
>  					  * reusing one and two here.
>  					  */
> +				q->queue[i] = NULL;
>  				continue;
>  			}
>  		}
> diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
> index 72f25de449..a980cd30a0 100755
> --- a/t/t4067-diff-partial-clone.sh
> +++ b/t/t4067-diff-partial-clone.sh
> @@ -132,6 +132,36 @@ test_expect_success 'diff with rename detection batches blobs' '
>  	test_line_count = 1 done_lines
>  '
>  
> +test_expect_success 'diff succeeds even if prefetch triggered by break-rewrites' '
> +	test_when_finished "rm -rf server client trace" &&
> +
> +	test_create_repo server &&
> +	echo xyz >server/foo &&
> +	mkdir server/bar &&
> +	test_seq -f "line %d" 1 100 >server/bar/baz &&
> +	git -C server add -A &&
> +	git -C server commit -m x &&
> +
> +
> +	echo xyzz >server/foo &&

The blank line above does not have to be doubled, I think.  So the
first commit yas "xyz" in "foo", and 100 lines 1..100 in "bar/baz".

> +	rm server/bar/baz &&

We are overwriting it, so I am not sure why this "rm" is needed.  Is
it necessary to avoid reusing the same i-num for the file to avoid
racily clean condition, or something?  I find it unlikely because
the length of the new contents ...

> +	test_seq -f "line %d" 90 190 >server/bar/baz &&

... is different from the original.

> +	git -C server add -A &&
> +	git -C server commit -m x &&

In any case, the second commit has "xyzz" in "foo", and different
100 lines 90..190 in "bar/baz".

> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --filter=blob:limit=0 "file://$(pwd)/server" client &&

And we grab both commits and their trees, but not any blob.

> +	# Fetch bar/baz without fetching foo.
> +	git -C client checkout HEAD~1 bar &&

And we move "bar/baz" back to the 1..100 (the tip of the history
immediately after cloning had 90..190).

> +	# Ensure baz has diff
> +	git -C client reset --hard HEAD &&

I am not sure what the comment wants to say.  Before this hard
reset, we did have modification relative to HEAD in bar/baz; with a
hard reset, we are ensuring that everything including bar/baz
exactly match HEAD, aren't we?

> +	# reset's break-rewrites detection will trigger prefetch

"reset's break-rewrites detection" -> "break-rewrites detction in reset"
or something to avoid the "'"; otherwise you'd get

    error: bug in the test script: not 2 or 3 parameters to test-expect-success

You rewrote this line as a part of the last-minute change before you
ran the test for the last time, or something?

Anyway, starting from the "everything clean wrt HEAD" state, we try
to move to the HEAD~1.  We already have both 1..100 and 90..190
versions of bar/baz (and HEAD: and HEAD~1: trees), and we have the
contents for foo in HEAD, which is "xyzz", but we have never seen
HEAD~1:foo so far.  "reset --mixed HEAD~1" requires us to obtain
it...

> +	git -C client reset HEAD~1

... and cause us to run the prefetch to obtain "foo", but it runs
do_diff_cache() and makes it notice bar/baz has changed too much?

Your "do not leave q->queue[] dangling, as other people may still
look at them" fix certainly is a good hygiene, but I have to wonder
why we are doing break detection in this case in the first place.
For the internal "Let's figure out which path have changed, so that
we re-read only those changed paths" invocation of diff machinery,
we should not be doing so.  A break detection is to see if the
change in the contents of a single path is a total rewrite, and
regardless of the answer, the fact that the path was modified does
not change, update_index_from_diff() would work on the path anyway.
I also suspect that, if we are doing rename detection in this call
to do_diff_cache(), it is a totally wasted effort.  We may want to
take a deeper look at it, possibly outside the theme of this more
focused fix.

> +'
> +
>  test_expect_success 'diff succeeds even if entries are removed from queue' '
>  	test_when_finished "rm -rf server client trace" &&

By the way, I find it highly curious that with the following patch
to revert the fix with a bit of extra output sprinkled to your
tests, the problem does not reproduce reliably, which may indicate
that your test may be flaky (i.e., timing dependent).  Am I doing
something bogus in the patch?

 * revert of the fix in diffcore-break.c is a deliberate attempt to
   reproduce the problem, and "echo/cd client/ls" are for inspection
   so you should not take it in your final version.

 * removal of double blank lines is a style fix I'd want you to take.

 * "reset's" fix is a shell script syntax fix I'd want you to take.

Thanks.


diff --git c/diffcore-break.c w/diffcore-break.c
index 9b11fe2fa0..c4c2173f30 100644
--- c/diffcore-break.c
+++ w/diffcore-break.c
@@ -222,7 +222,6 @@ void diffcore_break(struct repository *r, int break_score)
 				free(p); /* not diff_free_filepair(), we are
 					  * reusing one and two here.
 					  */
-				q->queue[i] = NULL;
 				continue;
 			}
 		}
diff --git c/t/t4067-diff-partial-clone.sh w/t/t4067-diff-partial-clone.sh
index a980cd30a0..b5a35ded99 100755
--- c/t/t4067-diff-partial-clone.sh
+++ w/t/t4067-diff-partial-clone.sh
@@ -142,7 +142,6 @@ test_expect_success 'diff succeeds even if prefetch triggered by break-rewrites'
 	git -C server add -A &&
 	git -C server commit -m x &&
 
-
 	echo xyzz >server/foo &&
 	rm server/bar/baz &&
 	test_seq -f "line %d" 90 190 >server/bar/baz &&
@@ -153,12 +152,22 @@ test_expect_success 'diff succeeds even if prefetch triggered by break-rewrites'
 	test_config -C server uploadpack.allowanysha1inwant 1 &&
 	git clone --filter=blob:limit=0 "file://$(pwd)/server" client &&
 
+echo after clone &&
+(cd client && ls -l foo bar/baz) &&
+
 	# Fetch bar/baz without fetching foo.
 	git -C client checkout HEAD~1 bar &&
+
+echo after checkout HEAD~1 bar &&
+(cd client && ls -l foo bar/baz) &&
+
 	# Ensure baz has diff
 	git -C client reset --hard HEAD &&
 
-	# reset's break-rewrites detection will trigger prefetch
+echo after reset --hard HEAD &&
+(cd client && ls -l foo bar/baz) &&
+
+	# break-rewrites detection in reset will trigger prefetch
 	git -C client reset HEAD~1
 '
 
