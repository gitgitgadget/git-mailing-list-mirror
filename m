Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F872E36F4
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289250; cv=none; b=Iq6tTrPGHEF3Uyj3RpAbkmbwjqKh51ui2pyTmipBFyERry9UnpFc11x196rhBOVV4XG9/oduFtRByob3nmQFKhib0BvfxeXUk8JECM5ZzXcPpQQpXyrE4k03HBlPoewxQdipwb2BcB+t2lfe7rBnL6vJYqBuU8LU/+5vmHeH1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289250; c=relaxed/simple;
	bh=vDOpxwlX36fI11BHpjTyLozNqUmv4SFgbkuXL5uRXi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sU55cJyszHNB0WCDz5//IldO0TYh2CTFUk7Bp35DR9vS/+pQtpW6T3NoWOnJm6wY8FkAdOlQd//DmgpWRrIS4vcI7Ge1eBrz568ZuNa+PtopUyas2KPZ0DX7cXQw2xQ7jc9lBSaIEDi7dVEHcKI1jEbwDneEVahl2GPxtGROfog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SE2q2t/V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tia4oz92; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SE2q2t/V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tia4oz92"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CAC401D000D9;
	Mon,  4 Aug 2025 02:34:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 04 Aug 2025 02:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754289247; x=1754375647; bh=Bm6u4YMQOb
	Mr4AR8x6iZ4zFOIMNX2K4lmRD9h+vX11s=; b=SE2q2t/V6HIxjx6wbqttYYgZ1q
	mAHszNa8NQHv+8GUgU2gwJ//h8F4r++1bcYhgPVibX1NDTT8s39FOUGf1b03PrWR
	m2v1b1yERdwj6oCC2ib1bJtDGMveTEcx1lp5Ox6Oo0eJEDIyEfWeV3jb9q1TiEq4
	Ie4K95IUA7+ISBTgHOMix/nYf78m/ZVkGB5UrSe5g3u0G951JPZ7e0ExIBtKEbr/
	l6zJ49NJ+3KIVl2WYzRSOXFz6xRr0ZOojaULx6JEHSqOPmoXOaiHQIYeR0BvpB5W
	/62mpr9/dpvb5WeD34jLLoADztTVeLUqbGpq+VmZp+VE30p6JBZwrgUpFqqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754289247; x=1754375647; bh=Bm6u4YMQObMr4AR8x6iZ4zFOIMNX2K4lmRD
	9h+vX11s=; b=Tia4oz92kXqu0wNEJbeTp/EHk5YL+tU7t6BPXyD1UlTxnVhzl6q
	2F+qwZhYmhAVqnb/kG+JbSkUsnztXWJwvrSL0iy0IRj8ooD2+fffCFgyBCb32gRA
	4+EZBh6fEFHgcx4KtndEq4dmMLVYLI4/t4HkOc9jrMabaui4YywYc85xy4uuTyfs
	YbqlC6D+ufMtVvV+G/gXmsB8HA84BT7eLqIpRLYDdv8bWGP3vNva5WJcGVAOXjT1
	LEabUq/jblXTT1aEyq+So0H3RZx322HahKKO0+EYw9zawdc+pTaeW7GksE+C/y9+
	3bHozAAHF2iAHHqLi4SHxRku7xakjlqHpAQ==
X-ME-Sender: <xms:X1SQaOcr0WWTLiRVXWzrIrQul4MGZe6nffFwWXe7_umBCn_itJBAkg>
    <xme:X1SQaFEQk5nsaJn6wD_qHoWTEUgpj113m3pdcnEwRn_urYUTfIFlIxS8-QhXtM3VE
    RT0FH7QBMPSaZ5csA>
X-ME-Received: <xmr:X1SQaPRtf9pHlGKK7lpoA-i_ExWkstlQ4A6iXDKxRX1oJzc13Gys2AhQj54AAUi8QeFOjinln4_0l_VBpgIiI2GO3tE3Ft27z2CLT8R0oow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:X1SQaLY4e_vLBClXfDWYbxGsFLnyxlfjErkyy0FpxWfnFfWhPikC0g>
    <xmx:X1SQaK1f1PXCpvr2Uc7V1uOaK1-QRQgDRGOd0nbYAH_r8fhBFhglsA>
    <xmx:X1SQaOom5XvRBcGdSjqq6hMuukc8AyyLAIj1nSCDmaZ9blnF0XAwpg>
    <xmx:X1SQaJO0C-UeHgsMnhmRkCvfWXn0YRNFLVY-LxLNgor_U1XL_vz0Fg>
    <xmx:X1SQaLd2m6iaEuPv9fXOX2Gfwwc7PNVT-KN9fk9kB3KBQpIMy7qDfdL5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 02:34:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c9f2184 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 06:34:05 +0000 (UTC)
Date: Mon, 4 Aug 2025 08:34:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
Message-ID: <aJBUWveulX7HKAMY@pks.im>
References: <20250716133206.1787549-1-toon@iotcl.com>
 <20250730175510.987383-2-toon@iotcl.com>
 <aIsQWcHf82ipHoWf@pks.im>
 <87ms8jui3p.fsf@iotcl.com>
 <xmqq34abm0iy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34abm0iy.fsf@gitster.g>

On Fri, Aug 01, 2025 at 10:09:41AM -0700, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
> 
> >>> +-t::
> >>
> >> -t, --tree-in-recursive::
> >
> > Sure!
> 
> Clarify *what* you do to trees in recursive by giving a verb, e.g.
> 
>     --show-trees-in-recursive

Ah, that's even better indeed! One question that this raises is whether
this option then should continue to imply `--recursive`. I think it
rather shouldn't with this new wording, but don't feel overly strong
about it.

Patrick
