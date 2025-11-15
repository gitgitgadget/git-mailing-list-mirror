Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D752581
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763184573; cv=none; b=pmb8whteAJDxIveKHc+O2iYZP4RoMV/qxHpAtLS40svmCh04lVpjPeI9aXrKfUYaP+5I3tUd4kxHEcVNw/HYDBcAF5bMe/AUHF7uZwHhlL5h0rG36Fr2cafK24mqHHXiTfUR2i0IOUOmEAzgt8xs+bYLNzgumBuu0TK0/IpXt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763184573; c=relaxed/simple;
	bh=llz6b6jVLCd5xo9CagYzEOZONTt1jXj0yUJn50Uhcos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAbYUWyFxHBsg/tvy4bKkDO0nlAx3BKYgWiDRO8gQAZpQvQdSKYJkAOu2O3JdP+0Ypx3kGGVh8o4++3ql+5pFIISn/IhBvdAkY0hkvVe+F1V1+HW2sS6MU2Zf+Fup1EcW4y4V8w7BYytcyhAdo2tNAoGA+IaJNg8BGNFOEI+l40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK7y+V4t; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK7y+V4t"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so3763545a12.2
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 21:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763184570; x=1763789370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol57Xi6UpPrWCaX837j3QPpLpn5QTLVlsikxGzb1GkA=;
        b=PK7y+V4tYQGHBCNVE4uZXVJmvY+zXqAUfKjt8+Zn0nnfDJOlzTjV9G687mQidSQQLY
         jQnEAhoBXIXIrW17fXV+yYjqTpXwysSEqoDHwii1JQ/QI2RSCohUS8e+YWvKxohuzGSo
         FiFxhGs69Tfoaom235nER3oQLpT/1+vUnPEp7zP10gejzYws4jt42hZOr9vINwFnfusA
         P0SBlDZy45d7PWgpn+la0Q5PJmUmrmG/Bl03C655PkrXAP4r4I1evTgjUcEl9JIx6wNW
         tBJXIqkchX3O0XZ+aXWQRS/AYmTabjpRbKnQcHxiFEbSegVkvuX146opvz1Xo1UDb0qr
         9c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763184570; x=1763789370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ol57Xi6UpPrWCaX837j3QPpLpn5QTLVlsikxGzb1GkA=;
        b=bcwbuUh+DPn5GeznUSJ7SWvROJEryfzM6cbyW8AynnYzmS9AxndY2uvTK8F/3utSIA
         jly0AA+KbVJQgnOhoQAKHYoHEepXmZTi6Ly5W+cR4ssXzgQBALUaeU62p++Z0H08fQ/i
         TGeNpjPf6zSqmRFbBRQOtfS1keXreZD5NkVzbUNTndBeHR6s5sNKqzXIBnzihOyscZJI
         c58v4WZeUQ9ZfESaJl3KOX/GC7Tb6qKFF84tSSxO15Um4f1w4pVN5pSZO76TAbdQuxBo
         zqi+6YjzFmw1nDzw+DnPkRc7XmsNcydHPGissjZrgW1sf26778BSpc6Ypeqt896MUqOD
         smBA==
X-Forwarded-Encrypted: i=1; AJvYcCXp5App3GWG+LFlSsf9k2TCJz5SZtjUKbA0sOQol/6GVSk9/0fkMt5uDIjCWYmCrsgu4KY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2S9gip74n8wsJLofYBBCWH1kJ+i8j4sRv9LPDZgkw3hzf4uXc
	K4aliGW/eapOufcUkq3BSqnL2DdZTyqhz4jPPftk1k3j+/Gavy9M/YHFeek7qefNHlwXYfeXsud
	uyPgnGgYQ31XxjGN3Pwqb4t6FuKWpeD5MZW2s1L3LWPVU
X-Gm-Gg: ASbGncspdzm404+yMeIJqCA8XsIufSvV3J5FAdHBXaEC4jZYCwidb6z1GnhhbPfHnaQ
	AOeawm3cAlxCWkMMoMizcOX6fB4hmlZPSpfL+a4Xxf+6wXBficNxMRLQ5R8DaL3kC7gvGcZvmWO
	Nm6FkZnuouMEGEQ2JzdMohBuqL4YpmOO7AC2Xv7hRICQCUchkMZXlkEhO5tIBkLlezakEREhGgf
	teHKlBBejpplux25EVVrYHlzgH7N0eiRgiXyigWW78CosiWQv0Jdc95BjxaitpyxHsIYJkjDtLL
	FyjUC+H5NUsquw8J/8D9dLc=
X-Google-Smtp-Source: AGHT+IEc0U+hDBYwlks4PgI0EvGQQ+3dECbsj1FvlcIi+xYCUR3sc98b2O4oAsZMCQBBWvvbiOKf2dV2vgiQKS6FIr0=
X-Received: by 2002:a05:6402:24c5:b0:640:93b2:fd1e with SMTP id
 4fb4d7f45d1cf-64350e8f2acmr4405794a12.17.1763184569981; Fri, 14 Nov 2025
 21:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
 <7d99f00c-3602-4b28-8efd-4780cad41ca8@gmail.com> <CAOLTT8TLEsSAcfUomoActrUSzje5mQNE7EweXh8WtY3sOfzfkg@mail.gmail.com>
 <xmqqqzu3qi43.fsf@gitster.g>
In-Reply-To: <xmqqqzu3qi43.fsf@gitster.g>
From: ZheNing Hu <adlternative@gmail.com>
Date: Sat, 15 Nov 2025 13:29:18 +0800
X-Gm-Features: AWmQ_bl61Kar5shaxy1RmHYnFNAgb1ROnP9OiN0AP_PvhOlJIcsEmwrSkxmtGpI
Message-ID: <CAOLTT8RSN-72gVXDS-zrr=7wW4HU=CL6acyDx_UXnvo4c5MaRA@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, 
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8813=E6=
=97=A5=E5=91=A8=E5=9B=9B 01:24=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> I'm afraid I don't quite follow. If you are amending existing commits =
to
> >> fix them up after you have corrected your configuration then they will
> >> have the correct committer automatically when you run "git commit
> >> --amend --author=3D..." to correct the author. If you are committing
> >> before you have realized that user.{name,email} are misconfigured then=
 I
> >> don't see how "--committer" helps because you have not yet realized
> >> anything is wrong.
> >>
> >
> > You're right that after realizing the misconfiguration and correcting t=
he
> > repository's user.name and user.email, running `git commit --amend` wil=
l
> >  fix the committer information, but the author remains unchanged. Users
> > then need an additional `git commit --amend --author=3D...` to fix the =
author,
> > which does work but requires an extra step.
>
> Isn't it more like "You need to run with --author to correct the
> authorship by amending the commit *anyway*, but while doing so, the
> committer information will automatically be corrected"?  As I said
> earlier in a separate message, the author and the committer are not
> symmetric, so having "--author" does make sense in the above picture,
> while "--committer", as Phillip points out, much less.
>

Well, I admit that perhaps the design philosophy of author/committer is
inconsistent (which has caused too much trouble), but for users, a consiste=
nt
parameter interface is easier to understand and use.
