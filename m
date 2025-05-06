Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F65680
	for <git@vger.kernel.org>; Tue,  6 May 2025 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569274; cv=none; b=oGJd6i/vG/OIxrlMaVpLIgj9+6lHRKz7dmjMxlR0vbiSvtDVNfqyIj3S4tZCGZL4CjfVvkAmP0nNR2sul6GCqVkRJFTJPnYgLtTHGpufvzFqVJBvku0qiviuEjfT4KxO76DIemnuyF2WyeglBWqRAkfWhBoo1Xwkd9vwoLIFLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569274; c=relaxed/simple;
	bh=c0vKJo3eGdGKTI0mmN2NmGoQ1lRZ5c7558ktTWmGk94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YbId0ZXJHHJn0ikBG7S8af2HNKfzG9qv3C938zfB5Mz31+ZEONfuK5/fwqp5+XB/9RfGzSFktjlQlZUAq7RhA5cCqes0/IygzOPVEYWGNTprVdU+yOw470Qd4mg4KJatOEwL5kEOCv0EZzf8gfMtdoPYRJginpSJKe7QPPJBBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h6kCHfNU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VomWsRMF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h6kCHfNU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VomWsRMF"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CC5D2540231;
	Tue,  6 May 2025 18:07:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 18:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746569270; x=1746655670; bh=73MvREXAuo
	tnDYA7DOgJrNjqiN80eKNSW1dyNJ5JROA=; b=h6kCHfNUtyO0cc+tgt6PAE3bkv
	+Z+F0qfDVdTdNpCKB9spDh6Ut4SXlZtlJb7Grwb1YCvYZNLMZmiIUMsYDuC95D+0
	an2uTr5RqWCVFbhFzmmPLq2CQKFLBwsCj+sRVPOxAglQPGIFLrxVcL/Bqh62pySb
	W2l0h8rUIPL1baeYGLqJ0fSwXh8Um+LoEh/sn05ic6QR8viI9WXxZyPzB83McKIR
	ecAFSa6o0Z4VFtPdu7JKgnJq8ul9nGOlk2G93/z/VxDKHFMLX7qoTF8as+K+fplN
	bk6cfrlJy+zHA1YrMY0w0ttcfjBjJ1FZMZ4ywSleYjdduEwj2Iu2cRPOQ4Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746569270; x=1746655670; bh=73MvREXAuotnDYA7DOgJrNjqiN80eKNSW1d
	yNJ5JROA=; b=VomWsRMFG6n1HbOF+XJcDXFsOlStRzYl3qzlJyFkrBbgN28vAwd
	nTYPaWj+xtc8sMsbxguQoauYeUCACIvCNUjQk508GzU8aoeOC4mD23MmI0zkvCCX
	VCPxDM/oacaohooE7FElkWNhmxZ9lfkQen6YAtAJLLY/2KYbZh3qzH9pP7mwZp5b
	lIbUmxz1JybOQwDfCkN6006FkvNtRIGWILjZWkrsmNatnaVAdnDv/fUNVpjF6wRO
	j2NtpI0yhPrzRPJTRAOfGFlwhyV2c0fKnWtPao24h4o4CO3Nr0ZZs09qHdj26r7A
	MFGjQfqGxnpSTzXZ66Mm/R1mBD7ecBq68vg==
X-ME-Sender: <xms:NogaaCU41RJkwzf11Xgcv05A8oLJsNesTQr-V65fTkBUJm5QrDLGcQ>
    <xme:NogaaOlBTLWdzgRCWJalRGL6tM7wAiylfUGkUxYIG02jgQ6RX3GVnKxApRL8jy-kO
    VsWgMbTxx_f7UE-0g>
X-ME-Received: <xmr:NogaaGa-23zXHdguI4wJZ2gCBpVXXsbno_JODG42ylKb5GfjCMKILtOL_naS9xOaHvoY6aMZIpyMYPUMJZkfRB6DxGNrFj88Y4Bd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrug
    hithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilh
    drtghomhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrghkvghrshdrohhrghdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepiihihigrohesughishhrohhothdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehs
    thgvvhgvrdhmrdhhrgihsehgohhoghhlvghmrghilhdrtghomh
X-ME-Proxy: <xmx:NogaaJUhi9URUF1Ify6RnEWk_98oDnuLFsX2M79ab57T2Xk5gNrWPQ>
    <xmx:NogaaMnuCFS8-0hPyahd_LUNUdHEAP5UvNSlNXOvIukRCfEkcWjm_Q>
    <xmx:NogaaOfdiL7DqayRj7Mz7gGyIyM9E-6ea0Oi6GXzDHRHZz4DuZncsA>
    <xmx:NogaaOGWNW33UigRUEDz2l_qzDZRDgxFjpnHIFSwz39vFV14NyLsNw>
    <xmx:NogaaD6tWmCNx0haj-BEDpr_pwsLIj7F4tKH03ZH5WwvMkp9hjHx_0LG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 18:07:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  M Hickford
 <mirth.hickford@gmail.com>,  Julian Swagemakers <julian@swagemakers.org>,
  "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Steve Hay
 <steve.m.hay@googlemail.com>
Subject: Re: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
In-Reply-To: <PN3PR01MB959731081532150F5FE54875B889A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 6 May 2025 22:53:44 +0530")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95971B8A202ADEA412010B35B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqplgmlisy.fsf@gitster.g>
	<PN3PR01MB9597B15F81AC6DDB35546C2CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597ED4DA3E781A6EFC03B9CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqecx1ll5e.fsf@gitster.g>
	<PN3PR01MB959731081532150F5FE54875B889A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 06 May 2025 15:07:48 -0700
Message-ID: <xmqqzffpfl57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

>>  * ... but I don't know if your use of negative lookaround
>>    assersions is correct.  Shouldn't the "a label cannot begin or
>>    end with dash" be applied not just to the first label but
>>    consistently to all of the dot-separated labels?
>
> I think you are talking about this case:
>
> someone.-example.com
>
> No, its not valid.a

I was not talking about any "case"; I was talking more about your
regexp to catch invalid addresses.  From RFC 5321,

    helo       = "HELO" SP Domain CRLF
    Domain     = sub-domain *("." sub-domain)
    sub-domain = Let-dig [Ldh-str]
    Let-dig    = ALPHA / DIGIT
    Ldh-str    = *( ALPHA / DIGIT / "-" ) Let-dig

so the syntax for first "sub-domain" applies equally to the other
"sub-domain".  If "-example" cannot be the third-level subdomain,
then it equally cannot be the second-level, either, but IIRC, the
patch had regexp that treated the first level differently from the
rest.

