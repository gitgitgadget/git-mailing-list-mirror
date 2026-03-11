Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DA13D539
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261109; cv=none; b=siTBIBIbNb6yVli8k5LzyOr8IdAm9UL23KbuwHuUQN3cd3sZ9/o1vfiwnQXu18qg+lJ+jaJBbAfr2GnZu2j03KfcamirAxNODMBomMhZTYVDXe5LTvZNHS0Zv68T+RuTIjXxDXF3/R+MFvc5LvrnIvN9GABzSxLs5stzZBGWMkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261109; c=relaxed/simple;
	bh=97llovE94lV1On3QK/MSQuTh8bWP99E1DT5daq4WOcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WDdsGaQ4ioL6t8DtAXlRUacBEul+GUA/7KWU9TVlnbIZL2tWnog5QV04Iu4AhnkdsHGTfYnWBH480oy/e1yHEmHWrd2/EILsxf0MfRI9AFTEFNZXBEUi6yoZajuci24JyrFztt2xjdnNAaZXw5hakAtwRXvdFoCzOdnTqRIHros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DQpAZaJU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zzbs27ZB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DQpAZaJU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zzbs27ZB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CD8541D001AD;
	Wed, 11 Mar 2026 16:31:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 16:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773261106; x=1773347506; bh=WzyppcLUX1
	DPrPwglJbW5SBiN6gLi1pp+x8Ugmp37mY=; b=DQpAZaJULJQiOuHrIfQxoNtukn
	qe7o2EkCiEvX8CbsIEuHYF48dsN/8C+aljuN20TYWooERXILN4n211+xsOKCVobh
	WJsg6qglVvmfT1krYgLe2F9mIfY3mgpZzKuNC739pz8lyVYkf/WE3OvyrKHJBbuu
	UhP9J1roI3tRXXurqlCp8df1GRa6TEarlfxOJyRbpgLEMbn6mLrYC/2nrmwP2AhU
	VCrpq3hZr4bHpAP+5/q4AlSjui7uKJEXuFdpvy94u4az6DbjMB8ryi1VpNGk66QN
	Okz1BnuIpDpZDkCj7jdQFNy6NxA1ApwQOttO9fEwDQFSSPNQYjS9jqsoS0hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773261106; x=1773347506; bh=WzyppcLUX1DPrPwglJbW5SBiN6gLi1pp+x8
	Ugmp37mY=; b=zzbs27ZBP587Mj5H1J8aZwFuLRO+UNoLD1uE+jQar3g7vtK5fgx
	sSwXCjcoq6b5bDV82ntzLqUcbyR6Pd4XtuipS2J1dq9kJonNT3H0eju1FWAIGnk8
	okkpl3u+4lyb9iI6dADf+3J9ZjjEMv4nWigWVoKTNfNMWVmOQhsDa9QbqQGz4Ncp
	52xwdksIYxAiMsdT7ms15mM2A+AofhEXmzfHbQqlfcbAOQsRKN0koxDEhvxK8CCB
	hsd9w1p06eOQdqwjFBS7+aSqdsUvsvrabtI4td+l/Qw64Zv0OwaVtjLNxVbi1TWU
	FXfx7bzWqjtxDNS3zchehX9Un5hXmMhbehg==
X-ME-Sender: <xms:MtGxaWWDGRM0a-7dH8WZARaqk_VB5gRy99Qp9XgTKZCXAW-je3Lycg>
    <xme:MtGxaVKQuffl8N3l9plYvpXWtBTzQVZLABBCRakr9S-kAldyZ9PHhm-2lFNlqY-ep
    V2as0d0O-iyS8qcJekP31PPvYkcz16cc3Ig4NKzVzzNCgFZ_n9-pOM>
X-ME-Received: <xmr:MtGxaeDzYeCT4vYPZXh1ZRAAFkU9cQa2MKTUpXuGGj0Yi5An6HU1PminuZTgAgNrZEn22HSY0_2iRcCGMfG5dJQfMH2UQLkfDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgrsghlohhoshgrsggrthgvrhhrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgef
    udesghhmrghilhdrtghomhdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfeehud
    elsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:MtGxadfL3KrIFlHISZy9h4OfcXTPIoXRFEsbX61jEvtTe-7CFrHy1A>
    <xmx:MtGxaV0k2vwEfHVqgYliidmvj2aTMUf4_dIdS9URuzHOOYARUby_pQ>
    <xmx:MtGxaci_6uKCXpzSnyHl6T05cw7jggiHuzlv7cEEhVqKaVFNBCu5rg>
    <xmx:MtGxaWlUqItgxy1C1oCK2OBWqGDCgc1CbQ157uk3oFgG8g6JN7qPuA>
    <xmx:MtGxadQXGlCeSqVHkP4z9RkqQmduj41PlaHT7J6_ELr_cy_T7H5k2HB7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 16:31:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  karthik nayak
 <karthik.188@gmail.com>,  jltobler@gmail.com,  Ayush Chandekar
 <ayu.chandekar@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [GSoC PATCH v3] t9200: replace test -f/-d with modern path helpers
In-Reply-To: <CAN5EUNSmZmdnDzpAKAh8fZRex3--tnKaWZZSQ+o5WATc6sLy_Q@mail.gmail.com>
	(Pablo's message of "Wed, 11 Mar 2026 20:49:54 +0100")
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
	<20260309230134.758107-1-pabloosabaterr@gmail.com>
	<xmqqwlzip82b.fsf@gitster.g>
	<CAN5EUNRZQP6ATE87AeZiJx-OTnNn_4NxhW4zyH6AspGUfnV7TA@mail.gmail.com>
	<xmqqbjgunofq.fsf@gitster.g>
	<CAN5EUNSmZmdnDzpAKAh8fZRex3--tnKaWZZSQ+o5WATc6sLy_Q@mail.gmail.com>
Date: Wed, 11 Mar 2026 13:31:44 -0700
Message-ID: <xmqqtsumm7kf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo <pabloosabaterr@gmail.com> writes:

>> Yeah, but if we are going to do so eventually, it would be pointless
>> to use the path helper in that "set up CVS environment and make sure
>> we got a sensible directory structure" check, no?  Upon failure, we
>> will hit test_done that loudly says that their CVS installation is
>> not working as we expect.
>
> Yeah, the new patch will change it back to test -d because it ends up
> in a if condition instead of an assertion.
> Would you prefer to drop that hunk from my v3 or should I send a v4 ?

Yup, let me mark the "cvs setup failure" one ready for 'next'.  The
other hunk that updates "test -[efd]" can become a separate patch.

Thanks.
