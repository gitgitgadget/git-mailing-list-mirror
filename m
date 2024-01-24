Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC917BA4
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086376; cv=none; b=lvutOxxVItYOP2Q1VfiUGemaEFMQUY4QEZfKExYNbw/nuoNZUCLhYtyOBPvAfnaHUHVTIjTonQ97YjZwMMtWKYVuc5jU1f6Fha1Ey6JOtqH2eD0NafJeBfLprhDwBwCWVMCp0YHAcqFKe4c5dnPIIEGdR/fW3VF/C+36DhhYoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086376; c=relaxed/simple;
	bh=017+xWdZBTFO7OjDtXXUapwi0ZVGkywFFWzeDlLGAb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McexyVJGauJ8QrT0vtjmI4xJLQKQQtvggXM0BQHQnYWNM4BoAQvwsWAU+fRiLLi3Sb93WCGAN74t9dGjmBVXMIBAlaqOd6PitZZdZC5wA6iLCK1F9msUJkm4BjtvA8wojQdCk+pDc4QwxfubeQYAWlYUckE4eWdo5egTNB3xmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gJsyiEJ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NUPcGe/q; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gJsyiEJ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NUPcGe/q"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 5124D32003F4;
	Wed, 24 Jan 2024 03:52:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 24 Jan 2024 03:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706086373; x=1706172773; bh=i9ghetAVa2
	uB/X/fYbq+XaRg8kTrV1O5+BtbrRRB8ME=; b=gJsyiEJ+X320Az/gTtVtR7nVve
	PJhVGZYJ2t4NvcCaA9e2I38MiL45UcI2SeWzav0Wzp/eWxIeWDlEGVU30qkVwn2a
	UyOwVloKeRhL1n2px8hyzAWCe+sY4SpM1yk9dP4B5KGjy90h34ThW/M2u6Q9cZ4a
	xioICsVafvZuNjpt/Z+lJqzIKJU5YyQ+6qL3kh1sTAw3rLqsNyWvq5o0ERxYjoEV
	m2m+3dMTGy/30gFH1U8EgRfHE3df39Qp10xa/z5MuOj/uIJjeBFdvUHyqZUCJJmL
	LRAanR4wbF9GBmx3f7GOi4J5jQWaXpuRdiVctLSuHHwFZ2gYzEasa7A2IKAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706086373; x=1706172773; bh=i9ghetAVa2uB/X/fYbq+XaRg8kTr
	V1O5+BtbrRRB8ME=; b=NUPcGe/qyGKwqtUXan4RtTyBG0oiDUpFjrMeRHjGiC4t
	5uB04OXtxcQ8GzHOTQpepid87z6x5cUuTN3iglp1pnPQDO0pXZy62yo5/6hrOykn
	1MHUXk2XCtNxFshimtDd+UO+zoaQLIiuAU0+aE/vXRzAb0MFBZZZ+KKDYBdinl9I
	ouN5yYjqH1LCXUsy4PL4t0uFFea6Rn3DbLjLIwBZgarAzxs64cMaVm0w1hGSNd/9
	BWk8xXWRzeZcVerPogMUieCahns8rTkEt05AlRVgQFdTzfjzus2CFfuQvPH0rjih
	VA1/B0i+m2bcu4lxpf5aSrABT+xdmJGdLirG8X/naQ==
X-ME-Sender: <xms:5c-wZUonA1-fymsCCvaedhCsD1TMWjY2pckaWUDwiIxYMswqpq2OEw>
    <xme:5c-wZapS0vXQJlL7eTKm5HtVuN31P_vMjEJIWnahzhoVaiWLtPVKJc3QQNb9x8kN_
    _Gzn6NRRPWLe-r5Jw>
X-ME-Received: <xmr:5c-wZZNG6jinl9pDjQEG7dKiNsi5b4hOCMkqodKcpvSA9WGMfWi4E6K2hU-N0xo607dr8QJMbeX-oSIa3zw80c4-sU0gHZ842FDNIcAOdn2G3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5c-wZb6Kj4VZLNsNkdhcSNDeWQpaCeHwdjrq49faPdXZ593gG12jJw>
    <xmx:5c-wZT6LMLxPWGlXldylQ5FZe1ytPVuBC-0p0FnMmieILArn_a5wrQ>
    <xmx:5c-wZbiZ01_5Z_y4CW8IlxDbKaMtRhgCzLztM-ALqvo5tR7ezGCxwQ>
    <xmx:5c-wZTGCfse4SdGOIeIJ4TaJf_PEq_ljj0B_9hP7mbSV1HjDoDMr1A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 03:52:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 48b158e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 08:49:46 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:52:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/6] t1300: make tests more robust with non-default
 ref backends
Message-ID: <ZbDP4ntRqrxX08yk@tanuki>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
 <0552123fa30243d6d8d6b378991651dd6ade7de3.1704877233.git.ps@pks.im>
 <CAP8UFD0p-OqYuTrB5m2uq7BRFko887bKszOLtP5peP-A79g=BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kIHKgS+0FtdR39GK"
Content-Disposition: inline
In-Reply-To: <CAP8UFD0p-OqYuTrB5m2uq7BRFko887bKszOLtP5peP-A79g=BA@mail.gmail.com>


--kIHKgS+0FtdR39GK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 05:15:48PM +0100, Christian Couder wrote:
> On Wed, Jan 10, 2024 at 10:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> >
> > The t1300 test suite exercises the git-config(1) tool. To do so we
> > overwrite ".git/config" to contain custom contents.
>=20
> Here "we" means "tests in t1300" I guess.
>=20
> > While this is easy
> > enough to do, it may create problems when using a non-default repository
> > format because we also overwrite the repository format version as well
> > as any potential extensions.
>=20
> But I am not sure that "we" in the above sentence is also "tests in
> t1300". I think overwriting the repo format version and potential
> extensions is done by other tests, right? Anyway it would be nice to
> clarify this.
>=20
> > With the upcoming "reftable" ref backend
> > the result is that we may try to access refs via the "files" backend
> > even though the repository has been initialized with the "reftable"
> > backend.
>=20
> Not sure here also what "we" is. When could refs be accessed via the
> "files" backend even though the repo was initialized with the
> "reftable" backend?

Yeah, I've rephrased all of these to sey "the tests" or something
similar.

> Does this mean that some of the tests in t1300 try to access refs via
> the "files" backend while we may want to run all the tests using the
> reftable backend?

Exactly. We overwrite the ".git/config", which contains the "refStorage"
extension that tells us to use the "reftable" backend. So the extension
is gone, and thus Git would fall back to use the "files" backend
instead, which will fail.

> > Refactor tests which access the refdb to be more robust by using their
> > own separate repositories, which allows us to be more careful and not
> > discard required extensions.
>=20
> Not sure what exactly is discarding extensions. Also robust is not
> very clear. It would be better to give at least an example of how
> things could fail.

Hm. I don't really know how to phrase this better. The preceding
paragraph already explains why we're discarding the extension and what
the consequence is. I added a sentence saying ", which will cause
failures when trying to access any refs."

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t1300-config.sh | 74 ++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 48 insertions(+), 26 deletions(-)
> >
> > diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> > index f4e2752134..53c3d65823 100755
> > --- a/t/t1300-config.sh
> > +++ b/t/t1300-config.sh
> > @@ -1099,13 +1099,18 @@ test_expect_success SYMLINKS 'symlink to nonexi=
stent configuration' '
> >  '
> >
> >  test_expect_success 'check split_cmdline return' "
> > -       git config alias.split-cmdline-fix 'echo \"' &&
> > -       test_must_fail git split-cmdline-fix &&
> > -       echo foo > foo &&
> > -       git add foo &&
> > -       git commit -m 'initial commit' &&
> > -       git config branch.main.mergeoptions 'echo \"' &&
> > -       test_must_fail git merge main
> > +       test_when_finished 'rm -rf repo' &&
> > +       git init repo &&
> > +       (
> > +               cd repo &&
> > +               git config alias.split-cmdline-fix 'echo \"' &&
> > +               test_must_fail git split-cmdline-fix &&
> > +               echo foo >foo &&
> > +               git add foo &&
> > +               git commit -m 'initial commit' &&
> > +               git config branch.main.mergeoptions 'echo \"' &&
> > +               test_must_fail git merge main
> > +       )
> >  "
>=20
> Maybe, while at it, this test could be modernized to use single quotes
> around the test code like:
>=20
> test_expect_success 'check split_cmdline return' '
> ...
> '
>=20
> or is using double quotes still Ok?

In general single quotes are preferable. This test is using quotes
internally, which I guess is the reason why we didn't. Happy to change
while at it.

[snip]
> >  test_expect_success 'git -c does not split values on equals' '
> > @@ -2009,11 +2020,11 @@ test_expect_success '--show-origin getting a si=
ngle key' '
> >  '
> >
> >  test_expect_success 'set up custom config file' '
> > -       CUSTOM_CONFIG_FILE=3D"custom.conf" &&
> > -       cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
> > +       cat >"custom.conf" <<-\EOF &&
> >         [user]
> >                 custom =3D true
> >         EOF
> > +       CUSTOM_CONFIG_FILE=3D"$(test-tool path-utils real_path custom.c=
onf)"
> >  '
>=20
> This looks like a test modernization, but maybe it's part of making
> the tests more robust. Anyway it might be a good idea to either talk a
> bit about that in the commit message or to move it to a preparatory
> commit if it's a modernization and other modernizations could be made
> in that preparatory commit.
>=20
> Otherwise this patch looks good to me.

Yup, this has also been pointed out by others. Will mention in the
commit message.

Patrick

--kIHKgS+0FtdR39GK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWwz+EACgkQVbJhu7ck
PpRVXQ//VpdvIvGK5fUcNTUVFuTlEZeZc6Fcx0sYeH+LkWth0ZD72v5vDALgD3We
sHQzA+9BQTS09doh8XExd8Q7sXIia5pfn+HZEQzIlD9b2g7ZxwTHl+Cl0HlTJCac
JEoWEYdrkCAlW7mkooKZLf1ta+DgshHz58e4zc7SQ2xMyUFAjaAbPZFDHW0XBSdU
Bmgud9+JWCyTD9TGFbO5Zps/f/fqmDUudfYBKumCUUzt4wYCbR4qPBJ+3JiHya8F
QqKROVJ7iIQVdWJJudP780yARRJNFIaJv1gG3bNEuvB6wJVyrpyOlonGSOZ6j05B
OijrygwpfvkNt1Zw0BQWINspni8aJ/pKwCz+cZvxWrX/LXBHatrdSRKdtWjACuj3
2YzhIdL3Tuj4qdrGTZoMRpSk/V3raUrWdLHzeA4+hVWudaMZeEGKcsnOqgYEv8a1
DyGdrhdfOSKDRxPGexGEiWFuJlkE3vmOlS/LaVWayPl5CG4wgyWyEgidwd1jUE9c
YbeU9NOJWCylnLAVH8LJpXawN+8JxhMNEdUTgPCX/lUpUMfUuYcRYRfPTzySGED0
3SgJyBF4xGhRBivLhVw9iuEpaGV/V3KHYSu6LCVU854GI8+4vo8Dw1bXFskOzHis
YEtJx1Vmh6NvLUXbr0XoMrKbTL/0PWqSwDWLcJWMpQk21l9dmgA=
=MPOU
-----END PGP SIGNATURE-----

--kIHKgS+0FtdR39GK--
