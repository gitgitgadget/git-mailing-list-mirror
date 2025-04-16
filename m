Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AC481E
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762197; cv=none; b=Mno4rUmwg1NZ2N2siZPc33u2u3hEa8Rb/UPnrNrw8IrtYBpW9K3va2V2gbKtu5TKcSauL+2lnWLL2kfP8SnlGQtQubCkpvI25fEsQRA8YBpf7sjLzWxKB5tbmEgrU3eF9s3JZ/mOWsqeAowOeKw04pcdZzx+bx190il8SihJbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762197; c=relaxed/simple;
	bh=x+0Qp3YuISZXHA2h42u7QsVOXxnKvycSh2bLM0IWvdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Apb1CGWhFid1KGWhaLMutc9PqCSexdaz2XV2svq6eyystMi/jl2HMaBUGdb+YGt9HXKCOkFZRQFP44qRAqQeocTBz0daAPyVxOvFMA2EjqcpPWt7kY7tL6SlHo0UK3nzvwmUSh149SiDaRRJfaHlbHqy+W8ZWHHbRV/HDKfCM6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MLaT2uQD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZScSc8mS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MLaT2uQD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZScSc8mS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C3A411401DF;
	Tue, 15 Apr 2025 20:09:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Apr 2025 20:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744762194; x=1744848594; bh=D9eJS+yNnE
	XoYTb1nIL+tPxnOcbVqrtfN0LDQFpqEmA=; b=MLaT2uQDiASa18L/P/qpHB4rhX
	Aajz49xZIQ3yUxbdP+ItslP40iHVMIBHpyrvwdHGaEV2H/n6BpYNm8V9RSLRwavs
	AB8H68HC03qm7RinWPaZG+V+ZZRlnajbPp6kzHLY826qE1m01SQlPv6RU0xJuxkr
	J0VUEiucD5tBfATrKYMQr8vqyD4j3IhMQ0RzQLdAPT/GUNoNuOYuECm3Kf94j19H
	JFY05Ok5/a7wIElK1zMRH7Bgnyba7k+liWFjHayNmWfoZQlVjQzM2/iRx7VcnWHH
	N0h0iW9O54kCaoK9w8E4lJhQZsSQ3WI6Y8oDihMRaQfLHqNuRcg4wLALTQmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744762194; x=1744848594; bh=D9eJS+yNnEXoYTb1nIL+tPxnOcbVqrtfN0L
	DQFpqEmA=; b=ZScSc8mSY8qA4GJ7VHvRTNqtYhPQBGTEfH+5S5pL18xSQs6A5b8
	EGZPIn+bBcDmhELwRH36HfnZrbUf5Yt4cR8SqS2p0oKCGOb1eUh7CLu13JU/zlm8
	H0ZLIr8x1x9FrbEmdTgZdQyBA4E7gyfm/afIwdUN8cmrO57TG4AFZgJv/ct9/Tjl
	zMfxxrVNhl79Rt6gIh6/gj2VGEWFW8aC2AxOfcnZrpAb020g1I2ShkHLe695frzK
	ZhBkulU4QV3t5hB09TWSzS37WMbfhSvLzkmUTsy8Fn00os4trrmDu1eXe1+AwGKw
	/2xh4NHUhvBCoj6Z/UIe+Gw+D+rW9pSdOqQ==
X-ME-Sender: <xms:UfX-Z2cCQuBQG_pGHvfb7hdSKljXkqgWtNjZq78D2-n6fDzesSs18g>
    <xme:UfX-ZwOsLZty2IgTlmf36nU8twK6BQ6iYSmWqdBn5FplSVyM-v-y9EdDzEyT_Sdaf
    YaLdEW7eMK6jdBd2A>
X-ME-Received: <xmr:UfX-Z3hHIT_B24bmdp4LiW1fFXpy31lP2xlRNEQkErdAuoe9WgBPJ1RKE8Q1mV0kwlY_Gl5bU1o_JS21BfGzdPZ6nlysjfZCdwdr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgvmhhosegsuh
    gvnhiilhhirdguvghvpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphht
    thhopehnihgtohestghrhihpthhonhgvtghtohhrrdgtohhmpdhrtghpthhtohepmhgrrh
    htihhnvhhonhiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghkvghmphhinhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepshgtohhtthesghhithgsuhhtlhgvrhdrtghomhdprhgtphhtthho
    pehphhhilhhiphhmvghtiihgvghrsegslhhuvgifihhnrdgthhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UvX-Zz-q5P6Zo3WQ3srlaRfjPkFLSavR0Pjtky6l-iOGK3zGJ9WFrA>
    <xmx:UvX-ZyvbqMitcolFnbSIcf79Ed-InENces43mie0V1EQTSkWjW_9SQ>
    <xmx:UvX-Z6GPWPuc4UbGMt-2zPZxk-_3g8MqJcsh7P_KMc8UDAONaAVTyA>
    <xmx:UvX-ZxNfyQ6NiwwYoNPz1VoSOoxmSByY2PlPj7TlaMeBUFE1r-tXqQ>
    <xmx:UvX-Z4X87lUub-OGCy3QQEYAzfSAzXLbqK24K7Kf2r4kKZ2piaGZ4cqw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 20:09:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Remo Senekowitsch" <remo@buenzli.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>,  "Nico Williams"
 <nico@cryptonector.com>,  "Martin von Zweigbergk" <martinvonz@google.com>,
  "Git Mailing List" <git@vger.kernel.org>,  "Edwin Kempin"
 <ekempin@google.com>,  "Scott Chacon" <scott@gitbutler.com>,
  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <D97KGN6TV8F7.1KKO8GYI65W59@buenzli.dev> (Remo Senekowitsch's
	message of "Wed, 16 Apr 2025 00:30:22 +0200")
References: <20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
	<20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
	<xmqqv7rdqkla.fsf@gitster.g> <Z/a+AVopz+HLa1eL@ubby>
	<20250410134426.GB13132@mit.edu> <xmqqy0w8ng5r.fsf@gitster.g>
	<20250411154839.GC648081@mit.edu> <xmqqfriemw38.fsf@gitster.g>
	<20250412231318.GG13132@mit.edu> <xmqq8qo2srn5.fsf@gitster.g>
	<D97KGN6TV8F7.1KKO8GYI65W59@buenzli.dev>
Date: Tue, 15 Apr 2025 17:09:52 -0700
Message-ID: <xmqqy0w1j7an.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Remo Senekowitsch" <remo@buenzli.dev> writes:

> Doesn't a patch set ID suffer from the same kind of ambiguity the
> change-id supposedly does? Patch sets can be split and merged, a commit
> from one patch set can be cherry-picked into another. What patch set ID

Correct.

I still prefer it over the change IDs between these two incomplete
mechanisms.  To resolve the ambiguity, you'd probably go all the way
to an approach like "in addition to the usual parent-child
relationship, we record the change evolution relationship so that
there is a record on each commit what 'predecessor commit(s)' it was
derived from".
