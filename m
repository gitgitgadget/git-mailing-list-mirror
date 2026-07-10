Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245AE36728C
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783653669; cv=none; b=RCYi8DwWh6nv9Ngk5RETSI4jhizlKRDYJBBvj7d7R0HLa9rw3ThL8dQefSoJleBme4KrxqSHZ8sFZWPRxJbIwnMjmUNphuLRK5VGTGvORJSH/Cgt4VoNrIizOht0Cl77KW3euuxR4nP3oyRAXIHqFjx44tWTLN6GpNFWQzC+ULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783653669; c=relaxed/simple;
	bh=65rDFrompcDKtqkrJpI91+ghnyzo2ZYuJhej749Esak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GVeYAARuphkc42RwaHnN8gQ8KHuOiL+33vrQRSQw+rVNe5BAfhsDqpQJfD9qmOiNj1gPueJlOBV1p3qM32nArSto92sQGfturSff9x6OoVF/v3a5Ugi7s9hmqjrQ8I8wkyCKRKpgqxma08ziXlIMfiHJ/JCr2G4GaAT+GVVKCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rRIAZXxz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=myWzsklj; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rRIAZXxz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="myWzsklj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 72ECB7A0025;
	Thu,  9 Jul 2026 23:21:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 23:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783653667; x=1783740067; bh=7Cevu03v65
	5jCS/KaQ9nbmPrSGqumlboRSl9UeKZp88=; b=rRIAZXxzXwIeXnWvqMqay+B/HE
	XF2dDxt6bvwcSPtat8FOXPgzkVuYvnlGLCf8JqQqUmbd1S+da7zJqa/iTcLfbQOa
	rY1tlNSdQBPCO+uO1Jgmjv1ZsDjwPadkGYiTiJQ93iy0szlxp1rvMSpMZGVjVEzW
	E6qMFss+Lqk5KobDw6Kt7Iy2jYo+0rVk7m4eXESieUEPRwJ3ZahReT7Jw8l9zKP8
	CmlhcHfnqFZTlsEVKqhvq6bRyTnf6DgYoPWkahN5WDrjD33+asxTMFKn7gjHEi63
	IlHzE/BwV/dLOWDnw4015C6igInFec4kgERAMpFY01qaboZDn9iJwV1W/qbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783653667; x=1783740067; bh=7Cevu03v655jCS/KaQ9nbmPrSGqumlboRSl
	9UeKZp88=; b=myWzskljNckpj4JRKwD/Olmg8E3We25y0jW4a4WD4rfERiiR5Dh
	G2EBQC0Y3LOzKF2MFaPHpT6+R2qQBzZk2DzINgdUul1PTucddw8aNYg06xji5+eq
	ZMTUm1JAKDQLTaSxa9uVbhr1shqVRZ5BTLMN1W4AiKWcTYlNaIy+clubl641LgEd
	3n3bifd2j2GSbTcx+IMH9IAx0h8KQCGr1wk9fKhvTYUJUwwAlkI29giTOIvXgpCS
	/QVC/UMgbjk0Ow+nQycVgtq5Eeiz8USARuU6CdZeerQOfcj7ThlQ6rKB5dpeMJXE
	o8OoSGIbXRH+veZlVIX0KMkApVMHMkOqXrg==
X-ME-Sender: <xms:I2VQaoWc1BrAE3M7x3YwDcnwwjUmww3Lp9T6q741s4Mq9Xp9OZRghw>
    <xme:I2VQajnj8HT4XioI1zdeBM3lfPGk3M-Dp7wey5RzC4Z6S-FpJW20_IKJY75M-7Uyk
    _ZQT76mR4HG_lv81lyiGAoz9baTzvmYU4kxgZT1USATOnXrWsZj9A>
X-ME-Received: <xmr:I2VQahYDLIs5ClvgnrVqbpibyOOi0NfHD53BLO3pQ7Es3R648cA8QLp_VX_rk6t9l-zuYIbIisQy6WRWiauMkTEcKSgYjpAqr19BjME>
X-ME-Proxy-Cause: dmFkZTFZFoog+pdO07OLdl9we1Uq2I4DZjSBADHA8bYgbosVo3AAYtku+LXTn2h5LUYkdf
    URIbWDf9u/kjTJs1SPnvITx0Mt9VCFiNVzROBuwxTg9zax0d5NFpHDCkTI2kRycvJQMDrf
    3JSauyH8nuvPUATCn01AIg+bPr7Bk62deWJWrO5TkKhDOJ2NIZP4moa3YQwXIYyxTrZs1W
    kzATX9/VkbG5aZ+1r/JQlt48z15zKZq95UZkL7qQFDSKZxx9CQs8HUZFEitLis/1h1rh59
    zxs6j2E5rJmS/Jet04DzhF3WTFWG6tx2G9zwI/d+pC8H4jteTz9KptP6F7k2p6tcvSEFGb
    unmCk5OhqVDAtoQMPkXJoSmGNBPdfVlK/Yv5DbCR6lx6N4isV4pd/5IREO8b4q0aoNqw1k
    LLphNs0yrXI/8Yr/u4PG/R86xxUB1o0bQTQlF8FOBxMOhsbIbY4IUr906PXExnUX7oWfa/
    ZTZqOYLkZI42Cqn8VesLL1flOCKcma8W2Qq2vLmAX+CSncB1/N9C03O6GtWxq2ibDApydF
    7vMeD9KffvlgTw6ZRpGlweg43MxxKQytCO+c+H4+5gmtkQ1rRslm+AqLVkfgYKyOdRv0FX
    yWD36dXNl+86zWGhqvmO9Ru94DvRdTcavxwvBIRUswWmUeefi4AuMwKia6pw
X-ME-Proxy: <xmx:I2VQamMi65GGsm9kT0nwDUhIuEi9SWQXK5A7Gw3s3luQVYwz2mwimA>
    <xmx:I2VQaubLh5zz9Ch19kwUrggwltTFhkpMnMAT-VUVghxKwjwPqoJP7Q>
    <xmx:I2VQas3CoGGcqbyTUCd_s_E06eI2Kz_AdDaqSQ7E_-MfXvvEYLnipg>
    <xmx:I2VQascyXuO54OQ75y3eFBzVCPsumkMcrcQXZC2ut67pF5fOHm8NaA>
    <xmx:I2VQauwKPoQ7k6T6KCfjgZAAyvirA3QaEEBCUsvDAEES7yrWyuTVxXOj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 23:21:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/11] reftable/stack: guard against NULL list_file in
 stack_destroy
In-Reply-To: <d7bc7fce35bb169a20a4ae9a1630e7080e133b23.1783590159.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 09 Jul 2026
	09:42:31 +0000")
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<d7bc7fce35bb169a20a4ae9a1630e7080e133b23.1783590159.git.gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 20:21:05 -0700
Message-ID: <xmqqcxwvh6n2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When reftable_new_stack() fails partway through initialization
> (e.g., reftable_buf_addstr returns an OOM error before
> reftable_buf_detach assigns p->list_file), it jumps to the error
> path which calls reftable_stack_destroy(p). At that point,
> p->list_file is still NULL because the detach never happened.
>
> reftable_stack_destroy() passes st->list_file unconditionally to
> read_lines(), which calls open(filename, O_RDONLY). Passing NULL
> to open() is undefined behavior and will typically crash.
>
> Guard the read_lines() call with a NULL check on st->list_file.
> When list_file is NULL, there are no table files to clean up
> anyway, so skipping read_lines is the correct behavior.

Nice spotting and recovery.  Well done.

>
> Pointed out by Coverity.
>
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  reftable/stack.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 1fba96ddb3..3fc3c0b2d1 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -171,7 +171,8 @@ void reftable_stack_destroy(struct reftable_stack *st)
>  		st->merged = NULL;
>  	}
>  
> -	err = read_lines(st->list_file, &names);
> +	if (st->list_file)
> +		err = read_lines(st->list_file, &names);
>  	if (err < 0) {
>  		REFTABLE_FREE_AND_NULL(names);
>  	}
