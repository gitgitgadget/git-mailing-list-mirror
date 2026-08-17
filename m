Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22923B1B3
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943943; cv=none; b=axm331vSqpROf9KOkU4iGTANpZsSIYamKSK8iFE33hf0GSJ2DKHyGDmozUZmZlboJvGRPlKF3bXl3bI79gKKSKAtutZNW+GGfD99C5pPo0AL63j+iDYJ814+JONcr3kfaaWJGArmO3T9TBuhLLDpQcD8Y8pmncHCS1kZsgpl5Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943943; c=relaxed/simple;
	bh=kqTkkIOJQiBpblQVBTnC1J6jDngbhu+361F369Tdv1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY4UVhD4IrhoXyvjjUrg9ngYxNpPuMS2THxC07iL1ro5Kkwx2Ab4sCy3OSnOj3hF4etqEsIi4rITCoThaQnolzrZ6LNx+KUG7oko+o81NZFVBhg1MpA7xn5ZKv4xtN9vFju5fHTyQIYk5CnoIgSAiwkc6wuOIRAyttGzzfE9abg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oN5C6gnw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LFDMRkcp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oN5C6gnw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LFDMRkcp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C3C2F1D00136;
	Mon, 17 Aug 2026 01:19:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 17 Aug 2026 01:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786943940; x=1787030340; bh=F8u8EKorFB
	Q58NQarSeZTOgcgLqS6cx1Y9UQMuUNIzo=; b=oN5C6gnwX4iXrlcdAv67PdN1bN
	+vogXrVsl8XUPhwOrJuon9TVyuXqbqr1l6DBaSFLp5ibI/b9l0db2ICKXMC5D8uK
	hep/ig7RrrfbuC067HnVulrqG31kE0HJYYX61NdxAmH86kI2TVRCMxHCdpmlLa2E
	kXJonZruK24fZYxddn6R+yuWQprvqqAzyw2MmEHhq+E4vF9Lz+8NxWXLnTYEYDer
	A8uyLdl2lPbvzou+KJnyHaIEu305Sx5VQTur9CMXeUDe2aAr5i22QPphQ6+U7CKK
	o3Zn8IRUHEdJkmELh+qCx/6BOIU3NjU0aK98OtmMjBg9adzojQaSNwxSs+NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786943940; x=1787030340; bh=F8u8EKorFBQ58NQarSeZTOgcgLqS6cx1Y9U
	QMuUNIzo=; b=LFDMRkcptLt12+P0Rlq+p2LDb0WIzXnUgBUgFOKQPH+my/m46vB
	OceD3mGcK+FJFCyz1PnhY7YxnSIBUq1mBQycZlAbrWGZeiPjIhLthgMjDj2x9oaI
	2v7QdVpYo2FUz0gKUFn+fvc/j/I+pS2tI8+ooljQgeY0/jbLWFujluRtKeWUB1tu
	oL8ECJSFoxhTSOMKEBDtiMSeV0sG/3FIsonxomYbdXR3BqWZR5IeWoUfj6kddnfL
	+NUX9Vkdf53gbVF1XHIXcnttf1CGgLWeO0qhsnknSJum0lUswpwIQgOTWq+bQ+bi
	Q3STDHloRCkTrC6r9DdCwRTrfFPB95Y20UA==
X-ME-Sender: <xms:xJmCap-j63z-bK_GYPN8s6djszsCWcE_1Gcs2jbY_3aYxthoAnI8pQ>
    <xme:xJmCaktFGAE4siWUpOgaIxxyFst2KI-EB1TlI9CcoCN1CkNKj69c5CorU_AW3Gppz
    -1exD1JNbHD4zXi9CtOCZ4uUPQjEAtDg1BtTDmBv7V6k4_yVCJ-p-A>
X-ME-Received: <xmr:xJmCasDwpJ7HZJLoQfyHeET7CuSvPndXeHjwPPTmDRR5hGG4sG8qdFwZfCqG7xcS1NaryeWIkgliqJFpifW6e4aaGjNBqErNQwLWrD-uMQ>
X-ME-Proxy-Cause: dmFkZTGJ+xI/WYpIsYxgmObKGyrycK5aQvResjWVrZC6tuccIpT/VD4oexqvvj7qWDKLQ2
    0Q+P2rcy/Dt0gfwpJdTywiAm+S2LPcfJCHKD69fcAW2U/Uejisz6LIChat1AyBPvxbWj8M
    KwVb4LEdznqBEqPMFNEwNFsGD8q+izjfi38nCbnk2nsA3lDUXeMNiOXxdPg9f4o6NC8dpo
    a5EijUSMbSXmIdO8ndCpSbJNO8mri4oaEV6T0YmOgh0IGorCclUcegJ2quJ6qcc2+6sC7z
    0hReAd61+NhM0JIKdb37L+B0ZAxhTEWAWLGmlNRaXDydjaAFRuhSiI/QdtnLpbxBrnjqEE
    9w3Siv6ncNVp3afWVef0EQEJ6A6L4u+tLp+4TaE2DdHi4ia0tQUDG3Ac5ZH9GwTGT84SqX
    lXYf7eudRxNAJ//6O/Gcto7xnld2w+Xh8FfEnujt6WG2uSegXeBbptaV/rlFeo6OgJXZY8
    STk8sp1ghJxOCTi8WXehnUEUr1niMZlROazAYAeeLRWbzps4LkeGKVD4EmzrWVgwFOosFx
    cszkiNB0Y4v1Y9SE1IRJYTVPMQ8HJORNeVew+a/UdUKSgCBc5mxtu6g9aiyiZjRTTJloZO
    ifpzWORO4fyFWM7t777MK6+3MoGmE7Q4OEP/SL1E7q4U+Y/tuK5SwsJqdL8g
X-ME-Proxy: <xmx:xJmCasUPpwatRFet4SJzLiUMSeuow7LtQ9I0ji7CZF5PxebrLz-tww>
    <xmx:xJmCaqDqKfoGfNY1-MHBmYW1JCOoVH7DmOL1qBvYQiXiCBZb0hwArQ>
    <xmx:xJmCav_zuobfDZlSEz7FE5TLaKYVpbRnPUySEtAun1lFbCkX4DN4Zw>
    <xmx:xJmCahER0O0gGjHhWYZ_2K6Chjh9znXUluAu8F97-d-9GqOSoNKkMQ>
    <xmx:xJmCaic8ecapF5cqeCisNMNz9tj5v8EBFKQgYl6csF6Kq-wPKqIplEat>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 01:18:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 254206e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 05:18:58 +0000 (UTC)
Date: Mon, 17 Aug 2026 07:18:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Message-ID: <aoKZvxE8oP5B6O_4@pks.im>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
 <an1zz02GNqDu-0Oz@pks.im>
 <20260813161525.GB1386479@coredump.intra.peff.net>
 <an7IhgES-reCzQMr@pks.im>
 <20260814165546.GA2563235@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814165546.GA2563235@coredump.intra.peff.net>

On Fri, Aug 14, 2026 at 12:55:46PM -0400, Jeff King wrote:
> On Fri, Aug 14, 2026 at 09:49:26AM +0200, Patrick Steinhardt wrote:
> 
> > On Thu, Aug 13, 2026 at 12:15:25PM -0400, Jeff King wrote:
> > > On Thu, Aug 13, 2026 at 09:35:49AM +0200, Patrick Steinhardt wrote:
> > > 
> > > > An alternative would be to use a hashmap here that tracks the packs that
> > > > have already been added. It has the advantage that it also covers the
> > > > `prepend()` operation and that callers don't have to be aware of this
> > > > mechanism at all. Furthermore, moving preexisting entries to the back or
> > > > front could become O(logn) if the list was doubly-linked. We do this
> > > > operation quite often to re-sort entries in the list when looking up
> > > > objects.
> > > 
> > > Don't we already use such a hashmap via packfile_store_add_pack() and
> > > packfile_store_load_pack()? That comes from ec48540fe8 (packfile.c:
> > > speed up loading lots of packfiles, 2019-11-27) and is how we know that
> > > this "is_new" flag is true (otherwise we'd get duplicates during
> > > "reprepare" operations).
> > 
> > That's a good point, we indeed do! Maybe it would make sense then to
> > remove that map from the packfile store and instead move it into the
> > packfile list to make it more generally useful.
> 
> The map protects more than just adding to the list; it avoids all of
> add_packed_git(), which allocates and does a bunch of stat() calls.  So
> it couldn't just be a check in packfile_list_append(), but would have to
> be a separate existence check well before that.
> 
> That's not impossible, but it would be a lot easier to see what
> generalized pattern would be most useful if there were more than one
> caller of packfile_list_append(). ;)

We only have a single caller that appends, but we have some more that
use `packfile_list_prepend()`. And there we basically have the same
problem.

Patrick
