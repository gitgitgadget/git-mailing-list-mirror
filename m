Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF12DF6F8
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778492; cv=none; b=bA4OFawfLA9EmuZXSLxXzaghT0D+s/MKTiMfpLu4h717DUUVCXqgibsEs5qWb+HsGzsI0LTZpLsLtkWh5incLyevutjwOOckKn0eWNY4cKFz6CaGDNFH2eWXJlJSjx6dTP+MYkyIeiosGGYV6Qtcc6veqFI0NlAfoyDIiSFB9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778492; c=relaxed/simple;
	bh=ogEnh1CB7RwQsKJyALTLFKS+jK5QNQtFuvlMcYZWPbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArjfcNuL2DGI8fNRvoL06PVw/ULO0ZL5bz7WIGMNU5OzLY6PpDPVUVhLAJXMUnjK9aqWX4s0rVutXD+Jbyg4foLSZ8qYKe8byrt9Zw0woBy/JzDpLfndjIxjcLfvWHyLVmGYpuPS3KOQk4zYA/EmvWFuCDpPmzfX7PBIpue3sjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+cb/DCR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+cb/DCR"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso111816066b.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761778489; x=1762383289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni0FdlD7kWVH8hD0kb3Ox6bY5jbmc+PoJF8o7vh8xIk=;
        b=k+cb/DCRyMae7YsO6szeGs2fXSmplyIbZwhq1hYh5ovBdOJPOOGkz4316RCfptLqg3
         tb5miJXAf+aJ4EWx5RxSu394FP+FCvsEXcCDLQYtbR8SlhKgm97qHpkqnbzDVL3XrRK+
         se4yfUhy9Qc9rUTl0K2zHHDF56UsRwKgLEbz1x3npHGxDozdrxX8cGkV5F8oU8i0QQed
         hgTulhJAmnZ8U5G+rUkLgulIkkxZMBE4OLtYo8YU02tvMlcBeMVA/6n06943vGoEBhXy
         pTXWqokopvDxEHG65dsCXMr9Yi9zmeUjfmIHreyv0lGFt5Er+e55yVoy5CvHQstBKwqz
         swlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761778489; x=1762383289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ni0FdlD7kWVH8hD0kb3Ox6bY5jbmc+PoJF8o7vh8xIk=;
        b=IJzwCdMjBUAzURLm7qOy0hpT0CSgoXdSTYGCCc5CFXGtuXAsAnXBUuYWaSc410j2zi
         WSl68uYx7ROwqlHqosJjZeIq3vnypoY8w2jK5pzRhWr+51IBh8qjEajsozt4Og8zkGf9
         s/R5I5LQwoXuilEzK8TaniMPGATU28C8uqhruRgtxOQIku1to7pLcwz+8ZLktOJDuwJw
         EGaRX24dAy2Fhew8+FkZEV4ujFMkrtJbnUuAtBVfFhGeBFeWvD/7v3iMM3Wz3aL/EE7m
         obRHEZ7zucPUYAx2in7acK1yaoJOliqUMAXiFni9Rm50yesuuEKVOxQVpG7ia+suf+w8
         cpqw==
X-Forwarded-Encrypted: i=1; AJvYcCXDddCCr14mkEkGPvA9msdVr9uzh3h0ligaO8JJQ65Sy7Dj5qh7yGeZcTwbNYrD/8HygWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2SAsDqEts/QZ16TX1dw44n4nElWqkcDlJwsusBUMOEtdmI0fJ
	r22sR0eY9hsoFD5sKfokGJu4pOz9hICS+Wh62+PAfkpcHFM0XbtU9AYL
X-Gm-Gg: ASbGncurrmS/us4e1cB/ip5cLoRnSkz45Uz+hz2s16XKfeN/USKAKVpMprhjshtGNtR
	xqfeXo3cgQmuT6gvl9zrcsnJw0qjSof0fk/sBVRgCxK1+ozJfav1mX5W65yNVz+xCQFRD62CeeA
	GW0Op7o8aJl1EIwthHlvwN9XNkKSOKf9VuQjF1ygIlIXR9Y8NThd9m3qtkFHgWzxkJiwNzrb+vC
	p11AOyWPzgzOvieiBLfOnjDW3JBdpKGXFHiN8q6DljT3JAJZd9PL4AkVH8QVY4aGgnFLMOGUt7d
	d1oW1Cxddwb0ME+Q8yP0OTjADDc861dOJgATm8EBnHNukGCWJKQ2O0eVGADiw2w9r39eIHqyMhr
	h263+4edrSFYLzV1O0W2Qyv5MhkSHZFYNtepGILGDoL8IsRQQYzJhmcl2QX1D+T/PD2RdvgdiqI
	Plc3EMWnsf8m0oS7U5G0SmgsZllPLDqg==
X-Google-Smtp-Source: AGHT+IGu8EROqlFiKQuV5YdEp8yVyKS4aTNthjV/55iT6FRH+1GzeF5TrDOY/dER8KyRkW/tnLgJ+w==
X-Received: by 2002:a17:907:72d1:b0:b50:a87e:efe5 with SMTP id a640c23a62f3a-b70520e0653mr137241666b.19.1761778489410;
        Wed, 29 Oct 2025 15:54:49 -0700 (PDT)
Received: from localhost (62-165-236-60.pool.digikabel.hu. [62.165.236.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853f97f7sm1530967766b.51.2025.10.29.15.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:54:48 -0700 (PDT)
Date: Wed, 29 Oct 2025 23:54:47 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <ericsunshine@gmail.com>, git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
Message-ID: <aQKbN157AMJi59rV@szeder.dev>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
 <CAPig+cQ7xJky+F=g=NMrN6BQfP+ZV2KF4RF2eLqtULKgMTR5_g@mail.gmail.com>
 <aOWXSO5GInJI8-NZ@fruit.crustytoothpaste.net>
 <aOXsjnWBOt0qFGwc@pks.im>
 <xmqqms61h0g1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqms61h0g1.fsf@gitster.g>

On Wed, Oct 08, 2025 at 08:34:22AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> ... but I also think we should take this
> >> opportunity to choose the Rust defaults for Rust.  C, Perl, and text
> >> formats like AsciiDoc do not have rigid defaults about indentation
> >> style, tabs vs. spaces, and line length; Rust does.  We wouldn't use
> >> tabs in Rust (the default is four spaces) because we use it everywhere
> >> else, so I think we should take the opportunity to use the Rust defaults
> >> here as well.
> >
> > I am also slightly leaning into the direction of sticking with Rust's
> > default of 100 characters. It's not substantially more than 80, should
> > be reasonable to accommodate for in most modern setups, and sticks with
> > what the remainder of the ecosystem is doing.
> >
> > So for now I'll leave it at 80 characters. But I don't feel strongly
> > about this, so if there is a majority in favor of 80 characters I'm
> > happy to adjust.
> 
> So the question is if we want consistency across files regardless of
> what language they are written in (i.e. 80-columns everywhere) or we
> treat our existing rules a "fallback rules" we have adopted while
> dealing with languages without their own strict rules, and use the
> default for a language with its own rule (i.e. whatever rustfmt
> wants is used for Rust, our own rules still apply to everything
> else)?

Consistency across files regardless of language was great, because I,
for one, prefer to use the same editor for all files regardless of
language.

I find 100 columns much worse than 80, because on my laptop I can put
three 80 columns editors next to each other (and still have a bit of
room to spare), but with 100 columns there is only room for two.

> I actually am fine with the latter myself.
> 
> If people strongly prefer, I also can be talked into adopting
> slightly wider limit for our fallback rules for everything else, but
> that is probably a separate discussion.  It is a bit unfriendly move
> against folks with aging eyeballs like myself, though.
> 
> Thanks.
> 
> 
