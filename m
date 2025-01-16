Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E819CC39
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033186; cv=none; b=cY09ctodlFGDsKfa5AH/WQRdJMnn8rVeHvvXOkEuDBinasOtJ50L3e3N3V59AdgfC8e2friYth7XTQnQPaC/VVOylVPMhTiUY3p18MMWI2fFUZRoTdr29FTjIW4Z+Gv57F+BJAdZEe2Y+ZRDYAz8Gdp8ZSd+O6iOkI7r7SVQsVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033186; c=relaxed/simple;
	bh=oMZptAEHhGDb7pMqOtJ4S/SuGbfg0IRyLcIpNK9ANyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWczACYk7WfGrlnbivJ3UurYz0LT4V7IxTqlfWVGFtChcQ6KU1eik7oLbACMxKzXkz9NKgx785gPFhPenhgLOCEUTRoUOd+DOUFRhxXlIsMAZ6OxNjH3dG4vGp7D5Lawj7z1FiBskogVrRoC3iTRMjtvl/lauwP2oFadHvFBDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ViG3uJKg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bqW7fvGI; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ViG3uJKg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bqW7fvGI"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 891BE254017F;
	Thu, 16 Jan 2025 08:13:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jan 2025 08:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737033183; x=1737119583; bh=T6GEQIa1uP
	mmxPp+rYIwY7HUp0SnCA6DowsSeRmGiRo=; b=ViG3uJKgK6RVty78MZDoudNwkW
	+f5leueXZySxF6VNj4zZ5gTIjuqLkBji4mfjtdPgsQmz3m96ABmNWc6zZ3KhpO1Y
	DW2vnwwYah0e4+LKq735N14c62tTnkEVydb4rCOFLhyvIo7fb8yigPM1dw5lp04H
	a6xkjHeOhamZ1G2cJFEd7kjxfg/wb8iHq1SjpWeyMTJ+Fz1dFKYbcd51v8bN/nvn
	6ZKMs7npSBJDpLuIaTvYmqIlV9Flw/fgBaT4sD0G1djMHoM/NKrk6WUC0xWvQ1xV
	9kctLDwFmlWBIKdz/WDhxJoPXZ7AVAT1awXvkzjz9fJ2r7XfaWYNfkTVZLmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737033183; x=1737119583; bh=T6GEQIa1uPmmxPp+rYIwY7HUp0SnCA6Dows
	SeRmGiRo=; b=bqW7fvGIbY5PZfpcZ1vxOtrQsATpDxyiNn3/yDZaWDFWsq+c5FI
	NECjnj3MNByiRaoQovVEsNxtVNg+5MeL64aV9nVVt+VPYaypQApfUKoKXvC+0jvC
	USBwj++bLURv430+DSgMNmb3J5iMp3IHHP+6Vq3F/UrvPWQyLLr/fYVMLftlJ5i0
	4dt8F3z4aL+5iDPHM2zDgGFL+IVutD90jfc7c3HdFvsBao/PlnZ6Sunjt/K3eN4I
	Ojx/7WDmDo96kyPhXGIBdgEi1f7OuJHE+8+45lrjacmhbueXmlkPYv0b/X5IhH9O
	nXyxWONXTqjcCk4+MLiQpSagHTpYGalvCvw==
X-ME-Sender: <xms:3wWJZ3eiS76gnNwZlaHF9YxkDs_VhRNmgs14eEeGxksBhmA008Ga-A>
    <xme:3wWJZ9My1TksUrVdNYw8EBXEioIoyE0bZA4_9vVQEaPf7HxQRPgNxrOW_OlVZiliD
    K-qjy5InBxh3zGTXQ>
X-ME-Received: <xmr:3wWJZwiOVPeiasuSswpBd-zHIk7BRaAsyLuhIGcIEmlSX0RPH0w8O2Iye2TwN7EMzq62BohIpv--AK_7yfi68fuPph2V082E_aPqUcgp6uME3zGHQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3wWJZ48V32oKswqeOK8u8xHbn4pYTsw0jsjoDVonLG6Cy8T4Yko28w>
    <xmx:3wWJZztscgw4ONIZFcqTa_tHeislBmtUBqXAMHhiQn232HVhliXv8g>
    <xmx:3wWJZ3GzP4vw6cyf-n9vZUqFapp7nxmnweU7FpSvOTqaopukqyOhww>
    <xmx:3wWJZ6N-IGKt4HHWIrIOmtJgXCDmw2kPwOz-qoOht46nBEMfmM_KaA>
    <xmx:3wWJZzK2podQIUuZgIoHw-FMufFRQb8Ef-iZ6rEQBHSqv6i-Tu2cpceL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:13:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46032de4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:12:56 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:12:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/4] t/unit-tests: convert mem-pool test to use clar test
 framework
Message-ID: <Z4kF1zR9TA8ff2bl@pks.im>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
 <20250116104911.77405-3-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116104911.77405-3-kuforiji98@gmail.com>

On Thu, Jan 16, 2025 at 11:49:09AM +0100, Seyi Kuforiji wrote:
> Adapt the mem-pool test script to use clar framework by using clar
> assertions where necessary. Following the consensus to convert the
> unit-tests scripts found in the t/unit-tests folder to clar driven by
> Patrick Steinhardt.

I think it's a minor detail that isn't really worth mentioning that I
was the one introducing the clar, so I'd leave my name out of it. This
also applies to subsequent commit messages.

> diff --git a/t/unit-tests/t-mem-pool.c b/t/unit-tests/t-mem-pool.c
> deleted file mode 100644
> index fe500c704b..0000000000
> --- a/t/unit-tests/t-mem-pool.c
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -#include "test-lib.h"
> -#include "mem-pool.h"
> -
> -static void setup_static(void (*f)(struct mem_pool *), size_t block_alloc)
> -{
> -	struct mem_pool pool = { .block_alloc = block_alloc };
> -	f(&pool);
> -	mem_pool_discard(&pool, 0);
> -}
> -
> -static void t_calloc_100(struct mem_pool *pool)
> -{
> -	size_t size = 100;
> -	char *buffer = mem_pool_calloc(pool, 1, size);
> -	for (size_t i = 0; i < size; i++)
> -		check_int(buffer[i], ==, 0);
> -	if (!check(pool->mp_block != NULL))
> -		return;
> -	check(pool->mp_block->next_free != NULL);
> -	check(pool->mp_block->end != NULL);
> -}
> -
> -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> -{
> -	TEST(setup_static(t_calloc_100, 1024 * 1024),
> -	     "mem_pool_calloc returns 100 zeroed bytes with big block");
> -	TEST(setup_static(t_calloc_100, 1),
> -	     "mem_pool_calloc returns 100 zeroed bytes with tiny block");
> -
> -	return test_done();
> -}

Mh, too bad that Git doesn't render it as a 

> diff --git a/t/unit-tests/u-mem-pool.c b/t/unit-tests/u-mem-pool.c
> new file mode 100644
> index 0000000000..36e31a3201
> --- /dev/null
> +++ b/t/unit-tests/u-mem-pool.c
> @@ -0,0 +1,26 @@
> +#include "unit-test.h"
> +#include "mem-pool.h"
> +
> +static void t_calloc_100(size_t block_alloc)

Can we maybe give this a more descriptive name? Something like
`test_many_pool_allocations()` maybe?

> +{
> +	struct mem_pool pool = { .block_alloc = block_alloc };
> +	size_t size = 100;
> +	char *buffer = mem_pool_calloc(&pool, 1, size);
> +	for (size_t i = 0; i < size; i++)
> +		cl_assert_equal_i(0, buffer[i]);
> +	cl_assert(pool.mp_block != NULL);
> +	cl_assert(pool.mp_block->next_free != NULL);
> +	cl_assert(pool.mp_block->end != NULL);
> +	mem_pool_discard(&pool, 0);
> +}
> +
> +void test_mem_pool__big_block(void)
> +{
> +	t_calloc_100(1024 * 1024);
> +

There is a needless empty line here.

Other than that the changes look good to me.

Patrick
