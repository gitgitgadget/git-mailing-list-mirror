Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC157143759
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257291; cv=none; b=LEoCkahIa+YGRuzQxrehaQY5e/pXr0MF2D1Xs+nwoiVQ+VXCuVMKRbJp4tWh4EfpN35SqwVQpY0GybhfopqBzs1hbEfqHW/8XUZRWPh0IRGHKYE4wk8TWJTzqA1Nf/grb/vfH1JD9dMC7AcFG1E6ol/J1QD/sxy3piecNElql7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257291; c=relaxed/simple;
	bh=hjlzLUbMIZa2C0W2RAF51h+Xzx1iX0sKUHnuBLJ11oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKxvlud2wbcfMEkyC10d772w2TXtY/l38kc//zngveh/EnX/qAlyTmqfxnDOvJz9a88sgqMpPRbyk0WVh3DPWd8IxHkbvqEY8OICmigyAEwcuNumWV7ryW/v6caV0Uqj2wZXUvanZpAIm2aErIYsIzosOb+YKCdAfz4jD/HDmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R1Q6pytb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1Q6pytb"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0aab1aafcso2149a12.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 12:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733257288; x=1733862088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIc7eHvylaO2nJfyNars7aN1wSGLK2DriZAB1HljwBs=;
        b=R1Q6pytbDJKYn7nyuzhGStynMHbb/yYK1JjJbjT34i8l3y7990E/FHdpYOTe8o5hmt
         iT/Y03hBLavLAM712PnxvQYHgW5g9zZPNlkosBb1Lhca4X+fbSdByGAksaQHURfgcMav
         34qp+vaK7Mf3vLwb08u8ksAv5DJ2bkUlRZJ48ZbKo7YGS1DW59hJ5rM+Pw2N6Oo8aZ9h
         GmdEdOffqv+H0Fs8zv3MQ+udnGA6ZJX1A/uq+wIzJ3ygumGoOB/davKY7rFrLedL3ewl
         XD1vP0iNddAtHrHjdKSWqAEthpqGrH8inRPsVyCbEUBhU67rzfjaQNIjKdEFsODd6vvd
         2SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733257288; x=1733862088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIc7eHvylaO2nJfyNars7aN1wSGLK2DriZAB1HljwBs=;
        b=FsBEDDRC8sIiVyXQHA6174yoojXwxHJjBrkru1Xhj0WcztLuOgBhB/GgMX/A7PJFfU
         On9Wp1NR9m10WvwDOgnlIaNOJiVKzdrtTfhAbvO+KA+SAaoAJO0c380lv5QigAg3qlTt
         hpJBioF03Lp0Ci9I9qa7cpX0C0coV3mPAsehmbItxNMpigsAIG+OTjDDYOwGMPkFAsYf
         CKvTtefvMz6kr8kaz1rL9dWFBrFoQzNtPDDfRmJza70c6Rs/idXJnwDeJaGq6H9z3+kQ
         k1rLV5cBpymn/+oz41QyRnz1vNDJLnGjdBL7Z1r5KF1mut9TO2SSiErgxHh+1SPhIG63
         IQLw==
X-Gm-Message-State: AOJu0YwOaSOxbO6SlkDMt8kcxbwTrYHAqdrDenoYuEpedka0GwLWjK7x
	t7oa2s7fM9UbGbmwM/3aMpMSQDu6SceBPxfik7QjueTgZF+Pe1mG8zr7I4+6wRS3/QPy0Iu4Q6M
	j7h5OHUOXlaZJ0raLGgua1qo/Eg3hZf84p2KL2uUzAJ2CFM9wke6/
X-Gm-Gg: ASbGncsDP7J8410P/Nqgd/rihJuz13U8E0vLihgKBlCWEKpKyCyN8vj+EGOBOzcbLt1
	CLXMTWyNYj5sTqB/UtmEXrCAeEonNCoyrLRx1JPQA6MBXaTco/q4fxv/PAje5
X-Google-Smtp-Source: AGHT+IE3uHyEPQ+RXApI0upvTrziNhR4y655KDzoV+LMSNSkeik6jPLrBIr2C++4qDUo2Vv3MeUEg00oFW+AVbyJ9Qs=
X-Received: by 2002:a05:6402:3191:b0:5d0:dfe4:488a with SMTP id
 4fb4d7f45d1cf-5d116933b9cmr16129a12.2.1733257287891; Tue, 03 Dec 2024
 12:21:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
 <CABPp-BE1C2izp1a0Xm8_0KU+kas8XKejDyix+AzXqbCOeVp2Dg@mail.gmail.com>
 <CADYQcGpyTL18N2t8t-HwafB8VEVbBt452fsE0yMBvRvZd1mbVw@mail.gmail.com>
 <xmqqfrn5h8zj.fsf@gitster.g> <CADYQcGrD5KtM1sZQbccAtDaLmUXD8Gxv_nUWmapjfZm=TMq=Jw@mail.gmail.com>
 <3bf4e4bc-c807-4bbb-8920-afba077413b4@app.fastmail.com> <CADYQcGrME0wDrhDu6HQsX2Vo7A3bPPr3Ooio3bBFcBg6XaHuYQ@mail.gmail.com>
In-Reply-To: <CADYQcGrME0wDrhDu6HQsX2Vo7A3bPPr3Ooio3bBFcBg6XaHuYQ@mail.gmail.com>
From: Kai Koponen <kaikoponen@google.com>
Date: Tue, 3 Dec 2024 15:21:16 -0500
Message-ID: <CADYQcGoTvGBbSyiA1ZuS4Vd=gai-rLa=Vke4fCfFrbERJmP1NA@mail.gmail.com>
Subject: Re: [PATCH] doc: mention rev-list --ancestry-path restrictions
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Re-trying via GitGitGadget at
https://lore.kernel.org/git/pull.1838.git.git.1733257083739.gitgitgadget@gm=
ail.com/

On Tue, Dec 3, 2024 at 12:59=E2=80=AFPM Kai Koponen <kaikoponen@google.com>=
 wrote:
>
> Apologies, I made a mistake while copying the patch in manually from
> format-patch; my git install doesn't have send-email available, I'll
> fix that.
>
> On Tue, Dec 3, 2024 at 12:39=E2=80=AFPM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
> >
> > Hello Kai
> >
> > On Tue, Dec 3, 2024, at 18:14, Kai Koponen wrote:
> > > The rev-list documentation doesn't mention that the given
> > > commit must be in the specified commit range, leading
> > > to unexpected results.
> > >
> > > Signed-off-by: Kai Koponen <kaikopone@google.com>
> > > ---
> > >  Documentation/rev-list-options.txt | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I couldn=E2=80=99t apply this patch to `master` (cc01bad4a9f (The twelf=
th batch,
> > 2024-11-27)). It looks like it is because..
> >
> > >
> > > diff --git a/Documentation/rev-list-options.txt
> > > b/Documentation/rev-list-options.txt
> > > index 00ccf68744..f0a46f9da5 100644
> > > --- a/Documentation/rev-list-options.txt
> > > +++ b/Documentation/rev-list-options.txt
> > > @@ -412,7 +412,7 @@ Default mode::
> > >
> > >  --ancestry-path[=3D<commit>]::
> > >   When given a range of commits to display (e.g. 'commit1..commit2'
> > > - or 'commit2 {caret}commit1'), only display commits in that range
> > > + or 'commit2 {caret}commit1'), and a commit <commit> in that range,
> > > only display commits in that range
> >
> > This line got corrupted (linebreak).
> >
> > I see that you used git-send-email(1).  Did you edit the patch file
> > manually in order to add the quotation from Junio below? I=E2=80=99m gu=
essing
> > the editor then broke that line since it is 102 characters when
> > combined/joined.  I guess you could use cat(1) instead.  I like to use
> > Git Notes.  You can add a note to the commit and then use that default
> > namespace (commits) when making the patch.
> >
> >     git notes edit
> >     git format-patch --notes=3Dcommits ...
> >
> > Although in this case it might be better to add a linebreak since the
> > line gets so long. You can add one short line so that you don=E2=80=99t=
 get the
> > reflow-paragraph problem from the previous version:
> >
> > (these are with space indentation instead of tabs)
> >
> >      --ancestry-path[=3D<commit>]::
> >             When given a range of commits to display (e.g. 'commit1..co=
mmit2'
> >     -       or 'commit2 {caret}commit1'), only display commits in that =
range
> >     +       or 'commit2 {caret}commit1'), only display commits in that =
range,
> >     +       and a commit <commit> in that range,
> >             that are ancestors of <commit>, descendants of <commit>, or
> >             <commit> itself.  If no commit is specified, use 'commit1' =
(the
> >             excluded part of the range) as <commit>.  Can be passed mul=
tiple
