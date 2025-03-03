Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF615DBBA
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 02:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968691; cv=none; b=MITO3ZMHJfzx+4hkulLosv4rqDcedSEgsoXpjt2s7GMV7EAYGXAxjJkvTU41ACtZ2Nqvh0CiqQ1n6WqmMOXpNUSo9TpzOowY7VZXvtGjEzs9+1nrQtLjWv9USAsavdbKAqLDFfn4+mXfFYeMRv2rCzI2PZB+hUAUxuvd7Iq2ueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968691; c=relaxed/simple;
	bh=K33DvPHSCvzK6HKieJhCBMg7D8AfO5SEEwztUqsrnc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qym62QbRvMPvEa77lpEgAqdF0SkNeQRYVf+u6iGoQxn84K+4hxQ1cLOnSiYfyYyYmpxDw4wDP3v8g784qFtj5pSpoTF/XPg/NNQu7JLHUKOcccRBSLiNFVg2KPnLj4iu4rStaAsg10Xp6tfG2xgGIDKEL5OYA4/d+fhrvsuEltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZG+7Vc6; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZG+7Vc6"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ef7c9e9592so29744577b3.1
        for <git@vger.kernel.org>; Sun, 02 Mar 2025 18:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740968688; x=1741573488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC28G/+9O2xwdVl3aM1PrR492BWCWqRc15y79/HckIY=;
        b=kZG+7Vc6UYdeucdaToo0J0wuZhKaQAKTXAJh7DYQ1GGg8Czb1rOTJ9ukNS3YaJ9hy3
         1Zee55R/WcNrrlcp3bG1XVjDn0sqe9zUwUYH8UNEh8SsrA1uMM0f93Ho96dPvmc0H7gA
         PRt0/jjsEhUBbvmjljFEbuqajoUeTE/kerKcAt6D4GLAIUeItDGztrNIKolIoU8q/6aZ
         mVyYzdsIzIX9/csb/FkNQ6tLhQ2jRpJEvpJmimzBUX2nzjpz67GGfiKnJ/g4aWJUmNeE
         Y7jq0zx+u6NtJy4qmlIXFyhW+F5QjNlfUDxAzhrwUviGy8eSa7/onW6DJW2MXp355AuZ
         OA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968688; x=1741573488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC28G/+9O2xwdVl3aM1PrR492BWCWqRc15y79/HckIY=;
        b=AVeypIN+x//I+JF1/Xgsf+b5w4Da673nnf7WwqP3fubdmInYOgAYuBCNndeuRwahVY
         hwMz0kIms5O5dhQGDGGrBTdxiF9jhI986BoqT9NKnv+3h4SPXiIixH+mkXBDmodfto/O
         zZyEfs/GAnoOOkYj06WA6B9BeAXUNjW2W4Gs8662j+n09tDoHBBR+pPBmD2qpteIdKhF
         tGIk8nMKjFw8Djl8obi4srYDeV2UupmvRUrLTyiKl6+huHc598miE3cHIHaJ9r9+2cfO
         kp2pCzQeux6R0ldIA6Oprd1AT8iTXm+Cy6zL4mkYKHJVwXOXbc0BDLC+yqxrUUr5OkuT
         QxbA==
X-Forwarded-Encrypted: i=1; AJvYcCV9ApbYXC2PBe1hkuO+uXPLJi/uUNkz3E87vPSGRFQDdZiwkwvXXLqRQU1bG1IvsNK768A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCwr9on5ThJ3P7E7ofZ2awMz9rbves94HzIqQtN0dHUVAcGDyi
	BvVJrp96K9DK0pDSH5AhIG06uxJXWH0ijmiEPucRlZ33l0lRSNI4jrj0lMn4S8SXUf5pQWhkXJz
	Gfn/JWBU53rS7ReXJd8oau0Dqaqw=
X-Gm-Gg: ASbGncu2P9OVALHba1BBS1wI6eibwj5NU6b9XDUt48rVgZ4H6PkRIsJL+tymXkpWsnN
	dH3lEsaw7t+CPI1fVxSAl81iRY7QWIljPcbJgkQBq58pU2wBhVLP9VUV6u2K5rMZ/hNlzUrLv9t
	i+3lrSgz3KTNAdBbqThFTSpzvFkKA=
X-Google-Smtp-Source: AGHT+IH7uq/tx8qd5uaQ2Wf3aqe4ilBzsOH+vlmM8wThvYDrZFCRmFWzUi5kZ2PwyHWGbruqzTbFBSWnd696gg9cq4I=
X-Received: by 2002:a05:690c:3381:b0:6f5:393f:cf48 with SMTP id
 00721157ae682-6fd4a038353mr127300227b3.21.1740968688657; Sun, 02 Mar 2025
 18:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFXmTzjQuZn_b-nQHkYo7KHs9__gc1ctoLx0KioTcPEkqak+9w@mail.gmail.com>
 <xmqq5xkz708v.fsf@gitster.g>
In-Reply-To: <xmqq5xkz708v.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 3 Mar 2025 10:24:37 +0800
X-Gm-Features: AQ5f1JqZVZwdW32k-NLQTZ3iZ-WcjzFtYaSalyk8YrCCnja4B4Esachd0H0PDxU
Message-ID: <CANYiYbGJevT_MAKW9n8qvk0Q6AWUY12mD7Hzcg6=+o_tkDuOCw@mail.gmail.com>
Subject: Re: [PATCH] doc: fix typo in it.po
To: Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, git@vger.kernel.org, 
	Ruggero <giurrero@gmail.com>, Alessandro Menti <alessandro.menti@alessandromenti.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:53=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Ruggero <giurrero@gmail.com> writes:
>
> > This patch corrects a minor typographical error in the Italian
> > translation file (it.po).
> >
> > Signed-off-by: Ruggero Turra <giurrero@gmail.com>
>
> Jiang, should I take this directly to my tree, or do you prefer to
> take care of this as part of the upcoming 2.49 updates?

With the help of the large model, it can be seen that the patch
sent by Ruggero is correct. Ruggero can refer to the following
link [1] and send a pull request to the repository
https://github.com/git-l10n/git-po.

The Italian localization work has been on hold for over three
years, and Ruggero can help rebuild the Italian localization
translation team (by modifying the po/TEAMS file) and
regularly update the Italian localization translations.

[1] https://lore.kernel.org/git/20250227015804.100880-1-worldhello.net@gmai=
l.com/

Thanks.

>
> Thanks.
>
>
> >
> >
> > ---
> >  po/it.po | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/po/it.po b/po/it.po
> > index c4af156c80..e43f0fea5e 100644
> > --- a/po/it.po
> > +++ b/po/it.po
> > @@ -17602,7 +17602,7 @@ msgstr "Controllo la ridenominazione di '%s' in=
 '%s'\n"
> >
> >  #: builtin/mv.c:185
> >  msgid "bad source"
> > -msgstr "sourgente errata"
> > +msgstr "sorgente errata"
> >
> >  #: builtin/mv.c:188
> >  msgid "can not move directory into itself"
> > --
> > 2.48.1
>
