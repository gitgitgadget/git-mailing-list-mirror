Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824B1849
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712454343; cv=none; b=AXGD54LbOjbyZA3szXaNL1B/sGSEqmzXQR3WAXXtZ0vm6M8OMqSAo4k9BOyz2Yzs1xqUfi9elrGiCz4DZxCI54uleohCV1aXJSaSy1iADmgtceARsTzrE+kgHToYA2KLMqwY2ox6NUWKVsvCDWMNwy3bu24ixrOqi4u2Tc9lyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712454343; c=relaxed/simple;
	bh=4vml6FHCI9xTdvmp+Jmew4tVulfYBw8vHfQkOMPSrCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asWd4xZAyHs+tPZviURqkQqu+b5Sr+xd9q45Jql3Wtl4LErTmqMKUi1sfqCYqojZATQr9fyeuDPQpha4m7dz7Y1ncacIsWhBNzMHOc3DzUzRpay3xs0ZQl/JSD5gm6V8DY8/6gJv2ia+w9+buxmy/SXgKdN6W1R0GkDF0KgMbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoN3lGa0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoN3lGa0"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed11782727so613686b3a.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 18:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712454342; x=1713059142; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b0KYDZDuf73qsZk/LzC1h00nde8WFGb65w/Sd8i7Xwg=;
        b=GoN3lGa0QItYHQ1zFe9XlOWZxZy5msBYpq3nVYVmq/jxiJHd9P7F2I3XvHa10Ht1mB
         KlgjAPrdXJFNzg73XArNCNGZ+XT1V5aA46VrVzGLw6D5sgw9jFZ7Y8JFV5STcVaoe/v1
         gUyCJ0TFcwS6faTblxJQi72wmAwuvwAwSow84SneCq1yIr2iq5jvH6rFtGFGYpqXSUDv
         kesTzgxXvApuMxF0DtOMssUZNbowhcTJwRrQU2qGdP2zSIfGn2RGPzWE6yvlKvrGH0i2
         dnXqnBjgYFXKeaUZtWfyuLF2nj+thhkPg9+nHEDYnMyxCHaBOhF50B06uiDBhdENhq7m
         KAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712454342; x=1713059142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0KYDZDuf73qsZk/LzC1h00nde8WFGb65w/Sd8i7Xwg=;
        b=aNNOm+qWSsdV9ZLiYB7kZbWcollKyVtmFLgn+0Vn5C9ssCjqd8Or/NLoe5C9TjUe4N
         tlqaam/R+2uawpfidPR8AE/K9/Oky8OXbWhHTLQWcHzlhCJ4gCr2LZXrlIIX9tIDEjfT
         G133an2LROg4RHjUkkObllv6zvXKnEulr26+pyeT11HMrt7JcqbQqQ7QrT0ABPVSR7RY
         M1rT7nJNjz+vLHV0vBuvLMMBR/mPnC0M4EZoZSKKqELjB7D5c5G+BAX1+8/i7OEPhylJ
         tdTur0qxkHRz1tNBikfpRgm6UfS8Bg5ptIk2gnUzajHvIoIrTVAyyAyhSu2Mt+VfJ2wn
         2jbg==
X-Gm-Message-State: AOJu0Yz+LorMhouGxg4le5/fMX0A1xf+QAfMixqhyiDOmYZaD5Mt2HXC
	V4XUGSY8T6CPj61FP6eVLCtHnWxKMWEvrkCyEPpeNioW9v1pFXE0r1xSpdqw
X-Google-Smtp-Source: AGHT+IEZeI1YOJCqVGx/sScNhzY6AoOuXxT6isiUj1m9GBBLHvMkTqoBhndpYJ4X7nkIXhiUilPMDQ==
X-Received: by 2002:a17:902:f343:b0:1e0:b5d4:9f60 with SMTP id q3-20020a170902f34300b001e0b5d49f60mr4061104ple.28.1712454341548;
        Sat, 06 Apr 2024 18:45:41 -0700 (PDT)
Received: from localhost ([14.191.223.174])
        by smtp.gmail.com with ESMTPSA id iz5-20020a170902ef8500b001e26c4823d0sm4071347plb.52.2024.04.06.18.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 18:45:41 -0700 (PDT)
Date: Sun, 7 Apr 2024 08:45:38 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t9604: Fix test for musl libc and new Debian
Message-ID: <ZhH6wq5eTUTZS_zE@danh.dev>
References: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
 <20240407013312.GD1085004@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240407013312.GD1085004@coredump.intra.peff.net>

On 2024-04-06 21:33:12-0400, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 06, 2024 at 10:29:10AM +0700, Đoàn Trần Công Danh wrote:
> 
> > CST6CDT and the like are POSIX timezone, with no rule for transition.
> > And POSIX doesn't enforce how to interpret the rule if it's omited.
> > Some libc resorted back to IANA (formerly Olson) db rules for those
> > timezones.  Other libc (e.g. musl) interpret that as no transition at
> > all [1].
> > 
> > In addition, distributions (notoriously Debian-derived, which uses IANA
> > db for CST6CDT and the like) started to split "legacy" timezones
> > like CST6CDT, EST5EDT into `tzdata-legacy', which will not be installed
> > by default [2].
> > 
> > In those cases, t9604 will run into failure.
> > 
> > Let's switch to POSIX timezone with rules to change timezone.
> 
> This made me wonder if we are losing EST5, etc. We use that in t0006,
> for example. But I guess not, since I do not have tzdata-legacy
> installed (I am on Debian unstable) and haven't run into issues (I
> didn't notice the cvsimport one because I lack other prereqs to run
> those tests).

Nah, EST5 is a conformance POSIX timezone.  It read:

    The timezone name is EST, offset is 5hours behinds Universal timezone.

You can check by trying today (or on anyday with DST on):

	TZ=EST5 date
	TZ=EST5EDT date
	TZ=America/New_York date

- The first one will always interpret 5 hours behinds UTC.
- The second one is implementation defined behavior, on glibc system,
  it will depends on the existence of /usr/share/zoneinfo/EST5EDT
- The third one will interpret today time as 4 hours behinds UTC.

glibc normally check if a timezone exist in /usr/share/zoneinfo first,
if not, it will interpret by POSIX rule.

-- 
Danh
