Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E568383BE
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323919; cv=none; b=P6hS6/wE3GAaI4+evStp2VBWEKxzG7oCDyJA/ktwN81aMoWToI7Vc5l0qKnN4/HejZNvQqujEP30maPSdPj/KLAQHNxCK07r1WuuiK+puzglgDWxq3x31vknIU1qyHlKN//S4hhJ32Pd7iKx0d8HrKQ4wy0cfFOCyI2kD6er6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323919; c=relaxed/simple;
	bh=HC0EFZoML+ZGc6+OoTKI3+GL1WNcfOxnSSaAfVXSf6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqVqbTw6Pq4BhGt1wbya7OprZmKqqmCYzUGa5s3/BrOpbUXSUkushvBqsLLzu7hI9tmOy/SXhtLg0nFampCQGGpmgHuSuH9V2nFNEn2IIpwttIRG6TO9K0c7+RANo254JGCCEEhHz1s76Chn2An+krRWm2NfukLOsNSL+DGllGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLp30W4I; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLp30W4I"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so162560366b.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707323916; x=1707928716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bEPzmrhtG2EwVfBsxyxIjmipyLXRaRk9uGT8/ep2oI=;
        b=dLp30W4IqqiNSbVAz1cIz3ixYAutJxyHQ54zwqKyON7CrprwN5/jgoXB/+A4YI91t8
         BEcqwZh2uGUxY1nv9DxcG/p+wVQ5oV3ZyeuMqxxjK8ts0HIQV9XQahsFeI2fEPhE1u9h
         iAWs4H7+lEN6MDRqnHKgQ/WpeHJKVg7vA5ZxfIyb0ewJM9AFBzsjt1cSGDCf453ZjQm9
         85nyuqwwC6AyudTbvUMWUoQ0MlRPIaS2nsFtrw9BcPWHGqFpNQe3sQh6wv6yf9dMiear
         H+aeegrNqmDJpL8hHo91Ss/9WpHAoBLoZsTQupyiJwmWRFCdxmC27Fz2mG3kAi9bxJXn
         gsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323916; x=1707928716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bEPzmrhtG2EwVfBsxyxIjmipyLXRaRk9uGT8/ep2oI=;
        b=wPLo7aLYDMRgleYQMvt8PIVf1FacY0UGz+GkurAVQMx7GynmI6C/8qtlnsfD471y9r
         IfCFjQDVmUZqeVqjFuBEHEih1nwIY1Tl1kR8ki9MBAdQJnbkh4oEe1sVDN8pCvIhWZB8
         RTdfG+358Bk18KC3sl92BXa0T58nK5wjnjOIO2e6XMJQ4sWlUnNTfHMLvHjopq/9e72c
         PP+TahQRZzbbRJ5I7VM3ixYQNkMeozF31yXlMiI1qzJpaeMjwLP+w3gxjWjYX17YC4y+
         fK6sx/IKhh0ndwj5FGQ0KtEQiaadsKSTBVgvgxiD8ajnLVOMUWn6ZKdnxl+XVhrmhw3F
         6sdg==
X-Gm-Message-State: AOJu0Yz2o6TUDjt6Qa9yziJswZo8XF04HX3vEJ7xk7Hgz86DOaEYUM2o
	C71P+joVOIrtqNS+v1DDPhtoYBX8AyEgT0t/hPdKjkNHm3ffzwmc5NQ1ADE2PzQhLdkWxwORNEK
	/eO87+QUAqHgqHUdgZ5kWba0XkrI=
X-Google-Smtp-Source: AGHT+IFJngDNB2U4TUDgpBeRk5dOp+Myzp2/tYVe9aj4BGKUw0D4fHCuFa/OneTZ1UVYWKULNilLx8y/ugxLk6jCH74=
X-Received: by 2002:a17:906:e094:b0:a37:9b07:fffc with SMTP id
 gh20-20020a170906e09400b00a379b07fffcmr32267ejb.12.1707323915817; Wed, 07 Feb
 2024 08:38:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201115809.1177064-1-christian.couder@gmail.com>
 <20240201115809.1177064-4-christian.couder@gmail.com> <xmqqil37yix1.fsf@gitster.g>
 <CAP8UFD3Hfgud19y_K1bZOudkBE-ss1_SgWTRVkJ7gUbYJ400yQ@mail.gmail.com> <owlyttmkmwaf.fsf@fine.c.googlers.com>
In-Reply-To: <owlyttmkmwaf.fsf@fine.c.googlers.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 7 Feb 2024 17:38:23 +0100
Message-ID: <CAP8UFD34a3Njx52ja05ZpSuRrORGsFu2zN7uBYprx5ABpn3r3w@mail.gmail.com>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with --missing=...
To: Linus Arver <linusa@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>, 
	Elijah Newren <newren@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:57=E2=80=AFAM Linus Arver <linusa@google.com> wro=
te:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Thu, Feb 1, 2024 at 10:27=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
> >>
> >> Christian Couder <christian.couder@gmail.com> writes:
> >>
> >> > When such a command is used to find the dependencies of some objects=
,
> >> > for example the dependencies of quarantined objects, it would be
> >> > better if the command would instead consider such missing objects,
> >> > especially commits, in the same way as other missing objects.
> >> >
> >> > If, for example `--missing=3Dprint` is used, it would be nice for so=
me
> >> > use cases if the missing tips passed as arguments were reported in
> >> > the same way as other missing objects instead of the command just
> >> > failing.
> >> >
> >> > Let's introduce a new `--allow-missing-tips` option to make it work
> >> > like this.
> >>
> >> An obvious question is if this even needs to be a new option.  What
> >> are expected use cases where --missing=3Dprint without this option is
> >> beneficial?
> >
> > I am not sure if such a case is really beneficial but some
> > people/script/forges might rely on an error from `git rev-list
> > --missing=3Dprint` to propagate back an error to some user interface.
>
> I currently learn toward just making the new flag's behavior be absorved
> into the existing "--missing=3D..." flag.

Ok, then I am going to implement that in the next version I will send.

> Nevertheless, you raise an
> interesting concern.
>
> Perhaps a compromise would be to make "--missing=3D..." learn the new
> behavior of this patch as Junio suggested, but to introduce a new flag,
> something like "--fail-on-missing-tips" to fail early if any of the tip
> commits' objects are missing? That way we could keep the current
> "strict" behavior of complaining if we feed rev-list any tips whose
> objects are missing. And for the vast majority of cases the
> "--missing=3D..." flag could (intuitively) gracefully handle tips with
> missing objects and you wouldn't have to pass in the additional flag.
>
> IOW, make the minority (certainly not majority, I think?) of users who
> really need the error propagation use the (new) extra flag, while the
> rest of us (including the version of you who was surprised by the
> limited behavior of "--missing=3D...", enough to write this series) don't
> have to.

I agree that the majority of users would prefer `git rev-list` with
"--missing=3D<arg>" (when <arg> is not "error") not to error out when
one of the tips is missing. And yeah, indeed at GitLab, we are among
this majority of users. I was worried about a small minority relying
on the fact that it would error out in such case. But maybe we don't
need to care unless it appears that this minority actually exists.
