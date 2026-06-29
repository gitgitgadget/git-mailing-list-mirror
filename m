Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B8391E6D
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782712650; cv=none; b=UZ+IfzY382aQ4605u39rUcv3hWv+EQJWRchM6W4u21+MbReNpeH0YX/Ru26pOyilCghiG9/Q61C6NOYxH+cBxFckGa0njy2Iq+lvmUFFbetNAoDNSw91llPnn05N5hResfafoc8CJPRqfkpT4LlXZh6+lWHCONgma+SB3SfYobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782712650; c=relaxed/simple;
	bh=C8qZUvp3bu8IfqLqACbqr8VHBLK/E9fqjE9fXVIgGQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IekvDhsvey2etQtsCz5IuOo4GqrAPHbTtoWQz7azWlM4pZune+b877koWGng2gIbOyU+cpn+tZuoIBTezHdpFA77pT+jvu9b/jPLJTOGtbeFSbeGH7iqwjyH3OKA03Gos7BzL6OsHd6SvbWjTbMN2v4Ncqf25eaZQpG5FtG0YCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V2MI0bxW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KuqqB0NI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V2MI0bxW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KuqqB0NI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D732EC0032;
	Mon, 29 Jun 2026 01:57:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 01:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782712647; x=1782799047; bh=RHfc2DTHlf
	8BfgrPReqRJXHwlmTFqG7GuALdeidtasY=; b=V2MI0bxWpS8lRyaeDpeZHJXCep
	y1bKzxR25ya/laCSwEl3x/kDWqdlCaOGPveqgC21qnKyQz6Zm0B5ks4OH6PTdhIK
	uQCr43Z8i13KzSkwPC/+ceMeZYrmhzXP5JYlTiP1LNf1oDCwx5Z6M1eZaaEbipm3
	nU7KgIIIEegDKgqMZ+uEwZKT+T5lwG+ZmNgrb2CEe07Hb8JB3Whbyx66v4eO3VUR
	DwktncVoo41NB8q1I5XeGf5rixzC0D7tHJNDzGdJVDLs9Fd9G48UuKOGhrnp8ZrZ
	LaEjEEwFJ6xFWrUbCa6nswJqAhQCWNLLhmu4q1vmADT2QgZLiFsSpuUpg9HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782712647; x=1782799047; bh=RHfc2DTHlf8BfgrPReqRJXHwlmTFqG7GuAL
	deidtasY=; b=KuqqB0NInsDQLLa5GTTXQ+1zWvkHTDmBwhVy9mo0JrKBsjzv1xt
	g2Cjlz1eZ4QuY17Vvss7tgs4II4PZKv5JaI7LCPZVqu7IyvivoSOfi/z24bBBX2X
	ci9MgNi4rXqA2hKup2v8XWdG/hukK+1sgMSpPnnsDqRnfKgcTICteYXkFUiMiTP2
	AxQdYVDtynpxTbL9OpPtM0zJc/ui3SRoCVkH+rdIMC4XlbAqZKpx3SSm6zEexrRM
	mRYxj8mHoJpaMSdg8gX/7hAn8xalS1tgeIEuRcazgIM7v6h0sxyu9Q8oHA6NJwNW
	LTKQ0dnLLBveuO+yO8A+NoXR2wnrzrtNEvg==
X-ME-Sender: <xms:RwlCaumvdOKhBd3s-JxOvkrwv_2-jKm727M__DuVvX4FPKzGNp940g>
    <xme:RwlCas38tN384C3jNQN8boFxv7TNLZIJ9pBjZCTQu0dqE8x8IZf68Dais0Qkyp1f6
    YIcYqQg0NpzpI5n8LLjfA1f0n3tRqnJUNdN-Y4PYoz9OSiHW4d_ww>
X-ME-Received: <xmr:RwlCahrfFUJcn7v0TqzgFnpawtVLxgYQfhtsun5R7uXqIgBs_aMQ3XMFh40j_uBuJstbLA-QHC649tulDpVzDpEOujRD0a9SwXJPWe7rZKhR>
X-ME-Proxy-Cause: dmFkZTG31eRRvrf/uuwsKzPxuvbVjOt1DfsDkbFwLYVcokv1nZYJsxG+/mtRCQduZHujls
    VwM89QmTRVQPZaZQHX6L8OWY76kx3MaBKD9AOK3BcoodsUN8hEjOs9x8d8uMUR/ofXmd6U
    JOLsuUKF/yrxc6MssW8MX4uJnQGu/cFuK7YOBYjR0wx6Rvrd6wxVexcHvU1oxWdOLhj2i6
    QPVCMf4yubnXTXZgZ8/CR5ciWcVgDXIqcjUGatoOCJOo2iN3qXz9ShD7oSYY0gHuJrCymu
    7p6dhveYBZc+OFWx00rM7xxBQgkn+5Mh7FuWwoG2tEIDMvwRPkv188ediU5DrQYngi5KKv
    CkfVGEH84wR8IQQ4lJBGtEsm4wzm932g9UWPfAolLc+jziNHsKwr0/DDBWL/J8Qz/Yptfh
    EAhpEP/nYoJ4FQSD8+cpTZPbETz2hCPNqR0O/LL/R0I3exRcDtE62ZYtyQu864ZS+OjDkb
    Rvs+NRC6vAI6+/Lf2NFr9cIYcdyPoZCvfkoQhbsSuMYEgSRgfbDLVuQ1IqzqBOjGafkaCj
    +aZULAYd5f59Akhm+i84XPoocw37ssO+QjN9zrY1ZyfPjm30qJDuIIrBnS2yyALSwrgLFg
    NPefz5wJyd9rr6rN9+EM5TWInCQ9ftDq2ZcW4VeHaLoQdlLnG3a+kMoUm6KQ
X-ME-Proxy: <xmx:RwlCahdo2dqqitePAPloLWzkvc4wk3lP7N5ylLt1JyzQAXH1JsLxWA>
    <xmx:RwlCaooxixZl9N_BSNRgMJVzYmJ93zrmTldyFhLiQjLxa7T5PjZw4A>
    <xmx:RwlCaqFhlE10AnbPcNn4_MR_JSKhtZGRbqjg6Dh5Uz1Qs_sstHShcQ>
    <xmx:RwlCagtLO360EmvYahUBz9ggFVqfg4fKxwGfHsFnzWkv7QYYUFaSUw>
    <xmx:RwlCahlE2ol7PmubSJCfB4jb6L7_WW_mBiot0sjh_WBeDaY6gTxbojnI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 01:57:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25e1349b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 05:57:24 +0000 (UTC)
Date: Mon, 29 Jun 2026 07:57:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t5551: pack refs after creating many tags
Message-ID: <akIJQbOUbdBbkTef@pks.im>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080710.GC107826@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628080710.GC107826@coredump.intra.peff.net>

On Sun, Jun 28, 2026 at 04:07:10AM -0400, Jeff King wrote:
> We have two tests that create 2,000 and 100,000 tags respectively.
> After doing so, the resulting state can be a bit slow to work with when
> using the "files" ref backend, as each of those refs is in its own file.
> 
> This isn't a very realistic scenario, as we'd expect most of those refs
> to be packed. If they accrue over time along with objects, they'd get
> packed by maintenance/gc runs. And if you have a process that creates a
> ton of refs at once (like a big fast-import), the usual recommendation
> is to run maintenance afterwards.
> 
> So let's follow that recommendation and pack the refs ourselves.
> Unfortunately, this does not seem to produce an improvement to the
> run-time of the test script! That's because after producing this state,
> we perform only a few fetches of it. And packing the refs costs at least
> as much as serving a ref advertisement (both have to iterate the refs,
> but packing additionally must write .lock files as we pack).

> My wall-clock time was slightly improved (but within the noise) with
> this patch, but my user and system CPU time were slightly worse!
> However, on a loaded system with I/O bottlenecks, it may be a net win.
> That's somewhat of a guess, though.
> 
> It would be nice if we had a way to generate all of these refs without
> writing so many individual files. But even if we taught the ref code to
> write large cases directly to the packed-refs file, we'd still need to
> take individual locks. The real solution is a backend like reftable,
> which shaves ~30% off of the test runtime.

We kind of already have this with the `REF_TRANSACTION_FLAG_INITIAL`
flag, but right now it is only used when performing a clone or when
migrating references. Also, it requires an empty repository that has no
references yet.

It raises the question whether we could also extend git-fast-import(1)
to use it, as it would typically be run on an almost-empty repository.
It's the "almost" that kills it though, as we already do have at least
the HEAD reference. So it could be feasible, but it's not as trivial as
just setting the flag and then we're magically faster.

And besides, in this particular test here we run git-fast-import(1)
multiple times in the same repository, so it wouldn't help us.

We could of course extend all of this so that Git is able to write into
the packed-refs directly, even with preexisting refs. But I agree with
your sentiment: it doesn't feel worth it as the reftable backend fixes
scenarios like this anyway.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm iffy on whether this one is worth it.
> 
> If you apply just this patch without patch 2, then the run-time does
> improve quite a bit. The cost of packing is amortized by the improved
> performance for all of those subsequent tests (but after patch 2, they
> never even see the unpacked state).
> 
> Likewise, I suspect this would make our timeout problems go away even
> without patch 1.
> 
> So the whole series _could_ be reduced to just this one patch. But
> hopefully the reasoning given in the earlier patches makes sense, at
> which point this one is kind of superfluous.

Agreed. I'd just merge the first two patches and drop this one here.

Thanks!

Patrick
