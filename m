Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940F327BE4
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766496775; cv=none; b=U+3naWKfAs0lE9jOZtLn6/AHLcWgEoldyF50sICNzeoh699zWkaJHUbulUMcDLxbf0fkXfghXP3zoSsWdVp9W0m8wUivW0kJ5G9XDWaoErd+4mNB1ddTPAsDg6N2W2DtFi2B1HKaZIpSIAVpS5WzjbGNunULMteXad71Q1bZEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766496775; c=relaxed/simple;
	bh=OkhvwgGuL1gkmfyWnl0lH9zKL46Foq+EtbprFrVHh1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RHbA/yLcH5RWeZpzf+YWU8HAyblRZKTxloJsaxcwcHB93g/qTuVritunVrNILO9JP24jRe8frJEIAEIcDc9IsQHqFwyTa0DmHZ64P15V4jga7yJgjJPJNd7Dm1uLYwAm3nj/S3u+vlK+dtzd2oxKhouiVwXnzu3iTPmeu/BRZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WfwDseRt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y2k0ucZt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WfwDseRt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y2k0ucZt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B868F140000E;
	Tue, 23 Dec 2025 08:32:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 23 Dec 2025 08:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766496770; x=1766583170; bh=72bPOY4oRQ
	err6wLuSUaNfid13YzGZzn7g/CZsk1W1s=; b=WfwDseRtazKQ6r2uEkLDkP8nol
	sNHA5GLxccqjnbXylInnwEpXSq8krrpNoAsOi6tlbjcTlDLULOF7RkfuasfBQCE5
	G/4spDHuIKqsH35tX6S2zWwEuTN7Ky+PX73NcwJs9/pkVukHYWLFfIgtd+xjRKEJ
	cvK5zQADzuKZ8mzXeplzal71ChbscEyeETV5PgWmXiq6MUcvZYcfpma/79IabHra
	hWwH0ahUQFYc1N/NvSzbbvRxjfcokxCY4ngjdzIf6cKXJ/J9379zp/M4a4f6X4iS
	ggld9ls78RU+I7Qg48FxqLuHq5R8Jp02xb8zgHjCzynHUtQDR0isSlp86GWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766496770; x=1766583170; bh=72bPOY4oRQerr6wLuSUaNfid13YzGZzn7g/
	CZsk1W1s=; b=y2k0ucZthOdOGI0xQQA7NXjSf4SG2tdBMIYMLlvDI3PstMxFIU1
	yK37xv7nmHtQ1/RlbMQGCaQvXBdwFFmPRCVr0x6N+lRJU448FzEhIFcTU6kV2Qtw
	5hnW1aCchgdwWAlEPtI+uV+/lEQ3PpJJucMtpswj7eRzp/fLfDThdJu5AD+HxtX0
	doWWpyUO2bX3xgI6Lr3KgU2N7LqfcHR1VURSgUYonCYD6pUI511h1BI1CjHZSoWn
	P+wOg3zOsiQAV7EwdDPExNm2acbMOb/6tKFPakuVuGX3KlfnS0tftvecfGU15hLU
	HExk6vZ0iWF60i9KfWGu/ulOu3iCrkL/gqw==
X-ME-Sender: <xms:AppKabu0aNoelGi-UMqFr8V2iRw_otrEytpAYkuTT7PWP_NoJ7S6Lw>
    <xme:AppKaTe2hzqP9yFgje2mVXJp4FBiaw_Nni9uyr-GLyGZji2ynTlz0cP-v7e9-KFsG
    cUDCmddWW_J1V1U-1vFA0yUZKXe68lflK7OxdXQp1l7k52yP6XvXj8>
X-ME-Received: <xmr:AppKaTwNHPRAdcqr2wmn_cJUSfVhK1so50FS3YhIyPzTpicVQTu9F7UyiqiFhFvmUJQVM-KMv5ChHAyiF34_4n7nBluAkuNdIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehleelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AppKaZGYRThg5UBZ5cHS4ODr-8k4EMhYM5yr4W6LTnckwxDn4qw1Tg>
    <xmx:AppKaXxxoY0sAHsNX-R471u7t9AoqEbM_N9F2mYu6FDdtWpi85RpWA>
    <xmx:AppKaasHmc5i2OKSJI6orpGWV0Gnh_S_IKO3tCl6wtJDn_tS9xPaYQ>
    <xmx:AppKaU35mlf8t4X2Tc-wnbk-P-eI4TIKVcT5qr9hgUYhvejB17KKLw>
    <xmx:AppKaZvFIStMOTNIDVry-2k7nbfb-aHjLeia7wcF1O9JODFHKKjPoo5O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 08:32:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH] status: show default branch comparison when tracking
 non-default branch
In-Reply-To: <20251223102422.36853-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Tue, 23 Dec 2025 11:24:22 +0100")
References: <xmqqy0mtpxti.fsf@gitster.g>
	<20251223102422.36853-1-haraldnordgren@gmail.com>
Date: Tue, 23 Dec 2025 22:32:49 +0900
Message-ID: <xmqqtsxhpblq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> You seem to be using the "what would a new user get when they clone
>> the remote (by virtue of their HEAD pointing at that branch)", but
>> I am not sure if that is a good way to determine the other remote
>> thing to compare with.
>>
>> Even if one remote branch you pull from (but not push to) has a name
>> that is not one of those usual ones like 'main', 'master', 'trunk',
>> 'default'
>
> Agreed, this should be as agnostic as possible. "Default" might be
> me using GitHub terminology. However, it seems that 'git
> symbolic-ref refs/remotes/upstream/HEAD' always produces the
> desires result, so for the sake of discussion we can call it
> "upstream/HEAD" instead of "default".

I didn't exactly question the terminology, but was wondering more
about the wisdom of using remotes/*/HEAD.

If a project uses the same remote repository to maintain its
maintenance and development tracks, their HEAD might point at the
'main' (used for development), but some of your branches you used to
work on fixes that can later be merged to the maintenance track, it
is likely that you'll fork from their 'maint', and while you keep
polishing your fixes, you may push your 'fix' branch to their 'fix'
branch.  Comparing your 'fix' with their 'fix' is what we already
do, and it gives two thirds of what you need, but the missing
comparison is with their 'maint', not with their HEAD that points at
their 'main'.

Thanks.
