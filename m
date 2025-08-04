Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD0A1BEF7E
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315215; cv=none; b=DT6ggDlQs+Bmh3XaidbWQfEPaaYMSRZ+7wWxaYjrJLdmAWzhfX6nCqO4c4ZwTKdt/C8j151LnNclF6ovvhiXREVtzebfYl0C7qEgkPNLv70iR7wWNy9UOyaWitfBtLyUsBw2qlg9bXtYQbMyYFCSf2HN+eBG3awdHUeK9vYJyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315215; c=relaxed/simple;
	bh=WBk5WcoxPXIhZhLRBRT0hs49ONRM+l1pe4pz1w32pig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZwvsPik7h9ZsM4Rv6rngGgHAAcNaqFujLGkFbI1Ko4MdLIPnbCCXU4DlXGygCyr1vZLGGjdL48/DAs6njFiGztx9CL4QL/d9oOAxrSx/7fVejENbLbCTiiS9ir/OVlVjIYQktdxVrIvaKoJNW8T7CF2jSsY7+43hl6Vy1mICNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lqtiA8B9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GOi6NEZr; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lqtiA8B9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GOi6NEZr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B38314000FB;
	Mon,  4 Aug 2025 09:46:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 04 Aug 2025 09:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754315212; x=1754401612; bh=G1DafIP4F9
	Eh4nyWnXXus6TdlPhSH/6Hyq/OcQZIb7Y=; b=lqtiA8B9TQqL5dMLo1vyAsOIqw
	IPK0OHvKl+BoJbyxBBfqWS+ijDrWhWlVJG5a3Nue2gOkwtNxIjXs6vEON3Nu/sfN
	+qgovNNPe/G5f7/7kwm3bL5oekhF1k2wiVpjjPZAMkXOSqDO3WZnNWv6brqxQ/ZS
	zhcnRsPPY/IlX6wnhQ7VFKhWcNuDtM2AHwhVtFAGSBAg0AyI3gqXcyf+3VhoyQqH
	3DI7ZkD/lD+S9N/dSxgNZckzBnoLmqR8A+COLvlHHOreNE3LJNF+zS2vUejt+ZgB
	PM3D8MO/q6V6pZN5f96cQ98TK8KBsVT/hZTlUw4EC3baOWzzg7rB7TJ4m9Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754315212; x=1754401612; bh=G1DafIP4F9Eh4nyWnXXus6TdlPhSH/6Hyq/
	OcQZIb7Y=; b=GOi6NEZrf//57GLek7FLoWAuofa5GPxrg4AN5foRvbqdu2llEjH
	1xueTRtx+lWPslKDEIWr+CNmDGbRFpLGRcBEqNeN/LtT0ulseVy2t+/myOa1oCVu
	SNSul1sd1c8AdoHdIdhN8sfCem34VMmf7LYIKuTGe7P9DMLj2rkmHBwnJdrPmgUX
	PV71gpj2jipDNmTChVuG4H8cvz6xGcmD210e5Auas4/9MP2YnTsVSLz7q8nVKYXs
	2H9WzBio21o0w6IpLQpUP24p05DU3HYXeJLtxFrUJjYVsTDE/HmQPLmNodYfbYQv
	PPCJ49vPpRT+ULRaNtbL/jYUKE/lQPYd/ow==
X-ME-Sender: <xms:zLmQaGWBrnsra13pzKBzYO7144O8xLXHSNruoagoO12jrlFMwIf4gg>
    <xme:zLmQaNLjk74J5gwAEaMolnYc8ipSxL_xyfQS5qbqB9wNBE2uGtvSM3HkiLiEM0RAJ
    NdqVPlE03BlIc1IYg>
X-ME-Received: <xmr:zLmQaG-6Xv7xlW8ehCAFDSEwzimssj3Aqv9cScqItI10EAFj2LsoBrlR7jXWZe0gZl8DSDobJSoaUd-DNn2OrKdJMsA-EjqTc2VSqh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hlihhurdguvghnthhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:zLmQaAJRajff3GUiASj5GjxJ7k6wHfTLv8-4ebAZPHeucR3Q3hkCWA>
    <xmx:zLmQaLmXetWRdse1FsU5FXqAxs--wex-SzjZPn0L74P96a5ndzgY_w>
    <xmx:zLmQaEPj-d29snjZgEfW9pA8_goBhMPjYWfulFF92eyXqctdsmi0Zw>
    <xmx:zLmQaB3chLxrwSB7rqVmV3qKJKWGLfW0MvYuqwCBR5dqXyaRbLs0dg>
    <xmx:zLmQaLFzEbID_-YZ_CR0pCBGjIdv58jlAaPf2T43auP0Nas5hpCICa2L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 09:46:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Denton Liu <liu.denton@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fix -Wmaybe-uninitialized with -Og
In-Reply-To: <20250804131922.GB86602@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 4 Aug 2025 09:19:22 -0400")
References: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>
	<20250804131922.GB86602@coredump.intra.peff.net>
Date: Mon, 04 Aug 2025 06:46:50 -0700
Message-ID: <xmqqms8f9p2t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So I wonder if this would be much more obvious (again, to both humans
> and compilers):
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 5dd6cbbaee..f0e49a5681 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1474,10 +1474,13 @@ static int set_head(int argc, const char **argv, const char *prefix,
>  	};
>  	argc = parse_options(argc, argv, prefix, options,
>  			     builtin_remote_sethead_usage, 0);
> -	if (argc) {
> -		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
> -		remote = remote_get(argv[0]);
> -	}
> +
> +	/* All modes require at least a remote name. */
> +	if (!argc)
> +		usage_with_options(builtin_remote_sethead_usage, options);
> +
> +	strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
> +	remote = remote_get(argv[0]);

I do not know about compilers, but a sample of one, to this human it
is more obvious ;-).

> and the line it complains about is:
>
>   if (filter && strncmp(test[i].name, filter, matchlen))
> ...
> At any rate I agree that "0" is the appropriate value here, and
> assigning it to shut up the compiler is the best approach.

... simply because we know the value in matchlen does not matter
when filter is NULL?  I think that would work and I would be happy
with a less noisy compilation.

But any other value like 99 would equally well work, which is a bit
disturbing ;-).

Thanks.
