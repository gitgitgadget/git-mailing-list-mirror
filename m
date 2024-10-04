Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4933B1C7610
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059503; cv=none; b=RsnR10m3QTyPRkpV45tc0kaXwnFxoyRFuhdDn4Mo0jodS9PE5oLAbxq6PSBxU3Uge3YnG+obwRVWmJ/VhdaYQK47XrWqH+zznuSivhl4URD+fTomkqynMMyQFzoQpgXr0eltGHqL43vMOb9sBlyYtINS98M9B7IVLIDhxR0pnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059503; c=relaxed/simple;
	bh=Q/TRokDcja2ja5Z1+iiCLZQPEq/NEDjrIDwIA8Ut7nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBIwciRTuAjJ1WSzhAn4UKkx7Lm+BR8DzljWDe6RZxV9OC6HsD0QE3ITlnrkfGA7vMKfNtmW8NEn8WhXjXp6k+YWR8aoP13K6BDdhsJkejUQPpHsxBK5Jwjra5FbsmX6EZjiDqRHULi5+bYnP5qUsGHrymKiCTFXTgEnJtM19xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaejSDaV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaejSDaV"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7178df70f28so2068185b3a.2
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728059501; x=1728664301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCc2b61u1vpYL5ToY2CLg9giQcBoSxCxV2myzKkKOGs=;
        b=IaejSDaVgU68Oyx7N1rvDK3EGYSMLy4Qp49eC05zRgDl49F1nbRBBq5BubcQuRwMRV
         jVG1TQRg7quds3alh9ureNPfl6yliPiZpLMuGbTC8sn0NKeiTlNMDw1CmQ2PAR8TRm3V
         Xk92nJprFQJQsefcqonYfxroJ59m6yePKyYCEktOj//BRmPWXw4slZIu+oOvHYyqVRAt
         U9KD1Rf8EufdtbG3JnNaaTI9EyDc4QWJb/4rNrmKzVEd7wkZS5Zvsz0Mq+qfWo/hyLER
         52lJ0M8PoIhlJBcn6qR/cetu2FJqpdpTky+9mphYx+XA8BIiRqSpLnEibBNmT7fsugGU
         Ie/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059501; x=1728664301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCc2b61u1vpYL5ToY2CLg9giQcBoSxCxV2myzKkKOGs=;
        b=PG4lTpTNpVjmdWchHyc0SvnPlmSXSWLEtcjY5Oju76TrzjnnZNP1vnzEaCdIAqbC1D
         Sq+5+83W+lNgzGsvYCw09oWOU7MfmLEjoXNccybC+JF9EXj24o4+V+hzykZgFPhVQagt
         9/J4THfYXNLtMmbiKVxFWVNg9o9N/N5RFiVf+OG5RQ3tPe56xzSveJo1vArS5x+5f9Wn
         4aoofJa8I4jY/LCM9c5jnUvfwjGaTXdXC8VIlLrD3HE0DDzV69DtO94PX0VpQmHsDV9K
         fFSjJiQFPRCcF+elJV0i2gPUtZh2kdMwDl6rLIhzzrlXL6V8PGy01/HoKxzDPBvZ0to/
         X7ig==
X-Forwarded-Encrypted: i=1; AJvYcCVeycAG3vBLHZ2EZUQXS+IYV9rwO67yKoy43htjonlpRzMlBMr8QiMYWJWIwnSsIzwbCsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Sckyal8DVOXtKNTmm02PpTUoUwGEv3F3C/s7RMQYTcMpLRYU
	z6tJGkjoruUT61+mQyi5mSj6CapWHMzzvIUzIqN+fLzxnbLBlW/+iUoF0A==
X-Google-Smtp-Source: AGHT+IH5yXKNbjcTG19Nvk5UzZJEo2z/vHcgc1zqC8zy6IgmccsJfOhIvOI7hUxD37XavsydImKROA==
X-Received: by 2002:a05:6a00:1253:b0:70d:3938:f1a5 with SMTP id d2e1a72fcca58-71de2446f90mr4699507b3a.22.1728059501244;
        Fri, 04 Oct 2024 09:31:41 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccf02asm50749b3a.74.2024.10.04.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:31:40 -0700 (PDT)
Date: Sat, 5 Oct 2024 00:31:45 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
Message-ID: <ZwAYccsboGIhGVIx@ArchLinux>
References: <xmqqh69thzd0.fsf@gitster.g>
 <Zv7aLRXwt9cfqW58@nand.local>
 <ZwAIM6GO3VtoG3ZM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwAIM6GO3VtoG3ZM@pks.im>

On Fri, Oct 04, 2024 at 05:22:27PM +0200, Patrick Steinhardt wrote:

[snip]

> There are two maintainership models I can think of: either a single
> individual or a group of people would take over.
> 
>   - A single individual needs funding. The ideal situation would be if
>     that funding came independent of any of the large forges. Or
>     alternatively, the big players in this context come together to all
>     pay into the same pot to fund that person. In theory, the role could
>     be elected and serve for a limited amount of time so that overall,
>     the community is in control.

Well, I think we cannot easily fund a single individual. It it is a
full-time job, we have to also pay for the insurances. I don't know
how to hire an individual in an open source project. But intuitively I
think there would be a lot of trouble here due to the laws. As far as I
know, Junio is working at Google.

So, the biggest problem here is that most of us either work at other
companies for full-time job which are not unrelated to Git or work at
companies which are related to Git(upstream). Although it is an honor to
be hired by an open source project, there are still many concerns for an
individual.

>   - A group of individuals could take over, sharing the responsibility.
>     There would be a ton of different questions in this context: how to
>     form the group, how to balance its interests, how to distribute the
>     work across its members, how to resolve disputes, etc.

From my perspective, we already did this. Junio will rely on the reviews
from other contributors. This is what I got from the Git Contributor's
Summit, 2024: [TOPIC 10/11] Project Tracking.

  https://lore.kernel.org/git/xmqqployf6z5.fsf@gitster.g/

> So... that's just me dumping a bunch of thoughts. I'd be quite curious
> to learn about everyone else's thoughts.
> 

Like Patrick, I just give some my thoughts here. Because I am a newcomer
in the community. I may lose some context. So, there may be some
incorrect expressions.

Thanks,
Jialuo
