Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DA1EF36E
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759066220; cv=none; b=Josdpv/6Zd/VZCuYiKT7gJ7kdRv6Zfsxc0iea3sCWCMkqeC3DpoaAPwFUwWJVD3r9fja4hO78duft6thOVpJIgbgNveAnwO993XPPzTPzZEeMphC01+PBDnOiDh900C6Sd+m1SpBI7FM03ssEoZssZZNvllVUg8Ps/GqT1yeAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759066220; c=relaxed/simple;
	bh=/eaSPkdwZQBBixtJ+7m3iQOJVH3tj5EkbXsmD1Njzzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdXLxKykTD8km0jxXXh4sER8pLUYKw5yK9zhsebAMW1YhpvIL8cYRkWQD3Qpa6HgiFb7w/hsTs0x/DOIZBkfaEGhfMEn1+DDR2R1hMYUuMYAxkUBVstqhroDx6r4Uk/ch6b2XAq/Nigk7cpBjondWVcI8y5WsDvrNmv8lxax3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2pRr4/T; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2pRr4/T"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3635bd94f3eso35024461fa.0
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759066217; x=1759671017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Pd4REASvSqfWOUGoJEfv6s5EImkKSNBo78wdk29sIk=;
        b=A2pRr4/TX0tfo2LMgkl7Fye3Wi7H2eFqgDDZgP1pfMkuvbST8ep7KncwMBfqyDF+dm
         fpTmHLxqh23XWLtL33eIH/2dQD90IGYyU7QDtUew5tLkoxUKFpHUnCXRaMkluToSE72X
         RfyhgYbl5MvWTqsxMSJgb4de1JOTMJSxgYxAbeVGEn9xBEYV9Et6pC3P0XI/9txBduJC
         WS8DAfkKI7nduUP9QnrZ9XjK9AS24efNaQeQ5wWtia5Mh/39dqwpbXnCCb+AuuR0mwJa
         uw+SNcgmVLYKSMPG3ShdoMPuX6EOFzy+V5zepsqNvXB/U8Sc0qVCPaqjIAJi8TGc3YxE
         uOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759066217; x=1759671017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Pd4REASvSqfWOUGoJEfv6s5EImkKSNBo78wdk29sIk=;
        b=m82ew46JZyKAZaB1G8/p0BkQn0zrCHYqmFjiuJcamnHdIlMgOU9EHim0TWcPKYijMc
         IHBr7BO3s9iRto2tkXrPFXUFnPTiLTO/8rZQogC3am3LnlZE4SdVtEeNQjBDufWLLZ/G
         JGFOCbB9KYxEvgRYsw6Dcu5gbjhoc7ZNwttxJO71WZX2amSoi+ZmTAMl+TTvIL3WjP7i
         2NWH4HlrobLVm5b0bwJ4cK0t4hi3HWiQdoRamsPL25PtzDnHJTSImWa6Gsqe+qH6Ze1Z
         Dbz2EV7ZtNhfzk4ibA/HXJuW4sIPqM3xA7JsyH7umzhbwHGSSASe9b8bH3PH8+ciDCPV
         rKoQ==
X-Gm-Message-State: AOJu0YwivxWnKWRZ1Ln0HL1kz3rs2aSBDCWJZVmHsBBpgHd6lgqhm/d7
	CkfK4UVDDxxL2aPRDMXFsT+i38CIOxwfhAxJ9y4nE7cFRfOgtlmNd3HXHfUW3dIjLZ/DmznIOcN
	uYVrhL4YYRdkZXYd/JjDle/oRBo2xqSe8QO4p8NU=
X-Gm-Gg: ASbGncsC3SwxeR2N+SrFP8J/f4B0H13iIATN8RTPar+upoJEuw5tdS7tvdoLz5HRTFm
	9HpUwL5QdbKp07YdLXBD5QRc1kBdkaX/2I7NlkTUKTXBsNZqckcg2owHtuBJT/SUkLB/UZcHWPw
	bJJH1jXTTbX0Tq0sctjckQEIUHX5/85+h1BdRHJa9uy2SWoir5FcEDkxv1svNM3r9fFN8jcPHrC
	CSQzK0=
X-Google-Smtp-Source: AGHT+IFfpAxmv1ZlCTul/hL/SnR+uVXZRK//cvIRJvZ1OyjANK6TusL5f0PG5HQM7lT+0Xoc6lAEHcR0WA98WgVDzfs=
X-Received: by 2002:a05:651c:3608:b0:333:7e5b:15c0 with SMTP id
 38308e7fff4ca-36f7dab3512mr37681111fa.13.1759066216475; Sun, 28 Sep 2025
 06:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920184007.26183-1-rappazzo@gmail.com> <20250920184007.26183-3-rappazzo@gmail.com>
 <c6a33014-5d87-4750-b6ce-234e944131b4@kdbg.org> <CANoM8SW6gsfmhPYWq2_7f9DuwyQ4vVpbWkaPn4mDTg--LAZUJg@mail.gmail.com>
In-Reply-To: <CANoM8SW6gsfmhPYWq2_7f9DuwyQ4vVpbWkaPn4mDTg--LAZUJg@mail.gmail.com>
From: Mike Rappazzo <rappazzo@gmail.com>
Date: Sun, 28 Sep 2025 09:30:05 -0400
X-Gm-Features: AS18NWBf3nwdiIZ_ZrMhE1b_m8h1CJdz4y8orAVXXVfXmral93MMrkYApQRzBLc
Message-ID: <CANoM8SXnxxF6UMSfQ06ANfEv7HFCEEMCVoGgod1-DuFeHp6tXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gitk: make Tags and Heads window geometry sticky
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 8:45=E2=80=AFAM Mike Rappazzo <rappazzo@gmail.com> =
wrote:
>
> On Mon, Sep 22, 2025 at 2:34=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrot=
e:
> > > @@ -10249,6 +10256,8 @@ proc showrefs {} {
> > >      bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
> > >      set reflist {}
> > >      refill_reflist
> > > +    after idle [list manage_showrefs_geometry $top restore]
> >
> > My thinking without having debugged it is:
> >
> >  1. A Configure event happens with the default geometry when the window
> > becomes visible. This records the default geometry in geometry(showrefs=
)
> > by the handler that is bound in the next line below.
> >
> >  2. "After idle" the geometry is set to the then-current value of
> > geometry(showrefs), which would then be the default geometry and not th=
e
> > one restored from the settings.
> >
> > Why is it not necessary to encode the now-current value of
> > geometry(showrefs) (the restored value) in this after-idle handler? IOW=
,
> > why does this work?
>
> When I was testing this, I used MacOS, Windows 11, and Gnome (Ubuntu).
> On Mac the call
> worked without the `after idle`.  On both Windows and Gnome, it needed
> the `after idle` for it
> to work as I expected.  I'm not sure exactly why.  Do you want me to
> try to adjust this?  Do you
> have a suggestion for it?
>

Digging into this a little more, I think the platform differences relate to
how each window manager handles the initial window mapping and geometry
setting sequence.

On MacOS, the window geometry can be set immediately during window creation
without timing issues. However, on Windows and Gnome, there seems to
be a race condition where setting geometry too early gets overridden by
the window manager's default placement logic.

Using `after idle` ensures we set the geometry after the window manager
has finished its initial setup, which is why it's needed on Windows and
Gnome but not MacOS.

I will split the manage_showrefs_geometry function and send an updated patc=
h

 _Mike
