Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C327468
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543726; cv=none; b=J5Ps6SQEt6LcVwVypwrboYoZkQMeTAT7u6VuJjhDHxXyZD4sMirkCEJpETIWPqnMeO1GLjVdVu9iRyfn1suokGBlDtKq4KR1k8pHmsxbgLXq8rzBOcyJ2dqdpjOgL24QURme9Jq/VJxCnOr0cB9rab9RwGmw8tYb8KDSJh8ALkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543726; c=relaxed/simple;
	bh=skDhoTi2iWfx56oAfpjhkdrWz89sRbBKTZtPqgkUd6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSXjUJtIvuVm0htGsKCHlrkgDzC8bPTWs2zGREwtdWxWgaSZYoyr4oNqGTZNzKDvLV10SyxTxcsxYWZQITIqB1ZK1+VECY9dhSJCxqiAaJuMO931sK5UWT4rfgPvUhwPHfAaOC723p1S+denQoHzgjWGra/Q1jEmkE9sv0XjlRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X/p6IUCB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PYESlSLX; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X/p6IUCB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYESlSLX"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 973D113806B7;
	Mon, 25 Nov 2024 09:08:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 09:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732543722; x=1732630122; bh=fmmShUxnLz
	o1h4ZrRs+AtIRunQJalWNFZFCOr6MXSmA=; b=X/p6IUCBuH7i7OLThXXg17/x+p
	ln5uQIxiNERWDtRF0bIkEekuUONGmvJ/91CGQyuOmNsDc6kVJpJbyLs8m1mrmE9B
	bhyuggpgM4TBVnoqyldbKwSrfCW1dUJgW8IdnzHuIIt8ef1uUbbZZzHU1XdfQoeE
	B3+mPFYBhdCdErwBQodAetZglcGwBjPGbWWCb48Bq5UtOklIJZRUgfdwae/BlBrC
	H2i1jP78CgkDlD7WMZlzT09S/83/Sygjo0RRzfXQQ64VOJzry4r/Kw5MA6nDkgoY
	kZQP6cXZhmhw3wfrG6WShVCH6kBS7ewPOqCOHGFZN+yeKmJ4VGw2RnLNl2WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732543722; x=1732630122; bh=fmmShUxnLzo1h4ZrRs+AtIRunQJalWNFZFC
	Or6MXSmA=; b=PYESlSLXRTaLZs0E0ei2iQGOIovUXLJRf10zWUEFKJCQ5Gcc3Yd
	zEyF0zLMRtpzISedsavLRBPXN9zYzgbcGSk5jgc5jv4nWJJT2JAIICEZ4AL5P2er
	vXBoAjBGGOZuZsJCsV+Z2VxGOKy4tQq33ZAyR9Dijgeqs1ne4zNd/eQxnFJeUTLs
	Ih+hhaKpJlk/kyevIK61TmDPyFgMyhxTjwcKc99QIH5BFW8lz/Q7CsxwSNybZnIY
	mByNH9NYH3LqgT80IDsqE/MVX3P2+Bq9e6H9E32qwAeTN6z8obzc0nYDW+qMC82+
	E7VRnXyI6q0dl6SiW/v7rVEvfPiAX+R0zMw==
X-ME-Sender: <xms:6YREZxE2wXeRVvuxyQDkl9qI92vuyzVg1GJA4LU_gGXkPZ-yzNMIkQ>
    <xme:6YREZ2VneXGzMRBCJV3uiNiXdlvsTCV8VnmV4eUT37SY_IbBqDx0lcGQJ6mDLK5ik
    _IXMYGAjF644AZRZQ>
X-ME-Received: <xmr:6YREZzIcEkIY4LK7j89QEDg4p2B624aJKy60QSOaEcAIvaGJFG9V6pCAuqnMWcFHpAabb7fNy-nqq_szhwbJaZj2z8UY5qxV6FDIIyytiJSixw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:6YREZ3FZBgYrl133Hm2jvEJTXyBFzaG7xpi8n38Kn00EeeJDg9qphw>
    <xmx:6YREZ3Vff_MRRQ0ghDcgGkZl-bDEKR4nqL43uuPSGeuDI9BvEozrpQ>
    <xmx:6YREZyNfwRPkq1Qq7ggDLvu7Gj2dufhkmy9m1bA9p7J8sdNhCgq5zw>
    <xmx:6YREZ22FsKWmKevdAxw3-ZItgRlvNL2UxiErT4Lmaop5mD_zIhQEzA>
    <xmx:6oREZ9x0Uk-omLmKux0HMd-yo-0STnaaDIx6hGPSqpyALlxAfxfSnmJL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 09:08:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id beef4037 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 14:07:36 +0000 (UTC)
Date: Mon, 25 Nov 2024 15:08:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 07/27] bisect: fix various cases where we leak commit
 list items
Message-ID: <Z0SE2TO74B3eMpqQ@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
 <20241120-b4-pks-leak-fixes-pt10-v3-7-d67f08f45c74@pks.im>
 <20241125112746.GA1069812@coredump.intra.peff.net>
 <Z0RvxAkmfZhgo_LJ@pks.im>
 <20241125131722.GA1613472@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125131722.GA1613472@coredump.intra.peff.net>

On Mon, Nov 25, 2024 at 08:17:22AM -0500, Jeff King wrote:
> On Mon, Nov 25, 2024 at 01:38:28PM +0100, Patrick Steinhardt wrote:
> 
> > > But we never updated commit_list. What if the first entry in the list is
> > > UNINTERESTING? We'll have freed it, but *commit_list will still point to
> > > it, and your free_commit_list() will be a double-free.
> > > 
> > > And for that matter, I am confused about what should be in commit_list
> > > after the reverse anyway. Even if we didn't free that first entry, it
> > > will now be the final entry in the reversed list. So wouldn't
> > > *commit_list always be pointing to a single node?
> > > 
> > > Should the code be freeing "list" and not "*commit_list"? Should the
> > > reversal be assigning "*commit_list = last" (in which case do we still
> > > need "list" at all)?
> > 
> > Mh. By now I wonder whether this code can be hit in the first place. Is
> > there ever a case where `do_find_bisection()` returns `NULL`? Replacing
> > the whole branch with `BUG()` doesn't make even a single test case fail.
> 
> Hrm, I thought you were fixing a case that was triggered by the
> leak-checker here. But I guess there were several hunks in the patch, so
> maybe you added this one based on inspection of the code and it was
> never important.

I remember that it took me quite a while until I was able to root cause
all the leaks in this subsystem, so some of the changes are of "while at
it" spirit.

> Just skimming over do_find_bisection(), it will always return something
> unless it is fed a NULL list in the first place. So a NULL "best"
> implies a NULL "list". Which implies there is nothing to free, because
> every item from commit_list was either UNINTERESTING and freed earlier,
> or made it into "list".
> 
> So could the "else" added by your patch just go away entirely?

Seems like it, yeah.

> That would also explain why you couldn't trigger this in practice; one
> imagines that the bisect code may avoid getting this far in the first
> place with an empty list. But you can do:
> 
>   git rev-list --bisect  ;# no revisions!
> 
> to get there. I wondered if:
> 
>   git rev-list --bisect ^HEAD
> 
> might give us the double-free, but that ends up with an empty
> commit-list in the first place.
> 
> > Anyway. I'm not familiar enough with the code in question to tell, and
> > it's clear that `*commit_list = best;` will leak `*commit_list` if it is
> > not free'd beforehand. So I think freeing `list` is the right thing to
> > do. Do you want to send a follow-up patch or shall I do this?
> 
> I'm not that familiar with it either. But it does look like the intent
> was that commit_list would get cannibalized into "list" (freeing
> anything that didn't make it), and then we'd work with "list" from
> there. And when we _do_ have anything in the list, then we either return
> it (if FIND_BISECTION_ALL is set) or free the non-best entries. But all
> of that is handled in the "if (best)" block.
> 
> So I think the code was non-leaky before your patch, and you'd just want
> to revert that hunk.
> 
> I'd be just as happy for you to send it. :)

Okay, I'll drop that hunk.

Patrick
