Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC2B2942A
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722403194; cv=none; b=aA43CktYMaHwkx6fUl+53l66MqkbScYfcxB/lFR7XbROlh6g/aABuslGON1VHJnRxXKerMrrwtoB5J/HMVKqJ6SRom6avULRV//h5o7KKTaK2VHaQGVRAHka/qssc8ypB4HGIkJnRBrg+rJ4ks5EnnhPN+pJ2fOYINuh0ZR7CSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722403194; c=relaxed/simple;
	bh=aQN0xCITrlQWgPVy/Fz9tKVPHw+5ZdLRmRIpbB1IhbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBqFmFHzhFdK7mx9t9RnWZrKm5iDsEUmXivRm0IcnT4tdTdWqiPaz3XdKO+zJH6NiC6GuQJlAx0CMLo/8yxt3UaupgJ6MSUZ10TOBgAl8EZhmjeILpAHE6fvKNX53vYG30Iy8sX6jrNq5kehPJ2SElRYF/NteET5tmzmgkTHZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H2yLJbxI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vnFephVA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H2yLJbxI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vnFephVA"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 34AA4138214E;
	Wed, 31 Jul 2024 01:19:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 31 Jul 2024 01:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722403191; x=1722489591; bh=IMAttregfk
	S8+g+D0nYPLWflwnk1DRfFS4I+wbE53i0=; b=H2yLJbxItcyFGFK2T9n+1uiWMP
	vG+0WLZ0d8GHjV3jobd6ojYJWRy0If0yfV2/wNXo3b5UoofUGkYA56Jz5oJspOic
	dqD1Zww2A7z8nEtTKjvgJy7ikyVzSodXz1FoCXWbfHalclTgw8XBphogcDTP6pZx
	C4Co+srOcNB3F6v0CJcinR6ybkO856kCppWeqan3DSYdN9/B+oLvSJwSxMOTPq2r
	pBTYoceVw0v0drONMn3+/jvO0W32XjfFVTFcboVHDl2ZoskuRNCxy5hE8hHkt9M9
	yfVcQ4eqR5OzgBEDYat7TLcCktvW2q7ahVucCcnuSb+ETTQCTNr94DmIyltQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722403191; x=1722489591; bh=IMAttregfkS8+g+D0nYPLWflwnk1
	DRfFS4I+wbE53i0=; b=vnFephVAsPYg8+S7psLu61SEv5Zb+87BBU0ifC86fggA
	r/tEVf/SYt/BbYiA30mE0tgbdocZkOphLP2qUTU9nH8zgKc5X8jkl3c00Uav+3It
	bVQ74gfINb3JKzBQR4oA5SaD3i4kKluTLftqRTNUWLum3oy+ZOnPt6Mmc3FF3ZN1
	ugWVvtpE+3TdtJLmV2uNqr++WgGeaEisgkFWsmKVLRgnhLL79xBCR27GA7/MdL6h
	Msn9CqV4ejrkpaYqJvaTUD4W+SazC46lez/6wUzct3pp830zqmw2HFH2f+wCtgvX
	ueZAVgsg2bbtWnv8CAE708Z5ZeAVSKKUFpW1y/DMaw==
X-ME-Sender: <xms:dsmpZomVDbU5Io-Ij5uwju-DSELVanA748619NimIDpFRGV4V3E59g>
    <xme:dsmpZn3dYzv0JG1-8e5IxDG4yjBTXiwG1obxE-owPuiVr8qwr5uCvPpSOVxoReYn6
    5VcwZDa9UK2JSM2qQ>
X-ME-Received: <xmr:dsmpZmr0H4-C7wz45NfA0QkQ2gLJRd5y45o6RAUzXckwKoR0A-ARl6jyQpbN-FjbCFyDHag_Tv3YiUEsmnN66j2D_bT0HrcahYBXq8dDCtNFdo5x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeehgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeegtdeiuedtgfeuvdfghfdtkeelkeeltedtleeggfeufeelgfeitddvgedugfehffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:d8mpZkm5zSiR5dPEK6K3ucCZol2wStR1GBhT5k1hKHP_69XyNPpe1w>
    <xmx:d8mpZm0-n41hYnpXPTzjGiBCiyyPTSt_sSNWiNEv1VuDiEcXofAnag>
    <xmx:d8mpZrseRvKo3mk8o149JDW2IIUi7hDmf0yuFj0bAdsNsZkIKsp6Ng>
    <xmx:d8mpZiWpeBgfbScc5fTNO-RUZKwR6sbZE2n322Cjefjx64ooXv1Z2Q>
    <xmx:d8mpZgpvH-GeVo32vAa1T8jraoQNsCpEYcVBTr9lzOUlkDijCc4bo8bQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 01:19:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2c6497ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 05:18:18 +0000 (UTC)
Date: Wed, 31 Jul 2024 07:19:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
Message-ID: <ZqnJcawtpzvguxtq@tanuki>
References: <CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
 <xmqqfrrxjw8f.fsf@gitster.g>
 <CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
 <xmqqv80szxgw.fsf@gitster.g>
 <ZqOc9vxdD4qttkFs@tanuki>
 <xmqqed7gxhyz.fsf@gitster.g>
 <ZqdldZE2MV-Pkuu-@tanuki>
 <xmqq8qxkhvt3.fsf@gitster.g>
 <Zqhwwudf-yjvJ_By@tanuki>
 <53c1eaeb-6106-492c-9c44-13a7cd1bd0d0@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4y/IxAsPsdXx2m2k"
Content-Disposition: inline
In-Reply-To: <53c1eaeb-6106-492c-9c44-13a7cd1bd0d0@web.de>


--4y/IxAsPsdXx2m2k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 04:00:07PM +0200, Ren=C3=A9 Scharfe wrote:
> Am 30.07.24 um 06:49 schrieb Patrick Steinhardt:
> > On Mon, Jul 29, 2024 at 11:55:52AM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >>
> >>> is standalone nowadays and called "clar" [1]. The biggest downside of=
 it
> >>> is that it depends on Python to auto-generate the test "main" functio=
n,
> >>> which is not really a good fit for the Git project.
> >>
> >> Is that because Python is optional (like, we only use it for
> >> optional Perforce thing and import-zip in contrib), or are there
> >> other concerns?
> >>
> >> Unlike these components, unit tests are not even for the end-user
> >> consumers, so if it is Python that you find it a blocker, I do not
> >> see a reason to reject it.  The thing looked like a simple script
> >> that does not use any tricky language construct or modules.
> >
> > No concerns other than adding another mandatory dependency for devs. We
> > already depend on Perl and Shell, so adding Python to the stack feels
> > suboptimal to me.
> >
> > As you say though, the script isn't all that involved. So it would also
> > be possible to port it to Perl if we want to do that, I guess.
>=20
> From the point of view of a "minimal C unit testing framework" surely
> the implementation language with the best dependency story would be C.
> Perhaps it could then also test itself.  On the other hand, writing a
> string handling program in 2024 in C is probably not the smartest idea.

I certainly wouldn't want to do it ;) I think Perl would be perfectly
fine given that we already rely on it rather extensively in Git.

> Then again, generate.py uses a non-greedy regex to remove single-line
> comments, which seems wrong, and doesn't seem to support preprocessor
> directives like #if and #ifdef, so whole tests can't be disabled this
> way.

I guess it doesn't have to be perfect, just good enough. clar comes with
some niceties like being able to run only some tests, all tests of a
particular suite or to exclude certain tests:

    # Run only submodule::add tests.
    $ ./libgit2_tests -t -ssubmodule::add::
    TAP version 13
    # start of suite 1: submodule::add
    ok 1 - submodule::add::url_absolute
    ok 2 - submodule::add::url_relative
    ok 3 - submodule::add::url_relative_to_origin
    ok 4 - submodule::add::url_relative_to_workdir
    ok 5 - submodule::add::path_exists_in_index
    ok 6 - submodule::add::file_exists_in_index
    ok 7 - submodule::add::submodule_clone
    ok 8 - submodule::add::submodule_clone_into_nonempty_dir_succeeds
    ok 9 - submodule::add::submodule_clone_twice_fails
    1..9

    # Run only a single test in the submodule::add suite.
    $ ./libgit2_tests -t -ssubmodule::add::url_absolute
    TAP version 13
    # start of suite 1: submodule::add
    ok 1 - submodule::add::url_absolute
    1..1

    # Run all submodule tests, but exclude submodule::add.
    $ ./libgit2_tests -t -ssubmodule::  -xsubmodule::add::
    TAP version 13
    # start of suite 1: submodule::escape
    ok 1 - submodule::escape::from_gitdir
    ok 2 - submodule::escape::from_gitdir_windows
    # start of suite 2: submodule::init
    ok 3 - submodule::init::absolute_url
    ...

So I'm not sure whether it's all that important to be able to recognize
things like #if and #ifdef given that you can pick tests to run on the
command line.

The alternative would be of course to hook up LLVM and properly parse
the C sources. But that feels like overthinking it ;)

> And it uses pickle to cache results; does that mean it would be
> slow without it?

Good question. I plan to find some time this week to draft a PoC and
will remember to benchmark this.

Patrick

--4y/IxAsPsdXx2m2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmapyXAACgkQVbJhu7ck
PpS8ORAAmpOQfNVQrdnhWVHy1dPLilW1ptif5jbgoYdj9ttK0VUjh3E1WJvdGbSi
YtFBjrWgp4QtXBQExJOj+bRR8iICLF+P4qRISDTKXkBERDei6qnB5HptmzoGecwQ
/IzbZ55kbjBkWRAzoctsDsxErmpoXR0cj/VC2Du6sZgLAk/TRuC9BUSy2afEK8jK
sfZgi8dMmdn479K+HqRSOULNAwPOxU3ewgqVemPJzMnXDICVx9jYUZ4pfuF5Za1l
402FuZ0n+gs4/ltA1j6mP/xKoyUHwTvFgmBSbAWOH1po2dchRGyVoMCCf3mu19tQ
dCGnQR/UQJgqH9hYJU+ZaD5v/Od2ZYs9fbl+/9yptI6zGWr7VkK6vsCuIw+JL0SK
4JUwGObYFN/tyNHki9K57rqe/12KdCVcQmolNZ9Z6y97VaSdct98GHTjCpvDPmsZ
nl8WR1jhkeJg7lW7eX0GiMOgHDBaFSfQzT7JWl7W2ttDXxz9+T15JAZgZm+MqIcR
tbLFccHJMKgZylPYN3yZ8CcEtMnkg7gPzUOCl30ls/R38cAkn+iu5+lgZ8uA5VJI
HhZk+Je5kd1eMGe6+Yi+WVBDI+CJ5et/ilocFg1N4Q9JrDfdaIxD7IObvpGAUSJK
VpcAVoHwJQ6t1evTry6UDlshbTepz7JsFr0HMSVjcGVlyQQY7EU=
=EJf7
-----END PGP SIGNATURE-----

--4y/IxAsPsdXx2m2k--
