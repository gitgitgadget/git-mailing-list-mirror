Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A82F0C6B
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045531; cv=none; b=GCAS/kWnKaHXYjupSgC0g5IxW1tvH+jFtrxMvwoVrpDc6jt4q4fJ/x5gXCU0R3qgQTdb+mHcFpjatvHhGNbkWfGSC+BP3zPobZ1OxxmXC/xMFfc9lYq820xGfYyH0pM3Jpe0Y4KCY1cfRBkBshFOaZNdVHhvoHorMe38rOc61tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045531; c=relaxed/simple;
	bh=ziu3mkGaLYPXksigkY8XGv6z+SyLSo7CiZIv/HSwk6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krB7qhCOZYC0qOskmia99adjGbu8flE3VGixopDztEaHv1FRE009p6GD7mhhhVGaT7Ce4a5tdv3K2QCwBNpRIpT/+WNzVIkoTVSrhMeuYm02R7LfGqpbwgh/r44wejeQyU1ujB+UtLbx4H30BPR3KiupMdBvNSQJV4U/LWM9kSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnElEZ8a; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnElEZ8a"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a226a0798cso3386653b3a.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761045529; x=1761650329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5U2+CK1nfj3L/PGw3Hugze4ITMr59OVtJr/wyIXFYA=;
        b=KnElEZ8auZflEi34pbXEeyyBPuJp/RYmh/4UUSD61PWSPWWQFzC5yZpeSL8byllDTL
         kEWYGlcNBjRk/mVThtJ5WbkAl4EVfNFHYDQ6+TvslCFS1cUN+Ts5ZJcGk7XqvX3lGNyp
         hJMStCD8MZ1hDqGX76euf9NNhHyyeOXFGdIx4DLDr+bHWyq4evaM3ljqDYL52xClS2ar
         k/eD1xA9gMT2yAYKFDEuyKcdAKF6xaHbOwFE/XXM+R0jNTnCDSqEvWTLpvg39s7ZgWgj
         GIz9U8VQ9eqTbyqkZZklTdSF6WJaw6adPx9mEdHbvscfOaJCqaXAsozQC5FnA8nFDXyo
         o8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761045529; x=1761650329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5U2+CK1nfj3L/PGw3Hugze4ITMr59OVtJr/wyIXFYA=;
        b=kWwBgFwsagiKmmNpbYl8F5UcxNw3dw1IZhb7wHl7zQELLupawuajvjMf+trTvq5Iaj
         J2LjZiNvvpjRutey7OEPHK7YoF93LQZN21/uGLIK8J1Q0gSj1Un+c796qnh8IrQBntR7
         Yk0cT6dBDszgNPB3Wj58o31zOjAUnfKeELddbP0y2ieFe10FNOPx+8y8P8fx7/swvYDc
         bzi0z38i6ZH0RzTtjQT3FPmm3NjBYQuhdUbOc9Bolm817CJlDtQ7EEeFuD756PwvRRSF
         yIXpQPhFrgASGvRVirSrI5D+M6wcYl72opLFdNnZ5fO7UDUH6fUHBYS6bmPVaRwm3OVE
         zfug==
X-Gm-Message-State: AOJu0Yzv+WmWi6O/JdC+DBEaxbxGWY30woQ/dHEFVk7t1v8b2zJZ2UPG
	EbK3DzVsUpKrpyMDxGfECE/M+ZRY/0R/uYcV88b6XDi8OtOnKoVy5ftJjijwI/HCQTKb6Cq1qGd
	jGdS9nAWpU/OyVnaVgAQh7fc8JJNxXNU=
X-Gm-Gg: ASbGncvdwH7849YE7UCw+Ihi7LM6uSGOjAwQxS1X+SwLIeIzgHtzgdJBxvz4b9PbiKs
	3DHc8FsU36rg0BYX8QWLNyRkLbQsynPNVKNKvY79wDAcUdev6X56Y1jJE8yelJusmxb+4LqHVo2
	GRehezkclqBLdu2B45cZNEB2vXmHDtOg6R8WzJGEOnDuV+tNLb4aAfOlEazJRnGs6oZuTNSLUWK
	l+mtPLYHH2JdLiz2Cz6fIIKJmyKg/hKNLd/7ojtp6yC5ADhhvPn0F4/DgLb45i+thEM2l3Y
X-Google-Smtp-Source: AGHT+IG0fpdEs766wAhh0mAnG9oon1Zg14htgbWJD4t9+sExhWXBYHa4eTwdCGXrN6Xx5Gen8rEuz+l1f2fRppQ04T0=
X-Received: by 2002:a17:902:ce0f:b0:269:8d1b:40c3 with SMTP id
 d9443c01a7336-290c9cf344bmr213608895ad.12.1761045529426; Tue, 21 Oct 2025
 04:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760997183.git.belkid98@gmail.com> <2879d9be3659a9c1ea554fff7814507caae24b65.1760997183.git.belkid98@gmail.com>
 <CAP8UFD1J_B9W62bv=0yccQNGahkv2vco3arQOs0oe0DccdTeYg@mail.gmail.com>
In-Reply-To: <CAP8UFD1J_B9W62bv=0yccQNGahkv2vco3arQOs0oe0DccdTeYg@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 21 Oct 2025 12:18:36 +0100
X-Gm-Features: AS18NWDF_gx2zSZpDnvFbT-8Nnu6A7IXhxsudMuRIwoSokAURQQrwJ3KOTK12Rc
Message-ID: <CAD=f0L9A+mz=c9M_BsTLpWNAv+8wU7C+VaB42VniuiiRvgmmoQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 1/2] gpg-interface: do not use misdesigned strbuf_split*()
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Oct 2025 at 07:46, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Oct 21, 2025 at 12:56=E2=80=AFAM Olamide Caleb Bello <belkid98@gm=
ail.com> wrote:
> >
> > In get_ssh_finger_print(), the output of the `ssh-keygen` command is
> > put into `fingerprint_stdout` strbuf.

Okay noted.
>
> Nit: I think this sentence doesn't need to be in its own paragraph. It
> could be at the start of the paragraph below.
>
> > The string in fingerprint_stdout is then split into up to 3 strbufs usi=
ng
>
> Nit: above the variable `fingerprint_stdout` was quoted, but now it's
> not quoted anymore. I think it would be more consistent to quote it
> here too.

Sorry about that. I'll fix it.

>
> > strbuf_split_max(), however they are not modified after the split there=
by
> > not making use of the strbuf API as the fingerprint token is merely
> > returned as a char * and not a strbuf, hence they do not need to be
> > strbufs.
>
> Nit: this sentence is a bit long. Maybe "however they ..." and "hence
> they ..." could start new sentences instead.

Okay thank you.
>
> > Simplify the process of retrieving and returning the desired token by
> > using strchr() to isolate the token and xmemdupz() to return a copy of =
the
> > token.
> > This removes the roundabout way of splitting the string into strbufs, j=
ust
> > to return the token.
>
> Nit: this last sentence should either be in its own paragraph, in
> which case there should be a blank line before it, or it should be
> part of the previous paragraph.

Okay noted.
>
> > Reported-by: Junio Hamano <gitster@pobox.com>
> > Helped-by: Christian Couder <christian.couder@gmail.com>
> > Helped-by: Junio Hamano <gitster@pobox.com>
>
> Nit: Junio reviews all the patches and adds his own "Signed-off-by:"
> to the patch that are accepted, so there is no need to also mention
> him in an "Helped-by:" trailer like this.

Okay.

>
> > Helped-by: Krisoffer Haughsbakk
>
> I think you mean "Kristoffer Haugsbakk". Please spell his name
> correctly and provide his email address like for everyone else.

Oh I'm so sorry about that his.
I'll correct this.
Apologies.

>
> [...]
>
> > @@ -845,13 +844,17 @@ static char *get_ssh_key_fingerprint(const char *=
signing_key)
> >                 die_errno(_("failed to get the ssh fingerprint for key =
'%s'"),
> >                           signing_key);
> >
> > -       fingerprint =3D strbuf_split_max(&fingerprint_stdout, ' ', 3);
> > -       if (!fingerprint[1])
> > -               die_errno(_("failed to get the ssh fingerprint for key =
'%s'"),
> > +       begin =3D fingerprint_stdout.buf;
>
> `begin` is set here, but not used below...
>
> > +       delim =3D strchr(fingerprint_stdout.buf, ' ');

Ahh sorry I was supposed to use it here


> > +       if (!delim)
> > +               die_errno(_("failed to get the ssh fingerprint for key =
%s"),
> >                           signing_key);
>
> (This might be an issue that already existed, but I wonder if using
> die_errno() instead of just die() is the right thing to do here.
> Shouldn't we check errno before splitting?)

Okay sorry I'm a bit confused.
I should have used die() instead since we have not split the string yet?

>
> > -       fingerprint_ret =3D strbuf_detach(fingerprint[1], NULL);
> > -       strbuf_list_free(fingerprint);
> > +       begin =3D delim + 1;
>
> ... before here, where `begin` is set to something else. This means it
> was useless to set it to `fingerprint_stdout.buf` before.

Yes I should have used it in the first call to strchr ()

>
> > +       delim =3D strchr(begin, ' ');
> > +       if (!delim)
> > +           die_errno(_("failed to get the ssh fingerprint for key %s")=
,
> > +                         signing_key);
> > +       fingerprint_ret =3D xmemdupz(begin, delim - begin);
> >         strbuf_release(&fingerprint_stdout);
> >         return fingerprint_ret;
>
> I think this could be `return xmemdupz(begin, delim - begin);`, so we
> could get rid of `fingerprint_ret`.

Yes I saw your response already.

Thank you.

Apologies for resending if you're getting the mail again.
My first mail to the list was rejected.
