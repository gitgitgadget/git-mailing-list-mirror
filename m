Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F7E9460
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510857; cv=none; b=Bj5nmyM6myUD36xH38HYCnJF6V0WbSMzN6BYi8Hif3M7p1u0Z4TNTgm/btLVaq4AjBQLfywk4KCJ9bs6GRGTfR2A902CW8OvWVw0r1Q7o1zvBiUcJ1+oIz6pTvVhJoNHSA2/aNZwdePYlR/4GkwkMk8tIozjw2aQq66wC9tfbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510857; c=relaxed/simple;
	bh=z3N9w8SOggJI3PHSI9paehiLid8kD3PTeBYQ8zr0pE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tiaDgSiQ+RE7W6bZE5oyExnv9AM3rabGyK1i8NJnSD14q16h8StzM0AFNvdk82Y1QYxSyIBlUYsGqDDgeHe9r7W15oHj2inATrAEiccYhAPjWiv1XYFW9rnZetRNYPayTEJNubLmYrTSd9/cxarNP7XAPPvfHeDMyEs/UsCzTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IH4Qrsg8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rr6zRxXk; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IH4Qrsg8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rr6zRxXk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id ADB73EC01F9;
	Fri,  3 Oct 2025 13:00:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 03 Oct 2025 13:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759510854; x=1759597254; bh=zC/JwjDWFN
	8g0IqJ/Lm6lLFsezMax2egoMXFycSJ1SA=; b=IH4Qrsg8+D7s+Vh+22SQhQoKAr
	gHouUs2KzisCIKfCei3iZOHAAxtvQjSgxEs6RkXsMGe2K6vEELocFW2vT8q9pisd
	WCEoomM43VaxgDQbwKXLXBl4jrJ9ccZ9eopazdTX8P7zDSWGDDHM7iZ07Yfu2f1B
	VAXgKPWNyd5hbGSRAdnyR/Bfx0k2xOzUOxKtu4jboYM+0LGVCVubDxbi3Sfvrhqm
	uplc+6ZyJPrRM/HjjQcdqeZnKLNSq89QDjXvseZ0W8sNldYFZ1CqmryhQPHCQNXK
	ZqJOAfh/28B80E5GPDq8h0TIKz7UpG+QmYjjeyROtXseU+Ic6HGA+buEe4FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759510854; x=1759597254; bh=zC/JwjDWFN8g0IqJ/Lm6lLFsezMax2egoMX
	FycSJ1SA=; b=Rr6zRxXkVHSmFffJrPG+85RFw3yQR/gY5cPzTGyIs1a0GXumtWE
	3YwP1EKosEZoqV9UBG7P2sWrt1d3CzxFlgDtmcQU1dReR9Zfp2CN7qDpjQulpag6
	8d9ZaxJRvjsgBmZpbRsYDnIeu2Sukv/GyzdXaYsnj3ChQAz0DE7oceuqUk9xUVil
	PQ+U1JG9vH2WhIqZIDfc6dGmFiUmYebDpB8sKqde9KCjh1BtCfUgfon0eo1Ketwn
	LrYRixAMRdd1y6UepHOLExVuPfNZqpIVQiNbrI/aslZ1ZN86elgVtAuOqh18Y3mD
	TPAfCszBjShT8+00BoJFTjdnGrDZH7iXKuw==
X-ME-Sender: <xms:RgHgaErgj00vmjYl4e7L5kvcnf9tH_hsiJRKBGnKEsSuPuvb8NtbTQ>
    <xme:RgHgaBq8K53U9b90MKAGTs9qnKv5sVakvGheUa3DJm9RfVYHDQ96yyXEafcJYVlhj
    RGaZ_HVSNlM8FQ2n-jXj2mR7aUHR_FHNo9dqSTBn1yUa-5nBTDP6Qk>
X-ME-Received: <xmr:RgHgaOOAgJiF3prcAu8gBJjbP09fKN5oQ4Nc-TqtmkmDsHrXt9IpaZbai6lD8MP46cCvZ2DgFveHtYv_NXELqtAAG95qdNuxKr0V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:RgHgaKzg5uaNu_Jn67aXWpg51uW2H_CJzC5yU5PZod55XqcoXWbL2A>
    <xmx:RgHgaPtm-bE8JSkTyq-lGBVJ5MS7vdDq6edBUWDSc1oGLIdEzjTz6w>
    <xmx:RgHgaL6osMGvLEjxwjT3u8t3yG1mXGyKiLkjC0QPSpwSgZ6pcAMw-w>
    <xmx:RgHgaGSg5QrcEBBxyOS9pLrOjAubn8rkudr23Nz8zobMCWWAMppKBA>
    <xmx:RgHgaEx9pzH_ZWgiD17dmNrj1ynukNsfmFGcCSnj-AmHQIVTNpbYcvKZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 13:00:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/9] docs: update pack index v3 format
In-Reply-To: <20251002223855.1022847-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 2 Oct 2025 22:38:47 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20251002223855.1022847-1-sandals@crustytoothpaste.net>
	<20251002223855.1022847-2-sandals@crustytoothpaste.net>
Date: Fri, 03 Oct 2025 10:00:52 -0700
Message-ID: <xmqq7bxbvs1n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/Documentation/technical/hash-function-transition.adoc b/Documentation/technical/hash-function-transition.adoc
> index f047fd80ca..274dc993d4 100644
> --- a/Documentation/technical/hash-function-transition.adoc
> +++ b/Documentation/technical/hash-function-transition.adoc
> @@ -227,9 +227,9 @@ network byte order):
>      ** 4-byte length in bytes of shortened object names. This is the
>        shortest possible length needed to make names in the shortened
>        object name table unambiguous.
> -    ** 4-byte integer, recording where tables relating to this format
> +    ** 8-byte integer, recording where tables relating to this format
>        are stored in this index file, as an offset from the beginning.
> -  * 4-byte offset to the trailer from the beginning of this file.
> +  * 8-byte offset to the trailer from the beginning of this file.
>    * Zero or more additional key/value pairs (4-byte key, 4-byte
>      value). Only one key is supported: 'PSRC'. See the "Loose objects
>      and unreachable objects" section for supported values and how this
> @@ -276,10 +276,14 @@ network byte order):
>    up to and not including the table of CRC32 values.
>  - Zero or more NUL bytes.
>  - The trailer consists of the following:
> -  * A copy of the 20-byte SHA-256 checksum at the end of the
> +  * A copy of the full main hash checksum at the end of the
>      corresponding packfile.
> -  * 20-byte SHA-256 checksum of all of the above.
> +  * Full main hash checksum of all of the above.
> +
> +The "full main hash" is a full-length hash of the main (not compatibility)
> +algorithm in the repository.  Thus, if the main algorithm is SHA-256, this is
> +a 32-byte SHA-256 hash and for SHA-1, it's a 20-byte SHA-1 hash.

I see a nice improvement over v1 here.  Very good.
