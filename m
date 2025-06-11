Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2AD299
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649588; cv=none; b=mXi5YRK9CXVVov3sNq0CL0q7xlBVECJAjWJXCsof3iilTlFAjhjFHGqOmU2bwfL/7GGOt/Ivjxsi/YxQe3EojTtUVqdirrN1NBTI3aNITKyJwSXSsvGI+D77RPXPWGUJicBX3vwoUCFYP1/8QN6NxSZKYWmG+N2FFhcaoQfD4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649588; c=relaxed/simple;
	bh=JSFm+xQZuYW1AMeQsEDbdM5F3RMed1ww7JBQx7EVIwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSo12Rq4Y0vJvFw1tqypBEIzqF9noEauq4pl3vG7hxuF5sECKjGXF3WlWUyxo1aeTS6kRjxAome6ZCb+disEFGqdVvGZZuWgQZVeyWQEtbw8O3kzegWtKH/n0Y6+kBgaNzGEY9df/d63rtPQ9vZbT+hKmaxHQ13gclcmawj4Hxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPbn2duK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPbn2duK"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad8a8da2376so1089219166b.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649585; x=1750254385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPsVj2JRj/UivkYaruBXsB+Np9nZVgA39uTkTJhMRDI=;
        b=WPbn2duKqU2UeZzk5XnjeKwxAlRNY0t5MyevEHObyMvv+QN5EENHY4LI0Xr9l5JDaG
         eRg39hlqO+GxYFGgREeQt8WX+yiGClHMy79alsfqgZFytTieviu4uetXw0aVMc29BNdg
         kmfJKvfE+I+hQ1xl/yTq2XoGPYWYSjDNko5e9ZYF/AmS/J7aAyidu+ToxSsNSwZbGwhz
         fcHnIS7O+aycBQdmoosnHy9kgZklgDKn4uQNWvNC4pOQW+322ci3BtWz9aXNYNOfECBv
         U+Vu/wMv2mZngtBLffH6M+bGQMzP0XZC7630cZnxmErQw8awCOkbUomfBjMSdGm8+1Tm
         amcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649585; x=1750254385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPsVj2JRj/UivkYaruBXsB+Np9nZVgA39uTkTJhMRDI=;
        b=j1FLHHZnWeEgjzavRZ/RTqP33OUp4YmQC6Rmh9UHL0tn76o0yO3l0FufZSrULXGHqN
         zzULkj3PMcwi3FiibHSI8ecv/XxzNbLGA1aTFsEepx8miU6GQgoWjQ+QbFBWbvCxz05v
         ByBTzatU5u/rJT2ZRzpmT6AosJ1oUazg4Q3A6fKZ10V73//Zp68SBY5oOEAJTbfmd5oW
         2v/P69tzM722+tjchet1HcwwReSTlTKTeP6AM3cTgA+CdxVW53js3Bjn9hI/7b71ysRW
         Bh1Le+HtQ2JXxIA+yH61Wx0ecZgtqFlr3+qa7HxTNR/2dSiJqHNILzs299qbFPgE2a/v
         SBzA==
X-Gm-Message-State: AOJu0Yx+xTxulQFX8pI7k9TmL58I5IlXI6jygs4rMuJQJgctvNkS33Xc
	3HOHQOTVHeuFR0iNF8RMMqAYv8LgSrxcUeWwl5/6p/Bp5cNNy5E7ZPK82Q9Qxxzk5ina176mMRN
	mHCGVWq/RKucwDIX+8q9aqKDIyWdFDHk=
X-Gm-Gg: ASbGncsbj4bLnV6TQzslElurVyS5CmyJltXS+/MNErlJfrIsdVZytCgChJZozHX42yT
	woO2Q9ZM8R7fP9Lj4w20KRwcL6PPEfO3/p2tJ00fb71vAxnDDJpuuRETG1QVEoYugzw8rhe5jVB
	OBMc1nixnMdX2PpDYUdF3k+shGFHz5iDD9NEldqoGfPPVS4Q==
X-Google-Smtp-Source: AGHT+IGsN5og6Sk3clf7qOHlAmc271dhZmwVBrtFnyQK5fsm/2200frSD/X0RQPcSR95FkH71zeguZmyJmnUv9KlGXI=
X-Received: by 2002:a17:907:3d4c:b0:ade:3b84:8ef6 with SMTP id
 a640c23a62f3a-ade894c42b3mr333548566b.23.1749649584424; Wed, 11 Jun 2025
 06:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com> <20250519141259.3061550-3-christian.couder@gmail.com>
 <aDVu6O9MUicmd8y4@pks.im>
In-Reply-To: <aDVu6O9MUicmd8y4@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 11 Jun 2025 15:46:11 +0200
X-Gm-Features: AX0GCFscPQ3O86-mtF35ORiFi5BXAJtttVmFGebi5d30u4vWzLdjbHZF10frEws
Message-ID: <CAP8UFD1b9GzfTSE0dSef_C8mjMz+PchUoRHBPp5M9yKz44Ndsg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] promisor-remote: allow a server to advertise more fields
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Christian Couder <chriscool@tuxfamily.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 9:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, May 19, 2025 at 04:12:56PM +0200, Christian Couder wrote:
> > diff --git a/Documentation/config/promisor.adoc b/Documentation/config/=
promisor.adoc
> > index 2638b01f83..71311b70c8 100644
> > --- a/Documentation/config/promisor.adoc
> > +++ b/Documentation/config/promisor.adoc
> > @@ -9,6 +9,24 @@ promisor.advertise::
> >       "false", which means the "promisor-remote" capability is not
> >       advertised.
> >
> > +promisor.sendFields::
> > +     A comma or space separated list of additional remote related
> > +     fields that a server will send while advertising its promisor
> > +     remotes using the "promisor-remote" capability, see
> > +     linkgit:gitprotocol-v2[5]. Currently, only the
> > +     "partialCloneFilter" and "token" fields are supported. The
> > +     "partialCloneFilter" field contains the partial clone filter
> > +     used for the remote, and the "token" field contains an
> > +     authentication token for the remote.
> > ++
> > +When a field is part of this list and a corresponding
> > +"remote.foo.<field>" config variable is set on the server to a
> > +non-empty value, then the field and its value will be sent when
> > +advertising the promisor remote "foo". This list has no effect unless
> > +the "promisor.advertise" config variable is set to "true", and the
> > +"name" and "url" fields are always advertised regardless of this
> > +setting.
>
> I think this documentation should be clarified to explicitly talk about
> "field names". In v2 I misread these paragraphs to mean that the admin
> is expected to configure name-value pairs because you say "fields" here,
> and that term is specified elsewhere to be such a pair.

Yeah, right, in the v4, I have clarified the doc here and in other
places to talk about "field names" when relevant.

> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index 94e87f2f48..cde4079d8c 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -314,6 +314,73 @@ static int allow_unsanitized(char ch)
> >       return ch > 32 && ch < 127;
> >  }
> >
> > +static const char promisor_field_filter[] =3D "partialCloneFilter";
> > +static const char promisor_field_token[] =3D "token";
>
> Curious. Why aren't these declared as mere string constants (static
> const char *)?

Using "static const char *" is a bit less efficient, as it uses an
additional pointer to point to the literal string.

> It might be a bit more idiomatic to have these as
> all-uppercase defines to make it obvious that those aren't a local
> variable.
>
>     #define PROMISOR_FIELD_FILTER "partialCloneFilter"
>     #define PROMISOR_FIELD_TOKEN  "token"

This has been discussed a few times in the past on the mailing list
but I can't find any references to such discussions now.

As far as I recall the first discussion I had about this was with
Dscho who was in favor of using "static const char []" because it's
more type safe than "#define ..." and more efficient than "static
const char *".

> > -/* Prepare a 'struct promisor_info' linked list with config informatio=
n. */
> > -static struct promisor_info *promisor_config_info_list(struct reposito=
ry *repo)
> > +static void set_one_field(struct promisor_info *p,
> > +                       const char *field, const char *value)
> > +{
> > +     if (!strcasecmp(field, promisor_field_filter))
> > +             p->filter =3D xstrdup(value);
> > +     else if (!strcasecmp(field, promisor_field_token))
> > +             p->token =3D xstrdup(value);
> > +     else
> > +             BUG("Invalid field '%s'", field);
>
> s/Invalid/invalid/

I have made this change in the v4.

Thanks for your review!
