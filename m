Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC11C27
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865477; cv=none; b=Kh4x1zLiff/wPiS1EuHmTuAkrbJ2Q50mKvEAaJeOws+knJfbZTX8GWvZ89oI6ctW3dq40XhdOVHlK9xjeK8jkP/ZZN8FYsq51C9xdk+DmfpPK79sn3ZV4jUQ8oumGn9E2y8Q+a0L+Z+oSvPSEaq2yU+IrnbiTBJk041gVeZIvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865477; c=relaxed/simple;
	bh=y/Xznz3uuxx6GPY4fixP2RfVC4e3Bn0upM+QfN1OtUE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lQwRI+dwDGTpO75l2mveaxbHE9YL7xYYTCXFvYmzNI3/+pKWW99+fNpLitCZZvLubDoYT5HHpxzISg4WzRFCPb5So2S77FrhG6HZKU2+fwY9eEle05VoU4NZPzuW7/gTQuwOfBMutFxIXhHoRTtl4+DJms+hcTGa5VGzsiyMGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=PuZADTVA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eC5BzN3j; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="PuZADTVA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eC5BzN3j"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 101B91400016;
	Tue,  7 Oct 2025 15:31:14 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 07 Oct 2025 15:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759865474;
	 x=1759951874; bh=o4Ip0mb+MYA2mz3yyJwTqLIKncV62ACEndoy/R/61uk=; b=
	PuZADTVAfhkAoMpvMPEPjVUeYN/2ULjftg6qAoFvDdRbeoecAzn2JxgENtOEfT2e
	1LVzpAIvB8ZQRwRkl6QDDgSjmcY5SOnucWCFTlMydweOLTRvz1NW9IGFPViZZMI0
	jfR3LXru3iYfZB/unT/aM8O6TpZsSJSUvXwHIrEGaip6hkOexCAQJM6GUy/oh6Qx
	Xyuf5b8uVEaynZub0aaSsHw+wSIE8PQWZP+cV8VdTMUOvR12lw3rHemq8gO3T4FE
	CuHfGP15qMz8hdqPqe/SEaqvuZRMtrH+f01kV/2AkMuWQyo6wdBbctdHpGs0mkIl
	CbIG0dUdh7oTDXG2ebrx9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759865474; x=
	1759951874; bh=o4Ip0mb+MYA2mz3yyJwTqLIKncV62ACEndoy/R/61uk=; b=e
	C5BzN3jxdP3P+31//F55FrBK4fn86Nwu/3VU6HiacBXDKS1LJrM5HkBWgPd5gdYv
	niLggwOjohOyLPM0hpRkTRCQiYqFOmeOIQKbFN5Ah+WhXecB0OOS+3KDA7Ty8yyn
	jr9CKWoFiq679iaJEmX+MLpo6JbeP9hHArXod+zlZ38rozfz/5w/upP1KQ36/OI0
	LAB7takAZQijWwYKQDMDq1stxXdN47M3mXykDGoYRTHcshr5y7NFAHIRlmq/6UCF
	KeENr7ytN3MG28gWgwwzSw/oBAiG95ZFUjhl4gPgabzrTPpOiA2yxicxZZdImGSe
	VCJT3JHmSQMNUvIMBz9uQ==
X-ME-Sender: <xms:gWrlaEuJPmCEjZvLkN1lP-Ftgg-SMZVaKBQ29naRwPc-d-we47Z1lA>
    <xme:gWrlaMSqrKA7Sn2kzBFsTrmL_1cxCiMx-rewU6HFjcwt6SK_rEljnFVMce5pHWJwl
    h59ixKvViypnWrCnxOksAWAXYLg8mLNB-VqogzD3AnrCh5gSG1Mig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdduvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gWrlaMWZ6atxhVMQ-k5boA-TWX0VElIkHZffgzbU33wcnqXbkic36A>
    <xmx:gWrlaOaEWYMj2CviI4e9L3Llo0FZmfi5Wp2F-unbGv-AMD13lO-qYg>
    <xmx:gWrlaK1vzf9bT2A_jv580b-AoAZbc7kUhe9lNam8frBFOketdTJ7RQ>
    <xmx:gWrlaIhI4MRSxmd-RTj16Pv0bbgfdSnRL4mItdaRoDOxXMOaj2CVDw>
    <xmx:gmrlaKreMebRkei-aX3TKnq26sewq-hv0gBwgfihijtLs4bNLd0cfK3u>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2FDE78016F; Tue,  7 Oct 2025 15:31:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Tue, 07 Oct 2025 15:30:47 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <ede082ad-5031-4b55-8576-0a6315f16b70@app.fastmail.com>
In-Reply-To: <xmqq4isalk5g.fsf@gitster.g>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <aOUkZa4_fq1hho7Q@pks.im> <xmqq4isalk5g.fsf@gitster.g>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>> I think this needs to be adapted to not single out SHA-1 as the only
>> hashing algorithm. We already support SHA-256, so we should definitely
>> say that the algorithm can be swapped. Maybe something like:
>
> Good point.  Also officially they are called "object name".

I hadn't realized that "object name" was the official name, it does
seem to be used a lot in the docs. I'm going to try something like this:

1. an *ID* (aka "object name"), which is a cryptographic hash of its
  type and contents.

I think it's useful to refer this as an "ID", because usually we call it a
"commit ID" or "tag ID" and not a "commit name" or "tag name"
and it makes it more clear that "object name" and "commit ID"
refer to the same identifier.

>>> +tree 1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a
>>> +parent 4ccb6d7b8869a86aae2e84c56523f8705b50c647
>>> +author Maya <maya@example.com> 1759173425 -0400
>>> +committer Maya <maya@example.com> 1759173425 -0400
>>> +
>>> +Add README
>>> +----
>>
>> In practice, commits can have other headers that are ignored by Git. But
>> that's certainly not part of Git's core data model, so I don't think we
>> should mention that here.
>
> Third-party software can add truly garbage ones that do not have any
> meaning, and Git tolerates by ignoring them.  But there are others
> that Git does pay attention to, like encoding, gpgsig, etc., which
> may worth mention (in the form that "these four are what you typically
> see, but there may be others" without even naming any).

I didn't realize that there were other optional fields,
will try to communicate this somehow.
