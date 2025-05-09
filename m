Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25022DA19
	for <git@vger.kernel.org>; Fri,  9 May 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808785; cv=none; b=td86KeLX0aVddQgACs4Bw20AYD8BMlC9BMvUTui9gvrGkK/TDbBpV2s+SBIdx91RlU581ZREF3LcqOnNfU5ZP38u9JIX61RkJO1OpEjui1nrlCNJooiN2TZzyJszpGULxK3V5EuoHZLG9tZvsDpCzfg0s6k+RpnWAdKJm7eTTe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808785; c=relaxed/simple;
	bh=fFUa1oPzjolaPs76AZIrcb/YsTuHwgU7q33E744Kbso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV6tRUk0uQ8I8gEZh6wfWxkG8n1b7AhcBNagV9gTuF4X7LDFauPg2JvLfOr5bfSsHC9WxMrseszYj/VWAPjMLvkgXUyzlNCnWNacJppbgN3OeH+vOGARbNw79LCfIiWD7aN9KLwZlfq5grc5r28A2r0fS/hudPOJj8RADrKIyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBFPNXex; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBFPNXex"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso2475581b3a.0
        for <git@vger.kernel.org>; Fri, 09 May 2025 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746808783; x=1747413583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dJhy3RkK3n+zP4z+bZJePmGyd7puyQvH575W1FleQjI=;
        b=hBFPNXexc/Ikz3enRkNSRNuWr50nhEtDJOScZMIb8Hd3en2GKK6oz9hWEH1hJwH5q6
         VuMv0DknUgQXlP01mK3NUGbc6HNsvMZWwirzmLhlXgMfCw+9/+prNM5Q95TpZn3TcPwB
         ysYxQHUBd/m/svbgdSuXpH0/fIZWdy5Nm7WJhKLKcm4gnUTitMO4GocZzd+97rUQ4hZq
         f4gX3kCuArgbYPiQ+TakIFEwpXlubCvz5sZhtMy2TxJqXXRTJi4B7koEPf9dyZOdIttV
         N1Q865pt1+3JPp5dgNOgwDF8ssesXtmhWOIj6VQtSoRR84dJ8aQpsDpCaN+q8ou8AqGv
         oTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746808783; x=1747413583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJhy3RkK3n+zP4z+bZJePmGyd7puyQvH575W1FleQjI=;
        b=jd3IPGbnCDnetPTBn5q30ualW7wOO/pUmVIVjD1j6hKUkBITCOJhaPzsO0QjJ43ZBj
         XXLkunDTn8N493W/JjlmS1xcju82/+CvTewTQnFBonKyRWFVcHS3j1QJfbu1/EThR8s+
         t0RuW6t/V5qE0qiKr0cJbLQjWgAK4c8V6DvWbgDvD6jC1Gu9VuU9LjWfOTm/LqR4xxwW
         oyV7vHwkBVtWM6FZ9T9GrMJtKEBV0mWCWGCztFti3nxnu88Ll7JYqwbQHI9Kno54ybZU
         sj/R1YWQHLzNpFR2sSCv2NQhgkguHOnNl0JgakZZI7VdmQgOt2AZ0cLx84AoLjFh1sDV
         NFSg==
X-Gm-Message-State: AOJu0YxAA6HOZaYpIdlyrj8Nv2KZv4/7qg9wMwFNONnsoVwhUU6Hs/SB
	icy7hoa1/fAjOMLWd7SOACvK/8Ze5eUV3akKEJE22hQtf44HBAbLPwN/aSlB
X-Gm-Gg: ASbGncvO/sCp7TO8PMpY4HwnG2VKe19GG9zebRhdwEYSI6Q1EdWmkIPxP0IeN8riKwm
	Lk0RaIctezbPx/m+ElpQJnsAZ7dScM3weaaKY2xV0mrfAKiGueKCUQg5Avh6kzAf3JbI+U67sso
	FckBBTXIyPB+3T+/ycNsI6ugBynt0L7ynFsoUfGoWLwqq0RkTfYGjIYdxocY9hgGzqiXkwXqU/c
	TFaagA8YpR/3rDyCQqIsjdZGuLkkAqmZhUlHxsJVPeQRknJWGks2jWBdHiPYBhbQtKZeeq00053
	RYdLu/cYMDieCFRfecZEx9q86KUP9PC3IUpa/tMV51PVF9o=
X-Google-Smtp-Source: AGHT+IG7EGEp5nWrrne0KIYhcm5q0Zv4P1pok57Q2EktKBd6FV++uDX1N1Q2MESbnHD6NqvBpW+1EQ==
X-Received: by 2002:a05:6a21:4d14:b0:1f5:8f65:a6f5 with SMTP id adf61e73a8af0-215abc17334mr7530521637.30.1746808783298;
        Fri, 09 May 2025 09:39:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b234a0b5815sm1685476a12.21.2025.05.09.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 09:39:42 -0700 (PDT)
Date: Sat, 10 May 2025 00:40:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/4] packed-backend: mmap large "packed-refs" file
 during fsck
Message-ID: <aB4v6kBdNHmFlPlR@ArchLinux>
References: <aBtzn4nwLsI9p5Cp@ArchLinux>
 <aBt0C8gdBecq5f8U@ArchLinux>
 <20250508200741.GB18229@coredump.intra.peff.net>
 <aB4dflpFNW4mJlq6@ArchLinux>
 <20250509155934.GA25686@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509155934.GA25686@coredump.intra.peff.net>

On Fri, May 09, 2025 at 11:59:34AM -0400, Jeff King wrote:
> On Fri, May 09, 2025 at 11:21:34PM +0800, shejialuo wrote:
> 
> > > > -	struct strbuf packed_ref_content = STRBUF_INIT;
> > > > +	struct snapshot *snapshot = xcalloc(1, sizeof(*snapshot));
> > > 
> > > Minor, but is there any reason to allocate this here and not just:
> > > 
> > >   struct snapshot snapshot = { 0 };
> > > 
> > > ?
> > 
> > I simply copy the code from the existing code... I will change.
> 
> Ah, I see. The existing code must allocate on the heap because it is
> returning the snapshot to its caller. But here the variable is
> completely local to the function.
> 
> However, if we stop using mmap_strategy altogether and just use xmmap()
> directly, I don't think you'd even need a snapshot variable.
> 

Yes, that's right. Maybe the simplest way is to use `xmmap()`. But I
don't want to introduce repetition. In the current codebase, we already
have the logic to load the "packed-refs". Let's just reuse it.

Out of topic, I have more to express.

Actually, my eventual goal is to unify the fsck and other parts. For
example, "create_snapshot" would also do some basic sanity checks. And
of course, there is some overlap between fsck and this function. And
also for "next_record", it would also check something.

During my implementation, I find it hard to unify and it would require a
lot of effort. So, I simply introduce some redundant logic. But this is
not perfect. Because I still parse the "packed-refs" file just like
"next_record" and "create_snapshot" do. And the most disappointed thing
is that I cannot reuse them at all. But the things I want to do is very
similar to these functions.

So, I think I would eventually to find out a way to do above in the
future.

Thanks,
Jialuo
