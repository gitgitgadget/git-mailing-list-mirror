Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F22168B1
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850589; cv=none; b=pGkKJp0llGUM6+etka3fSQQ7qFK889jbZDtMMK5Hq3T2Oup6zghGPBGXvYa62D0DO5qUQ6qNcfEGmW5oR0XneFNK1bMtSSM6z35OtJPG0xQH1GwDPRYK7bVkyhuJ8ihJ0t55Wq2fGZ0lYwOwfJS19Dw572tsXvV4pKtmk4MFGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850589; c=relaxed/simple;
	bh=MqrPTJoB9uR0X6Pd1j2NGVzrnqL1p4N1oZgwcTO5j1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxgLhAsAPb48BxD+W3mnsPqcGANsV4nxexyDgmor2/MXEZky715bgf3nEG2dXSS2abzMzPETdQPKPFYkdxdm+XIf83nEeIxkwAK1Q4nZ7ALVw6bkP1JcA6BYscdUHjAwQ+tTGjPjWIfrNvbcwtee9rMWT17A+DMiyFdQHL3YtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbDq2GGH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbDq2GGH"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-510322d5363so2651404e87.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 21:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706850586; x=1707455386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0vHIgXtOV5aVIegmek+B1dYtYlPq8xQ49GXWk81PF0=;
        b=dbDq2GGHwJsXZEg/+sGxIptar3xAESdiCk63ml3RdDtZM59orZhSL7mHMnqeu8MaPQ
         R2AlSYatJMMOOEOk3PFz4yGJB8x8y2z6lLPTeia0Tpg5CyzLfCZNXYdrVVUv3caV8Cdq
         +pOkMxwoq6ljrCm84Y/aIjZ9w00utMPRGkRKiFIenhwt85UU5oDf0q+pO7zpitxH15ja
         qpzp8u1EPgmDHKQ/PX0ujbqZLLyevAsWq9neJ8lxltBlUV2YQbvHq4YSmlcScdpZEUba
         ZuoEIt2ZVTtvAlSMV92TXH8QRumKGSMTyt56o1qHgsGG0xoEcSuXID9WM2Bh21OwPSPt
         0wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706850586; x=1707455386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0vHIgXtOV5aVIegmek+B1dYtYlPq8xQ49GXWk81PF0=;
        b=bn3ocJffbLq9x4zQHZ0bMVNKaYbPqttAH9llFrMr/8HkV7cAspOovqw98+sw7lgJPu
         qA+KmFN7NCtS+vQzr00IkjQNp3IoJRYdHvWQf3d726qT9qt5pen2R1N2xk0xW03bAllY
         zMY6zwVCF7NjaA+p3hTpxm860c/F9UqHBESJ/ITxI+cGH8rD7EQd1AThUSTSeO93/Tkn
         etfLNexutOX2okUlAY4verg2om0pgGew6ToMkFIgIQIldqKK+Oe9KPJ2VsyZc0Jtd6G6
         CdhiMVI7yIV1fygzbVwZS7bFFxqUXb/YM5tuWj81qIsBkrvHkKxqY4Txjvu1n8jNUDHJ
         LMWw==
X-Gm-Message-State: AOJu0YyrYRRHtWuIY47rQfoEEAReauCnvWLQ2bXri6QaA/wWKKELzk6z
	JrZMRyKw8YWVU821w3RP4IypBqqvMy51U+stXShePdhZXIN/eNpS2kxxnUgh+8CJiTmeJdPtZL9
	+3R8a/waH29YHVKu5QecZ0NkhmUY=
X-Google-Smtp-Source: AGHT+IF/zo0dMFELmAPoBWeT3wEeGrtaWRClaW8KieCkziTknlqC6fcKSnanLCH7V3gwOrLipEqzUIPxZDdxXCX1swg=
X-Received: by 2002:a19:f808:0:b0:511:2088:df39 with SMTP id
 a8-20020a19f808000000b005112088df39mr3165801lff.1.1706850585437; Thu, 01 Feb
 2024 21:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1664.git.git.1706833113569.gitgitgadget@gmail.com>
In-Reply-To: <pull.1664.git.git.1706833113569.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 1 Feb 2024 21:09:32 -0800
Message-ID: <CABPp-BH0zZPDd2-dLPbWLFG=G6oE_kM6N2xLwUbzqgZeXCon9A@mail.gmail.com>
Subject: Re: [PATCH] imap-send: add missing "strbuf.h" include under NO_CURL
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Hesse <mail@eworm.de>, Taylor Blau <me@ttaylorr.com>, 
	Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 4:18=E2=80=AFPM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Building with NO_CURL is currently broken since imap-send.c uses things
> defined in "strbuf.h" wihtout including it.
>
> The inclusion of that header was removed in eea0e59ffb (treewide: remove
> unnecessary includes in source files, 2023-12-23), which failed to
> notice that "strbuf.h" was transitively included in imap-send.c via
> "http.h", but only if USE_CURL_FOR_IMAP_SEND is defined. Add back the
> missing include. Note that it was explicitely added in 3307f7dde2
> (imap-send: include strbuf.h, 2023-05-17) after a similar breakage in
> ba3d1c73da (treewide: remove unnecessary cache.h includes, 2023-02-24) -
> see the thread starting at [1].

Ugh, sorry.

> It can be verified by inspection that this is the only case where a
> header we include is dependent on a Makefile knob in the files modified
> in eea0e59ffb.

Thanks for checking.

> [1] https://lore.kernel.org/git/20230517070632.71884-1-list@eworm.de/
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>     imap-send: add missing "strbuf.h" include under NO_CURL
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-166=
4%2Fphil-blain%2Fimap-send-include-no-openssl-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1664/p=
hil-blain/imap-send-include-no-openssl-v1
> Pull-Request: https://github.com/git/git/pull/1664
>
>  imap-send.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/imap-send.c b/imap-send.c
> index d662811ee83..f2e1947e638 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -28,6 +28,7 @@
>  #include "run-command.h"
>  #include "parse-options.h"
>  #include "setup.h"
> +#include "strbuf.h"
>  #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
>  typedef void *SSL;
>  #endif
>
> base-commit: bc7ee2e5e16f0d1e710ef8fab3db59ab11f2bbe7
> --
> gitgitgadget

Again, thanks for cleaning this up for me.
