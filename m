Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06952275842
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568009; cv=none; b=VQFhWH6RwVvQyW/XVoCbWnh9VM1tcVcF5YQc44q3rZJeBHKZ06uP/rm/bWEagDFiz2Db7OnUrGHhmdHAoXRfe5YjoTyAFUA3BIamb3WTFe6ua8jNnO/qebaiH7Orl14m8yT905llXZwuI1BRShLdd7V/7Kt51srusoryrnivJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568009; c=relaxed/simple;
	bh=UEwUpAx5+HVMK+4DUyE/pHy/qcpfXqM00I89FqY7Xag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLk1CulZlK40zFOGGSlgqArjT0MY7ECUeRnAlVQgN2uXpR8k3wRZVHlw+UWABTYkuG8H7G/37jLGXikNNkWAfqgBEeUGCHny6u4BljBPmugSK4sk3Y0vGrNFkPEqb+R2f8nzOq4R4LRWdg5VAv6u3Md9zWyt2FgqWxKytuy+A9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aBZjbtYt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RaCDzXk0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aBZjbtYt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RaCDzXk0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1912614002D4;
	Tue, 15 Jul 2025 04:26:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Jul 2025 04:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752568007; x=1752654407; bh=SoyRBTy2Jd
	g03Ji3cgZesXZLQ/PPSy22zpts9IBp9Wk=; b=aBZjbtYt+OGloHCj3MuoFsRxNL
	UfF9mBBYPRF04ELkKNXa2aZrTs9IUkkLgR+Ikfss39fJdCDCLsMJ5QwkcwgyymjM
	BaJjZbEV6IJ0+8A61Sfzf8JzJXtd9tp0xJZSk9fzLyf+I7ZRto0mj6o5CYePoSPr
	RAifiupkJAL9NO5VK6xC2IJ3lJZhcLflgbRXKSpb9zkScYCQtfUi5btUEBm1XaB/
	IxWjxA1ogajRsIwwcgMnGGIjqrBlHTstcCEdVSdbW+miWFg6izW22x6Uqs/YmgCv
	KjSfapmlpI/skT3tndz488/YVe3yGpZiF6qv8Bh4/H9zZHn3Ivyka2GjXb1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752568007; x=1752654407; bh=SoyRBTy2Jdg03Ji3cgZesXZLQ/PPSy22zpt
	s9IBp9Wk=; b=RaCDzXk0sJNlUE54+55aixZms8xzR9polwXJdDZfbHRp0tWGJPC
	A2Y+wD9SidSEHy8zSyqozCV64sdqP2e5/esWGh+auvpyI/eb5xD3IoFXkWJh2SlQ
	WlNoAC0zO8H+IyLffU8yd2iZoBWZganJ1sbMD7YaDTiFRrK4de+hZUKaNaDw4NmZ
	vVSAA6/SNS+t4uuip3dWOvFgNLB/SlpD4Umh6tggdfDj74d1AvZ+z7GyMFcbakeG
	0L1uYlUMy7tEQaETZtBBJuHGM4qMuK4RWyW8SlWEeNWs4vw5IClHicdc9isQ9lnt
	3/wPvn/Vw186udiUbImEzYeii+4HYCkPZpg==
X-ME-Sender: <xms:xhB2aKKL43-8KdRTTmLnt0H1Ua-OQei90gewj7vwU-Gtw8_qevYlPA>
    <xme:xhB2aCX29kyP-9Htwnm3b_yr41VBd8G0WePme_ZC4dQMgCGM3AKB_FyljMT-h791u
    P6ypa8Kl48YLFPTmw>
X-ME-Received: <xmr:xhB2aMhUQs41LRmZS67gw7H2LbDE5LkcvzPSp8dcFrD-g1ttRx3wo1blmWDD1N2duE_qyW68LRVtIlQ9mav5H29GhP4bPrA33djVRoGlrj0BbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xhB2aN9GkOzU7yfy4MkCTZrt_1A9cLU-LOinlcmDHVxe2IZsVlaunA>
    <xmx:xxB2aGByRq6LExwDCgdI5nEuOJ3NZfqHIFkUPLE59ldjVoZbsBk1NA>
    <xmx:xxB2aKKl1Qo2z_kipEnhFul5sdINwdjrLZI3-oVGDeyR6U23qaIO1Q>
    <xmx:xxB2aJkJ8W42AFW5eIFIR7NUXPV14PAOPq8xxtqMT3RTQS5v8zsgEQ>
    <xmx:xxB2aKlfbT1faqrvmKxp0-XtMR3LoobVnNPZbdmPhll2kw6ot3n1p4O4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 04:26:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f8e3de8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 08:26:46 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:26:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] packfile: refactor `prepare_packed_git_one()` to
 work on sources
Message-ID: <aHYQwq3XdPEJvU1z@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-2-f31150d21331@pks.im>
 <aHBJVZsFRUUM+vXu@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHBJVZsFRUUM+vXu@nand.local>

On Thu, Jul 10, 2025 at 07:14:29PM -0400, Taylor Blau wrote:
> On Wed, Jul 09, 2025 at 09:54:50AM +0200, Patrick Steinhardt wrote:
> > In the preceding commit we have refactored how we load multi-pack
> > indices so that we take take the source as input for which we want to
> > load the MIDX. As part of this refactoring we started to store a pointer
> > to the MIDX in `struct odb_source` itself.
> 
> The first sentence here is a little confusing, but may read more clearly
> if written as:
> 
>     In the preceding commit we refactored how we load multi-pack
>     indices to take a corresponding "source" as input.

Will use, thanks.

> > diff --git a/packfile.c b/packfile.c
> > index 16efc2fdca3..b43dd2fe6cb 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -935,22 +935,17 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
> >  		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
> >  }
> >
> > -static void prepare_packed_git_one(struct repository *r, char *objdir, int local)
> > +static void prepare_packed_git_one(struct odb_source *source, int local)
> >  {
> > -	struct prepare_pack_data data;
> >  	struct string_list garbage = STRING_LIST_INIT_DUP;
> > +	struct prepare_pack_data data = {
> > +		.m = source->multi_pack_index,
> > +		.r = source->odb->repo,
> > +		.garbage = &garbage,
> > +		.local = local,
> > +	};
> >
> > -	data.m = r->objects->multi_pack_index;
> > -
> > -	/* look for the multi-pack-index for this object directory */
> > -	while (data.m && strcmp(data.m->object_dir, objdir))
> > -		data.m = data.m->next;
> 
> Right, since we know that the MIDX corresponding to this source belongs
> to the same "object_dir" path. Having an ASSERT() here may make that
> more clear, but this change looks correct to me.
> 
> I am still a little unclear on how sources and ODBs correspond to one
> another, but under my working assumption from the previous patch, I
> think this is right.

Yes, your understanding is correct :)

Patrick
