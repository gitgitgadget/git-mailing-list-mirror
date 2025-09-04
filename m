Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C32EBDF9
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757026019; cv=none; b=WNt5/XRsGKA+6s6gLgwk53jM1TQWiD2kVojs8Y/CEwLIcuSxnGHjmxErDyxaupVoxT2G1OiXCvg/rgZTCa6OJoptM/yzKN7OkRlkGB0ctWA1JqYVxhKY/gFvQirpBIDJtyGGeJEPY5dVwAcyWG/mMNw2jKeNEdRZFdJK88XDeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757026019; c=relaxed/simple;
	bh=6gNI2d7sRp6Gcu4dLazeh4LhIsVm5i9FtqONjlyY0KQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ugnzs8WVyjitnGFaB+ereYiCOcZ3id+OzG15r+0x1Tf9N95M6VVG4nxKPsEO6odfhx0j14lngSpARJWFtvdJ3HtWF3LBYC+osK+Hv6zlxoA6oJj1Nu0BO3iKZiFRChktAc/LpXRGMhSIzYm6aFSDcpWnY/joXAPNkP/fqd2u728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sMiWQC0e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y1aTx11E; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sMiWQC0e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y1aTx11E"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A5B77A0602;
	Thu,  4 Sep 2025 18:46:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 04 Sep 2025 18:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757026016; x=1757112416; bh=HMU5NyfVs2
	eiTZmc8sCwQxop583gmcmMyN++LfDsBvM=; b=sMiWQC0e8QFAgiv1woxAokHIBS
	+vYhKa023dxf9iOV7nI17dGJDcMFkNxudORibnDrNTDOIEmZJyWHgG2v5AmDytVD
	D6OWiy5wMftoyOcozq2rfPy6af6o7KFc3nHbjKE5GdXjUoKlWswoMNJisM7AsYZZ
	8R8FND0wO4cv6RTtpv42AcMXWi/C5kQiHf+27JbzyqWTCfZbYz3KHwNtKfUDL83B
	RmACsDFiHX4O9fCSt97Gi75V1jQwaCu4pw2+KGfWTFLtz2ICj7TG6Ipgp1yeJWsJ
	QYhpi6t6RE92aofnn/MrjDdPif9+kg87X5i+B58AO3HUBe4digTlrXbxkTkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757026016; x=1757112416; bh=HMU5NyfVs2eiTZmc8sCwQxop583gmcmMyN+
	+LfDsBvM=; b=Y1aTx11EBk2H2LbBj4uSl/jcmWelTbJz16tlV3haH6W7TWGNEdc
	DYP9Pp/5Ztt7BiVimlpUTKov0oO/1hkru9f2FBT01agi52shGJ0dfB6Mb4ELXeKt
	Qu7MxVjft5Al+M53Z0L1qgWelULj4EfRrnM9G1WTaLc3zxRxah/dAZv48PKcoReG
	DPNYbkdWHDfItOcSFIobmf/bZOZRVByFmdNVt6nM3tugYScer0CQBH/FkCAgxhAo
	kJagznq4FJPl43tibNaphzeJRx61JFHE+wD+y7DydMwJrEQgwTKGTvpS6f4LEw5x
	6YRWYa/rxe25stVjUFFT6fZLRId49xyeCTw==
X-ME-Sender: <xms:3xa6aO5Uy_3og2MQIjkNEVxJVebwN_oIhzPJ5L_fvxfo5n3ik87qdw>
    <xme:3xa6aIhtLM4Izq_xgklqVUEp7mzutXjL0msSpwQSqRwyaxjUlnng4Qk9E2-fMMAzx
    Lc1RNS36CJlzZ93Kw>
X-ME-Received: <xmr:3xa6aImiRPNGjFlvkkIUYCt566FZSNFdkuFppesL8ifcfmbQLPMcAwuBGwKrtoEZBoCRPURRdXvSL5OvgNxuZ4bB7DLlEcrNT4YvNoY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnthgrtghtsehhrggtkh
    htihhvihhsrdhmvgdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoheptgholhhlih
    hnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3xa6aPtUN_08R2LpLOTsC2mPz-xm8Xkb4hE64KCgeVRj7v9EvUhECw>
    <xmx:3xa6aGAQADyh4R-vgjp89f1ovHuij1a5kRQxZ9JLMC4q56u7SRgqBg>
    <xmx:3xa6aMXAjgfVm63C3kkAjUqyNrRKsPEnYcGdURjPo6nDbsAyC-E47w>
    <xmx:3xa6aPFPG-TxJ8t2OPPInR0ZOuTW7S1FUCctHk9tWSN9vBGSFw7ttA>
    <xmx:4Ba6aKrqRGOWmPNFjxTP3TqBa2Ktom58zlon5qg2_4V8ntGMzuIuqACc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 18:46:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "Haelwenn
 (lanodan) Monnier" <contact@hacktivis.me>,  Ben Knoble
 <ben.knoble@gmail.com>,  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC 1/3] meson: add infrastructure to build internal
 Rust library
In-Reply-To: <aLoNc5S6PVW8jLu5@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 4 Sep 2025 22:06:43 +0000")
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
	<20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
	<aLoNc5S6PVW8jLu5@fruit.crustytoothpaste.net>
Date: Thu, 04 Sep 2025 15:46:53 -0700
Message-ID: <xmqqa5397s4i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't see any changes in this series that wire up the Makefile to do
> the same thing.  Lots of people use the Makefile, or things based on the
> Makefile like the autotools, so we'll want to make sure this
> autodetection works there.  For instance, I build with the Makefile, we
> build with it at work, and Debian builds only with the Makefile.

Yeah, that is a bit disappointing, but I was not surprised, as that
is what the cover letter promised to give us ;-)

> We also probably need to test this configuration in CI as well.
>
>> diff --git a/meson.build b/meson.build
>> index e8ec0eca165..1c0e98bbc14 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1702,8 +1702,21 @@ version_def_h = custom_target(
>>  )
>>  libgit_sources += version_def_h
>>  
>> +libgit_libraries = [ ]
>> +
>> +if meson.version().version_compare('>=1.9.0')
>
> I think we need a different approach.  Debian 13, which was just
> released, only supports meson 1.7.0, and you have to use testing or
> unstable to get 1.9.0.  There are no versions of Ubuntu, released or
> not, that support meson 1.9.0.
>
> If we require this version, practically nobody is going to actually test
> this case.
>
> Our platform support policy implies that we should be requiring nothing
> greater than meson 0.56.2, which is available in Debian 11 and has LTS
> support until 2026-08-31.  Ubuntu 22.04 offers 0.61.2.

Thanks for reminding all of us.
