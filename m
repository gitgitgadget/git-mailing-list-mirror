Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D31EDA22
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990076; cv=none; b=j1piS0dVHyTm1yIJXrhg9H5ewbcKo4YRVVbKQMfXlsYZzMfT179GIAax9rSffWGKBSUfundDQKmsCcLy/koOQWjKcCTJzOb8alnDeZHJU3Rw7+H/B0NRy3YLm7qwUaFr2lAqpAm6rgRQOZd8rNy/RwEKJaqYKXfsF/651WNUSSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990076; c=relaxed/simple;
	bh=tMYvPaqDY2ZzbKsitCTMHiRuY1Njzjl1lj5qSj8Ttiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRXqOIMcSk8dUQFryH+fXyfGmOmMFC5dowQVB1rWDjSyUxBz4+sCl95FPjTWc36YxGkXVgCWpu5ILwkBRE7tQP/xyUhXBKp2m9dodtAcTBM8rMTOvC/Xa4rsf3P1v3liANHPTdw4tjOB9nwubdq3i0LvaC2EdRfMUTdXRJUF2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L38f4D2J; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L38f4D2J"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e6087a8588bso3831569276.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 00:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740990074; x=1741594874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnI6evr8fzrgoV1tHtGxwLDE2+JwnY5esW9u2kLsddY=;
        b=L38f4D2Jc/JwgyQCWlA6ZlykoFQP1nHYA4u6GBLFMOPLKOUkfOQSw9yi4rAedTyg3M
         aa5jR3+eFgpsuzcp+s1dPdSmq/4kUsxRGCztbxhLEpyRa3w2cFvfXNnDw5tZ5RQzDKcJ
         Rqn2Cb8N+aIcaasyyCXF8nDSWxtKj2DCkSIOVgCD21bNkTCMnDuACULzdKlQa3yZKg7l
         IIabVd+SMsqRV4W/gADwTNNPQBWf6vML5KCRkL/D4QAFYi4HiiU+harWeaer/J18aWDg
         tR/8OHy+XwaT59kRUWdopoJgN/aqLPkBS4xVVwE9B1AbICLalXb1oTKChWV5m1FWThaZ
         unAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990074; x=1741594874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnI6evr8fzrgoV1tHtGxwLDE2+JwnY5esW9u2kLsddY=;
        b=QT4HYkmAWdB7VzEu2WliBDCsRMXpAwRfS65seyaz11KakgruVEtxab6GkAzKQKn9dh
         NiZBWJjVM78lVAE4QCPo7v8i0dglJ8N3TqWeNGpcnm/e54LN5w8KGHmA4rYS8S+NZY7E
         KY6TNRcqG6OyqSVE2WyzZd0Oh1C3edZc3vlTBI/xb5Kzr/hDea8TyYRSCXJwIeOwUQ/f
         JCTuH8iqpfSi2yxlMsmNx+BRuo79oTHRjXixVoFMn6vY76yqZL0Y1Il0NANDeZq61zRS
         N/FvkBDwNYUJTD3Z0uRZy1bmq1+kM1q7jpUnVfS5N8mF9Gi2c+lPSmJVm/Q0YJJWsJL5
         lkPw==
X-Forwarded-Encrypted: i=1; AJvYcCV9UUvr7kBmtb42pNQA3sged9sKB6lHcGDD0R8jn30HBqKoukkC0q4gbeoZ3QR2uyYlNYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7J2edbVZskxo7X6c5Hh4XNWSe/Fj2skueSyiY8E34me2XB8l
	oO+zb8ABEgJT787yiQ9NOUClyXv64tWQ1KDbX8umoN7nQc/1SGcKNWvN6Vyh48IKWTbzhJbOzei
	s2XDdD4BtLT/iHmY9VmQXYFwGpuU=
X-Gm-Gg: ASbGncsX4qbNE6RmCbF2egCJsQfjl17I1GZ+2CgCBGu4Bpr26C6rbvqgULoXsLpWrL6
	ESn2/OPZz/k9WZ6GS6oihVSs/XysSeDvdtSsZy/lSy6cMwTUDVFIjscut953ZAEsWltRZ5NYZlj
	AoKoogvH0CRcNzOD8mI39ZRtb/QA==
X-Google-Smtp-Source: AGHT+IGEtS98YDTcd2FI4P18QVIma0YLorNyUtu5A3JR9H6ko4QHm3dp62J/EsYezLWGqhNG4R9iTkNw+80WX9c+ugQ=
X-Received: by 2002:a05:6902:2010:b0:e5d:bf57:7dbb with SMTP id
 3f1490d57ef6-e609ef555c6mr20177490276.15.1740990074251; Mon, 03 Mar 2025
 00:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFXmTzjQuZn_b-nQHkYo7KHs9__gc1ctoLx0KioTcPEkqak+9w@mail.gmail.com>
 <xmqq5xkz708v.fsf@gitster.g> <CANYiYbGJevT_MAKW9n8qvk0Q6AWUY12mD7Hzcg6=+o_tkDuOCw@mail.gmail.com>
In-Reply-To: <CANYiYbGJevT_MAKW9n8qvk0Q6AWUY12mD7Hzcg6=+o_tkDuOCw@mail.gmail.com>
From: Ruggero <giurrero@gmail.com>
Date: Mon, 3 Mar 2025 09:21:03 +0100
X-Gm-Features: AQ5f1Jo8W_d_GOF-N1l5dt4o7RZd2ysPdPErTzOwPx3DVYVrLAJgu1yIsxuZVVk
Message-ID: <CAFXmTzgJ0_p92kaqFcby8En6EqEBnccN-H-uH_HMBNQtUtit+g@mail.gmail.com>
Subject: Re: [PATCH] doc: fix typo in it.po
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>, git@vger.kernel.org, 
	Alessandro Menti <alessandro.menti@alessandromenti.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jiang,

I created a pull request (contrary to what is written in the github
template): https://github.com/git-l10n/git-po/pull/827
I haven't run "Refine your commits" with msgcat since it creates tons
of changes in po/it.po. Let me know if that is what you want.

On Mon, Mar 3, 2025 at 3:24=E2=80=AFAM Jiang Xin <worldhello.net@gmail.com>=
 wrote:
>
> On Tue, Feb 25, 2025 at 12:53=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >
> > Ruggero <giurrero@gmail.com> writes:
> >
> > > This patch corrects a minor typographical error in the Italian
> > > translation file (it.po).
> > >
> > > Signed-off-by: Ruggero Turra <giurrero@gmail.com>
> >
> > Jiang, should I take this directly to my tree, or do you prefer to
> > take care of this as part of the upcoming 2.49 updates?
>
> With the help of the large model, it can be seen that the patch
> sent by Ruggero is correct. Ruggero can refer to the following
> link [1] and send a pull request to the repository
> https://github.com/git-l10n/git-po.
>
> The Italian localization work has been on hold for over three
> years, and Ruggero can help rebuild the Italian localization
> translation team (by modifying the po/TEAMS file) and
> regularly update the Italian localization translations.
>
> [1] https://lore.kernel.org/git/20250227015804.100880-1-worldhello.net@gm=
ail.com/
>
> Thanks.
>
> >
> > Thanks.
> >
> >
> > >
> > >
> > > ---
> > >  po/it.po | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/po/it.po b/po/it.po
> > > index c4af156c80..e43f0fea5e 100644
> > > --- a/po/it.po
> > > +++ b/po/it.po
> > > @@ -17602,7 +17602,7 @@ msgstr "Controllo la ridenominazione di '%s' =
in '%s'\n"
> > >
> > >  #: builtin/mv.c:185
> > >  msgid "bad source"
> > > -msgstr "sourgente errata"
> > > +msgstr "sorgente errata"
> > >
> > >  #: builtin/mv.c:188
> > >  msgid "can not move directory into itself"
> > > --
> > > 2.48.1
> >
