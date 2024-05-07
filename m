Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3C6EB7A
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715062518; cv=none; b=qCNwf2nkGWFATmfn96t8rfa/4IXgbCXYL36qse327dMsKS6U/6R1n84Gbuq/RmOzDqBYS/ljFTC/nyoVhMVQALO+G3lxTEviYckJQEM0k00AYp9KDZgiUQaRHSnFgIqj2mQaZCldjg2wnqzAZVEtCCJJRdyYRQ4SUsTvQAGvIlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715062518; c=relaxed/simple;
	bh=UGs8jJ7qD62TCqi6GotbTR/HxTYkGx6vmqFj8ALpjwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mgz9eICsWL7/J2cT85AVpyxm1weknJXhkR0VxL3LXsaDfn4c+yeTxtrdWYM/Ngtv/RJQ1o0IUWkflxYvAkmuNnOl+wqK/zXP41F370lLazIHJKSaQlS73yxbyumYSwZXhO8m9FurQDznHeakWsSZNjzkoz+gpmSan/vjl+v/BR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fSl9xPN2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f9N9ozOM; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fSl9xPN2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f9N9ozOM"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 53E6818000D3;
	Tue,  7 May 2024 02:15:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 May 2024 02:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715062514; x=1715148914; bh=S5XZiBJ1mk
	Q6x8or3fS70LGfKEFjX9Xjb0Ta8Vcehko=; b=fSl9xPN2S4keYyI5ySDy5CvWYn
	EP2fF7EERcDnGHGLYP1L2EEpp216qydHDyH2nkjGueWw/WAeh5mNO01fy7XOZxcz
	uPYjj/vCP2wR1LcZ7JVUz27dLOcoxP2KM4yvyBn1oNTDG+eSJ2hw1kwo+R+pSer/
	MhZ+j5sIbDbiSQEpBODJWhubllYvouDVR0cEzvSrtVsuWE65UQT2yKkKJPI7eq1W
	+8ukoZAE4gpmhg8IhTFZbwqwqorfAQ1fhJKlfCOUvmWOXbo5Wo41ADbujsxGiKMa
	zOgaT9jYZ2WHpMcILzC/m2a2QwVz5Ve815WP2a2QGS9amHKN3hbGSjwq+inA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715062514; x=1715148914; bh=S5XZiBJ1mkQ6x8or3fS70LGfKEFj
	X9Xjb0Ta8Vcehko=; b=f9N9ozOMrpInMFj6gYwKIl7yoTxQB0N8JaYm5prxUfHO
	2fcaYXKyElLGQfzPpI5u9ac+WCOIAkAyQGap2fvVi8NUfWxA4NytdzLawfWtWKBt
	rKd98OSil4WbVLYFAn/RkrrH9rgSwQgNb20P19eRJjBg2g7MAgVVLxiLMZy+YOEA
	wQW/lMLqeNpmQiWuPiWMRg4ARuNMUJemZm6RwfLakxaYnj8MjFFpoW+v8C49G8Eo
	oVz5XEnoW4ax98HFtXuceTi/lqNvND32kACXyyMPmzUsYnhUXsSg7YQ7WTtsyrTA
	gz/WnTqKW6AOnw3z8OihpmFoSu4EVs7Nwheh2K8+vg==
X-ME-Sender: <xms:8sY5ZtSitbghfyxidm2FKhb0vhdpPuczTJ0RyZ7hL6PiIHNV9ammng>
    <xme:8sY5ZmzoBhHIMybGVUS4j0WWsoSzh6gFqfIM-ZcziMz8mFzMaNmng_xSeYbEeILnK
    9TqG5qrXmfsUV50iw>
X-ME-Received: <xmr:8sY5Zi1WslcjWJPt9jQYMDyi7Xv3I1L1K-0hkhxycc8YntMc-6F1XhsjcWXJa18AfHIWHb3uEwn38vQAUxEjuTmr9PoOzI8cFhnqsJptQfFvnSxm2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8sY5ZlCLukyEU1jeR5GnNdyAy95fnsWrtSr6Z5ukY6YzE1322AswMw>
    <xmx:8sY5Zmj1mk4BU463k0YCeBTS4cYvodJhRf1LZDmsgrQhTJP4_uoqdg>
    <xmx:8sY5ZpqJPJ37MpShmNmNmie3MydzJ9HXh8GfdeTKiXryEaVwCT42sA>
    <xmx:8sY5ZhiE_C5Vij9LNbWVOWnDadGsjyiXGUos5_qrH_UVU7XZIqrKSw>
    <xmx:8sY5ZptHOC362MbFjwKLJBrjYBZf1rBM-xdFQykb8lC_YQeI-rumnY26>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 02:15:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2d2fb67d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 06:15:04 +0000 (UTC)
Date: Tue, 7 May 2024 08:15:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #02; Fri, 3)
Message-ID: <ZjnG7XIKJMRr2K1j@tanuki>
References: <xmqqa5l64e0i.fsf@gitster.g>
 <ZjihN01c8gWX0s9H@tanuki>
 <xmqqy18mwpog.fsf@gitster.g>
 <xmqqh6fatawj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7532azEI63AROr/D"
Content-Disposition: inline
In-Reply-To: <xmqqh6fatawj.fsf@gitster.g>


--7532azEI63AROr/D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 11:05:00PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> >>> * ps/undecided-is-not-necessarily-sha1 (2024-04-30) 13 commits
> >>> ...
> >> Interesting, I couldn't reproduce this issue when rebasing the patches
> >> onto "seen". There were merge conflicts though, both with
> >> jc/no-default-attr-tree-in-bare and ps/the-index-is-no-more. So maybe
> >> there was a mismerge involved somewhere?
> >
> > That is very possible.
>=20
> Yeah, I think I botched the merge.  Somehow my resolution had an
> unneeded "|| !is_null_oid()" in the result, but the right resolution
> of course should look like below.
>=20
> Thanks.

Yeah, that resolution looks correct to me. I've also sent a v4 with
increased context and with the two conflicting topics pulles in as
dependency. Other than that it is the same to v3.

Patrick

--7532azEI63AROr/D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5xuwACgkQVbJhu7ck
PpSCjQ//ZwujVAJOF+EXY1hSVKRiVFKWplCxKc2kLtF7pbF2eHWg/vTI0i0ysn2D
wa7jhpPdxwa21n1U961oh6PDYE6LdRvRKSBvN9Qexs2ZOgBrUvYKV51ZlSuLg+ou
XAB7cZA/gqKM0sNw/GtCilkccItaJDJxZLsXB3BB+D2Bq34vz617aQ3ycb8Xbmx6
L8nXG/3vBZu0vk6QgLGE3fcN7cCjwyS5GtJzA9cm4ajUBtk2xySC7fPZmUIkLN2r
FGqnE4nxOIzfy5JfvbH4smC/I4Gb479mThJW/AF3f/VFRZAFEe3/K4RtfWMW6D8s
ZYgrZ1vGvsXV7ws/mWslWJpqnXgoWr+qGbQDTfjkiPJVN5PiRxDJoG8K8t23TPMg
1JvTRbn87beenyA/NIc6WmthzvcMonsLtRBt4hx3wSkpgN79yt/yo3dv8BR2HIlw
uPva7k/2esTs98VbcSOxc6advOvHZCPYB+HqYjWclCUT4yKePG1kPkEp02FkIfvl
L5Bo/FR3enGwje/4puZka+6Ma1GTNTqCMvQ5dcsNcRFxcXZiE5nDvv2bvKGq+Pxl
g2wsRTnDfz7MhgBj01UKkCncopfCXXKOCJipMyWFcxeeV1vxipXXXKx3lfh0z8HP
z25QyhA4e1KVDmKK4xVEOfzsmjeGbEI+34lTfYWNfuQ5Wm49LOU=
=NXLR
-----END PGP SIGNATURE-----

--7532azEI63AROr/D--
