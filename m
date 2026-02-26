Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88813AE6F7
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115331; cv=none; b=M+ba/byjzX8o+/nahCBLJPNZmPs/rl6NFnTwuTd5aTwheziQ+apI8SVPIzw64Ox+LPicDzxWuJlUeJwR9b2AC0+U+QOrkmyYxLoPScZ2NDQvfEFvvWe8fdfeoNPHhPmbrb+VvkqzXhpMN08w/eVDHBiC+atHX/l8x7jbsHfemuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115331; c=relaxed/simple;
	bh=ckLUzAaqnoS1mobPRgkJk1r9ZCugtN0Qevrx6a4higw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ScrayauBMiWYz7vIIaSpA+wRTPphpDs/YqDMg2ZPrXfBlclMVUSRWUK/aDrN2Q+3clXoSRaIDuR5r9RnO5dx223NUQlU06JEOADfxZwMs7VYJ+FGYceCxoFFIKnG8pqF+siXEHSg5dEHhlF/aplneQOdogJdjupo7tzdRyvw60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L15kXdPH; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L15kXdPH"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94acf9ce1b7so716390241.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 06:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772115329; x=1772720129; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckLUzAaqnoS1mobPRgkJk1r9ZCugtN0Qevrx6a4higw=;
        b=L15kXdPHKY0sZXDba78XubihZs7NrOFHHTcASuyxcZ0UxVfIq6rjcn9QkDNGK30OHx
         03zIyUf5lOhVX/kUL4s6kpFuGucoN7+ox+dFFSTLU3VaJHKCwEveTSwqU72znAfNDGb6
         3ZdLs7sBbLvvb6a9vCi5pi3B1xlCBwsUQkA3KEZTT+y1aWnLdmy5wDhlNNoJZ7lvYL1A
         ftfZdkbJxvgr+sEcRLEwI6DxikLwqA9kc/hUE2VMoPQO5zWz8ay2by5DAf98/X7ZNG1y
         glsB5VztMSuWyF1VwW92mxtpaJbJQUI7wzSZk5vJOLsLXdBzwfFkKaSEXHT7xGAduOY5
         PHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115329; x=1772720129;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckLUzAaqnoS1mobPRgkJk1r9ZCugtN0Qevrx6a4higw=;
        b=KfLaFw0Dh3zQQGAdaWsqn1zXvls8RXVVNINjjI6zyw6rcjfgP1sJKfilXq0WLbhdP1
         IsxK9dy8p/5dA22Y8SgJXdu+sGWUCrpcmHaxo+/HWwZcW0ItjwazkN8pSYTvcJBNxEHS
         SOcNhz7JPDB6fqciTYYhDXoPOuG0ubLaHHHwVtFNpqaio74yZWi3zH9F8zJnyHJnuRAo
         1vMM4iVvuIVposymvh38r1cy5npc6kXPTLNKJRDZg1hrVVw+aXbhaO6+sLYm1hLFKG6i
         OxIYhsIvwx6q+1h2QiZ6gFBCvo9oZD1TtDgwIeMx4VyJybUV8BEKTa/+xChlu1t1qHp7
         7VzA==
X-Gm-Message-State: AOJu0Yy3/88WGcyyCFdN4bLdW6FYB2q0x4OTvKf6FEhCdIitiVDGFQrH
	T91Krdzw3XQT/Gbzl4dJ4GW5KBWN29SHviAxQDqFuQH3OUC83EibirIjLFWdqg==
X-Gm-Gg: ATEYQzy3hU1xNOoxSxfqthBoQxcFQSv1IH9dKrrZ3xc2VB20ykmCHxwW1vOIK4WuoiV
	CjqNuwAMNUqiAdAgWt0n7iP7rnxPLqsuoa3CUnlketcisUNQYvUVGJRiSwRu2v2R2cTY1b2acbp
	Rsnh1twnJrQJmPF9wk7dK66BSkndvyq9/pokLKxCrYxME/z3X4Kfyl+DaKsgDOPn9CWhsrtP5qk
	luxrn8qoFla5FuOzukZKq+pmc83Uo/0CWNZIepS2rrGw9WU/LFXDsg+KW0UiFWLzomDkZW+qB8r
	0+CUyWMXKyg5EieuBpjrC9gXQAy8F26XOmam2fc7LxuIIPUDctX9M59RwKeQYNCw77RhBaxrSwv
	+1A1UXqfa7ZI2Q6g/c8bewP6FcM4z1zyvyp35v4ouLZlDPM6+t27diwu962OvX6HIC91I7pcyPX
	s1kmm96napXlgM7HlktJ1TPhhBWnH/SRZeUbSUeA3s/ZyAvm0DrCyMoA==
X-Received: by 2002:a05:6102:3a07:b0:5f8:e45d:6438 with SMTP id ada2fe7eead31-5ff20a4cc45mr1266941137.15.1772115328521;
        Thu, 26 Feb 2026 06:15:28 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df641e133sm1776341241.5.2026.02.26.06.15.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 06:15:27 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [GSoC 2026] Early Introduction - Interested Contributor
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CABFJD6-7_bkixVA4Oj_JV1N5hMqFXFqBvK4KBAjM5hqcgC=_rg@mail.gmail.com>
Date: Thu, 26 Feb 2026 11:15:14 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0009780A-381B-4025-9C66-376680AD75CC@gmail.com>
References: <CABFJD6-7_bkixVA4Oj_JV1N5hMqFXFqBvK4KBAjM5hqcgC=_rg@mail.gmail.com>
To: Santiago Leal <santiagojoseleal27@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> Hi Git community,

Hi, Santiago!

> My name is Santiago Leal, a Computer Engineering student (3rd
> semester) at Universidad Gran Mariscal de Ayacucho in Venezuela, and
> I'm interested in participating in Google Summer of Code 2026 with
> Git.
>=20
> My technical background includes:
> - Languages: Python, JavaScript, TypeScript, Rust, C++

Are you comfortable with C? Most of Git's code is written in C.

> I've been exploring the GSoC project ideas page and I'm excited about
> contributing to such a foundational tool used by developers worldwide.
> I'd appreciate guidance on:
> - Which project ideas would be most suitable for a newcomer with my =
background

Probably all of them. GSoC is for newcomers. I recommend that
you take a look at Abraham's suggestions and read the
"Git Internals" chapters of Pro Git [1].

> - How to set up the Git development environment

Git is really easy to build, you'll only need to install a few
dependencies and run `make`. If everything goes well you'll have
a `git` executable that you can run.

Tests are shellscripts inside the `t` directory.

> - Any recommended beginner-friendly contributions to start with

Take a look at the microprojects page [2]. They are suitable for
newcomers and finishing one of them is mandatory to be accepted
in GSoC.

> Thank you for your time!

Thanks!

[1] https://git-scm.com/book/en/v2
[2] https://git.github.io/SoC-2026-Microprojects/


