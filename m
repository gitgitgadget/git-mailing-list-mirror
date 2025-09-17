Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A7305956
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096244; cv=none; b=cenpfFJJWB9QWkhC1wCO2sq5peelFblO5O8V04K1BcSDUySb4F7KakPn7EDl0QjD+Yfg7GsGMEay+s9H8Wom7jprVnD4q9YkyJwskusj+UwxZ4c/Xsg1F8/4GUTkWfQwi5wbPTGe2bTJfFkO0AsxZU9lyrIfTnArQ4I5S0WfOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096244; c=relaxed/simple;
	bh=IlUXuTQ3XSd187SKyHtxJFHoEs2DPinzLYXc0qtvUdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTLC1ZXfBNtNuTVArXD/nJS2vaaNli4w2+lFY8o7qFnh0+IRANlnkwkc0mcDMTj//ICld7pQwOxoAwQQHRAC6OjRXaQ294+UIfJlNFY98ZwYCBQ7RfS5zq0U9BIUXxBiwDu3QcSHO4D9xe2hDsIWAD+vdgc9SePdCjwb4XQtrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8FYMX/z; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8FYMX/z"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-577dd4c1e84so280991e87.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758096240; x=1758701040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlUXuTQ3XSd187SKyHtxJFHoEs2DPinzLYXc0qtvUdE=;
        b=Y8FYMX/zdN6/X6anLnLm4AE2HYVFYUK/AGoYSgN5SnnvT9jB0DAYE+rkNgz55yLCuJ
         YH9ZBjbzJQc603G28hP1yVubf2J5BXoMReLZBkaWmUzJf9pTBMaDfiWIA4oen/Ejr+1h
         leXFkOoKvtQNcSA8Zzxpc3VE7O0W//dScNeYVtXuqlxajVsApwDNZf8TPqCPkDiRU11l
         xY1gMMZjykywu4hNw7FE3K0YlMg3bXh2128FznhE95riNtB89BkQ36VzIg2TRVxmbn9z
         OjvLY5I7t66XTcnLvWVlP9V/X5BWttJ2Af0DOLAvaciGYuRYhDRzj+aWT+IITe9CIy6o
         GlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096240; x=1758701040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlUXuTQ3XSd187SKyHtxJFHoEs2DPinzLYXc0qtvUdE=;
        b=An9cZE5grJqv9giEkckWX1gFEZEzuG8anHl00blt80YWzMslUfDivHNeuYimcP6IGt
         kgSnkxjsY2Q2rzwGx80QXIiv9BvnIieSjps0g7GZCl9dnDepzLs8tXdjjsYEmV9OBlui
         YE6j+ZZrXBuUTgNXJsFdCxvbrMMTJCKXPF5qy3IMmZ5/0BJSnUHZ3WCTqHE/lcX+5oQT
         5f6bE4L7BRe3Nn5gKFvTdibIznqOVjUkY1pNOdxJ1AcP9Paycd0a9gzuvHMGG4t0h3gD
         kTvc5qJvYyG8JcKAbI7Lyp67+Zyd4AT86VBUgTvHwp5OGdApOKFlX/abli7aMc33FBhA
         T+1g==
X-Gm-Message-State: AOJu0Yy02vf+TtgqwbLE0x4JbzqY1Df+MjNUmzcuSVRTLMun07rPeM0/
	nC1GBQzscYtXgMvGU1Hb9C4W44SbXyC2Ibrix9n57njSUr1zoWduO3CBk/qPE3ktoUjFj3lDfV5
	NKR/FKAUUi49ne0o2j5QXC+OoNtXxLD8bFpJf
X-Gm-Gg: ASbGnctii28ARRL0TTBD7hjfg5bGlMuHkZWS9FaVIRQYLCkreuCQOzLt05A/AxlqfvQ
	kElnnFdRzZjYEo4a1aGRK2wb4n835RfGCW4Ae6hTxTInGbNDSja48vOatPgB88Mvw64kWsdBTe7
	mitKQfGkd8kQomyo3f06ki6Im9QbMwTevH3ESTvg8P8LWpJ4tK83tCqbknWTM607CmXg8poohm1
	GXwoCJz
X-Google-Smtp-Source: AGHT+IHRDpKgUngbLOegvMnImMKUHNS6CEFQnx9BRyWj4jJ7ia/WF1vyUHIy1t2otMnDBXMf2SDWo5anmNP+rjaF180=
X-Received: by 2002:ac2:4e04:0:b0:56a:4f7:6756 with SMTP id
 2adb3069b0e04-577996f1529mr396505e87.9.1758096239350; Wed, 17 Sep 2025
 01:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8e1905c7-7744-444f-9a39-ca809edb6896@anselmschueler.com> <c28bff47-04ef-4568-8dc3-add99f52209a@anselmschueler.com>
In-Reply-To: <c28bff47-04ef-4568-8dc3-add99f52209a@anselmschueler.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 17 Sep 2025 01:03:47 -0700
X-Gm-Features: AS18NWDR7Xc_Ouj083_EZac8Qg_a6MVC-jA1I6KOPJ3it6mf0ssmovzebtVIfrU
Message-ID: <CAPx1Gvdnz=PjF7viakFmYUSL72aQS83O9c8NWBCz_1Nt7z2V-Q@mail.gmail.com>
Subject: Re: Why does git-status suggest different commands to unstage files
 depending on whether there is a commit yet or not?
To: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resend as plain text]

On Tue, Sep 16, 2025 at 2:53=E2=80=AFPM Anselm Sch=C3=BCler <mail@anselmsch=
ueler.com> wrote:
> ... I would=E2=80=99ve assumed git-rm simply removes the file
> and =E2=80=9Cwrites=E2=80=9D that removal to the staged changes.

More precisely, it removes the file from the working tree
and removes the index entry that would cause the index
copy of the file to be in the next commit.

> This seems to be what y=E2=80=99all are
> describing. But with that suggestion, I was confused, because I assumed
> git-rm there would be equivalent in some sense to git-restore in a
> repository with commits.
>
> Could git-restore be made to work anyway, by =E2=80=9Cimagining=E2=80=9D =
a
> pre-initial-commit commit that has absolutely nothing in it?

Yes, and in fact a number of Git internal operations work this
way, by pretending the commit before the first commit has as
its tree the empty tree. If `git restore` did that here it would
Just Work. (This is part of why the empty tree always seems
to exist.)

Whether this is a Good Idea, I leave to others to judge, as
I'm too well steeped in Git internals to tell any more. :-)

Chris
