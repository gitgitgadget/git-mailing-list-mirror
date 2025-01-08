Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE961FF1DE
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350523; cv=none; b=Ovii49MjkVxzm1UH+2GFImFnXh2w1XsNrATi3hVzHbfqT3ZvG0AQvnyuSqbQq9LDtzF3haAQmkJhm8Gpb1MPBnAYX4cVOK5nfjy0K1ANgHyxja3GysVskCRM8e2Bv1FMsSKpX6i481qy6z/BfdDv6i2uiptikWVd15OluPuavk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350523; c=relaxed/simple;
	bh=/hmeEsGlbiP+hKqGsrhAha9cOH6blTeED3F1cwwHLtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eo1qCosqHhUo7Aw+bV3tJuDnliZN5tIEDckjbf2Uib2Mm6UPGNjfT8Tyn8USjL+Ojs8UuZ+UcpDGx3QeoQDhlQlmNTJBiIVSyzvpMki6ft0e/LgHA5Pnp+Bl9gq4W1Em6+j2P3rtJpjHuf8lFlKF3CXO6bNMIAm7G/CeXo6Fti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zrYGmlww; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDUZ+27J; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zrYGmlww";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDUZ+27J"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3AAF3254016F;
	Wed,  8 Jan 2025 10:35:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jan 2025 10:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736350520; x=1736436920; bh=4U3gomhZ18
	AXZiO/khqHP3v0Xm26+ux+izXC4xyDnAg=; b=zrYGmlwwAiym0NxJKx1UyIGcZT
	It5iW/tPZdd5Z/64BmoAKOWMTm+acJGQqptPtdEK9UskOszP7X3PQb6wC84fsfQw
	YwduYjdF+yHZxn4/wf5+BAw4u1+nUjcfyHMpOHqCWtWVQIRLdqxNv79/5bg4MIdg
	EtNPSODcJOScrBuBJqJNv/VpUabNOg2sPQKOCGy0nQT3kZU+rZqhQ0DlIq99Dsnu
	BNCTq6uO+pxNto173cJyjwDZdaGADFI9yRsDoTlQN7nxGeHch6En1IGzLbbbfRmi
	Q23pGuXNYPjH0Jnpnb6XOPkPd0V6jQB3KLKvCYypZITRpVUVCbPqjluzA7PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736350520; x=1736436920; bh=4U3gomhZ18AXZiO/khqHP3v0Xm26+ux+izX
	C4xyDnAg=; b=XDUZ+27JYX/i0QfSgaaxpP4EAhtYDAZQowuaL67GJ4B51EZ2NB9
	dlW0OcRbjdsJM0cXMzLwSRdKyN5h7TJdFA+mfDjvc+1GHhL1tJLT1igMwrLndWbe
	54fUrpf0qt9wX/BqE/xA5JAWMM7Jxrqza6cWRxezX9JG9Nbq98x+aws/xI7AOtfT
	QPDTJ8h/mkszLwUpQ2Ws2iZdSa1ozd8W9boMehyZJRUYlPFZQEKLNJOVqtsDwSJz
	aVB+Ll7RVkuOcivWJPJsyGfYQZ7fJoodzThQ7wyZN48ozlJlgYU0w3oOH5eWn3NQ
	c5bG6qiMYa6c1P7bo6BKt3dLDsTW1pW4dJg==
X-ME-Sender: <xms:N5t-Z0BWNYbO4daB9coaJzPifDNyjcR-8OIman681oui7fbYKOrfHw>
    <xme:N5t-Z2hVKVu-LGD1LTfVLI8bYLsBNIIwWZZfy5WbnrRDtE2aJ9D1hMGMQVKTkI4id
    mYs90xhT8dHtq4oOA>
X-ME-Received: <xmr:N5t-Z3klldaH06nXAQtZgLzGbJjZwo1u5RnC5FndhB5WlNPKwTMrF8D59mDuRwFM-103c7IC2RW7ojrQcGzQFG-zFFxzJs2yWtJ3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhile
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:N5t-Z6wWmxuLxcd8XMb6pOBDdI62l1eu3s1-KY0zwZOcSL1GkE4AHg>
    <xmx:N5t-Z5TzOmKFZNuy0dc8q-lNnm8TmK5mItVz_Ph18NlntBXjWrrCSA>
    <xmx:N5t-Z1ZKRy_8XOEPHx1Uv3sqR-e0a5fwNdcXq3oQjdZ5yyASQPTLiw>
    <xmx:N5t-ZyR8CbzNTrdX7EJhHWdSsQ-IP0bs2ucfwsQeqCXKphwdoG3hfA>
    <xmx:OJt-ZyKIUtprr97IiU9c_l9ivwq0cQujurOszj4nbSSO6Or4drghJ_w6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 10:35:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] t/unit-tests: convert hash to use clar test
 framework
In-Reply-To: <20250108120339.225596-2-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Wed, 8 Jan 2025 13:03:39 +0100")
References: <20250107091932.126673-1-kuforiji98@gmail.com>
	<20250108120339.225596-1-kuforiji98@gmail.com>
	<20250108120339.225596-2-kuforiji98@gmail.com>
Date: Wed, 08 Jan 2025 07:35:18 -0800
Message-ID: <xmqqv7upnwsp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

>  CLAR_TEST_SUITES += u-ctype
> +CLAR_TEST_SUITES += u-hash
>  CLAR_TEST_SUITES += u-strvec

This is inserted in the middle, presumably because a list without
inherent ordering is by default maintained as a lexicographically
sorted list.

> diff --git a/t/meson.build b/t/meson.build
> index 602ebfe6a2..d722bc7dff 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -1,6 +1,7 @@
>  clar_test_suites = [
>    'unit-tests/u-ctype.c',
>    'unit-tests/u-strvec.c',
> +  'unit-tests/u-hash.c',
>  ]

So, shouldn't we do the same here?

> diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/u-hash.c
> similarity index 79%
> rename from t/unit-tests/t-hash.c
> rename to t/unit-tests/u-hash.c
> ...
>  #define TEST_HASH_STR(data, expected_sha1, expected_sha256) do { \
>  		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
> -		TEST(check_hash_data(data, strlen(data), expected_hashes), \
> -		     "SHA1 and SHA256 (%s) works", #data); \
> -	} while (0)
> +		check_hash_data(data, strlen(data), expected_hashes); \
> +	} while(0)

Unwanted droppage of SP between "while" and "(0)".

>  /* Only works with a literal string, useful when it contains a NUL character. */
>  #define TEST_HASH_LITERAL(literal, expected_sha1, expected_sha256) do { \
>  		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
> -		TEST(check_hash_data(literal, (sizeof(literal) - 1), expected_hashes), \
> -		     "SHA1 and SHA256 (%s) works", #literal); \
> -	} while (0)
> +		check_hash_data(literal, (sizeof(literal) - 1), expected_hashes); \
> +	} while(0)

Ditto.

> -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +void test_hash__empty_string(void)
>  {
> -	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
> -	struct strbuf alphabet_100000 = STRBUF_INIT;
> -
> -	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
> -	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
> -
>  	TEST_HASH_STR("",
>  		"da39a3ee5e6b4b0d3255bfef95601890afd80709",
>  		"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
> +}
> +
> +void test_hash__single_character(void)
> +{
>  	TEST_HASH_STR("a",
>  		"86f7e437faa5a7fce15d1ddcb9eaeaea377667b8",
>  		"ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");
> +}

OK.

I'll skip the rest as I expect they would be faithful conversions.

Thanks.

