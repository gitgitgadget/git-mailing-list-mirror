Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A387C1F3FE3
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879022; cv=none; b=auAHDyBKLT5S1YTPSHVD0Zzk+3XSejJNBPvdtruLTMIQ4k+7drjx5Umv1Z+5lyeTbmHKq/wf/yBxh0EdI8mA8wjJ3jL48ppEWP4ZcoGzpHA8Vd1An40tQRMt4uXZCEEDqyhTb5rMTl7qpjWou4E/pFt2nRlVNSHITW0zNVgQ3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879022; c=relaxed/simple;
	bh=GgJsUSUaKxChkGQo2GBEAjrnTG2BcAolttJpyYhFYkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf+/HdABc/d3H1YOgwNs0S4ytI9alitklOMMB28XhCa5/i6jV/JJYshpbeBEi+t3J+vSaRu9sQDX0eWk6yZKz1d6d8Hepl/y8Y7qANBTO9472oh+eCBE1Rbz4HGHSOo06g9Beh67WCO9H0LjcOG4t3umTdQ8k+UdPU/gfO/KGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CkfnSah1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LH/IR59L; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CkfnSah1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LH/IR59L"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7878825401C4;
	Thu, 17 Apr 2025 04:36:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 17 Apr 2025 04:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744879019; x=1744965419; bh=N0JVpEzVpl
	lK2VAsdEP6TAZJeon6L8O0Ge4S4I+EHTE=; b=CkfnSah16gCR7gYn4+T4RjBuxI
	6UtnNMKDRyrLlLG6hRBt8zoRW2XkfA1BsJTs+O+9UNay6rHjjEhr4/F5BByrJQQU
	6UQB7e0v/z1Aqo2B9M5RvP2JTvraNzdRKXV28maiisphp9u1dk/2/fvfF/RrdVIp
	tQilTVLdCjA4+l9/N4EGDLUTzIV4VE+tNgJikhW+k9ZIURCdNJttpPDpUOTRPb6v
	M3XIvnG97y27oz18VH9IgCADQ4/VRJKf2lUI6yLM675xY/AzTplIaz1/bmbwRVhN
	1r6q9dpmBf08IhDKkRZE0pAwP5hi96viGIBchqzKApvPic48SGfRg3fuTUwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744879019; x=1744965419; bh=N0JVpEzVpllK2VAsdEP6TAZJeon6L8O0Ge4
	S4I+EHTE=; b=LH/IR59LNHGhhc+AJH6QzsEuG492TwFtL45t6TjjhpaqAIW7c86
	KvbrvvhIE3GC5Pa7A+UJd4VBWX1iUrrLdXUUezf8r4VIMI1W9UVcmN3yDKX4y+hv
	Kx6JB/m8XAQtDPUBfrXbJ8ndR8zIg7wXz0iRIF+CEp3iBEb69tUGenauSk35Leu4
	eEZmS2qy4gXzteVVsOLrUSUvESISCa7pN6A/zXBAXN2IaVL96a9hYVnhTmxPVLUx
	ITMrnd3EXPs3zqbThP2DLCWEWt82amDxaWhu/nAewAjReHBk7iy7yhmlFq2+IF9c
	nAFmaZF7l2HHAw8c/1mPrOA5zJI8uD7IiFA==
X-ME-Sender: <xms:qr0AaKUzerhwH8_8dFWnWpM4QcvvDSoBhALnIKD6cnnOMl2XRsTKfw>
    <xme:qr0AaGlXgFB5B2Zg07nD6Cu9DCOvLdN6cvitJDyavfncFfo7HA3YmHfoq-loYMmKI
    QedZdX8YshDPf1ptQ>
X-ME-Received: <xmr:qr0AaOblWS8VlNLW5RyjTaz5eD1SSonnr4ScH5QfJOp_1hz0hgBcLebALRWmQchXGqshH1TPBLXw-l0kpxTYo3uJ6GsbWABqZoPJHLmENB3EwLQS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesughinhifohhoughivgdrohhrghdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qr0AaBXzvpbPiYyd0eRiOJnAhF6QoWbxTHw1YDBgZXEyfKG7-EwL4g>
    <xmx:qr0AaEkiUkepvp1oapcrhIqrt9Op52TwebfFJbXvDHTKmCw8SL1OYA>
    <xmx:qr0AaGfL-JIicytmck1930mC7S2LhRcv_jAiAFDBiIOWD5OGkXBsEw>
    <xmx:qr0AaGG2PmK69bRv073DNlkncIgB2bVuccOErhtItmcGfgsuo1WhVA>
    <xmx:q70AaC_q-lZdJ7PrAP4JMn8PXDurA5QoHzkEp2Y0QsU4IZMvjhr8_Rg0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 04:36:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 030cd947 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Apr 2025 08:36:52 +0000 (UTC)
Date: Thu, 17 Apr 2025 10:36:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH v3 00/13] miscellaneous build mods (part 1)
Message-ID: <aAC9ptpajuOnH1Gr@pks.im>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
 <xmqqa58ffo2p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa58ffo2p.fsf@gitster.g>

On Wed, Apr 16, 2025 at 08:45:34PM -0700, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > changes in v3:
> > --------------
> >
> > - patch #9 adds some whitespace around the '=' sign in the
> >   assignment to HAVE_CLOCK_GETTIME and HAVE_CLOCK_MONOTONIC
> >   build variables
> >
> > The range-diff below was generated with a 'creation-factor'
> > of 80%, otherwise patches after #9 are shown as complete
> > re-writes.
> >
> > I have built and tested both the make and meson builds on Linux,
> > along with the make build and meson build and test on cygwin.
> > (A 'make test' on cygwin takes 6 hours, so I will test that
> > tomorrow and let you know if it fails! ;) Highly unlikely to
> > fail, since the v2 patches passed just fine).
> 
> Thanks, will queue.

This version looks good to me based on reading the range-diff. Thanks!

Patrick
