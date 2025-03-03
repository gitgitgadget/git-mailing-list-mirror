Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886E78F30
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991374; cv=none; b=JCCGipCifMoPyE2P9IGEqphsOJsPU7YArjEjR9EncWMmmTjd/8Ah71n+GexYaI6HkepOoqrZCVkfxep1WS6SBEsvQV8DJfbfF2NQt0AWz9HYRIo7E4cGXq8s+3PHt50wJC1ckET7frwS5xeg3Eu7ajkTKIFRZTIanPBGwKFoDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991374; c=relaxed/simple;
	bh=XqzTYE2NQaodUp0XRV9zKEqLWDv+yKtk8tyy6tPthdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwJY7lQMK9EiKd27U4CzNPYIfDLI+9zZ/9bXBEn2nzVH1fB5CX7eTbWokQ9MfdfzqZ/iYrHhH2bxE1shie1d1CYZu9eLisBgwiBLE2ZQIuvWU3cc75LYkydcCr+byn4Po6jRQ4ErrNa3sGp3DrrDXnVar7Z0zHUWGnb0kp9jrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmpaE7y6; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmpaE7y6"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so3395667276.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 00:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740991372; x=1741596172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FKaPEyUr9j0Y1/No/HAhINtI8RuqfD3w4uQQIAztck=;
        b=WmpaE7y6eNImaMnJj17M7NU8IrseIWmkJXx+zYYFA0U7l6/p1ExtdZqvFiEI+Abih5
         kQY4BtdpRKVGgiZXrErito8uFDR9kC5o1q0FRVh2sgvV0UbS8Ybz8gQIQSPBkcIpKqLO
         7jhLeaaKHzyyPy9o7x5JCwAnUXnStHoCzMkDXmv+P5Dy4JV5Scp92jaqvhJ/K1gXHFmG
         H+nPQ7vmIBY9dDbJjkADYHml4JJ6DeET4YDgr2vP1fmvXvrHK0GYk7qxX4D4sacKMrJG
         ZzvyPxyZUV26J8d4CPfexmwrNgxxzNQv83vV7rsma/ASzte3lXntEr6WV1eqd+Lm9S7C
         6tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991372; x=1741596172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FKaPEyUr9j0Y1/No/HAhINtI8RuqfD3w4uQQIAztck=;
        b=JFBdcpJ4On+agGD7aFFQLnBzExx2nDp56lBrAjlGMef7EnaO9vlzl9Xtrj2HLnD8mh
         lW9bM/n3o5mm7mGcgzktJPMW3fCMv3jQlBadUeqxKeNL/U5SBTPZjP78FKLz/V8IaT7A
         D2koYAgYAZZNjr5dJLh8pGQ1EWfOlG7nD/w2kMMqRrHOzDVUzux6Qc1Rgy3UoSc6bh1U
         kDqe6itV/Wy/4vdAevVX+Ix6wBOlzoENM/30AJImjXTj3hDKSKLYVIh/+nUtRyodRp54
         R5wXRuTTb1X6FZaZbrGHopt+FARw2QHK/+/EkkaHhEKRxpZljc3RbNhiyAPIuwHU2H4l
         S97A==
X-Forwarded-Encrypted: i=1; AJvYcCWul2zlwafgFofU7u1rHR8bHsTCSO4xD0QqYcqZ2Pey2mdzxUKHytRIjVKYjn8+VQEKyVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXAbPMX0trgkOJMNMy18o+FCqvc/2VCLi/qUSTgf3ZEl33OXZ
	3i4Sotn1ycY9Nszwj3mN+HhKnSIRoKAkF+aSJ7+vkGhtKWjr+c0NfWtIy5BC6RfQ0h7uzqA+Ppk
	q/ar02CT4WOud6R3wyQte1+Qg5rU=
X-Gm-Gg: ASbGncvos1oEVk8ULTJmCrbWWOzvyzHkJF1Nd4lEsalCLq29wxqsP3hnFpfaGu1pdvX
	rU1IFkXuStnscb5RPuIG7F2x64iocYETl++Zo0LUdQlqDwakAmvmXtnst9nZZQNMEl1XHt/XZdI
	44wdayBxyGh31bLSn7xXx+oxCVEg==
X-Google-Smtp-Source: AGHT+IE9sQfHF4tW6ehWu1Jh3SSXbCeydMllaK87Jc0JKMDUBxdw/WZJZ3oah/tJwzW6RnQAsn1DjCWQzEOI5xexMqQ=
X-Received: by 2002:a05:6902:2410:b0:e5b:257e:c3b1 with SMTP id
 3f1490d57ef6-e60b2e8e498mr15750519276.8.1740991372328; Mon, 03 Mar 2025
 00:42:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFXmTzjQuZn_b-nQHkYo7KHs9__gc1ctoLx0KioTcPEkqak+9w@mail.gmail.com>
 <xmqq5xkz708v.fsf@gitster.g> <CANYiYbGJevT_MAKW9n8qvk0Q6AWUY12mD7Hzcg6=+o_tkDuOCw@mail.gmail.com>
 <CAFXmTzgJ0_p92kaqFcby8En6EqEBnccN-H-uH_HMBNQtUtit+g@mail.gmail.com>
In-Reply-To: <CAFXmTzgJ0_p92kaqFcby8En6EqEBnccN-H-uH_HMBNQtUtit+g@mail.gmail.com>
From: Ruggero <giurrero@gmail.com>
Date: Mon, 3 Mar 2025 09:42:41 +0100
X-Gm-Features: AQ5f1JrTvjq0NkhadArKkTivZbxsd21NeF2JnzXXaL-MdVbZK8Mu4eSOdWuioAM
Message-ID: <CAFXmTzi_acK2dCen27tgRCYWhD8oHKDq1FE-xsvnOG+F1jytwA@mail.gmail.com>
Subject: Re: [PATCH] doc: fix typo in it.po
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>, git@vger.kernel.org, 
	Alessandro Menti <alessandro.menti@alessandromenti.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here with the correct commit message:
https://github.com/git-l10n/git-po/pull/828
There are many failures

On Mon, Mar 3, 2025 at 9:21=E2=80=AFAM Ruggero <giurrero@gmail.com> wrote:
>
> Hello Jiang,
>
> I created a pull request (contrary to what is written in the github
> template): https://github.com/git-l10n/git-po/pull/827
> I haven't run "Refine your commits" with msgcat since it creates tons
> of changes in po/it.po. Let me know if that is what you want.
>
> On Mon, Mar 3, 2025 at 3:24=E2=80=AFAM Jiang Xin <worldhello.net@gmail.co=
m> wrote:
> >
> > On Tue, Feb 25, 2025 at 12:53=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
> > >
> > > Ruggero <giurrero@gmail.com> writes:
> > >
> > > > This patch corrects a minor typographical error in the Italian
> > > > translation file (it.po).
> > > >
> > > > Signed-off-by: Ruggero Turra <giurrero@gmail.com>
> > >
> > > Jiang, should I take this directly to my tree, or do you prefer to
> > > take care of this as part of the upcoming 2.49 updates?
> >
> > With the help of the large model, it can be seen that the patch
> > sent by Ruggero is correct. Ruggero can refer to the following
> > link [1] and send a pull request to the repository
> > https://github.com/git-l10n/git-po.
> >
> > The Italian localization work has been on hold for over three
> > years, and Ruggero can help rebuild the Italian localization
> > translation team (by modifying the po/TEAMS file) and
> > regularly update the Italian localization translations.
> >
> > [1] https://lore.kernel.org/git/20250227015804.100880-1-worldhello.net@=
gmail.com/
> >
> > Thanks.
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > >
> > > > ---
> > > >  po/it.po | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/po/it.po b/po/it.po
> > > > index c4af156c80..e43f0fea5e 100644
> > > > --- a/po/it.po
> > > > +++ b/po/it.po
> > > > @@ -17602,7 +17602,7 @@ msgstr "Controllo la ridenominazione di '%s=
' in '%s'\n"
> > > >
> > > >  #: builtin/mv.c:185
> > > >  msgid "bad source"
> > > > -msgstr "sourgente errata"
> > > > +msgstr "sorgente errata"
> > > >
> > > >  #: builtin/mv.c:188
> > > >  msgid "can not move directory into itself"
> > > > --
> > > > 2.48.1
> > >
