Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFC199B8
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946897; cv=none; b=nf0wuuScCeXHmwJ826/I6vRR0pF0PHxVmbLnSiKOEAI/xtYCiQEduEH3HCTioGB0LrnrcyeWf43J9tKSG+kNZ6sLMO1EXYIc4weWXTOrzf7wA55N/shKwNZysVTGVz/9T0pD3jslxd/cMo4GgtwIR3gvx/iSkR+orTOZgllGccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946897; c=relaxed/simple;
	bh=oo0LX42O3rs9Ditzv5ixDjZYBvR60S/Asivb2JWc9QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFGzmQMLdpjmGWa5qn/vXKaf2eUSHW+sOUMYgWund/T5fhZi8BCNePXvix61o27a/M9BDthrOZd2TVcywppw84puMVfUYqFrbSsxg/p4gw9jOCI6Y//KpSMqAG12KjJvN9rofdgvGxKj4yMW6zZ8Gj6yLglOIbM2Z+f8lefVBzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jejmSfF0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jejmSfF0"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso385439a12.2
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 18:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730946895; x=1731551695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgMKtCYLFUuvjfC14mV6NfKBydGvlL3t9QYyCw0Pnqw=;
        b=jejmSfF07s6hfPPqXq90LLkDCH3jHeM11qv4AmNF/+pHVo9jfH1kFUdf0mavgWejsq
         cyIBP+zXJ0YCmMya600/U0iOEezVQBdluKM7oZysWUEI2BG9VsMAk2b6Hg1qsLTkmJsG
         1Wc/zrBBc/gIM62TIokxDcWoNloeMoarjpcL9UX0iZLnREcSpC74CDjhOAQV0FphlYOA
         J6Wl9WDHHV3BbZSu+iNQY1+bzTT54+B0BJKzT+tVmptwxJqpFkYyUJid+kz+N00Z4dcB
         qwiH66l0JPEtJUsdrkTH1KIMgdNi+j7imXsZjLzj+riWYu1iSfxDYORBi7H0DAPJoUPK
         bQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730946895; x=1731551695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgMKtCYLFUuvjfC14mV6NfKBydGvlL3t9QYyCw0Pnqw=;
        b=KjSr+3MX2WVRhvQpRwhVMsgh7LCdx/0q91wSC0oGi7R8/bD/nRXuKEhOxxFMQxAFwq
         PnkY/LkQwYs3t2i83mLzElFDmIuB2bFHvSJPDTetxc3qD7VeKOgvc3MHCi/DA9C9QRIJ
         Kvfg+AQv22WoHA8DcPw9NTS6XTL99xvzduQLOZVNeuFdcrg3KJdleDH1UrpxoKJ3BkIi
         CpTWhKJGYvxwo5SaIMmGOC3IzE+6v8zSKbeKdnsGe8TYRCPEA9dCmr9H/omv50rkFd5d
         XPv3Tnu2Bc2k28cOFGK9Ea0YUIekn14ouX6+XHCBbA5QFN7efen2+DSsNcktxh6fG6sy
         ucCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEru430SJ3zkbEtp/RtGpgikCUn4wO3Q7ypBI7U8NMRTz8NPvQJXfYP0oD30nEFRBVWc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmR5nHZg/Zx2lDQ3506vfHZb+LRzqzTk4IO4mBVRfteZsklmk1
	qh2pNJ8pTEsGdsEIqLPdT3zL+SidNQSFk/S9RvMZnhIpUxI7wnRn
X-Google-Smtp-Source: AGHT+IF/lMZujnGHyymrNwYmXl9N2rRA6HMRnRYEy5UhxUaidezcB1/VZMvYp735eg8CwhersbuE6A==
X-Received: by 2002:a05:6a21:3298:b0:1d9:78c:dcf2 with SMTP id adf61e73a8af0-1dc12972a96mr659413637.43.1730946895423;
        Wed, 06 Nov 2024 18:34:55 -0800 (PST)
Received: from five231003 ([2405:201:c006:3236:7331:d3a7:3ff8:4094])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a404csm294297b3a.126.2024.11.06.18.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:34:55 -0800 (PST)
Date: Thu, 7 Nov 2024 08:04:51 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
Message-ID: <ZywnS4j7gxn53N+G@five231003>
References: <20241105190235.13502-1-five231003@gmail.com>
 <xmqqikt1qhwt.fsf@gitster.g>
 <20241106022552.GA816908@coredump.intra.peff.net>
 <xmqq8qtxqcye.fsf@gitster.g>
 <ZyroYBwtQtgc6NoR@five231003>
 <20241106185511.GB880133@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106185511.GB880133@coredump.intra.peff.net>

On Wed, Nov 06, 2024 at 01:55:11PM -0500, Jeff King wrote:
> On Wed, Nov 06, 2024 at 09:24:08AM +0530, Kousik Sanagavarapu wrote:
> 
> > One way to fix this is refactoring the way in which we parse our format
> > string.  Although this would mean we would have to do a huge refactoring
> > as this step happens very high up in the call chain.
> > 
> > Therefore, support including parenthesis characters in "<string>" by
> > instead giving their hexcode equivalents - as a for-now hack.
> 
> So if I understand this is just expanding %<hex> and nothing else? That
> seems like the worst of both worlds. Now "%" is magic in these value
> strings, breaking compatibility, but

Yeah, I agree that this might be the worst of both worlds after I read
your reply to Junio.  It indeed is a hack - just trying to fix the
parenthesis case and not taking into account

- backwards compatibility with regards to '%'.
- not being able to do

> we didn't buy ourselves the flexibility to do arbitrary comparisons like:
> 
>   %(if:equals=%(upstream:lstrip=3))%(refname:short)%(then)...
