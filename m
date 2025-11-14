Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366F6BE49
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763099541; cv=none; b=lI+BhhiVbL/vphL4qkZKprulY9wHDRNzqFnfIMlJqd157ySI3BpaZnRBxl5Fg6DI7zDBw3ThriEd7CY/nQnwafc+4uDErialCzgQznIl0HsPXgBh/KaUK4i0lcDrNujxwdgAQtOnZYI693zn/nhfxdRVqeCzlA6diZ69GJl/tFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763099541; c=relaxed/simple;
	bh=PKLu3NkcrB8lJhBWDOnYRapdHR94s5vS5AW9QOGW47o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRq+ZHKGYCXUFEZUm0k9iNInO/ANVGd8qAAG4ChwacfiEnbDMNpROqkf1Wp6QVuV+ZzP5qwV38zfOOfg22XOxo1QfCDjE5QOrn5QBXH3UYlY4LQKZ02OCVQL7xF5C4aLr+EgOPkLH+W0wCNLP1DSltjKkR4f5LZSfWmkhRUvt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evWSqK2e; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evWSqK2e"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a5bc6b491so12640661fa.0
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 21:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763099537; x=1763704337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01wJzQ6k3eOeFQZsVoUQXs9Cf785hsSXEJQSIHm2Bso=;
        b=evWSqK2eh6DJPANoL1Km5X0/FMNQX2LnLMOOFpgXLO/PrDWG7WCMENgxT1w5lvwPmw
         Ct7koim8ShBEviBbpi/LyDQKk0MdaS8dcnl8eyEld3KeSTaL6Mf18UPBH24TAAoGhSzG
         ArvS4i5r9E+e1hbZG6dk4wgNg4hUgeQMmEQQaLhdS/kkUSUkwywN6fTz3wg+CEp1AsBg
         4tZIHfmW6LAnfoN55guUeZoj72DOQpk1p8E44PsdwhvZO9k1ExdicxowG6XZc4e0f1jA
         dcYIS9FbSywSuc5TVJsYUFHAIlibEQhEPrB++7LG3cJgZGC/653x9xmp67H4mP5VAoH+
         vaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763099537; x=1763704337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01wJzQ6k3eOeFQZsVoUQXs9Cf785hsSXEJQSIHm2Bso=;
        b=xOPzsDAVXwiXuLLvOfmedCJwTu1qjkHWIBX+gf6OruAZaohU+1eFBOl1PZGowHqYXh
         Ymn0iR/ctOG053QtGhV5XAsi8oIBMMoFIHy0dEtDG99+cSfqx2nET7hISjyvfUsoIxz+
         utvvqpBqqGrUtjxf9YBW9CzWG/sbfO9CgR1uaPSR5LebVZXOr16zkKxxikPOWEckugVE
         OfN6/KXK7bqy2ygHBbukq+faWJPZdQqFgTABoNY4UhuAd+ldt97Fiz2qB3Vwge4hz5n2
         qiiA6zSKWBAzgVC57z+PEerTw5zj/kcM7967nmvqq5ZQEfeqj13t0gIiXMuvXUHHouqD
         3zeg==
X-Forwarded-Encrypted: i=1; AJvYcCX++qkt11Zq0gwAgxOmz6PtMMmipRPqDjfblIJz06KFIWJ4uHN26x8bzE/xbrc1jxiSk7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws/OuPznqvIfC8rAwokrtgZZ38u2qqqD+z4UDPdJ7Bjnv58G3Y
	6u2Ms8yCE5CES6tebdJkmTgDU+b7NWzlKTScBYGO9H/dcVa+jcaxW4V1nzQg3G7RpJaEJmQJYv3
	u8++31eTeA4Kn6EeJK3TsXt5t4TvAeyQ=
X-Gm-Gg: ASbGnctE8ysaCz8+NBmF/Dzg2anSRxmdFSAzlLGyTsBkrFk/8/hk+27bJBsjdWARH6d
	9dTveb18CWcZX2GBua8N0MO9At7zjrw+YAt0vEKuS7o2eLCWL8GccSflTgUh0i6mox4HQZYY1tB
	1d2wF1puEVdG/MLxm2ft+QqgLS2yayQW8yTghvnsrpxssdtZF9/hLlDYTsne7hXR1XZZQCrEYpa
	vawgVej8abW5/mowxMYT54HPGTAuUmVQmZRIOudj99y5GjnBZ9DPcjNw1djSDR7N8CIfaLvDAxl
	gEfneiM=
X-Google-Smtp-Source: AGHT+IGduu7XwFAPvVB4FOPXl66uXI0DNYQA7vGPdVsLDEPDDe5ysWsEQ0ICuSiGDTv8Y3LI1vtK4xRfHM9fFGhtEsU=
X-Received: by 2002:a05:651c:4196:b0:37a:600e:ca24 with SMTP id
 38308e7fff4ca-37babb7fc82mr2980301fa.13.1763099537179; Thu, 13 Nov 2025
 21:52:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
 <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com> <xmqqqzu4t9yc.fsf@gitster.g>
In-Reply-To: <xmqqqzu4t9yc.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 13 Nov 2025 22:52:06 -0700
X-Gm-Features: AWmQ_bkmGZMtlPWkXx25OjqRqLl-9PLzHrAownYVpjJK840gfssI8AVuuRzMB8k
Message-ID: <CAH=ZcbAQ5fCUuL3cpETQmGNXsPE_5UMf4CqVgjj0vvmXmU7-Vg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Xdiff cleanup part2
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The primary goal of this patch series is to convert every field's type =
in
> > xrecord_t and xdfile_t to be unambiguous, in preparation to make it mor=
e
> > Rust FFI friendly. Additionally the ha field in xrecord_t is split into
> > line_hash and minimal_perfect hash.
>
> After having read the series to its end, I am left with this feeling
> that it does only half the things that it needs to do.  It does all
> what the above paragraph claims it does, sure, in that the relevant
> data structures now use not "long" but "size_t", not "char" but
> "uint8_t", etc., and I do find the resulting data structures sensibly
> described.

This patch series is already 10 commits long, and it's been a
challenge to chunk cleanups of Xdiff because its code is so tangled.
I'm hoping that future maintenance of Xdiff (after my xdiff cleanup
series is complete) will be much easier.

> But for the code to be truly consistent between the data structures
> and the operations that work on them, types of on-stack variables
> and function parameters would need to be updated to match these
> struct members.  As we convert one structure member at a time, casts
> may need to be sprinkled for assignments to these variables and
> passing these struct members as parameters to functions (which I
> commented on one of these patches) to keep the blast radius of the
> changes in each step manageable, but I would have expected that
> functions that used to take, say, an "int", would be updated to take
> "size_t" if the value coming to the parameter is from these struct
> members.

I had to draw the line somewhere, and I plan on making more changes to
delete more idiosyncrasies in Xdiff.

> Perhaps that would be the theme for "Xdiff cleanup part 3" series
> that we will eventually see after the dust settles from this round?

Not just part 3, but the entire xdiff cleanup series will be about
correcting types among many other code cleanups. This patch series
alone is unsatisfactory, but it is only 1 of many patch series to
come.
