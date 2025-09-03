Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2614501A
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879238; cv=none; b=Rn9lUMOoCrRecGYKn86M9lGpelbNA3WvH5c4iy9wesFBO+LOaYbiqJ2MpKout9lNqsM+DdlwgEH9jT6hO+bYtWda5cmZtESWELTZNT44p6g2OAv14mkJOTogqw+KkC0AOdGeT/T0po9aKlXO34e2mKQPlC0m9XuHESQpum56CXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879238; c=relaxed/simple;
	bh=H/RKhaW7nvLD3nQP9IPsNsPFBd0z2e20nIvOVEWA5HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxNM2jgI8/G8jjqkeMoUchA9MuKE37ep1dEOF9MUiknfeNBRH+xRf8zgg3zkddCX/YaHL7QP30E748CKRtrzChTeZGILRPygpu0TVCN9Ahsy0K7cVbzSKTJkhIdHFZQYL8+axqoxKIqqKPpH53MFkpz1A5El4dwzmniO43byxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mx1wbNWi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j50gUEY4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mx1wbNWi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j50gUEY4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 680FB14003F6;
	Wed,  3 Sep 2025 02:00:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 02:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756879235; x=1756965635; bh=nC2ALCpqv4
	GStQF6SR+pvdz/1q03vISeC45U78z/BFk=; b=mx1wbNWiJ4TxB5+4+XtIDhR/OM
	eAmXNkZ8ZqgxgdPlx9KjopUe01fUN4qWE4zhjFT0B7IuboTrUXmyYI1dvYH/VrME
	BelomQ2m21sdubrdRGvJKlJF/SbJx/4RMGrLzlduGrztl6Zm/STm7h4pRxaz0UgQ
	GU/q2S7pqjxtU99vxIYAY728VUdntw1UbGwrtspaKw1ywl7V8EMUTKOkMnGVyxQk
	VJ0yG2QUlzH9/4mC0fvp8N7kEWRZQpOjf2B+GkWYuOtBtY/fcFhPFjv742qCkoAH
	W0KQ5wqkiPhHEMrbrnlNq1G++B1lFEQMtE1fuHQkz0i9tp/UMtGgBRqzBLEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756879235; x=1756965635; bh=nC2ALCpqv4GStQF6SR+pvdz/1q03vISeC45
	U78z/BFk=; b=j50gUEY4ISjJi3nzifD82tQnmt6CvQgrpDCrSbgCk8lITfqHNJO
	jC1G5/Q1AjIUkjWT1KKuuEqVd0O0XjgpvR06WkmSsijIkgZV5jxDdnR34ieJNLQJ
	JusG8bmNLVbQov0vyVe0GxVOn29RCGdhfYHGnpX1JzMW52/apArby9osND0aMbtW
	k6nc0FF3WNP0v2E4HbOHJjildewTMOuuTBsNYPJS6MK44iXg9Crh6DSHFgqH8udO
	99F/86MU+cSswQO+pHy5p0gzDBzOQx3FKdVOv2bCzbtTxiJOW+t3vxXUGGIpnz/M
	IHdZ+LPgcI+N892/258JFxZ1gSdnby0mdYw==
X-ME-Sender: <xms:g9m3aM7MWQ1zLSki8-s6udSyz5vw-boP6bQKhVDjvMnSJO5QmOqRrA>
    <xme:g9m3aIdVDz2lYRPpWnJDHNzeuQXR27TBtkCfbCfnFCtaJ0v6tppLxMbhogL4VSdoN
    WMEDEGsm0LLlDGtTg>
X-ME-Received: <xmr:g9m3aIDC8om7vksP6v34UkGGe9HcVB7dU7DPsTJURfbo13lvyTzNxfR-2IWrZTVlFgiukPigy1QoZULhad7iNZvM5QtW-oe2ktJvLMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:g9m3aD8GXdJSOIuk6sqxKIGMN-_Y_SisnbUN7XScMZwNGh6ZVW4szg>
    <xmx:g9m3aLKQ4tdj8RyGaQI9TrPHFVsvmX7OldjcXWPQhZ21d2bPq47-HQ>
    <xmx:g9m3aEibesHsCzZqfYR-6h1-8xRoMV9idx66-LO-Y4FYjzeQ_TBnDg>
    <xmx:g9m3aD60Qzo5Qsrj5FN5V39lu3gtWwRdJ-KAvuOZIXrRr6NJmHv-UA>
    <xmx:g9m3aEoQ3otNoE2t-su1YDkFr14gSkrVuJ2wrHrFRvWifDqc91-wLNd_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 02:00:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4ca9c98 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 06:00:33 +0000 (UTC)
Date: Wed, 3 Sep 2025 08:00:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org,
	shejialuo@gmail.com
Subject: Re: [GSoC][PATCH 1/5] builtin/pack-refs: factor out core logic into
 a helper
Message-ID: <aLfZflWT4618ptCA@pks.im>
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
 <20250826073645.1074397-2-meetsoni3017@gmail.com>
 <aLbEWSHUotkmSiCq@pks.im>
 <xmqq8qiwgl9j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qiwgl9j.fsf@gitster.g>

On Tue, Sep 02, 2025 at 10:25:44PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >>  builtin/pack-refs.c | 31 ++++++++++++++++++++-----------
> >>  pack-refs.h         | 22 ++++++++++++++++++++++
> >>  2 files changed, 42 insertions(+), 11 deletions(-)
> >>  create mode 100644 pack-refs.h
> >
> > Shouldn't that header live in "builtin/pack-refs.h"? Makes it way more
> > obvious that it exposes functions from "builtin/pack-refs.c".
> 
> There shouldn't be any *.h files in builtin/.  since the top-level
> is where the library-ish reusable things live, so that they can
> eventually be used by more than one *.c files in builtin/ and also
> by other *.c files outside builtin.

Hm, okay. I still find it puzzling if the header file for
"builtin/pack-refs.c" sits in "pack-refs.h" as it makes it very hard to
connect these two. How would you reconcile that? By moving the shared
logic into (non-"builtin/) "pack-refs.c"?

Patrick
