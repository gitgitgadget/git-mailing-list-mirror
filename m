Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD982BD11
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764974883; cv=none; b=sANIIxH2vr+RAKPzkekT/NcmM7ymFawThXEndQd32dtIP7ohxMw/K+mH5hxI2KzdaRUJH23r+8TTpwsjvSYBTZWTF5MQ8fziyk4k2ddg7xUG1+84oLSJqy51W3oSuenQv1SBHpHdQQ0ek1gvbw1R/kJsPMnRH/5StStOrH2OI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764974883; c=relaxed/simple;
	bh=+oIcbrCq9bSmjyw/k/6yc4FOCL0IRSfKI+7PnK1wAv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i+a0Z4++TGNy6gFu3HYfLrhI8AuSRlIxPj8sowfcR84vWQNnC7+sjcE82eG44/Gqj9HKLUtRyRlj47D6LknSlDnHbwRtsRihsUD0CnmfQIgZQFhJq+7O0fsvTx3CbA25bv+1eNKEEpGJF2u8l9bF3hFtmRC1/J5fz3IGQKboLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oyvwd/JW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cmfbdj70; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oyvwd/JW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cmfbdj70"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35E817A00E4;
	Fri,  5 Dec 2025 17:47:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 05 Dec 2025 17:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764974879; x=1765061279; bh=pLv5fHlwNV
	53x3Po2VmNbfvvExp0loOhvZMqMF/wX48=; b=Oyvwd/JWc9RIpNWYetWaM7J4Ge
	j+zw1IyIdaZhDBW7ge/Pq1EceBtMoXA0tDcIvM8cYhMbyMoSYEstao8q+eMFZSRv
	Sk1ovqQESjCfjh94aepaJRFGu2fDjjz56KnI61zW6ANiS1yrvGy+3/xNYckZHzN6
	lv04x3w0b2eXtfM+FbMX/RJNArdU9S6EPxpmYA+bpz/4dCbMl9v1fZHYG+hFmGxl
	cezq4b+cMdMl+T2w7J3/KgvyTXNYuG77KXi1D69FHkx6c3JxSd2Wbi+8nsF73q5J
	xm2ucucv/7//B55acHHp1DaFiM9X4aRXR/ezRd7nVxX/EK0k5yZZMUtZSsdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764974879; x=1765061279; bh=pLv5fHlwNV53x3Po2VmNbfvvExp0loOhvZM
	qMF/wX48=; b=Cmfbdj70PqszChHRn4yeUUq2HE0ubZYA0MR8z3sKxV4hR8pef+I
	FDoI9JdrN0qO6x6/M6juV0tcL8dhqD7ks0EWIYjZ02AUgFCtjbpzdwesz6Voge0X
	fm7W3Wvpurnt6qjrGUOnb+KRrgVei2FHpfnSMAW4werakOuhj5estO8ol24UgR1c
	GtihoMADVq75Bu56s7MteHn0jbI7pfYVA9Vhs0IrMl+TTjetcReJeZg7gCtlpO2V
	nYlRsGumz04P8ACQFhdKB3yg5Rd/Qg+dcDVDgoijqptfCiGDLNPsjWCX8EDpU9Mu
	LHLx4BWw5OdAakNvlzgUSM8afK6uQhMlyVg==
X-ME-Sender: <xms:HmEzaSpz5DHzUiOr5jo2siwfyyPk9sXCE07msMN-YpuR3DVsxmATGw>
    <xme:HmEzaXBD32bMAsbs70YbLYIdRAvDv9qrWNxQhd9vniSQn4JlCTHPfamXOBEj4sQmh
    psjwRWPG9nXZ7eZBA_sYzFgDVTzJ4P7pI03KE0DfuudsDF9P7VyqQ>
X-ME-Received: <xmr:HmEzaTd41isyVuSGjkeO_GFmxPIiI7R4I-XUlYgw8k4RNUVno5rvBSNPi7N_lPBSZMVGXZK-p6RdqUsqCcWYsvtlNU9r5ljK5t6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrg
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprggrrhhonh
    esshgthhhrrggsrdgtohhmpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:HmEzafs4dETxizRHH8RI8axqxOli_qbKWS5luo_DNSAAFnOPWvgohA>
    <xmx:HmEzaajP-1oi5SIIaoOoI_b5uYBKrtoFgdAE9iKTimvvOWE5Ta2Cvg>
    <xmx:HmEzaXumUiYlw3WAVAhegnguHm9-YdBj4m7myqgpwIBkVOwEyxtoCQ>
    <xmx:HmEzaV9HFTAksoZyV7xidyxxj-ywkiI_DUWmT1loHfXFG4mLYlMi2A>
    <xmx:H2EzaTvkMP1Dyq3KhYzChuGUNhXFTMIsKEvFDHOqKbOEnQafHV68n1P1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 17:47:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Emily Shaffer
 <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Jeff King <peff@peff.net>,  Aaron Schrab
 <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,  Josh Steadmon
 <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH v5 4/7] submodule: add extension to encode gitdir paths
In-Reply-To: <87v7ikeng2.fsf@collabora.com> (Adrian Ratiu's message of "Fri,
	05 Dec 2025 21:30:21 +0200")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251119211030.2008441-1-adrian.ratiu@collabora.com>
	<20251119211030.2008441-5-adrian.ratiu@collabora.com>
	<aTLNwHpLUcy-WsZs@pks.im> <87v7ikeng2.fsf@collabora.com>
Date: Sat, 06 Dec 2025 07:47:56 +0900
Message-ID: <xmqqqzt87dgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

>> It feels somewhat fragile to me that we unconditionally handle these
>> cases and try to find old submodule directories. If the extension is
>> enabled I'd expect that the submodule configuration is the _only_ source
>> of truth.
>>
>> May I propose that we instead always error out in case the submodule
>> configuration does not exist? In the best case we'd then give the user a
>> nice error message that tells them how to run the migration manually.
>
> Junio told me to not do any kind of manual migration and just attempt
> new names until one works and then use it consistently.

Indeed, but I do not think that has much relevance to Patrick's
comment.  What I meant say was

 - With extension, we know that the repository will use the
   configuration item as the sole source of truth.  Unlike the "we
   now store submodule dirs to munged paths" design that we saw long
   ago, which would have required us to sometimes move the existing
   directories to match the munging scheme, we do not have to
   manually migrate the existing directories.  Instead, we can just
   record the pathnames they already use.

 - And with extension, when we add a new submodule, we would need to
   give them an entry in the configuration that does not conflict
   with those used by the existing submodules.  As Patrick mentions,
   this name does not have to be done with any reversible mapping,
   and third-party software and Git reimplementations can always
   refer to the configuration to learn the path without knowing how
   the path is chosen themselves.

 - The above two would ensure that the configuration would always
   exist once a submodule enters our system (and "git submodule init"
   is done to cause its gitdir created).

So, unless I am missing some corner case that still exists while
bootstrapping a new style repository with extension, Patrick's
"error when configuration is missing" sounds quite sensible to me.

I am officially still on vacation, so I'd stop here for now ;-).
