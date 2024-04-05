Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29471607BC
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310049; cv=none; b=rxYHMoWNmBPp10BSAaY+d7A4cZ72t237PhXI54zbZuIDfUHZMXnfkNKOA6WvUOSLxVB97w2gYAgbIsCgltneHjxo4xHNJSSq+r6pJBujTEsRoPXqt2l0gsp798efHQRZJUtUIRxMCdbXAtC+1fpTrbZxCMFRXDk6GsgYAFsoUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310049; c=relaxed/simple;
	bh=pRd0tSmAW1htdaEisr94yN3oBXwXPGr/iQ32K+weEw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA/w6045OXPUFvJDwWx8MPrV1yJtpCTafoaS9DBlj0fq9ySiIBvkO1FwaQJMM3lgiZZnkqLWRyG5sb5hMVmiU5nULQEvKL5fYL4ZX2ypBj0zZXA4N6Khz2Sv23DNyoE7H4bZGP9jQEIhdmj0PgPf7RbFPYX5ZS4KvLEqjh+rXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oHFvnTFp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nWo8qj0m; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oHFvnTFp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nWo8qj0m"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 45AE71C000F6;
	Fri,  5 Apr 2024 05:40:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 05 Apr 2024 05:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712310043; x=1712396443; bh=7ylNj3RVBs
	CPHdkBrThAK9AFn/mHHCj87HUp5VSLGgs=; b=oHFvnTFptMhXXVKi7WIaPapZr8
	Z2QYtov6ZPwMqAy0HBhW4m8lrCdmqGhVF75GgBWdmTzE7cVYMokXeOysm2MYPdYV
	w+fUMVgDrz/Y7I03QfVSzZxg1oxq5+TpgRS+yUzjOx4o6b5CelZvLQefpuLwe7x6
	VMohbOmGY/cZhNfyhl5tz4M3hM/w7Uz4Eo4Palvwsjn7qAEybh0QWFcUWWQjSQ3H
	OzZjORuitE+ldc55Sf99/YF5PZdoCfhc6QhQ8Q1num8v7hHddr635mXtypeUndRs
	I/GSQurPVAGppDvo3QUmHpAn51l3VzSBX9XbHexwh9YeixFcmV/2A0YxC06g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712310043; x=1712396443; bh=7ylNj3RVBsCPHdkBrThAK9AFn/mH
	HCj87HUp5VSLGgs=; b=nWo8qj0mfwdWwubvAIdBwthBx7JsI7XNOYh8Z2ucHQSj
	2IoopdqP/42HB2/DsJJgkpe3amVr5ZxTLtGjfh5b+hVM7Ab6eV4zen8YX1JbTa2o
	EAN47/WNHCzQHUSIxhYEKV+4p1TBQrmvquQLCwqBCnskcBw9eTvy1f5RUShWPJ7s
	49jdKsTW3gfN7qTJCnXKh2JePQNh+o2MYx+2HFzdd7Xtgv62D1kKjIfAS9TrDlbl
	vzB+Y5SVVWus4XmCZfHpOu0UpCUSgjkhu8+3eLnZUdiiQl7QbvHHZiu0gVzh+0iY
	zu51uXz3jKBVZ70wvGdSJBL07+IDGNDimt60sLaB/A==
X-ME-Sender: <xms:G8cPZhK_QsUmld-frKVPblQ-4PPicymdoC6obt-Qww046gC3YmyQ_Q>
    <xme:G8cPZtKio_2cNcptZZd1dBLK5Coby8sYI3hMBcZjVVhyHx8IYbN5GmpvR9b8fg6ga
    pSwNyYa49XurRQLVg>
X-ME-Received: <xmr:G8cPZptX7S_N23lC2O7YgmEmSIEjYqyWNJMFJAlu23PLDIDrQ9jot-LnPusVtQjK-1Woyunw82csTkHVQ4BYuSVyGrSh_spIT92bJBWnEtRQwLg2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteefteelieffvdevfffghefhudelleffueejvedvheefffeihfehhfelffeijeej
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:G8cPZib7iha0rU3MptSHVR0KTjEMrh8XwCSileB5dX6nflDjR1CpCQ>
    <xmx:G8cPZobXHC6f1W5OleNDbPxrKKv8-eI2tJb7SUAIohBeonstT2r39g>
    <xmx:G8cPZmDEWPCJbouH6EzlSgiVUrVt2JZlGzsFUJbZKPLtNir1pD0gRg>
    <xmx:G8cPZmZuV9FbIPJZNSrM2atkw3FIT70lBITUsUnWoe4U7X2xFysxkA>
    <xmx:G8cPZo6FYycpyjMPc9jpFFAkqBlpKEIBveUzaj7y1OsHe6ielbspPojs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 05:40:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cf8d0311 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Apr 2024 09:40:36 +0000 (UTC)
Date: Fri, 5 Apr 2024 11:40:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: Re: [PATCH 11/12] t0610: fix non-portable variable assignment
Message-ID: <Zg_HFtiami4j5th7@ncase>
References: <cover.1712235356.git.ps@pks.im>
 <c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
 <CAPig+cSb_cKXYaNCBpe9Uy_iGB_K2NXaw4d1hg5bPuVaCEWvjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qBVw4zQmmq3AWbDe"
Content-Disposition: inline
In-Reply-To: <CAPig+cSb_cKXYaNCBpe9Uy_iGB_K2NXaw4d1hg5bPuVaCEWvjA@mail.gmail.com>


--qBVw4zQmmq3AWbDe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 05:14:34AM -0400, Eric Sunshine wrote:
> On Fri, Apr 5, 2024 at 3:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > In `test_expect_perms()` we assign the output of a command to a variable
> > declared via `local`. To assert that the command is actually successful
> > we also chain it with `&&`. This construct is seemingly not portable and
> > may fail with "local: 1: bad variable name".
> >
> > Split up the variable declaration and assignment to fix this.
>=20
> Under what configuration, circumstances, conditions did you encounter
> this problem? I ask because this isn't the only such case in the test
> suite, as shown by:
>=20
>     git grep -nP 'local ..*=3D\$\(..*&&' -- t
>=20
> What makes this case distinct from the others? Including such
> information would improve the commit message and help future readers.

I only ever saw this in some subset of GitHub CI jobs. See e.g. [1],
where the logs [2] show the following error:

```
ok 6 - init: reinitializing reftable with files backend fails
+ test_when_finished rm -rf repo
+ test 0 =3D 0
+ test_cleanup=3D{ rm -rf repo
                } && (exit "$eval_ret"); eval_ret=3D$?; :
+ umask 002
+ git init --shared=3Dtrue repo
Initialized empty shared Git repository in /home/runner/work/git/git/t/tras=
h directory.t0610-reftable-basics/repo/.git/
+ git -C repo config core.sharedrepository
+ test 1 =3D 1
+ test_expect_perms -rw-rw-r-- repo/.git/reftable/tables.list
+ local perms=3D-rw-rw-r--
+ local file=3Drepo/.git/reftable/tables.list
+ ls -l repo/.git/reftable/tables.list
+ local actual=3D-rw-rw-r-- 1 runner docker 43 Apr 4 11:55 repo/.git/reftab=
le/tables.list
t0610-reftable-basics.sh: 83: local: 1: bad variable name
+ die
+ code=3D2
+ test_atexit_handler
+ test : !=3D :
+ return 0
+ test -n
+ echo FATAL: Unexpected exit with code 2
FATAL: Unexpected exit with code 2
```

I was a bit surprised by this, too, and cannot reproduce it with any of
my systems. But I would bet this is dependent on the actual version of
your shell  because it only happened with the Ubuntu 20.04 and 16.04
jobs.

I didn't dig much deeper though as the fix is easy enough, even though
it is surprising.

[1]: https://github.com/git/git/actions/runs/8554157462/job/23438877643
[2]: https://github.com/git/git/actions/runs/8554157462/artifacts/1384620962

Patrick

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> > @@ -80,8 +80,9 @@ test_expect_success 'init: reinitializing reftable wi=
th files backend fails' '
> >  test_expect_perms () {
> >         local perms=3D"$1"
> >         local file=3D"$2"
> > -       local actual=3D$(ls -l "$file") &&
> > +       local actual
> >
> > +       actual=3D$(ls -l "$file") &&

--qBVw4zQmmq3AWbDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYPxxUACgkQVbJhu7ck
PpSXiBAAnD91OF9j2IJ+xZFzmbDaSplTmxZGyJNf4tMGg15YqIF41WWGwDqcou61
Bf3bS7Hp0xn+IwFQpN3ozqpk9+S7LH/rhEzbgp5VCjv+GomtlCKdiyNV7lR1Dv6W
s3QMQpmWQcFC9++/1O0+FBWucXhCQUD0zRbvHv1Or0ZTEjv6h7a58ZNF/Ttaf5zP
GP+ddl6GDk4zF1HDp1mj1fhKCd/VhZ3DQ593hUXRC0qXS+MV+CK2jobdT9M6jV1c
aOJkK4Mv2HUxNP8op8lzgXs/Zpb9pil6MBnKWCwV/IWhJnE1eaLxURMeWzwBlGzF
Zq4FmuT9XsOL0PKanGR6engrUSs5GaSgUzlKxpqUvN/a2LeWwLXDx/C7k8J4eJgw
vJhC6qz5NcffxBCT3COOpi1m07VNu0NgjkxKd41tXpHnR573yZ9P//TQjmwisgT1
uDaaOcKn5DCMkneCyGfN0qWIa/ILFA2RXMqWpoyixxwWkjY3AUYdBocZTCAIxnbR
51dJ0xtQYJivRNfUvgcVf9sn2UPN/4Pkwu7gpHfkM0gDgappjmTyF7CiG7qbVtbh
sSjbB9i47gQympP/8vme/VYs7nE4qWB51mDEs4cMnXU7m54vO1a/hJnTEn5mGe1i
43gpjgyLeqRXV4BhMxQAIjYlW3juWs+LQuCqA599UCkXIh/lV7E=
=iomC
-----END PGP SIGNATURE-----

--qBVw4zQmmq3AWbDe--
