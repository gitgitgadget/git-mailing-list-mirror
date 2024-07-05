Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12D3145B28
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213738; cv=none; b=WqrJ8AeiJbvVo4T7pE5uSuyx2o1HnTZfx2ZYbW89aLZXrRsEp0pXc6UCn4H9djGUm/sx9276+HiQZI930nycwjkinYkyJNwTRz2t0sEksDL6w7NOSPe0c3FGvhyiNSzStS1CyfxfYR9fvT8/+9ri2uOklFPDKJXhdLJtOoBy4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213738; c=relaxed/simple;
	bh=UMjjz1Hz4DYZIsdf41XJOgHEZeMrU6b8Gw2YFYxcpOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3nlZ1LbbGd9mbF14A4YceC61zWHypxx8W/5ccTvdpBHoUq5H8vuXwv1T73dsCGJy0ZwwS8mwoNl5daSy46ncMiiTCdHvI8NQh6MDZ6MFZmt3oKY0/Lcx0Fmbu7qt/DkePvpMauAp4xouPDa1EiB7KVMnn30U2fCunP2dLFckLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST80Ctvl; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST80Ctvl"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f65715fe2cso72400939f.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720213736; x=1720818536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIVUXIMBZZGDhR2MDFvLv/OG3atgDg5Uv6hWnQk6HYk=;
        b=ST80CtvlcKSJbdegvDGHSauSWvZTRJi+y3Gmk9uPFhGG8oyxR15m4uaNK+q0EG1vMA
         DrXsY2045uisnO1UXxkaybA+JbzGpB0p2qPvhjKTcJl6mI71t7hYCeRzHuFE+5ygqGvH
         c+XNasGtfTYIljIdcW1FVieES7NbYJMYLcmPDR2fNNiIGGpVGfIlAORyGh9vDUiIMRrF
         EHzHDWs4DGN3RZZKmKg22ofX+sssRHRUTM2XXL7IRw8qXRvwdUJLmIMS6tb09gktyQaR
         DxHgGN4cs+mC6qYG5bU1eZiebrti2cYpZ0gb4oT50BZxRwDwOttT/6bBGa4sIpaUCaIm
         TYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720213736; x=1720818536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIVUXIMBZZGDhR2MDFvLv/OG3atgDg5Uv6hWnQk6HYk=;
        b=dcNJS5gREvtseZOsgZUfjuTs3AMkCD+TbLKcMY1PtLTm9MltHi6CIo4GwZwpjbta0y
         X8JojYm9nP0pkLHVW5HtHPMZGfSNtfqgqZFdDl8xOM54l4aBssat+IsVzZ8EdCazUgQf
         WZpb+YoMTbtG61WZSY0Ozwd9glKzZdWw/mZbrwdUMnkh/4QoVgaGhlFqdepQkAoO1uhb
         ZbJWHr2QDmQIl/TnNCyd7gmUvzbvJ6pqsF9NunVpfBw81jNq6x922iTiZHyGfzXybjFB
         ebj9wScEk8oLyd9B+dhITHeur/58iSFVmokdTSsm3Um3ukd8PtTRLbFJC1V48meBrZc+
         TveQ==
X-Gm-Message-State: AOJu0YxT5qu1+SHitqE4M/Gov7nRqMCd8qnqe97ODRa2ibKQizv6lrMT
	euA2FOvFZhI/KQ1DQCn1N1I1zIkcQdRAQgyEIGWF0cFNqQsFdSvlxGu+9wDy4SnnkhgNOXTm17r
	kbbBZgNNXG4VmXLe2vTeDPfiGiic=
X-Google-Smtp-Source: AGHT+IGDdmZ0ErWoTJZJQtQfj//z53RGOCdimVjKzIJY8RYohoY4p9keERjEfSFh+N/1fFcY9UE88+hR4FET6XpEsJE=
X-Received: by 2002:a5d:8e0c:0:b0:7f5:bd0c:aada with SMTP id
 ca18e2360f4ac-7f66e026dc4mr687920939f.18.1720213735957; Fri, 05 Jul 2024
 14:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cbc9446b1b0f2453b96aa9c0d89b9ec086a619bd.1720205457.git.me@ttaylorr.com>
In-Reply-To: <cbc9446b1b0f2453b96aa9c0d89b9ec086a619bd.1720205457.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 5 Jul 2024 14:08:44 -0700
Message-ID: <CABPp-BErBRQckm9HnM9xm67z65rM0oaxrJ_w3RtGqWXJ-sdZgQ@mail.gmail.com>
Subject: Re: [PATCH] config.mak.dev: fix typo when enabling -Wpedantic
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 11:51=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> In ebd2e4a13a (Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format
> better, 2021-09-28), we tightened our Makefile's behavior to only enable
> -Wpedantic when compiling with either gcc5/clang4 or greater as older
> compiler versions did not have support for -Wpedantic.
>
> Commit ebd2e4a13a was looking for either "gcc5" or "clang4" to appear in
> the COMPILER_FEATURES variable, combining the two "$(filter ...)"
> searches with an "$(or ...)".
>
> But ebd2e4a13a has a typo where instead of writing:
>
>     ifneq ($(or ($filter ...),$(filter ...)),)
>
> we wrote:
>
>     ifneq (($or ($filter ...),$(filter ...)),)
>
> Causing our Makefile (when invoked with DEVELOPER=3D1, and a sufficiently
> recent compiler version) to barf:
>
>     $ make DEVELOPER=3D1
>     config.mak.dev:13: extraneous text after 'ifneq' directive
>     [...]
>
> Correctly combine the results of the two "$(filter ...)" operations by
> using "$(or ...)", not "$or".
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  config.mak.dev | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/config.mak.dev b/config.mak.dev
> index 1ce4c70613..5229c35484 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -10,7 +10,7 @@ endif
>  DEVELOPER_CFLAGS +=3D -Wall
>  ifeq ($(filter no-pedantic,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS +=3D -pedantic
> -ifneq (($or $(filter gcc5,$(COMPILER_FEATURES)),$(filter clang4,$(COMPIL=
ER_FEATURES))),)
> +ifneq ($(or $(filter gcc5,$(COMPILER_FEATURES)),$(filter clang4,$(COMPIL=
ER_FEATURES))),)
>  DEVELOPER_CFLAGS +=3D -Wpedantic
>  ifneq ($(filter gcc10,$(COMPILER_FEATURES)),)
>  ifeq ($(uname_S),MINGW)
> --
> 2.45.2.705.gad6bdba207.dirty

Best viewed using `--color-words=3D.`, so you can see that it's just one
parenthesis that is moving, and in particular just moves to the right
one spot.  (Which you already called out nicely in the commit
message.)  Anyway, looks good to me.
