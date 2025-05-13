Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB45F1AF0CE
	for <git@vger.kernel.org>; Tue, 13 May 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155578; cv=none; b=F7vWjOgqr5tDWEsdPqEfUuoDX1wU4fKDfbhGL08tXZfuZI4jnnQRuUQGQv5SJDJzyQt2inNNYo8j7JTMWf+mit5qv3hJG+Xu/x8geuNCiFaGbnxYDyXtpT1a9vCb4BwpJTYRylaqsv1b5IkSaMpypOuOb/yyItQlkM3rZD1qmgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155578; c=relaxed/simple;
	bh=IC4XRZDcDRklh3yneafizqYeUWp5Sf4VSynrQZ2hIQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BYDVEijOwCHcS9ImfiL8ruC/TxV6ZPFDvJ+2npPCKlTTYA6VgijwxZ+gFzmv3143ikCiaCPYc/cmfaVrc1oBCgMIIiVYC6tBveX1MpsSY63NiQyGuoaKDediC/Bly0fIh5pbH/6UA+vNGx//aX+Z2CtTupNo8Dq5lQmSEu+CdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PtzyllHb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nMUWIKIY; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PtzyllHb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nMUWIKIY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A2A452540128;
	Tue, 13 May 2025 12:59:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 13 May 2025 12:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747155575; x=1747241975; bh=oCvMsfWax7
	zZuZSpvN2kTfn0VackDjsCGWilGnaWexs=; b=PtzyllHbk2d8ueGqHkOGl+eTcF
	jV8XGwFtAJrENOlQRQmT6tu8la3FhiT/Exjwj4nogl7tl7EtHpdcGNVbVbZlusdL
	speDcFSlObed68tpxQZ+lkO9PrKGzLTn6e5I1eykBH46tMMdzoSOk1gWsNVQQmJi
	BP7bvYvff23mipmHrHDx9cDuExfJU48Rg8jVCx/g3YsU4Tdn2A2O0nkxF+awUfFB
	qu+mhTmuvscGPjTsnT9Fx8hLEALqPLkVp1xKA4Bd0CKuDoisHTfTbbQa68SBhtmN
	yvq9BGGM8puqlcj9CUdsBxyw+ndlVCh+EpPLAxEm5fSnb/c7ISAQwJ4FRUvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747155575; x=1747241975; bh=oCvMsfWax7zZuZSpvN2kTfn0VackDjsCGWi
	lGnaWexs=; b=nMUWIKIYClRtZjOvZ96p99k2mIBguB4qCsf6BGptbSUZjxeg9yW
	A80yDpqKZdVrHVDppFvl9gDZhrd8Jarvug76dPHD2O9eDpcpzRM4Oofl3ukdGSZy
	tPCFbp6BCKuLDfQgHjfWzcZu0rEWzi8pEL3JkjR+WrT/D5Kkw7CKmfE8Mns3NKYO
	dsavsuhsX7Xd69zyH5DL5QPiwxMYfs2ZCZ2iSO9B8lQaxIEznqxf4ZbTRHdJAXB8
	lmjFV+cI6MphlPZQSCTGP2xzs1RWCsux8O4xdxtdZSR0I0RI3A5psdnqKRRUj8aE
	Px+vmXGJJqsyju1zG5m6eLiNY6qqaKnEFSg==
X-ME-Sender: <xms:d3ojaO_63l6voTvvXErPR8rXGw3nqsrrt2Pv2yKPEGqL-F6MpPlyzA>
    <xme:d3ojaOutrZg2R51bxdPuzfBXeUwFqwG_zNa7Y2pe4VDIZR-U2IKbliZEvWbVd0ALO
    gRiReHnAf-MDqiyAQ>
X-ME-Received: <xmr:d3ojaECHOCLXEb2Bamxm9S4spKSP3SvMX6x_xIa6zKse86GRuTbIF7KPfdtw2xiFlkzju5dJlQlel7Ddt_wNMYlyHmnOXKNNETqOWEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheprghrnhho
    uhgurdgsvghrvghnughsvghnsehsohhprhgrshhtvghrihgrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:d3ojaGeCeM9OH0Mt7rhlcmGZxPHCbLava-fwcYG_e2msI6H5hL2JdQ>
    <xmx:d3ojaDPUr2CfWNRsDV3ly7DQVpW0sJ-fGsPVsEOcoVetEIIQt-rBeQ>
    <xmx:d3ojaAnIbX2c-wouhhNClkMBRqg6sANidD153tILFk-W2knhbPJUdw>
    <xmx:d3ojaFvTX7Jx0mk60nOfF0L5-u0nGQXjMh2YKkqYMJbEjTlwixScbg>
    <xmx:d3ojaFBrGHeuj5hZZpiU2oUWemg3BcqCioeyliJOq_BiueeS8JIW4mLr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 12:59:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Jeff King
 <peff@peff.net>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cleaning up "contrib/"
In-Reply-To: <aCMLgaWXr_gM8g3l@pks.im> (Patrick Steinhardt's message of "Tue,
	13 May 2025 11:06:09 +0200")
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
	<3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>
	<aBhZHA7av8bWH9Ac@pks.im> <xmqq5xieq3fs.fsf@gitster.g>
	<aBmg1_wlF2fuk96M@pks.im>
	<20250512135017.GC1191957@coredump.intra.peff.net>
	<aCKOqs52TDZDvAXJ@tapette.crustytoothpaste.net>
	<aCMLgaWXr_gM8g3l@pks.im>
Date: Tue, 13 May 2025 09:59:33 -0700
Message-ID: <xmqq8qn0h2fe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Yup. I think safe credential helpers should rather be moved into our
> official tree. This includes at least libsecret and osxkeychain.

Yes.  s|^contrib/|| should be sufficient for them.

> I'm not
> sure about the netrc one though -- it's unsafe by nature, and I'm not
> sure I would feel comfortable with shipping such a credential helper
> that is known-unsafe.

That depends.  It is a known-convenient helper that can often be
used in an unsafe way, but when used with GPG encrypted netrc files,
especially on a single user box that is reasonably secured, it is
unfair to call it known-unsafe, I would have to say.

Thanks.


