Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5333B9DA8
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199522; cv=none; b=NScZOHYSptyo8i9OHNEp58a3fdcidqBcSb5juVTs41atbjJ2O/Dnpffo1Bj5Ned+ArksrK+FYQAt3RQKfcBp9zwY9SyKvM6WHI/uBXga6y4s6ZlHITYIxFL0OhLpvVtmSin4m3lJJVF5bymu7HUCt0Ll4nW27RXyCbTyGzq76D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199522; c=relaxed/simple;
	bh=fKzbNNjAuoBHyu/zdxMw2ZqgeDq5hxiMr+t8ciHK4G8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DDPAdLATOwm4aht9Wil/T4ihwe2Frm8R5ygX5B5+B4bQHfHVJYN6BpvOfyt5IsxfT/wJKELqDbBp9JMhVSKrTZbOQbs/JLc2H9b306Qaq95GmtyfpQZooSzs7D3cmhDt99cixxx49tibiv+exTFeGg4p3KqKvvpNfi0p+7klirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mMcq0whd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=in4Emu5l; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mMcq0whd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="in4Emu5l"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D217014000CA;
	Wed, 23 Sep 2026 17:38:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 23 Sep 2026 17:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790199519; x=1790285919; bh=SBTBGvJ91I
	6/cYYkU80gUwXucA2It5VQjzQWJ1qAFoE=; b=mMcq0whdQYjJV09aVEEFBCdhrl
	mFX5qrHgwD29LvO8HMlDx8jGSSh+Adb8lTRgEuZJ6cp9n3Z3UTXwCTFSZeR544eC
	q9LHgaJ8iXBRyF/fQAhRajS6dgTrmK7bC0macoAshvG3cS7TvRS/19/XrLIVdhWJ
	HDJ7haatiKjxSYB2hrtoPp0oUlHc9suaf0NU5P5Y7O15X9rN/CsftO3f4CZenVAO
	qsziicd6GCrQSq0226CYTRpOXOJ8a+Boph651Kuo7JjKqkG/4hyVXEsz62ULum/6
	KW2yDUidJUeI+JGNvngsE8ufMcjRnzXLVIwScm7d8hvKSilc4rxcspmgR71A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790199519; x=1790285919; bh=SBTBGvJ91I6/cYYkU80gUwXucA2It5VQjzQ
	WJ1qAFoE=; b=in4Emu5lnjgv1/oD/fSw2+6ZfYZLTUAs8idF+n31RSH4OwiOYLE
	rWeZwJAZO0WTkidGQoQlriSQrKvBGtqKonXAChdLKkFB+HcoYhithKwTmii2xL+b
	6MxC/yiKA4O0S6zxMMz/wpOvKHI5ib6h7JJMRc/VkNyBpp4YdkVXLosEa0oWphPL
	vX4oFroOgLFI8pfWMArVPJE8SH9Hf/qUsNWskNXdKz8UtVGKZQS2VIJ8766gI/fa
	S+8oj4ld/P/5pPCiZi72GOMFCFS8n+Nrg2AytfQhYFmB1bo4Qt7lZjCNNPKnrss1
	bb8Ju0MF2tYkAJf0ZpVA+nw+MBmXD1C2HsQ==
X-ME-Sender: <xms:30a0aoIYPEH1-WKTVOYjmp28S4oeqZSnoAEQY-VqVgm8zl75PMdt2w>
    <xme:30a0ar185A8rXuioMS4mpyCEl17MzPrbrvxMZ5dEKw1CEyL_kxK9xFi9uttyUv8BF
    WWrgNeGYSgtUp0zmBQu_XRKBUgPTiwlHeYYNmnQ8oIW0Skmsf8S1A>
X-ME-Received: <xmr:30a0aihFWjmcFIzamJcpChnqGRjBX3nxNMTqU0QvPZQDxDsvSZ4OXZePdVMmq4CEZ9G0iEtRFrt_kHqozZK0oPBYvrRRCSsFYI6t>
X-ME-Proxy-Cause: dmFkZTGspn42LSODoZh3E57s8hfkTwGaq7pE32Ra4Kg4ini0zGsOwpan44wJlo8NL+SzMs
    ayrNAkn19wW2jgZICFFL6O7LEMiw08HLklYcYe+g1ZP2k8vkZomudJhc4nECtCaa4mrBJQ
    Gq/FxJ9go0kQedl/Y7VtZQ0e7jENQ4d1gGm/k+6LxROQjTO3SLm5yA/72elGHWFVMNsv9b
    czk56sqeEjcQA1VJa9EocOfm21MZkItHD5ZzQL5QALNdgFsqaLwnA8rRVySr4TpIOtCjbZ
    vU+/OrTXn4Fj8piiZ9pokp+grnOgTYHGT0bOv9mbV41zCeNTIcWYsshZ2ZtmGnJl5L4xE9
    kYsYSeMWspE+OYi02cpHNu3TxJKfubAs9z4Z96bGvQ0P6k1Fk5fK5QJF+ICaWu0fFpb25V
    /UJUGV9GnEYtrgUfqJgn5szsc/S6MAdZ6lNM/dPv9MEDtpAngC9eTfGqgigIrk4F5u+86r
    xiQr9oFREwdhL9s3Yww7mOS5ybdqzJlb2usHsU1aogbiYDLJJZnSrSr7Iq6two18WTa8sI
    gELK9Im24wDFGvgGYdLowcmBLfMCl1LH8UJNV7+VCd+lzAnWeaYRKAA/MbVw3qBTawB/SJ
    39cHUL4BxEq8mdkez9wtUjNuC/CewyuBaHCypvCLiUVowGKHXqZPfQdZhYLQ
X-ME-Proxy: <xmx:30a0asXRXtraLgcrBjBHFA-aG9E-MQaybnT_LRthWBX_aeRLqd01LQ>
    <xmx:30a0ahUe6Mh7I1dYc61Xa37zxyFgpRwu0KSLHgsNfYsSyR3BqVrMRA>
    <xmx:30a0asjLZ5auDd1DdvIRxFihWNv_k17_knWzLBY9yWyYpqcRwyRV-w>
    <xmx:30a0asbqr6UP784iBHsn1Vk5TyFdGMBEem8IvE-nKXiVDF8K4TpYPQ>
    <xmx:30a0avZJZtJbeQMIwPr5u4Tz0Ej-HZP0MmwQhUUizV8jYwvIJFpQnvXU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 17:38:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] fetch: avoid fetching every branch of a new remote
 in a shallow repo
In-Reply-To: <pull.2412.v2.git.git.1790195720941.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 23 Sep 2026
	20:35:20 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v2.git.git.1790195720941.gitgitgadget@gmail.com>
Date: Wed, 23 Sep 2026 14:38:38 -0700
Message-ID: <xmqq7bkb7in5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> git remote add sets a new remote up to fetch every branch by default.
> In an already shallow repository, that turns the next plain fetch or
> pull into a slow or hanging one, even when only one or two branches
> are ever used.
>
> Add a special fetch refspec, "+:", that fetches only the branches our
> local branches are built on, plus the remote's default branch so a
> brand new remote is usable right away, without needing to first set
> anything up to track it. git remote add now uses it instead of the
> usual wildcard refspec whenever the repository is already shallow.

That's way too much for a single patch.  It needs to be split into
digestible chunks, but I offhand do not know how many pieces are
appropriate, so let's think aloud together and try to refine the
design while we do so.

The outline of our design so far should give something like this in
our configuration file.

	[remote "second"]
		fetch = :+

	[branch "topic1"]
		remote = second
		merge = refs/heads/main

	[branch "topic2"]
		remote = second
		merge = refs/heads/next

In the "fetch only what we build on" mode, we would collect local
branches $X where branch.$X.remote == second and then collect
branch.$X.merge for these local branches.  In this case, we would
decide to fetch 'main' and 'next' branches in the end.

But notice that this does not give us sufficient information.  There
is no explicit clue that tells that the remote-tracking branches for
this remote 'second' should be stored under refs/remotes/second/
hierarchy.  A normal remote that is defined like so:

	[remote "origin"]
		fetch = +refs/heads/*:refs/remotes/origin/*

does not have such a problem, as it makes it crystal clear that
their branches go under refs/remotes/origin/ hierarchy.

So using "fetch = :+" is *not* a good idea, as I said.  Let's scrap
that syntax.

One thing we could do is probably to introduce

	[remote "second"]
		refmap = +refs/heads/*:refs/remotes/second/*

instead to give this clue (see "git fetch --help" for what a refmap
is; it looks similar to refspec but only defines how their refs are
mapped to our namespace without specifying what to be fetched, which
is exactly what we need here).  We do not use remote.second.fetch at
all.

It would be an easy first step to teach that an explicit

	$ git fetch second main next

with such a remote.second.refmap should behave the same way as

	$ git fetch --refmap='+refs/heads/*:refs/remotes/second/*' second \
		main next

in a repository without the refmote.second.refmap configuration.  As
"git fetch --refmap=... second main next" should already work, it
would be only the matter of supplementing the command line argument
with configured default.

Then teach "git fetch" to further treat

	$ git fetch --refmap='+refs/heads/*:refs/remotes/second/*' second

i.e., fetch with refmap but without specifying what exactly to
fetch, as a request to fetch their branches we build on (and nothing
else), using the refmap, in other words, the lack of "what to fetch"
in the above command line signals "git fetch" to rewrite the above to

	$ git fetch --refmap='+refs/heads/*:refs/remotes/second/*' second \
		main next

internally.  Since we have the previous remote.X.refmap step already,
it means that with remote.second.refmap configured properly, the
user can only say

	$ git fetch second

and it would do the right thing in our scenario.

Another and final step would be to teach "git remote add" to add

        [remote "second"]
                refmap = +refs/heads/*:refs/remotes/second/*

when you want to fetch only what you build on.  I am not sure what
should trigger the decision.  Your initial message said something
about shallow and sparse and an earlier review refuted one of them
(I do not recall which offhand, but probably sparse).  It probably
is a good idea to start with an explicit command line option to "git
remote add --limited-fetch" in a single commit.

And then add heuristics (like "in a shallow clone, this mode is
turned on by default, but an explicit '--no-limited-fetch' can
countermand it") in another commit.

So far, we identified four distinct commits, each bite sized.

 - remote.X.refmap configuration acts as if --refmap=... command
   line argument was passed.

 - passing refmap without saying what to fetch enumerates what their
   branches we build on, and pretend as if the user listed these
   branches on the command line to fetch.

 - "git remote add --limited-fetch" creates remote.X.refmap instead
   of remote.X.fetch as necessary.

 - "git remote add" without explicit "--[no-]limited-fetch" uses
   heuristics to enable it.

Or something like that, perhaps?
