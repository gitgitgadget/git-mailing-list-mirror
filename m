Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAE33987
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770669159; cv=none; b=WHqgzZWa2oopZJboew025jW3M5sPCeiJ18adk8RG/9bRKGRYfxchZWOydh0I7MKO1Zn+vzWFjbfJ6YbiaR1//+xLVt0CGYLAmG/0zHi7MujJzbdn7e8Hk5ClzxrN8LWINpHVvV1kwmDC71FeQlQZI3jx0jXoX4CBp3xLgXSMKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770669159; c=relaxed/simple;
	bh=PNHclnypM3FPWN6a/MEORiKCIQCbaiOEmlu1UhIyDE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHOA25JYeSQ0YPz4xkzJ6i8oLc6qbIQQNNryzhh0+mqh9buaNLphCKuO/I/iWgUednXEKr/YDnU7nZ51+1mskgekDoDa9qZwwnWhKd+aRDFlnZ5H8P5c5e2suKAy6CEhGjDR1RLvsCoIg34uHqp6uTsHYJ0+0qj/u6SsXdfA2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HM2B0GCs; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM2B0GCs"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40959ad00f2so61763fac.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 12:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770669157; x=1771273957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zKXt8MmyZYdBJN0cpA593kZ9PDCLviKzyrRWkfKE/rA=;
        b=HM2B0GCshFUv2Uur5fl1RWg8Hh/Kr0veobeG2QPVUF3kQoGJniyS2kwW4axiyTTQAK
         wYXwBudNkr6kHM6K6lAw2C997Dul39h4VkBLS+R2kopBtzsrFYmnNmq/V6KxzwPsWHJ2
         s5Urpwe1vatN3YFt4UAdsblgcsg17ZRECbHBTbHB9M2sAuA7jYXnOMlUbTlrp2WJ3I//
         0GrMgpBttB4mvSePI2PsIW+WZ+BSqN7Ct7pzpEGjCU36Uyg3G1wsSKcd7D/+3bOnLrND
         1ariH6mMil00oJx0KBvqjGfcIiWcnZ2oYUn3jWC5UuYDISwbhaeW5fsiRvz7wyhNIKwY
         4peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770669157; x=1771273957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKXt8MmyZYdBJN0cpA593kZ9PDCLviKzyrRWkfKE/rA=;
        b=kn8XBF6Yd8Tc3vGIgGluPwJeswaVZeDodbQnyMvZpefkVSVoP/TGM2pdGIvswk6HGc
         8X7rmXjOvhUXn0NR8AD16BSnH+kUltvybr9On9maF6nte80/JPZ9ieAsOxzFVRGsboQn
         my3pDytqYHfTBv7GSm/2QoaR07QHTsXFVVESYHnThXeiGKzzPv1P3cs8WUw1AIiH+W/7
         eDkonO18Xk/J2IbHJtOZwpdFuA8RjHUTk5QZLa8B+99CYc6rcBqs8/KEsDKzouzPsk6z
         WOeLNh+imRBtHNse8WNHx2Lc3LeQ/xfNq5wZ/X66imcfRRbAUGnku9sIgDYwF68M8Pd9
         rwPA==
X-Forwarded-Encrypted: i=1; AJvYcCUqtTgL5V++Al8yOtZvMeWQX0PbYZtVo8yHQlAQOo5/Zmru843kmNkmeBgU5s8vRsKh8/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7E9o4N1icBnULT0VZyck6RioH20ZCjyISn8G8o1fIR4HxHVq
	eFUoreveE1civ4q17uPJbsjgIML56BFAFjojNpQw1Kn6VnMZYJ+C2tPH
X-Gm-Gg: AZuq6aLoEuJtNIa42Jh6Yi7AHk8FjpLFR1OIf4TWiE6tkFv2dtTnvdpUx81aKgBtYQs
	vnKja6gJRGEOIbwA2sg6ZcHPf1rjPcF8ul2hi9uJ0xstAzZy0esYF4fbMHcCcn58TxLvL/mSSAr
	UOnxOEoDnK7YtQC6H99cF3x7oNYqYFoSegpYe5o0noVWkcWzFfEdOFuT3iRGTuMFlLu3nH6EWYn
	6RgIflwT8jdvW77rwttgdGl8U6uEgAAAoXZ/lAXmoLx/sZnbKS7E/fI3E/tz59U2oEjfNzrm+Ip
	4e4ZIF8MtVoqjkRG6r7wJHd+VzMcV/mZ/K1FTLSGDHlOGhwE7Kad1u+wovw+kMVxzgUYR1yfcMK
	uuQkZC4rbxtlJ7YeGxZtyjZYgnHX/mPquIV6K8+05I8xuO33OdDS2eWZ2aukDBtZW0sTIlleXvU
	dRqwqb54vDkBFZx2g=
X-Received: by 2002:a05:6870:264:b0:409:85b2:5813 with SMTP id 586e51a60fabf-40a96cddab9mr7110957fac.25.1770669156663;
        Mon, 09 Feb 2026 12:32:36 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a99355b7fsm8252834fac.8.2026.02.09.12.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 12:32:36 -0800 (PST)
Date: Mon, 9 Feb 2026 14:32:33 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] odb: drop gaps in object info flag values
Message-ID: <aYpBH2eSjArsM_To@denethor>
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
 <20260126-b4-pks-read-object-info-flags-v1-3-e682a003b17c@pks.im>
 <xmqqa4y0jop7.fsf@gitster.g>
 <add7c86f-9d5e-4136-8c3d-a04df523487b@web.de>
 <xmqqpl6wi6n4.fsf@gitster.g>
 <aXhbXQo6taM33m-1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXhbXQo6taM33m-1@pks.im>

On 26/01/27 07:29AM, Patrick Steinhardt wrote:
> Unfortunately, the other callsite wouldn't see a warning because we pass
> an integer constant, and the compiler doesn't complain about that at
> all. It also falls apart once you start to OR multiple flags together.

I guess we could have enum values to each of the combinations that get
used together, but that problably isn't a great idea if we use many
different combinations and may not be good in the long term.

> It would be great if there was a way to tell the compiler that a given
> flags field expects only enum values so that it could always warn about
> misuse. But I'm not aware of any way to do this.

I agree with the sentiment. Passing a combination of enum values as
unsigned flags is a bit fragile and in some ways feels like it defeats
the point of using enums to begin with. Also when using a function that
accepts flags, it is not always immediately obvious which set of flags
are expected.

> We could of course start to take a more heavy-handed approach and always
> accept an options struct instead. E.g.
> 
>     struct odb_read_object_info_options {
>             unsigned lookup_replace : 1,
>                      quick : 1,
>                      skip_fetch_object : 1,
>                      for_prefetch : 1,
>                      die_if_corrupt : 1;
>     };
> 
> That would give us full type safety, and it would be impossible to
> misuse without getting a compiler warning. Furthermore, with designated
> initializers it wouldn't be _that_ awful to use:
> 
> 	if (!odb_read_object_extended(ctx->repo->objects, &list->oid[i],
> 				      (struct odb_read_object_info_options) {
> 		.skip_fetch_object = 1,
> 	}) < 0) {
> 		die("...");
> 	}
> 
> But I wouldn't exactly call it ergonomic, either.

This would certainly be the most safe option, but I also agree that it
not particually ergonomic. I'm not sure it's worth going this far as
long as it's documented/easy-to-find the corresponding set of flags.

> So I'm not sure whether this partial protection would be worth it, but
> if you think it is I'm happy to reroll.

I think this version of series is good and doesn't need a reroll.

Thanks,
-Justin
