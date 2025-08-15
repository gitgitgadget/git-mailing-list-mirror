Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE6D28399
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295933; cv=none; b=kUNWp0ydW/dt87Ez5sqRd8bSrFhzmzMXfr35T398pXXjFBsjcmuy3vwK+yqRNPUSNXNY++PPvhSoNtiqMSmbpUDsroWsDZaA7xnk5JUZHMitcyd/pH0Hz9C2lmaJMtnnt7v3hYmR6ERLiMxEL+Sajy0dVW7oRoH4GpbzqZobqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295933; c=relaxed/simple;
	bh=k+F+f9C9JY+MV0WZpoOFJoGy8eEgLHiq6Xa3GYx/ahY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H8csHEMH2tDoqSUDodxAfp5Ku9sFCJZT7c3GwZgjCbEot1oyNqt4y2geYkAOrpN/GTtxpafFl3xuuoAQGh2u3hPyH2MYLm3tckxkuj9dPvgvXz6ly43oMyyKQb4lvxsuir6ntTAxAQR3UKUlQELSw3OTZlH3J+M/HWxFfoNhLmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=E+qyagwj; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="E+qyagwj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755295912; x=1755900712;
	i=johannes.schindelin@gmx.de;
	bh=9a+fxk1zPeVLyfQCwi1YKjBKgJGOrAXkZAlt8tLevf0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E+qyagwjLiuZeiFrb+BbfzVWUvo9NdTY5suG8so4oZ3Kw5FcIwfSxayiJ0Af+QoX
	 BewCoAqsf1IdIyx+Pw9ACAE8VH5z+u8JjynqJYNvbpOzKohtYoeKKiuG0t/Pc+DlL
	 d94cfTvcEsNCFeTgukFzbV4ontVRdeG/Qba1019bvfU9ESpXOfaP/Q2bThjIjFWzp
	 1V7KVHUiKkwvAByKE6H6dAzepRU/Jq/J01zN3uY1SFEAFBsbLcru+v0oO4PqsYKq/
	 d/Awe0C45bsf5Bh/sfBvhLYiNlatobquIuy0mMBI9C+qm+JrTA4oPnJdTqsetL5ll
	 OGZEfD4rjQD7z3Jsww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.154]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHG8m-1urOES0qQK-007DEC; Sat, 16
 Aug 2025 00:11:52 +0200
Date: Sat, 16 Aug 2025 00:11:46 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Eli Schwartz <eschwartz@gentoo.org>, 
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
    Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, 
    Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>, 
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
    Ben Knoble <ben.knoble@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 09/17] Do support Windows again after requiring Rust
In-Reply-To: <xmqq349sntms.fsf@gitster.g>
Message-ID: <2ce3f7ee-62d0-9ddc-761e-31dc30109db5@gmx.de>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <96041a10d545e0e431d05b93544771c6bdfc06f1.1755220973.git.gitgitgadget@gmail.com> <DB9P250MB0692900F30A3E71E4F01DFFFA534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <xmqq349sntms.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1917944081-1755295912=:14038"
X-Provags-ID: V03:K1:rU0fOJWNIuGY8vMFhHpjk1zZgKKTIG/ZnCgsQv4GKbbCE7ba34g
 YuiQdktQW2T2iYqSmf1d32EjNA2woONxnQNvnPgJGQcme4eRQ+Qgj/EpwopH4bzxHuQVMuC
 AXwi7IMSBdz8CIynGPCqYLACOdouiQ1VJYbMS/3xV8mBRycg+sHPuHH4e3iksL1a9e5fjOu
 v7xtq+IScUi6bo2ctSrMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Axal9eIujbM=;yfwU8Vlm2+Ej5FCrLje9vgWSMoe
 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
 Ig6zatis/Vwo3DnqebMT6xbxaQxW

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1917944081-1755295912=:14038
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 15 Aug 2025, Junio C Hamano wrote:

> Matthias A=C3=9Fhauer <mha1993@live.de> writes:
>=20
> >>         ifeq (MINGW64,$(MSYSTEM))
> >> 		prefix =3D /mingw64
> >> 		HOST_CPU =3D x86_64
> >> 		BASIC_LDFLAGS +=3D -Wl,--pic-executable,-e,mainCRTStartup
> >> +		CARGO_BUILD_TARGET =3D x86_64-pc-windows-gnu
> >
> > I've said it when Johannes originally sent this patch[1], but it bears
> > repeating: The *-pc-windows-gnu targets will pass CI, but would mean
> > raising the required Windows version from 8.1 to 10. We'd want to use
> > the *-win7-windows-gnu targets[2] to keep Windows 8.1 supported.
>=20
> It seems that Dscho did not respond on the list to your initial
> objection in the discussion you cited.

I would have hoped that it is clear by now that Matthias is as much to be
trusted with Git for Windows concerns as I am (just like the other active
Git for Windows contributors, if you can get them onto this here mailing
list). Just in case that it really needs my explicit ACK: What he said
about Windows 8.1 support in Git for Windows is accurate.

> I do not think we spell out which releases of various platforms are
> still supported by us (we do list requirements for platforms in the
> Platform Support Policy document, though), but in general we should
> not be attempting to give extended support to systems that the
> vendor no longer supports.  As Windows 8.1 is no longer supported by
> Microsoft since Jan 2023, and Windows 10 will go out of support in a
> few month after Oct 2025, if I am reading the table correctly, so as
> long as we document our intention of dropping a commercial system
> that is no longer supported by its vender clearly, I do not mind the
> above that discards 8.1 [*].

While there is obviously some connection between the official EOL of
Windows versions (see https://endoflife.date/windows) and which versions
Git for Windows supports, the balance we try to strike (and by "we" I
don't apply the pluralis majestatis, it is very much a consensus between
all active Git for Windows contributors, including Matthias and myself) is
to support older Windows versions as much as can be done with a reasonable
amount of effort (where "reasonable" is obviously as subjective as the
definition of "taste").

The consensus of what Windows versions can be reasonably supported is
documented at https://gitforwindows.org/requirements.html#windows-version.
Currently that is =E2=80=94 you may have guessed it =E2=80=94 as Matthias =
has stated: Git
for Windows will support Windows 8.1 for the time being. The hope is that
we will be able to notify users when support for that version will be
phased out well in advance, much as we did for Windows 7 and 8, where
deprecation notices were included in the release notes of several Git for
Windows versions prior to v2.46.2, which was the last Git for Windows
version to support Windows 7 and 8.

> But I may be biased, as I do not live in the Microsoft ecosystem.

You do point that out frequently, so I believe that you made the point.

Personally, I would like to see a more open-minded approach here.

Ciao,
Johannes

--8323328-1917944081-1755295912=:14038--
