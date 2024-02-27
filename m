Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368613699F
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028480; cv=none; b=eYq5cIwJnjeFVeusgck9s2WUNlSDuWsU0+1V3LHPsK2z33t8Js9EIkAk3JLMmFKlf2lPJ7VmWNP5fHh66LuGa5+pIh2aXZI11Q5+kqB2VJVCcGJ4OC7xJq/y9d0+9vAuzeXUttO++26J6UgST/GBQ6J0eYAp9EgBILnu4BOvcFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028480; c=relaxed/simple;
	bh=GlGgu8i8PEOuS1+zry3l242ePo8SWFYyNwSJpvpVOxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9QuIOH5cnSQp91bcIdMZ5VuTD0s22v19CdfOTecgpvu0j5bO3zxYMW2IVOXeESm/Tj39fqAyA+g/3RsX8C57uhRNTttS2/DXV/5l8K52jAao/C/Q7AbYzbEzZdctUcTDV/5C4Vn4iKSgM0acwwJa5CUS7f9zjyV9Kl7+yO8AJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWIFBuPh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWIFBuPh"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so567656066b.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 02:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709028477; x=1709633277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE6IDu9XwEcVVehl3CWEHM8jJM7dfBqxX+LI/q/Yfpo=;
        b=HWIFBuPhdsEYn+Jl2vwCaQFqkTfj+Glg72FhJjsuvQ6fByPx0Mn4me9gJcQ8jF5We5
         M0VhrYle8uLDvErl7nLddQjT3hvDW85btoMmoDxl60Z24n9a/IOf5BTMe+2Oxa+t4nfI
         9ztKCpiqJOU/SrcwYTsMJXuZSx7CitSYTXchiMN8v/a6T3GNDg/DJSEez7b/fSm8cAwI
         Ht7/pmZ1W21lNQ9ahz0ExRl5txrNC8RfWG/aHkfG8St9MYqagCTQ3DJUIMRyLMnEmoRK
         t2s9NRep0mjPz3e99iaBfEAkx5sxX74DxevkuobYhZBC7gB7hIzomaWBKdNJT+Ho+bw4
         drGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709028477; x=1709633277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LE6IDu9XwEcVVehl3CWEHM8jJM7dfBqxX+LI/q/Yfpo=;
        b=fPkZ7roeB3Oo5xyCIYrybRsfSsLQ5Loe0StQByLI2j9Vp9FfX3y52XkCxYx9pcd2KE
         NFkG3cXWmU5fNPb/5GpiuSl7YAJ+5Jhpv2afylDLL0ghblNLD6ReHjxzP/pm8LrsxSMX
         gZzsVVHpn6qOmyRjOizLvpanZBGnNGTXJX2GGJx1lwBKIj1sIjG1RcMcALrvbJCyBPlf
         lDJWmVH5K1hw4e26722Oq0FDkm75LhMCO28v7LI6X1ri20YYJJvKVaRShmjvzrE04OPE
         gveNWrEu+YLm2T4JG5LQ5dD0Bla7Bx/gZN6jNN7tBBsAL8KZVbFtQtiAzjTPV9tgYqy0
         23Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV1fO1gUHIabMJR/z+oREAQYuhIDlJ6Wm71yoBkN9A1CpWOHYUBOH53XWZDPhrLIsbnz/YZ/Szy7zOellKS0khna6VY
X-Gm-Message-State: AOJu0Yw1m1SvGyRNnfXkT29L3bL5OqNSb3WtLS/Ej1tWRpYXyNk7duyX
	pLXEovZ1+Q9zWwvfqqD4Q9jUUPEa8xdpjNBITYyRUcGprBEL4F5GxmRXgHJMb7Af9KO98W7a+D5
	fMhorWusurB+AQNvvtypeYI6kKH8=
X-Google-Smtp-Source: AGHT+IH0tZDiwgmR5UtYYXqxGR8JQKy+fshcHUjXEI3kPWyOudbxQi6yXwIiAVE41ML+Wmzfob+6QqXvia50sioPcOE=
X-Received: by 2002:a17:906:aac3:b0:a3f:1cb6:fb00 with SMTP id
 kt3-20020a170906aac300b00a3f1cb6fb00mr7128293ejb.69.1709028477624; Tue, 27
 Feb 2024 02:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226143350.3596-1-ach.lumap@gmail.com> <xmqqil2bdvsy.fsf@gitster.g>
 <CAP8UFD0Qhy78=v9+hCekMJPkcH2KmeZeQ0xUx8kqrByQ4PO3Xg@mail.gmail.com> <xmqq7cirnlkg.fsf@gitster.g>
In-Reply-To: <xmqq7cirnlkg.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 27 Feb 2024 11:07:45 +0100
Message-ID: <CAP8UFD034evNrUHTomPXwbnFx=VG-ZNpwoLZspJK1pCoOjkc6Q@mail.gmail.com>
Subject: Re: [Outreachy][PATCH 1/2] strbuf: introduce strbuf_addstrings() to
 repeatedly add a string
To: Junio C Hamano <gitster@pobox.com>
Cc: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 7:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Unfortunately strbuf_add() calls strbuf_grow() itself which is not
> > needed as we have already called strbuf_grow() to avoid repeated
> > reallocation.
>
> Why is it unfortunate?  If the current allocation is sufficient, it
> is a cheap no-op, isn't it (if not, we should make it so)?

Yeah, I agree that we don't need to be extra efficient and calling
strbuf_grow() doesn't add much overhead. So let's just use
strbuf_add() repeatedly after calling it once.
