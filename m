Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233729405
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247212; cv=none; b=bgKf+4XuU9mslBRfx3aKx3FwWPo7u0bXHfVxS3drDuGXFHnqcsFCJfb/6oxWGy2D4ptCui+viK85BBWLRwO1lON5MDJfQ3R3EYRi8txj6LPo642RdWaBrCyV4X9Yry1fgDivqu+4yk+E/UKZuzAX6oDXfcbtewDGawmDZmKNLY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247212; c=relaxed/simple;
	bh=4Y0/8Lf02hvwKE0C7paPaUPiuwtN4xNcf+fcrWhym04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HW25k8SH7gyOuyWK5mMdvXI2/F30pNPzUs83haYR6kvcAbpxZw6qoWPHKeHtrMDULhuHUzWLpfgqqi+t9Lg3fu8c8T96bVXuQGkAetV6Cn1iE0PLUacTIZPWUtFbGK5qj22GDVDR1HKmlYnNlHwGl/NKQFUK2Q+dIz4xdGXgHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYkjLYde; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYkjLYde"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so2122652a12.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761247209; x=1761852009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uiho5tkJuKm2oBSQ0PbEkRvFhxE2ir7DLmkuN+eh/9o=;
        b=jYkjLYdeFlW80pve3tQ7887AkXk7PUuLxYw2PSQjSSUeoUUTuzZ/FKd0m/Ta9vchAx
         vH/J6G3V8eWv7xX5TkbQGInEZKQkZko0DiaSrSSuAHWwYh+m61IxdmGbMXzFWJqejLLj
         ivJv1flXmL8HBfUPEmiLTdkv3HaxQ8ar+iDs3OMBmvFxPmHh3PhV9jPmyhCZhmEE9I4O
         9Z6I6IjqSAJiAcAfNdHsk0QBgOHjbJVg0XeE89URG/NQMG0sCzXrl+mlnFb7ORq9FTOP
         7RPBu3mYqcw7J5F0AHO+ROh0dCgRPBEe8DjXujjGtNYSt/46QhBHNEejYMmqDJbkn1vt
         L1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247209; x=1761852009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uiho5tkJuKm2oBSQ0PbEkRvFhxE2ir7DLmkuN+eh/9o=;
        b=g/oI8R0xSyM95P2SnfIbresQ+upqqsYiO+OB2Sry4WIWXT9DdDdM/e8S6E3tAhHj6i
         uXSLFXhSYfGdUKB+WDIIeFvwAxSkf2PCc2fJwroFzRNafXW3MG7bp9Ya3bS/errGjvTW
         skUIs3JWRefGRZHohMMRV3e9Jgc6xp9V+Mi3KAE5mR/PAjSObvrKRr1crTz4psCbivgc
         +qCxEtiqsVhfcyZSn7H+wg3QbtDg2/UZojrNSnMGMartoyAsNIAwcYLKcBQcHmrdkYMg
         yADe/rU9Fx+a/LJo/Tp19ykMZ3xMTrEdKGZhBEF+nUOqZ/TSuSILjaI/mBkDdGEPHP62
         3E4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf4fVVEp7aAR3ERonAEQp17bloogmrSkxRyq1jZz9Lf0f/CZPUAWeWYv4EWTl9EFpmv7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHnMGJfNZQFsYocvOcq15CY/Lhcp7JAds5NajwA8mfYPaAzb9C
	+IxMEo2QsSzYAnjQH5SSa2ZqCPta3jvt8jrBq1npIoq01YhTJqyV3y0pCWiDkfQ2SHSbVWArcgj
	J+gFtWMrB9lWFobXo0tiDZ8vYLWw60WAJrdEe
X-Gm-Gg: ASbGncsQIsARFN/RQhSSXCOXOkn57iL12K5WlMJqepMMzhzXiuRS5cf7UTcxWL3lcOX
	OsGWpqK62VcuP8ASATyugh1xGpIytmVMWcgPlFvE8w70SdLQbWQhLDtiyQwny7fg1tDqURUrlUq
	7/KpjE5BHRYNH0DpAekKL+BhMoiALv97rLeVdzTjgpnoBIv13KWX9uFtw0r2U6tzBBnLz0WD4fb
	3+OUUummfSlxsR/wtN396EMy39kXAgIL5cOM2WpA/Oz23almO9TdZiXd1lCzA3VQXCSj2l48U26
	X9rsmXQqjHQ3WaV0y1YoViQQhZiPWCpoI7jz2TH3
X-Google-Smtp-Source: AGHT+IGgVScAAaNWQJ1y11s46H6Vw5UcmaT5/9QjWFbTYY5mcsc5RlcYbYCM04DLjc/7pbZkEqubE1jXbTFXja3j0I0=
X-Received: by 2002:a05:6402:5341:20b0:63c:690d:6a46 with SMTP id
 4fb4d7f45d1cf-63c690d6b1bmr15869729a12.13.1761247208701; Thu, 23 Oct 2025
 12:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bec27479-c53f-472c-87c7-374321108ad5@kdbg.org>
 <80220653-7302-4E4D-99E9-1A8CB5B4F23D@gmail.com> <xmqqsefaydfg.fsf@gitster.g>
In-Reply-To: <xmqqsefaydfg.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 23 Oct 2025 15:19:57 -0400
X-Gm-Features: AWmQ_bktw8x0VjE6Lqn8eDpc3Emncd8z9r0jTgfDS7OGhWnkA7AAUZI_v6ZVJpE
Message-ID: <CALnO6CB3EZkAyc_fWdU+P_MLcipZ4T90RSk0+46Fc20OmWEpmQ@mail.gmail.com>
Subject: Re: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think I'm confused, which is probably on my end, but let me try to
clear up what I wrote, at least.

On Wed, Oct 22, 2025 at 2:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ben Knoble <ben.knoble@gmail.com> writes:
>
> >> I think I'm saying that I am mildly opposed to enable rerere by defaul=
t
> >> as long as it has this sharp edge.
> >
> > Fair points. Could I ask an enterprising reader to summarize the sharp =
edges of rerere that need polished? It could make an effective todo list to=
 aim for prior to 3.0. Here=E2=80=99s what I recall seeing:
> > - messaging is not clear
> > - usage for dealing with incorrect caches needs improvement (should be =
useable without expert intervention)
> >     - as a first step, perhaps having rerere and status display more in=
formation about possible steps to take (review results, keep or discard) wo=
uld help?

[On the chance that the reply was due to this wording]

Here, "keep or discard" were meant as possible actions to take on the
rerere resolution. Something like

git status
=E2=80=A6
file (recorded resolution reused)
=E2=80=A6
hint: To review the reused resolutions, run X
hint: To discard them, run Y
hint: Concluding the merge without discarding them will keep them.

or some such.

> - delete/modify conflicts are not recorded and replayed due to
>   safety concerns [*], but in practice, most of the time it seems
>   that the user wishes to re-resolve such a conflict to 'delete' the
>   path.
>
> [Footnote]
>
>  * The modification that is safe to discard when resolving the
>    conflict to remove the path today may not apply if the
>    modification to the path that is deleted is different and may
>    require a different resolution other than discarding it.

Was this intended as "another todo list item to work on"? If so, I'm
afraid I'm having trouble decoding what the issue that needs fixed is.
My nth re-read suggests that the sharp edge here is "delete/modify
conflicts often need re-resolution favoring delete" and that doing so
is not easy today?

--=20
D. Ben Knoble
