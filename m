Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6CA923
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880534; cv=none; b=cb7Rd8yLrzmweHpl3tYPeS3fmq3hd24I2SC5ryzp3yxU80ib1SnsRRrTM5j7aiDdd2ZTul5MHms+U+T4mouCmkCDNT2ckzdeUuwMUFEUt91CDysns76vw5cnZF66Yb0pw7Oy5k76az/R8mf+PDorRhYgKkj+xm6LDedov7oNMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880534; c=relaxed/simple;
	bh=+/8ezc2ZZLw7zFm+4y4EmuAqhVAl7H+Zy1BHCyQCe7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YhzkPP3qbXCIYlwLx1XRvaowpTJX4F1bakG5uhgiSHhA1CI/AFkww5GjHm5MBwU9cta/j/Yx1uzNSN/RVsuB6cfHdX5fffOg9ERWeiOdsuXiJq4x9BOQ2P7iUL/2cu2gYhrJYW2igAIOc4nC4vJ0YDu285KwehQ0BdHKT6a5WWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGMgWN/b; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGMgWN/b"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso23134871fa.0
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752880530; x=1753485330; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2mOekn1v0Qpd97KsPsfBJadNBtNaMmSpXLnEXTfyGA=;
        b=PGMgWN/bMTb8erotkiJv0VcUjHxeljZ0y8I+RBIwz2PKkI5qArz6+sKh/Xp/IAhlRT
         plj7yxdE+Z9TTLwVQoARBAu7bRSJFByyI0tQX9tMoQN810ioDof3UndG4ZLT349482RW
         8eiXJ2CmRBNPeheRbuvpyk6ZoUXlH0m2rdceGDxMTlf+aE5lulleMmkXayfpVm1rntx8
         QQh2hhrq863HyxsrhiktycZKECmI4UIJPrpdQDVTzq4Y1Hk1vwyYQWw2rQUdWf5+1TGH
         D0VllFNONyNXl5YNXu9i8afk/X8nnWcQXk7Qtgzl6G/6HwKTMV5tGrCno+p+dLCoDra+
         l74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752880530; x=1753485330;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2mOekn1v0Qpd97KsPsfBJadNBtNaMmSpXLnEXTfyGA=;
        b=Pqldav6cPYJjKBunlktkliZs2m+/QRwgelR5m96qZP4cmmm16Ix5tMjrVzMW+Pd65y
         /VWRY0fY82LmMTUo3og6q7V6bUrto0J9o/EbXHqi+/3xQTPlBpLAW2BftnAstFntu5oI
         uFaX1NTSH93altCSl5RWdH8FVIJnSH94U1qdZrUBJEKjR0dkd2CNFnIHyvYPVMfvK5cH
         PNKc2vnfMDNdDAa6awjAkxGN5JpFMtvX25UijT0hT0r5Nd7MbfsYORo4mfzS6Nz6EGy0
         7gS8b8C8BvAGN+eC7iMV2aLTQJOoyptw5kU7JX86bjMkn8XAunPc9W+S3F/uA/MNKPr7
         IAew==
X-Forwarded-Encrypted: i=1; AJvYcCUL3UxbD7gV5SEf5r8TpYKe29WBpLoFnBg7I/Kn/WmqPcBcsZWOxd2RZMrBC/16x9N9F5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1REV+B7//UoFWBMN27paPJ+/Py6mVQKjuejXmta0fcm42wP5
	m2gnXTIQL6uBokTrQjSO5HgXfu5DWhQ2w/Xv0Sikh11DlL4KjHu2sazR4fCNns1ZjLRbEkh0OvT
	vwDRBnRnF5rG3odVTvT/03lb5O9JU9gA=
X-Gm-Gg: ASbGncuUg4VdkP+jX2Xa87PltFg+qJROSIbo8Qul7OZmyTREBz81ki0IKYBdcWGN0jP
	jnc/edeHSGuX/Zz28PnPd73fYXE/GXJ/MxGzrAqtvAIENcYevp0Ydp9e6Zd4m//rDlJgl++5y6T
	Ksyd3ozFk1tMRUOi+/jFl0HTZqZUjSS8ziycMLYXwE+pM2GMuANAyc6PtWNleLogyys0loBvTte
	4bhKSaH
X-Google-Smtp-Source: AGHT+IHmLCsj9/uEkBumaRIl79c4v8kp2YgwEZDfNniHwlsPSD1tRKGbTQBfsWh+Ut/+eQfC0YMVqaf0jwpiW7wtvzQ=
X-Received: by 2002:a05:651c:620:b0:32b:9418:6051 with SMTP id
 38308e7fff4ca-3308f5def4dmr30996331fa.23.1752880530323; Fri, 18 Jul 2025
 16:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <2a1f4be13dfbdee21811b7a4907f99042c791c2d.1752784344.git.gitgitgadget@gmail.com>
 <aHlrg7pbFqi2qNWH@fruit.crustytoothpaste.net>
In-Reply-To: <aHlrg7pbFqi2qNWH@fruit.crustytoothpaste.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 18 Jul 2025 17:15:19 -0600
X-Gm-Features: Ac12FXwyHW1ZwYPS1DMt5-rF34hmFkmA7Sf7JqmUzWL66njUeP4Hd6-kmTItCgI
Message-ID: <CAH=ZcbBebM6CememqOUFY2YPOXpk_mC=zE0OnLOKDqcJQTdMuA@mail.gmail.com>
Subject: Re: [PATCH 1/7] xdiff: introduce rust
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:30=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-07-17 at 20:32:18, Ezekiel Newren via GitGitGadget wrote:
> > diff --git a/rust/Cargo.lock b/rust/Cargo.lock
> > new file mode 100644
> > index 000000000000..fb1eac690b39
> > --- /dev/null
> > +++ b/rust/Cargo.lock
> > @@ -0,0 +1,14 @@
> > +# This file is automatically @generated by Cargo.
> > +# It is not intended for manual editing.
> > +version =3D 4
> > +
> > +[[package]]
> > +name =3D "interop"
> > +version =3D "0.1.0"
> > +
> > +[[package]]
> > +name =3D "xdiff"
> > +version =3D "0.1.0"
> > +dependencies =3D [
> > + "interop",
> > +]
>
> I would prefer that we not check in Cargo.lock in Git.  Part of the
> reason is that it changes across versions and so building with a
> different version of the toolchain can update the file.

This goes against what I think is best practices.  Don=E2=80=99t we need
Cargo.lock to audit and debug platform specific issues, and to ensure
reproducibility?  Without Cargo.lock, we might get different results
one minute to the next if one of our dependencies releases a new
version. Checking in Cargo.lock aligns with Cargo=E2=80=99s documented best
practices (https://doc.rust-lang.org/cargo/faq.html#why-have-cargolock-in-v=
ersion-control).


> In addition, as I mentioned downthread, because our intention is to
> support the Debian stable toolchain for a year after the new stable
> release, unless we are exceptionally careful about dependencies, we may
> end up with a case where distros need to use older dependencies patched
> for security but other users may want to update the versions to newer
> dependencies with security fixes but that do not work on our pinned Rust
> version.  We can't possibly satisfy both sets of people if we pin
> dependencies in Cargo.lock, so we probably want to avoid checking it in
> and ignore it instead.

I understand your concern and I agree that this could become a
problem. I=E2=80=99m totally flexible on which rust version should be used,
but without Cargo.lock checked in we lose the ability to audit why a
build failed. I think that this will be a pain point, but numbing that
pain means we can=E2=80=99t solve intermittent problems due to dependencies=
 in
the future.

> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
