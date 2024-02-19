Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4255466C
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378330; cv=none; b=b7DbAX4Zhnd0RskcYW+mqejneEPS3qjHoCj1nurxOKFjErgrGBs8yUGBYbARBknAuVuABdLHFGi/iZ3ErOJPpufJys2XJa8BgQTvkuPO3KqMqsXrWMk0D5AVj+6ZcT767WMeCdaJ6eKUOW5QN95m/Y5qSRSith6Xa4FzrRqQjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378330; c=relaxed/simple;
	bh=JVDAioJN0PaLle+Q8aSneT2X2aRZ5bwPkTPnQ4ZqvKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mD2JZBH/9r25pynTyOGdEd+pm/SG8+i4a4WvMxUdOkUjKI+jJ2h4WsVFqIpShTgyDYUvxd9H74DprEcWUC3uPf7GMNFol5gaLQlt2I0mELrsIAt5v3DTM0AHZ1fsIZig3vwxfLbfeaAMESynbZNSeYPYlK+usppND6QQZd96fvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJgncXrA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJgncXrA"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3e550ef31cso191300666b.3
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 13:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708378327; x=1708983127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk6z9H1wvYO3I/mZiJQxUJWusV8BEPMSdE9fFCWOU/8=;
        b=LJgncXrAHWfABIWCYrPU5GOtdO3I9ZeF/1Rt9i2blSjKDFNKqGZtqN8u6x7fKyAigR
         7hQCNg54MXY6fqt7KAaD6o6IdhkvoItSXOXv7KYfW8wGnrmqLaLz8VNdnAitJfue70dD
         nJDWGiBZSmqjil/3tj3AFklqj16948PxejvxYGEA1/o/FS5U31n9sdNuzamgqkfNtinT
         /R5J9i2io855J024+7eQvZAcLjJRwO6owg+DqN96Dz2cOcRgrPeUivdXh0qIUunDOR/K
         sPGGQhsAaH+l0z1ez9LQN6e2IlCSxI116FLThwEk0QFJRngN3BQBQ+eli0hPGbR0s+eg
         P6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708378327; x=1708983127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xk6z9H1wvYO3I/mZiJQxUJWusV8BEPMSdE9fFCWOU/8=;
        b=Wb6Crm4wMUDupyLF4Vyo7nZSqtSA3qh3Oks9/+4TMZ8ToGtq07G/kqvtsMACT1TXxs
         ozqTC+c8oaAjnbtA0rbLw8MmawyuVZ/+91D3ev6f+hq2Es1aY25JJ0VYZ5UyuOQ+NQae
         x+E99nV3qloZCeT7+YmSHCHwX7rkfE+wRo8KQ5/Qx1oW8jU+HyUMLXsE9lNC31aZ2bX4
         Bvdrio0qmhaMkIYFbY6ZL67jkaoHEqczeanO78i4K0v+urMlOgD+qe7h7PC9gNt/xqIg
         dlZKooIrhv6w2VZOQ8LRMqReRalKLBmyqHF/Q34NXK2GZ9AWFTfvJCqP3e9BwpUVuX2l
         UA4A==
X-Gm-Message-State: AOJu0YwtX3S2Ihczj4AnlgZ/sQ+ueMZp/0+oMGpTAfZOoFqWQMpaqMj/
	PTwLW4wQZw+vGutwR6HUk6jAo5Jpi/ggLCcEPncWu8VOHYOYtHUKDiUAjBC0kAnn+u+YZIBwyaM
	YA8Rn2CJ/6+U+QaYf6PJ+2O4eZ1s=
X-Google-Smtp-Source: AGHT+IHcLzEqaqR8To9kUpg1oJoyFtwQAdYQElGfbaOX6ibm7+lXNaRpQA7x7je9zRxsxiPDdCydsbC4JcZ+iNnst9E=
X-Received: by 2002:a17:906:b0d9:b0:a38:63d4:2273 with SMTP id
 bk25-20020a170906b0d900b00a3863d42273mr9526079ejb.35.1708378327153; Mon, 19
 Feb 2024 13:32:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
 <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com> <b2a0f7829a1c5f2822e9a896ffe3744587ff1298.1708124951.git.gitgitgadget@gmail.com>
In-Reply-To: <b2a0f7829a1c5f2822e9a896ffe3744587ff1298.1708124951.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 19 Feb 2024 22:31:55 +0100
Message-ID: <CAP8UFD3KbbRApC3ktgegsi_oBDpzX_89v0QGvWoHQ057hKjbbg@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] trailer: start preparing for formatting unification
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 12:09=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> Currently there are two functions for formatting trailers in
> <trailer.h>:
>
>     void format_trailers(const struct process_trailer_options *,
>                          struct list_head *trailers, FILE *outfile);
>
>     void format_trailers_from_commit(struct strbuf *out, const char *msg,
>                                      const struct process_trailer_options=
 *opts);
>
> and although they are similar enough (even taking the same
> process_trailer_options struct pointer) they are used quite differently.
> One might intuitively think that format_trailers_from_commit() builds on
> top of format_trailers(), but this is not the case. Instead
> format_trailers_from_commit() calls format_trailer_info() and
> format_trailers() is never called in that codepath.
>
> This is a preparatory refactor to help us deprecate format_trailers() in
> favor of format_trailer_info() (at which point we can rename the latter
> to the former). When the deprecation is complete, both
> format_trailers_from_commit(), and the interpret-trailers builtin will
> be able to call into the same helper function (instead of
> format_trailers() and format_trailer_info(), respectively). Unifying the
> formatters is desirable because it simplifies the API.
>
> Reorder parameters for format_trailers_from_commit() to prefer
>
>     const struct process_trailer_options *opts
>
> as the first parameter, because these options are intimately tied to
> formatting trailers. And take
>
>     struct strbuf *out
>
> last, because it's an "out parameter" (something that the caller wants
> to use as the output of this function).

Here also I think the subject could be more specific like for example:

"trailer: reorder format_trailers_from_commit() parameters"

> diff --git a/trailer.c b/trailer.c
> index d23afa0a65c..5025be97899 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1083,10 +1083,10 @@ void trailer_info_release(struct trailer_info *in=
fo)
>         free(info->trailers);
>  }
>
> -static void format_trailer_info(struct strbuf *out,
> +static void format_trailer_info(const struct process_trailer_options *op=
ts,
>                                 const struct trailer_info *info,
>                                 const char *msg,
> -                               const struct process_trailer_options *opt=
s)
> +                               struct strbuf *out)

Ok, so it's not just format_trailers_from_commit() parameters that are
reordered, but also format_trailer_info() parameters. It would be nice
if the commit message mentioned it.
