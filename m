Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668674594D
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462212; cv=none; b=JsHGw0zpTUcN2Z3CrsgRINk3H+c6/J20xZ16N1e8sn0/LU3yeKZOfinlUIqHyWtLuC9n4Cq3K9eLOZNJQ7KCBiQ5B+qFPkfuTzf/u+eRzLHyZ2HeFGd3ic0xJQAC/Szx49Xp0OHPEFejcfxgB5mcF0el2avSvD5EvhER6V5IYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462212; c=relaxed/simple;
	bh=8+x6l+6V9qBvDHZgU0Cmkn12HdEaM399BtBvG+3O9kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loZCBnz1jGcy6idTNJmfsaWsnUQbas9qjoc/+7A4D9esCcgjH2m//Od/b5JxXL/cYOtCKr3oHTAvN7YQywDyHZjLSN5DfDxWF30QuhhF5JfK9Ha/kpqOH+eN60785dIMVcGZ78RhJ3bt1KxGzXEcY1tE+loctrBEfuNmu1sbCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YOLsMF5o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCoSFApr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YOLsMF5o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCoSFApr"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 709B71140156;
	Tue, 30 Apr 2024 03:30:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Apr 2024 03:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714462209; x=1714548609; bh=nO2YLbJYOp
	NPPRED4TdcnFvMmj/lMITBpbk2IR4bGV8=; b=YOLsMF5oXvEt+vthN94jovmwwY
	v23JKz4B2WAMdWBjdC0suDoxweakbuioFgkhJELxYbgI+TffcellqNGhorQcXH2K
	PgDhdx4W0l0ReIhPGjm88IPxdBT8xihRiwqGbT2So57PAGgceD02IXrfBCEzXmAU
	+SY6V5jExHyhKXZlhoDJb4qPH8q2s2rhk9NEq1gkcA5ropbS4UHeRSSKM3xYdvfI
	/KHcoFLjA/qxgx63/KHz/GgzlkX4VSKEFOqtbwGJyBNYPJbinisAvC02CNIJYXC0
	rV5p3/Y0zNitip2g+ZnWyVSM9IoX2S5Os56UYniwpPvHJZkLwQ9VidT/DA8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714462209; x=1714548609; bh=nO2YLbJYOpNPPRED4TdcnFvMmj/l
	MITBpbk2IR4bGV8=; b=DCoSFAprRrXzP01vXE2DRd8tMwUnICathl5tlUNNm4bg
	B+rgL9Oe1g4lW6hsM5Ee1Ytwo/6kQopur7lqTfmviqfsygSPdVEDCpCDkSVXz5Kz
	xACA7IIptq1Bx+qxc6F3ozR5WPPM0g1Q5kDDDQ2T95V8jDUMuthBc3EaqNpFipMX
	PYCDIdm45CvaVVOyTizjRXn1mlNQJ94Pzq6BeZbMMIRTqoe6DlrOGr6ad5HHe6zb
	PdAl8WgGnx9H94WROLpoBdaf5dc0FvOABFgfoPSnPVEtnr/1ee6DWMIgcEH95ulK
	VdTzxZ+cyTkbBNyaLwX1J4o9p9ScfXDXbY0uy/3OUg==
X-ME-Sender: <xms:AJ4wZvwSSiKPMsI60buKG_HrjuPWQgDX2EqyI4urhx1sMxkqIPgQrg>
    <xme:AJ4wZnSZ3nbE1Z2RtYnIF3BbBG2LqCWbrpmeDZyaghG7Ks8_E2Th-0vETns1aJUzh
    V4dcGuvkYVUIkoB2A>
X-ME-Received: <xmr:AJ4wZpXm9aCEv9DFsFHzZSCDghgRIt5pdj_hRQmnTEhYF3AkS3Yc4nyiSrXJA7zLfcgciTTVUOtvGG7tPlzsVGIoVLfiDX3eeT_zVLWj0tJm_Q6PyiB_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:AJ4wZph3HIL-jG51rFeNOD6QZcTly3NcbrvWZ2wjNvj1r1FvvTDz0A>
    <xmx:AJ4wZhBA9UV6z_lHTNNbknDBSFdiKC-KPLUzK-O0UeDLrnSkcjwWfQ>
    <xmx:AJ4wZiJDoZByia_QKKnQkQ1D6NNnCdYpG1Oqt2sWSnqTzFaVwU_F0A>
    <xmx:AJ4wZgCz70inbANi7259xKhx-hj3doZh8Fii6Vh0MXovx9rLQ9gDvQ>
    <xmx:AZ4wZs-hBHuMf4hNT1_2NGcoZ17QslMfn7ZIf6OEYJfOQYofoC8tVl3D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 03:30:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 64c91b45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 07:29:46 +0000 (UTC)
Date: Tue, 30 Apr 2024 09:30:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
Message-ID: <ZjCd_drNT6kyjNa6@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
 <e57ed591-5006-453e-bc93-6c53fcab2aec@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vuLtGt/ipC92fsXa"
Content-Disposition: inline
In-Reply-To: <e57ed591-5006-453e-bc93-6c53fcab2aec@gmail.com>


--vuLtGt/ipC92fsXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 04:12:37PM +0100, Phillip Wood wrote:
> Hi Patrick
>=20
> On 29/04/2024 14:41, Patrick Steinhardt wrote:
> > diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
> > index d71b199955..4275918fa0 100644
> > --- a/Documentation/glossary-content.txt
> > +++ b/Documentation/glossary-content.txt
> > @@ -497,20 +497,28 @@ exclude;;
> >   	unusual refs.
> >   [[def_pseudoref]]pseudoref::
> > -	Pseudorefs are a class of files under `$GIT_DIR` which behave
> > -	like refs for the purposes of rev-parse, but which are treated
> > -	specially by git.  Pseudorefs both have names that are all-caps,
> > -	and always start with a line consisting of a
> > -	<<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
> > -	pseudoref, because it is sometimes a symbolic ref.  They might
> > -	optionally contain some additional data.  `MERGE_HEAD` and
> > -	`CHERRY_PICK_HEAD` are examples.  Unlike
> > -	<<def_per_worktree_ref,per-worktree refs>>, these files cannot
> > -	be symbolic refs, and never have reflogs.  They also cannot be
> > -	updated through the normal ref update machinery.  Instead,
> > -	they are updated by directly writing to the files.  However,
> > -	they can be read as if they were refs, so `git rev-parse
> > -	MERGE_HEAD` will work.
> > +	Pseudorefs are references that live in the root of the reference
> > +	hierarchy, outside of the usual "refs/" hierarchy. Pseudorefs have an
> > +	all-uppercase name and must end with a "_HEAD" suffix, for example
> > +	"`BISECT_HEAD`". Other than that, pseudorefs behave the exact same as
> > +	any other reference and can be both read and written via regular Git
> > +	tooling.
>=20
> This changes the definition to allow pseudorefs to by symbolic refs. When
> is_pseudoref() was introduced Junio and I had a brief discussion about th=
is
> restriction and he was not in favor of allowing pseudorefs to be symbolic
> refs [1].

So the reason why pseudorefs exist is that some refs behave like a ref
sometimes, but not always. And in my book that really only applies to
MERGE_HEAD and FETCH_HEAD, because those contain additional metadata
that makes them not-a-ref. And for those I very much see that they
should not ever be a symref.

But everyhing else living in the root of the ref hierarchy is not
special in any way, at least not in my opinion. We have never enforced
that those cannot be symrefs, and it makes our terminology needlessly
confusing.

I think I'm going to reroll this patch series and go down the nuclear
path that I've hinted at in the cover letter:

  - Pseudo refs can only be either FETCH_HEAD or MERGE_HEAD.

  - Refs starting with "refs/" are just plain normal refs.

  - Refs living in the root of the ref hierarchy need to conform to a
    set of strict rules, as Peff is starting to enforce in a separate
    patch series. These are just normal refs, as well, even though we
    may call them "root ref" in our tooling as they live in the root of
    the ref hierarchy.

I just don't think that the current state makes sense to anybody. It's
majorly confusing -- I've spent the last 8 months working in our refs
code almost exclusively and still forget what's what. How are our users
expected to understand this?

> Are there any practical implications of the changes in this patch for use=
rs
> running commands like "git log FETCH_HEAD" (I can't think of any off the =
top
> of my head but it would be good to have some reassurance on that point in
> the commit message)

Not really, no. We have never been doing a good job at enforcing the
difference between pseudo refs or normal refs anyway. Pseudo refs can be
symrefs just fine, and our tooling won't complain. The only exception
where I want us to become stricter is in how we enforce the syntax rules
for root refs (which is handled by Peff in a separate patch series), and
that we start to not treat FETCH_HEAD and MERGE_HEAD as proper refs.
They should still resolve when you ask git-rev-parse(1), but when you
iterate through refs they should not be surfaced as they _aren't_ refs.

Patrick

--vuLtGt/ipC92fsXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYwnfwACgkQVbJhu7ck
PpRleg/+KaoBH4hDXY8piIVTC5/5j2/GSkXCEulj5gHUdStpuE41V3x2e0gKC9Q/
L91nMDH2TSiANhd803uDW1HXZip/ZJFk6+vZYD5uo85462eWE5z9S1ov5pY/mBEp
pPPnpbTx1HoUTA1g2HekSB/OUQ5nmFrrRZY0tWpc4JevQX+8TxxGIrrSEsBTkFTH
y1rC1Za4nvT7KyKAp8Jnog7B50BBpT2VF1dCM7bJu71Suicjd628qr+jdiLlWigm
phGeTVcmLvjuAsVDnZgn+ML0sRL+CI3WbVAtXkZU0Xj0bHr/tYFMdL26tBeDVM/F
JhLMPZUqGl9viNIUgiixVKXtEBI7oL+POPDEU9St3KTEfuhnknA1y9bfQmBeFZAV
vM2XEnwtmEAyTNng/t2VFpYAeVqGRAe1rZ//bykUV43fuSCPjirdubrxw1uy2T7D
kp7qYN1YOIvOPSyXEhJ9j8c5Cbl6bFbesMsHxJvWhpkiCabT0GYsrkh4UeeYIQFR
H9/MT6GPp78MLNRpiOMhQ7NtbkSTTesca9KWiVh+ZK/uLuh/Y9Q8BmZVu2iFmPuA
Wa4LQiV0GhuGxwDvuHINZTDLp/3r9cnZUukOLaaOlGC/FV2BZAymUBKmmdO5rGPN
oGyUIQoL2dsZaLhcUXzZrQdAUGfuktowmkyHDRFPh151sUA7fnE=
=0wEk
-----END PGP SIGNATURE-----

--vuLtGt/ipC92fsXa--
