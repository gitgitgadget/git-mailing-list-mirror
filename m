Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738811D9663
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614085; cv=pass; b=iCHNwSHU+9gqb57Psy/r40EJO/rApcNr0upRImpeSKlBnsbtCNt9UkL8OX7twqyqUYhfwudZlY1bxAA5m73r40ewglitXwEJ9yG1nUQgMi/xFgGJhcx7xO3eY0DW0q/RmcBqEy1upR1FsdsON0kPRwHQK2QOgv8NH0uPJvB1p30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614085; c=relaxed/simple;
	bh=xf5aImLEkTSqJjwX3JNOeiKmpAkoTzyaufeDw9l56J8=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5QzDYbJufVTcLVtRSrcgvc3Y21Ru6xcNUSDcrQaezrPjJmJL1iCWWsCL5FFDez1qLVisjpxNhVDC+8A5kcPhRPjPeQ5d66umToN8nbkIy7ahq3TdgkfxHSUeu2G4PGFOLKdNYAZwDf0OZ4bCb+eQbHACRt6go99JjzSfsMo9Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com; spf=pass smtp.mailfrom=kanamei.com; dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b=cKRyzj+7; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kanamei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b="cKRyzj+7"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33c2520ad38so824498eec.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 23:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791614082; cv=none;
        d=google.com; s=arc-20260327;
        b=Ju+OebYNkqr1/LfsMfQe3a2DrnXIU4BspJSltDgos7Ko/fQyxzHwHAHMr9Sqbo1RPs
         LPQxIDpXucUciraKq83daAgADgu2bFyKWkfvb8g2+B7U42JhcOkdHBlIa7bSnygvb1uX
         BOJrOmalm+uQTkJr2CPgtFQ0+bNY5I488AxuY2cVOSACaxhA1uOSKxahGk4kK7rqMK2E
         A2JnXKcXtmjxuKcRr0JGrPUxfeJC+2uuJ+1OjJWnqRFAoN8i1l03fNoQoC702+o/NOEc
         aBHTWFMS7ngsq6me8L73MJztMjiyi3mtBKruX6IsVr0jfv/IT/5o9fB4ycm7c08JlcHI
         xEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=xf5aImLEkTSqJjwX3JNOeiKmpAkoTzyaufeDw9l56J8=;
        fh=dS7ZYYEQ3xS9uUoit4NbHrS7bRskiJR+qpqNwgt9xSw=;
        b=So+FjXio1mKzGGDiYxvVhnTX9zDrolHzAnrM7eyGozehQ5uJDmIHe4iaESFO4uSftE
         k78GxJ5bBM/uWotFGMnTq2TJFeCXaMqRKW0y1RAyG8hHUC8zf2LVuFwhbecetZ3ljXuP
         DzFtFNToIKvEnAAQvx7wRxAZOlnaGk/N0czzG0NjgchG1E4mx1raHwKYrI/go6oU+L4v
         PkblNxNW+/GaGeetBd9hc89+snZ/ccCvwiybrEOovhVSroKVdp0P3rwI++Orl68Ht0Tg
         7irtFwLpM6VT25X3yDIjhil+p+PvMWPUug6pKgpsaYVpmDyYzkIJpeH6QFQ96NUGP+lU
         J+Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kanamei-com.20251104.gappssmtp.com; s=20251104; t=1791614082; x=1792218882; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xf5aImLEkTSqJjwX3JNOeiKmpAkoTzyaufeDw9l56J8=;
        b=cKRyzj+70qc0TspXP40xFQSImpxWU1+SQKDx20lCZ7MXMA0hXiGj6RmihxGlFy5ODd
         LNe0zHT3pM2IVlHOp+jOEVJrc9fujfchOQgHfpiDcJvX9Flbk356OKxP0Gs7e7wKWcty
         xZQG4ZquDdLfBVnluQX3ffKYAvM6IUzxT80gdbV5vlCRxytjGCjLUSEAlX+J1/CJGdta
         nqs8Ro/LBOjEAr0OWYrx6AyQFbyZK+W7SGkgB9VV+zN8FW6bMzKmKBsYTHegxrJJ2d2G
         53rp2A0f7UOAHOOsaaX5DzgIkj0IM2plJJ7vi2sVG1k7ABCCwnzM/Q2b9qdqcCOX+/Fm
         /iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791614082; x=1792218882;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xf5aImLEkTSqJjwX3JNOeiKmpAkoTzyaufeDw9l56J8=;
        b=bHyhxCsU3DwVhdphlqTaV/VozneJvrBjR/ULXtoTW+FQQROWMFmfsjrG4KVc3+3S/y
         wvT1nqDxl1Uc3uG998EgGv1wv+aUGug/c4HDeDmvO/+hjOk8nmcwRI30fzdT3RWwp056
         s8bzf0KY9neG7VVIaolcw7V2lrEKpv998ziaGhbMkPhGM8cSdeRWBcxrMKNKV9BuZsSB
         4u+PEAs0yEqedMVM1MV/nI2yVpwzv8UW+365icR9y5iDNTkbOJAbCRoMvhucupHG1+7W
         xLt5dV6hUV+ByAomnN2xW3OJKglPBMe4j4ISOdbGoqQVcFw9GPNL+qi793SUSCcYLBUs
         Z67Q==
X-Gm-Message-State: AFq9FYJma2qIqoq0rSf3y8cpA/8cLgH49tpHFppzUgSQ2NAHYTVJL1eG
	GzT8UIMPiAMFNMainq9IR1GV4Zv+K7C+wQ7UsS6Z+pZ+pkliwxqWxWKspz+xKB6Pn+IOJw9VQwE
	PMj7cX/Wu0gs0uzdIb5c0x4/NUh/U/hLid5vyuzFYSg==
X-Gm-Gg: AYBFou1GZt/DDuHZ+wHXz/WOYewUUFCBBo2JIp/ggCIApcrgz1vyXBxNwD79EAn/3Lr
	uQlrR8UVnpnaE/eG+/ZFrzmYPnT6u8HOQokKmlSz1edxtA7xx8SO4YMYRooDKb4suZi1uMaY1W1
	DI80U0XIICKxSfxGU0ReNfqHZ+nAitWWULS5iUhkO3qkD1gtVIUHckoCW/aQ2WS9KJCl5qBvz1r
	cSvOaJ+Bu8rqFYxbsndAIHVg+FltJyXac4Qk4QIkr4ksQl9aFkybEvmujajHr4h456nmclT8bHR
	2AD5ZFjBiA/6JleIbG/vCg73nqVdduZIjtNgv7sbezSESdbbKMEr5Q==
X-Received: by 2002:a05:7300:bc9a:b0:346:7c2c:1d25 with SMTP id
 5a478bee46e88-3537e27b99dmr8444673eec.41.1791614082339; Fri, 09 Oct 2026
 23:34:42 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 9 Oct 2026 23:34:40 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 10 Oct 2026 02:32:17 -0400
In-Reply-To: <xmqqqzhyoftg.fsf@gitster.g>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <20261001042155.33303-1-kazumasa.shigeta@kanamei.com> <xmqq7bk173qm.fsf@gitster.g>
 <CANUHOw1eO0HNjU+-PYNDOz9kHhBZYYfhiKJSX4082YSC1NKxww@mail.gmail.com>
 <CANUHOw3gynMRGN7A-wOnL3PQtgFbMtsB2gyZxaq+0Z5bHp-H8A@mail.gmail.com>
 <xmqq1pa4ksiw.fsf@gitster.g> <CANUHOw3N+_yWnh7=2-5fD+XxgYC9-M9fqL8GEjfEC6kN+CD=gg@mail.gmail.com>
 <xmqqqzhyoftg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>
Date: Fri, 9 Oct 2026 23:34:40 -0700
X-Gm-Features: AclHuK9DElsjU5JnHhLNcYsk9WjCT7xec_8HCgzCEdwqF1q25n2L07Y6r2bDKis
Message-ID: <CANUHOw0bc75HBqbvmbyeCMNF-2cJa3y5Km6MmwsiGTwHMwLULQ@mail.gmail.com>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
To: gitster@pobox.com
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com, 
	phillip.wood@dunelm.org.uk, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

> 'git stash create' does not have to be fully capable of doing
> so with the current topic alone, but do you agree that improving
> 'create' in such a way should be our long-term goal?

Yes, I agree.

> Shouldn't 'stash create --foo' work the same way as
> 'stash push --foo' while creating the stash entry, if '--foo' is
> not an option relevant only to 'stash store'?

Yes, that's exactly what I had in mind.

> If the wish is "we want to start small because thinking about
> each and every one of them and making sure they work correctly
> is too much work for my liking", I would understand.

Yes, that is what I meant. When you asked why I was singling out
`-u` and `-a`, I went back and examined the other options. I'm glad
I did. It helped me understand `stash create` better. Thank you for
raising that question.

But when I tried to explain why I wanted to leave the other options
out, I gave a poor reason. Sorry for the confusion.

With that in mind, I'd like to limit this patch to `-m/-q/-u/-a`
and leave `--patch`, `--staged`, and pathspec support for follow-up
patches. Does that sound reasonable?

Thanks,
Kazumasa Shigeta
