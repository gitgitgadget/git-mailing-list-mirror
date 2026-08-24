Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5973815D3
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 05:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549423; cv=none; b=b4+SOfmTI0u4pR7dUOUqTiO3/K2AJsY3eIswyqXZDnASvuulALfUJeOssFJADtf3ZMcUqPiw9zIMNSx5jhzal8W/uYglMW0bpbNlKi1EWeitREEpyxTP7Juq3ujHtX1oFVxKKCMYuMgvcpOXbFHQF3sooc0IYzL/b+PlS4ciU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549423; c=relaxed/simple;
	bh=1f7Kw8vZYrYjeFfmVq71EJyU2L4sY068HoT5Tfb5hWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK+0OL9CiaBuBsNYfgLecqKePR5Nq+A6bnQeFul0qVivQg/EOpdZYVMBYtayqc/HqzIMWEWxHaz/CDXKCivDhzPmK9m3oWFpl2sJGoh1T75fZqdkpey79QPaicihQZ/9fjOaYuXOsruOq6qaeoWp54ycjROBD5es9isWFLPErzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GTifQkvS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QBDFDCII; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GTifQkvS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QBDFDCII"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id F3FF41D0006B;
	Mon, 24 Aug 2026 01:30:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Aug 2026 01:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787549420;
	 x=1787635820; bh=QnLqRPv0+B4nvEzwHqTQ4mVuCZd362l0RTE598BfNH8=; b=
	GTifQkvSrJcckfwtkXH13joWrLUhruJ7LqiNWkMkKxq1f70WqgY6EfeNUiKDvhN7
	uR6B/XnbByt7Kz/lo15WXYlLYbxWUg+h4ZOyJWjZrmSVhht9b9MCk8D24R8F7JE5
	AGxiuaw2VBM4ny96Cl8ElMCxmgp8B6g13Wfx5IHm//82aOJ4YYB9BPJrTIvH16Fr
	E3u7vU44G1scrNb93KCbtScQPuGkU3UT5kBnD1xCjCcsnZsZlOu2Hz7aMb02cUJP
	t04KsQvth4n0Gg2hb/kBjjmHZ/us4IagX4nFNbCRt+ffa38RMd+uqcuJBTx0J8BF
	Wt0wUi14JDGiq+tRE3xs8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787549420; x=
	1787635820; bh=QnLqRPv0+B4nvEzwHqTQ4mVuCZd362l0RTE598BfNH8=; b=Q
	BDFDCIIzjRLqSeFTsZL8lBh79M2pQYVkm0d+1OfgQhnSaGMtCJkhe+8YtY5xQ/Hc
	GB+H/UPb/8VjPg2KygGyU/QYfTqpEkXnkUWqPIJP1BsHxY88Szgpt0rt6kaEhXu7
	lcHrFFn8c7R9mr3cC6OhF5i5lpA3uJLLBvCtMKNcDA1TMgPOzh3+VhfMM2R9hyRP
	M/RHsCSldXG92EJQKtdzYKjTJ0Fi9AeLP3LRb97Aq1PlvpkvLF2oOLr2EXgRhnjF
	9xSdodI8aOFK03uyzC2w8B9Wi14oyWa1Jd4DR6n16N9xn+G+IrzJS3GD5nvpIiNy
	uALtDUOjJwrLMTxhb4chg==
X-ME-Sender: <xms:7NaLaltISWfqQfQzaffrHWRKo5tOcS1D49XEpfR2FuV5OtqitXqXmg>
    <xme:7NaLal6I6yCqpygHkIq0qo7a1fDa9YGHCRPNun2IfcMD7oq8homnjzFMrdQIE2UJV
    vXXQCiCEhYEqbplTpOo_ZNfNfFRpXk9HGR9femsRwlTxv3LlDKKkiI>
X-ME-Received: <xmr:7NaLamKM8w8_Ktl97E4EjKC25k9RjvxK7bF68PZvSSfOdMJ3ZbC18vxEMagTwEGaGVY-93psRqWQUTmXRvSDJ5Ldq-2vDYzo4HymDnlchA>
X-ME-Proxy-Cause: dmFkZTGadQQwUohkrZfRUqGVciTjdoydTYbcHCNgtJ3QHzTMFRvt23aSliOZ+njoGl7ejQ
    A29lXrQM4/RYeRQaQchb91m+fp1n0pZF1pgbvP2m9ujYE/mpJfio9yfFe4DdtoEAUqB+CE
    TuNEzHgmfNVhuxw8YKzArWnSz+txKhaVS2x2gX2+/xuVbe05ulLORM4ixXj6BNs5vGfLk1
    RpqCq1PXXmUH02lY1Li+oTPPyMYQfNSgiASuk9EayYlDsNZ4BV9gnNVWePTbL2ZxdWaro2
    wFBNYGDYe57yjm5g9n+u6cnxP5L94uwpQJDSR9TgvkDw7PCq5LPAxOeYrqexU//ygPzwE8
    T2GGnNE6FGNoVOgJeWtcN6FCckj6hecfJNTQnApJew+RQUjkl+oNFlLmDbgduskc41ie/O
    X5TkHtO8Jngcv3MbEDha5prNtxuraIrcK7YYTikY+8s2wTrTgmiUOemzlAXLWnw1L5l/uW
    l7rC0sgqpBhOymkijv0QINDJg8rouZxWDmaVyii25psNTIGoak0oo+R7B8MEKt8fZN5b4Q
    UgZpDDp7ycFfpbfC9Bcztou7xRWp3rTA8ttyvLjOYYCmB7KozkaNce6tuiCv95TsWeR7q8
    pgBX6pA+VQn3hhWel6Z1dXJgaXPk/u29zcLaxCPNHI4ZBiRZnCOt+6O2bTmg
X-ME-Proxy: <xmx:7NaLal5V9ekVzIrMW3Hmwu7hdSp1YZ9I-9t4pJFPQ36E9Cw__6OU_g>
    <xmx:7NaLapxIMakENOQjHXz56yJOKt4U1J2mWY8JjbLidx-eLpHSkmqUiQ>
    <xmx:7NaLapaTmZNEm-oXXXBJiC268Qj-xbkX1Z1TcckYID8GrPuQ6Pgx8Q>
    <xmx:7NaLarSkF2NstMVz48cENtLgOQV-iNOmXls_CbifZ3mTJh5Om-ukZw>
    <xmx:7NaLaoU2hH9wkr_-kvtQ8TeGqmhUa6hYxF6k0bPWfncEDEHk16EE8wwS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 01:30:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5a43021 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Aug 2026 05:30:17 +0000 (UTC)
Date: Mon, 24 Aug 2026 07:30:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] send-pack: avoid sending the whole tree when pushing
 from a shallow clone
Message-ID: <aovW5bxu1F8jYKYl@pks.im>
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
 <aohP7GMx9oX3ZCsQ@pks.im>
 <CABPp-BHJj-b=ieva3-=zaCAyvn5UtNQqNT0Q76YCpqZAjO-8VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHJj-b=ieva3-=zaCAyvn5UtNQqNT0Q76YCpqZAjO-8VQ@mail.gmail.com>

On Fri, Aug 21, 2026 at 10:36:04AM -0700, Elijah Newren wrote:
> On Fri, Aug 21, 2026 at 6:17 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Fri, Aug 21, 2026 at 06:55:51AM +0000, Elijah Newren via GitGitGadget wrote:
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > When pushing from a shallow clone, even if we only have made a small
> > > one-line change to a tiny file, we often push the entire toplevel tree
> > > of files.  For large repositories, this could be gigabytes instead of
> > > kilobytes.
> >
> > Oh yeah, that issue. It's a common foot gun indeed, and the common
> > advice here is to never clone with "--depth=1", but always with
> > "--depth=2" so that there is at least one non-grafted commit available
> > on the client so that they can indeed perform proper negotiation with a
> > server. But over the years I had to explain this again and again, so it
> > is clear that this common knowledge might only be commonly known to
> > people who have spent way too much time in the Git codebase.
> 
> I don't think --depth=2 actually helps here.  What enables real
> negotiation is push.negotiate, not the extra commit, and
> push.negotiate works just as well at --depth=1.
> 
> Without push.negotiate, send-pack's only negatives come from the refs
> the server advertised filtered by what we actually have.  In the
> foot-gun scenario -- clone shallow, server advances, then push, using
> depth of 2 just walks one commit further to the graft and then
> re-sends the whole tree anyway.  Running the four combinations (server
> advanced after clone, optimization disabled) in a small test repo:
> 
>     depth=1, push.negotiate=false:  Enumerating objects: 205
>     depth=2, push.negotiate=false:  Enumerating objects: 208
>     depth=1, push.negotiate=true:   Enumerating objects: 4
>     depth=2, push.negotiate=true:   Enumerating objects: 4
> 
> --depth=2 without negotiation is if anything a hair worse, while
> negotiation fixes it regardless of depth (the negotiator offers the
> shallow graft commit itself as a "have", and the server ACKs it).
> 
> --depth=2 can in rare cases help, but only in the lucky/accidental
> case where some advertised ref happens to point at the extra commit
> you now have.

TIL, thanks. I don't think I was even aware of "push.negotiate", and I
mostly went by the folklore of "just clone with --depth=2" that I saw
repeated on many sites.

But this and all of your other answers make me lean strongly into the
direction that the fix is at the wrong level, and the proper fix really
is to enable "push.negotiate" by default.

> > It's a good question to ask. In theory though, can't it happen that the
> > client changes the commit in question locally, e.g. via `git commit
> > --amend`, and then pushes? If we now assume that the local commit exists
> > on the remote side then we'd be insufficient information to the server.
> 
> Oh, wow, I had never thought to amend a shallow graft.  As soon as you
> asked, I assumed it'd create a corrupt repo -- a commit that wasn't
> itself a shallow graft but had parents we didn't know about.  I got
> surprised in a different way, though: commit --amend treats a shallow
> graft as a parent-less commit, and thus creates a new root commit.
> That does avoid corruption, but only by providing a different kind of
> foot-gun.  (If users really wanted a new root commit, `git
> {switch,checkout} --orphan` is the tool to do that.)
> 
> Since we've got another place where commit --amend can serve as a
> foot-gun that I've long meant to fix up, I'll submit a separate series
> that'll make it throw errors for both cases.

That makes sense.

> > [snip]
> > >     Users can work around the problem described in this patch with
> > >     push.negotiate=true, but while we can educate some users to set that,
> > >     trying to get them all to do so is quite unlikely. Let's help users by
> > >     providing sane default behavior.
> >
> > Makes me wonder whether the default is something that we should adjust
> > so that this defaults to enabled. Are there any downsides to doing so?
> 
> The only one I can think of is that it adds a round-trip to every
> push, which increases latency in order to sometimes reduce bandwidth
> and cpu.
> 
> It can dramatically reduce bandwidth and cpu, but not always (single
> person projects would probably never see a benefit, for example, nor
> would anyone interacting with a fetch v0 server), and it always
> increases latency.

That's all fair, but it does dramatically help in the case of shallow
clones. And the number of times I've seen this question come up hints
that this is a very common scenario.

We could be clever about it: if "push.negotiate" is very likely to help
in shallow clones but mostly just adds latency in full clones, then why
don't we introduce a new "push.negotiate=shallow" option that enables
this feature automatically for shallow clones and make it the default?
That to me sounds like a low-hanging fruit, and I would prefer such a
fix compared to introducing new logic.

Patrick
