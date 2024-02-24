Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442214B820
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708813538; cv=none; b=KoFwTIj5vBhfFMIkd3uBL8hzJPXssI0pivf84YL0WTnEiTxF2oYjmm/QTUFClAweduHiPQBikf8fni5zZ09v7SOHg2kLuw25LIukSzFEHp1Upao8x1mHx0TTrppACMK7XAtf8bJfINCpQG9CJYY2OUPd3TSzDrWOkvYc4yI6YHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708813538; c=relaxed/simple;
	bh=XN4PY4F8DaVQGfoGOHBIQc11YWCy9RqJ7PyQ9/QybYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9qdc4CsSoXeVwNACA5rDE2Yn3ry9gReMbdVDH0urAvXFv/qz81AwjC2kPeAWHY1NuxxwbvkpffrEJuykJq/xT8YzB3rj4fy4tus1+QCu1mS9p6lCPrSNzuQSbVZqn1Jm+b8yhP271HUZ3MrX61fsJL/iUKOUQWSKCPPje41OQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/FmZBZu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/FmZBZu"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so302909466b.1
        for <git@vger.kernel.org>; Sat, 24 Feb 2024 14:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708813535; x=1709418335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Y20Pa5uhDyqaP1GoRO5YnJyWCixlXusH8NL/FHLMY=;
        b=f/FmZBZuTHxPQDnzOHPNexDmLGamkzy8IV71f+gIl7tcpx0OjW5frzl54sNNLz3zzG
         Nsi6TTmrnbYXZdEO+WnRgeNdpgrxGohD/Ba6xQBN/JnDvBL8EbR8nHRO9PRQKOcfMKtV
         J6PzGruYLKkHEMj3I9125uy89AORRRv4cw7MnZzkM/abzPFaFP4CxMlPujG7jZ9rirVU
         Mz/a+Yi0wthjXF+XPr/1UvFe8xlfS3RXsCoJM2rCy56D3WrOb+HqzKw+7O1F+t/OUP4O
         LgCkHMKHGns4JHCY8gct4WpRsC1XC8s9D/+dHf6l2xxbbYcisJvMAPlJYPuL6auU/0QU
         jWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708813535; x=1709418335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3Y20Pa5uhDyqaP1GoRO5YnJyWCixlXusH8NL/FHLMY=;
        b=K70Nm0ABdGwUTmZkCspnpi2NArII+h6oGIH3Xd2Z57JQSFugJ3a/cY5lxnWVBOG8eG
         mjcCsEjbU8b8ERR6g0kFOlLKw+uM5XrRLURxhmLvUM9aS/vbesmCKo7XYVjZlXT7zozO
         jqlp/iEXqcrubF8CYmNyWemAlcxIXtaRy/fpjKTtUNbITwVCvMcP8KgxtAo3ph1r0EWv
         TMXLAJj6604FfPVwLw9Q/5i56enFkv/N9DgrVqupo44Bng0EzvcZ0W1/uAhh23CqcrMo
         HCS3qLUgoZ6tmzJUz4J4nghRuMf3bOa+lvWhDnQARi2UG2zooqBy4sFVv/4lk4g8l7rA
         hiWQ==
X-Gm-Message-State: AOJu0YyqFBZYzGdhJs6u/q2DOL0YkXrvdYE6Vu6BwPl1McBv7AX2hFHR
	FSGaWtzelw4dveTYY0HIWWR+58DvDvWreN4QlPOY8Ujkw7k0GEwGnd89FfGSCyaAoNHOcIGfZM1
	g25C6F2QFyVkCwFXVMm3rtFWEzB71AM/lM/VXQp/1MoMCXZevqw==
X-Google-Smtp-Source: AGHT+IFCzL4lE9+iBADH9Kq0pMQzquxhFgi1ZcBqnjqcIiJW84vPXMSzvHgA4zN+CdurhxgB885Gr4gfEo5iK/3/0n4=
X-Received: by 2002:a17:906:bc4d:b0:a40:189d:c5be with SMTP id
 s13-20020a170906bc4d00b00a40189dc5bemr2164184ejv.11.1708813535275; Sat, 24
 Feb 2024 14:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqwmqtli18.fsf@gitster.g>
In-Reply-To: <xmqqwmqtli18.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Sat, 24 Feb 2024 14:25:20 -0800
Message-ID: <CAO_smViGixoV+mWVye5xVhNtC28Yhdvf3Cq4xAXOtF0VKCQEzg@mail.gmail.com>
Subject: Re: [PATCH] compat: drop inclusion of <git-compat-util.h>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 12:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> These two header files are included from ordinary source files that
> already include <git-compat-util.h> as the first header file as they
> should.  There is no need to include the compat-util in these
> headers.
>
> "make hdr-check" is not affected, as it is designed to assume that
> what <git-compat-util.h> offers is available to everybody without
> being included.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * There is an obvious alternative that goes in the complete
>    opposite direction possible, to update "make hdr-check" to ensure
>    that things that are depended upon in each header file
>    (e.g. pager.h refers to uintmax_t) are brought in by the header
>    file to include the compat-util in it, i.e.
>
>         diff --git c/Makefile w/Makefile
>         index 78e874099d..d7b360f15e 100644
>         --- c/Makefile
>         +++ w/Makefile
>         @@ -3259,7 +3259,7 @@ HCO =3D $(patsubst %.h,%.hco,$(CHK_HDRS))
>          HCC =3D $(HCO:hco=3Dhcc)
>
>          %.hcc: %.h
>         -       @echo '#include "git-compat-util.h"' >$@
>         +       @echo '/* #include "git-compat-util.h" */' >$@
>                 @echo '#include "$<"' >>$@
>
>          $(HCO): %.hco: %.hcc FORCE
>
>    which would require in a noisy diff to add inclusion of
>    git-compat-util.h to many header files.  For purposes of folks
>    who may want to carve out only pieces of our source tree, such an
>    approach might work better, but for that to happen and yield any
>    useful result, I suspect that compat-util header needs to be
>    split into "compatibility essentials" and other "it is convenient
>    if these are available everywhere, even though they do not have
>    much to do with hiding system dependencies from the sources"
>    parts first.
>
>  compat/compiler.h | 1 -
>  compat/disk.h     | 1 -
>  2 files changed, 2 deletions(-)

LG, thanks. I agree with the direction from this patch: I think we
should not be including git-compat-util.h in header files, whether
they're "internal only" or part of the "external interface" of a
library. It does far too much and makes too many assumptions about
when it's being included. I plan on writing up some more thoughts on
this on a different thread, but it's taking some time to get those
into a shareable state.

>
> diff --git c/compat/compiler.h w/compat/compiler.h
> index 10dbb65937..e9ad9db84f 100644
> --- c/compat/compiler.h
> +++ w/compat/compiler.h
> @@ -1,7 +1,6 @@
>  #ifndef COMPILER_H
>  #define COMPILER_H
>
> -#include "git-compat-util.h"
>  #include "strbuf.h"
>
>  #ifdef __GLIBC__
> diff --git c/compat/disk.h w/compat/disk.h
> index 6c979c27d8..23bc1bef86 100644
> --- c/compat/disk.h
> +++ w/compat/disk.h
> @@ -1,7 +1,6 @@
>  #ifndef COMPAT_DISK_H
>  #define COMPAT_DISK_H
>
> -#include "git-compat-util.h"
>  #include "abspath.h"
>  #include "gettext.h"
>
>
