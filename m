Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5D3264EF
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882444; cv=none; b=S+YjyOUUXLOK1/q/a81HzfLRXbEuvgxyY/Q0ONSU0HtOvuwr76YVSf4M/TcuAOnGUtsGHvNldad2i1n+KeAVdUgmUYTGSD2alIK7dH64wNv8SQKxdaEe+C/NTbl+V3n7bWaBoQYZl/2d2JXv7L61xdkK56U2+6Rc89SXh9/kjHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882444; c=relaxed/simple;
	bh=E0uqTMzyQa2Mi+KMGinQrSluNYON/Fma3NCkVb18CBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZWM+m3lXZ6gy3B424T2ErTCsI029Do6bn6Ilu71gY/w8IVK85JVigcr8cJaUjG5EQocdlfoqGkFnFlqcINDWy+G3zTZdMJlg0M8k87cy7kO358YcK+u5YN1bTmuSb9QCAdR+4VLf0vwAYa/eAtZjrXQbFePXfLJid+4RnN9OE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SWThDpHK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r3b2F1ix; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SWThDpHK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r3b2F1ix"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C87147A01C4;
	Mon, 30 Mar 2026 10:54:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 10:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774882441; x=1774968841; bh=23JuZU0sAf
	lazZSnNe1aXuTUBgRxekptHt6N4o4h8nk=; b=SWThDpHK8b92r5lk35IZo5l+ve
	cTNoFq2jVJbtkD/Vx7qKWMtEa7woGptbRvXa1Wr32cXQUMiU/fCeS+wJjulRSSoO
	gmTw6IkMdrk/5lm2W5ddM6efsAGDjIvS5+5+tgI3u8CVeIaBPvuylCZKmbr+Mqbc
	LSC2oM446v5WQy8EHpzelUERPO/g/mLpu+USiMP4RNvVUO+D1QhPTzXK1Hbp9QLF
	r8AafQc0x+lkbuyFevpBSQeCaQLf9LFLpdiu3EnYSucHDvPaP9EdhVdAN1yvmCH6
	7bUDotef1uh6XCvQ/yD37QxglnIlZN1rdrKpiP8TI4KoUs7v46Yk62r+BE+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774882441; x=1774968841; bh=23JuZU0sAflazZSnNe1aXuTUBgRxekptHt6
	N4o4h8nk=; b=r3b2F1ixCa+NLn2BSzu75WkxLQ57nR4uIyiOKlEbZpr6O+0wsYZ
	mtgO2KFhRnLz3erKPiEIw2jile3/tW4pkYYO1bATHSRfJm8SoDY4Q6dY2Bri76Wi
	8bEK8sdhxZckyh48zTckjXjCxLUByl0RDhdP9KLa92Rkt1U3rETUoEzun/4F1YsN
	HUHCyPqKCrgt4cAJvorjNEp5MYZTDpaB1h/+/u/bNJLitgj4qylY8L8bhNsXbwxg
	f5wec03i3nyJw0q4YsETnFfUhHo94SpfK4VEyAkCQvJhV+TrzQEMeA7TMhH6z4m1
	wAFbHU+/be1xWUewfprweWLvuzfX/7YmtWA==
X-ME-Sender: <xms:iI7KaYYEYAmWp9XM7hIxPIJT9mh2zB_jfiSwr5YNOc8Jc9V6KWYh5g>
    <xme:iI7KaVpVSKB00pE5rM3Q-bTVYptGmN8DdwPg-V8L0Fv9flGXxuhECatlnLvzdP8DS
    -YsxSx0IV7gOOtVa1ll7OdsMu3b5WbmrmZ7be36Bu3sEDfW-byG2Q>
X-ME-Received: <xmr:iI7KaVMPt-H9HWv2hqgQlSaajnq1kiIJ21gYVgPnIa4JB_ZjiOVU2oZD-9ipX8e_pFmlzcah6uOaB3KNtvEFWbHghSt79WtAAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsihguug
    hhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iI7KaYqG6TurcuRbUeA3rDeHIKFRTiYb0yB6uUHI0h2a9vlw9-pKTw>
    <xmx:iI7KaScZO0zPCSGRm6G-fBCOAyV7WxOFI9j5cDisECG74Iv4pvNUUA>
    <xmx:iI7KaWQfBOJvZcDxYATy_JhJxJUlUnp6oXpVtxgOezvAtjoqhc8l1w>
    <xmx:iI7KaTaR_wtf7MFNc5hp1F3y8arRG_4_fbNd6Q7lIdhtaMTXxgzFcw>
    <xmx:iY7KaTSfYclR-3OXvtjpsxIG-FL8eOeUmCweCPMXr18TCqpZCD0mtcbr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 10:54:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com,  christian.couder@gmail.com,  toon@iotcl.com
Subject: Re: [PATCH v2 1/1] cat-file: add mailmap subcommand to --batch-command
In-Reply-To: <acpSgZ8RgBIE-h1Q@pks.im> (Patrick Steinhardt's message of "Mon,
	30 Mar 2026 12:37:53 +0200")
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
	<20260329082808.12609-1-siddharthasthana31@gmail.com>
	<20260329082808.12609-2-siddharthasthana31@gmail.com>
	<acpSgZ8RgBIE-h1Q@pks.im>
Date: Mon, 30 Mar 2026 07:53:59 -0700
Message-ID: <xmqqpl4lfjw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Mar 29, 2026 at 01:58:08PM +0530, Siddharth Asthana wrote:
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index b6f12f41d6..a53926d2bb 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -692,6 +693,24 @@ static void parse_cmd_info(struct batch_options *opt,
>>  	batch_one_object(line, output, opt, data);
>>  }
>>  
>> +static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
>> +			      const char *line,
>> +			      struct strbuf *output UNUSED,
>> +			      struct expand_data *data UNUSED)
>> +{
>> +	if (!strcmp(line, "yes")) {
>> +		if (!mailmap_loaded) {
>> +			read_mailmap(the_repository, &mailmap);
>> +			mailmap_loaded = 1;
>> +		}
>> +		use_mailmap = 1;
>> +	} else if (!strcmp(line, "no")) {
>> +		use_mailmap = 0;
>> +	} else {
>> +		die(_("mailmap: unknown argument '%s', expected 'yes' or 'no'"), line);
>> +	}
>> +}
>
> Not commenting on the overall chanegchange, but I guess we should use
> `git_parse_maybe_bool()` here?

The saame thought occureed to me.  Also I agree with Karthik that we
should not say "applies only to this and that commands".

Thanks, all.
