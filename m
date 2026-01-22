Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12830F806
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769064739; cv=none; b=Tkv/d70diJHODZDfbmQwU01IBRwqb/NwRbZwHc0W7TPVZiVqTC9DNXYJ3s+wUQKxUfDyG9U20sIS3BzISx2saqInl83uQlmQDO3vgJnbmnaC+53iA8/4wL21vr7+dEC85itBXo6aLrscaquKoRtfU1aIKUScQuVdtYPyGYBWDYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769064739; c=relaxed/simple;
	bh=r1dfX0FwrGL/WT47LcxqgY5yMHKg69I/DCtCIWDxT8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaDvJLS4g/AcjCvTUvO0n0uCjnG/xyP56yRUcBLstw0peV+IoDKz9elz42KRNz2rblG6XMIoTabDYZou0dfpjGiMi7TpuAqrFdF1vD745112L9L/ond7d8IqT72omqyKI2muLTDk6uJbRXT0KddacWTWI84yNtrdpwIwt5BMKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pp62vi7y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ULgz0L3q; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pp62vi7y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ULgz0L3q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A18E1400161;
	Thu, 22 Jan 2026 01:52:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 22 Jan 2026 01:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769064725; x=1769151125; bh=hfeoY0Rw55
	wmvoTzuWD9YqE+7md+0h5kYwZ05a4A4nY=; b=Pp62vi7y/fVrm/Snf6bb8VMRC9
	brvr8OT2Oxs0kwUGAMlQYfsPHRcrOlf9ExzvdBOQZbLcRnRCBdSYCs31Ws4VVFPh
	gVvIid9BKfmyKFCrqcchPDqyKg8CJUvqZmOh4WWMJayeKYo8hL3+M7Tt+TOwzZSt
	BdEa6+gvTg/ZHbpRpDTUuWx8Qvd+MV17dj1jvEQQXEmXMRfJDDv/+MUikjy9Ah3b
	X8MmJB9IulJyoc8qjayenkKt1UEarBiuERefHRkiPTy1PrKYDQPgn4xajmrgSBA9
	n0c5vhzrp5PyA1BFto0Bz+1oAp9cdxWhoXYF9j5i5usyj72jgEWUvO+QO46Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769064725; x=1769151125; bh=hfeoY0Rw55wmvoTzuWD9YqE+7md+0h5kYwZ
	05a4A4nY=; b=ULgz0L3qfj7yEoPHx+w4rq3cQRb2n/gZC/xYuGAcRej2a3N5+Kd
	pFUZvMHYPbwcurcWYTKGGLVqfg/h6kSCSIvtI8fWzLQh+iGYqj1ERy7P3V9nvr5B
	mpFJ1vDLOIgv/DUpRHv//rN/XskIENMx5FkI9Zsd+f4tNQULXa7eJsyWpGMMUIT6
	AaepPQZWuc4ln7EI8WiNPSXABrfGkAlFLH1XDTybj7AuSwo5MJlapsE6YsCHTlBf
	AyZJGBby53TZTuT428yxgOi8O3TU8nNTMcMTrFlLJRdXM5i7BdVOTUg670AYrew6
	cLUf6/2qABrZTnu9u3FMgAZrSsTtEQ5F+jQ==
X-ME-Sender: <xms:FclxaWDDcJaRYmYt4uI48bfL1Nth0ftGUsO3I9eblEePhoOuDo_5ng>
    <xme:FclxaXZWONX7dIorlbtWMm6iV-iV3KkFT_fZrRvufZb3YxL3sj7FQPl90GxnOI1DJ
    AwwR662ADIuwEhpLMRSn1YIOulkdZGbNCBXKtbM0cUy101tiMpFLw>
X-ME-Received: <xmr:FclxaR5nhRKwlQ2ly7lR6lpFse1DxrSLnUy409L7gvspINXPw0bTOzvEOAzJadqcVITdQeRtf2Z9rL0Klt61nrosvMkT8Rw3Up8DBMefSNtW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeehgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FclxaQYGu1bggu441Obtp_NIW2aOqupNsWdPRiRjFpMhNanO5NKrIQ>
    <xmx:FclxaYixqOvfOMKgfaXCmKLyRi3eLBFEelbItkQdG_yAu2B4xlH-qg>
    <xmx:FclxaZ8gsINV5twzMMw7_eyZPlHTplAFIRIV-pKfbb5W5-Dnepyipg>
    <xmx:FclxaboFGpqGH4NFPRYL4xMLyn-T9Am_1PNi598WEmiAnuQKWYGPuQ>
    <xmx:FclxaQzRYuYzo1AVeDlTZ_vTqSbGE_RZcQTnVFU2EApXKLVIy4N-JaVr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 01:52:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49f85848 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Jan 2026 06:52:03 +0000 (UTC)
Date: Thu, 22 Jan 2026 07:52:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/14] object-file: introduce function to iterate
 through objects
Message-ID: <aXHJEBY1FnbGRtzK@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-4-12c4dfd24227@pks.im>
 <aXFsFAV/1J9DLQRY@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXFsFAV/1J9DLQRY@nand.local>

On Wed, Jan 21, 2026 at 07:15:16PM -0500, Taylor Blau wrote:
> On Wed, Jan 21, 2026 at 01:50:20PM +0100, Patrick Steinhardt wrote:
> > Introduce a new function `odb_source_loose_for_each_object()` to plug
> > this gap. This function doesn't take any data specific to loose objects,
> > but instead it accepts a `struct object_info` that will be populated the
> > exact same as if `odb_source_loose_read_object()` was called.
> 
> This may be a bit of a tangent, but I wonder if we are over-applying the
> function prefixing convention.
> 
> In general I am really happy with this convention, and it yields
> organized headers where functions are clearly grouped by what structure
> they operate on. But I have noticed a handful of times where we replaced
> a very concise function name with a longer prefixed version.
> 
> I think I don't have a clear sense of what the benefit of prefixing is
> in this particular instance. Supposing for a moment that we don't have
> an existing for_each_loose_object() function (which I think is the
> end-state of this series). What does the name
> "odb_source_loose_for_each_object()" convey that
> "for_each_loose_object()" does not?

As you say further down, it makes it easy to see that it's a function
that belongs to `struct odb_source_loose`. It immediately gives the
reader a sense what the main structure is it belongs to, thus gives
scope and makes LSPs work better because of the common prefix.

> I think if there were multiple ways to iterate over loose objects, it
> makes a lot of sense to prefix them such that they are grouped to avoid
> mixing interfaces or using one API when you meant to call another. But
> my understanding is that the intent here is to consolidate all of the
> different ways to iterate over objects which live in different
> odb_source implementations opaque to the caller. As a result, what other
> way exists to iterate over loose objects?

There will be more to come: iterating over objects with a prefix, for
example. In general, this series is taking a layered approach:

  - `odb_for_each_object()` is the high-level function that users should
    use if possible. It is part of the ODB layer and abstracts away
    details about the ODB sources.

  - `odb_source_for_each_object()` will be introduced in the next patch
    series. It allows the user to take an ODB source and iterate over
    its contained objects, regardless of what the backend is.

  - `odb_source_loose_for_each_object()` is the low-level implementation
    for one specific backend. We also have equivalent functions for the
    other backends, like for example for packed objects.

The longer the function name, the more specific the logic becomes. Sure,
eventually it becomes a mouthful, but ideally users wouldn't have to
ever interact with the low-level details at all.

> Another aspect of this is how approachable the function is to newcomers.
> On the one hand, I can see an argument that prefixing makes it clear
> which functions belong together, and so if a newcomer is familiar with
> the concept of ODB sources, then they should reasonably expect that a
> function to iterate over loose objects would begin with "odb_source_".
> 
> But on the other hand, while a newcomer may be familiar with the basics
> of Git's object model enough to understand the distinction between loose
> and packed objects, they may not be familiar with the concept of an ODB
> source. In that case, the prefix makes it somewhat more difficult to
> find the right function to use.

So I would claim that this is even intentional. If a reader is not aware
what an ODB source is, then chances are high that using the function
that iterates through one specific source is the wrong thing to do. They
should rather use `odb_for_each_object()` in that case, which is the
higher-level interface that doesn't require the reader to know about ODB
sources in the first place.

I kind of see this as "guiding" the reader and giving them some hints
what the preferred interface is.

Patrick
