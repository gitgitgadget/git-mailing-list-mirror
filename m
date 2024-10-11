Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77919DF9E
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665639; cv=none; b=W70GCmCCuO83wNrNup8QxSw7p8lq7YTRm2YG0cDllyIh9VPYb9iD3LpUx4G8DfxwBLg4W2WYP+dJbrE3k8QYTsOPU0dT2Dxc9+5BxkSqt9zCRkMJyfKuM0yrqFYfxqvocLFpxxLwGxlDm3TrJNNwcSw4xiknov2aaB+NEBgD9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665639; c=relaxed/simple;
	bh=LcT+oHMQlwuJM0JRrDpUvgr/2G6TUu3muYsMiKmIHBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6pkQeb8GWxbD3XDFUhpFzkb31syg96YzOrkkoFIjHLjJ7d+HlPhOCFZOVEic3C27whHEXtliE9YEVhdAvwM+1IgBlF7D0q+tUowzduVnSy2b3xd+pkCrdA+EFtTOlsAJ0hWJRU7XYzj2l/JxhikngEZIXDdXV29iGajk/69pvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EF8PlarZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bjgiYD1C; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EF8PlarZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjgiYD1C"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65AE8114016D;
	Fri, 11 Oct 2024 12:53:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 11 Oct 2024 12:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728665636; x=1728752036; bh=oYEefwVEaq
	sRfSUEnBvT9FHPJKPKu9szGoZeeAoAARc=; b=EF8PlarZxRyFl5ArRIHta2nhz5
	hIBqDwVbmRui/HjSveEKvKap+oedvQnNAj6me5IphJTw0ZbsEhutt61t31T5A5kl
	o0LLLephWQrrp+WWR9GudTzIaY67oXj7bOTK8hg9yOxKush3zTwmvpv/TgiVbtj7
	YPR2Np0lp/alGub39qF4+leHpAQSBEZaHplVLRggwKrfXZIXbYpZlWlpi8CHnnJD
	AITMzyiNOG82DTCZxDkIwXLa+bsnUYu8feWPKhnqRrsidb9ihgSzHnEcUyU5+TOu
	/ZGlpfSsiy2v0GcLAyLwliftU6+u/94jtpbFYAiRjaxw4paoQi5BHIrMEcZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728665636; x=1728752036; bh=oYEefwVEaqsRfSUEnBvT9FHPJKPK
	u9szGoZeeAoAARc=; b=bjgiYD1CnayOMSrWyo3r+k/u0bRn+SwtIsITfzcJ549P
	Fwvck9orUhi1lgD8G5lmjqPHQh/WB/5vSK4TFoIvH0PlFqst02Bk2aWEFr+PrboY
	pIsq3bc3FxSch88NI8cMMBpIPCkKp6sZro3Z8xpPp85iD4uhL5ap7xVqgqJdbvV0
	I/Hm3hInOUnQPTMN1+zTGUvryG7cliDAZZdwRE3XrOk2L6Bp2OJUHGU5NAydTA3i
	JC+5nAGDT2agDDfAik6xXxKs0Uq+vUigzsrsoBNMe/eMFSOoX1Ok5z6yeDoK/POt
	YxFFZgRL0HZm//X7kWM0hCyuXU2JT0W2KJE8zUp2GA==
X-ME-Sender: <xms:JFgJZzL5sW4EMZ7A03m8ljvgxX4GiZ0RaU16hiuXXR-UVBFOeIxYNg>
    <xme:JFgJZ3IiuGXH75EmKHKv8hBQNo2ApIBxrBwbgTnscYIQwxgBNMkv32VAsaiLFwdPM
    1zY48UZC0Au7I3guQ>
X-ME-Received: <xmr:JFgJZ7tu0VL7gWPhnA7sqeyX9gVkl2_3bx7THzLAPZMkfdZy749pOuviL0MB7gmVWweSauAFmsQZXvx731btMFlWwV2NEb6vBlOEgAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JFgJZ8aT7-8m5cAUDoi0753hwXuY0nVliaFStCBPd-VDdaeYoIAGTA>
    <xmx:JFgJZ6aTkZJcjj4UruiPylO4ZJdEWQH5Jr5i-QPHSg9GnUQL045idQ>
    <xmx:JFgJZwCekcQHM5Mlkam2gnqKrmz9PJjVPYBv1bW8nstHdV8xNxzU7A>
    <xmx:JFgJZ4bXkaByCEKKp-zR3JzxUUi1I1SjoT62pXaiXuX-JYqLJdFe_g>
    <xmx:JFgJZxya0zHrSvqs91Y3hJIVo2Dxuwbr1XhbMY-CuStmwoI0UwaNIIFA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 12:53:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 09/13] git-curl-compat: remove check for curl 7.56.0
In-Reply-To: <ZwjYinN7oKSw2DIq@pks.im> (Patrick Steinhardt's message of "Fri,
	11 Oct 2024 09:49:30 +0200")
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
	<20241010235621.738239-10-sandals@crustytoothpaste.net>
	<ZwjKTJye2OmQClSW@pks.im>
	<20241011073326.GB18010@coredump.intra.peff.net>
	<ZwjYinN7oKSw2DIq@pks.im>
Date: Fri, 11 Oct 2024 09:53:54 -0700
Message-ID: <xmqqwmiefun1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > I wonder whether we want to have something like the below patch to give
>> > people a better error message in case they have a version that is too
>> > old now.
>> > [...]
>> > +#if LIBCURL_VERSION_NUM < 0x073d00
>> > +# error "Your version of curl is too old. You need to have at least curl 7.61.0"
>> > +#endif
>> 
>> IIRC we ran into some interesting situations in the past where some
>> distros had older versions that had backported some features. So Git
>> would continue to compile, even though it was not technically the
>> version we said was needed. And a patch like the one above would break
>> those systems, even they'd otherwise be OK.
>> 
>> Now possibly that is a little bit insane and not something we should
>> worry about. I don't have good examples of what kinds of things got
>> backported, but searching the archive for LIBCURL_VERSION_NUM and
>> "backport" yielded this:
>> 
>>   https://lore.kernel.org/git/4d29d43d458f61c6dabca093f591ad8698ca2ceb.1502462884.git.tgc@jupiterrise.com/
>> 
>> and I seem to recall most of the discussion of this was around that
>> author and RHEL/EPEL.
>
> Huh, interesting, thanks for the context! I'm not really sure whether we
> really should worry about such weird backports all that much. But in any
> case I'm okay with not pursuing the error.

Yup, the runtime die() would work it around for such versions of
libcURL with silent backports.

The message should be made _("localizable"), though.

Thanks.
