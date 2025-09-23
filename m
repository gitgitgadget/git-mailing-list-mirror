Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0225A63D
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603297; cv=none; b=OI/zYUF8NrPfzQ+7XuyUNBZx1/IMVefj3l+1JSMLL1PZpPOii9GpMe5A/4+sNewlUtkAzCBD7T3wAAMZP5f++Gs/aniCBMeXHJ2tqaNbyT0/XByiRedU29QoqYd4qVS7G63zN6KOqlajDUSoJSVQeL/8ezpnflh6S+XQna6GyMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603297; c=relaxed/simple;
	bh=RQ4XhZG2/Ju5FQQAzASAeo7LIAguZeJdIKwkaR9vnDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDn65AqNKaSKsR2Au4DHmiSpTXTMcClsOoG3ScWMNhqrYmS1Ey0LBOoc599laTtnYvmov0PyQthY1CO/CjiLCGZJ/Wbl6iNuVo4m/dKAOfPLukfPQB3i5foA5pi3QKZrf40r90i8SlJJP55ro//x9OGvoJNu3rIJyJJ25hy5gZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hoPonu6t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nhky318Q; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hoPonu6t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nhky318Q"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B587140009A;
	Tue, 23 Sep 2025 00:54:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 23 Sep 2025 00:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758603293; x=1758689693; bh=bvzcgEyFb5
	BcN4TtnLURUxWJ8DxKi8ZFlaFmmZq2nvE=; b=hoPonu6tXAP7cdhyBjPDdqR53/
	vewskKNw03bUwQcMTKYeFN245XwbJIxM5hbqgpS2j6ijoU7h+QjMfXl64uysZx//
	HC9G7Yu/i2rAb5BvgYq8nHgWAdFuMQaAvMLVnYOdXxkI+ah6fvlg/fzgwB8zlwVg
	sAg1jd0+9rxsZ1+KrVF4pHHJ8O6IUcMFfJ9WmfJ2Xrccy3FV2LegrU9rs1+s1cDn
	bhuctHSqBIG/doXylfUTpQfVhpBbNhei6nXNZIiicWFzcLtXBFC4rIjOB6WQUW5j
	jxSjxVhAUobtAxCJby1rHwlcFqdy9MnMBDGEp+cBXUaAlQYMXY7tnGWF41mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758603293; x=1758689693; bh=bvzcgEyFb5BcN4TtnLURUxWJ8DxKi8ZFlaF
	mmZq2nvE=; b=nhky318QnEQxjRZ27Goo8NWmaO7pXelS5yyL3D3Q04AQjlS+5Lv
	d81T89tRlqgwQiLCT4SMrABpxNx+uPz8zfaIEqzcsRhm04ghyykwq6hX+KnLKOgT
	CAffoHJMgTm7eU0ulDiUiKne/jhifawodvjGH0sIOuF5pdwI5LsrOC2WduTDTIJY
	2bL7P8r/0wPRPt+5nZMtkdXRiGPdHYPGsEm+AgYX6x3O6rr/EGoDBkJ9rtL+Otd7
	ivOyoP/cAdeQS5u/AfkOJ+ol6rGTQfjnfcnyQ9or9PKGELNI5CP/1YV6IVhOzW5p
	3vgb52m09CPZhKGcaTgAHqusNcqcoGBe9TQ==
X-ME-Sender: <xms:HCjSaEVr4-yq_E-rPQWsmdUhqE45pRyGGR4JcIjQm4r9-OChK6yGOA>
    <xme:HCjSaHHoVsgsX_ciUCJJKddh-YIibDk4HrRehNooywvgcZcc7DuEwpu-8K27yTtIX
    v99lr_-_qei4lt34lu1RZp6oTpC65Shu25NeKAj5ryI3nuvMHjo>
X-ME-Received: <xmr:HCjSaPOZ_h3WEPWhbPdmMfQX0wSKPgD9mWR9GiZw-asmUVzO4_gjtPPp8Q_WRMul0AGxS6-Kc4A2OKQijKkVKeff7t4Ms6h66lBe3vhSXNqy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehleekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggsse
    dvheeisghithdrohhrghdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhp
    rghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhn
    thgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:HCjSaDUqIvuCVunF4xTEnrP7AiO-VnvTEDSTMm9mFU6BbYCL57kJzA>
    <xmx:HCjSaGzUUk4mQj2q0fSzVqNc7yWyeFMft-436-rwlk2mUVZM2KApwg>
    <xmx:HCjSaDP45Xv39LsB8i9fKYEacmQ3FoXhMtCwS9j9I3g-MfUMGaG6bA>
    <xmx:HCjSaIqFmUU7C9CnPrBU726zaspTYGZ46Ajxq32M_lEjN7jiHJsFeg>
    <xmx:HSjSaM3eNJ0SDiMnsEjmha2chpILYqnOn_yQmmtAUL2-4QGQSJrPkRLA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 00:54:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5f0ae43 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 04:54:48 +0000 (UTC)
Date: Tue, 23 Sep 2025 06:54:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
Message-ID: <aNIoFePhTc5vGc_-@pks.im>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
 <aMsxhp6ZO2Cdz7+k@szeder.dev>
 <aMteF4VTq2C5sAhK@fruit.crustytoothpaste.net>
 <aNGkt/DdnbjNu3s8@szeder.dev>
 <xmqq348etd9n.fsf@gitster.g>
 <aNHKdFkiGLPcLEjP@fruit.crustytoothpaste.net>
 <xmqqplbiqeol.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplbiqeol.fsf@gitster.g>

On Mon, Sep 22, 2025 at 03:56:42PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >> As I already said a few times (e.g. <xmqq8qipzhg3.fsf@gitster.g>), I
> >> feel that the timeline hinted by any of these documents that were
> >> proposed is way too aggressive for affected people to practically
> >> prepare for.
> >
> > I don't think it's substantially more aggressive than the
> > interoperability code.  Both are aggressive timelines, but getting LLVM
> > ported to some of the affected targets isn't out of the question
> > (especially since older versions of it supported some of those targets)
> > and once that's done, I'm pretty sure Rust upstream would be on board
> > with supporting those systems.
> 
> Our timeline being agressive to cause more intense work on our
> people is one thing.  It does not make much sense to me to compare
> it with the timeline being aggressive to others who do not control
> our timeline.
> 
> Putting it in another way, I'd call it hopelessly optimistic to
> expect that those currently without Rust can somehow come up with a
> plan to help their vendors (or they may be vendors themselves, then
> convince their management) prepare their platforms to support Rust
> within 18 months.  And giving them ultimatum based on the optimism
> was never my favorite part of this whole thing.

We have made other breaking changes conditional on the wider ecosystem.
For example, using reftable by default is conditioned on the ecosystem
having catched up and supporting this new format.

Do we maybe want to do the same with Rust? We can for example add
something like the following paragraph:

    We will carefully evaluate the impact on downstream distributions
    before making Rust mandatory in Git 3.0. If we see that the impact
    on downstream distributions would be significant, we may decide to
    defer this breaking change. This will also take into account our own
    learnings with how painful it is to keep Rust an optional component.

The intent would be to alert distributors, but not "blindly" pull the
trigger. Instead, we should take a step back and evaluate both how the
Rust ecosystem looks like at the Git 3.0 boundary and how painful it is
for us to keep it as an optional component.

Patrick
