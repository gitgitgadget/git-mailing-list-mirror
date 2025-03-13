Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB6213C689
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886162; cv=none; b=JcyJOm+0bY4KFL7ccySg4Mc9lsJwCWDquRfVJlSCgZ2VwdAPdvDGBqniRCDudPUPQ/UO7muFxz/5xeBVEmz8EqrITswcBj6mSODLl6e/w07fV783SC1ynjayLx9DSIr+qeThjwBacT70viK9dKWR5cXENBV4k/4dZAqXkgsppWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886162; c=relaxed/simple;
	bh=ga/onxocYy2+QWcRIEjg8raRSPFuSS/HMiJZ5RHhsRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbYRwu28FT9joG5UW5NcZZvL3O/a9l/iATogESCbrIWUYYNR+W8zLlDvivRRmZKoFm2JIy8ZWnl1OAuGtTEJ4mVD1q75t/cPUWAjD/DLV6VzrAaDUyhhrR/ROTvJaw1DiETVREWJyh6eiO3OfYYApNDllqvNiHj/DKu4VvvNlMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQywS05Y; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQywS05Y"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso85947639f.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741886160; x=1742490960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSX6ndN3WtJZuz542zGS1NzH6bnyeb/tGP/N2RE2Ueo=;
        b=SQywS05YOhOiVvofkL/3vVRl7AEPZb67GO6pmXc8+Nbic+pWozkMaDWnnGLFpzMlZZ
         k57Z8Yj32fiVqiD4vrJW94kMSKMu9qh9XrnzbB2z4GZDBRcgIqiYG2iKb7ySDjsFzUkY
         XIvVU1AwDjeoGuOYlV34NDgtgTAxwehcwY34tBVvjvO+h5lm7yhOcpG3aClBbRKwqFcF
         flEm7Gz4espfh9FzPn5ct+wwOPLqJDYouzrC5Vs1WhXYBXxUXHrVxWRWEsenhgjZ/JUp
         PoxehfiBmzf1uTqKJdOR4RJPCbU7gcU7ex2Ut4S+KUDWOFhk4m9SYf+1EJp7jINTy3vz
         haUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886160; x=1742490960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSX6ndN3WtJZuz542zGS1NzH6bnyeb/tGP/N2RE2Ueo=;
        b=j8q3cEze7sL2c/F53x4nI542ZCEY+equI4k0emU2X6Pbca1juUTdDFfnx/4BL84oVh
         bXd+H5vneMCGm4d7jsrudU7ZeN3qmn+BQlnIyn2z38Dge3TmH6jNxTlkHDCHmBqEXjl1
         NSYzwUBfxKE1VqvksP8kbOFeL1KyPVSf5NaJyXVqPjPY5hak+3Y1mBNq4ddvfE1e0gqs
         00UWMO8qCmqpjzQKPEESo4ZyxTW2+mYu2DRC9cMQuuEHnTVERr2Am1F0Fa2z43jJQGUe
         4LJIyTXto04Oq0ZjHFrT9InRzRF8V00HaUuExYQw3SgZW/yC9zsymQeyep8oe6HhZYFq
         2qkg==
X-Forwarded-Encrypted: i=1; AJvYcCVjL1E/TFf8RKTSNOKmBGkTg6F7ZyuNHTpG+xLyIEpfyjuTfBLRyFTHr82FaaB2H9VItAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Pkysml+vKj0LSVbJh39pcOsWxn62BOIWYak7T99KqEFcCCJI
	Qb+ohMBv/3fm72pctU5sizsai5mRA6W7vVvouavkfK7MTcZTvXJ/c7RLrALA1htIWNg2fKfQWA1
	Zc152BaLQeRgokIo6exaackMuhj4=
X-Gm-Gg: ASbGnctkQEdIvxCnkKAcusVAVpSEmU1fqjWOe4RGPjeuhSzXy8DbRrSRI1GAEqBOWRg
	te7jvVeLInDiyhT9odPbD5noT+nnW7gQsOhDKZNzEPutiFfx6Z3eje68i5xu0cztWd8F3Q4tGAD
	g2eUhuv0aA0C93V18ERMwwoqxicTJKrTigQl3fuodiJpTnyoMA4Aba0ccl2AU=
X-Google-Smtp-Source: AGHT+IFGyVpsyT91TLfGIEay7pRP9Tc/aJeFOQQClpD+mkhSmEqYPMxkdJAzaIWEkfGLwAEO1OrK1fDMEs2mxM2X938=
X-Received: by 2002:a05:6e02:3890:b0:3d4:4010:4eff with SMTP id
 e9e14a558f8ab-3d468935c03mr130775725ab.13.1741886160161; Thu, 13 Mar 2025
 10:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
 <f48b3310d4ae8d05780fd25e467083c4dc9852cc.1741275027.git.gitgitgadget@gmail.com>
 <Z9ID/2zx25qesuJs@nand.local> <CABPp-BH+9JcP6FDP6RFQzZbwW=XOWnWAR8PmrCS6hG4iyd2pPQ@mail.gmail.com>
 <xmqqr031x2gg.fsf@gitster.g> <CABPp-BF7iTvqKFvuOZ5wZ3vZADjCvB63iKR-4D5+WeTxnZGThg@mail.gmail.com>
 <xmqqbju4q39j.fsf@gitster.g>
In-Reply-To: <xmqqbju4q39j.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Mar 2025 10:15:49 -0700
X-Gm-Features: AQ5f1JqQi2W7O6cy2Uiw242R4pKwkZOnmu8BOWRdaLFG2_orPowkoC9zwzV_pe4
Message-ID: <CABPp-BF01a8bEZ2mfp7H_=HKsv6mSE4+ee8bi9D9xKWbH=0b5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge-ort: fix slightly overzealous assertion for rename-to-self
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Dmitry Goncharov <dgoncharov@users.sf.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 9:55=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, Mar 12, 2025 at 4:18=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > But it might be worth mentioning that having side-effects in
> >> > assertions is a huge no-no, and I understand that when folks have to
> >> > debug one of those (I had to in a separate project years ago which w=
as
> >> > kind of nasty), that they sometimes jump to the conclusion that
> >> > assertions are bad.
> >>
> >> Yes, assert() invites such mistakes.  Why not avoid them when there
> >> are better alternatives like "if (condition) BUG()"?
> >
> > I mean, I just gave my reasons above which you snipped out.  But if
> > you feel it is important for folks to move away from assert(), would
> > you like to see someone create a better alternative to assert, such as
> > BUG_ON(condition), so that they have reason to want to switch?
>
> You said "BUG_ON()" is better than "if (condition) BUG()", but I do
> not see a reason why.  It also shares the same problem with assert()
> if we make it honor NDEBUG.

"if (condition) BUG()" is invalid; it needs more arguments.  "if
(condition) BUG(something)" requires a separate "something", which
requires awkward additional wording and/or is needlessly duplicative.

If you don't want to see assert in the codebase because of NDEBUG,
then obviously we'd leave NDEBUG out of BUG_ON().

Such a BUG_ON() would be an improvement because it maintains the
ergonomics of assert() while avoiding the potential mistake of
accidentally including something with side-effects.  "If (condition)
BUG(something)" doesn't preserve the ergonomics and is thus worse,
IMO.  (Personally, I still like having cheap checks that are okay to
compile out, but if we want a project directive against those, then I
think a BUG_ON() that doesn't depend on NDEBUG would be the way to
move in that direction.)
