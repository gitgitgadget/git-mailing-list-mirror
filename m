Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEBB2367D7
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760137371; cv=none; b=M4S6inP5qW8QjTLxOXcUcstY9B/H3mlgT1voHTv/ioUeYGQcp29YczKezW7POuGquoaovUClBV2bytiwYy96TaIaW4LfN5tUOGc+MsYkR5Kv7n0Wvgf5YiSsYeK39nwIWcTvcDBOrCR1uso6jw/X8SAuEMQHagqvytOppJk3ARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760137371; c=relaxed/simple;
	bh=YBEZphvovlNeFs3YfhOBcXY4jENc0emhKSGXSROXukU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPWjVf+o1QliU0LFVNqFX1w7KZvtzEJuTUKfXMKPb9n1iIDxJeUrlUhAzBFlrPQtA0Ctlhyy9LdljjsXKRR3kpo7JvaOX8zZXgWg3WS6M5hxpDUiJdAYGMnZLHDyW/gJ/sftWroLjTJ18XhrLklVuM54l067mu8NsowcrZRft5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=pawumRDX; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="pawumRDX"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63bcfcb800aso2865859d50.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760137368; x=1760742168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6F6SerwmdfOzXf5HeV5zZEWReq4UpAHfWkyskxuI14o=;
        b=pawumRDXznUDxeVc1bsC5uABvLzc+nQR/P5QYatDQkX+kxpes+Sax2z+aprVryk5XJ
         Zwig7F3hmHdChMATEyPImA1iJjUGm6/8rsyREmJs2yX+jJDssxKF/IFS7/jOAS8Exdmn
         i7y1khmj3hJ4N4R49QhbgjcEgaEaYCdj1kPXRcoZ7/ut9019ZBCo5nTf4wNbMVqZmKxh
         hnqUCaqjTbbd8h+SciA5GhjF/tv9ZnrIrTNKvOTxW0lebFmaG5uMc9CTdz5leFZpzsGo
         4qldnPp81YdJjvjakPCbsAh669OAR8yVGZ+IE1RY/8yi9tG7dwaSl/WmgPXO1qZz1uyP
         VQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760137368; x=1760742168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6F6SerwmdfOzXf5HeV5zZEWReq4UpAHfWkyskxuI14o=;
        b=EsHLQMqV5yWNqW5+qjaLTAAIHSKM572MxHz2e8j2b3E/L+ldgYHlN5hKl0ycRmJnyR
         5TWymLcPKDXoXfapoSEXRcJvC2i691McuOGt0VHA9N+IlGNaFTesNwR3Axyt2pVc32Vk
         CvnFmZHhghEV0tCj8B/lDxnH8h3WWynZ031hj/AQD1MH90e28Op6Aobi/NvsVqhTQ5yM
         QkoJ1B9Chijs2G39TvJwbLnn/DH6NPgI2aokanaYixnBVdeipOVHkJRxZXNKBAgHn5/0
         3gQS+tahGYPZHSYkwMjJ+INruVT9wHBZSYQROBLSkGMhSVg+9qvHrilMROt1tiqIoujM
         iinA==
X-Gm-Message-State: AOJu0Yz3a3PP3A1TwdxytmfTTFwqD5s5VPLhTq9wg7gPlWGYC0hMIAOy
	k1aYoZHsybqKk+NRV7YZkusGuBXzlMoHBB0oWNTFPfY7HOMWPj4EaVn2+AzcxyXH9gc=
X-Gm-Gg: ASbGnctARiHxS/5HonHU7xZQCk9Fn7kSKuQ17L1UcSnfHIFjuvW83eKcBp5OnQgO2XK
	oHG99Qt2VFphlUDsb3a/ich/siDD3qkMZfS5Frvpwb/ECRH4YT0Kijhv+562wNKIf6pXyB62aki
	Ngu67Yca/JN7HEwon8J7L3+uK0RZGUW971hvS72l9/CVylUouMEPx8gF7rAmHJIxTvHesxufrR5
	zF/hh9tWwQ1ZiDHBmGRxqNJmylaY3N0wqQIkO3usq26Lgv222uAB+Ym7UcBz6K0DiArheMb9X6n
	Cq+269CGC4g0+LLHDx3pLDTPHzP97pC35MWlEuVX8PnIhMX81IFRs67oqhhPO9dP+5/sNY9T9Cn
	m1xssTb7bSjnOgkVirw2+bsQuFSZdwuRMQuB2NhsvxFpwXGFsZ8RzuoKUnZSkuyrPWjHO0pW4NE
	wOArgK44eWuxmAWDoSrToFdI2c73I9+khQ0DY0IsJTpWIRVZvFSlpWP0Q=
X-Google-Smtp-Source: AGHT+IHUCDbfqMH8iZTJ4K3d4QBDbVk8qkmns2QxbrzjBAErXL5+BZa0H6Li3viUMpDWqq4jxFe0Xw==
X-Received: by 2002:a53:ec8e:0:b0:633:b08b:fee4 with SMTP id 956f58d0204a3-63ccb87fd12mr11329793d50.23.1760137367877;
        Fri, 10 Oct 2025 16:02:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cd95e2646sm2019484d50.20.2025.10.10.16.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 16:02:47 -0700 (PDT)
Date: Fri, 10 Oct 2025 19:02:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 38/49] builtin/repack.c: inline packs within
 `write_midx_included_packs()`
Message-ID: <aOmQlkDQOYFDnZdH@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <c2c7ca9f9e917392de3819ffffffcf78622972b4.1759097191.git.me@ttaylorr.com>
 <aOj72bpVTCXuFSHN@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOj72bpVTCXuFSHN@pks.im>

On Fri, Oct 10, 2025 at 02:28:09PM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 28, 2025 at 06:09:40PM -0400, Taylor Blau wrote:
> > To write a MIDX at the end of a repack operation, 'git repack' presently
> > computes the set of packs to write into the MIDX, before invoking
> > `write_midx_included_packs()` with a `string_list` containing those
> > packs.
> >
> > The logic for computing which packs are supposed to appear in the
> > resulting MIDX is within `midx_included_packs()`, where it is aware of
> > details like which cruft pack(s) were written/combined, if/how we did a
> > geometric repack, etc.
> >
> > Computing this list ourselves before providing it to the sole function
> > to make use of that list `write_midx_included_packs()` is somewhat
> > awkward. In the future, repack will learn how to write incremental
> > MIDXs, which will use a very different pack selection routine.
> >
> > Instead of doing something like:
> >
> >     struct string_list included_packs = STRING_LIST_INIT_DUP;
> >     if (incremental) {
> >         midx_incremental_included_packs(&included_packs, ...):
> >         write_midx_incremental_included_packs(&included_packs, ...);
> >     } else {
> >         midx_included_packs(&included_packs, ...):
> >         write_midx_included_packs(&included_packs, ...);
> >     }
> >
> > in the future, let's have each function which writes a MIDX be
>
> s/writes/that &/

Good catch, "that writes" is definitely grammatically correct, but I
think the substitution is s/which/that/, not s/writes/that &/.

Thanks,
Taylor
