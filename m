Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F58479
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737400111; cv=none; b=APYiPrFWJLe4AqwwP4xPKxWRfs8Du5w75IqjXQm64Hs/1gGM2ohAg9mJcJC+dpQiKXr+9d4ZFy9yzL/lagWc/CUHeGJvaqf6W+kA26rpiG+XKFrQlhWpCuORJv3QMHgy5dy9ejjeyCMIVZDPf44LWZs3FlMZVqw4a6u3zXI3NgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737400111; c=relaxed/simple;
	bh=o++7AoS5HpCnD1SeeHl47pBVP+QPuRL7xGJE5tXKNHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHMxkwIelKCLvCSAZOfIPbDCsb4Icrjjm/Mo9Xc+jTdjyY8s7zqDQEbroOwQwPoDJL2tw88UI506+QO+1I7EPwTWyDe9Na8zy+ywCEccuuEcqd+GRS0G9tBVa83dBNRsS/GmKCJtQNZB4d+FwfmGJR1Q+4ePTSYsgZ/TwKFLuAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvArigWR; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvArigWR"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4b6398d477fso1302977137.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 11:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737400108; x=1738004908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNVMlDA4sU/k3yCASRHnAwoN8AH47b4IvFyTBQ95dsM=;
        b=HvArigWRv/FT7pwI2amXZgB7ACb6Er4VjVXgvXyoILDvXLJk78PccvQlRxLDUapTYh
         YKAJRfFABd1qvAHltDzOOFdNSDgdL16I94lVNFd7n7rv9/GExH6yTrb8njK2ImVFjCca
         guZ+Z9iWgq6moKLu512AahvsYOgr2ZWZSOrF+N0KlJN6z+/KMMCfqqOhxIu6qXFiSeQI
         z/1ayTiNaYPXLCrw+hZMGLfqtaxfyc5VsLU3Tbx6CvC/JYRIuBGToV9c+cGCZjbBjVHO
         2TAv1k74viTB6lzbPqqIUcu+o2jXGCT02JR9BBlhL9dsp+Zn9awNeB64V4qw5wGRrJk9
         ApDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737400108; x=1738004908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNVMlDA4sU/k3yCASRHnAwoN8AH47b4IvFyTBQ95dsM=;
        b=D1wtLz2BcEtFiBNEDN6d9aiMjCEV6obnsl1K25nvfqIkbxMa2fjySsXhL3OaoJtpeU
         gizzXRXgeMikDBwi94qq+2UP+aRU77aIjUPZO5D+YjTwrSCW9x0+w6+43ZgMWJjUEg4Q
         uN4krgJpJf78m/N2xONfdKhg6UX3AbXirwquiDxCjnU6mPdHS4PnW9bzw0Z94GQl1rrn
         albHcKCTmaB4SYRE67mKG6oZdmWG9RnAlqIIBGyfqYaNQOTMZ5Lr4PfI95/h8YfYbyS3
         HX5vAdLsP9G8IcZnjs9u6/G+QvyP0LRrv7GkVX3a5/xUw4WiSMco5xgI83TIq+KX+RJm
         eKhQ==
X-Gm-Message-State: AOJu0Ywhnx5gln9jF/y8Vgn10CA3s/tb3E0an/M8km5hrlt8AyuUcSUQ
	HX52zB1VywYBwkoCMAExiyHf5nEQ+CoFH7TnXh8IIA7av4yR1XgTSSWPvnJh7w+GFIzd55OQkI2
	aIUMBk31S80JkaRbXdekqQ3xiANM=
X-Gm-Gg: ASbGncuxBepLz28h7nauDKz0ntSELwn99D21vcif4aCj+2fE/JvAORvwi2ZHLY+0IPm
	YucmDHTwELttwc0/fFvPAOasl5tK61zKB0k8qqEwmlhKoQrddi4E=
X-Google-Smtp-Source: AGHT+IFUwsLoQJ9hURRX6ABPRNaRYtQTJlYArVrV814DsZ1hIHC6nnNI1y3jezq138Dju/BUzhKl50CavB5w7c1OcBM=
X-Received: by 2002:a05:6102:c52:b0:4af:c519:4e86 with SMTP id
 ada2fe7eead31-4b690b988b7mr10010031137.1.1737400108702; Mon, 20 Jan 2025
 11:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com> <20250117104639.65608-7-usmanakinyemi202@gmail.com>
 <CAPig+cR6oCLw5h78NTrxDztTCLn4eseidk7wBc3JgVzKEE3+zA@mail.gmail.com>
 <CAPSxiM9Vm7DxDeneTvWLYaZnPK1Zpk79xfcH5US7-+R39v-i7g@mail.gmail.com> <CAPig+cSE=2jZvTUHsBnRRMizC3pxRwyud+TGDV7iw=QNmFmycQ@mail.gmail.com>
In-Reply-To: <CAPig+cSE=2jZvTUHsBnRRMizC3pxRwyud+TGDV7iw=QNmFmycQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 21 Jan 2025 00:38:17 +0530
X-Gm-Features: AbW1kvajPjIHYLZ5g1Ra-zNIdCS4w_phEkyuQ-6Qj_BrjEAZozYbWoKawgNvLtI
Message-ID: <CAPSxiM9QoCy7e+R9GAoELP1i+bssPoq2ogXPnbW59-ta6wjdoQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] version: introduce osversion.command config for
 os-version output
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	ps@pks.im, johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, rsbecker@nexbridge.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 12:11=E2=80=AFAM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
>
> On Mon, Jan 20, 2025 at 1:17=E2=80=AFPM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> > On Sat, Jan 18, 2025 at 3:14=E2=80=AFAM Eric Sunshine <sunshine@sunshin=
eco.com> wrote:
> > > On Fri, Jan 17, 2025 at 5:47=E2=80=AFAM Usman Akinyemi
> > > <usmanakinyemi202@gmail.com> wrote:
> > > > +       if test_have_prereq !WINDOWS
> > > > +       then
> > > > +               printf "\nos-version=3D%s\n" $(uname -srvm | test_r=
edact_non_printables) >>agent_and_long_osversion
> > > > +       fi &&
> > >
> > > As an aid to future readers, please add an explanation either in the
> > > commit message or as a comment here in the code explaining why Window=
s
> > > is being singled out as special.
> >
> > The previous commit which introduced this has this information,
> > can we do some form of referencing ?
>
> My main concern is that someone looking at this change in the future
> -- who did not have the benefit of reading the cover letter or the
> review discussion -- may have a hard time understanding why Windows is
> singled out by this patch. As long as you give some sort of
> explanation, whether in the code or in the commit message, then you
> save that future user from having to figure it out on his or her own.
>
> So, your suggestion of referencing some other commit may work.
> Augmenting the commit message of this patch with something along the
> lines of:
>
>    As with the previous commit, we skip the tests on Windows.
>
> may be enough to tell the reader where to look for the explanation.
Yeah, thanks, this looks better and clearer. I will add this in the
next iteration
if we agree to include the osversion.command config.

Thank you.
Usman Akinyemi.
