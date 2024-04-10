Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39C155732
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740604; cv=none; b=NVdlhQGm6cbYuTXpfGgtds9mJdmKv1vufVWEFBZnuiqhVSx8JoA0s95OaCjXevBvMM59N3AVFJZFBk6e7kEOTgun8ag3edL8bQTGZ0/pDg6SCuCtuEVlXPCUapCQ6OohBHoqOkT+JbOziSuYoOWzzSs/7YPya+Mkx2c3V6BIM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740604; c=relaxed/simple;
	bh=9AtqVPiqGCd0xUV1c5T1LFFz72Ij603I1uqQVlJnTq4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bL1Otf51dXuViW4xSCOCijkO38P103Ji9o6t18WTczjc891YxTIeNomxVZP5WmJf2uDEHj6hBIUmq5TXMpARhz4WhjTl2mwjznknkE3sulgog2hBqEM4mn4DBKPNQCgyusywT4zrGbWTTUYjIv7Ww+vnZMlcAK+9KqmRVLbGkV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=DokehW/K; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="DokehW/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712740595; x=1712999795;
	bh=9AtqVPiqGCd0xUV1c5T1LFFz72Ij603I1uqQVlJnTq4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DokehW/KXrU5rlL/6GHNbA+L0Co5suvMCWkjfjeBuCr6XBk96aETghV1e+gLCJt43
	 FNfyPPTm4qBeTIxiWltlIt3PAoQBIHPwa52CDjkV61q3XEY5AwvM5Gd5tA0we+q5M0
	 HMCF71vaLdOXMsUwrzIfjj0ps1ifpgmpPWD3T4CrhSps//TQj8pKxxqmv9OlU74KZM
	 hQIBZ1cA31fe4/baR1dEW8dU4keht+t6LBlBh6i1YDV+C8r249QyWL7D5kTkXnCXDZ
	 v4/PFKwyEjkuiwpkDnFYdgllTi01wx+Ic2rqguuVJJhlbXwvlWO6Qepkzy4bW9zWPX
	 eitCT/ft256cA==
Date: Wed, 10 Apr 2024 09:16:24 +0000
To: Chris Torek <chris.torek@gmail.com>
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/8] fast-import: tighten path unquoting
Message-ID: <DF42695D-2FA3-425C-B553-FF33D653CCCC@archibald.dev>
In-Reply-To: <CAPx1GvfUs-dR_RbqnBT3YhDJPMB7b=+fzyow8qjJgJQnJwg0Pw@mail.gmail.com>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <e790bdf714bb4c2a67708c016a97cf4f9e79ac48.1711960552.git.thalia@archibald.dev> <ZhYxNYR33ftEfcPk@tanuki> <CAPx1GvfgC46n_5fk3dHxg7dn393UVMi0CtHKqQ_GAaqnV_ECCQ@mail.gmail.com> <784B5318-F155-4D93-8085-62ACA63432E5@archibald.dev> <CAPx1GvfUs-dR_RbqnBT3YhDJPMB7b=+fzyow8qjJgJQnJwg0Pw@mail.gmail.com>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Apr 10, 2024, at 02:14, Thalia Archibald <thalia@archibald.dev> wrote:
> On Apr 10, 2024, at 01:51, Chris Torek <chris.torek@gmail.com> wrote:
>> On Wed, Apr 10, 2024 at 1:47=E2=80=AFAM Thalia Archibald <thalia@archiba=
ld.dev> wrote:
>>> strchrnul does what I want here and I=E2=80=99ve replaced it with that.
>>=20
>> `strchrnul` is a GNU extension (found on a lot of systems, but not
>> part of C90 or C99).
>=20
> I can=E2=80=99t speak to Git standards, but it seems broadly used in Git,=
 including
> three times already in fast-import.

=E2=80=A6 and that would be because it is supplied when unavailable:

git-compat-util.h

#ifndef HAVE_STRCHRNUL
#define strchrnul gitstrchrnul
static inline char *gitstrchrnul(const char *s, int c)
{
=09while (*s && *s !=3D c)
=09=09s++;
=09return (char *)s;
}
#endif

Thalia
