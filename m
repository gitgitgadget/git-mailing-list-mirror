Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C0186E46
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731159608; cv=none; b=rCHGemh/Bd3+rUWiFjHaMRxkBbAPEX0mJj2VutuEkI2hCiUPBeT3rOOpdKmeXA8fjYgM9xgPYXmOJ/Nc5NVsCUWIMk8vQRAsSIb+2aNitr0HAx98ZRjS4UsHh0i/hEkN409snN7usDI6Rb8D1hryi3sI9mQLV1zugZyyfWIxftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731159608; c=relaxed/simple;
	bh=6vau3nCFRg3oDk1CeC58764l4wPUm8EOAv87OuhQLsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKaSIq7yoblUTIeetrRaOR0Dv6v0mMJuva+4IL4daNsYQjM2AyKQfR2W9dqA2ngGGSBSI9dCSVSFRfyR7QG5Nn4Xmc77OSL2E8/AJPsK3kfnTxSshVYv4BjLqeD1H96QZQVbrbt80dA0X2FRa8PuLsPYNDjGp4plnhrf6+/QGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkjFGlVo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkjFGlVo"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f3f1849849so2203260a12.1
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 05:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731159606; x=1731764406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vau3nCFRg3oDk1CeC58764l4wPUm8EOAv87OuhQLsw=;
        b=HkjFGlVooVC9oL5VfGb6/Wro/HrNid9l2kyvC8REnb/ybp9u/qEBxNEeWxFhCYGJZi
         j0yW5+j+EmEBRBp7Tj/OGv3IupWIwGWAXa+qBUlZlFFlqprgzd3R4PZIywnMk7OmYO0D
         MKnZARhMF9+NbRCWX02imI5BwJIt0Amn96z1g66N4mNvKgrWQOAqI5daxnbspO+lve7k
         Y8J3uHRJHgRVN07dqPpHrjw6zpZ1s626FKSScV7qSrcC+SMrMyd9jgmX/EWZoGD1plnf
         BfRP7zCyijgRYE71Q7XYElq+bpKgoihQn50iDg2dKioVYbXHCsKafNlweYymubCuamzm
         /w1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731159606; x=1731764406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vau3nCFRg3oDk1CeC58764l4wPUm8EOAv87OuhQLsw=;
        b=XZM4wrgow+Tc3nYt7ioKp2HPtUuZna5zZQOz2CSFpElBNJZYagRVaYuAVOv/lgyOKt
         tfzepG+XymRgb8Dtwvqiw0Xx60Z4e9SIpAczhKongOuRfOGV9Ryzi17a2IGf/Fl+Wfvp
         Dy7KdGtOnbJ9xHpy/4slqkiZYt/no9y9ptotlz659dJUs4k7cTj2gpC5F6o88pckevOe
         lf3pMaIvh2h3VAXDV2zUurD7tZY2Q/0qcoyEOeb2oEzgisPxSO59TWLaahGWyRGIUZ4T
         JZ7aSlGhdHOKKxMGYuAyeuR3FzqR0D0sDtnjdbKUEzCv64gsNwfXeDVEM4tDkWokUlGW
         mhig==
X-Gm-Message-State: AOJu0YzJ61TowXx2fMihs2kfsFUQmZbMOK3Z9g5oU4coRLnc2UMwgGnA
	V5O3x/69wAN99gBmGVHUqBz3WGQWe2gGhTRBUg9UyC2BtBxGTLMBDHRXR/KVY5QhHlNovotEcjZ
	hOz8T0ifac1P1UBrMzpO8+bIlnD3K0/IT
X-Google-Smtp-Source: AGHT+IH3VM6rdcGu6/kKk34yt7rrRsJhQRqa76s9tLv5sVhf8rwa9a5HeZOf6ffxwupgw3AmQYcA3Vo2FuhRRcb2YmM=
X-Received: by 2002:a17:90b:3c50:b0:2e2:b46f:d92a with SMTP id
 98e67ed59e1d1-2e9b16824a2mr8667375a91.14.1731159606293; Sat, 09 Nov 2024
 05:40:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABg7He2asYQbdRvSvfh1YZ2FRPchVfvta8yBv4PFdVNnhzX6Ow@mail.gmail.com>
 <03c201db32a8$96e66e20$c4b34a60$@nexbridge.com>
In-Reply-To: <03c201db32a8$96e66e20$c4b34a60$@nexbridge.com>
From: Martin Imre <martinimre25@gmail.com>
Date: Sat, 9 Nov 2024 14:39:53 +0100
Message-ID: <CABg7He38ctGSx75HLw7xgu85nBUFAgwtxmJS4b5iBhGgoCu-ug@mail.gmail.com>
Subject: Re: Feature Request: Interactively pick fixup revision
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2context for all your replies. Please also see
below.024 at 2:09=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On November 9, 2024 6:41 AM, Martin Imre wrote:
> >first email to this list, so please forgive me if I'm doing something wr=
ong.
> >
> >My usual workflow is using `git commit --fixup <revision>` quite frequen=
tly, as it
> >eases the code reviewing process and allows for a clean history later on=
.
> >
> >One thing that is always cumbersome is to first find the SHA of the revi=
sion that I
> >plan to commit a fixup to.
> >I usually use git log and then copy the revision.
> >I even wrote a script that eases this process using fzf:
> >```
> >#!/bin/bash
> >
> >res=3D$(git log --oneline | fzf)
> >ref=3D$(echo $res | cut -d ' ' -f1)
> >
> >git commit --fixup ${ref}
> >```
> >
> >I don't think fzf is really necessary here, but it speeds things up.
> >
> >Anyhow, I'm really surprised that this isn't a feature of git.
> >I could see a `git commit --fixup` (without a revision) or `git commit -=
-fixup --
> >interactive` open up the git log and let one pick the revision they want=
 to commit a
> >fixup to.
>
> You might find that git rebase --autosquash -i <commit> might do what
> you are looking for. This allows you to clean up your topic branch prior
> to creating a pull request. Loads of documentation online about its use.
>
> Good luck,
> Randall
>

I think you might have misunderstood what I'm trying to achieve.

After adding a fixup commit, I'm anyway running `git rebase
--autosquash -i <commit>`.

However, my request is to get an interactive way to pick _which_
commit a fixup is targeting.
Ie, I'm trying to run something that pops up a pager with the commit
log for me to pick a commit that is then passed to `git commit --fixup
<commit>`.

If you have fzf, try running my script in a git repo with some changes
and you'll see what I'm trying to achieve.

Cheers,
Martin
