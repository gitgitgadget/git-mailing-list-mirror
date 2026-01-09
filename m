Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BBF2EC0BF
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001073; cv=none; b=PQOODlkq5T+Cmn8IXYkWBfZnytVFOeYGCatKlXykITO/8PTO//LjfDfbZNncsv2Yfi4HqEmShdO5JGzD0SyQ05EQl0O2+kOy8Ks0V4F2fipNX235XjqyYX4Vj86RK6+pKw6s4aiWxQlD522TGQIHxJZgzUyTxE6dXT26W0z7r9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001073; c=relaxed/simple;
	bh=Ezpe2QMr5/VOmnNuYaDnVEI6q36v42JaBzOmLjfc5I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7CdsjjbFyiiPxqPvMZjsT/j1Adwc/7x8iYRlTrmd4EauwkQs+TRzIgcfsnUXizpXFMeGC5UHayxXX7HubjdZrmiVuWrd9BtNsTLXlTPrPD56xpSYSZ6bHNTj5KJGA4J33vHWIca1ccI1NczkiOqaYAHMzBtywuXGmQlCu+znj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIlXZNGt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIlXZNGt"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0834769f0so34525875ad.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 15:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768001071; x=1768605871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvypave6IbHbxXmbEBPNNt7f2Puf+FY9s/ZGnLWySGI=;
        b=EIlXZNGtU8n38tCgIgqXefeCLdIARna0wJCwyH31I/zWqAJQjDWli4dqDB6jdEXUns
         pKZR2xAoUqi1leHd3mcsiqg7D4CsxDi5+tk+9F863FuZTt4IBfnhEWG8En/r4LfemX2u
         clqqC6w2POO976VHoYJa9+PVNrJMVbroj1PbOpnK7DwhRwws/VrJdkXXfuyuBnQ2yIFk
         8iPiotAC92zlrwYKAS9FxCNcKOfnDmN6/6te0LWooFqzsNtFh7/N+ZU5QfJsXPSspVVY
         UAsLSwWWIaM9eeiiPQ97hFvlur2TbAMAmup7vVNyICECAfJTfmZI5LBgfNo4WULPeafG
         0Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001071; x=1768605871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvypave6IbHbxXmbEBPNNt7f2Puf+FY9s/ZGnLWySGI=;
        b=DFfIz9Z0K941tIyCWsClrzfokCaTwzlATILAigTENw8Yi4P4dKBRyEM74KrzBEQP0j
         H9qSLETqEzN0iPJjv6IfKtvvjtuYDpHGLu86EZd8UffFWoRnI4zIW0dVrQybyFyVpa7a
         BEVOCIuQWAZlMdhEX/tNm/pEbvDb3kOaHfE5u6+q6shY6hXhGFMV0kWf5p5HxO9aZd2O
         93FRv4W8ZK8JYM4Udn36e0N7t7kyliExof2RIyVnOw42jJN7GnybJK+HHNGcw1eglxlm
         SYCHfpqc1p29CZ01dfgP/7CrfyyUP97gtJKsIZgJpNx1dVSG4odEmgEymc0Q1bK5YUzl
         z6eA==
X-Gm-Message-State: AOJu0YwUJ95VlduTicRnV4lMFby8huNfG5GDwHX/xHUzPfLFaUJ0ItZL
	TeEtd67XnMiZTIObJc2/D6uIJqkUngDMpmDmn11fmrPV5OsJtLDPkRKxyzZ+dKibUxYXsofR+e3
	CgQwzJLLgUtHF7h6WDjVx5SDyYRgVFFI=
X-Gm-Gg: AY/fxX6x2MVkx5rsBAQnKcF/c3nDac26c2Ly4O2FrH0/3v1RYffnESMTwH7j/wL+osQ
	x71Mmgy2n60A8Q2HjWU2hdL2k2poF3wOYapmLppiiCS+GKNHjoBJvGM8VKuxaMXpDyK+oFYZDIk
	s7DLkUwtZWAGFBS5qn3IvaouB9MWiXxArGcoyLmDCeolMcBCAG45GBw2C9rika/meNqY4K7zg14
	03v4/QO07L4DPOwSBYgQ84rxnOsasH8+VX6KTw6dEk+cNd04meWVRiupvvkSiCHLeFyfnrXU9GF
	rwmaeJOTsxZB+lpBIFLA2QUDEmKMErz8i84HMR+iAV1PIihZN2F+NhnuS0hwTA8DOaas+y7WKfF
	jGzw=
X-Google-Smtp-Source: AGHT+IHqORfuIpQqJBNiLPAmkyGXFKjzUs2FZRP2wiJ1Xk089bgFxVP8sAsc4pH4aMW+5NJMwP7xXrH3DOz+qRQk6f4=
X-Received: by 2002:a17:903:2f92:b0:2a0:8e35:969d with SMTP id
 d9443c01a7336-2a3ee490196mr97827155ad.39.1768001071399; Fri, 09 Jan 2026
 15:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
 <20260107-b4-pks-history-builtin-v8-7-18e9779e3a26@pks.im>
 <CALnO6CDG222mhCeWyBCpGU3fQiHPVwBh=5EygRFrFN3JOcx6Sw@mail.gmail.com> <aWCwOjKG_ZwqPCpz@pks.im>
In-Reply-To: <aWCwOjKG_ZwqPCpz@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 9 Jan 2026 18:24:19 -0500
X-Gm-Features: AQt7F2oAsXtLTaQtxa2-TJMpIzX_vuMwG76w_CY0XV_4zog82GV3ClboiXt2Az8
Message-ID: <CALnO6CAqMR_AZ-8REj-u89fNHBj-pmxre-Yr53CHPQDf_R_y=g@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] builtin/history: implement "reword" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[I think this is present in v9 or I wouldn't bother following up :)]

On Fri, Jan 9, 2026 at 2:37=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Wed, Jan 07, 2026 at 01:01:11PM -0500, D. Ben Knoble wrote:
> > On Wed, Jan 7, 2026 at 5:10=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > >
> > > Implement a new "reword" subcommand for git-history(1). This subcomma=
nd
> > > is similar to the user performing an interactive rebase with a single
> > > commit changed to use the "reword" instruction.
> >
> > > diff --git a/Documentation/git-history.adoc b/Documentation/git-histo=
ry.adoc
> > > index 5a9d931efc..4eea317e5c 100644
> > > --- a/Documentation/git-history.adoc
> > > +++ b/Documentation/git-history.adoc
> > > @@ -32,8 +32,9 @@ Overall, linkgit:git-history[1] aims to provide a m=
ore opinionated way to modify
> > >  your commit history that is simpler to use compared to linkgit:git-r=
ebase[1] in
> > >  general.
> > >
> > > -If you want to reapply a range of commits onto a different base, or =
interactive
> > > -rebases if you want to edit a range of commits.
> > > +Use linkgit:git-rebase[1] if you want to reapply a range of commits =
onto a
> > > +different base, or interactive rebases if you want to edit a range o=
f commits
> > > +at once.
> > >
> > >  LIMITATIONS
> > >  -----------
> >
> > Ah, looks like this commit fixed one of my befuddlements during the ran=
ge-diff.
> > Bad history edit? :)
>
> Huh, something's weird here indeed, the range-diff and the actual
> changes do not match. I use b4 though, so this isn't an issue that was
> caused by weird manual munging of patches. Hum.
>
> Well, I'll not go down this rabbit hole today :) Thanks for your review!
>
> Patrick

What's weird is the pre-image, which comes from the patch right before
it. It seems like an incomplete sentence that could be dropped from
what I see in Junio's mirror as baf46a880d (builtin: add new "history"
command, 2026-01-09).

--=20
D. Ben Knoble
