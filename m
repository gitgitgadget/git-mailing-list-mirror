Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE2E573
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803055; cv=none; b=jCJppjiORbDZGVMNABCpOw+roEyDh6iIW+mKf1kOE5aarqs/F6V4YSl/5GNTUj2+S7QU+95VXWDHfJTvi1WPd8CO2D7GTgyGEvN5pYQnyS9igsk1/5UVJlSj5kD5U07AH3SE5yAoXG9uUOgtDiGaASwGEurpXmyX23c5bAyJ9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803055; c=relaxed/simple;
	bh=HSUJDRvzWjwFQP/icgQ3U3kV7KZmFJ9MduHS6T5KrnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeRecjCGbBjam4t7gOHECFTdiUOoMWu3izkFaIVXaATaixmbVkRN0h2SLOv20BKCiOx/N47O0QpjZHVAY3F2/A4guvvtHXONK74ykUeSVoAy/q4P+IC9hAhaM4UJMGQGAd1YO/40E3vNyaGqz5KOzrbq9KKQ7d9Qb+tq0kb5s/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mqMOj1N2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q7JIYzqD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mqMOj1N2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7JIYzqD"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A8C7DEC0540;
	Tue,  2 Sep 2025 04:50:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 02 Sep 2025 04:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756803052; x=1756889452; bh=IWhjQ8DfG5
	6Ltfon0UXhFG+u1brxbXgrLEh9jGRdBDY=; b=mqMOj1N2ho8bRWeg5mxlC1Kqh+
	uDOJUh4mhrx1YzN/5hJkHMfJsSWbVCm6Rw8tGa409vUD0QVnAcCrcGxGXeUnnDfe
	zvCm25SRtV8haS+Fr2n3XjJlMki1yjv8wAde1FTXD7C9iFnPQNSbH60RWvf9LqaW
	O7bD+dbXg2r5VVrnXGF04MMKwv9UlLO4AMy49NEZWYWpFCcg7xcWiHpLqj0Up4/k
	NdfrhXCZbdDSo7FQASz9tsAzae/4AW7AXhKRN4zwYUT/DukuPL8IYfWzo9ZNlO+x
	NYvoep1ZwEeM9p3Zrvl0MTogQQO7nu4+2YvmFt4WHXnNifp40tIGE4ov3Pzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756803052; x=1756889452; bh=IWhjQ8DfG56Ltfon0UXhFG+u1brxbXgrLEh
	9jGRdBDY=; b=Q7JIYzqD4/Hmyc/x3ERm2tbwRW+IF0igT+uzevsnkE5iGqV/FO1
	lvKWBynG+TIhvLjCf7wkLYybIhUSv6Qx/Ao4PX/glebYqmwBGEcmty6TezbcFL03
	wkud2EzlUlf3rsvMIMz33Biy+vh+bAmIEIsoupfFwAxS0T1v4cL0/9KR515hrNMF
	RP1KOvPztt6xDnUeZrXjYGVUjxl5tYrOy8KIR2dUQzKt6QMaZ5OX09q0MPVLfQXI
	ap6L0ZV+AWfYRhIR5Wvbup0rGZ1L2e3a49Qitv+tyaf58bxFs0+udKyeJ+3V/GL4
	EF12YfYRZ/fbxulK6PYhnnIM7h7cDcr2zTQ==
X-ME-Sender: <xms:7K-2aD7UROlPY3Qme4WERfPeKd7h7sVjeqhHgtGpBWTGXHsB6ZpYTQ>
    <xme:7K-2aDcgEATpZEJhKRujKVIRFbiwPfOZ8H7yPjOMVpo6vOvtEoJpJ_W7F0UJjDT3h
    Ez32GjZ-nBwQ39koQ>
X-ME-Received: <xmr:7K-2aHAvo3WpaGMOTHD8qClYVJ_3Wz1T7XRIIADMad3GxzbmjZf4gJ6nbBjf6DEkEpjdM9epZ_XnEEDeJxFHFNC2qwdEXb2uI3E2wxSnJ6jf5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7K-2aG8ImztHoaDwswQu9dKM0t1c61E-4M7Yd5iniH9lb_SV3wf9Jg>
    <xmx:7K-2aCKfgAEHGVH-L6lf1Mj3-GbQbTopuEdhHxKZhuQq1_v3rVmY_Q>
    <xmx:7K-2aPhg_-ngZOAEnOtbhQxTDl1QaBGLdSkBTzjvoLDKEst2kZBbog>
    <xmx:7K-2aC4AqKIQWWilR0YLMz-B2Kc5Wyrq8eQad1FDOriWxmowV5f17Q>
    <xmx:7K-2aOQQBSQG2kqMfAIdBbm83c5pmz3vg_h6PFi3farVXFYygdZieB4G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 04:50:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc7e5eda (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 08:50:51 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:50:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 11/16] packfile: always add packfiles to MRU when
 adding a pack
Message-ID: <aLav6D4PhIHsUd36@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-11-d10623355e9f@pks.im>
 <aK5ZmNxE4zhNt7Zg@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK5ZmNxE4zhNt7Zg@nand.local>

On Tue, Aug 26, 2025 at 09:04:24PM -0400, Taylor Blau wrote:
> On Thu, Aug 21, 2025 at 09:39:09AM +0200, Patrick Steinhardt wrote:
> > When adding a packfile to it store we add it both to the list and map of
> > packfiles, but we don't append it to the most-recently-used list of
> > packs. We do know to add the packfile to the MRU list as soon as we
> > access any of its objects, but in between we're being inconistent. It
> > doesn't help that there are some subsystems that _do_ add the packfile
> > to the MRU after having added it, which only adds to the confusion.
> >
> > Refactor the code so that we unconditionally add packfiles to the MRU
> > when adding them to a packfile store.
> 
> I am a little confused why prepare_midx_pack() wants to add packs to the
> MRU cache so eagerly, and the commit which introduced that behavior
> (commit af96fe3392 (midx: add packs to packed_git linked list,
> 2019-04-29)) doesn't focus on that area in detail.
> 
> (Note that commit af96fe3392 *does* discuss a separate cache's behavior
> regarding the open file descriptor limit, but that LRU cache is a
> different one than the MRU cache we're discussing here.)
> 
> What I do wonder about is why af96fe3392 adds packs to the MRU cache in
> the first place. As far as I can tell, we never move MIDX'd packs to
> the front of the MRU cache at all. There are two spots that call
> list_move() on the MRU cache, which are:
> 
>  - packfile.c::find_pack_entry(), which enumerates MIDX'd
>    packs in a separate loop earlier on in the function, and ignores
>    packs in the MRU cache whose p->multi_pack_index bit is set.
> 
>  - builtin/pack-objects.c::want_object_in_pack_mtime(), which also
>    enumerates MIDX'd packs in a separate loop, though it does not
>    explicitly ignore packs in the MRU cache with the multi_pack_index
>    bit set.
> 
> In practice, though, I think these two are equivalent, since
> want_object_in_pack_mtime() will return before it gets to the MRU cache
> if it found the object in a MIDX'd pack.
> 
> So I don't think we need to be adding MIDX'd packs to the MRU cache in
> the first place.

I think the status quo is quite confusing. There are callers which
directly iterate through the list of packfiles in MRU order, and that
list is not guaranteed right now to even contain all packfiles that are
tracked in the packfile store. The list is complete when we only load
packfiles from disk, but if we ever manually add a packfile to the store
in-memory the list is not up-to-date anymore. I also couldn't find a
reason for that distinction.

Despite being confusing, there's another motivation here as discussed
with Peff in [1]: we can drop the distinction between the MRU list and
the "normal" list altogether. Ensuring that all packfiles are always
stored in the MRU is a prerequisite for that subsequent change. I
already got a patch series pending that does this refactoring.

That being said, I wouldn't mind moving this change into that subsequent
patch series, either. It doesn't really have a strong reason to exist
yet, but once we remove the distinction between the two packfile lists
we have a much stronger argument.

[1]: <20250820192008.GA1662788@coredump.intra.peff.net>

Patrick
