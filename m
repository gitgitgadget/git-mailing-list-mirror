Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BA4F8A1
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781121; cv=none; b=SoQH/DrBPhfHtw1elCGZKHFy7IqFEx9QgjE8KgsXALER3W1ZMICXnFFP5INNpBZkuq8f2mGgrztL3/Eer11fsZLHEaUsparSi9bYKKytSAcGGT/JNkCIQzSqFUgQtN9M/0QCw+XSM6a4d8pp8MylMQEtL2JqHMXpz8rYcw+Zfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781121; c=relaxed/simple;
	bh=mbPAaHVU1J2K2fLMnC4WYGssv+GwGru0IbPEc5hzzd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qslTriIQk9fGoW0P7kVcETAqVM06rzEKHPxbnbT79sMyhhXaA41Amux5On6ObTheXiKjuttOWpkTLexF7zwBL3ImBjxDQXL+kX5sWoPanjHGZ/i7/LIc1dH20xW6gNlMNbVm2Wh7kw4wnODVxDl1UmQSoZkHSp+tw7XUV8G0EL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/kQw7Zx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/kQw7Zx"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so4326547e87.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781118; x=1708385918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V1wt73niRD6EA/9cgRLlXeeZjPXpU788DX2Vp5M0Ckg=;
        b=B/kQw7ZxBGSsozvDxK/O33quZEhNbEWraWaWDIiRGUul5SV8K513mx/Lnd/RLl1h1I
         /kEfHqE5WpO1/dv2yHQtre2vxAagnstKqoZ5cmZa5Cz1H8MDyw/kXiw3hTkPceHIu4WK
         TC+rktK22jZrlWwT2zJBSKw2G1ffLPxgPDWW/DNm3ln31PGhyL6VuLGIqEe+ajzxyTaD
         nfXAZ8f+kzDQtQE3NmWJI4UHr1q03mSS52QYjje1Q43aHWIhg+LiLZy2qgDhnlhx4wOb
         lKr5JEiP8jJjIhXI19P4GmVfLoSKIr3OWZzN6uYGvRJxu+ZnIiCL0e5QMwx4WnKdTDkq
         ycvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781118; x=1708385918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1wt73niRD6EA/9cgRLlXeeZjPXpU788DX2Vp5M0Ckg=;
        b=Keh555LwXNFsGLXn4MmaYUhtSU0c6lZNRsJUmwYkvOJNxuomQO76XeZHY3/ATR3Ibl
         bi0U/DnBNdJlP7jQjmMsrlqQ8jHnwC9rlPeEcwA33BE5Idp4iEmenM6PwMvh8L6XAIJD
         FFPPvpb5FbFjIfhyN+FQQkY04/YEsQ3A3g/1rGnd7gHytP8bp68u5tfPAqfuOZEa1odk
         tHk62V/tlvNC+l2wxMwXK30n4IHUA4GZyk9k7WESAZ0qBiIqyf8i16MvBRs7lxEmjWEz
         CKUExMJ2sN64FqM618Ckdzyciq4IlHc/nLZ+Q6Ni8h1WxMjKHd6pNWpPc2G7XU76rg09
         UNAQ==
X-Gm-Message-State: AOJu0YzHq0tl15Ci5cAAMIvclRwe+m9VB1+XHYQ/lBm5T5Li4fYO+uXM
	6znR807vemHljKVbsRYaA3vPhQoK6KRJmU6kJfg6jyslfycZz6t3M2D9c9dTkN2F/edbPovBSwL
	MBYaLsOaGcwjb6sA6DdkGWfz/nAmNiGr8
X-Google-Smtp-Source: AGHT+IGl5KcDte1rO6dlnsEXGLkl7+DVJumzPX0X44U/ZgUzjBr2DP7dMfP0EIxl50fD0CgMeG48llYxWSPoPxo4EDc=
X-Received: by 2002:ac2:5df5:0:b0:511:974a:3cb with SMTP id
 z21-20020ac25df5000000b00511974a03cbmr488975lfq.67.1707781117576; Mon, 12 Feb
 2024 15:38:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <11f854399db2b0da5d82cad910c3b86ca9c2e0db.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <11f854399db2b0da5d82cad910c3b86ca9c2e0db.1707196348.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:38:26 +0100
Message-ID: <CAP8UFD3wMD5SmfpP20jST4YndBdPX9U9qAbKh=4TnUzLkpULRA@mail.gmail.com>
Subject: Re: [PATCH v4 14/28] format_trailer_info(): teach it about opts->trim_empty
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/trailer.c b/trailer.c
> index f4defad3dae..c28b6c11cc5 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -162,20 +162,6 @@ static void print_tok_val(struct strbuf *out, const char *tok, const char *val)
>                 strbuf_addf(out, "%s%c %s\n", tok, separators[0], val);
>  }
>
> -static void format_trailers(const struct process_trailer_options *opts,
> -                           struct list_head *trailers,
> -                           struct strbuf *out)
> -{
> -       struct list_head *pos;
> -       struct trailer_item *item;
> -       list_for_each(pos, trailers) {
> -               item = list_entry(pos, struct trailer_item, list);
> -               if ((!opts->trim_empty || strlen(item->value) > 0) &&
> -                   (!opts->only_trailers || item->token))
> -                       print_tok_val(out, item->token, item->value);
> -       }
> -}

It seems to me that this function could and should have been removed
in the previous patch. If there is a reason why it is better to do it
in this patch, I think it should be explained more clearly in the
commit message.

>  static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
>  {
>         struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
> @@ -1101,6 +1087,15 @@ void format_trailer_info(const struct process_trailer_options *opts,
>                         strbuf_addstr(&tok, item->token);
>                         strbuf_addstr(&val, item->value);
>
> +                       /*
> +                        * Skip key/value pairs where the value was empty. This
> +                        * can happen from trailers specified without a
> +                        * separator, like `--trailer "Reviewed-by"` (no
> +                        * corresponding value).
> +                        */
> +                       if (opts->trim_empty && !strlen(item->value))
> +                               continue;
> +

Wasn't it possible to make this change in format_trailer_info() before
using format_trailer_info() to replace format_trailers()?


>                         if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
>                                 if (opts->separator && out->len != origlen)
>                                         strbuf_addbuf(out, opts->separator);
