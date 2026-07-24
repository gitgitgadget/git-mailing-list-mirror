Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5B377AB3
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929592; cv=none; b=SMw49NnCbpQocHpqw9ii7HVAV3C+KntsN35/cmvybqjvd/snZJGLeT2TT/EwkgAovmxtRlGcUM9sm5rHJvpIAqfpF3PSFGwEOcr8MP6su/Eqacl8F3oce68t1LCY4vWNgX8uXMWvwRGgS6gYYOvc5f4eDzTVH1nKjjswVpmdpjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929592; c=relaxed/simple;
	bh=7/Fn4p0m8UdlmN/DZxBvUCkVSEfFp0YhzTMSEBEfriM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIVkxYeBbXBSCwCw2GAjPiRXwM4vVwW75TiwGXGt5FSJXc5+OzlTDTLPBlEsVg86DTH5fw62QMldPIUEdtWZFR5lPpOo7wYTEFRoOOmTdHbzY+k7M5AXE2xZo6dZaL60yXQddIr1LSeG2/w5DpXjhzfB6MF8CBZZmmCD49Uxx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=BDKz0yq8; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="BDKz0yq8"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66843304cbaso906716d50.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784929588; x=1785534388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lUkyAz7x+E2RaIcoPAPbP3SPDisO44TFthD7H56Gzl8=;
        b=BDKz0yq8kQlXjtLAtlFQf8Syq08qiek2YBTMXJi2AotYGajrzUZodIYba68j5WJGiI
         IjSlGJ/R0rjZk+NqDPk3kb84b2c9QtleWRGmHHrDfBHyYmsjYV7pYRUkcBAsaAvScTOD
         ocrp0Ds259D8t/BZdyEmWSHkK6U49Q2rCRWlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784929588; x=1785534388;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUkyAz7x+E2RaIcoPAPbP3SPDisO44TFthD7H56Gzl8=;
        b=na+yZC790Kx/Yys8m8RjoeNfrtctfZ1RllxZADQp4rHF2ZCpiMwXSfsu+r8Fg+Y8NQ
         Tl4EhLH2ICKHZFMLuLlspgzFuys21dJCJxecz+Mtki6xeWFxe2Cnyca2pIs3TwBx/+3X
         EvqWGYyOuTh2ptxxPAjiyfZL9bR/TLjhce2kwB7ydCl5p5VpoR0Vn2JzKy0WkomQ8tbN
         b8dHjsjiaQZyJNj4oTKtV8/jg/lA8jEYNlC3uA4IucwR404TC0BDihXLykpUR43YkJhP
         Dw/5vqSBy7SXyLgNsOpVWDsRgocS0KEQVhKXCs5wroR4st8rYYuFuOIMJjmZB2dwCyDo
         5PAw==
X-Gm-Message-State: AOJu0YwHvWu2GcMZM/xj5M9oZ1nIh9DRbFSz/8qJxzdsLGg0bAcTDyG7
	4vt0b33UCaaPehaXywpt1UsJuUkOvVnucnoNJ1MSqOm88i/y7463Uu/bmSXer9iPLdo=
X-Gm-Gg: AR+sD11PuTdqgwcAMOiDI26Z7CukoB+ZZQKT4GK5fNmVj7JAhwnCxswdiI2Q+s5prPE
	W3ofljAnKHQFVC+fYyM8rrpsiszjBhmNra9efph8tspmHFhVk/pZG1twjLXm0jc3iTS0Rz61MDo
	Z2bPhSZCUnpnO6f0tKJicRi9zBnEDtWXqgH9+FVI1rFiBHzBDyHI8JlD7bjzuax1OWl8NTRv24n
	ACcA5chPWMYgWFOiGqFCRjvOukYTCIjRfAr6Jb1ipR1I0TtIDtvV0wjoxApjHBFRHi0Nk2dCbpW
	HdZi7CTPVkmnZtYrkIg78NHxgEJT3sOzII7IIMo++BDgq3yidtV8WWqsidA5RMRsKBueqfzkYqB
	kZQP3g8oX8YW5y0Qt8aJT0IvPemmOx+D250w7IyCdvg5gXwVOqAg3/aC7rNfWw+iNesQEPo3I41
	si5WR4BbNrzqH455fKh50o9NgqI3czJf8GaqasSdpFNlhBgUIFnu+4RD0NLRbECQpU6DJ5DjV6Z
	ics6O2NCWZp+hCtE01tBACSBhgVdLH7pJQSoOSg8jSmerls/9kEsBuHmXWt1kuytg==
X-Received: by 2002:a05:690e:4382:b0:668:8b09:bd13 with SMTP id 956f58d0204a3-668a4baa723mr1703101d50.18.1784929587826;
        Fri, 24 Jul 2026 14:46:27 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c6ad2d93sm78773d50.0.2026.07.24.14.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:46:27 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:46:25 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
	ps@pks.im, karthik.188@gmail.com, sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: Re: [PATCH v4 3/3] fetch-pack: accept "pack" output for packfile URIs
Message-ID: <amPdMQH3QRLnDpl0@com-79390>
References: <cover.1784676106.git.tnyman@openai.com>
 <cover.1784874850.git.tnyman@openai.com>
 <d9063deb60354eb731e34c453cd6730e1098f905.1784874850.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9063deb60354eb731e34c453cd6730e1098f905.1784874850.git.tnyman@openai.com>

On Fri, Jul 24, 2026 at 01:14:25AM -0700, Ted Nyman wrote:
> When index-pack finds an existing keep file it reports pack rather than
> keep. Accept either result from http-fetch, and only register a keep
> lockfile when this fetch created it.
>
> Read the pack/keep prefix and hash without consuming any following fsck
> output, validate the reported pack hash against the advertised hash, and
> exercise a packfile URI fetch with a pre-existing keep file.
>
> Signed-off-by: Ted Nyman <tnyman@openai.com>
> ---
>  fetch-pack.c           | 33 ++++++++++++++++++---------------
>  t/t5702-protocol-v2.sh | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 15 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 29c41132ee..e9f24fbd63 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1887,9 +1887,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	}
>
>  	for (i = 0; i < packfile_uris.nr; i++) {
> +		bool created_keep;
>  		int j;
>  		struct child_process cmd = CHILD_PROCESS_INIT;
> -		char packname[GIT_MAX_HEXSZ + 1];
> +		char packhash[GIT_MAX_HEXSZ + 1];

OK, so we keep track of whether or not we got "keep" as part of the
output.

While here, "packname" is renamed to "packhash", which I think is
reasonable, especially to indicate that the buffer is sized accordingly.
We happen to read the preceding "pack" or "keep" into that same buffer,
which I think is fine. If we wanted to be pedantic we could read that
into a separate buffer, but I don't think such separation is necessary.

>  		const char *uri = packfile_uris.items[i].string +
>  			the_hash_algo->hexsz + 1;
>
> @@ -1907,16 +1908,17 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		if (start_command(&cmd))
>  			die("fetch-pack: unable to spawn http-fetch");
>
> -		if (read_in_full(cmd.out, packname, 5) < 0 ||
> -		    memcmp(packname, "keep\t", 5))
> -			die("fetch-pack: expected keep then TAB at start of http-fetch output");
> +		if (read_in_full(cmd.out, packhash, 5) != 5 ||
> +		    (memcmp(packhash, "keep\t", 5) &&
> +		     memcmp(packhash, "pack\t", 5)))
> +			die("fetch-pack: expected pack or keep then TAB at start of http-fetch output");
> +		created_keep = !memcmp(packhash, "keep\t", 5);

Makes sense.

>
> -		if (read_in_full(cmd.out, packname,
> -				 the_hash_algo->hexsz + 1) < 0 ||
> -		    packname[the_hash_algo->hexsz] != '\n')
> -			die("fetch-pack: expected hash then LF at end of http-fetch output");
> -
> -		packname[the_hash_algo->hexsz] = '\0';
> +		if (read_in_full(cmd.out, packhash,
> +				 the_hash_algo->hexsz + 1) != the_hash_algo->hexsz + 1 ||
> +		    packhash[the_hash_algo->hexsz] != '\n')
> +			die("fetch-pack: expected hash then LF in http-fetch output");
> +		packhash[the_hash_algo->hexsz] = '\0';

Likewise. The rest of this file and the test also look good.

Thanks,
Taylor
