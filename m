Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1389145B03
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503194; cv=none; b=jHlM5aUU43ORN64NKuEun49NZ6Utwy/BAWK1a9JvTxMwEnP+nXC3fta8qryP6lryb8BYN90/scIoUYYzaoyIf1XII+3gtwDm2jAFFM4XwFjUDjwNMszKodVr4o6c4viSG8/PFnr9lS69bT6QLzrDHFl6B0tQlwkK8Z9pL9MObEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503194; c=relaxed/simple;
	bh=Mil8nWD+XsgflDHlbxemk96OieUlxs2/K8aG/XvUZXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq2/fUmQTYp+jLz+NGUHnKKkhUgreu6mDgS8EWe1oYjucvjdSybkrCVDSVzJ3NPuZwNxH63PQ3GqTV1mdEcoAUU2saSHFNyD+mS9QAV14Eo5MVhYLIAbH3rjRgfO1E1NsoSGw4rxfT+iPQUOgGwHLrT62c6DhlOx67zrr85XI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HOMyMa5p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c8D+P6dg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HOMyMa5p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c8D+P6dg"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C3831138012B;
	Tue,  4 Jun 2024 08:13:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 04 Jun 2024 08:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717503191; x=1717589591; bh=n265fFjaQe
	Qm36Pw9NuEdb7tkRLOwBhEhAEBw53b3BE=; b=HOMyMa5pHG7IBDryhDjlxeodt1
	FHUeS5v1LfemEkh/TIbB81+MoaumEpQvGrW3CxqE2IDmvlOKcDMx66pDdiw3Lzcp
	TO5Nr7ssxP3VbJGRPwobMNiGG2L/pRll5z/6v3yuQGsiFMt7GAyBYnJatickioQx
	8QIyp5IMaUePj9sUnf8uRizKMDQUt8/LXJvqVnSioLlMoi7T/GlT2bsU+JDZf2KF
	r1NKcVr8hiItLDFA3mhyEichuZw7IknRG40NrrD1SIO4dWOCE1Y4I00y6w9GaW6S
	bH1O0Hb6m9WmUk22HNF8R1KnXeHcUNC1DEdtvGjxBiaqsrtPY00XLS6ium6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717503191; x=1717589591; bh=n265fFjaQeQm36Pw9NuEdb7tkRLO
	wBhEhAEBw53b3BE=; b=c8D+P6dgQFr0Bb4VO3+Kp5qCJxT8Ykonb/Lb2ZNWfR8W
	v9cRhvs3EtuyCUypyB6s/M0cTZFDunN9fB/J+mHkIXcqp/K92NXQD2RrfLPogNWh
	svxMJnF+1DOyuJaJKLSH7AB+X5Cmh+UKROFZmd9wqSFZPJ8IqLESexZvIulNdI5o
	YEYLPHKh3rhyF09iBtIFDBN3Qzpt5434qOqHjhWkD9XNX/w/OPdnQ/Cpse0t4oNZ
	8UHfFGvn3HvG2hfgoMycB7v8p5wkxN+Idngr7Z8eT9elNoxgghaZ666FnWiwI6p1
	IgB1VXuxoU6qiI0LH0fIWx8jIz7/gqRl/+g7U5Zuzw==
X-ME-Sender: <xms:1wRfZmVhZJZhexb0V-bMdnxOKlHUAMbrK9C0vihblJPNJM-KaRgauQ>
    <xme:1wRfZilSUN_M8H8Mipb9-R3iPpS4Ui7DifI0h02_I-a-g5YCDdkNAZaOjqoT7D74G
    acnutm4996Zo_sMtg>
X-ME-Received: <xmr:1wRfZqYpMILfh2nDaQHfNfIqjFLlZNNf7uvtvxHHcMsY_FHPHH-M7aeuLIREe7uv_O_GIwD0CaZC95VWZWeqtTrVsIoYTccF4_Wzy20o5MdBn2re>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:1wRfZtVL2FFsFNR6YVG4zEKuOoE9nbgpfsHHhjAqqoqnjlXScb8SYg>
    <xmx:1wRfZgls2Qddawy7rFcyv3INIuzHfVnjfCNxxixPpZy4DmULRkImrw>
    <xmx:1wRfZiey1ZU-rCFYaYKvMPLtlodPDa9XJMRKLLAlkR7AJmNnsFZlug>
    <xmx:1wRfZiF2nUrNBc5OdjuP96Q0c3zjcMm01XOgTIqrLFmjdRP-CE8mjg>
    <xmx:1wRfZlyROP6EEjpXMPGu5RmUA5Tpay8i9pmjpLY9VCRPuVRKWN0yvIJK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:13:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cca140d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:12:41 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:13:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/13] sparse-checkout: free sparse_filename after use
Message-ID: <Zl8E0qyamP4WWhkl@ncase>
References: <20240531112433.GA428583@coredump.intra.peff.net>
 <20240531113545.GJ428814@coredump.intra.peff.net>
 <Zl7FgVPHGiXJYSah@framework>
 <20240604100142.GC1298378@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7pEr2U27kP0aU4wC"
Content-Disposition: inline
In-Reply-To: <20240604100142.GC1298378@coredump.intra.peff.net>


--7pEr2U27kP0aU4wC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 06:01:42AM -0400, Jeff King wrote:
> On Tue, Jun 04, 2024 at 09:42:57AM +0200, Patrick Steinhardt wrote:
>=20
> > > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > > index 356b7349f9..3af9fec1fb 100644
> > > --- a/builtin/sparse-checkout.c
> > > +++ b/builtin/sparse-checkout.c
> > > @@ -500,6 +500,8 @@ static int sparse_checkout_init(int argc, const c=
har **argv, const char *prefix)
> > >  		return 0;
> > >  	}
> > > =20
> > > +	free(sparse_filename);
> > > +
> >=20
> > I wonder whether it would make sense to merge this patch and patch 4
> > and then refactor the code to have a common exit path.
>=20
> I thought about that, too, but it doesn't quite work. In the non-error
> exit path we _don't_ clean up the pattern_list, because we tail-call
> into write_patterns_and_update(), which frees it itself.
>=20
> If we refactored that function to _not_ free, and then switched here to
> a "ret" variable, like:
>=20
> 	...
> 	ret =3D write_patterns_and_update(&pl);
>   out:
> 	clear_pattern_list(&pl);
> 	free(sparse_filename);
> 	return ret;
>=20
> it could work. I mostly tried to err on the side of minimizing
> refactoring, though.

Fair enough, thanks for explaining.

Patrick

--7pEr2U27kP0aU4wC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfBM0ACgkQVbJhu7ck
PpS8/hAApr2WlQw0hTkPLy7+LfxKDCtJ5xnRizmZEBDBE7jk9JDa3ziFVinQWFFK
z74iOwfxF779y1u7+05WgEihIc1bMCsO/uw9cWVceZZumVuaIxr1bVM6XwBI6VfE
FfxGB5LxVrm5z0l4PbCz5EllHzRdoORDnCq6GOFZ80k44yv1ap4KIgmAqWDasTbu
wPree2z6df/uYwoLholWmpnyi/+MEYxNEZaBuIHDNXqFx19A6RDZvpy5qgCBhrCB
dSMX0RDaFRB9Xe4/aKZRPr9X2gTo4iZEIO9D4EBLYvdMt2GIzbU6dbyj8R0gN/Nr
O1QWG0TrgPMugyLEiz1MV+lIz5BimK9tGOvhsvLaO/Ih6tqYegJU1agpYrJKHek6
Qrgd+Tw7iDX/9Y3zzUmrq56NucgJjMUblj/iGaeVy3TTLXVkEYKPt1iiAjUOiwx1
kkHqHqp7rRDfZc1H1f26l0H8uTVtpDIe1y/pBbvQS/FGm8zxkmqA2Nc06//31UEn
ZjL8abP9+m5G9AxV/xEYTa0s/jxjUWuHOjVZYNyABoUugNVv36OvOZyL0fTARY0+
G7VTgLbj4LhQS5HYonlsHUUQJXL6iJI0MGG8B49iPMIm4CEcF+AIaGtR0kYK359q
qSZ+SIk6GLWU7Tkap74V5wVFUXuW6bxeoh4qc4V2M45+RGwY/b8=
=iqWS
-----END PGP SIGNATURE-----

--7pEr2U27kP0aU4wC--
