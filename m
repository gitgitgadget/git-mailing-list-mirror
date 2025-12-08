Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B0269D18
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218405; cv=none; b=XeyeYKHuODUQyJ7tZZwQpAcPDS1WR6e1mXnTdnjx7eLOhGCj/C56w6EE4nOaifU4xNxGXpLuNSq1nAscg5PUz4sfict40tbV449otzAwM5gJRR6GoL8YBG03ocQM1mrJoCI3o+U+G33dLWANF7QDC6qMqXuk6fkTVYNLa0wkTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218405; c=relaxed/simple;
	bh=OxRgO6KkOfNP8jVnw91qubvCzRa/lBJAvv90mQH56IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjLCDs18FXzX2aY/7FScI5fCCuY507GMf0sZJuRXzR4tzk30Rq/4o7lGJbFVkzMosRAq0CD1a4sJYfAiL2HNQyP1SNhf8a5RDD0DUJWNrCpOGjLur6nO0/BzSS3/KBBzZQElHC446EFCyr2i0jvTTvcrxN4R4kAsvVYUlTfic6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vlm7nCEL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XMCm22ml; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vlm7nCEL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMCm22ml"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9746C1400049;
	Mon,  8 Dec 2025 13:26:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 13:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765218402; x=1765304802; bh=6qlxNw4SFb
	Wvl36a3R/Dc8GPIjL5ecn0SSaUkwh2aTk=; b=vlm7nCELHwVJ7GGEdk2e59g+Jd
	70nbT8WPvglAW6mgdwHT+JNEHhOcWp/QgKjyU4lh0oBcqxDmRyGfX6+6q4VaawYk
	vrjDs0Rhiy9su/Q12f1sxtYm/FkbLN0de1I/ascOwSD0O09IpYJkwxWJMWOYrsVa
	accVjsSrcqDwfVqgq4LV+2u9TJsLkOFPk8Bdl5RfTCAU5UbI8KmLqvO86KSxXc/y
	jCwp6qT1ssN3gLzWNd4aziN9fOAGCIuc1chrNsr1RywhCy50USJX2beq4FkG+v5o
	ANFnost0yZlMDQqrOSconlxllyD1ZiKHZ7KNBw1xmDa8aqu/N7K5rNOetPFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765218402; x=1765304802; bh=6qlxNw4SFbWvl36a3R/Dc8GPIjL5ecn0SSa
	Ukwh2aTk=; b=XMCm22mlTLgBl2iGqo3beMDyaVLHtdk+7vTRPz5MARj20DHZ1ZL
	95TcnPDBHUbeK8VCwOKg0KDyaHnAoHiDZLllf/A6mVkohDTNJtrX987fzsGKCBmi
	+u75G8f7TzNRfrQYXZpWZVQj5511n4pKhiwN9NCiNruBDuuReJ2HDGoKHhRlu/8x
	A00IM6H7ZsmQDVe7vRvREuJBrEunCWraGyEfY42JCLK2clYAj/nzVN+Bhgca7Okp
	IcO6GxCIMFDRstKLIc5esFnTJiIpF/fR9A1oQl5Ch22paK7rR1PcuhpT8Bi92i8y
	mB1s1BEa75LtEjcWSZuG3ffuEKwlZ4l1Qpw==
X-ME-Sender: <xms:Yhg3aUvXupROBayrp2jHFryNuosxizPO0GFmf7713d7KGN70AvDN-w>
    <xme:Yhg3aYXzS88B7kMC8vwwGqir9l4yFxyQV7FoRIl8GnXinmviDDN0nW4CGTI6d3luv
    T1IyyxIeHEJQl-5n2AMWN6SO5qldiTnRCiApuL_Nj-yHkl6c6no>
X-ME-Received: <xmr:Yhg3aYHAzvftamUIJnFaZKHp0orc1FoMCpxwud211zt9hdBcqhJ7fdKwJdGfWrqt9ak5rc6RF-bETo14FnKreKl2V9nBFf-KWM6oirE1dYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:Yhg3aS0HiR50OwBryEzoDer2h44uo7DorKJ0aSxJt92PA8aYNJAvuw>
    <xmx:Yhg3aSM5XPXvmHgplYzwACyS14B0zOp-Pg5a99hpp1hNkZ5aNAnPSA>
    <xmx:Yhg3aZ4f2l0A65fYq-Mj4-0Vw6-mxU2u7trdY8Y1V2iuJLCVjS-nag>
    <xmx:Yhg3aU2yKG7IDqDolZxVAzS8EUdcDkgV8iLPUkPyjm91tO6cdgowcQ>
    <xmx:Yhg3afVGzRkRgRNalYv7PsUIA4n3Q6nIwUpoIvvJ4fLijrq-0oPFuL1L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 13:26:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31a81269 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 18:26:40 +0000 (UTC)
Date: Mon, 8 Dec 2025 19:26:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/17] midx-write.c: introduce `struct write_midx_opts`
Message-ID: <aTcYXJr_-IxPmC65@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <47aae3bf2a83a2724aecd3314f8cc5d47e8013f1.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47aae3bf2a83a2724aecd3314f8cc5d47e8013f1.1765053054.git.me@ttaylorr.com>

On Sat, Dec 06, 2025 at 03:31:22PM -0500, Taylor Blau wrote:
> diff --git a/midx-write.c b/midx-write.c
> index c30f6a70d37..b262631ae45 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1014,14 +1014,20 @@ static void clear_midx_files(struct odb_source *source,
>  	strbuf_release(&buf);
>  }
>  
> -static int write_midx_internal(struct odb_source *source,
> -			       struct string_list *packs_to_include,
> -			       struct string_list *packs_to_drop,
> -			       const char *preferred_pack_name,
> -			       const char *refs_snapshot,
> -			       unsigned flags)
> +struct write_midx_opts {
> +	struct odb_source *source;
> +
> +	struct string_list *packs_to_include;
> +	struct string_list *packs_to_drop;
> +
> +	const char *preferred_pack_name;
> +	const char *refs_snapshot;
> +	unsigned flags;
> +};
> +
> +static int write_midx_internal(struct write_midx_opts *opts)
>  {
> -	struct repository *r = source->odb->repo;
> +	struct repository *r = opts->source->odb->repo;
>  	struct strbuf midx_name = STRBUF_INIT;
>  	unsigned char midx_hash[GIT_MAX_RAWSZ];
>  	uint32_t start_pack;

One might argue that parameters which _must_ be passed could be moved
out of the structure and into the function signature, and as far as I
understand, that would only be the `struct odb_source`. After all, we
are talking about options, and a mandatory field is not really an option
in my book. It also makes the interface at least a tiny bit more self
documenting.

Other than that this patch looks like a nice improvement to me.

> @@ -1566,8 +1586,11 @@ int expire_midx_packs(struct odb_source *source, unsigned flags)
>  	free(count);
>  
>  	if (packs_to_drop.nr)
> -		result = write_midx_internal(source, NULL,
> -					     &packs_to_drop, NULL, NULL, flags);
> +		result = write_midx_internal(&(struct write_midx_opts) {
> +					     .source = source,
> +					     .packs_to_drop = &packs_to_drop,
> +					     .flags = flags & MIDX_PROGRESS,
> +					     });
>  
>  	string_list_clear(&packs_to_drop, 0);
>  

I think this syntax is not allowed in our codebase except for a test
balloon just yet. See aso 9b2527caa4 (CodingGuidelines: document test
balloons in flight, 2025-07-23):

    since late 2024 with v2.48.0-rc0~20, we have test balloons for
    compound literal syntax, e.g., (struct foo){ .member = value };
    our hope is that no platforms we care about have trouble using
    them, and officially adopt its wider use in mid 2026.  Do not add
    more use of the syntax until that happens.

> @@ -1774,8 +1797,10 @@ int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
>  		goto cleanup;
>  	}
>  
> -	result = write_midx_internal(source, NULL, NULL, NULL, NULL,
> -				     flags);
> +	result = write_midx_internal(&(struct write_midx_opts) {
> +				     .source = source,
> +				     .flags = flags,
> +				     });

Same here.

Patrick
