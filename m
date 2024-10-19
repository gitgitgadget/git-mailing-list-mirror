Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B817DE36
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729339134; cv=none; b=E1dVa+1cz+O7PS+je2EwMJDHAwfySsZOvCptYyPfn7lCBd7iVodzUE9U0vlbm10ZkzhwHPCI7njBdOaqd3IQVjMRg3WXP2pmMXEziycACh3EoBanRWCZdKf4jWz6p5BxEd3YipZhR4RxFOKGC1XCJcno6E8cmPhVE63KzHV84NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729339134; c=relaxed/simple;
	bh=L0itzk3vBm8RvPdN/24h3DeSdB7E2ovZcIdQtulHwNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2J5DMw6n+4YxYiUr55vne32EuXUaRcZuI9ZRmjYnHi4x7J2+pf5/ELR0hw1HZ+A5y0eXPL3FRbRmuNBTCwKc1JZ66uMtveVNUjY2HGDEAKg9npR1THZIcFe6cM94aHVi+I/MBEqRVlBayoWCo9qiqGzDt6x6rCfgEon/zlF4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Miq05FQ7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Miq05FQ7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so885070f8f.2
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729339130; x=1729943930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyqX0+IEyVhewYva1Gc2oLaSlVWlcckWc61izh/3uI0=;
        b=Miq05FQ7OB5ENchkUY3TOKmNMNM2NcBzY5y6hk67A2uTLX+ZWJIHjpcLKByaOjF1VQ
         8hWMqEGgQ/I4TaMLPDW45hYKz2VOX+odc4bio7JHqQ3ckA5ke697B7CixRtGmplQPphk
         2/+8nJLbMwEVKLshVxw58zbj8Pur4PtrYIlC98n9u80a5CaAsqVTH1gSOi37S8gSeERl
         V9DrI3YWEQ9B91IkGeOuy9UxuYKaIF69hizDARti86M7EjyF1zhBssTj6ovvqh2qcs8c
         R64jw89XHSQKIlmGQ0s0TaUvw2tOcOs7tqBlXFUAGIfshKv1JxgBNQn/FuUZfd8Tav3x
         FTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729339130; x=1729943930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyqX0+IEyVhewYva1Gc2oLaSlVWlcckWc61izh/3uI0=;
        b=vRGYmHf18Ytxx0lMobdcuuK80M3HvV5uCGtrius52P2y2Ds1tuLvciqbC9SO5o4K+j
         P3PDx4syyQc8vsRe6DutULC1UzBK0Y84/2Xe0chfXWNoxvF+q/QPG1aRP86YwynvFoor
         TUJisWRqvxsVo/CGPjaUe7gM8bNzhFfZrhFfUjEiexO7Pi0NyN6+z5uY1Kftf1mgiKaA
         T8wA2VKX5jYEavIAGsUimQfTYHv5jY4L0SR8TQYGd3PgvgzBktJo6F5laKuAchSXf0tH
         tOB6mANKyXV3uYtCV1eljZtncN1iVNhobGQkHf12h9wLt1Q4ODFKnTDyOnjoDjvzKKpX
         GuMg==
X-Forwarded-Encrypted: i=1; AJvYcCVF3bT7bgLEmXpRMrPNo8M2K1mcu72/4DQiOuGPhE3AkgZp1GqaEv/ahT7QPUP7pxYsP2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5ygU8y0Lba4qpFefhRvwcCKlXPrQbKG0ZMFjYa1BWWAk+ycx
	39gOWZbc/UoxDrOOrAlneUFRl1QLbU4Ocu2D1Cl3Nu7eF3oKZ+Q73BNPDoILYqHXRELuCiJmonr
	jsvBtWOkhjKOrFNYtMKMPMOdy/yk=
X-Google-Smtp-Source: AGHT+IGUZItJNwiDlAdsQamVlrcZxKRM4mxUttBl/ljIF1pY4hIlumV9C/qi62bJ8Nq2t3hH521MC3j32TS6472C4cM=
X-Received: by 2002:a5d:674c:0:b0:37d:4c8f:2e1 with SMTP id
 ffacd0b85a97d-37ea2181ea7mr3304754f8f.22.1729339130247; Sat, 19 Oct 2024
 04:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1817.git.1729296853800.gitgitgadget@gmail.com> <0e393f0e-aa4b-479f-bedf-f4dad2256d02@app.fastmail.com>
In-Reply-To: <0e393f0e-aa4b-479f-bedf-f4dad2256d02@app.fastmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sat, 19 Oct 2024 12:58:41 +0100
Message-ID: <CADYq+fYCAJx-FsPnn+RpTTFZ=hWucyC-gj=tq=d+7R2YiYrKdw@mail.gmail.com>
Subject: Re: [PATCH] notes: teach the -e option to edit messages in editor
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 12:37=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sat, Oct 19, 2024, at 02:14, Samuel Adekunle Abraham via GitGitGadget =
wrote:
> >  builtin/notes.c  |  4 ++++
> >  t/t3301-notes.sh | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+)
>
> The documentation should be updated:
>
>     Documentation/git-notes.txt
>
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > index 8c26e455269..02cdfdf1c9d 100644
> > --- a/builtin/notes.c
> > +++ b/builtin/notes.c
> > @@ -489,6 +489,8 @@ static int add(int argc, const char **argv, const
> > char *prefix)
> >               OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
> >                       N_("reuse and edit specified note object"), PARSE=
_OPT_NONEG,
> >                       parse_reedit_arg),
> > +             OPT_BOOL('e', "edit", &d.use_editor,
> > +                     N_("edit note message in editor")),
>
> The `add` subcommand does what I expect it to after some testing.
>
> >               OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
> >                       N_("reuse specified note object"), PARSE_OPT_NONE=
G,
> >                       parse_reuse_arg),
> > @@ -667,6 +669,8 @@ static int append_edit(int argc, const char **argv,
> > const char *prefix)
> >               OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
> >                       N_("reuse specified note object"), PARSE_OPT_NONE=
G,
> >                       parse_reuse_arg),
> > +             OPT_BOOL('e', "edit", &d.use_editor,
> > +                     N_("edit note message in editor")),
> >               OPT_BOOL(0, "allow-empty", &allow_empty,
> >                       N_("allow storing empty note")),
> >               OPT_CALLBACK_F(0, "separator", &separator,
>
> Likewise for the `append` subcommand.
>
> --
> Kristoffer Haugsbakk
>
Okay, I will do that. Thank you very much, Kristoffer.
