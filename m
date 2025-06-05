Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B361E5B64
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140904; cv=none; b=EX/DNeUd5AgpPuThHpOj0BlwTz9v3ccphO61vjernTpo59mXBd3n70sf/+USZtwlYDJ0rd3qPb1l16pF3ZmSL5E681XxRpRbTfKgSyV5jXak1bRb9A82dzw7Z4uxVRMvceNpLP+5zaZXXVnhdE/IgE/JndEwqaAVCQL2kaRheOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140904; c=relaxed/simple;
	bh=1OIh+WDTzOtuEIO64MusOPL+aGTyUDHJoBzGTPR/My4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RvUHcdncJPRBcFnAuwVmVS3KQVjzdB4R/V2+bOJ0y4SBGLlB7r0QeRaPVg0Q5aue8JjajWqSuanR7dTgwnULgckw2yUZlFQymIlL/1AsYdjKKj8LAVqV14Yz6dZvD8cljA6D3uHBLGpyWmaTMOe6duIoy1CqSfc95dcxB/tXfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FuoKhzIJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EaEeKZSR; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FuoKhzIJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EaEeKZSR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C9CF2540110;
	Thu,  5 Jun 2025 12:28:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Jun 2025 12:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749140900; x=1749227300; bh=BCrCGwN1Su
	HzxSXHrH1tFMyuLQq/1BHHTuBZfyccCgM=; b=FuoKhzIJUFnsS5UNQ4fre3A3Ap
	/IDtsw65jdm7/DGWMM04icNhZOrNmTIxZF1NhFsbuBEq5hcUdnRHkSp2zVz4aF8N
	Jbl64T23exIxgJu7+8DimFmUJV+XwXZqOhcqk0YI388+dWCcB8ZkeSinQIQKCqU9
	l7JTgVOEm/f4OJdH+pQ6LSTqqwzzborrepXK7B1JZ1/1n+gRwhX+k4rEwigA4POl
	U9yhIEyOF+Ud8JhoMuLFYCCxRWwsIei+4YdSKLu4Cr2BbzRfQr+JKNVYPmyr/o8J
	U+LrddMmeIOEJSjjjg0dbMdKScWRUYC6L/SSkT8ZaLfVTcAD0Rl7Gfg048IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749140900; x=1749227300; bh=BCrCGwN1SuHzxSXHrH1tFMyuLQq/1BHHTuB
	ZfyccCgM=; b=EaEeKZSR78UIPO+4w8/5nKCdmIqc1/lRusLka09zYotvaaNIJZF
	XoYm6bR/RIAjgbyYw8RZiozPGNC4EnZn/sooWI9N9NpSECYkB5RS4x3haqqVm8ed
	5v/r1uqcOHCw/pkZIFKBnrI0yypJD22VlDgwZEs0K2hbkJ0Ao2Y2yeYy+ADgLUVp
	3iut/9uJdqNezweBsXxtIrBB+AbD5hwh0ZjF+9bPRcvwlwZ4TqiKt+gSHY/UgaE5
	Ox2sMcAKO9Xkd7z1MG9AEtLHBBHwX+idOHCye2ORn/gB4cNVHDD9c8XsZ6PSCUdH
	HnHcL21fRXleiHC8vJWwrb3oUDvYlNCXPNQ==
X-ME-Sender: <xms:o8VBaLGJBW7k_UR98lyEh6iQQ7IorIsOH4owRD9YbeLh_Iux6eIyQA>
    <xme:o8VBaIXCMofniJXYRLe3IqbCU7bpk4R54Th_qR0IgOJ2jNWNeMhZvDFnPKfnb9EVD
    CT4ScP6JrxEr30DCg>
X-ME-Received: <xmr:o8VBaNKoXMv3tXwIdWuOSWcCUv7nAqhIg14HGiqJh_OHqSMQO65vj7K0KcMCXQHzetjVkrnneaQH_4akAAjnjjGPxmkd_fPFtr2y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepiihihigrohes
    ughishhrohhothdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:o8VBaJH5m9ihzl1-GYwpiTdRnnJtPzLH4p1RjIpN-VxH3etC27Pkaw>
    <xmx:pMVBaBVNkWhVAWr6mAvKva18kPEYjPPaE-Yy6s2J1JoxGUCgDGmOBw>
    <xmx:pMVBaENMYddWnLTl2z5OReS8-mJkVR5FfQw5ZeIfUcU0Dpu8deUn7g>
    <xmx:pMVBaA08U_mnoIznn2LRXFAbBMqp2BGAWn62jPjvUrymvm-nXtpoXw>
    <xmx:pMVBaOQ--OhOfF8moYxtyg9iSvROKO4oQWMjRhm8XM6p3DaARtCBueYH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 12:28:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Aditya Garg <gargaditya08@live.com>,  git@vger.kernel.org,  Eric
 Sunshine <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  "brian m
 . carlson" <sandals@crustytoothpaste.net>,  Ben Knoble
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v12 02/10] imap-send: add support for OAuth2.0
 authentication
In-Reply-To: <20250605080002.GA2998537@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Jun 2025 04:00:02 -0400")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D1C148578224A02B9773B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250605080002.GA2998537@coredump.intra.peff.net>
Date: Thu, 05 Jun 2025 09:28:18 -0700
Message-ID: <xmqq34ce9mql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Jun 02, 2025 at 04:29:33PM +0530, Aditya Garg wrote:
>
>> @@ -1405,7 +1558,11 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
>>  
>>  	server_fill_credential(srvc, cred);
>>  	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
>> -	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>> +
>> +	if (!srvc->auth_method ||
>> +	    strcmp(srvc->auth_method, "XOAUTH2") ||
>> +	    strcmp(srvc->auth_method, "OAUTHBEARER"))
>> +		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>
> Coverity complains that this "if" will always be true, since one of the
> strcmp() calls must return non-zero (srvc->auth_method cannot match both
> strings!).
>
> I'm not sure what the logic is supposed to be here. If we are matching
> either string, it should be !strcmp() for both. If we want to match
> neither, then it should be &&, not ||.

"If XOAUTH2 or OAUTHBEARER, use the password" sounds somewhat
strange (unless the bearer token is stored in .pass and passed as if
it is a password).

"Unless XOAUTH2 or OAUTHBEARER, use the password" sounds even more
strange.  What about other methods that are not a plain simple
password authentication?  Will we remember extending this code when
we add yet another one to exclude it like XOAUTH2 and OAUTHBEARER
are excluded with this patch?

