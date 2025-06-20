Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD629238D57
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431492; cv=none; b=Gve/7z+iZ71QI7iUoHVJsREz2WjxPYF4mOvWCERsZDTB1+fo0tZJvpol7XJFoWqOQU2Du300hpC61X+MiSkBD7d7Z6ZlZbK0QiWTy5DJU1bVccx7LH22gdhTucR/67RkHvSyhWJd8rglZ+nc65QIaGDFNmuAon9lgOZtuIWN25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431492; c=relaxed/simple;
	bh=U1LZkJmIEXlmc/sX85L7+69xIc+Q1dP2435ZaIavDFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cMYMSZI/kKOVzYyrZGz6W9oJ4lnNQRLLMtLwcuAgBuAf4CcXe9fiJ4IB8sawelOZjn2Zup8LcQDPFPIbX/FnK7nsx294ELDSZrgM4A7AUFTwmimVMI6VMW/pWEppH0FXltZvv3iRJ9x9NCbuqs4NMnmM9HAliCrf8NSSd1TK8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bHdYnhiI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NwwiD69k; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bHdYnhiI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NwwiD69k"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 100FE1140216;
	Fri, 20 Jun 2025 10:58:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 20 Jun 2025 10:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750431489; x=1750517889; bh=WgNC5XVUz6
	r9KJtNZ43thbQ93M0uIymY322VooeX6/c=; b=bHdYnhiIwUwy8aXdzeDwqmrFhh
	f6BmbhZ1E1mVxWtFmwEVrbEqCd7guRj2ZItPwfDj3Id3NV8OW36YlQsW9vxBPnId
	oeNjDyWDjUvUzeinoE4ZTwxuMPWYsZKpOJhAyn8+7Tx3nZmoFskWsxBImZ8hvn9x
	NXenllci0Qur4ZxqunjMuue1uQynD26pymm8qALt1sJ9Gq4hWcg0yOx9w2uurXoy
	NuPWJwZD0Jpu+pzVAVbZG7/BC/iegraqEmpe8cCxEsWZouDamDfoQuxlPPf8P7xw
	x6X2NTri2uzyKpfmdVxefn5idpO61v3vUN3SZRbhWVEPc6K68plO3BqR12yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750431489; x=1750517889; bh=WgNC5XVUz6r9KJtNZ43thbQ93M0uIymY322
	VooeX6/c=; b=NwwiD69kgcmcAKb1Pm7fqi5Z5Qe7Vt5opUo53lSPtAGC1U+SSbX
	ROJjGNcgG2Yz7QXhm23x8soAui+5ps8ielLdvbN9W3hS9CUWiQF0RYzuX1N5+k2n
	zpWM7Oa6wRUAQHirmpzzS53eGxyWR2jX1neOa2tIrMuLkiL9HDsO//7C8IWcwOCC
	1dYRHRjNlTvud5R2ahbKnrZI4RNt051A7xS5Go42fbuwtPZmmwHeJlqMhkbMfzDY
	sEwv4mK2eP/dT7yvhDgvnjoidhJ7lxq22AZa7C3ywEzoqUhHy95mUsYeYReTqkOm
	uD74+PW2ci6MaAfsJPHUug7XSLzDEg/RoLQ==
X-ME-Sender: <xms:AHdVaPlMwqcc-lEJOGXj1oiE9l2lWgl-A_koropbjTerNdTeoTjorA>
    <xme:AHdVaC2YZCqrNt8CYOe1vTMFysaL-D-2EWd_UlQLAz7yxBDB5FhmDxcJo5P2dSGKR
    O-YXZ-BZbPQFI_pgw>
X-ME-Received: <xmr:AHdVaFqRabQqeyhR4-NujBCmnl7H2cUQ3RzZXL0jj16EQuRKS6PjpWlocsIPboxVQ4XNH9CgjFt8mM4P5Tf9NkyFIgXzaO31JDDn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:AHdVaHkrZfmPDdjV3hlLLwCxqCYeR2NLyVqbJSJiOhuPiRtBsvpRCA>
    <xmx:AHdVaN388VLWs7q_QSZG3qzIIF4_XMnp6QoCqg3uFtV5ZfQcXCvU8Q>
    <xmx:AHdVaGvU2fyyI3ArgRRG5xq20frFCM2gX6bJxG3mB-e44WJIPpQCkA>
    <xmx:AHdVaBUl2WxPQ9AS8sN5P_NiRTY7oZ5SYIX9ml7XMro4fxH1nxNxLA>
    <xmx:AXdVaAAxfAOY3Xr6TL9KiU3V9OGzl1JU3I_xKYIRuL255VQDiWCN6vYA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 10:58:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 10/10] Enable SHA-256 by default in breaking changes mode
In-Reply-To: <20250620011943.586596-11-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 20 Jun 2025 01:19:42 +0000")
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
	<20250620011943.586596-11-sandals@crustytoothpaste.net>
Date: Fri, 20 Jun 2025 07:58:07 -0700
Message-ID: <xmqqmsa25ukg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Our document on breaking changes indicates that we intend to default to
> SHA-256 in Git 3.0.  Since most people choose the default option, this
> is an important security upgrade to our defaults.
>
> To allow people to test this case, when WITH_BREAKING_CHANGES is set in
> the configuration, build Git with SHA-256 as the default hash.  Update
> the testsuite to reflect this configuration so that the tests pass.

Nice.


> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  hash.h        | 6 ++++++
>  t/test-lib.sh | 7 ++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/hash.h b/hash.h
> index 0e14cade4e..144b53b7d6 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -174,8 +174,14 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
>  #define GIT_HASH_SHA256 2
>  /* Number of algorithms supported (including unknown). */
>  #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
> +
>  /* Default hash algorithm if unspecified. */
> +#ifdef WITH_BREAKING_CHANGES
> +#define GIT_HASH_DEFAULT GIT_HASH_SHA256
> +#else
>  #define GIT_HASH_DEFAULT GIT_HASH_SHA1
> +#endif

I think we decided to format the above this way.

    #ifdef WITH_BREAKING_CHANGES
    # define GIT_HASH_DEFAULT GIT_HASH_SHA256
    #else
    # define GIT_HASH_DEFAULT GIT_HASH_SHA1
    #endif

cf. Documentation/CodingGuidelines

 - Nested C preprocessor directives are indented after the hash by one
   space per nesting level.
