Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1459191
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059167; cv=none; b=lXPE2rTtAUelVxYIdMIqgfqxvK/7ExXMo1lE5/LvgtTKr57oA3tPqgg7H+PMexYCIE94EEPDRh2j+qjjB1qAiUc0yWoL/dNidv6aeN8h1SsOHLStyxwvY/4zzNkH5lw9K6m0F+day/PCaAzWjnWGGXxjH/D/uMspKrLj7aWM+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059167; c=relaxed/simple;
	bh=AehCWvlN19vinD3/4ettyijZpj95wyo3C0y5YgQ8nmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f4Pk6H6Z5wPJ0KA7SHF00FP5zHrKPW6S4OqO1DbtqyzNC7dMiP7k03TwWad8fJjfyrXSffLFADWhLIxAeZKffIgBZ1FeRTwA+9CxvvlQckTxFlbyvFbdjt7ZnZeK6SvlyuJfDCZZEO5e5kX8coez+PF1uqY3M2tYgNs9c9kXb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QvZ063Dc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o/NZeCV7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QvZ063Dc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o/NZeCV7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B819C7A016D;
	Thu,  9 Oct 2025 21:19:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 09 Oct 2025 21:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760059164; x=1760145564; bh=9lR0Qa64zO
	5aU+Ebf15nByfNj4WusjTcHKBzpSoDMEc=; b=QvZ063DcEIyz8rDvu1E1Ma0laM
	Y6u15qAjf4As9vmy1cxNhrWHCbSUg1+3O4Bkr/Onk0KAryr7lRQexUbLK3jZRlXR
	8F8BC2eegKap8KqYcYAwiTT5A+qEzGemoGHf1L4njbSe1eN2ExlUKkSWF7oC/d6L
	jwrRPOOlDOL1thbrGm+w4LvoEGSnvePjQB59UH8Mbe/fPS6CcB1xsVyWZ7KQe26w
	i7V6JaTTx0NyPuFA0cOQVm3iUyp7Ym+8YYAVumxHZqDxd6H2G8UwAkoXh53PT5mz
	yby6hmH5XIDsdypAHPHyreLFLYPvMuO10kXyu5z6TXGnImvkkyoBLNel5iaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760059164; x=1760145564; bh=9lR0Qa64zO5aU+Ebf15nByfNj4WusjTcHKB
	zpSoDMEc=; b=o/NZeCV7vEH/5nvMvercHAnZrRJJS7rmslpT6XN1dPAzOSTvm+t
	/ya9VW+5AAa2sACUS9nU+Lcu3t6mdR4n56OvFJVFg2QGeL2ixLh/wqIHljDmgmza
	icp4FLP2+VID5o70WMomp2uKe90ozZ9cekpB0e0Ikskorlfi+kjZE1puASyKO10W
	6+Mxn3FN+/3VNGPagLh2WuUskRVHyc+U/A6cWegtXpU1q2OhvhySb0BdJvPPVnkK
	hBG9yc3bmpliOseU9SmYvDFhtpVplKeoYmcFtgsn/yIeTOHPUo0RKHG8CVeSZRNt
	N0/3s+BNWcyfRQni+mJPzIlFiuOdLp2AUJQ==
X-ME-Sender: <xms:HF_oaEwuJHlJBijAv-No1fomNcf7eTu-4z_fQQOFOjgMUR7PsG8fZg>
    <xme:HF_oaAcPgm6lJCrOJPJXcC4ph2iH4NdcaYiFEouDPPuuOrKdg34LKJYl95ZGjlRF1
    4B5jTr5SePwsWb462ntq_xqyqDAf4mU0HMALbMF7_8DrsgCw22Eog>
X-ME-Received: <xmr:HF_oaB5yz1yYqOuVFFXf68PGclalrinIGRuWReTgYW3aUonjxz9PStYj9VxYnhZ3QQY1ELLh2xSEuthC9I557O-Zy_0rZqmsJW7z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepthhm
    iiesphhosghogidrtghomhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:HF_oaNIQ-37ETmnPAj7pQrUxqouJTVCsovWK2EEKPORf97Sxljb2OQ>
    <xmx:HF_oaBwZ6Ta7I6yxBhefcRCg1aq6Y1SGnuAirXitVK9xXCJrpeQoHA>
    <xmx:HF_oaNKrgzJmuOMhXY_5Xn8jMvNKlYpx_qtQ02H1eBtHxkd5jkLRaw>
    <xmx:HF_oaIXv0R-z0FS46X3PXpkxEPFos_-jh1hiwAIOCviBCFKNmedm8A>
    <xmx:HF_oaOHjLqMUO_2NJ9z-zla8wC-ejAA0iileKn4JAAG6VpBdWy-sDDeI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 21:19:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Todd Zullinger <tmz@pobox.com>,  Collin
 Funk <collin.funk1@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/5] doc: git-tag: stop focusing on GPG signed tags
In-Reply-To: <20251009122457.1273701-2-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 9 Oct 2025 14:24:53 +0200")
References: <20251007122958.1089680-1-christian.couder@gmail.com>
	<20251009122457.1273701-1-christian.couder@gmail.com>
	<20251009122457.1273701-2-christian.couder@gmail.com>
Date: Thu, 09 Oct 2025 18:19:22 -0700
Message-ID: <xmqqsefrblk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>  -s::
>  --sign::
> -	Make a GPG-signed tag, using the default e-mail address's key.
> ...
> +	Make a cryptographically signed tag, using the default signing
> ...
>  -u <key-id>::
>  --local-user=<key-id>::
> -	Make a GPG-signed tag, using the given key.
> +	Make a cryptographically signed tag using the given key. The

Given the above ...

>  -v::
>  --verify::
> -	Verify the GPG signature of the given tag names.
> +	Verify the signature of the given tag names.

... it would be more consistent to say it with "cryptographic"
somewhere.  Also what we verify are "tags", not their names.
So, something like

	Verify the cryptographic signature of the given tags.

perhaps?

