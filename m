Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD1F4409
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112217; cv=none; b=ieNbnEB0EdOzCyNd0BrRFmUAPVwOGPEI8lSoeAkm7GQdsn5or/IRZh/aEoPsI9CiV2/1+usMOAB/mzmgHppzNYDWqR0egwLOdBnPM5S8OxtHt4VI1cM4dehWyYIdcxum6DCaHYUs9rAQiUfTLBQsqkZ7WonPkYGiiyxJNdmTWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112217; c=relaxed/simple;
	bh=FExjCK0R/rSk2RNIYS2anE3zlGRYOweiCNsgWlPvOo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZdT+hvF8PBL4KjhO9yDovBJAMQM2dzHgomv3GmzQxw/J5f4PctupOwlUxzCB+z/jM7ASGWGzZJ6rmbRvp7SlZlYvysx79OO3GrKbvXM6nadURylvw2NwNxTP8h97CpXtNF6BBrUVhFxdRa/YKya4i5AuJh90ZOLo2zxiKLZots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Zbox8LaZ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Zbox8LaZ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6dfff346a83so3146777b3.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729112215; x=1729717015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o7kDKvK7zzKM/Xd2iO1pEWAH+tDUXdfOZfuPIHKRQyk=;
        b=Zbox8LaZoZvbGM+/8Bxsc1WA5XWVHbXvdqBruJ9hQgIvUEpz+DhCLrmyNIKS7S0nB8
         idG0PrSL+DHSVlSdtTFuiGHULhzIh3WrcmVJSJ67V4aXz3ZXfAMSDxNZ8PjdO+Yda2OP
         ZrUZJE6ptnl0M+xMQSDuZIzHOG5bm0HWyOuFrCw2okE0gq3qK+Ty+CIvVzBiRN7xS26D
         qjAZibvv5oDTB1kweyFZ/WkH7odlxGFkL5rk+1Rr47vv7JRx5TXUEILXUH0UFDLnx4BK
         iiiguVf3mWLyEMpOegpJveeLp/bqNY3/w2dYw/2ZvYyjvU+OwCcXHsoEHOvN5nxSX016
         5hJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729112215; x=1729717015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7kDKvK7zzKM/Xd2iO1pEWAH+tDUXdfOZfuPIHKRQyk=;
        b=GRr+yM8PM8elD3qpQ7wm/htsBLrAgq13ZjI1n3H5rAKaJ3N1i0PdFhjxQGuEq6f57g
         AUjt8xGlzUvaj9qQuWqZnapmFjmWHB+kiQ0HU/q9XEUQQvweJsBaW//mLtiJvZ9XC2e8
         XQ8/MS1ZSk0F/eApLGA3sCtnEdhZ6mUJVxqq9CXcT3ONQOdRmvsKjNpcl136WOzzYcez
         QK3Ubmgh5xljE1mcxjqqmqDIN7BTn9/+lLPdKJtWehTD/874KmjzPly2+p1anln922gZ
         QRzL3RxxZrlgcQuHF79s68EKaAfKb6td48IGCt8gOeH90azsTo7FYUoKzSvh3FVCBi7t
         ZRig==
X-Forwarded-Encrypted: i=1; AJvYcCVnh0sJMeERp4phU4hWwIx8tRRbSyudEcr5Z92uFZppjqmuV2jbzBT9l1yXJKTNxRFDDlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVD/tuK7LpIBYIgZHfjjc64DLMqz3PQPwA1EiNLRMJhoEdAk0z
	AxPTsEIAepIV8f3QcdVg/aKOtoOK9U3HRWVDkwEtd/zeV26QZYKGbMFPDkv/Vs0=
X-Google-Smtp-Source: AGHT+IHU11vfqWZwDxuWJzzvZF+4enJhmRycz3AZk8b8z7LzM3RZUxJpLf1x/bzSTCQJgp+kJbFR/g==
X-Received: by 2002:a05:690c:4d87:b0:6e2:f61e:c53 with SMTP id 00721157ae682-6e347b36869mr162499917b3.29.1729112214891;
        Wed, 16 Oct 2024 13:56:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d25fbfsm8501637b3.124.2024.10.16.13.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:56:54 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:56:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/10] reftable/basics: provide new `reftable_buf`
 interface
Message-ID: <ZxAolGGcndQzApPJ@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <0ddc8c0c896a006e4cc094390125efcec0b3cdff.1728910727.git.ps@pks.im>
 <Zw2cjxpDf6MowCP+@nand.local>
 <Zw3xhwLFlznU_JvK@pks.im>
 <CAPig+cSXJaETg4Sq3Zw8=37M15CdLEUkdMb2U2X4NPSOAFwmyw@mail.gmail.com>
 <Zw7CIRoXrLr5pd5A@nand.local>
 <Zw98hKZc1pjBGGcU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw98hKZc1pjBGGcU@pks.im>

On Wed, Oct 16, 2024 at 10:42:44AM +0200, Patrick Steinhardt wrote:
> On Tue, Oct 15, 2024 at 03:27:29PM -0400, Taylor Blau wrote:
> > On Tue, Oct 15, 2024 at 01:10:59AM -0400, Eric Sunshine wrote:
> > > On Tue, Oct 15, 2024 at 12:38 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > > On Mon, Oct 14, 2024 at 06:34:55PM -0400, Taylor Blau wrote:
> > > > > On Mon, Oct 14, 2024 at 03:02:24PM +0200, Patrick Steinhardt wrote:
> > > > > > +/*
> > > > > > + * Add the given bytes to the buffer. Returns 0 on success,
> > > > > > + * REFTABLE_OUT_OF_MEMORY_ERROR on allocation failure.
> > > > > > + */
> > > > > > +int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);
> > > > >
> > > > > Is there a reason that data is a void-pointer here and not a const char
> > > > > *?
> > > >
> > > > Only that it emulates `strbuf_add()`, which also uses a void pointer.
> > >
> > > The reason for that is because strbuf is a generic byte-array which
> > > may contain embedded NULs, and the `const void *` plus `len`
> > > emphasizes this property, whereas `const char *` would imply a
> > > C-string with no embedded NULs.
> >
> > Thanks, that was the explanation I was missing. Perhaps it is worth
> > re-stating in the commit message here to avoid confusing readers like I
> > was when I first read Patrick's patch ;-).
>
> Does it make sense to explicitly state how the interfaces look like
> though? I don't do that for the other functions either, and for most of
> the part I just reuse the exact same function arguments as we had with
> the strbuf interface.

I don't feel very strongly about it, but I had suggested it because my
initial read of this patch confused me, and I had wondered if others may
be similarly confused.

For what it's worth, I was thinking something on the order of the
following added to the patch message:

    Note that the reftable_buf_add() function intentionally takes a "const
    void *" instead of a "const char *" (as does its strbuf counterpart,
    strbuf_add()) to emphasize that the buffer may contain NUL characters.

But, as I said, I don't feel very strongly about it.

Thanks,
Taylor
