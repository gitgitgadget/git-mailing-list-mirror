Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48932DA746
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263972; cv=none; b=jarBw1RV8K9XIsayvb0EcfI1iQFiSnOGhYZpSiIiv+igtQ3lwn7+DwBG3lS1zf+FGZ8AsHisYGqP2TKms1F/E+Ym3x3O1sPnuKLSWvHwMiwWjZqpbXmEd6Tjdni8wHIybTasyLMW0PXxt8cJTMBmdRFle4JFNI+oZ6sTV6sOMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263972; c=relaxed/simple;
	bh=fIEeiBycb9ADc0CRtt9HkxLJiePmdKIgY/CiuGQdVng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaAQpkL3zgB0FnhxUFgMVuqBs2zj2weINaKjQ5MxQecy4mug9VTR/7C3mllG5FLhsjBRW5/DNh0WOikmj7I9nnGqquJ9sV2sDMYSlmgyXfabm1cl+e7GzB7WIzjEJtsFi/0BVBMTBd9z9nfkg0yVCTca94rpkCkJb072uexOchY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=KN0VLuDH; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="KN0VLuDH"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7832691f86cso18194767b3.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761263970; x=1761868770; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sGxFDGdM2JcaxesIDGeQZvoe5wp5I+WGnh36aEzoWPI=;
        b=KN0VLuDHry0J8sHXZqfRLdaO7pbDy5LM5LRWYJgnQup0dmjgBbexqU+k8f25PZzGNe
         M01zxphcU10W+msGxSOiRClTBSUi1772jnVGy5U3kdCyXKB1AtIdk2nNXuCYq92+3QfR
         TYiTt69XmYaFHSsIJut/4PJbvYdTHBHSytE7GL6glZmBfOOTlI0wX5hQpc3cddoxFWK2
         2G008dG/kQoX0XD6rGZw4Vkdpx6iGLbD3isPwaCJ6wQoVZAiinUpaLyRd+sp3wPY77ji
         EnN9DWLlofDJr03Euwi9lITGIH6zWFEySbpnIao/gm13uN+SP9owK5HTg5huGqFi/jH3
         VPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761263970; x=1761868770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGxFDGdM2JcaxesIDGeQZvoe5wp5I+WGnh36aEzoWPI=;
        b=uz7zCj/9jBovvY444f8JYewv3gM+v+Nn1FTPAfs4jImYPu++kXfF30YEPFQ0TKcZHH
         Y4iDs2E1PIm/3vBMhwVOBZoceeUW7eV0dUlEJHBxldp0mXR2W5RiWxKHALkNOi1v0xNp
         mFNHhznEZ+lORnwFJIpuNfNLGquQgRB+aur9WqPKOmBWDDYjHWvsaAT5gMA93Teh0o8P
         kgYc6nL5d+WPC7X/kawjNGamTRfnErClMsK00eH+E1tq0Bv4fl/NDktH2L407Tpo0qdh
         8ux2QsklfKeYWrK9T0SjYM9tCflBn5MB8gCiyj/6JAllRjijYCaI2U4oWut5pr9qxxrs
         S92g==
X-Gm-Message-State: AOJu0YzDQz/wKDasDbYKroevFHMnY4t5PPuyvv91SQXYqjlkaQqfPtYg
	PlgzwY9RgURv73yZqzjRwK7/Dbe2u+Qas30CtL44g/8zN5R1nCD13doKihtdiaeLeYo=
X-Gm-Gg: ASbGnct6NwRESqlgKhE8dANkTpGLvsDQ4KvXQLhJNfz9m37GEPKm1h7JpCUGs8HTCH9
	g9lKZ/xXgXOmR58YQI/5LkfmXV1CAaFg4M8r3oAdv0be7c06qg5XfeJ58Gb9avna7aIbOEQGZ0W
	M2N50t+5LLKqCiodnvb+3K8ufii/yiKSmqu4v6PI7IzQ29m1UAva4CLxdL3X7/EWL0YJyomX+tK
	f3sjXqBCnIShHeqVdO+aKGUFWhIHEw8UOPV+UXt4v7E+TywWe5mqdeFWmgW0kpH/VcNYi5gUlnb
	7qgTSlxkYl2IYliLL2xTh8O8ogVGDqLEgP8PqUeyeMtQ5y0Z5zmIGMkeX963g2057XxdkwOosSs
	j8+TpRCByaRhDkRZp/19K0Fk9nsapOLBMSHpThaMVp/MXdRWKBn999faIN1HfN+5mMLUIjLdQc8
	xH5rvQKvj7LyBJLjWfffE8+hVhxaln0kXrdr7hRgfT2hHhm+rjj1FGP9pbYqmagK2xaJxhFiNTH
	nXfu4NykaTfxaYjMQ==
X-Google-Smtp-Source: AGHT+IEyIOXSs70+1mGoJAldJH7Mad1VNx8wCFIGyRCuQ6EEnBN/pabriwt6pW5cdoUC1pP+BqyOiw==
X-Received: by 2002:a05:690c:b06:b0:784:960c:e3bf with SMTP id 00721157ae682-785e006c4f9mr1789487b3.8.1761263969651;
        Thu, 23 Oct 2025 16:59:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-785cd5a5fddsm9810647b3.12.2025.10.23.16.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 16:59:29 -0700 (PDT)
Date: Thu, 23 Oct 2025 19:59:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] last-modified: implement faster algorithm
Message-ID: <aPrBYGa6HWUtTI4V@nand.local>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <aPGB/FJtjDmyNLvG@nand.local>
 <87jz0tu3yh.fsf@iotcl.com>
 <87cy6gtym2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cy6gtym2.fsf@iotcl.com>

On Tue, Oct 21, 2025 at 11:04:05AM +0200, Toon Claes wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
>
> >> Nice, I am glad to see that we are using a bitmap here rather than the
> >> hacky 'char *' that we had originally written. I seem to remember that
> >> there was a tiny slow-down when using bitmaps, but can't find the
> >> discussion anymore. (It wasn't in the internal PR that I originally
> >> opened, and I no longer can read messages that far back in history.)
> >>
> >> It might be worth benchmarking here to see if using a 'char *' is
> >> faster. Of course, that's 8x worse in terms of memory usage, but not a
> >> huge deal given both the magnitude and typical number of directory
> >> elements (you'd need 1024^2 entries in a single tree to occupy even a
> >> single MiB of heap).
>
> Using ewah bitmaps is slightly faster, although the difference is almost
> neglible.
>
>     Benchmark 1: bitmap-ewah
>       Time (mean ± σ):     793.1 ms ±   6.2 ms    [User: 755.1 ms, System: 35.2 ms]
>       Range (min … max):   784.7 ms … 804.8 ms    10 runs
>
>     Benchmark 2: bitmap-chars
>       Time (mean ± σ):     808.9 ms ±  11.2 ms    [User: 770.8 ms, System: 35.4 ms]
>       Range (min … max):   800.2 ms … 830.5 ms    10 runs
>
>     Summary
>       bitmap-ewah ran
>         1.02 ± 0.02 times faster than bitmap-chars

OK, makes sense, though just to clarify, "bitmap-ewah" is just a
bog-standard "struct bitmap", right? That happens to come from the EWAH
implementation, but the bitmap itself is not being EWAH compressed,
right?

> And ewah bitmap being more memory efficient, it makes more sense to keep
> using those.
>
> >> Likewise, I wonder if we should have elemtype here be just 'struct
> >> bitmap'. Unfortunately I don't think the EWAH code has a function like:
> >>
> >>     void bitmap_init(struct bitmap *);
> >>
> >> and only has ones that allocate for us. So we may consider adding one,
> >> or creating a dummy bitmap and copying its contents, or otherwise.
>
> I've done some testing, and to do so I've made bitmap_grow() public.
>
>     Benchmark 1: bitmap-as-pointers
>       Time (mean ± σ):     783.7 ms ±   8.9 ms    [User: 744.1 ms, System: 37.5 ms]
>       Range (min … max):   774.4 ms … 803.4 ms    10 runs
>
>     Benchmark 2: bitmap-as-values
>       Time (mean ± σ):     856.7 ms ±  10.5 ms    [User: 816.0 ms, System: 38.1 ms]
>       Range (min … max):   845.7 ms … 872.5 ms    10 runs
>
>     Summary
>       bitmap-as-pointers ran
>         1.09 ± 0.02 times faster than bitmap-as-values
>
> It seems using ewah bitmaps as pointers is faster than using bitmaps as
> values. I must admit I'm surprised as well, but in case you want to
> double check, here's the patch:

I think this makes sense; the pointers are half as wide as a struct
bitmap. Even though we're going through another layer of indirection, I
think that the smaller slab footprint results in better cache locality,
and ultimately faster code. Thanks for testing it out.

Thanks,
Taylor
