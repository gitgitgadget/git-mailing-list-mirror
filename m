Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FFC29CB4D
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758324296; cv=none; b=F8LUyZMLdIiyckZX8o8c794LxlYsrQ0GNZ+QsVoDRbuVb+6XhavlsnSEcDl3NbEryb1IousxlqVioqtSAwlkWW5+n0VgzSuqg/QFVqCcjbiBp+6fPyvMtO0/ztQ0Nd4ANN/eYckp6KW09IGuao0cOOel4ZsgjBpfQHHUoMuCrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758324296; c=relaxed/simple;
	bh=rWISnYdzcwXkY0IYi2x3pdLdkv1KI5nkVcmZGgKnWg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ochFu4pKbIhF/tN7mWQ3hswA1cWaA94LnPxz/FPdx0jAp7cbRnWF95ojSReW/Ja+Uen1H8S1fSo9aUebUjU/VLxcRKhz8aEo71PUiGBpefXP29CEWEUh8dczhWvEHSBWoJR9Jk/7JssNjiceUyxwKA+7ayj3l1gcEdj6XE8sruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fy3XIZO2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DfIgCHH5; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fy3XIZO2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DfIgCHH5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 995EB1D0007D;
	Fri, 19 Sep 2025 19:24:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 19 Sep 2025 19:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758324292; x=1758410692; bh=SfqybHjVPE
	UqW9fulCRMD4fCidtf8cjZskZ/H6YtK20=; b=fy3XIZO2nvxIIzNTHiNNq5wfWz
	UNUm2fPZZd0hhdxR3KcqkSyv9LGn7ktB2DYV1P7SSrIl1D3ObQBh6AGc57cc7+6p
	U8awxQQLWWVA89E6fLz3T2aQuZmkuGJlKDrUIp3g7uJ3hNDg8jrWAQapokl+Hojp
	u5ULf3r/JyvYjTD86fHFJGN/nnBiSuqLDf4IiTVrOS9jsWuOLnmcd6Mmr+8finvc
	RF80u3NZ+tZBZfZ5nH606o/HIit8ax1kOGVk77XjHkw4E2G7fHE7QS6Qfncix4l2
	XEImsGRjjOlvR5MEOq4I9it+4MtIuoDlKQXv68EBaq+loaxzpnEEGLTHXveA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758324292; x=1758410692; bh=SfqybHjVPEUqW9fulCRMD4fCidtf8cjZskZ
	/H6YtK20=; b=DfIgCHH5HyChPnHoapo44DLNz1Na4QaH0Zm6wJJIz5k0PQqrA79
	kgeX6UApiClsUrcdugg2AHTiW0SeA2X7v5N2JZiuo6bpvA74FCPyQcUVs46+nL3a
	T0HtEW+cDcj+aK3iH+JlPDmUWclCb4HM10wLkFYZeKEZ9f8/5z+MWi4LDHXuUWee
	6+L0NmE/ByIl05jIYezb+n59jY3GNbwZeM79EqVIwiVgcc/BmQRvwVFGt8Jjz91J
	kftONMoRNGPnhRqOowi41XVV/o7xUf6UVl2OFIH7nME4+vwPoqrRRqviwBw+5O2a
	qDjznhPzX0+qcjNgPIBcrmRyomCVrZp97dw==
X-ME-Sender: <xms:RObNaHkVzpso0rP_-Em1hopcIPGdnxT3OIdTSqytwllU3LL1ORSBNw>
    <xme:RObNaGVtqNo00CyEOJok29-HCXT4R0L8_xZ7CxSDFvHc5Gp5Khu8bc0vWXP2NJjjF
    6fo_EHc1Ar7MLSqLg>
X-ME-Received: <xmr:RObNaEF8vGApRF1HvT--p7JIqfc-IYGScqxIuBfTPYPxq2UvOz9oN-78G_uHfVQhgf_KVRGv7q-EtHC5UpCNOpxA-N09A9AzZTyF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RObNaKcK5aYoIha3RrqxTFczcfbdhU4jCL7CUqt3IMfMRgSVjrSn7Q>
    <xmx:RObNaNLsB3--3XFvPZbkm4eDfTpNOp_Hgfph3VFdxuHiVg_TZivp5w>
    <xmx:RObNaHHJ9fie1w9S9zkjGUNNGyqCxXnSYeYUMPlX7ejTCWy8mg2kLA>
    <xmx:RObNaICMP32zJb99I5rghr7sQW-k-OBUvPdsTztQnkfa1fQV-a1oKA>
    <xmx:RObNaBrsO64DDTWyJ9py4aIO_ZFBXrYwFoNVvYRb8zNYgE94Aowo8wUK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 19:24:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 6/9] rev-parse: allow printing compatibility hash
In-Reply-To: <20250919010911.649831-7-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 19 Sep 2025 01:09:08 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20250919010911.649831-7-sandals@crustytoothpaste.net>
Date: Fri, 19 Sep 2025 16:24:50 -0700
Message-ID: <xmqqikheyqil.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Right now, we have a way to print the storage hash, the input hash, and
> the output hash, but we lack a way to print the compatibility hash.  Add
> a new type to --show-object-format, compat, which prints this value.
>
> If no compatibility hash exists, simply print a newline.  This is
> important to allow users to use multiple options at once while still
> getting unambiguous output.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

Nice.

At first I somehow thought 

    $ git rev-parse --show-object-format=compat HEAD

in a SHA-1 primary repository would give the equivalent object name
for the commit at HEAD in SHA-256 world, but that is expecting too
much out of a simple 50-line patch ;-).

>  
>  				if (strcmp(val, "storage") &&
> +				    strcmp(val, "compat") &&
>  				    strcmp(val, "input") &&
>  				    strcmp(val, "output"))
>  					die(_("unknown mode for --show-object-format: %s"),
>  					    arg);
> -				puts(the_hash_algo->name);
> +
> +				if (!strcmp(val, "compat")) {
> +					if (the_repository->compat_hash_algo)
> +						puts(the_repository->compat_hash_algo->name);
> +					else
> +						putchar('\n');
> +				} else {
> +					puts(the_hash_algo->name);
> +				}
>  				continue;
>  			}
>  			if (!strcmp(arg, "--show-ref-format")) {

Pretty straight-forward.

Thanks.
