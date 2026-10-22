Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709373;
	b=0F/ORfitHp3G2HQnRN2ZaNU9X/m0LUmWgq9/gY7YBq+d7ZkNGVdN0hqYslczS5ubxdA9
	 Gmw52Ei1SubT/FffJs13zJ0xyerqaOKhJka7DUJuhqwjqf+5IUuqFE+2M267tojzgGt1L
	 AgEv4LWnmQL6XSPr29Zu682Eblu9yfpcMhhOaQWCTWxQyfphmDY90DU6+hccLUuCa4e5J
	 aIdn2WLA317ECCnd5c/0jTW0ZWUcTDub+g88aJakGr6+QYPi5vwdxOv+1yY4jDCaiha+S
	 1OwwgHqVavllBFJcLZ4BgFZ5yXG7UjT/HwjtzHr1aPbj4jCLbihjwciGZgIkIE6RZxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HJIHD1iSROUotaJ0IVXF0RKuPKwOlHk52FeEyjqjhW0=;
	b=PMAsq2B3zJaRR27CqB3lnWxYjB7CyJ09ydtYuDcB5qtrOUll5kKnGvYJ1N2NR0BgtONo
	 1qymdWlVUyKdl3kE9Mn/ICwUR89OigmCRpM9yKgi+k+EqA77C9k68PVqwEYf+kdGtiU4o
	 ViCRiP7bk/tBKiH+zHeyA6l+sfkWDcTtLlgkhVhalqK2YvztBbN/Kvdi7d2p9u9p3nHUY
	 PhRiawCeIOGMgelkidhr13koRqe3AfiqebTV/Y4Jy0zJQSersUfnUoXVSFSIYcpOwPebw
	 qzi09DJWKuajfg9BLRJ9DSrnt2xzoS6OhVTJdRoKi4qsQWWTJiiUEEQ9BnFTRbWhpew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=dOYJ0wBd;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146D606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 22:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7146D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=dOYJ0wBd
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6aa9606ddadso216139eaf.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792709372; x=1793314172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HJIHD1iSROUotaJ0IVXF0RKuPKwOlHk52FeEyjqjhW0=;
        b=dOYJ0wBdUuxH2oytcR6uz6rI9ujem69Qzoy9soyTOKrqnc8aQjPhjnRMv4qf9qKUkd
         wSP5eqZbAq2gG8NtOYxrn7MUSHrzJkMM9nX7GSdGalY6roHweBz0aosdM3dD1t8t5l/z
         Uu6wbG1F+EmjutQhKq9j4Xz+hgsVk1PpRdHgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709372; x=1793314172;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HJIHD1iSROUotaJ0IVXF0RKuPKwOlHk52FeEyjqjhW0=;
        b=Czpda57kABC0//2WHxnU+JgVlvXBhbmPT8mywUfUpG+Sdggk4Laq/nGVTUsQIA/BL7
         s3PSEx3/55694CCLmSWApTbK3BfAXEYA08SHfzzIjIM4tShDMkPYttyEIeE9v4QEpRln
         OoWu0hJrBnjQNJizbBKwtwu2HsQwqs7HcMFW4Fxs0Bizabk4eVSUsKyTm2aOdGK5H337
         9y3f5TAPIFgxA4j7px3QOdYd8S0jCzzBqeUJnWWZVf7OPA7RFtPmLJlGGAB5N4nq5Wum
         qFdlEVJ07lQ/Oo5+4uiWZbnsy82ja0BMyUNOoy0nW2lO++gqXLfAj7DE2+JKp2ltHY3N
         EmaA==
X-Forwarded-Encrypted: i=1; AKwUvBxwv19adCbIZHKQF6iDHZOwWxzAmcKCfIXVl9hQC9Rx4C/BZ9kiUE/23JDxmgxBBo3rNMc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtZ6I1cNu9aLqbR6sePAE0s/HakFm20nMKXVKnDhF0V2gVZbWZ
	IPIJ0H4DTfxyIBqsOH0Gk5mjo1v7KrgFMvXAJxpsDcTyRiLENWlQB5vkOKjYb9qXoWo=
X-Gm-Gg: AYBFou3KxzmHdZrZKc5+fKSRZpO6ot3p1n5uaQFJb6XImhRlXn+bBO9GbivPJUWmG1P
	ohGUQB1ph7vis3+KT/EKlW4EyNJ6hdgvrSWM/QrwZAjHbe/WV1QMovIIWH8+scsNxJPuMYSdaWv
	eRW29NOzXaZo5NI76InccHl4QrJXeXOq+UcFLX+Oeq+8LNzGjF1Ng4j3lba58jvanOxLeFO1S6q
	776tYyDQ45RM0pHIzVMHUJgN7OpwvwEwrtyi0xzBjMz4doeOzcYHOI2x7C9bmIh2OLc3bvAGrSY
	jhE2WWHD5Zd88eltEbGhgkUoVqp8lXNzAIAmFeRcOmrzdEPnM0EoXejA4uiwYo/yP3pM/vChLfP
	N5zc+Qasu8kgl5fBSwLDiFVPBBrhwnAWEIaP+t6Z1hGXwGJudpBfjOkQDnT7Mi6jRhPORl9BEKi
	KeSm1h1Sg8qCxuC7cWgqslMWEWVnKQvvxo+dku4CRTbchPvNCb1Dl85YsmhFYcRUQhN+oTjyK7U
	vBX0Pc7HiT3QfW70ON5fyIIfakOU90/G6AU39i25ZhOZ1GG+UwWUOdcHl8SOHsnodYlX+LmfF4c
	P2xrv3JPZdVPqKzI+bsGOjA4FKwbO5VBhTuVC+HEvuofKvcLzxZVlW3QoRatytPO/VfD2yw=
X-Received: by 2002:a05:6820:1c93:b0:6de:1788:c3ca with SMTP id 006d021491bc7-70b88b0b150mr533157eaf.81.1792709372354;
        Thu, 22 Oct 2026 15:49:32 -0700 (PDT)
Received: from com-79390 (vpn-centralus-04.tradc-corp.com. [20.80.83.168])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b8b2088e4sm434833eaf.4.2026.10.22.15.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:49:31 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:49:28 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Derrick Stolee <stolee@gmail.com>, Ted Nyman <tnyman@openai.com>,
	Daniel Reynaud <dreynaud@openai.com>,
	Aaron Friel <friel@openai.com>
Subject: Re: [PATCH] negotiator/skipping.c: parse parents before queueing
Message-ID: <atqS-JB5ayn_ixmG@com-79390>
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
 <athgd6Ya12zRdIR_@pks.im>
 <atp0Q5dFHQHAZAov@com-79390>
 <xmqq1p9he7cr.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1p9he7cr.fsf@gitster.g>

On Thu, Oct 22, 2026 at 02:46:44PM -0700, Junio C Hamano wrote:
> I wondered if we can avoid pipes, but the best I could come up with
> was this:
>
>     sed -n '/.*fetch> have /{s///p;x;/./q;H;}' trace >actual

Yeah, I wondered something similar, but figured that writing it out
would be fairly inscrutable. Seems like it was ;-).

Thanks,
Taylor
