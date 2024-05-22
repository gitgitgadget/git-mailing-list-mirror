Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C347BAF7
	for <git@vger.kernel.org>; Wed, 22 May 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716413026; cv=none; b=Xwg1MnPmLipST5leZ5bGCsdnNNY4446f3cDNEfOe0V2ZuoQ92/g7oa7x8F0ZlpJ0BexIFsFp1R13df/Icj2FFW9UDwFCnY+0vUGxadIeeeGDdf94BwK9NJEJpwaWHI5SqIcLhI46L3Gl/UbckLySAz+UwvyDc6Z5gSZPjLghdNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716413026; c=relaxed/simple;
	bh=cWdRRkeo1NN0hcEfKLOr1o8y5s6P5UAVYrhWlwnjT+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVwEEfKSLgoRUZIZSn0PJajHX7DWZ10AjF9cYk1zpcrMOxdqOeHxwyXAhuZSwwYVCyUhEmMe6as2RQKfZmrJFqJVddZ5uZufTmRhfQW+/ZR12ltxGuAp8VmSe8D+GVlrdfEU0rRjgt2V0EO/CsJQhGkRbTNQebqp3NVTyqagkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFTbAqZC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFTbAqZC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-420180b59b7so12439875e9.0
        for <git@vger.kernel.org>; Wed, 22 May 2024 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716413023; x=1717017823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfxS7Y9ICqGgBaWVUnNv7/mqO39Y51gGMZD9dSFuBO0=;
        b=aFTbAqZCAl7iWxjcaQEHVluHm6HsLufmfwnS+phVltZALSYRoJ5D9cZqmqKAtqpdMX
         9SmFL535BA5cVLHY+q2N0kuXk9fUFTrLwMMTs3Sz0RhRq5rnor5dTXzKL6lE2h3N07ub
         u1b1YnPpLnKsYfdsXEBQsTFLuBgCss2W0OkxabiXQK6MenLrcvfjDPOJykI2qlE8RN2z
         F3SnoOaPuK08wFEFwyq5pDFE8mdQpienQTcae2d4zLNRlvHafUv2g1dT1tMH0taU6bTX
         ptn/P5y/NW3joSAyT+V34YXA+S16RpnIb3vIHZ4iPRnMqnrvuEYYeGbmRvESuq2bQ+ea
         qJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716413023; x=1717017823;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfxS7Y9ICqGgBaWVUnNv7/mqO39Y51gGMZD9dSFuBO0=;
        b=vqT8Q1HEPC/Mkaggjmcr7SRnjFwxYd/gVAK2tVEbUrbwpwq0c4OpVz6Q5u2EMvDFRb
         6agStA+504qroKAsrYDU6l566rcrZsepjeP+hASP+QgxJ829tnY6DhIEtuRNjeX2Os20
         1ZSDJki/ueE/JDGd9JFQm3NnHIEUINJww7e1kkiGtRoxDzDiEi/WPuxyLrNFFpUCG6Lp
         YcYfIyDwtTL8A5bCOyAggkSmRxEhFKTDSBNnbRJPo49N7yDUh8bH7yC5Ovr8IHkJbg8s
         yk/Ba1fw54SoNagI3b0gks7IYxuHFdlhv53OOZ46k4lpidAjkfR1oKn7xWxtFjbWxhst
         v6yQ==
X-Gm-Message-State: AOJu0Yyw8wgxvhSOzbtUKTCmR7ndrfE+yEMmk6ADTf4ItZDjYUPL3wvJ
	Bm2yk76RvQ3y4y0XMkwwbXQ0QhRtNsV4lnro5ELCzDpwYGxAC8Tt
X-Google-Smtp-Source: AGHT+IHSJfueo7Nw3Om+5uAly1mD9zn+if5IpuWUnpmlPvzfjliJ813b12X7WgF2C5VWsxY89iv9xA==
X-Received: by 2002:a7b:c019:0:b0:41e:1bc1:36de with SMTP id 5b1f17b1804b1-420fd36042fmr24555035e9.26.1716413022907;
        Wed, 22 May 2024 14:23:42 -0700 (PDT)
Received: from gmail.com (133.red-88-14-54.dynamicip.rima-tde.net. [88.14.54.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f99d7fsm5452025e9.31.2024.05.22.14.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 14:23:42 -0700 (PDT)
Message-ID: <ff8efadb-4c1a-43ce-9b12-7688d6062c18@gmail.com>
Date: Wed, 22 May 2024 23:23:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] add-patch: render hunks through the pager
To: Dragan Simic <dsimic@manjaro.org>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <310a2904-681a-4bee-96b9-90a2dc107975@gmail.com>
 <1accd0163c96811b7b7f146e477acf89@manjaro.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <1accd0163c96811b7b7f146e477acf89@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, May 22, 2024 at 10:09:25AM +0200, Dragan Simic wrote:

> > @@ -1387,7 +1388,7 @@ N_("j - leave this hunk undecided, see next
> > undecided hunk\n"
> >     "/ - search for a hunk matching the given regex\n"
> >     "s - split the current hunk into smaller hunks\n"
> >     "e - manually edit the current hunk\n"
> > -   "p - print the current hunk\n"
> > +   "p - print the current hunk, 'P' to use the pager\n"
> 
> I think it would be better to move the description of "P" into
> a separate line after the "p" line, perhaps like this:
> 
>   "P - use the pager to print the current hunk\n"
> 
> I know, we'd sacrifice one line of the valuable vertical space
> this way, but I find it more consistent and much harder to miss
> the new "P" option.

Making 'P' a /version/ of 'p' allows us to skip adding 'P' to the list
of available options:

    (1/1) Stage this hunk [y,n,q,a,d,j,J,k,K,g,/,s,e,p,P,?]

This is what I though and this long list is what worries me.

But I see your point.  I am not opposed to adding a new line.
