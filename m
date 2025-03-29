Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4BC2C9
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743248210; cv=none; b=QC2JMEWJrUZRrmzePEtgamqt5e1hhTYTdjyIsDh8ipAoeY/rEaKgjfRWo+AvaaVPDJcp+ckE3haduE0zHcZ8Q+wEsGsUzImpxQ5onWUgY5EN9+UGBoFBdR09uYE6O57vinnQVykSvB7dLXL+dClJWi+EdGhHX4lOd/Fi5Td3a3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743248210; c=relaxed/simple;
	bh=k1TowNBuEvXPA+MOIuP2cgpZNkj8d6cztGuVRqrtni4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vl1xmuW9stbnYTWPvsErK41Gzd/H7wY0A9hiQSXDR1OFD0AgBqHUV1lti0DnNs5shd1dh4HVRPXh48gQ4W8McqYx+sOBAVMOQiWfEn36v29kbKUyw+KdZ51fgURn1LLGfyLcJXS6FCMMrjpYSfENw7rapteXUV2eAIlJN/YzdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=plYYTRL3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZvw99mw; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="plYYTRL3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZvw99mw"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D9222540105;
	Sat, 29 Mar 2025 07:36:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sat, 29 Mar 2025 07:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743248207; x=1743334607; bh=8n2eL1Kr4Q
	u8s8etZah6R4nABuhrdUK3fJlOqtY8yaM=; b=plYYTRL3Sulbk2URYcXT7AiMRw
	SrSLpQNBpUUhNWbtI26eHWmSxdxlm57KRAZPmH5B5YSBLLdyPBG9mgK2juTvSuS7
	m92sk5pwCn5YNaZ+g8Ub9MsP4EsILGlYq++Vr0foL27SxvKxZlGZomVPuU2St4DK
	PaS9dDQdHCPj97I2tdA578kDbwnZzGp11RSJNFdJ/WPUIZ/BmE0hL6z0jhu75tqm
	chyipcQ8PjnWQ2QeXDlO90qOkhCxkZTxNatdDAWRJFvkNmGRC873H2GFhHVanPJQ
	31pJPO58D8xZ9kvTYSDXl9iVRIfAm8DcunYI4ZC/j/cp08Ssm59z4J64H+MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743248207; x=1743334607; bh=8n2eL1Kr4Qu8s8etZah6R4nABuhrdUK3fJl
	OqtY8yaM=; b=GZvw99mwhofLin3R1dK9k7/Hq8dTgofBQzWv8NGuvJwgkOWuAxx
	/pkyQWW8Tan/VpGWctf0EUtvrlVp+SlO5+WhHIX3J3KIWdpclIFOMPWBCwytwSYr
	78qT/kyu2TyUO0IVCBQ1bA/oKslJAqXz0K1pJlkn8AoPLmpiwP43ImsJZBvHqjuY
	hagQ8cFLiqHzLiXXtI+/a/5AQ9919yk87nbQ4h3376HFiDTlcGXmGWbsUWOf2Fhy
	+vkO32oLiDQgSVT2cvmkm5XqeLzYclIPUi7bN7R+YVgQ+4izDf6GGa2wLgOvFBKb
	buKXmHKr8HrDeLS2njn5sCm13ttdBXxYSVw==
X-ME-Sender: <xms:T9vnZzIR267TLBmxg9NOZ2xKrYPSZyGqAMStpdEGUzxlzNO-_MWY9w>
    <xme:T9vnZ3Jax8Lx237CU00MYLzm_mhEiPpRyaqbTSjam-HqJhuVxvBWR_77wpHWuWdqp
    GHYnH_XvNYM83Gv6Q>
X-ME-Received: <xmr:T9vnZ7tGnD4dIVxauyqGs_6LLjWeXMf8eErxZg6He7n1LkqB3JIiHgcXJGrTZ3JdiolU_fjsF34FO1K66y7pt10i2jR6YKPTWryAqXs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeegtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:T9vnZ8aLXbMTwRgt8uMjPqZUgmg24ty_HTN6Ekq6VYJDGufvnQDVmQ>
    <xmx:T9vnZ6YrNDWTuhrSy5EJx0S-5Kx7YkWJSYoj9E2JXGL7DCPynwHd9A>
    <xmx:T9vnZwBWXDjTi8a9XxazBOag3W8yR79Fr3DHIGs-1wucpLl1dZ5I0A>
    <xmx:T9vnZ4YvMq9ER3h_hiPXb7dXbFYkyYbQj2wZbzx6_lNiVUiqc78O8g>
    <xmx:T9vnZxXpSy6R9x38Ed3ZoZUYSdszhDB5m78j9hbkmyK-jhDFWv7qNYTu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Mar 2025 07:36:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH 1/2] help: include SHA implementation in version info
In-Reply-To: <20250328170121.157563-2-jltobler@gmail.com> (Justin Tobler's
	message of "Fri, 28 Mar 2025 12:01:20 -0500")
References: <20250328170121.157563-1-jltobler@gmail.com>
	<20250328170121.157563-2-jltobler@gmail.com>
Date: Sat, 29 Mar 2025 04:36:45 -0700
Message-ID: <xmqq8qoodq5u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> When the `--build-options` flag is used with git-version(1), additional
> information about the built version of Git is printed. During build
> time, different SHA implementations may be configured, but this
> information is not included in the version info.
>
> Add the SHA implementations Git is built with to the version info.
> ...
> +static void get_sha_impl(struct strbuf *buf)
> +{
> +#if defined(SHA1_OPENSSL)
> +	strbuf_addstr(buf, "SHA-1: OpenSSL\n");
> +#elif defined(SHA1_BLK)
> +	strbuf_addstr(buf, "SHA-1: blk\n");
> +#elif defined(SHA1_APPLE)
> +	strbuf_addstr(buf, "SHA-1: Apple CommonCrypto\n");
> +#elif defined(DC_SHA1_EXTERNAL)
> +	strbuf_addstr(buf, "SHA-1: Collision Detection (External)\n");
> +#elif defined(DC_SHA1_SUBMODULE)
> +	strbuf_addstr(buf, "SHA-1: Collision Detection (Submodule)\n");
> +#elif defined(SHA1_DC)
> +	strbuf_addstr(buf, "SHA-1: Collision Detection\n");
> +#endif
> +
> +#if defined(SHA256_OPENSSL)
> +	strbuf_addstr(buf, "SHA-256: OpenSSL\n");
> +#elif defined(SHA256_NETTLE)
> +	strbuf_addstr(buf, "SHA-256: Nettle\n");
> +#elif defined(SHA256_GCRYPT)
> +	strbuf_addstr(buf, "SHA-256: gcrypt\n");
> +#elif defined(SHA256_BLK)
> +	strbuf_addstr(buf, "SHA-256: blk\n");
> +#endif
> +}

While I agree with the objective of the change, I am not sure how I
feel about the implementation.  Given that

 - The code here, and probably the existing code paths that depend
   on these SHA1_$WHOSE symbols, assume that only one of them is
   defined;

 - The "git help --build-options" is not an end-user thing but more
   is a developer thing.

The thing I am most worried about is that it is unclear how the
order in which the SHA1_$WHOSE symbols are inspected here and
elsewhere in the code are kept in sync.  What happens when, for
example, SHA1_OPENSSL and SHA1_APPLE_UNSAFE are both defined?  The
above code will report that we are using SHA1_OPENSSL, but hash.h
would probably use SHA1_APPLE as it has its own if/elif/endif
cascade.

Perhaps it does not matter, if the build infrastructure ensures that
the build fails unless one and only one of SHA1_$WHOSE is defined.

But with the way how this part is written with an if/elif/endif
cascade, it makes readers spend time wondering how the precedence
order here is kept in sync throughout the system.  If I am not
mistaken, the top-level Makefile has its own ifdef/else/if/endif*
cascade.

I imagine that making all of the above not if/elif/endif chain, but
make them pretend as if they are independent and orthogonal choices,
would make it simpler to understand and also it will help us catch a
misconfiguration where more than one is defined, i.e.

        static void get_sha_impl(struct strbuf *buf)
        {
        #if defined(SHA1_OPENSSL)
                strbuf_addstr(buf, "SHA-1: OpenSSL\n");
        #endif
        #if defined(SHA1_BLK)
                strbuf_addstr(buf, "SHA-1: blk\n");
        #endif
        #if defined(SHA1_APPLE)
        ...


That way, we wouldn't force future devlopers who are plugging new
implementations of SHA-256 wonder where is the right place in the
existing if/elif/endif cascade their new one fits.  It also allows
us to catch misconfigurations to define more then one of them at the
same time, if such a thing becomes ever possible.

Also, wouldn't it make more sense to just reuse the internal symbol
for reporting, i.e.

	strbuf_addstr(buf, "SHA-1: SHA1_OPENSSL\n");

instead of having to come up with "human readable" name here

