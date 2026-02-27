Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F0374162
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772234894; cv=none; b=MEf6DktkyDvOPjD90cq0SaiY6oY+B6VyoWBMOw/lRgRp+trmlkfa8QgYwWmdzAFH2j/O7uhooRTq21aLUNyg9q/4uhcE0ZkIrcYXdvZpQ2qKn8wOQmVr3kymujReydblaPhf4jekK+Os3Y3aJAkzS6IlrLK4W5BhkARjjoEPEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772234894; c=relaxed/simple;
	bh=FMOY8zr1tXrV9cHQrgXEsY5vO/PEWkpyDXQRR6e8H1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dFfk/fRqdrGVQScPj7eK9e/Hltpqn2G3+D8DEXlVEwk9nYlGrGeYGuM6qIGea6vXz3RS8xYWVAPDhOfONi4GNpTnQRGxY0MvhVmEfNfDoPuayA2e97zA4SufNaOjJyDEcOXINt9CvLWwbqkeikzZGeW2XY8dLhZxqniPfLvZh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1oivn5u7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pKUef+3w; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1oivn5u7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pKUef+3w"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE0077A00E7;
	Fri, 27 Feb 2026 18:28:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 27 Feb 2026 18:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772234891; x=1772321291; bh=H0gDnUjYzF
	DRYBNKbYwIXWWsziXEQputeDi2CQENBG4=; b=1oivn5u7Ak1JuyI+ifbQdGZv+x
	hMSDsKNF2thD2wnc3CXsQ2FifUcJ9G6lmIe4Ec/7hN659q5VCUHVqvp0YPONVNCy
	kOfyXKboDsy53GKP16OyLM9LjXdTOPEIThjnJPr7zKNKx8yNywFqGf9SC/CLN5Xh
	wXZul5s5uud25MYjH0ACt+39sdY+m4Cx3Pfj/LWDXeQhFqxiSYTDx+QXdH6xTfil
	D0xVZzD7yuuuDQ10L0NdTNG/OwO6Iwc0Q88J8KbvjEnEvsVN4z4Iz3w20+uduWVH
	g0dhHKpAr32wCNREYF7rq+Q8OxFqEVZoelsvBYrVgZ6F+Kb4/ADrAmJ76vzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772234891; x=1772321291; bh=H0gDnUjYzFDRYBNKbYwIXWWsziXEQputeDi
	2CQENBG4=; b=pKUef+3wCmH8QlWTXdMn0FIdAVhg9hkKaIz+NZYLhILY+oT81Lb
	/mV7UWuEihGrTdxal2F3tsZr2iuumwsRV+4eMrZbwIrVQHrGFzz6WCoM32Fdg6X3
	CejRRM98UVh5dLgleW2T60B80n4DPRrDc8aaVtpi1U3ZQUJOYptpF6MBE43enXmU
	QyvMY3gltYIx0KNe2BWMiDx8KHGFWGpHMiDEe69+cEtPQYAmDi6ur1IOlkMNuIr2
	Q8CtbzCiywCiX/yk3ZiS4LLvPCiwbfNzVSHh4wa0ObbilL1yExJfqqO1BLd+A0UU
	QnPfLdhYln67qUjWpVOOzgh0s0vKD9UbXUg==
X-ME-Sender: <xms:iyiiafYnSqlQXIgP82qovXSE0RJKr_szB5Qppv3mMpDxMNhQYmbjEw>
    <xme:iyiiaVbIcEJ8mug7NNw5Dl8rQg-cXcnbE9GG70OYrFjMq0e2N2yfyMi5LUKtThtUy
    Au4u4NSam88lkZiqLjQKsijDcuTGUAWH2vnL_EFQoiwn7PnGpJp5A>
X-ME-Received: <xmr:iyiiaW-eNE8lBLKkigQhvMa_bEkhVqm_s9JgbOiXuol3DbKfdj300rtDJG6gO66-8gktj4b8A9BYdjaZSbuJKSEMAt7pA92eIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedtfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iyiiaUg9Myluhf9d416OFYxbwjbOh66n9jCSH_FNMUWTEF7M4HPD4g>
    <xmx:iyiiaWf9gC-sP_7g6JsrIq0JAh1USP0VP1sszwPKIApu9B2O3dc9vg>
    <xmx:iyiiabq8IFnyxudT9HQAcHz1iWiQfxEwEr6Ns75U89kGPr-y1-ajVQ>
    <xmx:iyiiabCK4isXVAwyUvt6Dts662jkdLUM9NbDNxcLisbzXDp8e5N3Rg>
    <xmx:iyiiaRTfBSAEcXOdIo4rwwjqiya2ESu3bpRPQfWhVDCM52GzUuXQeClH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 18:28:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] parseopt: check for duplicate long names and
 numerical options
In-Reply-To: <20260227230822.GA2965111@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 27 Feb 2026 18:08:22 -0500")
References: <xmqq5x7jujqb.fsf@gitster.g>
	<7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>
	<20260227225055.GC2956443@coredump.intra.peff.net>
	<20260227230822.GA2965111@coredump.intra.peff.net>
Date: Fri, 27 Feb 2026 15:28:09 -0800
Message-ID: <xmqqpl5pojg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Doing this:
>
> diff --git a/parse-options.c b/parse-options.c
> index 51b72eee11..f056a4471e 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -659,9 +659,8 @@ static void parse_options_check(const struct option *opts)
>  				optbug(opts, "short name already used");
>  		}
>  		if (opts->long_name) {
> -			if (strset_contains(&long_names, opts->long_name))
> +			if (!strset_add(&long_names, opts->long_name))
>  				optbug(opts, "long name already used");
> -			strset_add(&long_names, opts->long_name);
>  		}
>  		if (opts->type == OPTION_NUMBER) {
>  			if (saw_number_option)
>
> seems to shave off ~1% of my benchmark. Not that exciting, but hey, it's
> one line shorter to boot.

Yeah, it is the right thing not to hash the same thing twice which
is totally unnecessary.
