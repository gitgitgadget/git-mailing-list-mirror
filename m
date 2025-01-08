Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCEA1F8F14
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736341142; cv=none; b=GyP9q4HSi9wGkKBCwp6e+i55hjLMpSESZizdqWzmRv1d2KuzBYQxuzw7BP/FU3wXZDsWWbPVJUHN+sQHc6OOJuMa1UurSCAjiB+apJmuL6mdE6nryJYKHDATVhftsnQkMKIuAAgwUQfcTxe3dNd3gsl7x1N9rJKt+QfBLpUCncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736341142; c=relaxed/simple;
	bh=8P8+OR1MRfe+8tqZ3iPwMYocojl0xJO04eHnsFCPMhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqAdh6fPqWaAFIy/uG18wNFuVvTTpXyxH3IxIJzLNjACvunz7euRB8a8mzbMvxTulluFSlyhfnsjENgb8vkjsDrPRpaM6mJuv9bmpT7YaHp1xqcug/3riR/fI565w6OC0DYpbaqtMFz/BGZiRHA/VbF6DBIpD1IRn1nqqUvvclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5bV9mHS; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5bV9mHS"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85b92397fe2so2696153241.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736341139; x=1736945939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNKZNG72IU9Y8j6mGKd8jyG0GGsB9rFCoccumPoGgGE=;
        b=O5bV9mHSGF+SnNnWgloxi0cClHToeInDK959X4FXwf2ip2rk0+RgVLvGYf/renupjt
         3oUOK2cDCXePvxvEW6h2rl+/+ejbWb+xjFR+V1IVL5u7DHEpqFrqRXJ4WBEk5DlhXZej
         n8WMDJUrwAw5y1PfXiK4YCFlZLasPtU6o4C0PjCzKAUIQyFVck1hschmg+8IWejyIUaa
         4sulb4Grym1AkpRuWtsfPo04CtKgPM+1RJS2WZbWwQ0klpU2f5iNO0fb4JATq/wgk7YL
         0iJPEl+i+NdSYEuy8K4tgaXCk61g5AzrYw1CM2OdRHvz/+9EvoEsi9tWH8XdZDwSXYhR
         4xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736341139; x=1736945939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNKZNG72IU9Y8j6mGKd8jyG0GGsB9rFCoccumPoGgGE=;
        b=Hp03vmEOrOiMdMxPkBuYD++/T0ZvektBSWKFKsr86UoXvK6q6HNEtb8LpPXkqsS8wK
         l9bR1iyLSpZ9WMX16Ioe1CHYfRB1lgyjEZNRaadM4UjqrMbggWt+t+jxjpBf+fxUI4sm
         kJoSpxRO2x5EQJeQKgKPl8juhF2mAdP+vrELgTQUrObMaVTg12XNv4vdvSDnI+8Ya5CF
         i+mRjCwnq7i4VheKDvqLVE5xzxz3ysAuzvtLO1RrvSbd2QPZQnrp+/9YaV8nAfCNv36b
         zdikVf7iNdFpFvIm7HXznwhqBHktnD679xq1nWWojXqerb3fAjCfgmSp4msU05YXvGCA
         ahqg==
X-Gm-Message-State: AOJu0YzZ9NvEI9CinObzmczav0URENWoR1E2VVOhoe06aCbmyYAkIt4p
	FjcUoYkBUD6rDoEcNcZDnXbx+TWG9gA4nXiHL5Jjbq5KVTdJ4AHzKqB67lQUnlX+W807Ua+6yYn
	33uJqW6/GobhpKJFg6ELOq6z2Hz8=
X-Gm-Gg: ASbGnctJ/9WWklDLWAvhrmksmkjTxgmZ0qX6KA4Iw1ew3AFbupZDtkC3FI/+EzzcW0R
	+PlnWFbs+I+sH65/0+YWdQIqNiR+giMlYXTOFfw==
X-Google-Smtp-Source: AGHT+IGYLdLXFTdnyFkm8TgZjyzn2xgRmjKOaqtEvfL4sYNXuSErG714F66MUs2QMD1+sXJTbYZ+OUP4K4w9MdhWPng=
X-Received: by 2002:a05:6102:26c5:b0:4b2:5c0a:9afa with SMTP id
 ada2fe7eead31-4b3d0f66b7amr1530266137.4.1736341139124; Wed, 08 Jan 2025
 04:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250106103713.1452035-2-usmanakinyemi202@gmail.com> <CAPig+cQz+2Q7Z=uMYvKNrK2MACQC130u5iiMcsUPjNTifeWSbw@mail.gmail.com>
In-Reply-To: <CAPig+cQz+2Q7Z=uMYvKNrK2MACQC130u5iiMcsUPjNTifeWSbw@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 8 Jan 2025 18:28:47 +0530
X-Gm-Features: AbW1kvaQntQ-Fa6gkldlUq8HD4OIIKjabw30zGNFnkN7eHibB2-OTdm_sozVyJw
Message-ID: <CAPSxiM9krVgyXwymQSg1Y8L5qsb_xpo_FGskFcmWWBC2_Dvs0Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] version: refactor redact_non_printables()
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	ps@pks.im, johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:05=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Mon, Jan 6, 2025 at 5:37=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> > The git_user_agent_sanitized() function performs some sanitizing to
> > avoid special characters being sent over the line and possibly messing
> > up with the protocol or with the parsing on the other side.
> >
> > Let's extract this sanitizing into a new redact_non_printables() functi=
on,
> > as we will want to reuse it in a following patch.
> >
> > For now the new redact_non_printables() function is still static as
> > it's only needed locally.
> >
> > While at it, let's also make a few small improvements:
> >   - use 'size_t' for 'i' instead of 'int',
> >   - move the declaration of 'i' inside the 'for ( ... )',
>
> Regarding the above two items...
>
> >   - use strbuf_detach() to explicitly detach the string contained by
> >     the 'buf' strbuf.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> > diff --git a/version.c b/version.c
> > @@ -6,6 +6,20 @@
> > +static void redact_non_printables(struct strbuf *buf)
> > +{
> > +       strbuf_trim(buf);
> > +       for (size_t i =3D 0; i < buf->len; i++) {
> > +               if (buf->buf[i] <=3D 32 || buf->buf[i] >=3D 127)
> > +                       buf->buf[i] =3D '.';
> > +       }
> > +}
> > @@ -27,12 +41,8 @@ const char *git_user_agent_sanitized(void)
> >                 strbuf_addstr(&buf, git_user_agent());
> > -               strbuf_trim(&buf);
> > -               for (size_t i =3D 0; i < buf.len; i++) {
>
> ... the original code appears to have already been using `size_t` and
> declaring the loop variable inside the `for` statement, despite what
> the commit message says. So, is the commit message out of date? Or are
> the patches out of order? Or something else?
I just investigated what happened. Another commit already added it and
I did a rebase on top of the "master".
I did not notice it at all. The commit message is out of date.

I will update it in the next iteration.
Thank you very much.
Usman.
>
> > -                       if (buf.buf[i] <=3D 32 || buf.buf[i] >=3D 127)
> > -                               buf.buf[i] =3D '.';
> > -               }
> > -               agent =3D buf.buf;
> > +               redact_non_printables(&buf);
> > +               agent =3D strbuf_detach(&buf, NULL);
