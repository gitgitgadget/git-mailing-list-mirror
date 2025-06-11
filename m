Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41242226D19
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634698; cv=none; b=BlyUolSGuGYaS9pb29UEnKP3ooJBoDm82V3HsMkPRxjGg8YIVa7nZJdstAGxpchUT2ggeu7azykKd2q73lGA6bBK+5CgTaOSyiPA6/cLQcQlt0ySBscKLKtAU1CWGwuClkT9Kfww9KNx+uiq19ojN44wvo7FbSnDtvNSevtLOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634698; c=relaxed/simple;
	bh=KMRf2l7MutqFPliKM6BGf5V5cckerOZ3nCN4Ko8s5zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuijKZ9bk9PQ46TKGWdZQYjarAFW6no4AhjxT7vjx59K+QKwtANoEGLoOGLUJDU5fy2AfsWIoHd2tw6SWQLfl3AxChuAS80jIFbGW5Hx7vVJCkxmqxFKUE2F9WaICTOE6U8i2emlI1JAY7tYR9jtdPS1LtdILgWbEinF3gySJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5MDuB7S; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5MDuB7S"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607c5715ef2so5861018a12.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749634694; x=1750239494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVmVph+SVUo97DUut3mVfb3NPlrc4lZEEGD43hitRGU=;
        b=P5MDuB7SXkEW6UveVHndRiDmbTXmYe17Dny/eLFRXDfly0vmZKlWrVyNe6bP9D0xn+
         OlDotirhj8WpMibQc92UsUw4Gzw9RqDdnSdj4or2ZUROZtwZ5yuU/W7nUC8cCAxr0lqH
         LLTIVHO2bo0lam4WJ4ZyLzy74mvJPnycfi5OAwMtTmQDIQN3zbb0eVdXv0NUMpeYnb69
         T5eOnE0EiAUAOxsGj5dWL+Qhv0zJ0hl7aWdijVLFr5XMXvhPKr3lmikzhpVYgP15w+Vj
         +XjVpYoEBFuFOR2oyy5W/j1dzqXZHQz90Ps1zuoWXGkoTNmYQqMlm4VE/rgbr4UJ9XOq
         75GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749634694; x=1750239494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVmVph+SVUo97DUut3mVfb3NPlrc4lZEEGD43hitRGU=;
        b=sZG+KDnLZGCK2yJKtTshd48tCq05YF/MOKjKoChoOsCRG6bo7kbQLoCVeIEhENrt31
         M20eg++vwMU1TJs3bXXBayov3SJBW+9RlHjiyYj0OtDY6rwBVuHXXwDM2xtKoXRi1THO
         jTHO7iiPLHi2wnpuSZ8aQYzq6NTpYZ9qjTYsNZ8LveaT6NElu4b2E+HyMnDVwio8iyYE
         FPknTMGJlNpLgRQx0RmH9j334ksZAwaeDzut2OSRlH9t6hTyl0p9OWRpsax94y+dCNU2
         x3X3lw0ZCuPMiPl+VztpqsxBn6Jh4nRqNQqqzhgzrYwaV5SNb7Cq/p1v6w+xR5E71gtn
         a+fQ==
X-Gm-Message-State: AOJu0YwJLTI8b5r1emVUs2XbTRAHeq+7+fyN+g6v+4NNpF6MX38IMNIK
	svkzEnJaaR9KcXwgq1QGhzWum0SmvtmANOKVvsMhLrwlO1bfPrg6pKlt0fLWuRn/bTlb1cNwpyD
	IAYOdmpVT4aJlg3mlfaNV8Y8V0pVoAm0=
X-Gm-Gg: ASbGncvGbij6wC4HIWwDx/SVsMPAPnJQR3GOBOz4NSnTr5ZAI43rz0BE0pLGcKS5ysY
	tvHD29YLPTyu66LarZ/5ingkSbABIDDKiDRPKOmKCrKEKhiyGYQhxjTDujf1fvgQUor/hOksTfL
	HcVd6qGY5HPiDwjpYQvYHCVffOIaUIf41PG7bXNSsSmeGro/nZmJbJai64
X-Google-Smtp-Source: AGHT+IFv2j9Ac3D/fhhWFErD/bKDYLflAJof55RwKvV0XlgLML5ml5GN15m6gjRHUaKRZ1xruQsSbPW17fnxYaOWXGE=
X-Received: by 2002:a17:907:e8d:b0:ade:4300:6c8f with SMTP id
 a640c23a62f3a-ade898390b6mr282443366b.57.1749634694170; Wed, 11 Jun 2025
 02:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611062643.8639-1-siddharthasthana31@gmail.com>
In-Reply-To: <20250611062643.8639-1-siddharthasthana31@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 11 Jun 2025 11:38:02 +0200
X-Gm-Features: AX0GCFvEjNBoTThAH91Uk2Ol9BOOyzosMh5dwSeEbLUWNzIOpKns0DlrFiZTwFo
Message-ID: <CAP8UFD1hBo_ZH1nyGBOoQOwx=44CfnkhEOHYu3_XMwSzXQAHdg@mail.gmail.com>
Subject: Re: [PATCH] cat-file: fix mailmap application for different author
 and committer
To: siddharthasthana31@gmail.com
Cc: git@vger.kernel.org, viakliushin@gitlab.com, johncai86@gmail.com, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 8:27=E2=80=AFAM <siddharthasthana31@gmail.com> wrot=
e:

> Reported-by: Vasilii Iakliushin <viakliushin@gitlab.com>
> Reviewed-by: Christian Couder <christian.couder@gmail.com>

Nit: I reviewed it when you suggested it on a GitLab MR (Merge
Request), but I am not sure it counts unless I also review it here. I
think the "Reviewed-by: ..." trailer is for patches reviewed on the
regular Git mailing list (or maybe on the private Git security list).
So maybe "Helped-by: ..." would have been better in this case.

Anyway I have now reviewed it again and I found it great.

Thanks for working on this!

> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  ident.c            |  4 ++++
>  t/t4203-mailmap.sh | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/ident.c b/ident.c
> index 967895d885..281e830573 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -412,6 +412,10 @@ void apply_mailmap_to_header(struct strbuf *buf, con=
st char **header,
>                                 found_header =3D 1;
>                                 buf_offset +=3D endp - line;
>                                 buf_offset +=3D rewrite_ident_line(person=
, endp - person, buf, mailmap);
> +                               /* Recompute endp after potential buffer =
reallocation */
> +                               endp =3D buf->buf + buf_offset;
> +                               if (*endp =3D=3D '\n')
> +                                       buf_offset++;

Yeah, without this, in the next iteration of the `for (;;) { ... }`
loop after the "author" header has been found, we have:

        line =3D buf->buf + buf_offset;

which sets `line` to something like "\ncommitter C O Mitter
<committer@example.com> ...", and then:

        if (!*line || *line =3D=3D '\n')
            return; /* End of headers */

which just returns as `*line` is indeed '\n'.

>                                 break;
>                         }
