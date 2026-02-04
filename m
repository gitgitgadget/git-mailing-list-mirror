Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D9349B17
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225318; cv=none; b=pgsVvPF6Kw0+2AH0JP5ZqSoCQBp2QtejWqLm8KAxpXXTHzCF8StCSTJ5ywq8lzS3lI2RfEs0k7C9Fu6BWWAwdcn/25jRByTs84XS0g36PoXYXFNyAwF/B+ZFcR2jV9EahiNyp2MytPDDmJbZHUASMrd5nW7Q6bSuTFM1Wx+pDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225318; c=relaxed/simple;
	bh=W6C6Qmx5KhqdSc9+48H1Ti0cv0yYaFHtUNC7QIDE4d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Esxi914RSrngPhJ+LDgpUIqInozAup4oywbt0RUwd3xbV2mnV838FlxTabN/rrRUnX9e0gCNwJuI1YJ4/udhSuCYnwMpedof6W6hCevWrw8NxfKqTuiqdp4YitlbOlxpHAK4NDdPMr5iZ4qeONnvjfaTn2XIUxxueNLawBvMoPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7Zf+xRW; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7Zf+xRW"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40974bf7781so676521fac.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 09:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770225317; x=1770830117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4KAoATfvHR0qwhCmc8VxPlQEbZDn8W2v+n8RtC44Eiw=;
        b=X7Zf+xRWDZhPAh48K97LqAb5SpYOulL62hbeAjTdxMoHDcicYmsI3cBxj4FCwJa84I
         A/32H0wq2PyuEXpH2nu6uzLohrFEHDhTskN8biVaSwz8idJl3DuikxTvqG8Lk7f1AXPa
         v343GPPoPoBaftHDkna3big0bAV+j28pzH2fD3eR2gAL3nrCpHgf4tW1UHv4N47b6qKq
         MktlbS9bjnTJEI0Y2goUPKO765Zqz4z2m7QIyU96MZULqwHxr6+PW5LvbyNsi7cy+uIE
         tTR3c+hFV4N2Cqks6P44oiprMEynNapQ3ki7xVB85JsgQOopgGaT8B3fgJY4P0ja0yQp
         GJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770225317; x=1770830117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KAoATfvHR0qwhCmc8VxPlQEbZDn8W2v+n8RtC44Eiw=;
        b=jZUAtt4jYUJ+dVtaW8wvVDeqkCWmc3QxLKR8uSIkdo1UCkMAwoiZg9zANyAgTFIUKL
         I6YVbVsEHQXjFxamrgTxbTqdJ5CpPC4mmbputMHiXupLZuox38CeCifbCKQn2zwzSbVw
         geGKqpXZi1/NS39gNP4EYu3inHI+cy4znKrS9at4b/OtgiXYLQOK/E8qXxcNPBfZqYsQ
         YgKPxNqax8duzXnWKaqcYDT+MWVt/PjaZCZq0u8mXbWVgQ9SswURV+3AU1tXjU+f0txt
         u5vGlVM6Pr3VoxgyhMrFQ5YiQiSIDUQt6d73civd7+mnJVWzi71vmp5VURoSlfZQrd6S
         InBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcpUoFMcZGgBZ8FayiGyyvU03guwS2aOdDgMfvGgizx0c9P0mZMhtrNThqqu/v0MFdcTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzyMUpU643ckSEvqhYWSBISXCINe06r7I0kuCuf6+S4si23u5r
	PNNlGKY3r8PjQ7ha60taEJkOdfBORqSansGpQtO2fm/b14h4A0H17bRt
X-Gm-Gg: AZuq6aJ3ELfsEGpR8GFyTze1A09G+GJWcF0lzFF1xt2jWQ7ozGWcphwxig+Lv09ya6w
	Cvevz+H61bknoRTJZKgsImzxQqFZZzl5Z6OtiOsQViCWwsP+VZkfZc5y1A1P491lkYFAftmUTMR
	RVelRfi5rSKlWWt0pVNDDrO1/fyMJaaN4+4s6XIuGZzipYDgupe6O0M+C+ckykRgIzVHrLVDWCA
	TurderQupKvlnNeVS67hJdgo2El2gtrP8x3Yklgh7WI5AYhA+SrOoxRHdTMQuZuG5BINqx2YJhI
	lEZz9SnGLOCK0yuettBbnI0XefVfpZEeETToGt4AtCqKl+g5U7ijmopRedMZM0Ue8lkOJt8ZAUf
	nEko3vLgJCgLoBynKrIoJbrh4ymAWXUbf/uo6aqctaa/SbV1t+Q9uSiwgtleAK6Ia0PIGmrJdpd
	bSDlvs
X-Received: by 2002:a05:6820:2d0a:b0:663:1399:13f3 with SMTP id 006d021491bc7-66ba588136bmr24212eaf.12.1770225316940;
        Wed, 04 Feb 2026 09:15:16 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66a32bb2bdbsm1648406eaf.1.2026.02.04.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:15:16 -0800 (PST)
Date: Wed, 4 Feb 2026 11:15:15 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>, 
	git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] odb: prepare `struct odb_transaction` to become
 generic
Message-ID: <aYN9p7crUDUlog8p@denethor>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260203001002.2500198-1-jltobler@gmail.com>
 <20260203001002.2500198-4-jltobler@gmail.com>
 <87o6m5rff8.fsf@iotcl.com>
 <aYIirIQveQiNWzsx@denethor>
 <xmqqfr7hqvzj.fsf@gitster.g>
 <aYLmel06ANrskuG5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYLmel06ANrskuG5@pks.im>

On 26/02/04 07:26AM, Patrick Steinhardt wrote:
> On Tue, Feb 03, 2026 at 02:54:08PM -0800, Junio C Hamano wrote:
> > Justin Tobler <jltobler@gmail.com> writes:
> > 
> > > So long as `struct odb_transaction` remains the first member of `struct
> > > odb_transaction_files`, using `container_of()` is functionally the same
> > > thing as casting. This is also how we do things for `odb_read_stream`
> > > and `odb_loose_read_stream` so I don't think it is too big of a deal
> > > either way.
> > 
> > It would be a good theme to clean them all up, together with
> > existing ones, in a separate topic.  Code hygiene matters.
> 
> Fair indeed. Justin, will you handle this cleanup once this topic here
> is merged or shall I do it?

I've already have a patch that addresses `odb_transaction_files`
and `odb_loose_read_stream`. I'll check to see if there are any others I
notice and send a followup series after this one gets merged.

-Justin
