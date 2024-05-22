Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD88002E
	for <git@vger.kernel.org>; Wed, 22 May 2024 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366459; cv=none; b=rDxIGCPpVs+GK0jXZitACRyfY5NGqvI+bauEbzV3NE32SoQA6KznwBFSgNO7GStKGFvEwa4XR9IFF3PU9kFt1es/ucXl45d+addNfNLhMZpZ2KrQVo9ugvlpDkxK+3/tBXG0J5vOCnpChEfXbjHUsazhGQNEznmZmQO/T2yot+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366459; c=relaxed/simple;
	bh=y9eghATct77z1GlHGOEucDIelJiEVXShAJykuRlBFgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxQkg9/H2lBwtSnL/eUM9mPQjvEJ+g/Y/qSb7UXgCQg7jWQlpzc8/1ckGwm1n3kgEX6GoeEJu4sJ2L5ucSrPJdHPFAEdxMb5rIUJFYexXwaDVrRTL7mx2PA11zcopgj5T1BdDrOYyvnKS2XALMXmeQtGCwbk7ImK7tu0NCJy6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JrdMopN/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iGfSQvV/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JrdMopN/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iGfSQvV/"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D14D91380125;
	Wed, 22 May 2024 04:27:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 May 2024 04:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716366456; x=1716452856; bh=Zqg5PCDKcD
	EK7WjPDNZjKoaH8wYFOhxNIDzbt0t3ewY=; b=JrdMopN/KXUXQs8/0VccT0Ajcj
	jXxyeLAv++90Fz+Z20U91LS8vbeD+fT/o6rOSAL0U2+u8oVSzMM/TgD0wyZV7NHB
	90LedkqJssdEyUq4lmEFAjOLL93ALbdEZi50KfayjGkLTtO57vIXe6Gje1H5tnWi
	qFbTcHsPMUHE2LdmPPFpDr4hDwRacQ3tx0V7pJlvZErDHczkegnsA68lgFa9MfbX
	3iy3+y7tPgBqgd3ps+vPUZFdy3RIHDqUqK/vUoPoM0IgCri9vStds7niawAFSFUM
	ADUQS8kikfaoypBcsGrRGemslktrf7kTtVlW1LxxNfl5PHhwsR9y29yHzfkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716366456; x=1716452856; bh=Zqg5PCDKcDEK7WjPDNZjKoaH8wYF
	OhxNIDzbt0t3ewY=; b=iGfSQvV/aAnXVe4/SAuYD8RCSh8THvAxgCaUDFgHMttG
	6rcRvpwhK3ofGbT5OLn5aDVn3APDLdSgWgFmVxxulCMzoDuSj47mk+NMRY2blIBX
	9y3EYYvXWDVSmg/sEnKf3cxCaueZiJu6LrXxj6QF0b/IYJRf2kUtlA42ZA0kbiNk
	QWKBe/QOcSld9DVkIuRhD9HybNC6pkFewrmHUHh6oDcSY0MZeXj1IcZBoaThDKQA
	7mDu6NF9sFD/3Om1xSOOeHmRjUoW+24B7iYwnDa0LWmSfUgS1eURIWz8V+ADz4yR
	UxIc6bJ9I3CyQFd0rZD5eRtYSWXMn4oaI38ARWG00Q==
X-ME-Sender: <xms:eKxNZrfVEcZV1w9Sh8T-CTNk1c08CocPUiomd0tom04kdn14VbOwBA>
    <xme:eKxNZhOFRFpUhfFJkZnnXGcZnvqazI9AeLTLfC662iCsXsPTPlsjY9GlotZXdNOJZ
    d1z-3pc3QisyYxn9g>
X-ME-Received: <xmr:eKxNZkgToB3f_trfALBJNGWUf6gAVWNQ0nIpzddPsCqLBXTg1ElmICRWj3aqsA1TvkLmzXFj7RkuqQsFBkwj4vGnFW4juvCuooTTS2xLKVSPbz0L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:eKxNZs9RvukwqSPhgsjYwqWmIJJAybB2IJYL9j_0IBSClJeMmYrRKw>
    <xmx:eKxNZnuToKyF-PmLiG9Lc5Nts9TWLOD8shY1ZrC2-jw0OcSc4xL0BA>
    <xmx:eKxNZrHpKeUBJg6LgeAQ2rhtLCYfpmjIbC-v6GebyNSEnY1IeKUi3g>
    <xmx:eKxNZuMXl5oGrEjTDaqkvHbuoYwPqJ_g4NO_F58kReq-mTXe0QtdqA>
    <xmx:eKxNZnJ0yS3Vy3AzogzkK21VPLxQuonqQ68lnpusC6xXJHMBplfOrRsP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 04:27:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 59c813a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 08:27:30 +0000 (UTC)
Date: Wed, 22 May 2024 10:27:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git init BUG when gitconfig has includeIf
Message-ID: <Zk2sc-649Pz77_G-@tanuki>
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>
 <xmqqbk4zazqd.fsf@gitster.g>
 <D1FH40J6URHF.186U29CMRJ0N3@protonmail.com>
 <Zk2ndVx4gMTV8ZUf@tanuki>
 <D1G108TQBWK4.2XW34J29NCAHG@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WPIJta5Vqdkshj9f"
Content-Disposition: inline
In-Reply-To: <D1G108TQBWK4.2XW34J29NCAHG@protonmail.com>


--WPIJta5Vqdkshj9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 08:21:50AM +0000, Heghedus Razvan wrote:
> On Wed May 22, 2024 at 11:06 AM EEST, Patrick Steinhardt wrote:
> > On Tue, May 21, 2024 at 04:46:23PM +0000, Heghedus Razvan wrote:
> > > On Tue May 21, 2024 at 7:36 PM EEST, Junio C Hamano wrote:
> > > > Heghedus Razvan <heghedus.razvan@protonmail.com> writes:
> > Aha! Seems like this only happens when re-initializing an already
> > existent repository, that's what's missing. In that case we do already
> > have `the_repository->gitdir` set even though we did not yet set up the
> > ref storage format. I'll investigate and send a patch.
> >
> > Can you confirm that this is what you see, or do you also see this when
> > creating an entirely new repository?
>=20
> Hi Patrick,
>=20
> Thanks for looking into this. It seems that the issue happens only when
> the folder for the repo exists.
>=20
> Eg:
> $ mkdir new_folder
> $ cd new_folder
> $ git init .=20
>=20
> or
> $ mkdir new_folder
> $ git init new_folder
>=20
> But directly running `git init new_folder` when there is no `new_folder`
> works fine.
>=20
> FYI, I just did these tests on master (4365c6fcf9).
>=20
> Regards,
> Razvan

Indeed, thanks for clarifying. From the following three tests, the
latter two fail:

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index b131d665db..c1c7c307d3 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -678,4 +678,21 @@ test_expect_success 'branch -m with the initial branch=
' '
    test_cmp expect actual
 '
=20
+test_expect_success 'init with includeIf.onbranch condition' '
+	test_when_finished "rm -rf repo" &&
+	git -c includeIf.onbranch:main.path=3Dsomething init repo
+'
+
+test_expect_success 'init with includeIf.onbranch condition with existing =
directory' '
+	test_when_finished "rm -rf repo" &&
+	mkdir repo &&
+	git -c includeIf.onbranch:main.path=3Dsomething init repo
+'
+
+test_expect_success 're-init with includeIf.onbranch condition' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	git -c includeIf.onbranch:main.path=3Dsomething init repo
+'
+
 test_done

I've got a fix ready that I'll send upstream later today.

Patrick

--WPIJta5Vqdkshj9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZNrHIACgkQVbJhu7ck
PpTNKRAApZZJ+6EDmcLTB1+LKvrgasfMKbnJv71fCobTJFSByB1UOcyEjurgpB+H
QNBfwia/FbGI1QUmqYtdBVaIY4NeJ7KdkdJziUIipsv3cb24WQslX9AeVSWDLgA6
Qi9jgmyJyXGXtDYaZMq8e7cUcGlfiZTjAp5PDERC0LxC9F1QzBxLdA+6D1rLhWEn
AjymxG1g6OsMqQPwuZGGhH76tImn1rMijeXJSZGEP4zrQMWdbsbFeUaIrMaCjpRi
+SOPLeFCW8zzazPIHh/lo5JVwSKVsILJjwYZ5CVVXPUaFgk8F2w9CYIVn4Ijmq9Z
4gM6qZXuNuJwwwB0yK5Jve8pEF3YS6CBuGIIMgL0vWiHFxz26zdShpP86AjGeFWt
q1cxPPF6CWdAFgVgJHfXLLRrlk7EvrsQoXsBQwj2zXSuyuhG3J53XRAht+27glTD
qFenrb+JwtcqUsVhuXuhWHUSjlW5VrFjiBqejIzPZ1EfAUVnWm2DgfacQ4sX+njw
x6kP4mjfPazIS6bJrFKjmjXfv0LyTIxUK9IybbawtUnLvIfdzf5bwMVyZi0U/Jsc
rWjqjobzKKq7VCZFU9CnRUMQNRSbbSDhmgUD9VHRftoe2OFZEg98gIDwpFceamHG
K5zRpvfunvOM2dVkzJZVY7oyZSNn8vwr3Vfxa6DSL53b/nPTHMQ=
=FnDq
-----END PGP SIGNATURE-----

--WPIJta5Vqdkshj9f--
