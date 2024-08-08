Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604082C7E
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137200; cv=none; b=I0crmtGA2cC4grqTdEHzwdkFo0aeNwxoo5NZJFKDOAc/mjquaDAHFvv38bgq2w8Wn0FPM1HFFLbuv1juHwFBRbVU7kYAYt7hpLy5BgOtbrsU2B7vlp24+BRIx9u8odet/0rfdUB35ZWBpkhv484Wz+oVdRzSFZWTqkCZXEmFZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137200; c=relaxed/simple;
	bh=6VnvkqXLIPsXQR7oi5yIj6tZLaInnDb0MjQ2z2dV+CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPUaas07gPHE8ko56AzEOf+feGNo4vYOboHhhin58eHBwID+IDR3XA+Mtvm/qe3Pj/3m2tN9yrp+P4W2yC6p/zg9hqqK6hr7eIUWriFjIdHlGqq2q/W9hNCxllG587wk+2cUiI2p2RH7PA2tTfKfIDd1IthyzxkxITVIYuKX+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Okb+SASM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Okb+SASM"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-710bdddb95cso847292b3a.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723137198; x=1723741998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpJdLGG1thxrQWYFe6qElGhYdaufJf2kaFNJ4xMkHis=;
        b=Okb+SASMeEzUidB0X5Ys5W51MN1DpVtT154XeaFp6hMl9Vex4J/4Z3b4Vg1QYuyt1A
         EZ//azmZWBinuCxxN/rHSQ6Khu3WINZJ1SSEw04i1/N9DlTtHFV1fMTY16ZJLAVw18us
         rRe6S/XaHXiOrHqdBxxdJIcWIx6hirbFPYaSWDk7uaLbfrlqPXtKzx3rrd7bemtu9Xg+
         tiph+EYzcYVXPWNx2yCntDeqEt51dCAq0gsuyp/809b9AipRUF05TQzmhMHyPk9KkBnQ
         bruZpp1tcmjG/lhJcGL/Wv24fpNqnc0COG7tT8MXkWtLZBw25GO6OueFPMjl0epv0XAM
         l/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137198; x=1723741998;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpJdLGG1thxrQWYFe6qElGhYdaufJf2kaFNJ4xMkHis=;
        b=EEmgXRQdHU1yU+xL7XMa/d8LlfZXokxG/bFbtooY51d5+kjXbb5YE1CE4FFZgIHrdG
         yJqWiNcMz2ca+M2VR/WHzRMMtmNJAkV+M0PDN4Ll9/jH6KcY1WzBBZKbtq/ScoSMQaca
         W2EG3XtRe+3XHGPeGSbPEPhhSwGtikhD8POE/ESIE/IZMoXGIjJW+qqmBC9Jw0Lr7Dys
         yfvaikNnCDWx5SHabax2sJoXoEvCMsKWGFOTa7UjyCkEXHK8ie+04nBhOAz4biMtc+HF
         f34zzqgK1N3cEoB0orxRUHn5o90YFL2/dbLmA8fMCMmqBOtiXMYjtBrBZ3q8eR2wWHWq
         NckA==
X-Forwarded-Encrypted: i=1; AJvYcCUIfIhcYz9jREj5n7gHIrph70gdtY53E4ckTWH/p+YmGyL9S9nwyQIzTL9HB2JnEM9C6kEPom5VD6IVxbBbDE+omdIF
X-Gm-Message-State: AOJu0YxY0hq02P3DXAHAGdEjGv7eYkptnk0suWMo7CbL7+4y5PATeJ35
	b7mqzA34T/PjWFh9qc2BkxePNIpMNCB/XJVL8SqjChGJcyz5Di9oBMLyTlbuVg==
X-Google-Smtp-Source: AGHT+IFE8HUK8t3NSqftgr3NKxoMsVPEd4vh231oUADJ8NjnC3p5hinbC2BC9tQ+7GlTmlqZuO8iRw==
X-Received: by 2002:a05:6a20:a11b:b0:1c6:a825:8bc1 with SMTP id adf61e73a8af0-1c6fcf623e8mr3069834637.29.1723137197350;
        Thu, 08 Aug 2024 10:13:17 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2cc95dsm1383707b3a.98.2024.08.08.10.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:13:16 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:13:12 -0700
From: Josh Steadmon <steadmon@google.com>
To: rsbecker@nexbridge.com
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>, 
	git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <bs36iyp3yzb5l52t6yw5364odvugrt22jfeypqohtzdwp22ecj@kurf4p62qibu>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	rsbecker@nexbridge.com, "'brian m. carlson'" <sandals@crustytoothpaste.net>, 
	git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
 <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
 <0a4601dae912$68d8e920$3a8abb60$@nexbridge.com>
 <zrbylipleb7fd7jrlnsampufeiuyiw2suwvd3tuxqoukhz6h52@dnjr7urrwzn3>
 <0a8401dae924$c9e8e9b0$5dbabd10$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a8401dae924$c9e8e9b0$5dbabd10$@nexbridge.com>

On 2024.08.07 19:51, rsbecker@nexbridge.com wrote:
> On Wednesday, August 7, 2024 7:08 PM, Josh Steadmon wrote:
> >On 2024.08.07 17:40, rsbecker@nexbridge.com wrote:
> >> On Wednesday, August 7, 2024 5:21 PM, brian m. carlson wrote:
> >> >On 2024-08-07 at 18:21:28, Josh Steadmon wrote:
> >> >> Introduce cgit-rs, a Rust wrapper crate that allows Rust code to
> >> >> call functions in libgit.a. This initial patch defines build rules
> >> >> and an interface that exposes user agent string getter functions as
> >> >> a proof of concept. A proof-of-concept library consumer is provided
> >> >> in contrib/cgit-rs/src/main.rs. This executable can be run with
> >> >> `cargo run`
> >> >>
> >> >> Symbols in cgit can collide with symbols from other libraries such
> >> >> as libgit2. We avoid this by first exposing library symbols in
> >> >> public_symbol_export.[ch]. These symbols are prepended with "libgit_"
> >> >> to avoid collisions and set to visible using a visibility pragma.
> >> >> In build.rs, Rust builds contrib/cgit-rs/libcgit.a, which also
> >> >> contains libgit.a and other dependent libraries, with
> >> >> -fvisibility=hidden to hide all symbols within those libraries that
> >> >> haven't been exposed with a visibility pragma.
> >> >
> >> >I think this is a good idea.  It's optional and it allows us to add
> >> >functionality as we go along.  Platforms that don't have Rust can just
> omit
> >building it.
> >> >
> >> >> +[dependencies]
> >> >> +libc = "0.2.155"
> >> >
> >> >I don't love that we're using libc here.  It would be better to use
> >> >rustix because that provides safe APIs that are compatible with
> >> >POSIX, but I think for now we need this because rustix doesn't offer
> >> >memory management like free(3).  I'd really prefer that we didn't
> >> >have to do memory management in Rust, but maybe that can come in with a
> >future series.
> >>
> >> This is a good point. Libc is not portable, but because I can't build
> >> with RUST anyway, I hope that libc is restricted to this facility if
> >> used. It should not be included in the git C build. It is probably
> >> moot for me anyway for this series, but I have to mention it in case
> anyone else
> >gets the idea to include it as a dependency for git C.
> >
> >I know you don't have access to Rust, but would you be able to test the
> symbol
> >visibility steps with `make contrib/cgit-rs/libcgit.a`?
> 
> Of course. Branch? URI?

https://github.com/steadmon/git/tree/cgit-dev
