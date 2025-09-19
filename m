Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB421ABC9
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319688; cv=none; b=WGEtM0SwaSMMWu2JsKUHFrAMYTC0rPClYLVQvspyCBniVpV35+klMP9nA/UlxOT74TJIG4nuRuOcI1kcd1wlNBhPYH0wRhuxn/aaVQoIhn/7x9XuMShBRS0X9y+WmmPBq6XZxNGAvc33kBAEHEPJj4CtExlgi6kTZ7og2Em3/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319688; c=relaxed/simple;
	bh=XSpB6ALyyapTQNqkrEK31hWTKT713Btqng6YelQ//NE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hN+Bt0If1iBCKw7jmAMKu2cXq0gcNbu8y5TIqkksJe51BsEOzI42Y5pi7U5/ImPT1VysZJr3Jl+MnbQiOBiRxf8Y4QXlklMSSg0J5atKmiw8jhjLYjxWbJABPuDahWUnnqI2zw2BNdBWapvoXy+uezMC4QHIL3M+qye0xNYYa6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nBVM4gxt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m7bICfTs; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nBVM4gxt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m7bICfTs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 344291D001A1;
	Fri, 19 Sep 2025 18:08:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 19 Sep 2025 18:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758319685; x=1758406085; bh=UatbZdgx64
	dLXcjJX3u19QCfT8Xw5M1+I9PqUVupKDY=; b=nBVM4gxt77K/piGHr4+KIXCYTQ
	UgLcW8ck2G3qMqG12M1WUXhk87byhySQgEpOuU31dELrhoTTm+gCbBnO4l9LIurE
	ZN4YBZeV/K1nlyUZODfkx4WTBQdizlNWXhsx1Q5y1GjgismfIpNYFu8Y8GDWS1f6
	gy9uzL4kLeC4vE7Df5VDNT5psHLZdz3Krvyh+5AncNrp5n06jrmpWGxbJVs0OJlK
	5pRPQMG9KPXbL0uhSLo5GbE6pCQWWtb4k7mSd1igG+tL3fXSW0Eu4TP7M9dZiycr
	D4y1Hu9keXdIqs4gX5+UpNK01qS9HbZ8fPyDqvWDR2i37xrojjhzaxAj0reQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758319685; x=1758406085; bh=UatbZdgx64dLXcjJX3u19QCfT8Xw5M1+I9P
	qUVupKDY=; b=m7bICfTsUXXNwJ98/6/n5Go5s8Wu888xaM7D8gvkgDxjWzRkMyn
	JDPpt3Tjxn8iGkss6uhhrViHIv/s1oqDd7MDorMVrmV+lQEdt0n/sEdGc4QdBpla
	vNriBc/cNgtf6NbgVtlSGnJyuokXK18x9kx72BgmZCKAGggeuhXIF9gShx/4HbzU
	os7MSy1z6DiN0EIJrks0EqM2OySAQBoB+xDxjwe8O7V4rO6DuouI3BLugjxnp3WT
	ui2h5/6N3w6E34YuQAbj+iw+0/1FLz6F7rI66dQmyEj4fhiCMUV1wal6gewwtet8
	XsF3hmKIli33j4PdCsR+BqvmaEUl9+gsz8w==
X-ME-Sender: <xms:RNTNaMGhA6pVZ-uB9-Hhn07DxPE2g6pH84FYd9olQqnSGVoEzVOC4g>
    <xme:RNTNaA3Y3cWHvqkRcU3y0Y8I8_AOFDuIzLOE_xPio9gnN5HoNAqMv9hVwWedIiicq
    ceFi9gjBDzLqF9GVw>
X-ME-Received: <xmr:RNTNaMnVLYd6N4TOML_yu2uE69Sp4RmqnQOKA8aOPHw5gk8X_C29elMiyHB1W_t4AvzDHNkUkoklG0d35O_OOqdEU52NtEvbolJR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RNTNaI9Z-FRjzhT9bvlyfKODn5F6NgbMXwwKxqczxi4kDdmox41AfA>
    <xmx:RNTNaJr1BOQ6xueLSLw0FnzwKYG0OnHmWEk724Ax73fOchI5NvWiuQ>
    <xmx:RNTNaJk29tbQ3n-Q81RKJDrUX6d_DY4eOiU2zFgY6oU2vd6CNb4g7g>
    <xmx:RNTNaIj2X7bm88aBAPYYZow3aq3UpLKkaVuxwz7URvMFHfnUJ7JJCw>
    <xmx:RdTNaDG9_wHSjPSoVFGNuGqMejTj8yxztl4nAB3rS9kS4jkFP2eyfG_u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 18:08:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 1/9] docs: update pack index v3 format
In-Reply-To: <20250919010911.649831-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 19 Sep 2025 01:09:03 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20250919010911.649831-2-sandals@crustytoothpaste.net>
Date: Fri, 19 Sep 2025 15:08:03 -0700
Message-ID: <xmqq7bxu14fw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Our current pack index v3 format uses 4-byte integers to find the
> trailer of the file.  This effectively means that the file cannot be
> much larger than 2^32.  While this might at first seem to be okay, we
> expect that each object will have at least 64 bytes worth of data, which
> means that no more than about 67 million objects can be stored.
>
> Again, this might seem fine, but unfortunately, we know of many users
> who attempt to create repos with extremely large numbers of commits to
> get a "high score," and we've already seen repositories with at least 55
> million commits.  In the interests of gracefully handling repositories
> even for these well-intentioned but ultimately misguided users, let's
> change these lengths to 8 bytes.

Very sensible.

I do also agree that 32-byte is the natural size for the trailing
hash, but I found that the two paragraphs below was far more than
necessary.  As they argue, we use a truncated hash anywhere in our
file formats, so I would have understood if the explanation were

    "20" in "A copy of the 20-byte SHA-256 checksum" is an obvious
    typo, as SHA-256 is longer than that.  Fix it to "32".

instead of these two paragraphs.

Or did we mean to use a truncated hash back when this transition
design was proposed originally?

> For the checksums at the end of the file, we're producing 32-byte
> SHA-256 checksums because that's what we already do with pack index v2
> and SHA-256.  Truncating SHA-256 doesn't pose any actual security
> problems other than those related to the reduced size, but our pack
> checksum must already be 32 bytes (since SHA-256 packs have 32-byte
> checksums) and it simplifies the code to use the existing hashfile logic
> for these cases for the index checksum as well.
>
> In addition, even though we may not need cryptographic security for the
> index checksum, we'd like to avoid arguments from auditors and such for
> organizations that may have compliance or security requirements.  Using
> the simple, boring choice of the full SHA-256 hash avoids all possible
> discussion related to hash truncation and removes impediments for these
> organizations.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/technical/hash-function-transition.adoc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/technical/hash-function-transition.adoc b/Documentation/technical/hash-function-transition.adoc
> index f047fd80ca..f2df1d618d 100644
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
> @@ -276,10 +276,10 @@ network byte order):
>    up to and not including the table of CRC32 values.
>  - Zero or more NUL bytes.
>  - The trailer consists of the following:
> -  * A copy of the 20-byte SHA-256 checksum at the end of the
> +  * A copy of the 32-byte SHA-256 checksum at the end of the
>      corresponding packfile.
>  
> -  * 20-byte SHA-256 checksum of all of the above.
> +  * 32-byte SHA-256 checksum of all of the above.
>  
>  Loose object index
>  ~~~~~~~~~~~~~~~~~~
