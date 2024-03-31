Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A579CC
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711869141; cv=none; b=jw4wMVlTZrLUB2N7Tel7LZVU2QHeVOQkWxeQRVNqJgFomm2348tKFRZ/UEDE/1mA5eWAf0v26SZfykgf/wSps7aBmr3X4+HhxB9ZT9LiQ21/HtNYpLeINNSwBfXfFDiVb1EvlgV3naOp92CZ9abdl+3XOKwYHN0mk4yR55TWi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711869141; c=relaxed/simple;
	bh=tM21bXargaiwJw4P71LxlXRlXF891T64o+nLxDWJzS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLh0It2QFKZOx8gv5xWsEOIg6TtIVcZAW1W9OEI1NBpAY2SRIt+zlOEMf3V+yGhH1jt06sgnWPH3tQhUmiKeT4n3YaMb7Mcrt/y4kCJPJsIMm9xnrEayO86eQN1KxdI1KriRTirH6ZK377pkZlAj+VVseJLfuNOdNHXRicZ9iBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9T3afOw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9T3afOw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so23365515e9.1
        for <git@vger.kernel.org>; Sun, 31 Mar 2024 00:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711869139; x=1712473939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozmA49dhhoeDc20FXkBigaQGJVDi6TGCfXO+0/40gV0=;
        b=X9T3afOwhAGQuv43xI6DqvdUu8hQrHS+2l80Llx/cmEEOSSK3c/vtHTiMkp22vKlhz
         0qR3CAc1sbPo4yCh40SzWsfwL9ORgLwmdpTvsFzgwPlgYFgiAMtHMCD1c+dETJI9+eng
         HSODfNzsrfZwXocf9KZnXna09ZUfiLWuvi0QEn3b8DjZmWRsNsucV4gOInhSEpcn0wgj
         Kvs2BCm/4nEtQYgP3siBEB4xO18msNwGkhiDNG5s/XsdhXbCsqlRTJBvPWAhuiXDPo0h
         dEM4G4Oig4xBwF8K0wSztvUKhnYTYPtaw93aN6IQB+7syhOYhQ6Zh7tMF0d3KyTRNy57
         Gw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711869139; x=1712473939;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozmA49dhhoeDc20FXkBigaQGJVDi6TGCfXO+0/40gV0=;
        b=nO2Cq5T2mJ4V9atXup4HiGsLFWrphkNffG1jntQyiWKiyQEgRcii3KULP4sDGkqRdM
         HrKVZuyIe6d2LmElG+h+2nZGL83TlrItaUpdMr6IwSd4bp3Slb65V4lQaI4P/VTEM43u
         Ypz56G/xgF7ir5R1vAGK8xpLOJe/2+tBpfnIyyzqg0YBFN22Wzhah2OgF3nhqN9tCaMH
         +WwVeGa06Fk6aXGiRZAYP1Q81J9ccloRURgymUEoiDX5tLkETWZKTbpYTv6q9w0i/bz5
         /YMvRblKNOm21P0loNIeuiyTycLdn6ZafyM0uGkUeVB1qZOmmoIopBH6YvUpHSXntsN1
         xTLg==
X-Gm-Message-State: AOJu0YyJ2UDWSgAZCyFBMmlspgX4obuXyYvCkgilM/gxjZiZ15HDYpWq
	a/5srQcyNUi0/JyYBJDS30qnDk8Fc0XVcHcSBvRbRY6XhJFDu88TPAnS1rVS
X-Google-Smtp-Source: AGHT+IFcGPdZRm5RaYdK11UAfAnQbVQIG4mwiMhqw25I84790k2N91gkZDurA3Sy7F8m0mwN0RUHWg==
X-Received: by 2002:a05:600c:4f85:b0:414:8c84:5f43 with SMTP id n5-20020a05600c4f8500b004148c845f43mr7849298wmq.14.1711869138489;
        Sun, 31 Mar 2024 00:12:18 -0700 (PDT)
Received: from gmail.com (26.red-88-14-197.dynamicip.rima-tde.net. [88.14.197.26])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b0041481207b23sm10850943wmb.8.2024.03.31.00.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 00:12:18 -0700 (PDT)
Message-ID: <0f43cd7b-a366-4ec2-9577-93708e21f2ff@gmail.com>
Date: Sun, 31 Mar 2024 09:11:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: omit trailing whitespace
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq4jcooddp.fsf@gitster.g>
 <fc002d62-6efe-42d4-b562-c10d3419fff6@gmail.com>
 <4c8da56e-974b-474e-aefe-1ced5ee69327@gmail.com> <xmqqcyraj3z7.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqcyraj3z7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Mar 30, 2024 at 11:43:40PM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >> >  	for (cp = buf.buf; *cp; cp = np) {
> >> >  		np = strchrnul(cp, '\n');
> >> > -		fprintf(stderr,	_("%shint: %.*s%s\n"),
> >> > +		fprintf(stderr,	_("%shint:%s%.*s%s\n"),
> >> >  			advise_get_color(ADVICE_COLOR_HINT),
> >> > +			(np == cp) ? "" : " ",
> >> >  			(int)(np - cp), cp,
> >> >  			advise_get_color(ADVICE_COLOR_RESET));
> >
> > Thinking again on this I wonder, while we're here, if we could go further
> > and move the "hint" literal to the args, to ease the translation work:
> > -               fprintf(stderr, _("%shint:%s%.*s%s\n"),
> > +               fprintf(stderr, "%s%s:%s%.*s%s\n",
> >                         advise_get_color(ADVICE_COLOR_HINT),
> > +                       _("hint"),
> >                         (np == cp) ? "" : " ",
> >                         (int)(np - cp), cp,
> >                         advise_get_color(ADVICE_COLOR_RESET));
> 
> It is not guaranteed that any and all languages want to use a colon
> immediately after translation of "hint"; the current message string
> with or without my patch allows translators adjust that part to the
> target language, but your version will force them to always use only
> a colon there.  Is that an improvement?  I somehow do not think so.

I was just thinking if leaving the format open to the translation is a
sane option.  Maybe we can move the colon to the literal in the args,
too.

In any case, the patch is OK as it is.
