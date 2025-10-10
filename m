Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0959C2FC00C
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111110; cv=none; b=r4Is/r10Xd/YNqCZlG6rgqOinb4g/0G1SCgMtJ6uTQvLIUisnJeRGdAbuDWrGsrZR+cn8En5sWy8Tvauv3vf23eg7Yf9yx4+XYCI0V0rN16XYNlk+S3pjfogwEt+/uke7K37/WmL/0/7ZdNCUCmDTp5HkX7IXM3qQUsqNN2d5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111110; c=relaxed/simple;
	bh=X000sIjjGqjwuFVZrhXdm5FMUQcoxZ5ya6fEPmuArh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UXnq7U2AhR0WFXNcz3FP20latqAwJxOi1oiRxxiAdaJmWtSMhc3IT40DkRfoOaE4gN/Boa7YXsgxSHaeVkdhNBwRYjyQAiB1kGpogii8War4yCbEL9m2tCUpS13m+lMTq5nbvcjzDz2pwAHK/aXwyzQbpH/E+Q75p1OR+up0VBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q1mtsqKD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VNWykku+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q1mtsqKD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VNWykku+"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E3351400098;
	Fri, 10 Oct 2025 11:45:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 10 Oct 2025 11:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760111108; x=1760197508; bh=oNqIFTqGSY
	Y1TdSf0BPj7RoKJRMiXzqXnewZO2cPtpA=; b=Q1mtsqKDbMXi5BfbRaNVjgwzsy
	wkjHq5Wi1IERKjXdhj2plQfLg5euUi8bdP8EndWNrFNN3KbA6KP/1GVGbc0EqQz+
	9XSu4RkaESrwdwLLCDFgWBRdvSjyMk3K1wFPLBzox4u0V/pIvVG2Lw3IzsZeP292
	L53d/ZB1c8T9MuUBU6fOuT5BCg6w+jS19Ptbb/qB5F1xHJT3F8UlIdTRzfgH2Bn/
	rOOZqN3L8LyX31NINXp1g5Qr/LvXJ6lmezNQ3EOJuB/hc9zxwK1brW2FMCS35KO7
	KqE2WttjOmrE2QHgzEm61oXVtG/YwcqIPkLszMgQaOSTHqFjsS0RDl4O6S3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760111108; x=1760197508; bh=oNqIFTqGSYY1TdSf0BPj7RoKJRMiXzqXnew
	ZO2cPtpA=; b=VNWykku+BfPu3cuW4ea7KM55JyMD+InozHHPDCQGLsDMucoLDw/
	tpMB2PUetpSPAQQazFuIzNlor+IH9aLYnoSFQdqkbgz4hIa5iwVVWOvM+oQIra67
	0Wp9zywA7QQFu6hQdMIWYKdJ3OAYuMJWQozcECQLCtAtdcXJWH3EXlbJXEBUQef6
	or/+L86KbsesKEGT2MRQzj0uiEerZRQtMIc0K7R/qpY7I0UUXfVdLhPxAbToZoty
	ehfheEhBYyXmlP4pfQtQ7ou+KPn8yzDVT0fgR1oA/RydyUVsgG+K8BSOV+VTJ6uP
	USK6dfQzQTktRt0sUKQBsi9r7WvnwmhhbAg==
X-ME-Sender: <xms:AyrpaElYpEY3y-9q9x1hIoykjTz0BEdCc5Eht-XbmbZIdD-WEnUUDw>
    <xme:AyrpaK3txc8WmMygQDwt1UP1f9slv39RBeG2P6vwGhQGmt3Z66-P2O9X2ObJG8Ycl
    G7RG1Q89LcxJD3VzpOw4vDOC4c54xXFhvLiUsuIbkVPmkN4pcbA5A>
X-ME-Received: <xmr:AyrpaHquNdps5sblgi29yCIQJAFZR1nWaBPGIoExoCtmEqA4vvFPLz_252zTLRZJG2KftGvHC9fQW2WA5yeWhGBNm_KBbrE7MGD9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehokhhhuh
    homhhonhgrjhgrhihiheegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:AyrpaPfzNKGxJZoFVdWJuWLOQVKObncM-HxLl-SW9sGPgDQ1HmiGRQ>
    <xmx:AyrpaOr_sP1iRso8w_GjLuLnA_2Hbx3PH19AClDG5KWBST6ii7Ub_g>
    <xmx:AyrpaIGAlzAFrRv_uO_XbSNZIL179D70QNTuG-7Kr6VEgoYf8lDhcw>
    <xmx:AyrpaGuwzKofihiY7XesQaRSidNwctB6sgr9FxW9z5K3CmvqZ3kovA>
    <xmx:BCrpaDLxm4Atw7Thr1A_eLPuITqsCvpz86Nd1s_EsTJAOgI4UB5Vzf_d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 11:45:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] patch-ids: fix NEEDSWORK timezone parsing
 in fast-import.c
In-Reply-To: <aOiZ_v3bO35oVWf-@pks.im> (Patrick Steinhardt's message of "Fri,
	10 Oct 2025 07:30:38 +0200")
References: <20251009234957.1789543-1-okhuomonajayi54@gmail.com>
	<aOiZ_v3bO35oVWf-@pks.im>
Date: Fri, 10 Oct 2025 08:45:06 -0700
Message-ID: <xmqq1pnabw1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 10, 2025 at 12:49:57AM +0100, Okhuomon Ajayi wrote:
>> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
>> ---
>
> For a change like this it is important to explain what the problem is,
> why it is a problem and how your change improves the code for the
> better. All of this needs to be patr of the commit message so that the
> reader can understand what you're actually doing.
>
> Also, if this fixes a real issue, is it possible to demonstrate the
> issue and the fix with a test?
>
>> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
>> index 606c6aea82..695e1a0ae1 100644
>> --- a/builtin/fast-import.c
>> +++ b/builtin/fast-import.c
>> @@ -1959,14 +1959,15 @@ static int validate_raw_date(const char *src, struct strbuf *result, int strict)
>>  		return -1;
>>  
>>  	num = strtoul(src + 1, &endp, 10);
>> -	/*
>> -	 * NEEDSWORK: check for brokenness other than num > 1400, such as
>> -	 *            (num % 100) >= 60, or ((num % 100) % 15) != 0 ?
>> -	 */
>> -	if (errno || endp == src + 1 || *endp || /* did not parse */
>> -	    (strict && (1400 < num))             /* parsed a broken timezone */
>> -	   )
>> +	
>> +
>> +        unsigned int hours = num / 100;
>> +        unsigned int minutes = num % 100;
>> +
>> +	if (errno || endp == src + 1 || *endp || 
>> +	    (strict && (num > 1400 || minutes >=60 || minutes % 15 != 0))){
>>  		return -1;
>> +	}
>
> Despite the formatting issues I also think that this here is becoming
> hard to read. It may make sense to split this up into multiple
> conditions.
>
> Thanks!
>
> Patrick

Thanks for a good suggestion.

There is another thing we should be aware of about these NEEDSWORK
comments.  Often, the task a NEEDSWORK comment suggests includes and
starts from assessing if the task indeed is worth doing.  We should
read a NEEDSWORK comment like above one as its author mumbling to
themselves: this feels lacking, and we may want to do more here,
like X and Y and Z.  Maybe not.

Do we need to check even more precisely here?  What's the point of
doing so, and doing so here at this point in the control flow?  Are
there better approaches than incrementally adding more of similar
kinds of checks?

Without being able to answer these questions oneself, one shouldn't
be blindly following what a NEEDSWORK comment like this floats as
"ideas to do more".

The current code may turn out to be good enough.  Removing the
NEEDSWORK comment with a solid answer to the question it poses in
the proposed log message would be a commit worth making in such a
case.

Thanks.
