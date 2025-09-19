Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BAF86342
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323804; cv=none; b=Rmu4kFyvElazxf5akqRC4NwFvpZ/0OS9fkXAdntxNl1XDHuqQ3H4s6AwXOmvZ6++bN+xWjAyAnjeKaPmM1mFi/Ls9A6jqOooPbczhTaat39Y1umac84ddHyBDMlx6YRnwrjshQV7Dfhrsp2nZqiKEt4k/FxeDefi4b0VRtD/gBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323804; c=relaxed/simple;
	bh=mrwy5xuj0IZVuHEcx8FCzwMpc+nD5nqFWmJ5yPZ10RE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E0I59VNJUF/I7rsG+kEW2PdRzEse6AvOenNt90pBlV7m5cUi8UE78aXfVkqepET8qDKhwXdFJewweTVlMX+pZ7kC6bzxXL0mB2lukK6UA5MAWAaAlugGK9I7mqat8uxcTc0T5JxD+4bt6UoD/Wz2MdeQrojIQ/W/awiRlbrKPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OlrHgPI5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VUXUoF/z; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OlrHgPI5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VUXUoF/z"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D23D7A01C4;
	Fri, 19 Sep 2025 19:16:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 19 Sep 2025 19:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758323800; x=1758410200; bh=+Ahbe0oPfo
	sHg/nhO68aSWZ9TMjQlOV+jX47U8Q6B8I=; b=OlrHgPI5+vxK9SHdeF3l05YPb7
	1Zh8XIAatsK/aehqBoYr3XWxk7Grq494Uu6qJzbg13sev7xmIk9rWBGTMvZynF6I
	a1oYHfvpz2y4k80zhSNyFAbPbXe/txM7n2MpfXaBKlpU2e8KAkiRTy9fush2mWIC
	MosThcABf6f4j1ypXyw77assbTS2SxEdqkQ6pybkDKdPXJK6squsUkcPQmanUTgd
	znMQCeWe7ENKtb+Q9gycuNVC+4wz+DP4gUvNqhUlVCMMxmyYfka6BU0XEXDzi/r2
	ijo4+AIY9CwwMEkHO7tns5oSb3OMI4x3p8LHVj50CJEzJ3FbMGZ5MW4Paavg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758323800; x=1758410200; bh=+Ahbe0oPfosHg/nhO68aSWZ9TMjQlOV+jX4
	7U8Q6B8I=; b=VUXUoF/ztmaJ4z/aVRel9VLdUmIYRwXAn8Vp2xxiAQGkpINtuYJ
	uLANu/Wx4qxMlR33haJGRRvWlriQZPodtkuDPhTfSqLeFnQEEvgG8CcGVkv6OMPh
	V/jJXljKK7mmiQ0NdYyVKAmV33xcsQYpvI64AuycYfpVALNgZoFCNQcape/+8pro
	XEkvHMItORSL/E8dLqpUUB8Nf5thpnag+702aBT0mjKn0NLC2R4NJjbKThNq10zK
	6Lje5XLgsrg40aZLAbIlqjK4T5qcZSlWd9VXqNAFiaTvdOZKv11yZfZtpeLygpne
	Ats/lUtNTej1eJuIOA1vRwyNSM0b9428C1g==
X-ME-Sender: <xms:WOTNaONAIMAGv6Rxa1rTtADqI03hDS4QRwIXi46wxf9pM86wvzSyDg>
    <xme:WOTNaIclXhbtd4ykXyXiVei1-6XJxQ8pozjKP58zpzPiFBkPGu7Dn42zU1_t6kaMW
    fJAx3q5KW_oGXSdAw>
X-ME-Received: <xmr:WOTNaLtu4kvYVyZFD6HjL6PGMRslRceTXqTiGRbcuH5ixp6GglGYlIBTR8Hs1QrOSEFY0NgnQtzGS9xUgO8ZWy3EhzE0PwuRKQXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdehtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:WOTNaJnkXjJYF6d59gKeVAf6Kmskvalybj-ZuA2uR8yUvhbczFm9eQ>
    <xmx:WOTNaNwk0SIKzmTIJgNeCR1TxIDFCa_76WXNfKRA93UgPdS0UBh35Q>
    <xmx:WOTNaLOhM9McaqullOg0Hj7HONB8HB6hOahRSkzWvCPxZQJS2jhwAA>
    <xmx:WOTNaJrst5LgKJzwKH0EVbE-3CTtgd3OFyKIaaFLqGp20pN4UCJaIg>
    <xmx:WOTNaPzUwRILSvAHENVkv-LSTt8P8QzJ7_7pJTWl9Ai2ZNakd-3r0TnH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 19:16:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 5/9] docs: add documentation for loose objects
In-Reply-To: <20250919010911.649831-6-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 19 Sep 2025 01:09:07 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20250919010911.649831-6-sandals@crustytoothpaste.net>
Date: Fri, 19 Sep 2025 16:16:38 -0700
Message-ID: <xmqqms6qyqw9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We currently have no documentation for how loose objects are stored.
> Let's add some here so its easy for people to understand how they
> work.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/gitformat-loose.adoc | 49 ++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/gitformat-loose.adoc
>
> diff --git a/Documentation/gitformat-loose.adoc b/Documentation/gitformat-loose.adoc
> new file mode 100644
> index 0000000000..c8bef606fb
> --- /dev/null
> +++ b/Documentation/gitformat-loose.adoc
> @@ -0,0 +1,49 @@
> +gitformat-loose(5)
> +==================
> +
> +NAME
> +----
> +gitformat-loose - Git loose object format
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +$GIT_DIR/objects/[0-9a-f][0-9a-f]/*
> +$GIT_DIR/objects/loose-object-idx
> +$GIT_DIR/objects/loose-map/map-*.map
> +
> +DESCRIPTION
> +-----------
> +
> +Loose objects are how Git initially stores most of its primary repository data.

"most of" is a bit misleading, I would think.  Those who start (what
eventuall becomes) a large project from scratch are only minority of
the users, and all others start with "git clone" from elsewhere, and
in the resulting repository, Git initially stores most of its data
in a packfile (or two).

I think it may become a bit clearer if we drop "initially", and end
the sentence with "data that are created locally", perhaps?

> +Over the lifetime of a repository, objects are usually written as loose objects
> +initially and then converted into packs.

This one is good.

> +== Loose objects
> +
> +Each loose object contains a prefix, followed immediately by the data of the
> +object.  The prefix contains `<type> <size>\0`.  `<type>` is one of `blob`,
> +`tree`, `commit`, or `tag` and `size` is the size of the data (without the
> +prefix) as a decimal integer expressed in ASCII.
> +
> +The entire contents, prefix and data concatenated, is then compressed with zlib
> +and the compressed data is stored in the file.  The object ID of the object is

The glossary calls this "object name", not "ID".

> +the SHA-1 or SHA-256 (as appropriate) hash of the uncompressed data.

We should clarify "data" in uncompressed "data", as we earlier said
"prefix and data concatenated", it can be misread as the payload
alone.  You have "The entire contents" that stands for "prefix and
data concatenated" above, so "has of the entire contents" may work.

Also "uncompressed <whatever you rewrite 'data' with>" at the end of
this sentence should be followed by "in hexadecimal".  The "first
two hex characters are used for fan-out" etc., depends on that you
do not use binary result of the hash as the object name.

Thanks.

