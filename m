Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9919005E
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765250337; cv=none; b=iCy4YuXKVG7xO/lfrxJMt5AvDaK+UUXQaNJHyPhVYOEhU+F31o8rYz4IA4keOUA/4ILmnh86rfqV9xC3lX6NItvoRxBdsEAgeL3w4GZ7io2S8+AOgNt3oE5V0ZoQWqsDfx68XnBMgByLGcxy/TCiqFWwPcs8zOvxhmVE7cZQkwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765250337; c=relaxed/simple;
	bh=WmzYpipYMn1ByqcMkpaaZmAD8bvYqrZN2h8Vzsxpu18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caLwbrgX+miWgr4BVuZ/84GUVYOZBsyKyyAvX/yRZcmBZpVlQcnBhQ3FhcLO+j/WJxiD+19d7Ts7YHbam90Z9aDGkqlygl46Wz9DfVlBMOGU1T5c46lc8/kgBEFmS9BIZXJJZOElRa+5q/c9Wtp9NfCIJiL0krCNlAgtExOrGDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=l1sGUAOR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="l1sGUAOR"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3454164a12.3
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 19:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1765250335; x=1765855135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFTe3WxqXH/RPP73WjL+aosyWIUD8XLSY5/poY/a/Wk=;
        b=l1sGUAORp0ggOwl8Wexxwg9Y2eCchQ35EFMc9PAtrb4VlHWERkY1BVp0r7ru3xk2p6
         va6HE+BcQIYlWC58/ROs0wkSswmXXcZtCclNvnUJ3dPmKf4ZXcCvhq8EnNM65AKE6LNC
         wen+mL532iZSPAHSEgSlorU58HhzRpM6gVYyMYk23MUOIDqYr9BzvHlAj05xrSsWo+8Y
         3tK4kJIqZjO4CZLJdci17ioKHxHm652xPXUcaznssBp3UwVPy6rk7OCkr+3A15Zo0nhk
         56LB9gs67+j1ddsbAe+axHF8IWMQ/euAaBuhR4pi9XPYibh3mjJB7KD8GVFXyHSKD9fq
         0U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765250335; x=1765855135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFTe3WxqXH/RPP73WjL+aosyWIUD8XLSY5/poY/a/Wk=;
        b=wnXpI7tXHa6Rb+XnO3LGQbQs0YPVgpguwn2lE9juJ1F9pI6XtjkCjRkUuIBiX7+V2U
         kpBS8okVHixGwrcyY8EEFibLxezgsXc0tYt1b1XMnhX6k2EE5nzMLTdyaIVcAyTf4GKy
         /sXM0D0mmpZyuBwsN863XZgveox4ZkK/2wtuq/4atYABnVrBdtHrFboeaClvPKpH/KP1
         fddve/LhnpcuZd9jJ+GKi3K0Vae/+xq7BCLMhMahXqN0ErscMbFh1N5uc5u+cpqF7NNe
         ctS05Nk+l/5VKsfkxtOpXR41vMZnP6iz2I+kBoBD1LJ9RZVgCba4RYJR5ehl0WCrxqYA
         7+lg==
X-Gm-Message-State: AOJu0YyaiJd6shJoqSlvfZWZT8QOMUIuEGdcjx7+hgWmIg0cSja94Lg4
	WJr8R64F/muIzVnq2l56XL3D1u+XkiYwz5BJnE3giGuAys8I4Q4ZwO6vrrl0nJHcKglDi/6prhE
	kc2ykD1jECOpC21AYlaGpi/0R/w9ezLtoNfN3N0ohzHWAzuGlyZWj7P3Ltyom74ZjyTLava7uD5
	tVpf20cnkYDdiay9YzTfuq6M/Mf1uhZPjyId8m3Hks3vYHs8v/PgJCulLMtISZIuqGeibek4Jqo
	fEJI7uFoggxzHUJ0uQNf37iiCsbYCeSpb5QdjuIcQ/e+t27dsmQ5Qa+CxSH5Gmy6JB7rNtnJ1rm
	mHtRAZ7D6QqV1Zk=
X-Gm-Gg: ASbGncuFzpu6OzifajcHloBCk0modj+TCfA/DsCKXUQKNb78ar6bsSyHmBui4tIkkTz
	IiNLSUadWYMpBcw/umHlgo2dzkXdWRUE0ljJFlbWwQ/8Yr0At2JKkA3wI2/W1fENRKugiCa+KH3
	dctsqb17Y2VYLX2t3BznKNtfRpyqTielIkJCESx9blAhJ0nE84TMsEVReTRYltuETLasDl3/E7h
	SUVviEmgkyOzxMEfeJJL1cAyWsssIIs9wH7t6aqFE2p2IUvZe9K3hlAu/hirm+iV9Aw9EWc
X-Google-Smtp-Source: AGHT+IE23CK4gOpqdI+welelS4K9fmgluovWW+wzvLCzP3g8Pq5pJ6ZgHzgiKR8sqRSTD3pbZmd9kDspvXd/udalU7o=
X-Received: by 2002:a05:7300:220d:b0:2a4:3593:c7d9 with SMTP id
 5a478bee46e88-2abc71cf1f8mr8194145eec.25.1765250334736; Mon, 08 Dec 2025
 19:18:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
In-Reply-To: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Tue, 9 Dec 2025 12:18:43 +0900
X-Gm-Features: AQt7F2oEm4AluX5URyJpz2nFLj6fGC6V5d30PAQ1N0onvMj8mLtwlMYqwJoi1Ow
Message-ID: <CAOTNsDzmGypKNOg-pFuW45qst+g8=LHQbdNAgtVYJvD8pxa6_Q@mail.gmail.com>
Subject: Re: t3900 failure on macOS, iconv(3) broken?
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 7:59=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>
> Hi all,
>
> three tests of t3900 fail on macOS 26.1 for me:
>
>   not ok 17 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 25 - ISO-2022-JP should be shown in UTF-8 now
>   not ok 38 - commit --fixup into ISO-2022-JP from UTF-8
>
> Here's the verbose output of the first one:
>
> ----- snip! -----
> expecting success of 3900.17 'ISO-2022-JP should be shown in UTF-8 now':
>                 compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900/2-UTF-8.=
txt
>
> --- /Users/x/src/git/t/t3900/2-UTF-8.txt 2024-10-01 19:43:24.605230684 +0=
000
> +++ current     2025-12-08 21:52:45.786161909 +0000
> @@ -1,4 +1,4 @@
>  =E3=81=AF=E3=82=8C=E3=81=B2=E3=81=BB=E3=81=B5
>
>  =E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=81=AE=E3=81=8C=E3=80=81=E3=81=84=
=E3=82=8B=E3=81=AE=E3=81=A7=E3=80=82
> -=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3=E3=81=90=E3=82=8A=E3=82=8D=E3=81=B8=E3=80=82
> +=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3$0$j$m$X!#
> not ok 17 - ISO-2022-JP should be shown in UTF-8 now
> #
> #                       compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900/=
2-UTF-8.txt
> #
> 1..17
> ----- snap! -----
>
> compare_with runs git show to display a commit message, which in this
> case here was encoded using ISO-2022-JP and is supposed to be reencoded
> to UTF-8, but git show only does that half-way -- the "$0$j$m$X!#" part
> is from the original ISO-2022-JP representation.
>
> That botched conversion is done by utf8.c::reencode_string_iconv().  It
> calls iconv(3) to do the actual work, initially with an output buffer of
> the same size as the input.  If the output needs more space the function
> enlarges the buffer and calls iconv(3) again.
>
> iconv(3) won't tell us how much space it needs, but it will report what
> part it already managed to convert, so we can increase the buffer and
> continue from there.  ISO-2022-JP has escape codes for switching between
> character sets, so it's a stateful encoding.  I guess the iconv(3) on my
> machine forgets the state at the end of part one and then messes up part
> two.
>
> I only noticed now because I used to compile with NO_ICONV for some
> reason.
>
> Is anyone else seeing this breakage as well?
>
> Here's a patch that adds make variable ICONV_BREAKS.  It avoids the
> breakage when enabled, by starting over again instead of continuing.
>
> Ren=C3=A9
>
>
> ---
>  Makefile |  6 ++++++
>  utf8.c   | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 6fc322ff88..cf8a0d3ee9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -181,6 +181,9 @@ include shared.mak
>  # byte-order mark (BOM) when writing UTF-16 or UTF-32 and always writes =
in
>  # big-endian format.
>  #
> +# Define ICONV_BREAKS if your iconv implementation cannot reliably
> +# break a string into valid substrings.
> +#
>  # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound. Defin=
e
>  # ZLIB_NG if you want to use zlib-ng instead of zlib.
>  #
> @@ -1836,6 +1839,9 @@ endif
>  ifdef ICONV_OMITS_BOM
>         BASIC_CFLAGS +=3D -DICONV_OMITS_BOM
>  endif
> +ifdef ICONV_BREAKS
> +       BASIC_CFLAGS +=3D -DICONV_BREAKS
> +endif
>  ifdef NEEDS_LIBGEN
>         EXTLIBS +=3D -lgen
>  endif
> diff --git a/utf8.c b/utf8.c
> index 35a0251939..ff0c541fbc 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -515,6 +515,19 @@ char *reencode_string_iconv(const char *in, size_t i=
nsz, iconv_t conv,
>                         out =3D xrealloc(out, outalloc);
>                         outpos =3D out + sofar;
>                         outsz =3D outalloc - sofar - 1;
> +#ifdef ICONV_BREAKS
> +                       /*
> +                        * If iconv(3) messes up piecemeal conversions
> +                        * then restore the original pointers, sizes,
> +                        * and converter state, then retry converting
> +                        * the full string using the reallocated buffer.
> +                        */
> +                       insz +=3D (char *)cp - in;
> +                       cp =3D (iconv_ibp)in;
> +                       outpos =3D out + bom_len;
> +                       outsz =3D outalloc - bom_len - 1;
> +                       iconv(conv, NULL, NULL, NULL, NULL);
> +#endif
>                 }
>                 else {
>                         *outpos =3D '\0';
> --
> 2.52.0

I checked a few cases:

* macOS 15.7.2:
  * These tests fail.
  * These tests pass if your ICONV_BREAKS patch is applied or
    ICONVDIR=3D/opt/homebrew/Cellar/libiconv/1.18 is specified.
* macOS 14.8.2
  * These tests pass.

It looks like the system iconv is broken on macOS 15 or later.

--
Koji Nakamaru
