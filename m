Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92818EAD
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546423; cv=none; b=uafK8ncy5fD3Zz576QZShJiPwki+yrhdrFwQnp70d/qr5ZQ4qwgBiK25DtDjehPs1q6+OyOM+i9Qw/7Vz5qm8bJ94tucTPQjNf2LFJZi6VLlkNLvoM2eJRqVaIjbeUbQtJ8atYwljV4yXqSOhHBKS6i7ZpX9wQKMcLjs6cVb6s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546423; c=relaxed/simple;
	bh=akMwqHCMx9A/hhqqgRYuj8iNZaGxh1exeOCzfN9csuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P74OoOEZSKZllKg+Vasl0NeslnU1z9xNWc+SeD860orDGreD/LXnUY21KD4e09Q0HMes14BFuyFZpISHas46b8BEA1PROjiEErjiIlGTBeO9KPTm5Wu3lzzFjUMJ3xLmSTdJMIcCHHGSEQ+0bsWaXgV5Ow2Q/yTdLM+f/evyO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=InvO8pFg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2zIF8h+; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="InvO8pFg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2zIF8h+"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 06B061C000B8;
	Mon,  4 Mar 2024 05:00:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 04 Mar 2024 05:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709546420; x=1709632820; bh=h9W5GqVkmw
	OAjxL8sufJ49LetMyZNVjsWPgLFIcpmqY=; b=InvO8pFgPRHH4jLKfRCahDNAmC
	wl9L09MgcdrZnPh1eioKv1Wg4ZuTPzeaSo9R+J/x3QMtN+9oMdjV0OXUiVaHwo9T
	2StuumT8KokQ6E/wPmurGoUdhFQzLVvXBbAM+vfyZcoHOfZvbuWPhpAggpB7oVHO
	p6CtnBBHho4Z1JmnzQX8AcNiM0FhjDHhaVIdPUxeQsestamoF81EZwGkKX+FHO3e
	wjVEsRTKedeWc6mw1dm94iqKkEHAqzcqOqoj5pfZq0LzDBxTlodvMttd6aCsfAQ2
	18qMPdxtuA0kl+NLP0elhk4hLAW5XoZ52evYvnddvb1HHn947l4xVT20CFWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709546420; x=1709632820; bh=h9W5GqVkmwOAjxL8sufJ49LetMyZ
	NVjsWPgLFIcpmqY=; b=V2zIF8h+ahMC9Tawk7zXriku0sZExUH0537CD/9tUMdo
	elnY6irjO/w06DK+LBhTivzgghdUoKjmoOb5dqZ5YTAG+b0jpta0TRVel0R6EFU/
	7YzdVCvLlxDJWWESyTKoiCajSXIiGgWJjVKqcEbVe258XJis7ulhS7Hvnd/0TDM/
	iJ3W2XXf9O4oeCZGsQflXehqL1kLZdNl66Z1rLPYPPAPRLwdzc9+wL5pGTUTTdlZ
	i+IgThCfv1VEfB6eZGYxdP3+iKzqD/gFeznxb0YB0PqZTMmi5ujFJyVhE9U2zYjl
	EqAujJanVwMsYjguDC6AudXZ7aMnpsvpRu2CapbAEg==
X-ME-Sender: <xms:tJvlZZ5UjMrS59jheAEicFBcJwPqkSWq18xsS6JIOUqbog5gD5Otaw>
    <xme:tJvlZW4XZJ9QJ9Iizf0f36J_KuRlBqP87zymg2c-AUH-EExxI7cojtMZfRCzVXdJ8
    rjWvp-c-LYSRPbbcw>
X-ME-Received: <xmr:tJvlZQcmc7_RdUSMxOAYc3J448DI3F5c2HBxq8F2fwuhjjAc4j4I7ta6XkZdQEPaAILQOyTLoU_skocB0_aDTFDSwJrW7cjZMk91CVpeMlnKxr4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:tJvlZSLniF16SCo5blsG-wV6riqsuyAghp0-RA8e55YxALsB4SRDlQ>
    <xmx:tJvlZdK5jp7BzR2wLMHJS8iSItt9kJBPexFRpoupiu9LSJJt3PIXLA>
    <xmx:tJvlZbxmNqh2hCfABAWLEdAzuBz0GTbz5lVlxpzU142GSWS_Mc-xGw>
    <xmx:tJvlZd1npvtQ8tOYZBbjsVsyvLzwRTmvh_rZuxpxVWfZHMkcVtkxzsVG7c4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:00:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2dd08a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 09:55:54 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:00:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Benjamin Flesch <benjaminflesch@icloud.com>
Subject: Re: [PATCH 9/9] upload-pack: free tree buffers after parsing
Message-ID: <ZeWbsVL0NF32rYAt@tanuki>
References: <20240228223700.GA1157826@coredump.intra.peff.net>
 <20240228223907.GI1158131@coredump.intra.peff.net>
 <ZeWHdaZnhOHKs5QP@tanuki>
 <20240304095736.GA3723539@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nw0E/p4iZd4s6APg"
Content-Disposition: inline
In-Reply-To: <20240304095736.GA3723539@coredump.intra.peff.net>


--Nw0E/p4iZd4s6APg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 04:57:36AM -0500, Jeff King wrote:
> On Mon, Mar 04, 2024 at 09:33:57AM +0100, Patrick Steinhardt wrote:
>=20
> > > +	if (skip_hash && discard_tree &&
> > > +	    (!obj || obj->type =3D=3D OBJ_TREE) &&
> > > +	    oid_object_info(r, oid, NULL) =3D=3D OBJ_TREE) {
> > > +		return &lookup_tree(r, oid)->object;
> > > +	}
> >=20
> > The other condition for blobs does the same, but the condition here
> > confuses me. Why do we call `oid_object_info()` if we have already
> > figured out that `obj->type =3D=3D OBJ_TREE`? Feels like wasted effort =
if
> > the in-memory object has been determined to be a tree already anyway.
> >=20
> > I'd rather have expected it to look like the following:
> >=20
> > if (skip_hash && discard_tree &&
> >     ((obj && obj->type =3D=3D OBJ_TREE) ||
> >      (!obj && oid_object_info(r, oid, NULL)) =3D=3D OBJ_TREE)) {
> > 		return &lookup_tree(r, oid)->object;
> > }
> >=20
> > Am I missing some side effect that `oid_object_info()` provides?
>=20
> Calling oid_object_info() will make sure the on-disk object exists and
> has the expected type. Keep in mind that an in-memory "struct object"
> may have a type that was just implied by another reference. E.g., if a
> commit references some object X in its tree field, then we'll call
> lookup_tree(X) to get a "struct tree" without actually touching the odb
> at all. When it comes time to parse that object, that's when we'll see
> if we really have it and if it's a tree.
>=20
> In the case of skip_hash (and discard_tree) it might be OK to skip both
> of those checks. If we do, I think we should probably do the same for
> blobs (in the skip_hash case, we could just return the object we found
> already).
>=20
> But I'd definitely prefer to do that as a separate step (if at all).

Thanks for the explanation!

Patrick

--Nw0E/p4iZd4s6APg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlm7AACgkQVbJhu7ck
PpR3VBAAj/k/n9CfM2937R6RWvFq7bKHVHZp6WSjQcYadjcOyS1XXsQH/4vL5FFl
yZNGuQgYqhCkhiy9lHdBan0PHgtgrzd8BNNFx0RZIH3dm0D2Ew9ysFo15IjHfjEo
YSVHr9iS0QX4Gkr4K5zlKZtfFoCWveBQbZX27/2GP0M58g6/c+DvFpWL8oKl9LCv
InY3kBe1PhS+ZnZJqgQEclgox+vl47XDK8jSFSGgLiFdmV8M7vGGK64oXD9Go7S5
wB16Pee0r6I+GXVKtqh94K6plFByfaP/UyQ4mF6xI1aSzLB75PQ4Q3KMFEKyYCAh
DhXWMaYzz8NOoelAwX6p1mkeglSNbtW+CJ8Gl/k4KZDJ8EqdgktvTbgx1P5c3AqA
+UOiNFidI1rG1E1LLujTSbCz4b4MApvH0z22OMF9y6KRpzcpaNetRBkZ7Kx+QH2t
zDxa1YeggMODBdUWqNMl/mIVkn6/TMKJxYGUUFf5NmRawTSG4dQATLIoRDZ2Me3r
EiNTa8tck8dfSIJEHQ4l1GdhkGj8mG/3sPxVKrEFwRnKmfFIjQEkWAf84JfFYB/i
aZTCLswASqnH88XkmTUlhPeagLybHVR45FfZglA5UfXRlA4GG75it3eLpgXd6pI0
+09vFlYfKKL6TCH9H0LxRpBh8m41dZzik9Z8o82nCiNwqp1/OrU=
=LRYL
-----END PGP SIGNATURE-----

--Nw0E/p4iZd4s6APg--
