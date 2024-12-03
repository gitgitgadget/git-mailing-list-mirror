Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33C1F4731
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248767; cv=none; b=dZPVm5PjCT2iCIum7v3RDtfyXiZQeia65VYXdufPDKPaWW47vHJCddwrU0UgE2HR5cmA1z7fFlgGQ46hYHxVPA5SHGEMoxAHlG7W33kKN1omixr14WHwuNXLXEzd6WQZXEFTYuKRF5How8kiAU2H2GGhfeH0ddqwnAm+jjm7jmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248767; c=relaxed/simple;
	bh=CLszC0A2O/YIgjIRHUBnXLspXNvhj/VT6IhDG8P+0Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLlhTbNbbvT/FSxiktLoRsrt3mnCse77I8jzYIu4bDnVCHD3yGM2miAi8FqbTkaA2ot2LQ9QYMkPxsUDcZpxYd5XHhasmXGuZlX+vEk8pu+16O2S2wERGeyaEStYtZH3TqUlCSzcknoVlnOTeAgwczieqmUvUHUPRJ0vWjaTuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5jRXqWq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5jRXqWq"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so603a12.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 09:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733248764; x=1733853564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuQeX6ImXuNV49rAnw++nbjt+0glTvZEFiKCu46xZKY=;
        b=l5jRXqWqj3UvMtblIXoTJLpb/ZlSYxIYB6JHHr4812+TuYavkvsTtIG8oqYOBZSL7j
         F5LaBtr2UOA/iELBbDps18ERoP+eGB0XMpAtaDg6pJT0tLRM5XjRf61y75FrwptlQlqf
         3A21PDmRFxBPrZ50VK/ZQ1Nems2m2gOsQfCYOS+mmrvTYYzzeVX3RBIn6Q32h9AXV5jx
         rV9BP3cdEOmoRKJL+3+egVN38jiiGbw5AU3FjdgODivOUtrc2FsSk4roWofHuox0W+HQ
         LY96dVcqi9ZzLF5Lq1DIlg7AgichJqKlk0j4QJzY0akDTBGkyfgX9ymryzwWvXDJlBJ6
         d1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733248764; x=1733853564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuQeX6ImXuNV49rAnw++nbjt+0glTvZEFiKCu46xZKY=;
        b=GtfpHr0mIVEoj0XkxIuOsONBVjCTs0t26KSgA0XAqsfAP++8B78Y+1Wrv/XltiwX3C
         NR0g+mzmucUvNs5FbGcBOaul+/Q7A02x6IDmZlNEjjv2Nqx0s2bcVrklNfvh3R/UevuV
         nnWY9vM+5NMx5tD4ntdo4LfWA8HKZhlY/Wewatg5Ci1/ZwPYfdh8KFF32HKqAUaY1xaI
         m8oRVFP03d8/wJ+qh/vlrSKdV5Vo8hMG+xg7bovIxvQihS70ktfjspB39XtMsHWdw7AT
         SIYvFjIRLhHH1QdgAv2KMPnBEpjmk2BMbjF0aS1uszUxCBnXCU0kqJCpfFeKes56ndJE
         lOrg==
X-Gm-Message-State: AOJu0YyEdLb4OSYKOeRM0Q2EW7OuizXqr7SCCVRLY2JJei0Te4t0HD/S
	9zsqZ7eKqgB5OoH5+NHCI9y0bt+NtA32DJT6EAMrexJwMbLd7L5FSXN5YJRZ/6g0BoWy+NIjOXB
	3zzctIJQZZsH0KNprM4k8bmK1M87JrPYLLmWB
X-Gm-Gg: ASbGncsZiV9/J7Wp6RmND3kQYhEoKs39a2JujYBoW7URRTuRPkT99ddoOMCB/hN6mmx
	NtppiKP83ZN77HV7Kw8ZRbc+6HZC/w3yCSnx4Hp7P6x/TGeEtX3Qi+NFAbspz
X-Google-Smtp-Source: AGHT+IGYjigFfovSkDfSrY66PxYz6SfoSMfk4Nj+N2wvA9URUjWQX4yDb1Fw04ItbKS9TOhdHnWMggKUOrct/6ezKcE=
X-Received: by 2002:aa7:d5c6:0:b0:5d0:dfe4:488a with SMTP id
 4fb4d7f45d1cf-5d1069fb980mr90333a12.2.1733248763551; Tue, 03 Dec 2024
 09:59:23 -0800 (PST)
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
 <3bf4e4bc-c807-4bbb-8920-afba077413b4@app.fastmail.com>
In-Reply-To: <3bf4e4bc-c807-4bbb-8920-afba077413b4@app.fastmail.com>
From: Kai Koponen <kaikoponen@google.com>
Date: Tue, 3 Dec 2024 12:59:11 -0500
Message-ID: <CADYQcGrME0wDrhDu6HQsX2Vo7A3bPPr3Ooio3bBFcBg6XaHuYQ@mail.gmail.com>
Subject: Re: [PATCH] doc: mention rev-list --ancestry-path restrictions
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies, I made a mistake while copying the patch in manually from
format-patch; my git install doesn't have send-email available, I'll
fix that.

On Tue, Dec 3, 2024 at 12:39=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> Hello Kai
>
> On Tue, Dec 3, 2024, at 18:14, Kai Koponen wrote:
> > The rev-list documentation doesn't mention that the given
> > commit must be in the specified commit range, leading
> > to unexpected results.
> >
> > Signed-off-by: Kai Koponen <kaikopone@google.com>
> > ---
> >  Documentation/rev-list-options.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I couldn=E2=80=99t apply this patch to `master` (cc01bad4a9f (The twelfth=
 batch,
> 2024-11-27)). It looks like it is because..
>
> >
> > diff --git a/Documentation/rev-list-options.txt
> > b/Documentation/rev-list-options.txt
> > index 00ccf68744..f0a46f9da5 100644
> > --- a/Documentation/rev-list-options.txt
> > +++ b/Documentation/rev-list-options.txt
> > @@ -412,7 +412,7 @@ Default mode::
> >
> >  --ancestry-path[=3D<commit>]::
> >   When given a range of commits to display (e.g. 'commit1..commit2'
> > - or 'commit2 {caret}commit1'), only display commits in that range
> > + or 'commit2 {caret}commit1'), and a commit <commit> in that range,
> > only display commits in that range
>
> This line got corrupted (linebreak).
>
> I see that you used git-send-email(1).  Did you edit the patch file
> manually in order to add the quotation from Junio below? I=E2=80=99m gues=
sing
> the editor then broke that line since it is 102 characters when
> combined/joined.  I guess you could use cat(1) instead.  I like to use
> Git Notes.  You can add a note to the commit and then use that default
> namespace (commits) when making the patch.
>
>     git notes edit
>     git format-patch --notes=3Dcommits ...
>
> Although in this case it might be better to add a linebreak since the
> line gets so long. You can add one short line so that you don=E2=80=99t g=
et the
> reflow-paragraph problem from the previous version:
>
> (these are with space indentation instead of tabs)
>
>      --ancestry-path[=3D<commit>]::
>             When given a range of commits to display (e.g. 'commit1..comm=
it2'
>     -       or 'commit2 {caret}commit1'), only display commits in that ra=
nge
>     +       or 'commit2 {caret}commit1'), only display commits in that ra=
nge,
>     +       and a commit <commit> in that range,
>             that are ancestors of <commit>, descendants of <commit>, or
>             <commit> itself.  If no commit is specified, use 'commit1' (t=
he
>             excluded part of the range) as <commit>.  Can be passed multi=
ple
