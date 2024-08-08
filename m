Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E6149E0E
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149796; cv=none; b=lE6gv6Ipj/zSYW8vf6qnqODsTXUfIjnLT1QEWZNxDiHMkjOGUGwiU1Xc7sWZFPrUTViLQdSymoz+djPi6ROXQpTg19MdFkBHTQ+inbiLDW9VRJIdmW4Ph1IiapCfXafTBRMldhqJCsF5lyh0DoPdVg5fzEDpcAYdMSeoHCyGovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149796; c=relaxed/simple;
	bh=jJOKo7DqBZ9wMjxX2LusWFRBys7JzJN2fvBSsZaKUUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRZvXAUhToMALvYnUxiQ6z2S007jJmbKV3E4VyciX0GCwgPsS1OK0RBD81vxSrlXBxrTu5XYeZSLq9GBa120Hp37Cl+3ntFOosSklWtGgfPapT82oSVOFnV6ubJwNmglAUbHRXYxH/hTVnsn9i/z4xywReWwC0eUR6hUsMsmCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVWoKmXx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVWoKmXx"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cfd1b25aaaso1163494a91.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723149794; x=1723754594; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FF6DGhIcfanGGTqRGCK3EP/lfp0y1Qg7emBsDqiJ1M8=;
        b=SVWoKmXxSCgHlFu/01TVxIx9c0dS0b0puqv46WyckVLuU8BvUEloO0AfbY8MoIrx93
         Gs05k4npvsV34POYs9+xezs/qA5y9tpOCdhBg1aQLjANK3HbtSvMDYeRId2snR8y9rpr
         njO305dQOlpn/Gs8gPNmhByrGxvIPa4JKq3+8nF2C9hW1zo1T6x8CjlSOfwtmztbArT2
         3yk4d79YOiSrWQUVglAovVZ5qMGOenlLOpYTvqt+IR2EO8ekKl4gIhheWalECLDn3MJ4
         sgoqE4Luu2jyD6ou/ZW5HCnovtmIQiYXwHVW1NtL+/ZhXZmcpLXRgEpk0k/tKpmmSQmP
         ruPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723149794; x=1723754594;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FF6DGhIcfanGGTqRGCK3EP/lfp0y1Qg7emBsDqiJ1M8=;
        b=RffNfKUs80Sjp8cE3Ax00t08qezy+NeCVqQOUGxtXPCJRhy0J6J1UcsL4M4kiBPtwI
         zKkrEkdcqW2O2GpqEE5xCMTPUQ8vESuazf6fqjNCfF9BYVHzBdlfN3QuSv/ZVS5eSjhZ
         atHKiHNG/ntHkH4gil23HdATCowLA21aIX1IQ6uYLigIbwvqeWzofYqfyTiDu1LeGvLx
         nRJJR/s7HT8Vi3iz5Wc5uVqadC9y5AA8ive1TTFW0xKnWK9ERkhA+r3e+ovi4QtNPdIv
         ta+rvPMoWiag/ikcrN6iKgnB59jgZ7ywRgfcoEOVm+7lTekFXNY4BO5ReiqsLamO/0Fe
         /bJw==
X-Forwarded-Encrypted: i=1; AJvYcCUuAvpFVkoWSMrQEZY7C0Avx3tT73uOGTNPrS14cfXevFRWAlKExSYyUe70nDBqIH7Mfd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR20Nz7bILeDCkHpR36Y8g2/0dxa2JgwiLioOyhwfcKg5t4crm
	5+mq9dmp3SSDX2OMnmaCfhSlZVHbYmtwcqWw/QQbMYD5+r47Li8Z3RnfS/stC3a1WyEx0weqYlW
	igQ==
X-Google-Smtp-Source: AGHT+IGDoeK4LUrZLRF7gYuysWbzNP2zeBcL7PAitrRMeIPw8EhsJhQo0WIzmek1yA03hiTzgqw6rg==
X-Received: by 2002:a17:90a:4e41:b0:2c9:6a38:54e4 with SMTP id 98e67ed59e1d1-2d1c347257amr3208477a91.41.1723149793956;
        Thu, 08 Aug 2024 13:43:13 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:fa12:a76d:ac7c:e104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9dc8712sm1568469a91.49.2024.08.08.13.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:43:13 -0700 (PDT)
Date: Thu, 8 Aug 2024 13:43:07 -0700
From: Josh Steadmon <steadmon@google.com>
To: Kyle Lippincott <spectral@google.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	calvinwan@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <bglok2kx6kxebh3oicdhhij6ibynse26rkhdorkrbd4wyfek6v@dab4xzsyrujv>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Kyle Lippincott <spectral@google.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	git@vger.kernel.org, calvinwan@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
 <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
 <b5epjlsptw3punygmx2abmfnrkki6n6ta4fk3yse7iodlabr63@zss4z3575r7v>
 <ZrQJe32sYNOTSJGf@tapette.crustytoothpaste.net>
 <htakxe76kl7ll3q7trjj6cjnsrg4tnue2k46zo25bnf3zre7t7@r74vgvebdhsx>
 <CAO_smVjEU4QH6JsLxt2v3ZYPEKwyd9gyJ4OjNgf1+mPVS6xoGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO_smVjEU4QH6JsLxt2v3ZYPEKwyd9gyJ4OjNgf1+mPVS6xoGg@mail.gmail.com>

On 2024.08.08 13:18, Kyle Lippincott wrote:
> On Thu, Aug 8, 2024 at 11:22 AM Josh Steadmon <steadmon@google.com> wrote:
> >
> > On 2024.08.07 23:55, brian m. carlson wrote:
> > > On 2024-08-07 at 23:05:00, Josh Steadmon wrote:
> > > > Yeah, needing to free() is the only thing we striclty need from libc
> > > > right now. Please correct me if I'm wrong, but IIUC then any memory that
> > > > is allocated on the C side and then passed to Rust needs one of:
> > > > 1) freed by libc::free() on the Rust side,
> > > > 2) passed back to the C side to be freed there, or
> > > > 3) leaked
> > > >
> > > > Am I correct in assuming that your opinion is that writing additional
> > > > *_free() functions on the C side is worth it to avoid libc? If so, then
> > > > I'm fine with including that in V2.
> > >
> > > I think if we're going to be writing a general purpose API for
> > > libification, we probably should provide free functions.  Normally, that
> > > will be a call to free(3)
> >
> > [snip]
> >
> > So in this case, does that mean we'd replace our call to `libc::free()`
> > with just `free()`, and then add a declaration for `free` in our
> > `extern "C"` section of cgit-sys? It seems to work on my machine, but is
> > that actually the more portable option compared to using libc::free? Or
> > have I misunderstood something?
> 
> I think both having a generic 'free' function, or requiring your API
> consumer to have a compatible 'free' function is undesirable. If the
> API hands you something that you must return/free, there should be a
> function for that specifically. So I would expect if the API has a
> `libgit_foo_get(foo** f)` function, there'd be a paired
> `libgit_foo_release(foo* f)` (ignoring whatever squabbles we want to
> have about the names). Requiring `libgit_foo_get(foo** f)` to be
> paired with `libc::free(f)` limits us to always using libc malloc;
> pairing it with `libgit_free((void*)f)` means we can't refcount it /
> ignore it if it's a part of a parent object, etc.

Sorry, the diff context got removed, the the particular case I was
talking about here is where we get back a strdup()ed string from some of
the config API calls. I guess we could add a c_str_free() somewhere on
the Git side and call that, but it seems like a bit of overkill.

I do agree with you about providing _free() [or in our case,
_clear_and_free()] functions for more complicated data types though.
