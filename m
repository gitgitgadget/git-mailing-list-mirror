Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9B31AF09
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825674; cv=none; b=Lkpq9L/zgltyDR2IkKIFU92s6RYTQz4uLqPnETm/UBhTGWXF1R6o+6pAoNFSNzF6LMIqxUl8eP00MDF4DK5vEgpnWKf+S4nyYiO+xQ0chiHRVlXKDgf651lcEPnnKswzXoi0NPo9KhV49Rxor0h5Q1J1l0HX0IXRntLTiiQU6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825674; c=relaxed/simple;
	bh=s60novMoyKigpTeF0h4voBQzHMxe148L0tiSHla2JHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFUN1XyAJHl/9xtaqcH00oHFAfclH3Leq7QyQB0/LPS4Iu5jQDWnl5NhGaVXQNhDdLzsCwU6XlBXfw4rReh7UcdV5LDcF0BUWjb7lAj7dFu+X+03QOrIVSQ0QMxfwkMq+SUcDAAhPyM1zHwc+4pyb5kUrzBgTsRjX+qDgmlopME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs05JhSj; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs05JhSj"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-367064ef8a9so10388841fa.2
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825671; x=1759430471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFYuzWpMpTc8Kp5jy/hYCHQ+XNNkjsihoQmBi+n8ug0=;
        b=cs05JhSjipgcntrhbTODSxDsZ4P4XQZ+Z7rHvlQNDLsGcDYraQeoboEPwFaPmpW7Zd
         RkCxplZbWOafHAxdtEvipa5kxZpvtWvNnEGrQ8yiTF3hTInuNWkb1matCuGoRJcQDepp
         Qzyo3B+aKhYi5Uut209axdZ6NkXHRgKe8Ca98nPIFkeOIG5cFEDZ/GNM1XRfTaZZLX6m
         IdkWjg0dTGXQ3Yb/0GQ+EUcIfpGujeSq3o0AIhKQeIj8rfIkDOlZo2DIvjybyOLZkNEh
         reIdfPsjY3fYwe8Q1jJy0IRrUAnV/3kmsJf/oZ9achoOPAOjilpdeEPnr5+xHb2Nqje1
         caZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825671; x=1759430471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFYuzWpMpTc8Kp5jy/hYCHQ+XNNkjsihoQmBi+n8ug0=;
        b=eJiKgXFMA7jE7lDvBev6P2fWtQ/gCZLRRP9loUWj27rsP6/9jwacUv693b3eIKfhUR
         i86AAHxsodIR2SzrcVrUD4ud1NgDWyPeiAWbdivICFYQ/EGDwMURHYD93siaXkTv3S0d
         krLzj4+9ZwqIxx2P/N6BmZvKSxIglU8mmOP6nuxVvDZ6AA5kR9EfCY2mYRF54msHWaew
         2ORCpIyGg3WTYUqFAoFZtXfBppSc8Hyd0MfqTT5kVaqvP80U2Vl7z0DH1KI9JHr9QQtu
         C5paOeJmsc/fUCOfHJUDN0lqKPD9iLomeW1udWU4sp10vzH/v1BZePav1Rx6hcHtc6nc
         bRpA==
X-Forwarded-Encrypted: i=1; AJvYcCVPTmuZZPppfYaSdyVEW2fQnB7Ep/YSSEcZLiQHbziEAqLnx/Jo4KFD+v7wficyMrQBLao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyFEuqTxgluz1BxTAscJ4nGxvthvYNfwIFvnR8jW+QSnaMhwu
	UwaSqT4sewkc+FZxdkXWYaeauu0ZazLmaFADc0V+EdBouNDBBYLDg5NT5oD4xBBXWLhQdoMLTBX
	WCL5BddEqQxJ24xHa60qWih46uHFpCupWtsyj0JTMHOn+
X-Gm-Gg: ASbGncs/3TnCBiAIVKDpwe3Y/6mXx37YO2soReCBrwdPZd6e4ChCpu73Ts3vfOoNEAG
	V27K2aaYdgYtak55OJXpKaODUafYAYQR7mxjuaWZQGNzWmsxZzYtOW0i61Ypmv9/mRYzRaEEVUv
	usgK4j+pN0mkG5bJATxH1fbuSUoyOs1yG+aGc2ODaU2+6a4358CkIYoUzGGtvZEj/+5JjzWCGBq
	aHSSIAf
X-Google-Smtp-Source: AGHT+IH9uu1lxKVr/at72B4X+u3uUJ9/uQ/KMzk9zUp4swb/VIdtJjM3JQzf8l8km0Jo5xQmbEv5haGuldbeZ+KWaao=
X-Received: by 2002:a2e:b88e:0:b0:367:5a84:bc98 with SMTP id
 38308e7fff4ca-36f7f934e79mr11307321fa.30.1758825670864; Thu, 25 Sep 2025
 11:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com> <08a0fceb72b2bd0a2803d24b9874b7f9bd03703a.1758662670.git.gitgitgadget@gmail.com>
 <311f7dbe-b970-4a5b-9d53-05f019cc54cd@gmail.com> <CAH=ZcbBcEbTqQ-FpYSdr_QjSM5sKerECKsSVdTyHoSQqG-V9iA@mail.gmail.com>
 <1c3461c3-09bb-404d-a4dc-a895baba68f2@gmail.com>
In-Reply-To: <1c3461c3-09bb-404d-a4dc-a895baba68f2@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 25 Sep 2025 12:40:59 -0600
X-Gm-Features: AS18NWBDcBfCgGMqV837U6Iz_BLeWp4OrQDkAzIpK2zX7Rj5w8kc4zhKiZRaB0w
Message-ID: <CAH=ZcbC-cB35AGmiKgEQdFa5ee+DftwOQ_dUe4=T+Vq-dxR+qQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] xdiff: use enum macros NONE(0), SOME(1),
 TOO_MANY(2) in xprepare.c
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 9:18=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 24/09/2025 15:46, Ezekiel Newren wrote:
> > On Wed, Sep 24, 2025 at 4:21=E2=80=AFAM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >>
> >> On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> >>> From: Ezekiel Newren <ezekielnewren@gmail.com>
> >>>
> >>> Rename dis1, dis2 to matches1, matches2.
> >>>
> >>> Define macros NONE(0), SOME(1), TOO_MANY(2) as the enum values for
> >>> matches1 and matches2. These states will influence whether changed[i]
> >>> is set to 1 or kept as 0.
> >>
> >> This message also says what is being changed rather than why it is bei=
ng
> >> changed. I think the rename here is a good idea but I'm not sure what
> >> "rdis[01]" and "rpdis[01]" are used for and whether they should be
> >> renamed if we're renaming "dis[01]"
> >
> > "Rename dis1, dis2 to matches1, matches2 to give the variable names a
> > more obvious meaning."
> >
> > Would something like that work, or do I need to refine it further?
>
> I'd maybe add a sentence before that to explain that "dis1 and dis2 are
> used to record if a line has zero, one or many matches on the other side
> of the diff". I don't think any of these patches need huge commit
> messages but a couple of sentences explaining the reasoning would be
> helpful for anyone looking at them it the future.
>
> > I
> > would love to rename rdis, rpdis, etc... except that I don't
> > understand what is happening or why. Could someone explain the purpose
> > of these variables?
>
> Good question, I'm not sure anyone has an intimate knowledge of this
> code. My understanding is that the code aims to remove runs of common
> lines when they occur between unique lines in order to reduce the number
> of lines we need to look at when we're calculating the diff. I haven't
> worked through the code in detail though.

I'm really struggling with how to write this commit message. I would
very much appreciate suggestions. Here is what I have so far:
--- commit message start ---
xdiff: use enum macros NONE(0), SOME(1), TOO_MANY(2) in xprepare.c

The local variables dis1 and dis2 describe how a line should be treated
based on how many lines, in the other file, match this line. NONE means
the other file does not have any matches to this line. SOME means that
there are more than 0 matches, but less than some heuristic threshold.
TOO_MANY is when there are more matches than that heuristic threshold.

Note: When need_min is true, matches[i] is always set to SOME when the
number of matches is greater than 0.

The names dis1 and dis2 don't convey what they mean, so let's rename
them to matches1 and matches2.

Define macros NONE(0), SOME(1), TOO_MANY(2) as the enum values for
matches1 and matches2. These states will influence whether changed[i]
is set to 1 or kept as 0.

The variables r, rdis0, rpdis0, rdis1, rpdis1 in xdl_clean_mmatch()
have not been renamed because I don't understand their purpose.
--- commit message end ---

I'll explain the parts of the code that are relevant to the commit
message with an example. The following snippet goes through every line
(matches1[i]) of file1 to determine what matches1[i] should be by
looking at the number of times that line shows up in file2.

    if ((mlim =3D xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
        mlim =3D XDL_MAX_EQLIMIT;
    for (i =3D xdf1->dstart, recs =3D &xdf1->recs[xdf1->dstart]; i <=3D
xdf1->dend; i++, recs++) {
        rcrec =3D cf->rcrecs[recs->ha];
        nm =3D rcrec ? rcrec->len2 : 0;
        matches1[i] =3D (nm =3D=3D 0) ? NONE: (nm >=3D mlim && !need_min) ?
TOO_MANY: SOME;
    }

The lines:
    rcrec =3D cf->rcrecs[recs->ha];
    nm =3D rcrec ? rcrec->len2 : 0;
gets the number of matches from file2 (i.e. rcrec->len2), and then this lin=
e:
    matches1[i] =3D (nm =3D=3D 0) ? NONE: (nm >=3D mlim && !need_min) ? TOO=
_MANY: SOME;
Is the logic to set matches1[i] (the line in question of file1) to
NONE, SOME, or TOO_MANY.
mlim seems to be some heuristic threshold based on the XDL_MAX_EQLIMIT
constant which is set to 1024.
