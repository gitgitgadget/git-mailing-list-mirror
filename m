Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE41AF4C1
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568340; cv=none; b=GbyrnTs0XDWmqVHK8lyzO5hh49U2bEj7TuQvXnjYuCrwvS0QuPwzYE3t+CeefEZ+66OGLkpa0+HR8Wvaz7JyIVuTpOf33rIfgNn93h3CxiNEbW9PXh5ETdp0tiJG4wFULTNbUhKKAtetPgIE8pJxMe9YTBEiHQpb9/qUvBl1Bac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568340; c=relaxed/simple;
	bh=drVJFdyjk+kHpEeYsVvQg0lPms1H8aFaYGpapAimPAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VI9c0fsMu9jY33a+ZG8y1IUjhfuAZysNXOeJFgd6O+1y4doDK4/ZNozac96X7GXJDXBQOwEaIYEfS4pPGS2YfgmzL3bjm9vyLyXcNivj6N9cUXscVDRk0pqaeCydjFrzrdtrP+2tzHddLNkq4xQq2+ivw3IdE44ygshPKABfh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMtE/NNH; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMtE/NNH"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e57010bc95so43955025ab.3
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755568338; x=1756173138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4jOMmcLvk+c16LehPzd31BHpsYGf4tRfQS2oFvGkgU=;
        b=OMtE/NNHdI5OCko7ouXI2KCdom5ZaDIL0goYr/ehMizjQMoDPSetcCJ2Y4/i6YXdPZ
         7m95SMRfYwV18uwuaC+lQ4WPl7kRILJugfACKMzHDyws+ykXRlVjSdisciF/x2KpvMaW
         ibT0+rHdtSt8vgQxlfJl6mEAuNm6784l2J0IhASnBx1jjh3uu9Up5GWv6tRnAYGdDDbt
         v6/krq084VaVQyccHKxk17f2nTWJSh8YZaioTAKgR6jINCGI2+YC39FGdwpIPiaHTu8d
         SVFqNhRrm4zb/dlkRqgL9TTwcmOWwXMfJ3j44VVi0m/Fj0Rel7nc9rU9fDragnmKOfXr
         j4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755568338; x=1756173138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4jOMmcLvk+c16LehPzd31BHpsYGf4tRfQS2oFvGkgU=;
        b=wkOrqWG75GYSody0u/uHH81HphlbM+n7lCRLL3qaFpXaguW4RsMlOh0+1hWpPxm2xO
         RDvpvP9hUDuw0KFXcXrU9PzuAFFkJO63r3RFEdwd2yNDdLyTWpmtLQH3iSxEk5CVqUPP
         QT0eAcvo7tnsImiB7mpQbNQ+KFlyDBNAuBVuQUxulxoduMce0+8e4XaEOXu7V7/m5Pa3
         3Pd/mC9g0hGBmfjaLsGzcKB+7ld5Mx8wc2MxkN90RUqiFRo7oceH22rVCMCGcr65abwz
         0gOya9ZefUkZyxsjTZv+gog64KSszP3Z16rDp4HcUZitGTQRQNKu5bzWPpKvU0AVFIcf
         5RVw==
X-Forwarded-Encrypted: i=1; AJvYcCWsxN7itRQaxFZ0Ssj07pjoC8ou4g1cKdtbRwM3/ouDcvHvtGLu4v2zEF+2TcEjBv+oadk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vLyV27zk09F5uuMUWKiLn5b9iHgeS5zcs8jR1ve0PZyZISzf
	/Va8nCNlHi67ejBn6UlEB0T8ylo13I+ow5P7V4ZPMYiyUmLAnXOZd49TPCJ4zn1vHlnOb1km9D4
	PyEd9yiA60ZIamT2wzCUm04XznW1kZvo=
X-Gm-Gg: ASbGncuBt+lmQooHs9KYt9E0gwezNy0As3ngYJk2M26FYERB/QWPcs5CJ75JpVgAL+K
	tAsGZabGeVoFu/8dButWWjcksJj17W4yACBW12dgBtTRNCaLPhQ6/Pg1N1o8Z/6r3tHKR17h6O6
	Rj9Kki4taWdbncmoKA5Itf2I4mXyfIwhUuFEMXnfVE676fsH7bwqKAy7nW4tTUTOwUcH5y2ljJG
	670L9b0A2OlsIO/3YcAH1gooc0r+FUcUNYxoYLF
X-Google-Smtp-Source: AGHT+IF4JrnqJ8OnRzHjvY+dXduXPx1uUrk6RR7+ogWXUiCzSgNIVIvETHi/3vnpQkEAwjAaIPwjaOunp1TXGkjrKNY=
X-Received: by 2002:a05:6e02:2591:b0:3e5:7dac:d690 with SMTP id
 e9e14a558f8ab-3e67663ebf6mr19941775ab.19.1755568337983; Mon, 18 Aug 2025
 18:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <xmqqldnggt2v.fsf@gitster.g>
In-Reply-To: <xmqqldnggt2v.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 18 Aug 2025 18:52:06 -0700
X-Gm-Features: Ac12FXyCQlE2Pd0XPVelZ-yLBw80RjE1ADDFmAOWzBGF4DIgHjN7jH9Jmn2aKWw
Message-ID: <CABPp-BGvQdrft62S_0_-pdReZCV_rdy=2X0Uebi4oa+-emW6mw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] RFC: Accelerate xdiff and begin its rustification
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Taylor Blau <me@ttaylorr.com>, 
	Christian Brabandt <cb@256bit.org>, Phillip Wood <phillip.wood123@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, 
	Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 3:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  * Code style: Should we adopt a Rust code style of some sort? Perhaps =
have
> >    the code always be formatted by rustfmt in its default configuration=
?
>
> Sounds sensible.  I'll let folks with more Rust inclination to
> figure out what _the_ style should be, but having _a_ style we all
> stick to is good.
>
> >  * Rust version: We are not using the same Rust version on all platform=
s in
> >    CI; 32-bit builds and Windows builds require a newer Rust version to
> >    successfully build.
>
> As long as we do not have to bend backwards on the code with "if
> using version X or older, use this alternative codepath" all over
> the place, "pick a version that works on each platform" that results
> in "due to the quality of ports, some platform's older port is
> unusable and newer version is required" is not too bad, especially
> for a system that is still rapidly getting improved and a bit on the
> unstable side, I think.
>
> >  * Performance with whitepsace flags: I originally intended to leave ou=
t the
> >    whitespace handling because I knew it was slower,...
>
> If the Rust guinea pig were different from how each line is hashed
> in xdiff, which is targetted by am/xdiff-hash-tweak topic, then we
> can leave out the whitespace-ignoring hashing from this topic
> altogether.
>
> Quite honestly, I do not like throwing away the other optimization
> efforts that can be reviewed and integrated trivially, but it is
> practically impossible to do so while still have a "let's start
> playing with Rust" topic that targets exactly the same area.  Yes,
> this topic licked the same corner of the cake first, but still,
> I was hoping that the second iteration of this series would use a
> different code paths as a Rust guinea pig.

I agree it would be nice to merge those down first.  One possibility
here would be having Ezekiel rebase his work on top of
am/xdiff-hash-tweak...

> After all, the primary objective of our first Rust topic is to set
> the framework right (like the platform and version support policies,
> how foreign interfaces like type systems get impedance-matched, what
> the impact to our build infrature looks like, etc.).  It would be a
> huge plus if it can at the same time demonstrate how much safer code
> we can write with less effort if we switched writing some (and
> gradually larger, posibly) parts in the language.
>
> The result this cover letter has in its title, 'accelerate xdiff',
> is not primarily due to use of Rust, is it?  As the other topic
> demonstrates, it is to use an implementation of a faster hash
> function (we can consider it to be an impressive technology
> demonstration that a rust reimplementation of original C code can be
> done in a very performant way).  And nobody is expecting that we
> would be using Rust for speed anyway, no?

You are correct that it is not due to Rust.  My original objective
that I tried to trick/coax/nerd-snipe/whatever Ezekiel into looking
into was cleaning up xdiff, to allow various features in `git replay`
and rebasing merges.  Ezekiel was interested in Rust and in a
challenge.  xdiff is quite a knot to untangle, and Ezekiel's been at
work on it for quite some time.  But, he happened to notice this
speedup, and found a way to turn it into a short series without all
his other patches.

We could perhaps shift focus, but I'm curious if you're wanting the
xdiff work to be thrown away or shelved in favor of some completely
different area of the code, or if perhaps some other aspects of the
xdiff code would still be amenable.

One big challenge in finding another area, whether in xdiff or
elsewhere, is that Ezekiel really wants to showcase how nice Rust's
unittesting is, but that only works if we start at a low-level and
build up.  If we make Rust code call C code, that'd either not be
readily unit-testable, or would require us stubbing out the entire
implementation behind that C interface or doing something more
complex.

What if Ezekiel rebased his series on am/xdiff-hash-tweak, and then
instead of further modifying the hashing in the first series, he:
  - introduced brian's patch with the platform support
  - setup the CI builds to test building with Rust (including Johannes' pat=
ches)
  - started working on transitioning xdfile_t data structure to be FFI frie=
ndly

One issue here is that it probably wouldn't be too long before we'd
want to rip out the xdlclassifier struct (mostly a glorified
hashtable), which is kind of tied up in a knot with the hashing and
line equality, so it would probably only be a few more series down the
road before we'd want to start tweaking the code in
am/xdiff-hash-tweak to make use of the new data structures.  Would
that be agreeable?
