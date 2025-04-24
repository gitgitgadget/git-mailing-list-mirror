Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53418DB26
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508016; cv=none; b=LIRboyhl8xjrkXs4sU5MKyxzRA1VxekgltYlNG8wDNcfU70DDp8YHutzQnAiIlDo7X0Kso1iAyG4HwWt1OkwjC4zxNNplxfv8JffXuhSuLDCd4Cb3Ca6VfTHfod+xrqgigSpEVQNFrRBGqtOqwJCSbAS40vMvwSnX8GGlQibUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508016; c=relaxed/simple;
	bh=0vlWjvVx6iwsvCWg6DEbG8mwwogZeyX+eZSYKzXZhgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SPo4eBx/29DE26E/VeLEZ3ALv8c1zVrS/wLTgjqWs7HwErPwrIEehi9i83K+pvXGuOYXgkVDKg+P/dbmkV7fWArkS7HEosdLyxiBHIr4HugXA6mN9QB48d9rhOVgcEeTaVPYO5gJsYdC3K7n9C0z8wM69sdCHJNyx5aGMS11g94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MPEHNk8S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fhmCTRIC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MPEHNk8S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fhmCTRIC"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AAE58254025F;
	Thu, 24 Apr 2025 11:20:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 24 Apr 2025 11:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745508012; x=1745594412; bh=qHNTkCjWP6
	wdK4V8mWE2ThvjPmvOSO96gMl9Quqor5s=; b=MPEHNk8Sr29vF3KHmXd3EanyJH
	s0QIjl7wL6jKNe2KVBK5W/sR9wwaaQnOZodmRNmDx9X8KT5qkZBO56WlzJom42cg
	W404cHL7ljjnJhb1TluoZlya430L6xV4dJaazHUQ5svUoL6HLN4x3f6P/6ADDW+P
	wtlsvsIXcAkYyC5ueSOHDdBkXx+cGVe1Vh7W57zTRKAzGs67jtIjrK32XpNxqYbM
	IVA2Wd7XoNPzMRyvqGdNdgG/rxNAFl1s80Vb41oW4IXSUGVCJ+24rezLPFdjX8Qz
	XymQwMn3322O+9qKfSdo1YtKMl3yo3OdZB7yKr9h733XhNzZQYs3fNjBd9ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745508012; x=1745594412; bh=qHNTkCjWP6wdK4V8mWE2ThvjPmvOSO96gMl
	9Quqor5s=; b=fhmCTRICoOzS+IP2uEsmKFRSQBKFx41DyHdHxX74TiMx+Ly/c5c
	xFTm37o3eMhUqAGAfqDZ60UCEZ44XeaPw4fUVOHJMX9LzevUFCpw53ixujGE/qjw
	ogG+51fZCXQzq4yWomkaYgQnFCZkiE/Fmo4wbf4h8nuvNEn/wv0t76J4mgmHGEcc
	7wdWnYNYC6HaPccgyYaW5Z1+OldnHWw3QNTNnpg0IT62uKB2vCIgs7mjskWFAIFC
	R13et20HgeJLKLfKHUBA6l4KhsKsWuKsPeeIUtr5ECKK9ky2IK/IIbl0/FYZuXV/
	OuHvV1AVbl4xzogbfXKWTFfEGKyb6W4LNoA==
X-ME-Sender: <xms:q1YKaLJai2kZVJtcbBapewxPmsgatgD77ILEc2bE42zBn2ir0TmGxA>
    <xme:q1YKaPKl32NOEnHtphrkBoD9WJ2pF5lU-kHrLkxSU7049-_Ctj5_4yrpVef7ke1XA
    sqyLarlMBILqAHI0Q>
X-ME-Received: <xmr:q1YKaDtsyUM-kJj1zmCWV_Ijl0SGx-nCVzTNZNkoDR75MVRf0ajIg4fH1HEUM0_SOK1ZGA6ZkrhfSUcYBKP2rpeFl7FliR4zZRgS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieeftdekfeejudelueeuhfeuveejvedt
    geeuvdeghffffeeuueefgedvffegleffnecuffhomhgrihhnpehofhhfihgtvgefieehrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtgho
    mhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrghkvghrshdrohhrghdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhirhht
    hhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepfihirghgnhdv
    feefsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfh
    houhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepvghhuhgvlhhssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:q1YKaEaDRwnnjuAxg924cWEIvg3l_ouQsm_APIaOGImpg6Gq1vUfcw>
    <xmx:q1YKaCaNLyjPvm38X1iKV0YChSStQEjrDlFDAU7rL-NZPDbbRE1W_Q>
    <xmx:q1YKaIDZ_WjKoQrAzdUZ9sJiqjwnB1LeOOnc9ve7qqZQSlp4XqOGdQ>
    <xmx:q1YKaAYtHLoNrN7r5LsNzQg8F-cE6OrGmzdqDw-LvdxMCX4LZkdXqQ>
    <xmx:rFYKaDb_vOs710BlHiORl3N_a3Ktmry6uItSTRosVFG_XqKKkn0vtlfy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 11:20:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org,  M
 Hickford <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,
  Shengyu Qu <wiagn233@outlook.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Erik Huelsmann <ehuels@gmail.com>
Subject: Re: [PATCH v5 3/3] send-email: add option to generate passswords
 like OAuth2 tokens
In-Reply-To: <PN3PR01MB9597932FB4B19DE2038AA26EB8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 24 Apr 2025 18:23:22 +0530")
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
	<PN0PR01MB958856EC9FB1E4F73A738746B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
	<D9EVAF38Q1KJ.24J34ET29VPTI@swagemakers.org>
	<PN3PR01MB9597932FB4B19DE2038AA26EB8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 24 Apr 2025 08:20:09 -0700
Message-ID: <xmqqjz79vb6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

>> Something like:
>> 
>>     [credential "smtp://smtp.office365.com:587"]
>>         username = someone@outlook.com
>>         helper = "!f() { test \"$1\" = get && echo \"password=$(cd /workspaces/codespaces-blank/M365-IMAP && python3 ./refresh_token.py)\"; }; f"
>
> Interesting, and this works too!. I wasn't aware of this.
>
> Junio, I can drop the third patch if you want.

What I want does not matter in this case, no? ;-)

It does look like an additional mechanism only for this use case is
unneeded, but it would be nice to address a related but different
problem, which is

    What made you write the extra mechanism in the first place?

In other words, was the current documentation insufficient for you
to realize that credential helper is an existing good solution for
your problem and there was no need to add a new mechanism?  If so,
there will be numerous next "you" who will also want to use OAuth2
token from a program output and get frustrated because they cannot
find how to do so in our documentation, no?  Would a new paragraph
with an example like Julian gave above be something we want to add,
or do we already have enough information there and the only thing
users need to do is to look a bit more carefully?

Thanks.
