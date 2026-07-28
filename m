Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9021D9663
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281514; cv=none; b=f4ICGOyWx+yAkNNZH0Ycq+MoX8iLbOAGP2P0+vZtxr9IGafoZ99AGXNB4s4v49oIZ49jVf8HwNEhGsokoTfoVmMH2bhR682eiAj+zzzESDZVBYxST3Yj7ZFQIl8S+TI2omscEGGfXbS9o5yjD5Q5Q9pKGkXYdIXVbCo1FmVbH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281514; c=relaxed/simple;
	bh=67vRz1OS15tlykKeGgbCky0gQ3IV19jzcTQ41XdAcIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecJuEXErpt8mH/ij/uA3hmStxxjiGnhg6yT2iBzC1GYCdoialepOc62tkUcriC1aR4OCx3eetb14k7mB7F0zwlZsJfjvuV3s6ljY5VAVeAIs6NcyRtFz+4qwPz5+9zWsqL7MT6K0Wh7oBCB/3/IbPzFGTXHpIAR0ejfYp/gyWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=WyZ/m65R; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="WyZ/m65R"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e69a2db34so6698167b3.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785281512; x=1785886312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YDin6SAdrN+0ArTFaDtEYgk63/ji8brYvF8wKs/MFcY=;
        b=WyZ/m65RPVu8gFddyvaCoN5Iq04Pb9YyS4pB0bf36sOk0ZV7UCb1ilYP8A/Ogyv7hC
         iK5iqykhUN29OhX4Br4hIoFa2IpjbeNUto1PQtZ1HQJ+KOOHBSkZAxLepmyiWYKlyuCh
         DYZSpU80PPe5S19G/PA+NI1t1dkys6i2gMYD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281512; x=1785886312;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDin6SAdrN+0ArTFaDtEYgk63/ji8brYvF8wKs/MFcY=;
        b=MxiFOy2pzd3kSJYd50jbn+cTjbiGhOUOKW/4outRfWow27QNrXuChRkrk/KQ52eemZ
         2FBFf49UDZeibsukvNO5Z1gzd4SaZTh8jK4Ggu81Zq/+o2vvtdnfa+oGliJ7azlM/3L/
         hotXoUr4bU1vCO2y0PlbAFuRPBfavsWBX76IqiqAL3So6cLS44LnSTvr9T+E0jJTTFbO
         RCoUOPWSOOeNQEfWx2COk3gHxHBPaCPSxt0x4ODyM5N4BnArjgmzksT78+Az6xQTuVQV
         4EXPtVXeGLpYTxdUI764THIn8Atu1lXCyG9VlcsWRbG9w0G7HjAarP3hh7EQAw60KqL9
         w6Cw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0YtqSxwQOMDZA7E+m4W8LNfGx3i2BlPSejpwEWmgAkj2vYnVZCttXzicWmuTkEvFtfEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1FJ5Gp76mmNE0Ql2VhHWDJy+WWzeL9gdj/YrYIhcTggaTG+hZ
	5yjWhpz0D7OKL+fUUoW930jebl4PykBWcyBBXur/iZi5IPV81OB8tkeHbKlgHO1PRHM=
X-Gm-Gg: AR+sD13JBgxHE70cdJ2HDe9kGgxf0wxESUYZlYTalkztPBMdwyGZsEIUL0FVcEA7NnI
	w2RJJtQDUMp9Xi1Isx3lG5OgHWbES315LkaxMZce0zq+a42X8IrhaYxD/0I6avHS3+sg9rHaK9q
	Csm/slSIuQdug6UkM04l30fzREN0Zhf0M7ysVopw4PYdRG2wC0kMM+lnBItTblTEMb0lgifxM83
	buS2opu1B8CjhGueB2xI57jfEWObwP1Z3q21ZIt09ZoZoRU4S6Eq/9l6xh+DIRnCOCxV/fjWpQa
	PiS9bO9JqXLxlbKkPgh/3kLj4oumU9E6PpqGzLURg7wfRnnnoLLVL8igH4FVcnF7X+WPmyDVqw7
	JIrYCCwSWpGW4vQucotJlK+Zx/ew7ZivSPwWkNTdywhetpx96hDn0S5emRo6KDHXZdhM7wRp9PC
	2nC1m/JpqFYkd0YtDvSp9awAXxlQuhgsCCt5w7lcMpOQ0V9lDoV42oX2ppxy0s0jI4vxEViAeTa
	nbtRy+w4XX7Cktcd+CuSGZxIMpkmOY5l6l00SozmB0wA1Y=
X-Received: by 2002:a05:690c:62c8:b0:7d1:dd7b:b71f with SMTP id 00721157ae682-81f99242bf1mr20835567b3.29.1785281512136;
        Tue, 28 Jul 2026 16:31:52 -0700 (PDT)
Received: from com-79390 ([20.102.114.220])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa27568c2sm8276217b3.5.2026.07.28.16.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:31:51 -0700 (PDT)
Date: Tue, 28 Jul 2026 18:31:49 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: David Lin <davidzylin@gmail.com>, git@vger.kernel.org,
	David Lin <davidlin@stripe.com>
Subject: Re: [PATCH v2] pack-bitmap: handle objects at bitmap position zero
Message-ID: <amk75SuhyHBbx-E8@com-79390>
References: <20260727171331.21088-1-davidlin@stripe.com>
 <20260728135248.61304-1-davidlin@stripe.com>
 <xmqq5x1yd968.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5x1yd968.fsf@gitster.g>

On Tue, Jul 28, 2026 at 03:46:39PM -0700, Junio C Hamano wrote:
> David Lin <davidzylin@gmail.com> writes:
>
> > `bitmap_position()` only returns a negative value when an object is not
> > present in the bitmap index.
> > ...
> > Also cover the non-pseudo-merge case by passing `HEAD` twice. The first
> > occurrence initializes the base from its stored bitmap, and the second
> > must recognize that position zero is already present.
> >
> > Helped-by: Taylor Blau <ttaylorr@openai.com>
> > Signed-off-by: David Lin <davidlin@stripe.com>
> > ---
> > Changes since v1:
> > - Clarify the bitmap disk load wordings.
> > - Add coverage for the non-pseudo-merge case.
>
> Thanks, both of you.  Will queue.

This version looks good to me.

Thanks,
Taylor
