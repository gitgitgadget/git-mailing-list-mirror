Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30041D61A3
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924369; cv=none; b=SMv9dNVc0YRqAEhmaGG7sh3Qez/SXpwPd1qy1PXtUZyIVBmDPRAFwYG8YQEB1Q0uQ1BWMsvHcxJn0lSBKCjKRI6di0Di0wL3bELqBv8YFDJN4FcWuvC6lPr1YXPTsJ17KL4O4PEPfBAP3SH44OpLXgNl2oGySvWIF9f/jSoNUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924369; c=relaxed/simple;
	bh=gUcbZKHXDd90uJuS/8x7BMVKmeepx7YHk2hjxukXZuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoD4MqHu5FT0FSfjI0NgNYd51Uo4zKQfdlLOru3PPlwl+6I6NtoVR6Nqsr+m8T74fKPNCPmVH2giwyTBYqDFt2ToDBr9ZyaU9ab/zAYDm1wVElTLl+gt1rjgPa4JdmHuAvzJPiZ8Dg7+uN/+sOPc/hvUaiMc7fUWsBSv5cZ2q/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iXqJAsvL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hw/pXqRy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iXqJAsvL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hw/pXqRy"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 113ED7A0091;
	Sun, 23 Nov 2025 13:59:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 23 Nov 2025 13:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763924365; x=1764010765; bh=zo5uNEGZ6x
	DWdY7bg0xZv+mR9QNhn3y+DvAGYUJ/700=; b=iXqJAsvLc+jVh2UdtD8c9GP6PT
	P0mdOGvaN0P32iDjBRFih7Yza2SZv1cC2y7q3XXVH+OOBbnCiHptwZF1ci+EGnIt
	1yaW23yV6l+eZrnI/xn9YfodJQIIVrAI1xiGN7KAJ5THP/j8tXR+1cl+9K80e//2
	eA0XzE7hFTCU+UDFWtERl9CMgkzaAvLKhZTabAo9+yQcm9y4ttTJghKWuSGlJ6xU
	zehbyQUjP26nE9c1Rhlr+9+bPo4LIybp5ss6Ej6r57M0VCBr8Emn09JEbVm/5Enf
	3WnT24PVqln4CTEZAL1y3Sl0YGcrHGy6uDI3hxUSlVr78ILPvAl1MOUjURjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763924365; x=1764010765; bh=zo5uNEGZ6xDWdY7bg0xZv+mR9QNhn3y+DvA
	GYUJ/700=; b=hw/pXqRy5sIZOnmhoS5BuircPmcSZb1i8PIGFQjDJpEKWLipq99
	KGrhYQU0glhwv+ka4AgwMy24+p3lDMNNCcjiZxfJ2A4I+tQBwM45fu7G2kAF1fea
	me7qUaN60DQcVWPrJP/L/IGc9iHu+pp0a4uPUH1sfjUvR2D+Rxs9e8l0Wb7Skevx
	/3/ylvyaBtoJ0EwCdRR6G+DNQEPdaJdHLVBDyRttayI6JYo8+gNotSvCxFbRWack
	VNylRgecQgvLAvsfAFvdBhzN0QGmA84I0TWnQMbpjCgmgEpPbBRWGkqIrnvLZdtc
	hZV1L+Q0Jd1dmhe9byo7kTBScCDp8fcooNQ==
X-ME-Sender: <xms:jVkjaaBypSwvEAVV3kKeoOWOwJN3ja95Y-XnQXz5stKVUVfxPOo3cw>
    <xme:jVkjabhOHHa9nyqd8MfdqMFHowWG6_Sc-MS7VHYRnnt-M4Lr6qJ6F_QaAguIASXBd
    XC_O_2mrUuqJU4SRq6FYrbmUGVCXt39Hgli9L0s-pAVZ38QB5ruGg>
X-ME-Received: <xmr:jVkjaSniUEiGlwJogO81EdgskvEsoF9cYSu77pejbmdJuExq8NDN7GHIukeIfAtWCp3TdF-Y89mECCB3vscUQj51-LYbaWmgY7qPjLsh3yORnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jVkjaXovjVpQ96NK2wfiRbmgBfG2xkSenomS5vbCnsSs9kn_hQWT0w>
    <xmx:jVkjabEIfqQSmXTFQE-R8RJP5UNlrRc-mzbf5E7V6_3Dto3AJTuQ3g>
    <xmx:jVkjaTwHOxXF761B7yrU6pFjvS8hq53TOZwc0k8gIu2c1F7iPlyDTg>
    <xmx:jVkjaQoQ3U1cWpbSplrsetxWQfYEeUwSB2I5KgBN-7MVQtoMiLAjnw>
    <xmx:jVkjacS5qv92szSmSVn0VsV2fR1dLyepUP1WVUNw8_y9_JIblJjmS8d4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 13:59:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5eb152f3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 18:59:23 +0000 (UTC)
Date: Sun, 23 Nov 2025 19:59:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 17/19] streaming: refactor interface to be
 object-database-centric
Message-ID: <aSNZiaa9tRQgKbm5@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
 <20251121-b4-pks-odb-read-stream-v2-17-ca8534963150@pks.im>
 <xmqqv7j32ahh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7j32ahh.fsf@gitster.g>

On Fri, Nov 21, 2025 at 04:10:18PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Refactor the streaming interface to be centered around object databases
> > instead of centered around the repository. Rename the functions
> > accordingly.
> 
> Good idea.  
> 
> > -	st = open_istream(r, oid, &type, &sz, NULL);
> > +	st = odb_read_object_stream(r->objects, oid, &type, &sz, NULL);
> 
> Calling the thing that is returned a "read stream" is a lot more
> trivially obvious than the original name "i(nput) stream", and I
> like that aspect of the new name a lot better, and the structure is
> also named appropriately ("struct odb_read_stream").
> 
> At least the old naming was consistent with the usual file I/O API.
> you "open" istream, then "read" from that istream, and finally
> "close" that istream.  If you insist on having the noun first before
> the verb, call them
> 
>     odb_read_stream_open()
>     odb_read_stream_read()
>     odb_read_stream_close()
> 
> perhaps?  I think _read and _close are already named appropriately.

Ah, right, that makes sense. `odb_read_stream_open()` is also shorter
compared to `odb_read_object_stream()`. Will adapt.

Patrick
