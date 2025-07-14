Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBF251792
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501661; cv=none; b=g4zIvS/T32n1bMA11dGWokcIv9Gk397yTWJDTHv2uC0F0sGlqU2Xy6p5L4d6rdzoATiOz0PX4QVvlgi1ooG8P21h8kwlw5gUD52fsPDpJ7XkEzpHk1rffsxuoda3adLZtYabz2RQuc2XCxWJz7fu08zLAdkFjaB+zNrzFZqRZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501661; c=relaxed/simple;
	bh=ptXQCbB1ndT1kei3yk9cF3DHgTmYkYQcq0EwN04TU0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SIV/oI3vq5OgCVMCFM0OoCEQh8Lz2afgfN6JpwwA7BUllsM81C9K9c9XOYdDapNbllyQ3zX//8mgDTjPyCZ5s0sREqzMSOxIFY7Mo/OyGV9Ba8pTodYCxQWNMLeXyChSvVQvQU9E8fx3YAIwEHJYW8qH10nyl9LzQka7e8UQEu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvC2YY08; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvC2YY08"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45611a6a706so7363315e9.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752501658; x=1753106458; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptXQCbB1ndT1kei3yk9cF3DHgTmYkYQcq0EwN04TU0U=;
        b=FvC2YY0894Z3gU6huWk4vIq3/BtmA0guMQGTTJgcu0h1ZlMP31bQIgNW9AgyzPkLJb
         EUWayJR52Dnzg9WNnrqpfapixzvLhZFhXnl3nahD6X8xIqs3sImO6HnS6p+oLi2tLXwH
         MYMa482+yzf90Ux5OeMoB/vj7Sex+fDOfKn907hibxH2dHF4LMi/LUpGsy20Qs6hG5Ov
         6FZK6nM3HUgF/9vb2TW5SmuXbkAYcaSyI6HUpIWpnY7Vc3Rrog85kPvY3t5fGrzKu7PX
         V7Bd2kJXofnqHXS8WpKuJdGFtm5hNeprkdfFR4ACR6jpHozWAl0JQWxEclr8m1XqnqcE
         TY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501658; x=1753106458;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptXQCbB1ndT1kei3yk9cF3DHgTmYkYQcq0EwN04TU0U=;
        b=o8ARbwFRHvlWnoNpH+EQtL7BD5YoLrXcDVpYYDK8TQt1YgThMnfDdRI3QEWBmAqijV
         sMxozONMrdcBMNR/kdGTmAGAt7GFrIYkEXaowujEfcadMdRlRXkq+5b9QrTU7B1mczIu
         cOE85q744y6NtBV8nDnADszZ2UECWYYlmWfpNOi4BKBlzFgSdDTdi/PNARuQcJn8XvW8
         P4aAwzIv1kRNuHcTwwLYEAxAnqX4OYRuZ+vYkr/Xc7iTuGaulixc7zxJWL/Jpd5Im4rm
         zDjauqHEETk/c/GrSi4WfqL6yPzrNgmpkVZ9nTPgN/4PUyd0FSLxg2I5xYrBZ6EhybJB
         YRsA==
X-Forwarded-Encrypted: i=1; AJvYcCV8jHzZLGxJ6EWz0weKMCiaqNBbBL4qFZRYAi7YTCJIbJbNnEFsSZf/6XfEBj/nsR5G7j0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31MHsPA7HkjMY6m5Q4D3hlzzdISr+YGYjyRRUnbe+64FsUirN
	tI9UZnyvpCSbAuSuxVkgGxMbd6Vfx5GungRqS6BoNnltxEfyBAE3FRjQYBpDcfxbo60rChMLQQg
	ActsCaYraoIVwrv4WrLBOT99tbBjXWdU=
X-Gm-Gg: ASbGncvzf6JNWCAAENflEcW/8Sniodhu1a80v+HP/FKUufgzMz7HWpDGyMNXn5wDLTG
	PxiypTTSQl04QPj3azrJwYz8ZIrqjwA5hAohTE58PmWtPfSN5vqH8mg+LivxqOmaKS4w1vroeP0
	/WIVlGrzDx/Nxvo0QYE/Tu//curvae/hxMwR9LMsrGWk7Dn/UDvYXwpx9+lGBQxtu6PcoYjsZ+e
	93/aO/8/d7C1m5CYGStKuoCMgKbvTke7uYnl0g=
X-Google-Smtp-Source: AGHT+IEmiShfGAhwhDxb/kxFdjw3AxMR+5Rq70HLiVx7Bs2NY/1igBctuXMKxldADXOuOfGyR/FD3QQZi3+5aUDYZxo=
X-Received: by 2002:a05:6000:23c8:b0:3a5:2b75:56cc with SMTP id
 ffacd0b85a97d-3b5f1895be6mr7620340f8f.23.1752501656764; Mon, 14 Jul 2025
 07:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712172615.11364-1-carenas@gmail.com> <aHKgu3Ew3Pk0PL2v@fruit.crustytoothpaste.net>
In-Reply-To: <aHKgu3Ew3Pk0PL2v@fruit.crustytoothpaste.net>
From: Carlo Arenas <carenas@gmail.com>
Date: Mon, 14 Jul 2025 07:00:45 -0700
X-Gm-Features: Ac12FXwvvrYWXT20iaq_AgSO7KsNe-EMxeRqiSLO4481RwBOGjg41SzSV28KmJA
Message-ID: <CAPUEsphoFaS7CnxXs_PsMCtCrB7ByE+y+SxQGaxoovjAdH7UFQ@mail.gmail.com>
Subject: Re: [PATCH] meson: disable PCRE2 dependency by default
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	=?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 10:51=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-07-12 at 17:26:15, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > Makefile requires the user to provide the USE_LIBPCRE2 flag to
> > enable this dependency, but meson has it enabled by default,
> > which can be problematic, at least in macOS.
> >
> > While a popular option and matching what was done by cmake
> > (which itself reflects what is preferred by Git for Windows)
> > could result in a broken build or linking with the wrong PCRE2
> > library.
> >
> > While not git's fault, macOS provides a PCRE2 library in base
> > that is not usable (even if it would pass the test) and not
> > configured properly, as it installs a pkgconf module that
> > points to a non existent pcre2.h header in /usr/local/include.
> >
> > Change the default to off, and let the user enable it once a
> > proper dependency is installed or meson instructed to fallback to
> > the wrap.
>
> Can we disable it by default on macOS instead of everywhere?

Yes, but I don't like it much, as it is:

* inconsistent with artifacts created with other build systems
* really an issue that should be fixed by Apple or at least handled
better in meson itself.

> For most
> builds on Linux, the system libpcre2 is the right one and users will
> expect to find PCRE support by default.

Agree with you on that, and indeed I think every packager
of git (except for NonStop) does enable it at packaging time.

Maybe this is an argument to enable it by default?, one thing
that I wonder though, is if we should first isolate the code on
its own and link it only with `git grep`.

I think the rationale behind the current setup was that we will
eventually replace all other regex engines with PCRE2, having
better performance and retiring compat/regex, but code to do
that failed to materialise, and I am not sure how realistic that
was.

Carlo
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
