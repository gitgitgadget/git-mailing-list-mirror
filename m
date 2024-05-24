Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F97B12E5E
	for <git@vger.kernel.org>; Fri, 24 May 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536159; cv=none; b=UCG+aSQwoF5TZOySDmYeAVikWtdsTcAmrFrs2u4nvdAGoex/7NAKi0MdP5EoWaVmEAqQiF8+QHm3/vUqiXk04ySbgdzx/78STtcMEJytcryw0ci4jPt5tMSwofn6Xr1/urYn/4y94lGNZmCyVF2LgUG9cNKGb0/vCHrAkAgsmn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536159; c=relaxed/simple;
	bh=GSBt33SeQAPVLMZKwubJTyVod8PAFEnebfrtHP/RljU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExD4rRG667nbSHKFKekwPkY6KDTmlT17M3BWwfMht7Tv+unOngrE0vU3Hy/ZMzL2si8fyMEDo6n4Z4zmjlK2qRIO363a3SPmMRpi56WazchszP1qTKcXP+gdzkDAfjXTayyV9HVa6/3rIaxyjlxZvdvX1nguk/l62x9H3ESqrDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OSNZxS+d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JuPegF5B; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OSNZxS+d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JuPegF5B"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id D0558138011A;
	Fri, 24 May 2024 03:35:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 24 May 2024 03:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716536156; x=1716622556; bh=t3nGTSSOjd
	Tf8TfT3emyXR4Nxg/XEoVmMsT1Rv/Y9g4=; b=OSNZxS+dPvxI29M57czOGojpmY
	1SGAMbiZdE2e1Q1Oz+vz16osUZ7COSSNJuaqCE+AunXGLg/XEmfjslisPDWY5kne
	8Ml0q07SK0FJzqrPswD4P7ifD4C2qilmoxZ25puaAN3T7ulFkUzCttoNCt0uW9KP
	4AznLaP30510hSQSmvSl7p/aqSxaXSdqlrveP5JT/ahZb+aQF0bKcf5SZc8o5oYB
	nKcQNxfGxeASo8sS8SRqNeHIzt3wYqACOWqWmWpv7h77jI+kxjW1y5cmV61aE3I4
	4bYPIisbNp7jXJWuNkVa2ncXDX8wKNR+o9dMhuqGqmr77YIkz3zsHpktAUOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716536156; x=1716622556; bh=t3nGTSSOjdTf8TfT3emyXR4Nxg/X
	EoVmMsT1Rv/Y9g4=; b=JuPegF5BqI7Nnmzfy8N5Gw5aB+qZm3ykiXWgZufZODSm
	MPSFTFeFCW3ft53iEIhuJrKPuOVPlYOQW/b2+tPfdkbPQvvMVd9jq18Mn14R1QH+
	9nAvTkUm+f8rrfkWffEBAdwEwgEqV8kISLlteIK3fC/XiufNcaCu8Ts+ZaH7tjw+
	BTvcAa0ETHM0mlkALZohm93sjyOPADEnSARqVdI/5MkrKIkFUtsV0yRAOEw46Lr5
	XM5OBS716Dd2sf0eoP2F8wSqtWWo6k/ujjUt6lZOFrOyHm72qARzlPINO4aZPIZe
	G+UQaHCdOwi+LlVZjx06O2874q3q7GrWnFclotFdxA==
X-ME-Sender: <xms:XENQZowPhQePHAc3Qlgbl3D5i6I5OGbUUpKfQQx5sLkOchinXbjOxQ>
    <xme:XENQZsSCpcSFpmlfb5IEBy4bQzDJU_cjzhp9y26w0xJypNyRxJslcsF8SgFMnSPbD
    wix4PN_8L1VtxFlfA>
X-ME-Received: <xmr:XENQZqUdBepSdp6WhDZbF-ByDaCGEa2ZDbO_2d3wEP0nvsR3V4U06YS0prXMQoX8sQsCTHpUgbWlabPanC3XIR7cnjnQ4S2qF2QLGX3oCzt3X-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:XENQZmhJz-t4cNSsYK8jQc2f8tJ3iDYdudA98TrwhYbOQicjGpU6ug>
    <xmx:XENQZqB1Wbsge1Qyje-eOtL1_8SDAhTGtvSziq5PPyncR1zn4FCX_Q>
    <xmx:XENQZnJxK9U7-eRIPpVzO0cGBN3kwvupcCguHhizrTg19EZeigTlPg>
    <xmx:XENQZhBLIa_sWb_HQrC3eYr5V1LCqgxu16lIRVV2MYECYt4gLxDSeA>
    <xmx:XENQZtOWgdODxHrsP5yPufFqblqTnKKQfYcMlHH2mXgPlE82m0UMDdvP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 03:35:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 640edeb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 07:35:52 +0000 (UTC)
Date: Fri, 24 May 2024 09:35:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 9/9] builtin/refs: new command to migrate ref storage
 formats
Message-ID: <ZlBDWYwFBeVSuM4_@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <2ebcc0db657905ed2a164b302da4d02da58ca2c7.1716451672.git.ps@pks.im>
 <CAPig+cScGc2p2=FiqscY3eHfW9LHRiyk8DtycQ8H_=Ko=oVoXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pL8uoAiCYEZYglJc"
Content-Disposition: inline
In-Reply-To: <CAPig+cScGc2p2=FiqscY3eHfW9LHRiyk8DtycQ8H_=Ko=oVoXA@mail.gmail.com>


--pL8uoAiCYEZYglJc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 01:40:50PM -0400, Eric Sunshine wrote:
> On Thu, May 23, 2024 at 4:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > Introduce a new command that allows the user to migrate a repository
> > between ref storage formats. This new command is implemented as part of
> > a new git-refs(1) executable. This is due to two reasons:
> >
> >   - There is no good place to put the migration logic in existing
> >     commands. git-maintenance(1) felt unwieldy, and git-pack-refs(1) is
> >     not the correct place to put it, either.
> >
> >   - I had it in my mind to create a new low-level command for accessing
> >     refs for quite a while already. git-refs(1) is that command and can
> >     over time grow more functionality relating to refs. This should help
> >     discoverability by consolidating low-level access to refs into a
> >     single executable.
> >
> > As mentioned in the preceding commit that introduces the ref storage
> > format migration logic, the new `git refs migrate` command still has a
> > bunch of restrictions. These restrictions are documented accordingly.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
> > @@ -0,0 +1,59 @@
> > +--dry-run::
> > +       Perform the migration, but do not modify the repository. The mi=
grated
> > +       refs will be written into a separate directory that can be insp=
ected
> > +       separately. This can be used to double check that the migration=
 works
> > +       as expected before doing performing the actual migration.
>=20
> s/doing performing/performing/
>=20
> The mysterious "into a separate directory" is never made concrete. Can
> this provide more information so the reader can know where this
> directory is and how to double-check that it worked "as expected"?

Good point. I'll add a sentence that "The name of the directory will be
reported on stdout". As we use a temporary directory name we cannot
mention a static name here.

Patrick

--pL8uoAiCYEZYglJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQQ1gACgkQVbJhu7ck
PpR9VQ//ff1OXid4zcGW0lR4+iXmrpUqxmb+rhfaXtijBvrnrHjpAQovPx58Lc2X
N+9iMr8+135nYZ5dQViZLnRcH7W/SP4Pny5i8gAUJDFOBjQek5HbOBQTfveTH8ag
KHvrU/2ejWjfcOWm68mfrO+cKXDrm2eDv4lZPyYqWFfRlN27wQKnCJUqUkoEufXU
UVJvASHWxxar/xed0Mt10s1v9jKdlaVd8FyxTxbSIE7bYmR6rO2nK6BrSjkH7v6N
EiKEvmheRS7CaU3Vv2iaswShTxCsItGoJNLvFWMdP8Bi5aLv8b7AL0yq5QKx868y
Bz/Mj2XhakUzKFpy0YiEu0i+swVe/0+NZ9UBxxNFmzYC0SHsM1i200cu3dM+BvKN
+WZ2lunfhdbot/YHZKQrWcuU9OkhlhW4id5ccOOEtRpli42kXkQDfzcz94YFM4Dc
zf4hY9JMFsrheGqsIKCiJR8oYWXw1T9GVIm8EY9INaCbosSZ0pWQXhMBlb1WC0yR
fm+nTAc4j6y0GCe5DLs+2co9BqHcuXMGOx6RFTAXC0VjdtYQjlx5JwkI2DoQl7cY
vhvj4pHLogAyiL0oEuP5OGkijZQKTXLGJhICv7Hj2EiOVCA/JGZeSqJNy4C+oKFq
Kh0JAwwj5qMaS1b+VCR8u2FG32e61w0lYcnnWuN/XbbkhE/5npg=
=90Td
-----END PGP SIGNATURE-----

--pL8uoAiCYEZYglJc--
