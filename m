Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA20372B4C
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769727785; cv=none; b=NGw6IX4eQDMiL1sn56XM0+6+azOHHokTzfh5aeTEtn4/sbjCR0PiA6d0b2kSx8jKP6PaHtmuIrfmSLYim87ZMeW6ih+Gak5QXcLiMWYsaef1QeC5dQrWQA8HNYARnEyFtm5K/VsGXDYlsw2MLUlCbeNdqRdmfY9T5pJFHqL8o6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769727785; c=relaxed/simple;
	bh=D/xquznj+CI6etzLhlqF52GWfkylrr0KQ8ta2EZIy3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TYgCUm3fumDj46SXOo+qjqhk+8dbaSG7Uq1Y9tih2bDo3qWhAUPorZHbkj92ex9Z7j9loyOIxWtQod9ximxLZEP5tDTID+0YpEAHmpR8vvvTZRqJ+z4PpnudxEUdfPuCSHRfVRaFZyF20v6dwYHx0MDrm+fw2RNKnFJbmK/9jj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NEpnptuw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IEY+1wY/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NEpnptuw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEY+1wY/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A00DE140008B;
	Thu, 29 Jan 2026 18:03:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 29 Jan 2026 18:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769727782; x=1769814182; bh=k0j/qJ+2qD
	JLjP4UzQRSiZNA8hRnsSYKPC8U1JAwmjg=; b=NEpnptuwpgidXbjuJxLlkAsPzy
	brQ/tcl0fN+my6HtHV+UfRUCKqHJ1XdyGcsEjvupq5noPK3R1amYjiZ8zti5XZqi
	ky9pmwuJWnmqOfpUISDQkbHSz0ozvULgMgtBcwUNVGNX6m0TKIj6stFQCYVrOj5q
	geVufGuYyOkT1kiLxW663cNFOXDSHe2MZIX8F1ke3SzrvVQK0s2YarZ/CUQe1bkc
	CY8Zuk1+HGjBlFaevSkCsYOLG1lyiuYrYRy4Vz5udGZnBdV21GDle0rEWg3xxICA
	rbLFkHG96OOT52NKsDrviOobiuvqxWB+/4rXTP+fWhCOi24SLGYD0XBb5rtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769727782; x=1769814182; bh=k0j/qJ+2qDJLjP4UzQRSiZNA8hRnsSYKPC8
	U1JAwmjg=; b=IEY+1wY/Ty8/GwSiPdX1V53pYdSwLByGWfGnZ26kNukQ0D9u/Qm
	ym7GEkaxJwNIns2hNCBgF3mC3GwT7ClJTCz+P//fTRvRgYwXTUABjYu2jlnNuH6+
	RGuE+Kb01E+hp4b5qlkKbut+z8gRx67O3xSMKlMWMbPCCdAv01Ev5K8QHtgW+Fco
	H/AzsRx/L+4h4Hdz9jl1qMRz+dGFG4AeUcrfq3DcF+ITRe1LZOBqTE4btZ5dgLiS
	gPVbphxK3oo4YPi5ss/mbh+j7OUZeZ/qbDsB3ev2GjUfDpXXjW7Nb9clSLGwgxMR
	YjSo24+qMHYi8eWrj3BMBKjHnXrsn3W1QMA==
X-ME-Sender: <xms:Jud7adDgBfoOvaXxWTygO30Pm8BZppuzfM1piytKjn78XgOvwHy3HQ>
    <xme:Jud7aShZar9Eu6lzRSEss13d-Jteu8Qx9DHHZHx7l5itGW-g-L-m8S3rhNwMmQCfQ
    TPcVRLP5VU6cCAAx969SWtroOovoLgFt09BBZ_RuSX5Dp4XVC6AUA>
X-ME-Received: <xmr:Jud7adnzK1vZ6cb0C-G7dJwCfSAHZZ2xVMdbGLB62_uh3BX3DHa7djz0DvAQfZO5gbVo0sQRpuV3AWtJDqfmzR3rVKOabfgBd-YiT_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Jud7aWrX9yEUJRNiUgyXO6A9TQyn4canvaE6pqH1kl_opQDwXWzGgw>
    <xmx:Jud7aeEpCVGYRSAk3swq_BW1tG7LMFFrGlFzu55bbTvgQWiviqZ7sA>
    <xmx:Jud7aaxIicRwbF3WPFuT1HsjzcSWkprykVQkG4WpkjqNkZ-xIn0e5Q>
    <xmx:Jud7abqMObQ3Dp4O_MDS1ahEkdBGiAlhnffOuJGAtIyVsNSsLQzQPQ>
    <xmx:Jud7aVEDXHvdixdFG8LQqbZFfV2ThUiUFbqOJh07AsAfA-GEXeyvJ_Ak>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 18:03:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH] show-index: warn when falling back to SHA-1 outside a
 repository
In-Reply-To: <20260129153948.224156-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Thu, 29 Jan 2026 21:06:55 +0530")
References: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260129153948.224156-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Thu, 29 Jan 2026 15:03:00 -0800
Message-ID: <xmqq5x8k9g4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> When 'git show-index' is run outside of a
> repository and no hashing algorithm is
> specified via --object-format, it silently
> falls back to SHA-1, relying on the
> historical default.
>
> This works for existing SHA-1 based
> index files, but the behavior can be ambiguous
> and confusing when the input index file uses a
> different hash algorithm, such as SHA-256.
>
> Add a warning when this fallback happens
> to make the assumption explicit and to
> guide users toward using --object-format
> when needed.

Line wrapping at 50 columns certainly makes the lines narrower than
80 column limit, but let's not go to the extreme.  We recommend that
the lines are still less than 80-columns after being quoted a few
times in e-mail exchange (as you can see, I lost 2 columns by
quoting once in the above), which means that around ~70 columns is
the practical fill-column.

> Additionally, wrap user-facing die() messages
> with _() so they can be translated via gettext.

It is somewhat distracting that such "while at it" changes dominate
this ~100-line patch, whose "primary change" is a mere three lines
we can see here: 

> -	if (!the_hash_algo)
> +	if (!the_hash_algo) {
> +		warning(_("assuming SHA-1; use --object-format to override"));
>  		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
> +	}


Can we push the "while at it" message changes to a separate patch, a
preparatory clean-up, on top of which another primary patch adds the
above warning?  Alternatively, have the primary patch that adds the
above warning and does nothing else, followed by a post clean-up patch
to tweak the existing error messages?

Thanks.
