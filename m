Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E05383982
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323759; cv=none; b=K6MgReCEMFwY1cBpZz4sGJcZawRigKPMqMT0BkX6vRkRtQLtLP/lytY+bm8FJ27lr6gCyaOdy+yan6/B1vOFUsU+AdYVN0ry6e+E8wHxvBn6D4x0eeL7yBfyFysj2czHdvq1gLg4Uz0gWbSGL55khDQw+PI4YiiZUmXBhH3Q1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323759; c=relaxed/simple;
	bh=7fnP5+9PRd8uuhaw9eo91HwN0Fbe+krKAmxJGdzBRco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S48HXa5KVO2y3AmaRZCCWLwq5//nFdkqQ4LN3im6n+yARVndvdPmiEgaymlxThXkqOXgFU4eTMpBzIXpjOtfwem4hRp70nwPR7eQScCORarFsI131IWaNOWUu3gHoN/HD7OgcSZofbfVn4KJW14EG4LOOJCzPE42kfpD36aKPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hAWVEGXO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hAWVEGXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1791323755;
	bh=7fnP5+9PRd8uuhaw9eo91HwN0Fbe+krKAmxJGdzBRco=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hAWVEGXOYTobmVIfNa/06Yj9KLotYZGMaiirLTyfqvG2J2eNYSp0Z/mdllQrFpT5M
	 GJhhwEEO3Z75FqB+UbRpbTa4yMseWptsNA33MVsn/2HM6Yrw4pAhe9iLtUvzBCT+a2
	 1JYjYQ8EFf0ZmvoT6GtPpgFOXdRIzCyoZbfXCEHBYgHs+maQzCBIPatBwAkP6wUgSD
	 p+bdxFwWYZ6iFktiQKoilo/WcvQh6T0Entl1Ob3yqDZDaFPOKEiCoEaxuV0C7mq2OX
	 RgolD4DUiXcaw/4Y+uR25KAKJnbzAWOq/2qYzvjE/BudDZSwnSPCLhKZtmmUoB6WhH
	 8c+VK7lP6KwjlBexqQSeoXxjzLKoxmKzkx/sqq8CKVY8yv+mSrwcrs+/BG2I/dbrcK
	 /jn3waBaHu70f5PheGiqJ+9CTiFCDaJdqVQIblz6Kg0TdvSL5DHzpTk0DSSC+O1T0K
	 FUT+mEBT3VdjLU9jbqO7ZMZjtDf6CJAbrJtDWVzcMoEwgREpbc0
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1808:f548:d307:7e36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8A8EE20077;
	Tue,  6 Oct 2026 21:55:55 +0000 (UTC)
Date: Tue, 6 Oct 2026 21:55:54 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Scott Chacon <scott@gitbutler.net>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and
 tags
Message-ID: <asVuadq79SNc-1y1@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>, Scott Chacon <scott@gitbutler.net>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
References: <20261002081846.25144-1-scott@gitbutler.net>
 <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
 <CAP2yMaKF4CRvtfTQDVe51SqEm_DnoVOmED5kcUSg7UvLkBp4Xg@mail.gmail.com>
 <asOa6dgpj0qV5QAU@pks.im>
 <d59dfe7e-5958-4a72-92d7-788521f3e55f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5E8R5rDBEyPnh/8D"
Content-Disposition: inline
In-Reply-To: <d59dfe7e-5958-4a72-92d7-788521f3e55f@app.fastmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--5E8R5rDBEyPnh/8D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-06 at 16:16:07, Kristoffer Haugsbakk wrote:
> And that was okay. The Git repo seems to have a bit of cruft, and
> git-fast-export(1) fails on the first error then suggests a fix so that
> you can continue on to the next error. But that=E2=80=99s fine for a one-=
shot
> program. For anyone interested:
>=20
>     git fast-export --all --reencode=3Dyes --mark-tags \
>         --signed-tags=3Dverbatim \
>         --tag-of-filtered-object=3Drewrite >SHA1HERE
>=20
> Some real loss of fidelity was there though:
>=20
> 1. You can=E2=80=99t for some reason export refs that point to blobs or t=
rees
> 2. Your Git notes will be effectively lost since they will retain their
>    SHA-1 filenames. (This is mentioned in hash-function-transition)
>=20
> Then you import it with
>=20
>     git fast-import
>=20
> But to no one=E2=80=99s surprise (here) this does not work because of the=
 SHA-1
> collision submodule.

We actually have support for rewriting submodules in fast-export and
fast-import.  It's a little fussy because you have to rewrite all the
submodules before you rewrite the main repository, but it works.  Here's
a command to handle git.git:

----
#!/bin/sh

temp=3D$(mktemp -d)
trap 'rm -fr "$temp"' EXIT

GIT_LOCATION=3D"$1"
RESULT=3D"$2"

git -C "$GIT_LOCATION/sha1collisiondetection" fast-export --signed-tags=3Dv=
erbatim --tag-of-filtered-object=3Ddrop --export-marks=3D"$temp/sha1dc-sha1=
=2Emarks" --all >"$temp/sha1dc.export"

git init --bare --object-format=3Dsha256 "$temp/sha1dc"
git -C "$temp/sha1dc" fast-import --export-marks=3D"$temp/sha1dc-sha256.mar=
ks" < "$temp/sha1dc.export"

git -C "$GIT_LOCATION" fast-export --reencode=3Dno --signed-tags=3Dverbatim=
 --tag-of-filtered-object=3Ddrop --branches --tags >"$temp/git.export"
git init --object-format=3Dsha256 "$RESULT"
git -C "$RESULT" fast-import --rewrite-submodules-from=3Dsha1dc:"$temp/sha1=
dc-sha1.marks" --rewrite-submodules-to=3Dsha1dc:"$temp/sha1dc-sha256.marks"=
 <"$temp/git.export"
----

And here's an example running it right now (my main branch following
`master` is `dev`):

----
% ./convert-git ~/checkouts/git git-sha256.git
[elided]
% git -C git-sha256.git log -1 --format=3Doneline dev
05370fd7088edf77bfcd09c8c909450e764a9d10d8304dc333f39f01697c5a84 4th batch =
for -rc1
----

The downside is that it doesn't produce the same results as the true
interoperability code and it's much slower, and, as I pointed out above,
the user experience is poor.  The advantage is that it's been available
since the original SHA-256 work in about 2.30 or so, so you can totally
make it work almost anywhere.  The above script could also probably be
nicely converted into a generic script that would work on any repository
without too much effort.

> Okay, dropping that exercise for a second. I would personally be okay
> with trying out this migration on my existing repos that are =E2=80=9Cloc=
al
> only=E2=80=9D. It would clearly be in my interest to find any bugs that a=
re
> particular to my workflows. But for that I would that migration where
> you keep a mapping of SHA-1 to SHA-256. Or else I will lose Git notes
> forever (which I use a lot).
>=20
> But reading brian=E2=80=99s cousin response:
> <asQrWAKQXV9zn1Vq@fruit.crustytoothpaste.net> ... it seems that there is
> not enough in git(1) or anywhere else to do that.

The interoperability work doesn't rewrite notes because it only happens
when cloning or fetching from a repository and notes aren't usually
copied in that case.  In-place rewriting is not yet implemented,
although that's a thing I'd like to work on.  Hooking notes into that
shouldn't be very difficult to do.

The reason more of the interoperability work has not gone upstream is
because the pluggable ODB work has really ended up breaking a lot of
things[0], so sending almost anything requires a bunch of rebasing and
fixing, and I'm presently very burnt out, so I'm doing very little
coding in my free time and doing more cycling, reading, and Factorio:
Space Age.

> The above scenario would be very hyperbolic and too cynical if not for
> the context: one person is leading the direct implementation work[2] in
> their spare time. In order to migrate Git from a to-be government-wide
> banned hash algorithm. That seems like an institutional malfunction.
> Somewhere.

This is the problem with open source, unfortunately.  In the ideal
world, would other people and very especially major companies help out
more?  Sure.  But macOS and FreeBSD also ship one person's bc/dc
implementation as a core part of the OS, there's only one maintainer
each for bash and ncurses, and a lot of other cases.  This is basically
https://xkcd.com/2347/, which, as we all know, is a widespread problem.

As I said elsewhere, everyone is interested in scaling Git to larger and
larger repositories and improving performance, but little else gets
attention.  Those are things I _don't_ really want to work on, which is
why my job is not working on Git.

[0] To be clear, I think it's a great project and I'm very happy to see
the work come in, but it has impacts throughout the codebase.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--5E8R5rDBEyPnh/8D
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrFbmkJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZycMu9762icEy5MmYXthJK5tIPqGW4mbZjSdZxu9R/Kd
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOiFAQDnZIFr+nTre2ZbM1ZU6t6Vok5B
5h67aL2dwuzzlKyQ5gEAsRUmXWjYCRE1YF9VolAjjI8tSsJQg4wV2on2lIbVeAQ=
=xCGk
-----END PGP SIGNATURE-----

--5E8R5rDBEyPnh/8D--
