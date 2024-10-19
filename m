Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666AF18DF6F
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729329212; cv=none; b=LY7c1dT3BxpWJ35EDhWvgodF79fHlsImIzFQW2fw83s9EhVSrtG4UleVZ92UX56+Xz9w9F2cmT9XD7w8beOSBpnkEfIcxp4pYh9zTaHI7UKUZIrcEmY9vC+85nZonIsImUi1DoA1fVt8LbuXPPg9ztSUJf8MHeXmpcssd/NdSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729329212; c=relaxed/simple;
	bh=0jwiDYGgu8Udy8ZQh3lwhrIBAj/maMZXXczqL5psvj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edwUGo+YM3XZ1lNZi8b1Q/XZ0LSQ8NSXyeod2aTb/yRveEGa3SoybVBSF3b+7xVS7Y6+JDqKN+lJ643etlDcm+oqNdNNrhEqKPfJDXeUzPIAbQaRB9FMxYffpyllsNkHX1WhEO2biMc7u5oLL6DN4Qs/msY+2iKwAtKUKQH0Z+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqRcJi4K; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqRcJi4K"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d7423ec6fso52773e0c.2
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729329209; x=1729934009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jwiDYGgu8Udy8ZQh3lwhrIBAj/maMZXXczqL5psvj4=;
        b=CqRcJi4Khs82h7C+coLASyPB14/Oqo5N2h+2X+HGDy4IyGR6d4bbOabmgPXthsQYa/
         7UA7+6tYzmPM/0RA+kIXj2EnA2mOt8HdN2owmYsWQQnanbp8V4KhuzhachBIN4Ru5thg
         LujIM/akcCYQjXMy/Zj33UsuZogFDyxCU0bbRIpMYquEMHecBhq6ljvB64QL6qQZdExM
         FaKPwiDQdMYD59bSvm6VEebXG2vgH9cGj8ewWPsU8DkqEDpr/9BspuUvgamM2VsNx4/g
         aoWrkZ2LDJL8dmlO36IWAS47+i4hfpwm4EbhXkRKY0PIMoEDx7KhbWOxllluvzsphqCg
         ZAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729329209; x=1729934009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jwiDYGgu8Udy8ZQh3lwhrIBAj/maMZXXczqL5psvj4=;
        b=wKq9q5DJns+E+bKJZYu38kE5JXWTn/w0LknhA6aOStR0wiTxMJ+j+4QdNrIiYsU1Bi
         akGId/6msPwWu+3X1v3eE2w/I7YlNpygxe5lyQMuR7OrxxfSWaiw8vAQKtzYO3QUXu2x
         fj+refEO4GiJgqsysf6aSxU21GjOhIBUaBZc1DVGOaJH7IQp8O6WEVVT/Y+OxLNWoF02
         e4TzjSXRrANDX8DtMUhY1a5gQno8O6AsTosXEafrUgm6WvVc22gjsIcfw4z5R2gdgyEr
         cAp3KmVQje6+61pU1AhN3Wxh3XP8Cb/iI/HPCYwoG9DB7j6myyLHf9NbuVrztOgtk/vu
         dHsw==
X-Gm-Message-State: AOJu0YyFMO6UFRA1QNYHwpVtFSC7ZIKYHE2ytElXYyHjdArHRJyIzbWx
	vsWvvQodvYUShIRLZwtxtw6Vp7SIhOINnaq9JNdRizXeKHgbRM0/zlNmCIPhIfhzobbsowaxBZl
	M6BreXnoOcgrx9DDGFdJXCqyA0Wk=
X-Google-Smtp-Source: AGHT+IEmiWFmePL504t6wLwBKGJBNP+dHsfTO6V5i9eHiPuopcuZMHXYPJ+LDhQqjYm8bltres4skfo2r705z2JLQZo=
X-Received: by 2002:a05:6122:2916:b0:50d:23ed:d054 with SMTP id
 71dfb90a1353d-50dda39fc0dmr1530865e0c.2.1729329209198; Sat, 19 Oct 2024
 02:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO1n886ZRRD6m_GQsYz-AGwpbkDB4S+0+hRx-9mmN=6iJ1o7Mg@mail.gmail.com>
 <ZxD-FCW9drBpC4c5@pks.im>
In-Reply-To: <ZxD-FCW9drBpC4c5@pks.im>
From: Abraham Samuel <sammymore50@gmail.com>
Date: Sat, 19 Oct 2024 10:13:19 +0100
Message-ID: <CAO1n884Kd5v7A--=895xAc0nHqQtVsCcJn5ad-4pdGhQv1SNCA@mail.gmail.com>
Subject: Re: [Outreachy][RFC]: teach the '-e' option for git notes sub command
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	"gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:07=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Oct 17, 2024 at 10:43:56AM +0100, Abraham Samuel wrote:
> > Hello,
> >
> > I was searching through the list for a #leftoverbits project that I cou=
ld do.
> > I then came across this conversation
> >
> > https://public-inbox.org/git/xmqqed7bhobk.fsf@gitster.g/.
> >
> > The suggestion was made to make messages seeded with -m/-F to the "git
> > notes add" subcommand be editable when the "-e" option is passed to
> > it. This allows modifying the message by opening the default editor to
> > enable the message to be edited before adding the note.
> >
> > I have checked the current version of git and there is no "-e" option
> > implemented.
> > I am also studying similar implementations for git commit and git tag
> > to help me understand the implementation.
> > However, I would like to know if I am permitted to go ahead and if
> > yes, I would appreciate pointers to other resources to aid me in
> > implementing it.
>
> You don't have to ask for permission in order to fix issues. So please,
> feel free to go ahead.
>
> I assume you've already read through the common documents that we have
> in Documentation/, like MyFirstContribution.txt et al.Other than that

Hello Patrick,
Thank you very much.
I have previously read the Documents you referenced and already done
the microProject
https://lore.kernel.org/git/pull.1811.v4.git.1728498122419.gitgitgadget@gma=
il.com/
which has been integrated into master and closed.

> I'd recommend to have a look at how this is implemented in preexisting
> commands, but you already had that idea yourself. You could also dig
> into the history of how those `-e` options have been introduced for
> these commands, which might give you an idea what was required to be
> done for them, and you'll likely have to do something similar for `git
> notes add`.
>
> I don't really think we have any other resources that would be helpful
> in this context.
>
> Patrick

I have submitted a new patch with respect to this.
https://lore.kernel.org/git/pull.1817.git.1729296853800.gitgitgadget@gmail.=
com/

Thanks for your time.
