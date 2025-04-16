Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA42459FD
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799297; cv=none; b=GZFe9rjaLNz/sFBf4RdbSFmQ8gkOd7z9KS/PykolgHpjCheswmBQHvPGZ4WmmysVQYilsMnk+JUXa/42Xz/AELBeyAxXPfotBG6ALvceqwah0tqbscnKpKvuwgcT2DIPYj7q9eoCql61kQsD2VAl09HtuEqyUow8p4vSq39wXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799297; c=relaxed/simple;
	bh=l2wfIfM0OFEkaXkyOFSdgeOI5zsLTZHHoJ95sLUsJ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j23ZC94PG51nC2qxCJfKVcSSDsrzK79OLRpsdMB6xzd1ZK1MFrfv8IgUcqIBJBRk+k2lHGY43Krk0/xkrP83UbYZFAU8WLSbMoqIz+t08VW0SW0YJyKfSrhmqnRgdhJBBVwpXGj2/RxvH0VCFKZGOhN28+CQZSXTIPlfCrT9Ne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ncff7tek; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qlTs7o6L; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ncff7tek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qlTs7o6L"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8BD7B1140225;
	Wed, 16 Apr 2025 06:28:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 06:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744799293;
	 x=1744885693; bh=Lte1msYUI+pd6DviFvOcOQgEZEGaQfDU4KQgY9gKX/E=; b=
	ncff7tek+9l2fiwyQ1bQqHVkDfVRQr1E5ouh8YPWgzi3GC+DkWtZMjvyQqtUwGwB
	d+MOZCM2femQ9+YOqWr01H4emzGyptgrORnm++U+tTx5+er+mzhGNb1flxCLfets
	UkBU6oXftGQk8CyRZmEMHWZh29uS5QvzMyCTn5LfdRb3me7HpJ9pP10TFNnDyvil
	E9OYZ4ixbrAS8SZFpb5e4wHoszN0kk78KnBwcpwh7Yy91XfYQ6zUKeOVMPleavGu
	WCB30Fallt33SvO5cl5cczPIjdMrK7sB+gSLIJLNLK3xJ6lIVelnBRxBnhska8u3
	o1xSTAWGOe0zHZCJRgg3eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744799293; x=
	1744885693; bh=Lte1msYUI+pd6DviFvOcOQgEZEGaQfDU4KQgY9gKX/E=; b=q
	lTs7o6L8nol/aRajNzQRbN+xMfwnqs0KWg21XiVFmFl8xi4GU3hv7iLFyhzHMRSg
	OX1+QvAmxAPVLehUxzDVkjiP67Z3UDU67L01L3ZnTYEUxIa73M1vm1yNgUq+6fx2
	JJtcwIFpUNqYgjA30VM43wsG7oBs9TU6rXvlCth2NgSJr5+bNUbpa0jILCfeeHE8
	eu/ykrzBNlYOsWmpL2yTLovHB8tagwjVjG7A9ftsj8QmcZlc5RE6bwpiM/lcA+DU
	vrK2Vj/y8CJwCNFiuA3wTQdki+BjZaVshJD7yBu7EhBkekfr+xmPsTL8OxjSknpy
	q6/2NY9CpnkrqIhMMVklQ==
X-ME-Sender: <xms:PYb_Z92YsRYSBxUjooKKjM1ZXf4ywY0HkUHee1-P0dcpgwNJNtAEFg>
    <xme:PYb_Z0HAphJTPFuXTuVUXqFzvy3Qy2zdyU1tg2MUUxnGDNpp9AfD_aQClErNMqIzO
    WdQQAGpEmNqaWz92g>
X-ME-Received: <xmr:PYb_Z96ZBlNRdR4KZO0Ler3wzyLqY9k6PLrOXSc316ie9HLdaEqs1vSc9OIfcGaEDtpbp3OVIqFyGT1XW4KcTq0bMcwyfYa5GH9ChqzSlyzDdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtth
    hopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsii
    gvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehglhgruhgsihhtiies
    phhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PYb_Z61jmOma00Jgke3z2ZYsJAYZAEiLLqoEhsP4YOUdNfX3HhRncw>
    <xmx:PYb_ZwGjL4Ua9eUOBwHZoJBVjiP2Rayjzpv8olLOxVnVS_wGsOgImQ>
    <xmx:PYb_Z7_pjSUgUwKpO2HYepq8h1q8GQO5Ez3Rk37a99wYTte4PsRNaw>
    <xmx:PYb_Z9mxHw6Y-LC4UKrOJxCDbaa0Z3fThNiWmJ0jLxWXWu3rRaOs5g>
    <xmx:PYb_Z3bpihdPcMsK7HhyxV1rgs07hLxZZUAFwF5WAzXDvAQhbBrQ3e-q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:28:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 610d6441 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:28:11 +0000 (UTC)
Date: Wed, 16 Apr 2025 12:28:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] parse-options: introduce `OPTION_UNSIGNED`
Message-ID: <Z_-GOuC79KxWVwJ5@pks.im>
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
 <20250415-b4-pks-parse-options-integers-v2-4-ce07441a1f01@pks.im>
 <94f4ba9a-81a9-4e3a-932b-faee5aa2d2f4@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94f4ba9a-81a9-4e3a-932b-faee5aa2d2f4@web.de>

On Tue, Apr 15, 2025 at 07:38:04PM +0200, René Scharfe wrote:
> Am 15.04.25 um 14:14 schrieb Patrick Steinhardt:
> > diff --git a/parse-options.c b/parse-options.c
> > index ae836c384c7..9670e46a679 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -216,6 +216,49 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
> >  			    optname(opt, flags));
> >  		}
> >  	}
> > +	case OPTION_UNSIGNED:
> > +	{
> > +		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
> > +		uintmax_t value;
> > +
> > +		if (unset) {
> > +			value = 0;
> > +		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
> > +			value = opt->defval;
> > +		} else if (get_arg(p, opt, flags, &arg)) {
> > +			return -1;
> > +		} else if (!*arg) {
> > +			return error(_("%s expects a numerical value"),
> > +				     optname(opt, flags));
> > +		} else {
> > +			value = strtoumax(arg, (char **)&s, 10);
> > +			if (*s)
> > +				return error(_("%s expects a numerical value"),
> > +					     optname(opt, flags));
> > +		}
> > +
> > +		if (value > upper_bound)
> > +			return error(_("value %"PRIuMAX" for %s exceeds %"PRIuMAX),
> > +				     value, optname(opt, flags), upper_bound);
> > +
> > +		switch (opt->precision) {
> > +		case 1:
> > +			*(int8_t *)opt->value = value;
> 
> uint8_t, surely.  Similarly for the other casts below.

Oof, of course.

Patrick
