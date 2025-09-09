Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD619283C93
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408216; cv=none; b=ZVlvOVbKfizE/yaoFMC3jUfOynHM1YnEK33F53Ds+r26jY/YtYSIRUP9cO8Td4GTvocvNp8bS/JldStJuwSuIcD6O2Uraw2Nq6PP5c0zlizJFjC69x4bX4JIcm6lecqINGzXMkM1YZ3wZ19jbu02zYFucGoS5pBWhG2Y7FsYgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408216; c=relaxed/simple;
	bh=cBvoD+aXYK1B8Ff0XyfaLvHsHk21/o92pSH9hHrKQOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I12PrV9QtnGtmZMmvkK1pGuCZppV5ImNp2GM5hoUHK6+ntrnHnqhCZTXIGIQUwsh28ukhQT4nB4JOYOk6JJKQiKCgZ7i63lQkjF6hxH6tFf796fimAbyK/MmfzQbcoAyRK3G6eOG9BIU0veM5cLcHJITtJUmbY5VOnz6h9rNPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MosVp0Kl; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MosVp0Kl"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3f66ad3fcf4so55319875ab.3
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408214; x=1758013014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHEV7AT4Z0knW7VRTt7Wc5U8gSKzPbhwwU7khg0/ggc=;
        b=MosVp0Klk2E8yoYVFvrAHfwmX8XU5f4vKs+VFeqfEiytiUr6TFdANYhhngaJaCtf7x
         S56zc2Yxm1dYlz3TH2BIr7IEHx6E8eYjyJ7RZRlu1B+YEQwopmm00emCBbzJadgHt1sJ
         D8pghBxjbv0sII6pfHBOwqdfxhNcnNpMhDYs+FYTHk1+CrcmAETB/jIhxvWZUUWfQpzp
         VnuOddc7jXKPa+6fRihmM2JPtj132c0GJhkj89X9WMYWnwFIbR4r+kluK7SSzKxyY3oF
         tlaDUovSPCnw0qGL4OSPAhiDeJDMTLeacPDeT4F3ZWMSflb/4kez4DiZFOteK2nP/hzy
         iITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408214; x=1758013014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHEV7AT4Z0knW7VRTt7Wc5U8gSKzPbhwwU7khg0/ggc=;
        b=TashUo4WBYwmkc3SATrwX4RneU4tHgAFyR188b2asxZAGledZkuEH43q4dgjNseUTk
         BPyJzjluYsMOxMA9RU9FT1AUZSqN9gmAxt9xk1HfORtge2wOsV1J7YqlfADmJGP5DXcK
         Ja8leAxVPqrdlD5HiZq4FcKGrMK1Uw2+XBa9zM1aEW3SrY0zD7T6Iyol/0x6sqDH/0+y
         6Jl/h6lLJOvgbvNKZtJLpLGKmDzvrxzNn3xEUPu2CkYM/BllSHsMn8WibUwxu5Te519X
         6h9TgyGpUu/KcwGFHuG6W45yjgd6avpKpQ1jpnKx0NVoaqn2tRxJi+PHEVxeQYnSrDai
         rxTQ==
X-Gm-Message-State: AOJu0Ywu4fZPDXQSSIp1H5kH9jAtllFMfpBQbuJPYJIxrvbP0fJfhvCF
	K92au+3Tr5y84uIcOR4vSwFIqAoaLsTDaGie+PoNAc4V7+wOzl9EWudP1Zx28HIWGvh3w0L7s7s
	dJsPfmNRpSmBLTIPU8FhjJwjx06DA74FahA==
X-Gm-Gg: ASbGnctZ6OE1bxhqBeDpN/mm8/onmeFnQtGJUHzcqoVAJ2S81FkJc2hUw/E8bfZfVYF
	DZCvroj1Zwc1T0jtfChJi7bGEI+c3QkEINsOR8QN0/lopeCufsxg6VzeGlo4v2Ys1hg9WGA7XRU
	MwJuCORglfVsyogojePMAAkwh/rvVoJ+0GbPg3BmiuPK2khq9Nt7W6y7qMOscYu5muslr7KtYAe
	R6kvTN6/tG5NxQXbz/twJfHOep1/umNg6/WGkxWsKrnLbcTsQ==
X-Google-Smtp-Source: AGHT+IEjlNZ6BKgUSKjC4czMG6302nnlWKQtzjOwwZ60AM9yvlX/2hykUtGAr/6yg0v+GEkBSQ9r4/vLIEYmMG2XioI=
X-Received: by 2002:a05:6e02:2198:b0:405:b792:32f7 with SMTP id
 e9e14a558f8ab-405b7923533mr110224835ab.31.1757408213858; Tue, 09 Sep 2025
 01:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com> <ab17d8c23f0ca48374416ec1eb34128585795736.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <ab17d8c23f0ca48374416ec1eb34128585795736.1757274320.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 01:56:41 -0700
X-Gm-Features: Ac12FXziWHa4IGtMGOlyWLGp1Ar29667Ddp98FCJwsCPd3Zgyt3Gh-bubyeYqAw
Message-ID: <CABPp-BFNSj5rLYqYXCbqmg-kKwfV8BewjoCx+7j3vhT6waojFw@mail.gmail.com>
Subject: Re: [PATCH 04/17] xdiff: delete xdl_get_rec() in xemit
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 12:45=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> This function aliases the fields of xrecord_t, which makes it harder
> to track the usages of those fields. Delete it.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xemit.c | 38 +++++++++++++-------------------------
>  1 file changed, 13 insertions(+), 25 deletions(-)
>
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 1d40c9cb40..2161ac3cd0 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -22,23 +22,13 @@
>
>  #include "xinclude.h"
>
> -static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
>

Can we remove this line too, to simplify the diff?  (i.e. make there
only be one blank line between the include of xinclude.h and
xdl_emit_record?

> -       *rec =3D xdf->recs[ri]->ptr;
> -
> -       return xdf->recs[ri]->size;
> -}
> -
> -
> -static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdem=
itcb_t *ecb) {
> -       long size, psize =3D strlen(pre);
> -       char const *rec;
> -
> -       size =3D xdl_get_rec(xdf, ri, &rec);
> -       if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {
> +static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdem=
itcb_t *ecb)
> +{

The change of the opening curly brace to be on a new line does match
our general coding guidelines, but cleanups like this should be in a
separate patch.

> +       xrecord_t *rec =3D xdf->recs[ri];
>
> +       if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) =
< 0)
>                 return -1;
> -       }

While in this case you were modifying the line in question and thus
fixing the code to also not use curly braces around a single
statement, which is more justified, it still makes the patch slightly
harder for reviewers to read since you are doing multiple things (what
you said in the commit message, plus cleaning up style "violations").
It'd be better to leave the existing style violations in place, or fix
them in a separate patch.

>
>         return 0;
>  }
> @@ -120,11 +110,11 @@ static long def_ff(const char *rec, long len, char =
*buf, long sz)
>  static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, lon=
g ri,
>                            char *buf, long sz)
>  {
> -       const char *rec;
> -       long len =3D xdl_get_rec(xdf, ri, &rec);
> +       xrecord_t *rec =3D xdf->recs[ri];
> +
>         if (!xecfg->find_func)
> -               return def_ff(rec, len, buf, sz);
> -       return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv)=
;
> +               return def_ff(rec->ptr, rec->size, buf, sz);
> +       return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find=
_func_priv);
>  }
>
>  static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri=
)
> @@ -160,14 +150,12 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_=
t const *xecfg,
>
>  static int is_empty_rec(xdfile_t *xdf, long ri)
>  {
> -       const char *rec;
> -       long len =3D xdl_get_rec(xdf, ri, &rec);
> +       xrecord_t *rec =3D xdf->recs[ri];
> +       long i =3D 0;
>
> -       while (len > 0 && XDL_ISSPACE(*rec)) {
> -               rec++;
> -               len--;
> -       }
> -       return !len;
> +       for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
> +
> +       return i =3D=3D rec->size;
>  }

I agree that the code is easier to follow without the aliasing.
