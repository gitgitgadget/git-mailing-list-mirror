Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AE3358C5
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615347; cv=none; b=Kr+/0FpCqeth5uULQw39/iWskxnQ67NER3jxE0j8bbIGTbjXB854c6FkSh/lcDeAwczp1RKlX4YLiSNirf1/BX/3LAvKWMhD2KSrVhpW+7p+Xwh8dTqWa4dvdjawdewTdT5v53BVMwDTQ67VM2ToyKKfJjA1pvLWTW4v3rq+XAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615347; c=relaxed/simple;
	bh=LU5AhFmk9DRgT+GnBzAn5p1EZUOlt4YS0h49yWbD2b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kONdjCTS4W1cwEjQKJzXTDj7bu5/CbFQMag4xZoOq9BlA7r9VAwqqJ3tr/RiFDs2AnltxvI8jyiRL8vtUy6pA+VgB427u76VPZfa8Z7olS+0SxbNKAsWuE0/ABUy+JicFaxDo865DXyI2O+CSou3NooNt3bxicncGc2hOjrkIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NbRdQjus; dkim=fail (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2ty5UeK reason="key not found in DNS"; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NbRdQjus";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2ty5UeK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C92F7A01FB;
	Mon,  5 Jan 2026 07:13:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 05 Jan 2026 07:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767615235; x=1767701635; bh=/tebqfPMZS
	65RgjxYLdRDws8u9J0g19JjOB4ec27m9Q=; b=NbRdQjusHUzqJL/F91uU9OHptQ
	tP6Y7x1/Xy553OilGZZgdZ9zWcqSYVynLNuZ22Hub35SLwGdn8/IWrCG1vtqdfAW
	9EXUv+Qt13dkQJRtNUhkOcqX8wSbHAFq8kbr278nJNBFrI2q1dHoH8rmx69CIn0j
	zmOQCbvejGBp6wbovJRMiwNFnf6kZJg7mpDsgffOOfRZDXwdDh5zsvSZf3lUXYtV
	H2rxhxwiZ3g/ZJM1pCLmsmQ+WLgyqqF5mqXp6tF3A/cTqsPZ8QfgkJV5lzScnnna
	y8NS0LRW7CWkrPSEAlujZ9eroKqdWV4SCLPwROTR3ek2UL/Me5PE0Agm7TKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767615235; x=1767701635; bh=/tebqfPMZS65RgjxYLdRDws8u9J0g19JjOB
	4ec27m9Q=; b=h2ty5UeK3TBY14N4v6iP/IF35aKwPDS5kBX463oCzmZxTqZMK5w
	ORKZ/QRPc5tDSxhjAe2wBqNdaWVDL/ODaZoASjgHPH/wXNLGrSadn2iurQB6VrNc
	C0sZPPny4jIA5jZfrduJrY1ZkuNWsC0OHQ/Mig0cq9nWu2o/NpppsBthDrgM0YEp
	MReSKbLW+A4AZka4IeREU2LSf8qyR5KtJYlF8gEjL+dvWUu6zjd6cXDKR2tWwTgf
	cYxCsEcTeFKYLS7ykXkIBL64LcI32zhUMf00aNbCcs7BUqhhA4oAsoDuDTAPvEWr
	ljFvfBCinwd+FY+kz3nY9zMbIIx2UrXnLCw==
X-ME-Sender: <xms:A6tbaWy3XzVnivBqxhyy1Q5OTOSXterUiYUlP-ekauCSC3Y54KyKFA>
    <xme:A6tbaU0B0KrXy01Ch5RCKAruQNNSEQY_FkMzE6k4T7JQIj_sIh5nn5V4-ozWXV9F9
    hS8ChVTMqk91mMM3MoAlCPNGDozJRw_F80Mo_qoRJQfUIzV6lNA>
X-ME-Received: <xmr:A6tbab-Q1RtwU5VJBdjTnx8kVn-0E9mXfcBzNqe-as9mJZualaAi3w2RiKGVrHXMyDq9CW2A_hNM_FdaHQPAeejiJqNGdI5WRt0DUtJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghmih
    hlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:A6tbacrwmtkfPfYxlX6tvEqEr8DIvtMLi7muxktFxiU5jg-5cdGSOg>
    <xmx:A6tbadQxBoM8KZw7d-1xgFDO0eL_p31KOopSkeq49uSmgIAmw8YIEw>
    <xmx:A6tbaXNleTMjsHKunbCuwRa6jqkx-7bvl7olaa9chFjaA6Y2oF5WOg>
    <xmx:A6tbaTiA4ASfPJLnvnN0_ZND-bvEXKUPaTvmWUoMOrEx_M-eFEo-xg>
    <xmx:A6tbaU0T4gFLh_ckCjNfIeJngShiUv1jIEGuYHMjommy9m5Bx_iFzWXR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 07:13:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 185de7f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 12:13:51 +0000 (UTC)
Date: Mon, 5 Jan 2026 13:13:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 00/11] Convert remaining hooks to hook.h
Message-ID: <aVuq_e-fRoBJArxG@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251226122334.16687-1-adrian.ratiu@collabora.com>
 <xmqq344ulu4a.fsf@gitster.g>
 <87h5t0babo.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5t0babo.fsf@gentoo.mail-host-address-is-not-set>

On Mon, Jan 05, 2026 at 12:52:43PM +0200, Adrian Ratiu wrote:
> On Sun, 28 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
> > Adrian Ratiu <adrian.ratiu@collabora.com> writes:
> >
> >> Hello everyone,
> >>
> >> This series finishes the hook.[ch] conversion for the remaining hooks in
> >> preparation for adding config-based hooks and enabling parallel hook
> >> execution where possible (that will be a separate series from this one).
> >>
> >> v6 is minor refresh for some last nits. Details + range-diff below.
> >
> > I didn't see anything iffy in the series.  Will replace.
> >
> > Should we mark this for 'next'?
> 
> Yes, I think it's ready. Thanks!

Likewise. All my remaining nits have been addressed, so let's merge it
down to next. Thanks!

Patrick
