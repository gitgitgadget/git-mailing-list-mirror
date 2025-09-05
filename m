Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139AA34DCF9
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075034; cv=none; b=FUGzHxG2qhtuFkk0j83HLzn5J8hBmnOhcZZJQAXQ4uTGWJdQkhV8fytPDIhtfZrFt6RScQ6XVPqO4KkvJaLdnR75c0eaFX1sxZAeRH44UgBv7ftGJQUwo1DOnQumTLamfqkgVH+GF2dWCCZJuKO4nRcCIw4UGTPUqq4AvpsBicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075034; c=relaxed/simple;
	bh=8WzGtEm3JhNcJaCGgmWBKT2LhXhgaaN4NTQNzUR2OOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo50mUDfH6HXeFo3BaGX2X9Ugwm/LWyYdg0ESq7+ylHp5t1/StfC+gZTkXnrUuXIHwCOcaiPH4R5/gFOdNTFCllo7Sw8gnQlcZikaZU02KhxvnxFywGGkXJcsr8hUvs+EoyO4k6wjXypSMhrOpsRlgMMe/x28j7iFcsO3N86tVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d90w8ujX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WkAE8ke2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d90w8ujX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WkAE8ke2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C485EC02BD;
	Fri,  5 Sep 2025 08:23:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 05 Sep 2025 08:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757075032;
	 x=1757161432; bh=1bZcG0BYF9D6ZjUeJmC/NiCzjAmrigdAEpEN2rkcuI0=; b=
	d90w8ujXexgAMM7Uvn/X/mulY+NtFIidH8xfEJ2GJ+0XCJgnMVpNNHeoIpiEY+hT
	38/ODeUosCpAurx0dcy7iZ03nmXA7QSBPu35XSQksXx3Ke55BZ4F1dmExX9Z0o0j
	afKMFZMVaqmx39BvAm2rGfUbLQ8/fJGmlhMRl9avdqhyz4z60J2EloLC5Qw1NflA
	qUSCIQQ4b5KtQS9Xu4lei5boKlLJhLES7tBoiL4w9wfySZZjW/jsZ+VcDy7Yuy5p
	BIFGuU+4M/aiew6pi3kJpwrcCjIOZP6QSgbPK/Ckzuhmadj96KII3Z0dCI7zijbr
	ZLftuypXbKi6aD5YWAIGqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757075032; x=
	1757161432; bh=1bZcG0BYF9D6ZjUeJmC/NiCzjAmrigdAEpEN2rkcuI0=; b=W
	kAE8ke2zuyD0evflvVkhkQdj7BEA7RtJkBwZCdfNl+M2af+CPIlgD6kgInrXO/Xr
	t6COMlAAQ93j7e1hLc5kTex5+TbIgjy/6AzpBEEltDh8EZEE/XE6VDKnyxsobfHJ
	HzRJQsawMmeKZVcOi1e8i268FrW3N7MEZJoIRLkiXe34jUdAouJw6QIgXWtG8esS
	gAfj9vKqNZht73p/X88SgG+d26A8u987a2jsg5HOHdXpFdtsZVxrlZ5OY0hiVdwe
	D7TxQVr9vLid6UlxeMr8c86So0FxUDv6mOZvfSrROPXTqMZrsumTPu4ImJgHXPhy
	gg8EHmgvrhaN91R1eOg2A==
X-ME-Sender: <xms:V9a6aC5TfE_fSPnoDaISddzXUAquYGkvOJvleMJLYmKy_rm77Vse4Q>
    <xme:V9a6aGfM_Iq0sCpp_TMTvVJsodM8qEFskd9qBoMdb35Iop4ReWZmCftuD5ojTAmas
    1KSqqXji73yRTH3hg>
X-ME-Received: <xmr:V9a6aOCfW-dZslgG-TcCLKvFSKO5PddeFAnqcnI-7RP7BPIbUQs368KAp7F3haj5xAuEnpAVloDeZu_he2LV6Eamu7lFjvyZP0UBqHvqGOK->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepughi
    lhihrghnrdhprghlrghuiihovhesrggvghgvvgdrohhrghdprhgtphhtthhopehsthholh
    gvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:V9a6aB-IZyP_F088elYO94Kg3I1uBJ8EIVO1-FOSbNficWs-78shTA>
    <xmx:V9a6aBIdi8Te-gMfcNy9xS4BtdCDDjPhkWhtT9Ok2Cr0ChgDbN4Vpw>
    <xmx:V9a6aCig3JuQWy9XALfuWbL4qHjAuINbs3KSnkEe6PcniO1xyQzzRg>
    <xmx:V9a6aJ4H4QTxJCgbBrslfoHpIi_qhIpb9hWEzhKedHqMr26nwpJ3vA>
    <xmx:WNa6aIW9arUt0v6HNporzFDVWrvGM4A23hIsMcK6FRYzbjfFM6Sg_FIC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 08:23:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6536a8b2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 12:23:49 +0000 (UTC)
Date: Fri, 5 Sep 2025 14:23:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>,
	git <git@vger.kernel.org>
Subject: Re: Doing blobless clone by default; switching between blobless,
 treeless and full clones by a command
Message-ID: <aLrWUhtCqp1hMcQS@pks.im>
References: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>
 <2ebdff4d-8adf-45d9-8cb5-6d7ee39f218d@app.fastmail.com>
 <7713256d-e258-4356-b303-128fdb417972@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7713256d-e258-4356-b303-128fdb417972@gmail.com>

On Thu, Sep 04, 2025 at 08:19:59AM -0400, Derrick Stolee wrote:
> On 9/4/2025 5:41 AM, Kristoffer Haugsbakk wrote:
> > On Thu, Sep 4, 2025, at 11:33, Дилян Палаузов wrote:
> >> • add a git command to download all locally missing history, including 
> >> for treeless clones and blobless clones
> > 
> > This sounds like git-backfill(1).
> 
> Indeed, 'git backfill' is intended to assist with downloading the blobs
> that were not selected in a blobless partial clone. 
> > I’ve never used blob/treeless.
> 
> I don't believe that 'git backfill' is optimized for treeless clones.
> Treeless clones are not intended for "refilling" as downloading missing
> trees is particularly expensive.

Yeah, indeed. I guess we can tweak the way we backfill trees by batching
by depth. E.g. we:

  1. Collect all root trees and fetch them in a batch.

  2. For each fetched tree, figure out all missing transitive trees and
     fetch that level.

  3. Repeat for the next-deeper level.

But that batching is definitely not ideal, and there's going to be cases
where it performs _way_ worse compared to backfilling blobs. That's
nothing we can really avoid though.

One idea would be that the remote tells us about all the trees we may
have to fetch. But that information alone is not helpful unless we also
have the links between trees, and as soon as we have that the info is
basically interchangable with having the actual trees in the first
place.

So in general, the recommendation I typically give is to not use
treeless clones at all.

Patrick
