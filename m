Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00284535D6
	for <git@vger.kernel.org>; Tue, 21 May 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278284; cv=none; b=eufpOgys4XnLQEe+SBBQlEKhFnkUCLTMRi5vvyh8Dt/NJPV/KsJ7CPLbFt6qnfBt+Ddo4U22xqzXsY4PtzS/FSHnKzJFu8G3uTkf0ebi/K8wp7iUL0n6uhE1XDLVp+zSro4RdCrgCFolhNIP1NhySgUYymsPYgdcvIr+uScgwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278284; c=relaxed/simple;
	bh=mWeDL2FOjgcr+8WhJAJ8k8mAwDcMkTEZlix7B+0rcm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daGEHQpcpbORQFigosg4J99EvZCjC9EJ6a4oaWt8rRlnCMG7v6AuLoXRgC5Mg6rTXC36RPi3ICTFkBCJGiL7Se00dojJP5qO0dDeTVkiCAswaMgaepLLAcRWIAgfUl5RynPHVEBeS4CGqBd+QSClpJQBwx0AjnqEF5ckdlXFnEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mFzVBh0u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NezV002y; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mFzVBh0u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NezV002y"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id ED63F1381495;
	Tue, 21 May 2024 03:58:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 21 May 2024 03:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716278281; x=1716364681; bh=mWeDL2FOjg
	cr+8WhJAJ8k8mAwDcMkTEZlix7B+0rcm8=; b=mFzVBh0uNVx+iiFX5KdKq/FSnu
	UbS6nzppPh4K0GUxQObotwHtMw949ccBf+4/sP9qYnCav9NhFlDrYdmXyuQ0U9TL
	91M/KPTj4ZVIlvPLmckhHqu2XEEx4GzQXwWq6YuD5viiPwgvxeBZ82p9oZ8VxtFY
	zgfgRoo5kwobNiutERuHt9QZD1bL7Ar0TIU2zUc8y+9rgGFEs9i7h7AI27vB+Ex8
	KLgC5W5Y+AjdGs/qgkJV6MWZ4uPm6smytnmK6b0YxyF2gRkvVqzf/hu7cdXduTGn
	nJJMEKET6wEl3NF2EZDSVoe8gE3YokjxO4geXPZz+4fDz0zegJOnysmD2yTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716278281; x=1716364681; bh=mWeDL2FOjgcr+8WhJAJ8k8mAwDcM
	kTEZlix7B+0rcm8=; b=NezV002yqGGjCLWSJ0vcQYGifcQ1sEqdDNxn/DZ2P4eE
	iEsb2ruyd5ZyEpqO3j1401lXAUMPsmTpOMJ6wdMq7wBmSZCb5wvEzQwnGCYsYD4v
	kzSZbRGjDKCrqWAjZh+CXTekE5Qa8jTWFbOyPlIn9J2RCKtjSIbGpiGLcpnDJo+D
	8YdR6uI2X3uBLjI70s9aMT1HZLKc8QPoRmRvGHvPX4wzz60Pdw4xvfLfllRusiBJ
	JbSWhUbJ9eQEEIvC4p+ldIwOxfbc40Juz9okbZQ/sFgThvD9WCVB/2l7DGRivug2
	WpOWpxSBAMffuUcPwlVoxlPpqka5bjT/MJuXI6L5mw==
X-ME-Sender: <xms:CVRMZl_I5LS61d_hAoWbnkhtr86YzchrR70JqfSfoIJadj9rCutofA>
    <xme:CVRMZpvG-PJxRrkUoUVbXIdnn7PzBS5pZT9aE5D0ptAJQgvHLuEm7IHRO0lbK7Df2
    7tt70RlAkhEzR11ZQ>
X-ME-Received: <xmr:CVRMZjAqoG7vjIJfYgMudyTJYBcZOnLRuc5aowR1tDoYJhTzpnqCEqxpz2pLtt2un3Kcc1gbw9kCu9orfJzYWFovz7c-ls1IVJliEMvAMBFCex8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CVRMZpeCPMmOAdhuQQjH8aDx64KoaF3PDZTG1hpbI9JByNBfIaP6FQ>
    <xmx:CVRMZqMIj50PvZgNSJJFiCfp6GyvlasXCJd5jJ11a385mGmj5gOE7g>
    <xmx:CVRMZrm702jZcyJFz3BZnZ4kMOejeedamGRu0EAsMRqtmVs9Lplz7A>
    <xmx:CVRMZku1-Mt9AiAF6Z9Te4_f6DHkh3HuXYW45rwP5KQtVgu3CKUUXA>
    <xmx:CVRMZjZnJ1_h6vsDSckhaCfgz978t2T1tPkmEDNAFKm_GHGnBOz114Dh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 03:58:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 599da80e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 07:57:57 +0000 (UTC)
Date: Tue, 21 May 2024 09:57:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 1/5] setup: add an escape hatch for "no more default
 hash algorithm" change
Message-ID: <ZkxUBebjx8WvyJnm@tanuki>
References: <cover.1715582857.git.ps@pks.im>
 <20240520231434.1816979-1-gitster@pobox.com>
 <20240520231434.1816979-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZX/2OVCTwX1AEpMp"
Content-Disposition: inline
In-Reply-To: <20240520231434.1816979-2-gitster@pobox.com>


--ZX/2OVCTwX1AEpMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 04:14:30PM -0700, Junio C Hamano wrote:
> Partially revert c8aed5e8 (repository: stop setting SHA1 as the
> default object hash, 2024-05-07), to keep end-user systems still
> broken when we have gap in our test coverage but yet give them an
> escape hatch to set the GIT_TEST_DEFAULT_HASH_ALGO environment
> variable to "sha1" in order to revert to the previous behaviour.
>=20
> Due to the way the end-user facing GIT_DEFAULT_HASH environment
> variable is used in our test suite, we unfortunately cannot reuse it
> for this purpose.

Okay, so this now really only is an escape hatch for users as we do not
specify it in our tests anymore. It does make me wonder whether we want
to name the envvar accordingly, but don't mind it much either way. It is
only intended to be a stop gap solution anyway that we can eventually
drop once we are sufficiently sure that there is no further breakage.

Patrick

--ZX/2OVCTwX1AEpMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZMVAQACgkQVbJhu7ck
PpQqYhAAoYY2z5tHOV4GEZeJb6aYZkfb2GsfwMl0QDQo0Z0fARz6fYrv70JLFI+9
ma3wRG9GhFsf8YqDymVb9zyzmoU2OBqINs8hFJBjNPOOoIysidNvD1vtG53oqb5C
F3XjG7WDIQRXw9PLIDklruVuGNqRTnOzsl939btBQBbrSCwRVQQx5WowliZkRR9R
VDivnMT2yAdXrkF2HfUd7irhmUQYh7qjkrrBJ5OF09+wLWoA512MnqiaftBqEEk/
JKTcQLfZQV9zl2+tcOrOFxTlvgsVHFPSkrfKhAQR1lsAtGfOK+cYA/E3Un36pEPi
4duqYZQBE6n6uFCBLd086yaNFjn/c4rI+6MdNmT2r6skFB+8lBf+q+jsglBV7AkW
AHpbzQpMzBzjQA2n+aaNhrCXPYUM0ChEfbmA8sO/SQFs+ufj1D6bf6pb/iKBwehV
w9HP4KvXfmJ74+GwzAiI6i7860b6/P0+Qy/+1KUCwPHjx4Xb1bf4tWpSROUOGEg6
1PJ4VDSk6SfFhZfzzS1ALsaRcWeCGAACNEQ96FwaImLwdGvjuycFxtHpSolYGQBs
sNmOpnrVI16NJOW/3bHOj7SFid4DOKHQXgaBULbeeHy63Lu6mfEza044gqg3jKF/
5SxsfMIzcwYCIGzCOQlbbes+PQnAXopheznKyFHB3mtOpPX9ydU=
=uAgq
-----END PGP SIGNATURE-----

--ZX/2OVCTwX1AEpMp--
