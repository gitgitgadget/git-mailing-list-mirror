Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828CC1EBA0B
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988405; cv=none; b=HSZWWRBu8FWUck9q4YHDYNEw1TdPqRtcWMaMPVt3xDwxcIdFnci0ukydegPOspqyWjh30Cf9lxgkEuUKK5pCb7NdJUhsI2tIPfIPNI91DsM4o9lATzScwbjyaU5Hx7rxBciQAAHiMSTP46mdyPqd644gzcXLd0B0VxC/h9aKzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988405; c=relaxed/simple;
	bh=mZkNPNgCJph1hWipTFJTBglepc/bfWO9snS8Xr+ZNgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFVlLLLClqntiWf+6iHgA2FUf6aib6VplCtnp9mO3umwIAfGJ/l2+bEvs5AJxWcli9tZJJlQeUiOZO7onjL7xTLCc9Ex+bar7gne2l6GdVgFOvS1NUQjlpMYQ90/Zy622LktalvvflFtSNizGCADxJaUqkILOM6X+LA5OULnSqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFClWOB4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFClWOB4"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so2487765b3a.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 03:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728988404; x=1729593204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJt5QESYaNwR3ja/FSzsqIwQsVWRCMOvu+wD8S7ApEs=;
        b=TFClWOB4FSk4FQ/sKmEkUzMpoUPN5BJp7Xmhlflz+3cJgsMTf8gxpr4S0CTMIlDK3I
         3wiljHdxe17u+xs42gfKDjERTchVd+0j+qk8xoyvnUjr0D/3BJfXv0mZ63dQWRIOm3+x
         8DbWKnJleuxVuvxfJfixG8uV2Q7MpzIxZBG7k8KRQxNFO4uq2T0zMSlGAVX2wBMlYV2s
         IwRpPfjYdZEBEOrrsp57NlcA0g6eGfugU2iy2oM2vxmp4ljeCzAYHOmzFUxiAziEyoER
         fVKcdepsPVxyIBHFoasvFCl8P08niXJ8qcCPpcrUyfp+OzojLngJZVBgo+1E+RGnLjyn
         9nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988404; x=1729593204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJt5QESYaNwR3ja/FSzsqIwQsVWRCMOvu+wD8S7ApEs=;
        b=bcP0KVdfdwmIlwEqk+m5AJ3Tlr6rcSjnNpSxhJXCZYTpRrHCmhsfX0zd0K8mVoUIQ7
         v7yoQCkjqNgjrRdBe7QoI3OPFJA+WxGuegZbjijjW9H6aETk7ZQVmBNwjYoi9jxIPYjj
         zPyOHRjIjHQ9Gdruamkv8+k/nFhN9JV3caRZpt44fCglG7Q5ht1lf+gMnPRzPgYqK+mA
         PaF9lGLRC3Nmf5TODFKJ0qS/bWEjA+65eny35w0MQi6E9hFVy3rUAww4RmmX1a6ubuOT
         GFzYxQMWPPpRmEdYSGdykcDVQnUJNMX2soxg4/azmXPHKIICLJ3ieR+oy2Y7vTOTAGE1
         pm0A==
X-Forwarded-Encrypted: i=1; AJvYcCUJuHK/pUvXx8uIl4Eewvx0uNCS9RhoOf0NQYlhEjNd1WqSkUGJTyT86J6E1GYlhRO3GNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLquJhP0DpWv/aqnPQNp2kai4bXFU8k7N3NS1ItQ5JX/3Vpmvn
	R8Ezci0nsApc7DFvgYn1p4QNsM8hqKyOeqhBiWniKfF9o9q32HyTQ/xRMgszYKw=
X-Google-Smtp-Source: AGHT+IEGG2G9zqP1wCvB94oVdZ80x1t+Ii+DoNc+M4tvG3PowjzsSusVdrCfAQnPleDZucK+m43CZg==
X-Received: by 2002:a05:6a21:1786:b0:1d7:84f:f6f9 with SMTP id adf61e73a8af0-1d8c96c473bmr13767060637.48.1728988403716;
        Tue, 15 Oct 2024 03:33:23 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6c17f3sm1030477a12.25.2024.10.15.03.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:33:23 -0700 (PDT)
Date: Tue, 15 Oct 2024 18:33:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] reftable: stop using `struct strbuf`
Message-ID: <Zw5E8d3AotDBYKSA@ArchLinux>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <Zw2e0w5bkDO4l/Qs@nand.local>
 <Zw3xkX_a4KyrSNq9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw3xkX_a4KyrSNq9@pks.im>

On Tue, Oct 15, 2024 at 06:37:37AM +0200, Patrick Steinhardt wrote:
> On Mon, Oct 14, 2024 at 06:44:35PM -0400, Taylor Blau wrote:
> > On Mon, Oct 14, 2024 at 03:02:16PM +0200, Patrick Steinhardt wrote:
> > > Hi,
> > >
> > > this is the second part of my patch series that stop using `struct
> > > strbuf` in the reftable library. This is done such that the reftable
> > > library becomes standalone again and so that we can use the pluggable
> > > allocators part of the library.
> > 
> > I reviewed this round, and it looks generally good to me. I feel
> > somewhat unhappy to have to force the reftable backend to implement its
> > own strbuf-like functionality.
> > 
> > So I think it may be worth considering whether or not we can reuse Git's
> > strbuf implementation through a vtable or similar. But it may not be
> > immediately possible since that implementation just die()s on error,
> > can't easily swap out the allocator, etc. So perhaps this is the best
> > path forward, it just feels somewhat unsatisfying to me.
> 
> It's not perfect, I agree. I initially tried to do something like a
> vtable or to even compile this into code with something like a wrapper
> structure. But that approach in the end fell flat. So I decided to be
> pragmatic about this whole issue and just duplicate some code --
> overall, we are talking about ~200 lines of code to completely detangle
> the reftable library from libgit.a.
> 

I have read some patches yesterday, I feel quite strange that we need to
make repetition. Could we provide a header file which requires the users
who need to use the reftable library to implement the interfaces?

    reftable_strbuf_addf(void *buf, char *fmt, va_list ap);

Thus, we could reuse "strbuf_addf" to implement this interface in Git.
As for libgit2, could we let it implement these interfaces? Although I
have never read the source code of libgit2, I think there should be some
code which could be reuse to implement these interfaces?

However, I do not know the context. Maybe the above is totally wrong. If
so, please ignore.

Thanks,
Jialuo
