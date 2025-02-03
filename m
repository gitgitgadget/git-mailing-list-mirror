Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D21FAC58
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572573; cv=none; b=Pd819I3t7Lu8+d1Nh7uUK6c2jiw9RB/UPMHEd2XPLN7HtxIn0ma4FyVPIUqF+clK8fD1sTapD/2PEgFaxi8SBbRTZ2S6G9+ZdVnkVwCa5m3Jtjh2hL/heKOM1ZTMlYnTeWffTc87NZsIcEmUROW2hqXwpafpOpEXJ6sUaHOwcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572573; c=relaxed/simple;
	bh=LbmiAvnBebbo3svkmj7GcRN8wZMvPUi6dXeJXAYLmOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTI05GbjdsPpbRYOrhxNeGLlxs0CjEs+AKOr8+9eg8avHzptkUzTKXgzvRMn+v/xW3CdmtQwxgT07ho7GiuW8VMLlRvNxECi9+XXQKWUAZJWm2ncAiC+AAXhEZ7yubKs4l7mdbXaAy/rfm6Kll5hyOpIaKZjcTlEtZCiQ9uih7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IeP+vqlY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3OWDrOB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IeP+vqlY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3OWDrOB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0D17114016D;
	Mon,  3 Feb 2025 03:49:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 03:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738572570; x=1738658970; bh=N+FCqnr5y4
	hVTLmv+1pFiACubllQHlsBdLs9sL7Bde8=; b=IeP+vqlYw0dEWPYyPoUz5lXAOi
	SkHGYUK0ua7lyVAW7r7/UxahqKVtadFiRf5vMmCltHOlpYlRVQx3tDeUHzUPMM3Y
	jzdCp6AstvjuhLlYhUGEIUWJtZ49BbfsVidotO/fTNlAmN9TronpPnsC8viZXkMA
	G0L1QURE/QMdc5Yo02xg7ooWJgntAQrSkuLKHzsap56HFUtkt4s2HvTP5pp6o1ZQ
	p11aDK5SyAgsDTkG2imCXYWZfDJQR+T9L6J+m42E2X1Skm6d5Klk/+fMPypY3R9X
	HfrEcr2fLOEuTSX4lv1NdOPLVsX0Hrt2Uj/lWongJXfTi0HbfMOsm43qYVrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738572570; x=1738658970; bh=N+FCqnr5y4hVTLmv+1pFiACubllQHlsBdLs
	9sL7Bde8=; b=l3OWDrOBm6w/CSOTWsG+nPxmKJnplhRNgBOSO+tJKTu1oYyO6YP
	6WLkNHYhFMYQo6IOCm7YYzy/5hj0AugsFFc1Gyl487un/p5ZMKNruvi9gFmOI9OY
	RLVp7dRIEWqA0o1MdEAGqv/EspG+yk5WZzDxT/aGd+lyx0AyR4zuqihLAEBNA0nf
	/zOprV+av78d7LC+OCwXNmWlVred1YQ+/cSm3X0wBz/tDU9BUDKfb7yRqI++eyJb
	9qdY7vf24ciEy4Dtfemcrvxp/wBi1LeUf2mhu/X+6FI9DuyBkS/E83/UxCRhqQM/
	Z/Ckd/iBlLWka06nGpepMmp6WZ9umk48AzQ==
X-ME-Sender: <xms:GoOgZw7zQ8ITHekbT6EqsaoP1ZXCXYuybS5VnzLC84iRijSQhiZiZA>
    <xme:GoOgZx4tK0CgPuav9d6bNrtfVqmS_xvxyh2MrcWyhuLbRyYLJUA7xHvtNZoWORvFM
    UNvzkV4Z-a4GjP1NA>
X-ME-Received: <xmr:GoOgZ_eB869RFSVAFUitynGXiV6LZ983lUEktkNVkgPa67DdQpTz_I8XpDiz2FbQy3QW1rTOy049IXMaCCTAWNDV0XRLCKAj089M_EyEX9zuBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GoOgZ1KsCfjElPlaJf17gn_V8eZW0bZXcnLsjuyHTxA6JRWnK7fC1g>
    <xmx:GoOgZ0LPy4D136pkDjtsWi8LAlsoSELWA9damgmKEE_vjXB3k6zvkA>
    <xmx:GoOgZ2wnu8Bfng1A1K44AGSoyYWQDfYAP-oiP7jxhA7OHvdgZQubjw>
    <xmx:GoOgZ4JiSKdlLa469tafjf4HWXie0g4WpXSUKtbnGKFci2ygCOOeqw>
    <xmx:GoOgZ-gMZPHLxECkHTztbYSQKNE4-d5rC5yppthwFhz_HEwkxmEV99GQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:49:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 38c2a90f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:49:28 +0000 (UTC)
Date: Mon, 3 Feb 2025 09:49:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
Message-ID: <Z6CDFwtSRNz0OaM_@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
 <Z44u7od-mDiKcKVZ@pks.im>
 <xmqqr04vzyz9.fsf@gitster.g>
 <b784f612-4b6b-414a-9742-86611c50c55f@gmail.com>
 <Z5srHBSPKQlsuH53@pks.im>
 <xmqqjzaccdpn.fsf@gitster.g>
 <xmqqr04kaufo.fsf@gitster.g>
 <Z5xW57fsOCNcGViY@pks.im>
 <xmqqtt9f9d8a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt9f9d8a.fsf@gitster.g>

On Fri, Jan 31, 2025 at 08:09:41AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> How about making the rule a lot simpler?
> >> 
> >>     The expiration date kicks in _mechanically_, i.e. stale entries
> >>     are unconditionally dropped at the date, based solely on the
> >>     comparison between the timestamp and the wall clock.
> >> 
> >> People are free to advocate for its continued existence, and when
> >> such an effort achieves a concensus among then-active members of the
> >> community by the stated expiration date, a patch to update the
> >> entry's expiration date may be accepted, thereby prolonging its
> >> shelf life.  Unless such a thing happens before the expiration date
> >> comes, we will mechanically drop the entry.
> >> 
> >> Of course people _can_ resurrect an expired entry later as a new
> >> one when it seems appropriate.
> >> 
> >> That makes the decision to expire things from the list easy to make.
> >
> > Works for me. Ideally, as any other topic, the retirement should be sent
> > to the mailing list as a normal patch series so that people may chime in
> > on the retirement and state reasons why they don't think that is a good
> > idea.
> 
> That is the complete opposite of the ideal from my point of view.
> The whole point of making the list items expire by default is that
> the onus is on those who want to have them on list to justify why
> these items must remain on the list.  A patch to remove an item that
> hasn't had anybody advocating for its retention shouldn't have to be
> chimed in to be supported.  There shouldn't even have to be a patch;
> that is what I mean by "stale entries expire mechanically by default".

I completely agree, we were simply talking past one another :) Retiring
an item from the list doesn't need any additional reason other than the
expiry date. But people can try to advocate for _keeping_ the item and
extend the expiry date in case they have a good reason.

Patrick
