Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5FF5D74D
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418093; cv=none; b=N73hjFkK7xisBejTHp+Bd9CUW/Z0bQcsmzR847KL5foa4M7nR4zVYAEBcQYhjnR/HNqtN/lsPZD9Ifa3VBaWP+2Y+MLQYeAvxVuHzfU2pa1tft83GNxlZCV2W42DMCZu4vKGqkyQzVgOL5gZTfMkKPdyscbjFP16tyDhKOvIRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418093; c=relaxed/simple;
	bh=q4rWon+nzdENKqPzskdlaTDHrHZ2TfmB1Te4RPsyQLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlhLkJVsyMo0+lSrbcpvaN6BPi4D30Qzgu8HbYtmZLs9DeHemOSvLzHrzxfT+aA5t827WZiJDh4V/Dkhfq/Y1uvoHvrrC3kVHo4o0ZKrpqHT2EbJDYfyQ/oiCJR8IuhjY1xy6n2AsgtYDSm6Tc/zyofZMcKZSFSJpQtFneqwIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a6Za2IYR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FBU93+1W; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a6Za2IYR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FBU93+1W"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 78B4E1800086;
	Tue, 20 Feb 2024 03:34:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 20 Feb 2024 03:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708418090; x=1708504490; bh=I6wgVHvozD
	sE70wnHKJI/xvDjTa7Ti7oDtZfEPXBMik=; b=a6Za2IYRkEo2SjkmBfQN/jCqG7
	akHrtAWtTuZIXAngHEeb/5Fnfl9yDA+rLVpIp05iPCpqbf0m84U5Kw4QhELK4UOU
	tvOyCkfmfknfCPCyP7t5bOLOYs1fEC5CJErayGd2xS7WLJ4DhpFNEdakQ0yXCkhN
	+LagomXecRJb77aMtKnJ9DOyayGlRpceRVLmoVgeQg35Ag873ApIguYvS/Z0wxr2
	poqAX1Ry3DLoznrKY7+Cvz/hvfj1BKX8N3Cy5xhwn7Wlz0xpWenZHisRbXd3ZWNc
	QCPR7OhxRw/XeAD2lg8jpHeMF/GX0cgTgfo7OgrnOZYEdNBgbjFNVLCTsIQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708418090; x=1708504490; bh=I6wgVHvozDsE70wnHKJI/xvDjTa7
	Ti7oDtZfEPXBMik=; b=FBU93+1WRiH5bLogQSBHNpqlsx0/bWTiciGjDIC7ArlG
	0VIHLJcJ/8pj2tDJ0wHkvX62N0EH0HafOlB4dtvOuRyYBagOsAwCnlmw4GjEkpKO
	Tl71T2JtfA6udDYN386rcDOO4CTFPuzDk5DgUO5DjjVKgVHq4ATJ1GgdEFJjI8AV
	TYWEXqnbZSLRdlc4agdnq/64t4cMx5imyglxpKlstW2yGGt3pbobJ6ySHdrPwwOI
	QBpTqoOimMuuqWB9j0T46N4vSkRbI4C54jNgmgfV6C1uQt3YH0IlI8jJV4JEDpp1
	aEN2aR3zDKs7xKn6T83SoU/H+8iXIKf51Nkp3Vvusw==
X-ME-Sender: <xms:KWTUZdFNgBZRxuvL1Iwn220gRvl1YIfrujG2Cz8d_IAhrI7Je1ou_Q>
    <xme:KWTUZSUELR0IXqOH2cyKfVSJuaTwxhG5i-ttdopk3qU1l7phJx0IaLTVj6tNQ-2f4
    IesO5L0WIXF5HD7iQ>
X-ME-Received: <xmr:KWTUZfJZYL1C4bKlHiAs7lmKFrCoUDkFg4is5FuU_4kIL6dZBLAapu80eBy0piQNZ-ommEU_U3_1ym6rPa-VoefPyh3lz1oJMH_J_tXlw69rKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KWTUZTEk0T7eIwnvCtIoYKasYtx9G46XPy-STzNMVVY9Yv4nZEFQ_w>
    <xmx:KWTUZTUzAL0rAjQZjTjtbKKa539QhXyTDxnr_03OWTw_1khnA0AcJA>
    <xmx:KWTUZeMH2lKinE0HZw68MQ84VSA9sCX_juc6-nG5DIMXEKwPoqt_2A>
    <xmx:KmTUZQiSSItbeUtzXVz3dq2E8OkoQlEAS9isFWAdARaJJRrkxE70KQ-BJv4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 03:34:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b461e99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 08:30:46 +0000 (UTC)
Date: Tue, 20 Feb 2024 09:34:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] builtin/reflog: introduce subcommand to list reflogs
Message-ID: <ZdRkJkhBp-7hAJzZ@tanuki>
References: <cover.1708353264.git.ps@pks.im>
 <cddb2de9394a07e405682e9ccdfdf5de92bb9092.1708353264.git.ps@pks.im>
 <xmqq7cj0ynys.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YxsUuU37MllXWHOh"
Content-Disposition: inline
In-Reply-To: <xmqq7cj0ynys.fsf@gitster.g>


--YxsUuU37MllXWHOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 04:32:43PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> > index d2f5f42e67..6d8d5a253d 100755
> > --- a/t/t1410-reflog.sh
> > +++ b/t/t1410-reflog.sh
> > @@ -436,4 +436,73 @@ test_expect_success 'empty reflog' '
> >  	test_must_be_empty err
> >  '
> > =20
> > +test_expect_success 'list reflogs' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		git reflog list >actual &&
> > +		test_must_be_empty actual &&
> > +
> > +		test_commit A &&
> > +		cat >expect <<-EOF &&
> > +		HEAD
> > +		refs/heads/main
> > +		EOF
> > +		git reflog list >actual &&
> > +		test_cmp expect actual &&
> > +
> > +		git branch b &&
> > +		cat >expect <<-EOF &&
> > +		HEAD
> > +		refs/heads/b
> > +		refs/heads/main
> > +		EOF
> > +		git reflog list >actual &&
> > +		test_cmp expect actual
> > +	)
> > +'
>=20
> OK.  This is a quite boring baseline.
>=20
> > +test_expect_success 'reflog list returns error with additional args' '
> > +	cat >expect <<-EOF &&
> > +	error: list does not accept arguments: ${SQ}bogus${SQ}
> > +	EOF
> > +	test_must_fail git reflog list bogus 2>err &&
> > +	test_cmp expect err
> > +'
>=20
> Makes sense.
>=20
> > +test_expect_success 'reflog for symref with unborn target can be liste=
d' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit A &&
> > +		git symbolic-ref HEAD refs/heads/unborn &&
> > +		cat >expect <<-EOF &&
> > +		HEAD
> > +		refs/heads/main
> > +		EOF
> > +		git reflog list >actual &&
> > +		test_cmp expect actual
> > +	)
> > +'
>=20
> Should this be under REFFILES?  Ah, no, "git symbolic-ref" is valid
> under reftable as well, so there is no need to.
>=20
> Without [5/6], would it have failed to show the reflog for HEAD?

I initially thought so, but no. `refs_resolve_ref_unsafe()` is weird as
it returns successfully even if a symref cannot be resolved unless you
pass `RESOLVE_REF_READING`, which we didn't.

The case where it does make a difference is if we had a corrupt ref. So
if you "echo garbage >.git/refs/heads/branch", then the corresponding
reflog would not have been listed. Even worse, even after this patch
series it's still impossible to `git reflog show` the reflog because we
fail to resolve the ref itself, which basically breaks the whole point
of the reflog.

This is something that I plan to address in a follow-up patch series.

> > +test_expect_success 'reflog with invalid object ID can be listed' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit A &&
> > +		test-tool ref-store main update-ref msg refs/heads/missing \
> > +			$(test_oid deadbeef) "$ZERO_OID" REF_SKIP_OID_VERIFICATION &&
> > +		cat >expect <<-EOF &&
> > +		HEAD
> > +		refs/heads/main
> > +		refs/heads/missing
> > +		EOF
> > +		git reflog list >actual &&
> > +		test_cmp expect actual
> > +	)
> > +'
>=20
> OK.
>=20
> >  test_done
>=20
> It would have been "interesting" to see an example of "there is a
> reflog but the underlying ref for it is missing" case, but I think
> that falls into a minor repository corruption category, so lack of
> such a test is also fine.

The reason why I didn't include such a test is that it's by necessity
specific to the backend: we don't have any way to delete a ref without
also deleting the corresponding reflog. So we'd have to manually delete
it, which only works with the REFFILES backend.

Patrick

--YxsUuU37MllXWHOh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUZCUACgkQVbJhu7ck
PpTtPw//YIZA95KnUEMzy6te41LEjyuHAxjPUxFDwDtuhvCtPs+6AGyr/TL/RmBI
IzwRK6ZRy8wl7Gb7nkoVOT9DpsQqtXBJqPXivfFtZtu/HwTE3i0SQSBIT/ryvybW
GWaosdnhfq16rPyqjuCnUjnlxhMBuQk5/KGes362ePYCE7oU5CiQ/3g77PGQubEe
4x/E7Biu4g/3dnI02zIPik0BXcU9ThGg1v9rqHmK64vrIy4uEz0wH9a3fZenp97S
zUYgr/Iu64vu/IsI4WUNZdGaAAaKj5bbzFB2q813P/8rN4dPvFbhyyxwjnsnd/Zs
SQcsteengUx1E3Pq79qS41BOPM538ysOTqchiehmUpOv5u1Xhjqfkvh+QX6gqhy3
r9gRa1n4w4i0gv9KqGVzQG89Hk9QYdxeeQWRyLRAiOoD+UJjFFNZfgFdboB7SZE4
5mHoj4aTa/DJ1UnAKQiLkjKOo5/NdBmDTKtI0XMFKcUUXI3EFNisDDZK78KHjMId
AT7zwd3Zg0h9WyrHr2ev8klS3azDxQUvW4iBeO8gJB/7MW8se0MUuNXswDmOKBqY
nXzM5ptbn+LXHTNFkRAoAR4jR6pd62dg3NSIfUd6sXhOZNzXPuNd2Q14DTWhl6Lx
Yu9VKAPfTbZAaZy+HUroc5l8+rz8zhZFwMXFgWx4I6S8q3WLtPw=
=3xMZ
-----END PGP SIGNATURE-----

--YxsUuU37MllXWHOh--
