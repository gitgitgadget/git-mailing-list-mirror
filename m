Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA57193079
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960003; cv=none; b=XDZN1fBlyqMFSLddDBp62D5oPGdg5tfyQnZUY8pOFfce17i7Pww+SwhEvxm8Rmt7UmceHfTjuSorNdHmaD03ixy4SsNi0/Wdg+zMJ5lMT1i1syIFRO7uA0J3eeUYAJf5z+MUBBs9BbJkaQ+wXN744PLRl3mgiV/99A27Lw2U5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960003; c=relaxed/simple;
	bh=oQWRovYTzaWTpV6sHo2MALbj1vvB1i2n4TfdA74WcTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+jGOxfT++DLzoOAzHv6RvZwnxBQGnljo4CGgosGcUEj/68KNKgB1C8TI9+CKfskIGzqEbXXHTzSOfSqTsnShHiKHqYR4++lv0ysrVr2AEGMFzOb1Wzjgu9RUbbaOeFixdugroPHqxXUbrn2XGpSDJoq9yGLVmnFKVbkgucZ0mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fWW6z0MJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4usrAO3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fWW6z0MJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4usrAO3"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8D8D1140169;
	Wed, 15 Jan 2025 11:53:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jan 2025 11:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736960000; x=1737046400; bh=W7G1vz84rq
	8hH9TrGTJWoPW4py4WCEAkqQjrwYn0kOQ=; b=fWW6z0MJFCIbb2Poa2qOq8aMV4
	rAPgTrtIx1EaiiZ8QUnGuRPYjA1Xq8hZwOuxEiKEmNHmv/U5v71F23xw9YYMzRgY
	dnUCnnD44oOPAX98+DVlUsULMclQVDmW19H/01nV+br0tK9hoSEyy4llTzLMDTGQ
	VD8h8Y1e7M0jA80qXrL6c6XxVg1rq/hVOYBnD4OT19IPdLqhAGyDsq33ELpV4Ib1
	Uq17/RhpOaMZeEaakWHHWQRul909Qf72QMa1OFabWi2Z8/lcg1Fkd1nsiI/sHm1Q
	GQ3ZyBF/sHhcRIR1W8ZVtOFeSTbHAR+muXk2YwOZwqfgDoJAfuMzJtSWigzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736960000; x=1737046400; bh=W7G1vz84rq8hH9TrGTJWoPW4py4WCEAkqQj
	rwYn0kOQ=; b=B4usrAO3LnYpqcKuvIhhcVINqxXCIeBb6n313NNJKwV00Mhy11C
	z46jJbxFDdg7+xMpg5RvVR7LQW5uI9LS9wmGv74D1zlxLgFxiZhiRvH81QfRE+lo
	SVJJ9Y+xfHjoT+Kn7XqrWvD3d/Nlga1Oe9Ee8EtTmH93mdAfIGY7ThBXdADrP1wN
	afuuCCpjM3+q96TBm1NHOtBO/fLkHtIOYB9jJkPePj0Ta4E0PwLHS45Us4yNKPjy
	axVvv5fna+e9BhLB2Hd2BjMCx3tBkgNDhuOYOdDTWItchlRXyL222dFQGLWovL78
	3BwrLCadwPZ3HqQGTRNApSfIg14QPGF9CJQ==
X-ME-Sender: <xms:AOiHZ1RyTdt1oEx_eM7c1K9oDQMZBjFm5mVsdLVJ3kR8AUKL5wZRpQ>
    <xme:AOiHZ-xBF3rVxd43jjmhpa_RP5txTJJh7ADwnbsaPnjnkodwHPk3omQ8-C2vB1ms4
    wqQIM7QncjEszS94g>
X-ME-Received: <xmr:AOiHZ61xEUZ7YtBceNhTbCnymrpxkfKXGAyk3H2BqVMY3OqXnB6OWgyArFgfHlYRe1c9xldLNSlhjM7439Ar4LJ-y0Y2HJ2a66ahoiUh16MSRhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:AOiHZ9BA7pdfQ0l1z-64doeUCkIysETGTTA6wfuYqVCVYqcsYo38cQ>
    <xmx:AOiHZ-g8sBqcq6qoBDavQd2YW-cBrb2BlCgfcEQWeecPxVFTeJoyGA>
    <xmx:AOiHZxr7iIoyz626rMPvzf6ZSXiR1FyT1geA5IsPos_Ph-W6p9QCTw>
    <xmx:AOiHZ5jXgYikIjwN_zqhKZSyw_Tq_cU8S_x_BEQ0hIOxKmOaBCxMgA>
    <xmx:AOiHZ_vpB0YzSVREifZybqSHQbesAC6cV9R4k-HjEdYrlB-MYUWfDpPD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 11:53:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 66c2038b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jan 2025 16:53:18 +0000 (UTC)
Date: Wed, 15 Jan 2025 17:53:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 09/10] ci: switch linux-musl to use Meson
Message-ID: <Z4fn_cTzEl_vZ_Rw@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
 <20250114-b4-pks-compat-drop-uncompress2-v2-9-614a2158e34e@pks.im>
 <CAOLa=ZRiRWubZJHvzgag8Ypaeye_xzZ9e5bdZxRBQFL_qhzb1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRiRWubZJHvzgag8Ypaeye_xzZ9e5bdZxRBQFL_qhzb1Q@mail.gmail.com>

On Wed, Jan 15, 2025 at 04:25:58PM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 8885ee3c3f86c62e8783d27756b8779bd491e7e6..71d85ae85a02e5a4389e133ed53f45a5042af36e 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -378,10 +378,7 @@ linux32)
> >  	CC=gcc
> >  	;;
> >  linux-musl)
> > -	CC=gcc
> 
> Question: isn't this still needed? I thought there was no way to specify
> the default compiler in meson and as such it is better to be explicit
> about which compiler we want to use.

We already default to GCC anyway in "ci/lib.sh", as we have equivalents
to the following for all CI systems:

	CC="${CC_PACKAGE:-${CC:-gcc}}"

I'll mention this in the commit message.

Patrick
