Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6992AD24
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323070; cv=none; b=EeAapgi61+tIlKtsR8+5BqjNs771qKRgzEZL12P8GzEw+Sh+cxOuRVEh/SuuDRQMwyZs/E68N1P0ujjTPOhR6AtYon7+r9Eo2+wPxjhVzchN+zeAIGnA46mzLEfASiH0PLMKRU2cZWaG8kkMn1fqa8hAHmPz2HvQWw1Wma4ms+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323070; c=relaxed/simple;
	bh=hE0XggUGvYmtU7pdtAbD8/ir6N4NKlcpwBhOdIcI9kQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hyFmtWT1z0gsVfneyyHUA1p55u28SXR7zY4xPTrUwBl3SIuIIuSw6wT4wz5rQzXDP7VyGxohhR12QZGu3QDEVhuJeI3Z3SrJWZ+BNKz1/2SsNs9tV21R8lZDwJb2EgA0cQa8spknnhuDQnkemKWPfKNeb1kIZWPk3fLOueRSqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uLL+VBDw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=By5wqvJU; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uLL+VBDw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="By5wqvJU"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 24D0D1D00128;
	Fri, 19 Sep 2025 19:04:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 19 Sep 2025 19:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758323066; x=1758409466; bh=0rUd/XlDlN
	50CMWxgomnFbsUjLYo2SK98e2t6ubCCjg=; b=uLL+VBDw/8sSab84+QSftLX3Cc
	FFdWaPfvxFgxL0CifcnMlCmzO45BAW34meerNN2LnLzB/Z7tdHHY90r6fcXV2KNO
	ytDYCCs8ft+RLUjT8pkTvbX2cf7hmMaoZaY1fv09WO8oFreuul0dEW5pGNhN/b20
	Du6hxLvSvmQlmYIE3JuVipAvas2jjDomTFWyTEzEePp5SeKuOnKnxh32upbzC3mQ
	ENzschEfYeDhj9Khs1l/UVmLqq4AB2x5amNDVEOVSME+mOV/t32z2E3wYnokN4n9
	41pO7cruGcDcutf+FoSw3IRzJS/ZNEyHGMa9p073surNYevqkjZwxxUPZS1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758323066; x=1758409466; bh=0rUd/XlDlN50CMWxgomnFbsUjLYo2SK98e2
	t6ubCCjg=; b=By5wqvJUhkTln8u9KyNZygbUEhqNW6lgop3DIRejyYNQwx46iaW
	Y0M1qWWymMzU8mrvQrjDIBfjkjBNiW4WNcpNBEzt8O69NsmKh+QP1HEqzfmEGAAg
	sFOizdoY8iKS5eTC2bkvAFBNFOeS6JXTeSe1bmQrywI1ROyEwzGeGo6c5BP3RLF8
	/A8XfvZDZrea/rretSYW3Zej5X6E4YnwplzTPzSVICiD9nR1aCpHkDBtKUggw9ea
	Zvz54lgKFFTdrBAYS9JU3KSo7aUCwINaoFtiUXaoBH/miG6ZFc5mdCrQZrARQLOO
	8AnZ6EpQHzlOvlsg9L08jcMYxN764cOnMbg==
X-ME-Sender: <xms:euHNaGz_pDu5MDdIoY1XkWAlRVs5E6hHPXdY8KTfwRsijLYCrGSXlg>
    <xme:euHNaNxbXmV1FsspHT3SiBPQfZavBrTrvyNWQJNI4F5B1x896ug845hLkfnNjZMlu
    gHi5KBxYKdy7kUDlQ>
X-ME-Received: <xmr:euHNaOzuJezUO7OTc01-98QLe7uKf6wGvRwrn5hJhNbSDLuwe18NtMJQVtB_S-3pP1UfHYPfVM_VW8dotqeD1aM7RPTv2HBnE0ip>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdegkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:euHNaHZ_dL-INQTzWsdUYYdlyNArjXOLgiAkQS2pUQyCV7W4X8QUMg>
    <xmx:euHNaPWi4gemDBB0ZwmdIJDYRnQPXCr1iJ5BbC_roFBp_OUhK5nS_Q>
    <xmx:euHNaFjI_P9x0pgxtDqzacNshGCVxNGsHXgLw5gbGONY_tE67ss4hA>
    <xmx:euHNaNueMRPJNhHNU7mOuqPBvUvh3_5HmkAZe_vWxqi8QL6Cmy1K0w>
    <xmx:euHNaDFFtpPHVgk2xd2YDfqtH-39NI-kuT9X-RkqUyI_lPlVjIBgSe1m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 19:04:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 4/9] docs: improve ambiguous areas of pack format
 documentation
In-Reply-To: <20250919010911.649831-5-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 19 Sep 2025 01:09:06 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20250919010911.649831-5-sandals@crustytoothpaste.net>
Date: Fri, 19 Sep 2025 16:04:24 -0700
Message-ID: <xmqqtt0yyrgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +=== Object encoding
> +
> +Unlike loose objects, packed objects do not have a prefix containing the type,
> +size, and a NUL byte. These are not necessary because they can be determined by
> +the n-byte type and length that prefixes the data and so they are omitted from
> +the compressed and deltified data.
> +
> +The computation of the object ID still uses this prefix, however.

Not wrong per-se, but I've always viewd that the in-pack object
header with n-byte type and length was an optimized representation
that stands in for the textual type+size+NUL, just like the payload
part also uses object representation different from that is used for
loose objects for performance.

And when you view the in-pack object header that way, "are not
necessary" and everything follows in the above appear to somewhat
miss the point.  It is not just "type size<NUL>" that is recreated
on the fly for computation of the same object name as in the loose
object form, but the payload also is recreated on the fly to match
what loose object would have had, e.g., a deltified representation
would be reconstituted into non-deltified form, etc.

IOW, I would have exprected the description to go more along this
line intead.

    Packed objects use the n-byte type and length in-pack object
    header, with in-pack specific representation of the object data.
    In order to compute the same object name as if the object were
    loose, the object representation used in the loose object is
    virtually recreated by translating n-byte type and length to the
    textual type + size + NUL, concatenated with the undeltified and
    inflated object data and hashing the result.

>  === Size encoding
>  
>  This document uses the following "size encoding" of non-negative
> @@ -92,6 +105,11 @@ values are more significant.
>  This size encoding should not be confused with the "offset encoding",
>  which is also used in this document.
>  
> +When encoding the size of an undeltified object in a pack, the size is that of
> +the uncompressed raw object. For deltified objects, it is the size of the
> +uncompressed delta.  The base object name or offset is not included in the size
> +computation.

This is an important point worth describing.  Very nice.

If we wanted to help the curious, we can say that these are used to
both help us know beforehand how much memory to allocate, before we
inflate and/or to run patch-delta on the payload.

Thanks.
