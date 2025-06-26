Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA7202990
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973314; cv=none; b=SiS+pnZT/je0SGee8KBRDIKhen0k2E7ZkCo4DU8fKBV+HlQlJlIQcUHA1Vs9ZP5B1O83I2fMaK+d1UeFQpx1fB9wZzzJQcTmotJPfZ7I4fk37RuuHz3E3KhlXv3BwQBrAdtBhS3kaeiWrLdyf6iGUoefuD7+zhqsH0+0q5/7wMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973314; c=relaxed/simple;
	bh=zaz5T2P2sGNmSY0ft+cE1lozP7TQgAAU5TYWb+sy9hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdvTgDisT2c05plIVvJAf52GEUksKk+bnyuF/lLV81+IM4deHqQ2SoJgez18DuFAXs0Q5Up60Vqi68w2CZeVCDnVryLmwzuc9YKlcn7CnhP79pfjn+pqO+2ntPo315i6LZz8BA6QD/swXZ18RZopCH03X/GKcEWc0KkkmsLekD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DR2HmnHv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR2HmnHv"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313a188174fso2457624a91.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973313; x=1751578113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FZKL3QFeycG1+gPnc7dHP4ZM8PJDSOWCA5CindeMPk=;
        b=DR2HmnHviAXLzMOuGnWQfYsLqVC6kuqbYH14gJ7mmsYJWfBeuiqX432m0D0jPLmCOo
         67+P8jMMmZLKS1NPJAW0CTjdtF4xu2jC5Kt5LZDFbcbXPkkZdypbiSZ/TV7Tc0c2pwDM
         8vmVni3ppNpBwTH8bIc4WXTR0pZZ6xPEBeC+Ar6RV04e/g/FkNGNLW9A/QgyP/3FXJfM
         N11o1X5e2gnrcC1Q7o+6F2gv88xXvVi9JEcMhDt5juy0lLKaWirxn8INcTr784Cmp3ey
         F6/Hjf7FKXZ0TDl086+Mx6naKUxQIAUAh2DOaJEsa2u8wj87q/hv/mpNS94LbnJ/vj5+
         tGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973313; x=1751578113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FZKL3QFeycG1+gPnc7dHP4ZM8PJDSOWCA5CindeMPk=;
        b=NSwztN+wlwmaxKbMPRQDjX2CGrIbvfxwQHBy7TJWsAnzqN709t6MnatJCYv1jHIwkh
         AOkQ8eP7qG6OE577PYdrosVRmM6dtKqJykhh2UqWDlpZyUYrHLy7I4HVWoRPC+B3mtR2
         wfhTbeXNQMEIEk1RqK3y0cRekTkOuhA5/kM3wlRVzTEA6ViOVAHtjBiLISiAW/oPrnmo
         Xg3LskazNAdnCqL5B3himjzqZ9rgg85rlKkvf1L28r0ZB9/YRqmSZPtD6sLfXDfS4wE+
         yQp6lFLCWFL/VnSJ5Lf3cramPuZhRDBYuQb79dG78v/mb0RssBXIwsVyZApy227vVZxr
         VAew==
X-Gm-Message-State: AOJu0YwjmaPF6a9O78+7p69Y1szSCfJrduFih0OlBbvWf3bfGMZ6zcpH
	1q6udNZKc/1JOEb5nvq1aF4Mqdvcum6HrVx04grj2yLLDgFM9kKHzZWLx7lG0xAMd7N4fSfKZWU
	zoCQDEw0Qk2LeQyITkYZHq6ajH7bJWz8=
X-Gm-Gg: ASbGncs/f08t/Ljd+7WswBbw3klCkXaXsnsAoZnYKevmV5MmxJFDwyr9l+hWCri1mPs
	7Ml2bKi3y+R2PCSwoHYC00YV8P9GF6vL6U3y+A9oYXH5DBW/l+Uihmozrkkebp+cR70RzKtxDsG
	BDewPTNruj1QEfDKzLuB31Yw5av0elLZtgXIwnEHU8GFHz9/nOCLN1+vJSMGIELh4Ty6IwrEqRl
	a8Oclr2Lbzs6Nfw
X-Google-Smtp-Source: AGHT+IHBnXMT88eQPWaacUSwzzjHhFIQof/W3iHQpt/I5HUw/wnl+i4ZPWYdU3xsPy1KDDgPMXBKS8b4Gu8EyB0IJVc=
X-Received: by 2002:a17:90b:33d0:b0:313:d361:73d7 with SMTP id
 98e67ed59e1d1-318c92bcd2fmr716671a91.13.1750973312589; Thu, 26 Jun 2025
 14:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626132233.414789-1-ayu.chandekar@gmail.com> <ca8e7670-cf4f-4915-a37f-09d2e4b7c62a@app.fastmail.com>
In-Reply-To: <ca8e7670-cf4f-4915-a37f-09d2e4b7c62a@app.fastmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Fri, 27 Jun 2025 02:58:21 +0530
X-Gm-Features: Ac12FXylq31lnuhF63Vs3CFNVEtEsS4P1UNmBw2h4sbGQgNEkoa7tEXzSyGw71U
Message-ID: <CAE7as+aSG0BKeGDFs_GnHjo7juTv1jhKzRgTKGeoH+2X_-O=CA@mail.gmail.com>
Subject: Re: [GSOC PATCH] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	shyamthakkar001@gmail.com, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 9:10=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:

> >
> > +test_expect_success 'no change in comment character due to conflicts
> > markers with core.commentChar=3Dauto' '
> > +     test_commit base file &&
> > +     git checkout -b branch-a &&
> > +     test_commit A file &&
> > +     git checkout -b branch-b base &&
> > +     test_commit B file &&
> > +     test_must_fail git rebase branch-a &&
> > +     printf "B\nA\n" >file &&
> > +     git add file &&
> > +     write_script fake-editor <<-\EOF &&
> > +     exit 0
> > +     EOF
> > +     FAKE_EDITOR=3D"$(pwd)/fake-editor" &&
> > +     GIT_EDITOR=3D"\"\$FAKE_EDITOR\"" git -c core.commentChar=3Dauto r=
ebase --continue &&
>
> How about
>
>     GIT_EDITOR=3D"cat >actual"
>
> Then you can `test_grep` on that.  Like in
>
> https://lore.kernel.org/git/5ed77fab-678d-4a06-bbd0-ea25462a7562@gmail.co=
m/
>
> > +     # Check that "#" is still the comment character.
> > +     test_grep "# Changes to be committed:" .git/COMMIT_EDITMSG
>

Thanks, that's much cleaner and faster!

> Nit:
>
>     test_grep "^# Changes to be committed:$"
>
Thanks for the catch. I'll fix it.
