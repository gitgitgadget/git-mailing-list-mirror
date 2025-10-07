Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C52DF130
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856662; cv=none; b=kA2v8zneWxJxKilmsSrq6q1US5HKPx2sdpx9CHp9U9oVwOjpwwxyPBTT9klm6BJSJb00TTwO7l1TZ/IZZUVSn6fk7JyrYGKeENbNdGpUFYexJvS4re7Smlm5oLcoLPZ9nFbfdcac46kVQe6q7LQB2OLc8c/C8gCWzNDcdTgH8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856662; c=relaxed/simple;
	bh=6noyxQgBOZCyTog4bQansO9TB9udX0R8pParfv1Fi/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ddb1BUyd87BpjW7fKH6HLUbkqSa6f/41WS7RoHn2K3sJbWq1c7WAtLujy4H7mJz27Uhs1mB4pvT7lRNoTNh43RvZp8oh3uQ6+r+VCiGINLyNHzVrLlRcal+tVY26SWRo3W0BipPRWxGBEJ0Z7FEhSnuxh5pF++e+LZ5RDlsj2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZUb1VO4E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PlPBt2YP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZUb1VO4E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PlPBt2YP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88AD97A01D4;
	Tue,  7 Oct 2025 13:04:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 07 Oct 2025 13:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759856659; x=1759943059; bh=3XDh+pZwOG
	6B7NY86W6FLPaMxwzNyIQje3wyh1Igujo=; b=ZUb1VO4EGOIdOtvpmNrTuaAY4V
	WVurNZkrUi4BxT8VDttfcWJ8/d3hL7v9c8zd4kbUBIkraJpJS/RW9HBpD32sK/OF
	bvYV/CRwE1hTQX0qxhGTAa5uaWxB69Yzq1ENzkQpUeyJltx7oMUS3Y3HLoNsUgRQ
	mbY3B/eHzv9U2vq0JbOmYo5t2PDJ6c0bQMnJ0EjijlfJeRXEkUcghX6oG46f1clE
	aQZhsokfEseFWgXH7vMp3Ov8qXMR17XHwAIo+LVMNrqrjpO9+/Ukx6SlMZaQMPDL
	5ZE9tkRMbezJ36mEqoKZYH6+0wz13CuVz0afpzY7ONOkCyOe2+E33hhgoobg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759856659; x=1759943059; bh=3XDh+pZwOG6B7NY86W6FLPaMxwzNyIQje3w
	yh1Igujo=; b=PlPBt2YPMOjfloFb5+bAhAJBifxKBths5edrDkLIMqgVY08ytne
	K8a1yUC4gqbzC4Tdv81wa2WUJ5jbhIdxm/UfLAbtKet+eFV8CHYDMD6/LA1Hd3ad
	SOLc1+n4SfDtOUUSmW2Sm0D2EzuEeiOwov9XirLTIqkFMRrjoOA1DGa3GN0/eAUn
	z6IwmKpdklNxk7lWU5li8NpJpLpG36DGj5rEFEMD4l9pIgsAqI7ivpn2KYpAMGi7
	WHTojFTIIScaw8v4v9YSMBqKMJ2UqJ3YMWN3oPMCf8MEpaqgomJNhVNpPtuu7z3k
	GmNVZ1ypARpRAAMT/X3Tj6ksoM02Fp116tA==
X-ME-Sender: <xms:E0jlaPQK54qho3Ig084DyoBvXehI8N8fGCP3X1Dz9VnYiWwFIOv4Eg>
    <xme:E0jlaBNV0ZzNDQHqnLSl4hL_sqg-rnob_VZtrPJ0JMRGoop5xhdCtzy6sQzPp7G1N
    rHNMrYzE0khA_dxtO2gmYM1Xw7-hPXU057Gw1qjAz1wf91fLa5q>
X-ME-Received: <xmr:E0jlaEm79x8xAG_Rnf545fha79m8ti4ojVILXsGIpp4pvVUw-iOu5jmDmiJfAfyn6mKo-31nl_nw4Mxr8sBJ5PEoxAXEL1eMz5Ut>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhhorghhrdhpvghnughlvghtohhnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehthhhrrghnuhhrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhrohhsshgvrhdrmhhitghhrggvlhesghhmrghilh
    drtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:E0jlaLYjnHpo2gvkbXkGCyjJvnNnB_NOCM9uq0Z2bnW318d3vPms3Q>
    <xmx:E0jlaCTDA1cDwHr6bmlLvv6FZUwI_ige8cy73AELcGLL0hZDPpG4JQ>
    <xmx:E0jlaNXNzz4vwSrRBkoo6DCkHzgke7OtnMnDDGl2vCCnTpnyZHjC9Q>
    <xmx:E0jlaJaJFfx7Fh8iPruUBDYdoBGqZQv0CwNC5r2VjybR1GrOzyWOAw>
    <xmx:E0jlaO6MLr533zWWnpn3a-pSjQpehmMoex0N_LtytKudyHVeHZOjipeC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 13:04:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,  "D. Ben Knoble"
 <ben.knoble+github@gmail.com>,  git@vger.kernel.org,  "Noah Pendleton"
 <noah.pendleton@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>,  "Thranur
 Andul" <thranur@gmail.com>,  "Michael Grosser"
 <grosser.michael@gmail.com>,  "Eric Sunshine" <sunshine@sunshineco.com>,
  "Taylor Blau" <me@ttaylorr.com>,  "Matheus Tavares"
 <matheus.tavb@gmail.com>,  "Johannes Schindelin"
 <Johannes.Schindelin@gmx.de>,  "Calvin Wan" <calvinwan@google.com>,
  "brian m. carlson" <sandals@crustytoothpaste.net>,  Martin
 =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>
Subject: Re: [PATCH v2 2/3] config: values of pathname type can be prefixed
 with :(optional)
In-Reply-To: <18d9eef5-a1dc-4d9d-957b-ae630f0a2b12@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 07 Oct 2025 14:24:38 +0200")
References: <20250501214057.371711-1-gitster@pobox.com>
	<cover.1759094936.git.ben.knoble+github@gmail.com>
	<5c97f580a9e77c464bc6bf4ed9ea8546711c6637.1759094936.git.ben.knoble+github@gmail.com>
	<a687ec17-8ee4-428e-bae5-063716d59a08@gmail.com>
	<xmqqzfa3onxx.fsf@gitster.g> <xmqqsefvol7s.fsf@gitster.g>
	<xmqqms63ok7g.fsf@gitster.g>
	<18d9eef5-a1dc-4d9d-957b-ae630f0a2b12@app.fastmail.com>
Date: Tue, 07 Oct 2025 10:04:17 -0700
Message-ID: <xmqqzfa2k5im.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Oct 6, 2025, at 22:21, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> We'd probably need a preliminary clean-up patch to fix all of these
>>> in the vicinity.
>>
>> So, here is the preliminary clea-up step that should come before
>> [2/3]
>>
>> --- >8 ---
>> Subject: [PATCH] t7500: fix GIT_EDITOR shell snippet
>>
>> 2140b140 (commit: error out for missing commit message template,
>> 2011-02-25) defined
>>
>>     GIT_EDITOR="echo hello >\"\$1\""
>>
>> for thest two tests, with the intention that 'hello' would be
>
> s/thest/these/

Thanks.  Will modify locally.
