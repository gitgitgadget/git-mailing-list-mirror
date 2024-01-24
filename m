Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B9133433
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126497; cv=none; b=i8Cq2wlZnGQwQxiLpGlErw9cUtvppCn+pCAoSuarZydZyqeR8/iahM2Et7I4HDvgYLn8+M1AOeQXjoR9DqVScclu13vjGPWBwN8f6hJa6VvrmUFHyId4+K1zzZyeKLl4v14BlhK7wYyW8h1CwFmBafP46l6u0JpcjImoDqGhKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126497; c=relaxed/simple;
	bh=xlHYUJnTvEUeBTwJ8IKRh6F4bbbnVCGhJauCW6X3W0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuiGqrBieMuWyZmPnjcRbPndNrlO/8DqwwxF2yKofs9mwuePY+smpWutlx4C065bD6bFNN1UVMdEN1ciCOgbUhusSQrT2pS9saIoOkVVRAiO8Zwyu1INs7oAswD533Bdaa4JJk0BHnxJsMk5xQSklXxyp4P5iFP1qFeNIYH6Fw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JviC4Te/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JviC4Te/"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5100893015fso2743410e87.1
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 12:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706126493; x=1706731293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cNCLfdofDOKIUwInldUx3UO+I6cNxnJouxCispWqlg=;
        b=JviC4Te/wckG10dkK1jd/CFF7yQOKS3i9rkuit5MVAc3FaowfkMBcEXSS9nBBEIvCn
         DWkjNNlEAjBd0w+tSsDIzOlWkaHra8mgtcE4InJt3qBx3R9F3niY4pc/aWpEgJ6vWCzz
         BXXBA0ojqiwL9knq2nIpU6TxVqo+c06iRj1R6/twLLHJ5G2ARZui57LjJGiKNAFHwAaf
         Tsbf7IO2ozkLMEpkPQnzigGo3qup6fNm3RZK5RR/S7nnfTt91HjNDVGZgSX/t6gkv8/4
         /AAOBD2DfgOcOQi0lRlaM6dVD9quVvkeo28Ps5CqL+An5CuU3V4Dbf3MwXSczzTjA6VM
         dnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706126493; x=1706731293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cNCLfdofDOKIUwInldUx3UO+I6cNxnJouxCispWqlg=;
        b=m/YZf/Gh7XJZlu3G0XgQ+5ykvw6qgpRvwZ4IynOn042JpVJc9nXswklOE2iE4xhVOQ
         ahqcUvR5VWVC5ACW4XeGHoglHSmVIQASFtfetMBqoQjajLn0YcZu8EZIPeCgUYYFGbCB
         A42TCZY9OXfYGU7j3e715ZP2Wi06L0BH804Ba/K6yGvNH4aHVZOW1zmSoFdEjnuPv3jZ
         C40nVKxxm+E3vBiiViPDOmptbQSoYHifX8ikIfWiPfefXYGlp2DcTMVF11zy+Du57p92
         f64c4MXcWxgiWSgN2cGT7EOnblBFfcnKvHNaLI7EXmy0wIE9R2BPVNG2Cb293AM8zIxB
         UchQ==
X-Gm-Message-State: AOJu0Yz6wqGd092rNSQqLvYt27axq2wPkYIoCrIHvRb5vRyJ2IcKs4XB
	43eGtl/zMQsrSpgFonQGe51E/Za8SRwwyKEyNBEw4pGRlYDE2Nof5D6SMyxqIKg1ymGDPDS7i4L
	TVZaVhcTWfkj77p/rnUkZHytZ36JiiO+36eY=
X-Google-Smtp-Source: AGHT+IE2qhX5oiqUZogYVqXMz6tv3lhFP0bbsCRPrOj3FK4MdEx9TgKt5dcV6CEcHOg40oQ1i2J7AbGG4vDEsBv7fXQ=
X-Received: by 2002:a19:ac06:0:b0:510:10e3:b62f with SMTP id
 g6-20020a19ac06000000b0051010e3b62fmr495620lfc.136.1706126492887; Wed, 24 Jan
 2024 12:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com> <ac9338533c9096c090d1463c1b29505bde019731.1706105064.git.gitgitgadget@gmail.com>
In-Reply-To: <ac9338533c9096c090d1463c1b29505bde019731.1706105064.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 24 Jan 2024 21:01:20 +0100
Message-ID: <CAP8UFD2oxpefhGtH61wZvcHEvd24jtu_ZBVsnNZMjD2aM_NDcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] FIX: use utf8_strnwidth for line_prefix in diff.c
To: Md Isfarul Haque via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Md Isfarul Haque <isfarul.876@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 3:04=E2=80=AFPM Md Isfarul Haque via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Md Isfarul Haque <isfarul.876@gmail.com>
>
> This patch adresses diff.c:2721 and proposes the fix using a new function=
.

Please give more details here about what is currently at diff.c:2721
and what the patch is fixing, as lines at diff.c:2721 could move to a
different location if some changes are made to diff.c before your
patches get merged or after they get merged.

Also if the patch is addressing an issue in a code comment I would
expect the corresponding code comment to be removed by the patch.

About the subject, maybe "diff: use utf8_strnwidth() for line_prefix"
is already better.

> Signed-off-by: Md Isfarul Haque <isfarul.876@gmail.com>
> ---
>  diff.c | 18 ++++++++++++++++--
>  diff.h |  1 +
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index a89a6a6128a..e3223b8ce5b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2300,6 +2300,20 @@ const char *diff_line_prefix(struct diff_options *=
opt)
>         return msgbuf->buf;
>  }
>
> +const struct strbuf *diff_line_prefix_buf(struct diff_options *opt)

This function seems to be used only in diff.c, so it could be static.
