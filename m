Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210CF30E820
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750384567; cv=none; b=lQF0LGE5SdFK/JlnvvczGnwjD3TvLdGK4MSHJZDpHHwX/ZJHe/PeQoNUeIqlcsfLaUwugc3fajef9Q5snAABPv+uGBmvrhvqp/WkOyuYgMAACC8HOFgyZcEWf+VCnUfH/LMFVStU5ycxUx1OwlebQ6fF88bIg7xTzrcOVYY9wZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750384567; c=relaxed/simple;
	bh=huyx78vILN9oR2jf54a8BAMFKWz+XgTW3XEsTrTtRfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U4Com2cj8JKB/G5z92yHhw8G+n0lt2p/HO7llqoRRW+FQoCzVveBDf4SFwkM2pmxGPVFc5uNVGSWnaSqhjd5qXTR1HKR0IpVAMLSQuYf3prsMNqWlvviIr+5nOayJD9u3PrChvuz27vQ0nAu+duWiCqpCqwSsQZ/eTY3usaReqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CgolTeS/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gHZPAnKv; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CgolTeS/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gHZPAnKv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CB961140123;
	Thu, 19 Jun 2025 21:56:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 19 Jun 2025 21:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750384563; x=1750470963; bh=6+P2V35mce
	lbiZKTeobmHXZJaq3GU+heUTpwP2Y5bTg=; b=CgolTeS/uNdQNVHqBteMdd9j3w
	G41zYykyobrF8EQDpaiP99ECSs5rDTCrFKPtEK2aDC6/NNbgP7jhrKwzkhd+jrEs
	gUU+mgyoyRt+HiiHChzl3CpvJX2JipfFOpsA1j6b17v/UisX/ohdNxKH6c1pb9V0
	MZUgetPzeCcSp071yw3/x+/P/KOP+Fc+PBMFnCrY7AVANdFCt38a5IzHQ+DuXfFo
	9+jlyZp5gYKg1QlDAjCvvQp0AU+4Icg1eJyy6FqeAZ/Xs88mFByVIZ5XscRfEOrA
	OQ7dqDcuSL2hDr3C9KGPYDPIsMomAeZpdzTImBrHIuoCmuIKU2TElsbbOkSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750384563; x=1750470963; bh=6+P2V35mcelbiZKTeobmHXZJaq3GU+heUTp
	wP2Y5bTg=; b=gHZPAnKvdVPr5IG4eqruNPzEC6JH2QBaZJggYsYsMefOm0FX+dx
	FSU+K+W2Hkx9v864X2JwGIMcwlirEam8M/jdW8sD88Z6dVGxtn32ZXIRWFlIMHL5
	lDN7mg4sGjjoJFc1JyoFBYs0PA6X1m4oczDF1pwPO+D8fNXCO7tz4ZMsbEsgNZPc
	aKdZmZOVxpzslPBJ7GqGMykEiAEmXmE8gE0/nVUmmUKR6Hyj10+R0yZ/AQGjeQiZ
	Oj9aYAYS0G0RfMiilzZ1dWGpR4bO67fZiNQcJwYrXK/6vNsJ+3luzoSO7fACTlR7
	cBE9PuqE2JoC0pPwhc0mcmwIPIl9xDcStMQ==
X-ME-Sender: <xms:s79UaOwlGNJSonWGB_obCr8ydflRIUg4Wj9qPZHZDf2x4dGfSs4nAQ>
    <xme:s79UaKRJ4Asy5Trmtcf5-L4eGbq1dLoYK6HrFStnZO7KaI2Bomvu14MgDJqVjJ5VC
    yKOKk2lvS4FfnMjxA>
X-ME-Received: <xmr:s79UaAULOaMJXBQARHWYcCNfpBWN5fjiB7Re3OeSVgnBqYkCD4nhfhUbDJPtFr72cUDQuWZq6to-VztEIpU39syKZQukSyGmn9qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdejudegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:s79UaEibr4LkLZPXtlhi-1Vb06ZeTLbTKKSCgW7-IIQDOaks87DmzQ>
    <xmx:s79UaACS6zwZqLMg-we_SeHND0hhF_aHmy0bwoD4GX1ybcudEFRd1Q>
    <xmx:s79UaFLGX67HnCN99owOsx1zq-Qhnm6jmkGH4G3_m4P3H2S-soo11A>
    <xmx:s79UaHCuKq3l0I5qpUboYXDm3gCGaoJUJ76X4IPKaQuJDcmEL0Mqhg>
    <xmx:s79UaNO6ihKzd0YVLOYRvp-L_PfRU62nPOgp2NF9sON7fsHNCCRKtB4f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 21:56:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 02/10] hash: add a constant for the original hash algorithm
In-Reply-To: <20250620011943.586596-3-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 20 Jun 2025 01:19:34 +0000")
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
	<20250620011943.586596-3-sandals@crustytoothpaste.net>
Date: Thu, 19 Jun 2025 18:56:02 -0700
Message-ID: <xmqq1prf89cd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We have a a variety of uses of GIT_HASH_SHA1 littered throughout our
> code.  Some of these really mean to represent specifically SHA-1, but
> some actually represent the original hash algorithm used in Git which is
> implied by older formats and protocols which do not contain hash
> information.  For instance, the bundle v1 and v2 formats do not contain
> hash algorithm information, and thus SHA-1 is implied by the use of
> these formats.

Does that mean use of _ORIGINAL is a sign that these places should
keep using SHA-1 and should not change?

I am having a hard time guessing/assessing the value of having _ORIGINAL
that is a synonym for _SHA1; with redirection, it pretends as if the
underlying value can be updated from SHA-1 to SHA-256 (and that is
the very intention behind GIT_HASH_DEFAULT symbol that gives us a
level of indirection), but it is hard to imagine we would ever want
to change what _ORIGINAL means, as that word talks about a historical
fact that will never change over time.

> Add a constant for documentary purposes which indicates this value.  It
> will always be the same as SHA-1, since this is an essential part of
> these formats, but its use indicates this particular reason and not any
> other reason why SHA-1 might be used.

I am not sure what this means.  If we use GIT_HASH_SHA1 in such
places explicitly (as opposed to GIT_HASH_DEFAULT), isn't it a sign
enough that with different versions of Git, that particular code
path should keep using SHA-1 no matter what the default is?

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  hash.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hash.h b/hash.h
> index 0d3d85e04c..0e14cade4e 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -176,6 +176,8 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
>  #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
>  /* Default hash algorithm if unspecified. */
>  #define GIT_HASH_DEFAULT GIT_HASH_SHA1
> +/* Original hash algorithm. Implied for older data formats which don't specify. */
> +#define GIT_HASH_ORIGINAL GIT_HASH_SHA1
>  
>  /* "sha1", big-endian */
>  #define GIT_SHA1_FORMAT_ID 0x73686131
