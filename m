Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F537DE83
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215785; cv=none; b=pKErBRILjsVLRWadp2Pbxy3Tyh1ckdv//n68gDQkZIiYE2/Q6FxHgyCuMXwxrEWvQv95AIICG/UzFsVX+dOAyhHUinvfTOm1ge/ZeaKSJ/EhpToTTp2HlaGGTlK3Ag933KIruRh27DTBtQqvgOLAcErbg2PG4BnSeQuHX0dnNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215785; c=relaxed/simple;
	bh=rvWfDyAT4RfZKav8W8SYFelMnJXABZjeduc+67zh1fM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C7U75qLm3Z70Ph+5b8EflTm4ovYHiaB0/laM97Tl5BMoL4h+tkvEBXKf4uiiyXwPa7yQ0VqXfNf1jZ4vD3D7mx7CrBp95Ah8oxEZ781cFgwkYc7cAXcPGqhVibQ+vU0O/TfS43YPm4Zdbv1Aj50K0M1JTOOSP4jZYMiiYZIShrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NqqH9JzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r+U+4HH/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NqqH9JzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r+U+4HH/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 678A11400112;
	Sun, 22 Mar 2026 17:43:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 22 Mar 2026 17:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774215782; x=1774302182; bh=pRn+JQ5/6h
	PKt6HC2RZkup/m6sZaSJMY8BGSWGq5c3o=; b=NqqH9JzYoZoXRy8TjVIsps5tft
	lcI2Zmy3t+ooJTjzO+enAMiZ/iiy2yuI8wCxmR7wXGOBlE7SPGwGHg+h2O4LL8GF
	hIs+jKB39qZZvSLHHJzLOBlhq2OkWO+gjOxD50hiBObi/2iDtApFKHWAI3L4R1VE
	udT7VYiZt2WZTeAItwmRpJbqGRSTXYb7JG7HjZmvsZKoPa8IK8s/OGF8XZO/oySZ
	rX6CTy/Oj2104AzjC6ffVAjzxTAph8dSD3HJk1sq0MrrFy7Or+bcc03/1kEFthiz
	v9gUd2ASh2/OP5vH5eJB8LBu6lGiU1dsMRX4nf9w2aBUa3twY7o8idojnH4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774215782; x=1774302182; bh=pRn+JQ5/6hPKt6HC2RZkup/m6sZaSJMY8BG
	SWGq5c3o=; b=r+U+4HH/kyCSbAwbr4ubC8Ed2HufcgmQZn0ShyOJsfkiWUXfcCy
	YLlcv6tsEr8dwLTZ2PN5HUQ0k3Tw5DsuaoUkZ1R7c0R80Uhxxs3Q3fk0RbQDNV4i
	xjh1hbySVGPe7nJe9mSdi1xONNCT7UE7F1G5iYrFEwMNszXtabClxOTo4cDPbez2
	pthZOoOrkeHhaLedzxnBpe0us0OT9nn62DrhfMKpYnqjIZMkeB0yeyHuKFQMjmni
	U00oTOW10UnFDUftl2bBq5TsfTo68fFQFzD9ElfnygZsoZwouCG4W2SfWdTnLWaR
	uniwn8MpGnC8dBVjnv4dhD36OcB9oCMNzeQ==
X-ME-Sender: <xms:ZmLAacCNDdcP2ii9qjxXeUr1rzrBJZIgW_dlBKbUKKJKX_dDFWqXZQ>
    <xme:ZmLAaVibTk4t3Ip0zfhvSfF3qs76UIWhYc7-WbAQ5TTVMGoTUBTwuS7rQvKxQzivP
    1pv_aRUmin2UhDUNEevldOfyT3RizYQeeP6t20_4LAL1dBq7Z2fXg>
X-ME-Received: <xmr:ZmLAaUlCE-p3mhEPcSZ9Y9BOlyYST7tDIXWExGLZPTzyObROSjnxJpQdB6bU-BuUjqcK4iBlEOpSPBP82Kkei2ezxX-LA_4X0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeiledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdeh
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZmLAaRrdLDoXLX29BdrXf1zNQBIOS6yu3_BLOGYmSJBIGFMzNT9bVg>
    <xmx:ZmLAadG1-CB3HjKfq-N4JumIiuMvCSwBvvrLmn6HFZHXE2xzWGx8lA>
    <xmx:ZmLAadx9gaYD1zE51Ray-vYK0oabSDqh8qiSrG_FSdBRVA2Kw5FEMw>
    <xmx:ZmLAaSpS8ZKTOmj6GTNWkZFJZVT6js9e5dXxsZXTi2uozH3mBFIk4g>
    <xmx:ZmLAacG9m8LQBdsZrgmIXE24CbB_yCf-5T0r6snwVbp7Oihl5Frm9OKM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 17:43:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] branch: reject --show-current with -v
In-Reply-To: <bf5b0901-fc44-4fbc-b66d-5eb062ccd324@gmail.com> (Phillip Wood's
	message of "Sun, 22 Mar 2026 16:34:12 +0000")
References: <20260322060705.53491-1-jayatheerthkulkarni2005@gmail.com>
	<bf5b0901-fc44-4fbc-b66d-5eb062ccd324@gmail.com>
Date: Sun, 22 Mar 2026 14:42:59 -0700
Message-ID: <xmqqwlz37d7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 22/03/2026 06:07, K Jayatheerth wrote:
>> The --show-current option doesn't know how to handle verbose
>> logic. In such a case, we want the program to die when both flags
>> are used together.
>
> Is there any reason why --show-current couldn't be made to work with 
> --verbose instead of dying?
>
>> 
>> Acked-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
>> ---
>> I only changed the title of the commit message.
>> The previous one (i.e remove unnecessary verbose flag) sounded
>> like we are nuking the whole verbose flag.
>> 
>> The acked by tag exists here because this was supposed to be queued,
>
> That's not what the Acked-by: tag means - you should remove it

I was about to write "Yes, I do not even recall seeing this patch",
noticed the "v2" label, but couldn't find corresponding v1.  If the
message had "In-reply-to: <xmqqldiplvyd.fsf@gitster.g>", that would
not have happened.  FWIW, Sergey, who gave the "why" to start the
thread, deserves much more credit than I would, I would have to say.

I did say "This is certainly an improvement over status quo.", and
"is good enough for now", so it is not completely unwarranted to
have my Ack there.  Without any context it is hard to see, though.

I _think_ what happened was later, after that "Ack" was given,
Sergey brought up a good point, "why not consider what should -v
mean in the context of --show-current before proceeding", which is
more or less the same as your point above, so either I did not pick
up the patch right there (expecting some form of response), or
picked it up but discarded (after seeing no response came), or
something like that.

Since there are two people who independently questioned the wisdom
of erroring out on "-v" before thinking things through to see if we
can come up with a good behaviour for "--show-current -v", perhaps
we should do so before proceeding.

So, I am not picking this iteration up, at least not yet.

>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index a1a43380d0..cab22e1538 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -861,6 +861,8 @@ int cmd_branch(int argc,
>>   		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
>>   		goto out;
>>   	} else if (show_current) {
>> +		if (filter.verbose)
>> +			die(_("options '%s' and '%s' cannot be used together"), "--show-current", "-v");
>
> It would be better to use die_for_incompatible_opt2() here so that the 
> message is consistent with other commands.

Yes.  That would be much better.

>> +test_expect_success 'git branch --show-current rejects -v' '
>> +	test_must_fail git branch --show-current -v
>
> This checks that the command fails but does not check _why_ in failed. 
> It would be better to redirect stderr to a file and use test_grep to 
> check the error message matches what we expect as well checking that the 
> command fails.
>
> Thanks
>
> Phillip

Good suggestion.
