Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC0AD23
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730421687; cv=none; b=DXdo+q8Z+aEuFRfAbNwbrwWsKllBUSlyHy2D86ZY9GgBdQWWeQWgRkjNSBUMWWFgqnv1fWnaCfZNATyu5OASWiPbB78z9lbbjuou1/2CSawTMFctMLYqjdZZlsRzLUKtxzIKvvCWDuBwfYeoNjlJoh0H5XolK1T4uTVpv4ufkhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730421687; c=relaxed/simple;
	bh=sQj9fUnnj5DJmVrFabavcUv8uEPMeRUntEPVs5+5f14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tmle21zErMUlj7zbPdG/9/fxMxlUHiRt1mPTZ9cZCQ2t4+pynAjimupMSHSx9ckALZp/Tz9he0rIDvDL9A9lDFNMU2L8CSz736a2iPcswTg+W40Nt30wJCcS1ByHp4G/2FGrXi0qBDsdaOf1uUGlxhynjowSmog0vtTJ3jcctnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zb37xqWr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IS+Ad6FK; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zb37xqWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IS+Ad6FK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 947381140094;
	Thu, 31 Oct 2024 20:41:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 31 Oct 2024 20:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730421680; x=1730508080; bh=O9bHpR8ZvL
	UikMHaEFcsdC8dmgET+wlTm/y2vg9ViEk=; b=Zb37xqWrGrv8Z8B3RwMsnnoSDb
	EmqK6fZOcGMpg+N13xoaGL41ZTNOKcTCYS34EMLT9tCR7xlhIEriiXU1ZG3IcQ/p
	UVJ4SGn+r27sSoaj6LwWFjHWUsnmNUWjhuF3ru/K/DlN30EgWtyu6fUJIIFP/gG1
	87O8dBOWC91+l+h1zGLdepvDGQIQCEzTmRqXwJv8ByVDGy7ot5aRD1nRfBueuo14
	lWl+9icovm4I2cX4QY88bJ5VZscuqvpVcaKck5HJrADMIrDRhbBn43q/zIHJYdmD
	+lv+4CsM+ILd5mrhyEM89pWZxk8/Wf0JxLiD9Q5da7L8PSYiMT8JFNfHDopw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730421680; x=1730508080; bh=O9bHpR8ZvLUikMHaEFcsdC8dmgET+wlTm/y
	2vg9ViEk=; b=IS+Ad6FKkree+/j1GDVpMCK/VWINcQMlsH7LmdBOwQ6kI1elnhE
	mMjtMzK4VHi19F7RnPe9nAJnZcubkGn5NPKqH/poI6D1wPLr7U/p9jbR/o296yPl
	8MghmkjriEf7SPbninLakc5lDwYWGcYOXan1vZV87b10gUi7Eyk4ok6yMA8rwgl1
	V/B03o9S9aNGX340xNNFBDpttTSeLEZpOMnPUzZts/vqH4pEsOm6jE+MMaXPd6QZ
	j0iDUd3pQAiIa0V5qhUzCJj1K1B+RZeDkIUmufWpRH0SQWFzslqtfMfr1I4BfK/1
	qpgLvLGOGx6r/NOyipjrM8VLJpjzQqEpgnA==
X-ME-Sender: <xms:sCMkZ7gMMj75ZyDofQCDGjbW67_KJoW4GukOx4VJ7G2gn4PCTJ4QbQ>
    <xme:sCMkZ4DWUgTnscL-n2mSefnYWUn4VWbfzAeTmbeoHahRg11yLeJktwZ9whaGZ5xeK
    QGR-j6jKeKgL8LMjg>
X-ME-Received: <xmr:sCMkZ7GsXPmPyokyi3LhMOfE99PCbr34GAMWP8YYC4NAkFvsOoj3YwagdGEbhY3mn64viy6sSXvJmNivvCIr36VMuxJQMYuXmQYj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:sCMkZ4T5q2Wy0EmMH3c1xQoyWaBNaQbW20AYkImpTPqFnHfL79iaHQ>
    <xmx:sCMkZ4yZWYYHnUfuKDpe9stAxqZLh6Hho5fHdEvzGZhGOrixWzc9DA>
    <xmx:sCMkZ-7EECre8MBG0fOwZkkcqqAZJ3tYFTA-mXzZiBgK8LTYkCNYPQ>
    <xmx:sCMkZ9w-F1ypuYDJjjWrCCTieLWT7H6vM5armeYGr7L_FgYAhs_hRw>
    <xmx:sCMkZ3pzHZ8O2bl7zcqhXRwuCibmsAiMCxJX0hb9WRX8DzCacahyS0mN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Oct 2024 20:41:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Taylor Blau <me@ttaylorr.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/3] ci: remove clause for Ubuntu 16.04
In-Reply-To: <xmqqv7x74ws9.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	31 Oct 2024 17:34:14 -0700")
References: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
	<20241031234934.3451390-3-sandals@crustytoothpaste.net>
	<xmqqv7x74ws9.fsf@gitster.g>
Date: Thu, 31 Oct 2024 17:41:18 -0700
Message-ID: <xmqqplnf4wgh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> We're no longer testing this version and it's well beyond regular LTS
>> support now, so remove the stanza for it from the case statement in our
>> CI code.
>
> Something like "we replaced it with 20.04 which does not need the
> corresponding special casing" would be necessary to explain why this
> is a good change, as opposed to an equally plausible-looking patch
> that replaces 16.04 with 20.04 and otherwise keeps the "stanza".

Ah, I take it back (or atleast a half of it).  

We have been already using 20.04 on the .github/ side, and 1/3
removed only from .gitlab-ci removing the last user of 16.04, so
presumably this has already tested well for 20.04 and there is no
need to add "corresponding special casing".

I'll keep reading the list backwards, this time resisting my
temptation to utter nonsense without thinking much, attempting to
catch up.

Thanks.


>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> ---
>>  ci/install-dependencies.sh | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
>> index 126e570eb4..d30ae53a18 100755
>> --- a/ci/install-dependencies.sh
>> +++ b/ci/install-dependencies.sh
>> @@ -55,11 +55,6 @@ ubuntu-*|ubuntu32-*)
>>  		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
>>  
>>  	case "$distro" in
>> -	ubuntu-16.04)
>> -		# Does not support JGit, but we also don't really care about
>> -		# the others. We rather care whether Git still compiles and
>> -		# runs fine overall.
>> -		;;
>>  	ubuntu-*)
>>  		mkdir --parents "$CUSTOM_PATH"
>>  
