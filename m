Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863A20D50C
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039380; cv=none; b=FRcFK4p779hcAj64xsKcU+VdBso2YiYnSGddub+EzfYbsplTtQ/90lpBP08KRQOV2yIeLizuKEdxa6R3fO6K9uRCHgCo5Rcqzs80/Im8RyZMVUIQkrV+tD9MqeKPXhAXd1pFP2+kGl1A0evN/tVaz6c/QdCKfRp6o0V6HkmyGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039380; c=relaxed/simple;
	bh=b2YQCniTw7PYCS50CF5WXxB2pO9bL9lwgvXyugIRihE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oxddom4DNX96V+ZZ0E7ahHeTlJEd3pn90MlB8RzAKv+mtDOk3dCFZnit0aTlqx2+2Cb/b5ss1mhgNZDqu7DLb7wqEx72acmq/o6me9/FezEooBfnnlcPmTNeXXTboQjgVSO8DTOkQwQi5hHN2OdeXPHYk5nO5fOPq3XAtKHLlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzdhvLjM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzdhvLjM"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af8ffa04463so106437066b.2
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754039377; x=1754644177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwzfhaXLndBzClwxdMyl1j0jxAqbFuzsQO/e3c+7SsQ=;
        b=AzdhvLjMJgyvg3RUQAceQXbltFzJsFS7ifoJEN4TLiaW3JpZbj0UD5OMmUSWv6P1Gp
         B9KsNtHy/nkNxkgYMLOU7x0o+0vKSIlQX1ivqWXONFAvgqnLRlgiGPSmRZyTKuCRLdL1
         CxL0qCitjFT16LVZ9WlUYsfhwH4/WaGckPzNF6r+r/uB54flzQzS1LUejUHwSj8YqtTa
         NY44QNLV5qwm4qJAWnWUFajQi2Bxn6CJRfUxOn3Q5I7m6ZraWCG2JSBBa84RarWUgqja
         b5WOfLPCIeHcoYg2CHu88/aYLGq9Z8pQaxevpIWKpEdw7aOh1SF+cqGXrnsuSvbrjIKK
         fsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039377; x=1754644177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwzfhaXLndBzClwxdMyl1j0jxAqbFuzsQO/e3c+7SsQ=;
        b=F5huU18QluU8ybCftzS1y9Qhe8j1t+T6VfS7jU1HzWUKYOdRXT8yqy3RrbyH4IufJf
         4l1LAxmVrHJNcpzlsHQ2UmoslL4wKT2wgsTbNUi9xI9SmLKa0Of05WI6ZenAMIdTjL8e
         sxwFhdw9W1gFelfc1VjIhiixl2ZK7JHT/Go5efdzhdRMlbnT5ni8QRse1CwSlyHfvvLc
         pX2zec4lSlCcRBsdla8cmp3nDXUZ10L06VgAyrLLi1kueWdvXwKBap2+HZ1Yk8A3LnCi
         DI7gFK3d8L8If797Bw6kU76x+iTOouRa20oXYQtOOqcNgawFUZESKxgzgRHwSexxSHdl
         3zww==
X-Forwarded-Encrypted: i=1; AJvYcCWQGl5MFGJfwxj5sltYpSWM5K8e9aqLAs6L41IrMnkAQdN9aIWVnb3WiQ8FEx+4ihpNqlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzIRE8h5ExdtOccfL/ZUPMkIuYmkSXn/vC8TwpFzPoTD2HXQ+
	wZaU5OHUkiHvoTSpEuQ+crg0XpUhhU7wGluvAoBqFHIN6FpgpLxoDyKNw6+OYHrp4FmWosN5ol3
	crfqO7FzxO9jdAM9Tt4pXybSeyxeYMKo=
X-Gm-Gg: ASbGncsBmblS9WmxojxNEpJKL7SSTJ1QpDQc4NsAgT7AVCQy7gG57XTmLKnaVZwrurf
	HW3MoE8R4z7QfM77IvdZ20M6EMv94jqg/5yjfexVr+V1UAGsd3TIwMOzKM2ckBgWXptCEwGxm2w
	X8Bv5JumqD+JVHP1srILBJQqBsunQ2GA0EJMGAWsshMGE0QQdxcg0xojlgZCcmbtokqR9xuM2Q9
	7T4glF5wWSW0vHDEbNM
X-Google-Smtp-Source: AGHT+IHGxDuKjhRskD379gkghik10H9ZxEAxMVNtMgf7EYFoxMM+zh5IgnTdHBS8xnIhvJUIQ8MM1tyIXgD0RQsd6+Q=
X-Received: by 2002:a17:906:6a29:b0:af2:9a9d:2857 with SMTP id
 a640c23a62f3a-af8fd578a69mr1199682966b.3.1754039377053; Fri, 01 Aug 2025
 02:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133518.1788126-1-toon@iotcl.com> <aHmPHcNQYlhGo8JB@nand.local>
In-Reply-To: <aHmPHcNQYlhGo8JB@nand.local>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 1 Aug 2025 11:09:24 +0200
X-Gm-Features: Ac12FXwWzlTSTuc55mbVjX7MSftgxO1vya0FYlWNYL736kiI8n-ay-lvnc_R-6o
Message-ID: <CAP8UFD18Ds4zME_ZHRdTA0W7KXk57zo9664xaU2TbH7YsHbFUg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] last-modified: new subcommand to show when files
 were last modified
To: Taylor Blau <me@ttaylorr.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 2:02=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:

> > +struct last_modified {
> > +     struct hashmap paths;
> > +     struct rev_info rev;
> > +     int recursive, tree_in_recursive;
>
> Can we either make these two part of a bitfield, or at least declare
> them separately?

I wonder if we could/should use the `bool` type from <stdbool.h> as
Documentation/CodingGuidelines says that it's now allowed.
