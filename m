Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C2A1C4616
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531040; cv=none; b=ludYPM2g2khIoc/A/sTdImv5OOU0ISm4mPo5ttSJchNcKTpRPArXPP8qyRgKqOJveysbSLdCIDI9579KPvhdyd0bHcGqf/kCxppnlvY7O52o1EzHRXTW9okfrtiu6MsSclfIa3Vuz3nOsPHP1b2j4EDsqQOiDDWUjxdsDT7kfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531040; c=relaxed/simple;
	bh=BELWLHyhqvfuimxXPpZqFtaSlOq7DbuA+EPHwaCXy0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiRc/X7XI4x+T7Qx8gRR2mcoxfB9LEmdvdMR+c5j/5n+W63rbcMSnwU6GXh+4uyopk5tlBmX7mQdvd9PMuZxFUV8AsgUebdppvBcirQDgFJAoPEesFxqN/hpLWYDlNFBOKLayG+w1CmDe6HISrDuY1Y1N/QZ0ZlF2pXU7OIqE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaj1mfkK; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaj1mfkK"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e2e508bd28so34957717b3.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729531037; x=1730135837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=solQdluk3pH1JDu3OTb48t9JE373Gg/6itZGVNhnZ20=;
        b=kaj1mfkKHaNPhM1tNznf9cAYFqkRgmsDjWenRdaAULNXLIW5RHjRxG/pZSHUkTUh2j
         vwLJl54cxa/gaJPxCrmxRWMOwLPyhMrVt/DIjruz6CNPNR0HRzAgaTG0g/Dy1hdKjRTj
         ON1cFghbwTXRjQnhVbdJM1Nn62N5/zBpwDoN3voPH0ZZVrIL5jbDiAoqYyBPbszTWY9X
         oCsjCqAaiz95kQQfQSSF/qBtNECaA7Lxryjo7TGkbBcA3AvXWA2qK0qGy714je1kJKp4
         fBIhdSB/Xtdr41eI/7ibUFqhJiO33IADvh0ClJrqL4QVPsWuxiSFQ9tkxrfj15P+ZNQb
         Ls4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729531037; x=1730135837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=solQdluk3pH1JDu3OTb48t9JE373Gg/6itZGVNhnZ20=;
        b=lwR13Rtz/t8BiEg5DYAWslMTq6mD/WKrLh4Vks7zyTOgo2EaElFPldbRNQKALmTG6q
         DBbiPRKCipl5NOxH9p3tI5UV+NgD6SdhsK4863Ht+V64NIulHhp3apA5cSACC0Fdo9vE
         CrOk33Ct0RQ8dtoQfnAxCGu4H2AjR2/fKXdAoD1isqJxKrR6Gz8OWWkoWIWxIMleKr7i
         QLNt9CxQSeKWnygRFvpiUSWU/eJO4Q/nqbsBMmwzv4HyiOvbJytKw0lMf37141L7cbDh
         HHiokJ/l0J7V/0DTLA3Y3TBfFwQ41g3S7G64byL7ZzyqiM7ANBuahPRgno3uz70cyuEV
         rybQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxvFzjwiFrhgU1SYEY42xw9sezMvAGuu4CNHxTl88qkmvc8eRwx7bXMlg8Mmawj2z8nVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzv1sQQ0NGX0piSEy7RccPbmaIfB5A+ahsuochZrTC4gyXVZUj
	wN3Xs8lMk77GosSIcOpPIlCNnCK6W/afQk978B9lsyik3Arb5cJmOyQvR6R+6ZFiFVD6HsVQc77
	0fYmd1gQl6TzPb56pICdHElnb82AHYSBBytk=
X-Google-Smtp-Source: AGHT+IEbb6ztXpbf/hHyAAn0U4A7e1A2SrNlMo21t3fhX3fxmjwvgZFz0yTkeglkZeVvGU8RsTz6UQNQIZe8iTRWZlI=
X-Received: by 2002:a05:690c:39d:b0:6b1:2825:a3cd with SMTP id
 00721157ae682-6e5bfd4ce2amr97915927b3.35.1729531037505; Mon, 21 Oct 2024
 10:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019163439.274656-1-kuforiji98@gmail.com> <cb88194a-15d2-4c3d-8768-189853572ac0@app.fastmail.com>
 <ZxZDFyKxTn_D7c3o@pks.im>
In-Reply-To: <ZxZDFyKxTn_D7c3o@pks.im>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Mon, 21 Oct 2024 18:17:06 +0100
Message-ID: <CAGedMteMtaOvyE2gX59bMudEUmCZw7nOh=MuDRi=7CbYm-gBDQ@mail.gmail.com>
Subject: Re: [PATCH v2 Outreachy] t7011: ensure no whitespace after redirect
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 13:03, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Sat, Oct 19, 2024 at 07:54:30PM +0200, Kristoffer Haugsbakk wrote:
> > On Sat, Oct 19, 2024, at 18:34, Seyi Kuforiji wrote:
> > > This change updates the script to conform to the coding standards
> > > outlined in the Git project's documentation. According to the guidelines
> > > in Documentation/CodingGuidelines under "Redirection operators", there
> > > should be no whitespace after redirection operators.
> > >
> > > Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> > > ---
> > >  t/t7011-skip-worktree-reading.sh | 22 +++++++++++-----------
> > >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > I can confirm that there are no changes in this version to the patch
> > itself.  Which was expected since the change was good.
> >
> > The difference in this version is that the commit message has been
> > improved.  At least according to my taste.
>
> Agreed, this patch looks good to me, too. Thanks!
>
> Patrick

Yay!

Thank you for the feedback @Patrick Steinhardt @Kristoffer Haugsbakk

Regards

Seyi
