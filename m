Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F6224D6
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713486; cv=none; b=FqAvyZWa1HuYvyDDgTjQ/tb882ZT65wvTRIhScUSkJWo+8rQQ2NPi6JFw0tWJRiFmLFgk6VHtMqXdCj7f4kjtqUhdDM78i43W3m+N2WHb5RV84KgX1f6onz9XEPW6iynyBLSAj1CKDHVAWvluioSWuEclrMX7NqZJZ38Tug4hzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713486; c=relaxed/simple;
	bh=mUUk2Z4QefkyCvBFeXowJzTRNRfjcyNKymAB5d9egRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBiNYN0ReNVjRQvFkvxgU9E9ukDR8irkx+b2M2PF/MKDAiWnVMWSjV++P20fBkmd7HRf0Icyx4l52Sxvcuq7Z60k7NTPnSdbDbp2DX8DMlCBSHWb7ijOkvgbXYKUUu9gesy4KATnX/o37GssO/uV7q72zI47tjUquB2/HpEpKz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CykCybHb; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CykCybHb"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7951713ba08so124911685a.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 15:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717713483; x=1718318283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNMd7GvOYrN9tNaIx8VIECICEwcI8kdWyY4eHQtRPmo=;
        b=CykCybHb17e+n/Z4XRpAC1DTEdjwQQnuUIrgnRUJaUAqKeK0symlKevyBpnaYSJeX3
         UstJ3Ns8t8tFz9UvZypIxuWNTaITe+EvsjXb1oIeeNAWzbxg0AiHi5f2YaxuANeURl+J
         vj87yK8DsVKlDSwwQCOhMoBUGYyL9+UTclPjInVE8AaWPQrjmdMjA8zkgoRlxed+kNXW
         GO/uyrvWfRwRToV9m2by7kDZ0KwrAQGOADICCv7GGNgKmjw9ADGKV4IYcyyI4inREA8p
         VFmqGgIB0+iB+55y3W4uywJpfk/61AstZ1ut6dHPWOOCDAhfDqMo3+bu+0FVDcNvX9Zm
         9SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717713483; x=1718318283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNMd7GvOYrN9tNaIx8VIECICEwcI8kdWyY4eHQtRPmo=;
        b=Dm1rRNTLRO34EN6yYlQAO1x/7oG/ON1/QSYvOByQ4DennnBc4rMci2dmd0CAYnTKEL
         QLoOQSZfusae1Y2nDuQNKsZntLVsumMGZ/AEc1ccmn69WH+ppgO4HJVGuPTF5rLQgYsw
         6ImAg1qQvMLOF54BWD6chK/F1C/zt0CDkYRAmtdmNkNa8A+6EymcTffAaaVZ+jHzyHjf
         V+Z1/BYcbyjTt8e+SYXUDum4sfxLxnwiwzqNEAezw5icafxej4IByzTIdgJUkmnmIiWw
         FFRUqHDKtR0oFIHoZR0CbKCHK9txIIu6mvPZFdnkdBTsyZYEIjASbkD1NCemdw2J2c7W
         8kHw==
X-Gm-Message-State: AOJu0YyK1zmvXsCKTUvUujZMZgbLGHzQsJGxgbCdPby/pA+xP0N2kujU
	YUSFNSaxoGJEG/aBeAa4l5/R9+Yp7m4cZBukngqyMGKVUK7NnLnYDJIqrDR3dJ+u2Lzy9UmcnE5
	TyLI=
X-Google-Smtp-Source: AGHT+IFk6R8ewmnsSn+fYJZZjHsbRb4g/dPd4sDKl8In74TTWGtL0uV3jocUy/xNUdFJlSR7sS+clA==
X-Received: by 2002:a05:620a:4594:b0:795:1e65:933d with SMTP id af79cd13be357-7953af0d56bmr235929585a.13.1717713483644;
        Thu, 06 Jun 2024 15:38:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532885e70sm100917585a.63.2024.06.06.15.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 15:38:03 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:38:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] pack-bitmap.c: ensure pseudo-merge offset reads are
 bounded
Message-ID: <ZmI6SqIFkWz8OPr1@nand.local>
References: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
 <0a16399d14afd527f4db63f2a4a3b0a3cbf112f1.1717699237.git.me@ttaylorr.com>
 <xmqqfrtpluws.fsf@gitster.g>
 <ZmI3RYSsx6VRHdc9@nand.local>
 <xmqqjzj1k8c8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzj1k8c8.fsf@gitster.g>

On Thu, Jun 06, 2024 at 03:35:51PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Thu, Jun 06, 2024 at 12:42:59PM -0700, Junio C Hamano wrote:
> >> Can table_size at this point be smaller than 24, which will allow
> >> (table_size - 24) to be a huge number that st_mult() will
> >> comfortably fit?
> >
> > It could be smaller than 24, but I think we're at the point of
> > diminishing returns here.
>
> I only meant to say that we could easily rewrite
>
> 	if (st_mult() > table_size - 24)
>
> condition to
>
> 	if (st_add(st_mult(), 24) > table_size)
>
> and we do not have to think if we have already checked table_size
> before we reach this point of the control flow.

Ah. Thanks for the clarification. Yes, I think you could do so; I'm
happy to send another version if you like.

Thanks,
Taylor
