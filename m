Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B9446DB
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516090; cv=none; b=YBG+egfIAc86kPVyOqYESTJGFbKyPRjAkfdNWiNaedXgcWlvcof3aZELXeuHNkJLecKbHyfON7qvGNbnwsZQzCQ9y+i7G4MKkO/ZdxSqYN3NWTFyTwf+YFXcwm9NZm/XapFnXjU1PZ7Q8cRA5GwIzC2boh8KeUrqff2UfS5VSSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516090; c=relaxed/simple;
	bh=snDEDEquDVGJFctrLHQndgGLmO/cYD84yxVQwDR173E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwlMx7hqOx8DpYMULRiRc1wbZrFch78SrQ+X2fVyzyrY6AY+FHRfWX9oziViL9aOCa73T3jIKTbNyOKHLRpcdViW5ApVnB6jSd2xrxySp2N3kmbT+BeEnT1UUWmRPE0dzm94Xc7/WiHpXvOo/qpUIZM2C3fY066MoLTkWjRPxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qaHOZhvT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QsIKynVu; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qaHOZhvT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QsIKynVu"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C1B2211400AA;
	Wed, 21 Feb 2024 06:48:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 06:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708516086; x=1708602486; bh=WKU2FQIP0B
	B7w9mfFTLSki7CCjbxcw+kLi85gqRFaXM=; b=qaHOZhvTjDm5PKG+bBQjsp1Ry1
	sT3Jeyxa5O3DGKT81mHEZYaRz13gqMxd3eC/Zo2YQyLR7Q5GeXz11DIIyo6LIK7K
	th3e/i/t+VhauCPpNdZj+7TEJI/yoOusramtjkN6YKIUGGBQ8yWGc8QcRzSQzReP
	4xTWb0BTWhBSvfs3shpgLiOi1l8qEaze+z3Y4+5pZduMOERiUhYYG1jW1gHX7UFf
	eR1xeVDfY6kvkk+04QCfANXkChogRHp4iC3/wAfmWA6UxHgerdxX+Amk+6P8sKrR
	BH3dSUpcF0rc2d7ReYDFs5Mn6aE8b8Ps+2SzuIHRPuzWJYDMiKubPTqmwjZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708516086; x=1708602486; bh=WKU2FQIP0BB7w9mfFTLSki7CCjbx
	cw+kLi85gqRFaXM=; b=QsIKynVuQN/IeO8Bm4H880N8OlrIoygv2w2NO74l50qV
	O6KXeN+HCx2sCnr9dmCbdbe/5iPkDCCdOqHd7KtqMJearvkm7vgUFk/z8sue02Ib
	eciDI0fAr166jc3QPxkKnsyrLgmymib9qIpzuEFDVJaRSveUX8Rz9qs4HwZnG1Gj
	OEndYeb0Z4kIK8ItGPla0/G1RuNIAeENbr/jXVaeAIC4kRyfN4LVU5wvX2Zvnjkq
	8sU2hdMDjDu/aTNMl/3pni5tOkfqE6RtfmslYzcAbyx83YEpvQ7UsIc4JRuKtE4v
	FtHviuEm3xAc76vSE2EG1sXkcKWCrJC43GN72p0Lrg==
X-ME-Sender: <xms:9uLVZRLJvpDL5wvpO6dinA7-_RYC1AVrusLK_22_RxPrc3mRcxHIYg>
    <xme:9uLVZdLkb0oMojTInC_iRkoKhwMNwtW0-A4TQlA8x2W72UaYH1Ex93v2IVq54n2rz
    MBndoTImpMaBg-ftg>
X-ME-Received: <xmr:9uLVZZtxMT7HTMyZLXfKsoObv4D8BHn8w0cHjLt31Qdbq0gESQjAacjliNmEDn_1XSjyOAXjBZxGYYreW7WJzG7zDU8iYYYQeNUqbXvFF3zD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:9uLVZSYN5lCzV0A-NDnoJ3HkQ0CHk2Hf0lVIqS9pfTRbEDlTpXF_8w>
    <xmx:9uLVZYaBD3F5YVi8pJYe_Bl5ZobGLHoPO88eqA-x4M94u4Hkx5D6rA>
    <xmx:9uLVZWAmZy7Ul5MiMDG19tQDayr2CVMetAbh_TmB43MU3LP1ng44zA>
    <xmx:9uLVZXn5muMqnv6GFV710fBwv9lTsuwj0t4F34xFZl-mSxhGbbqSuA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 06:48:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d8287c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 11:43:58 +0000 (UTC)
Date: Wed, 21 Feb 2024 12:48:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] reflog: introduce subcommand to list reflogs
Message-ID: <ZdXi8agx5oxKfwrD@tanuki>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708418805.git.ps@pks.im>
 <xmqq34tnrqxv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pGg8jbCKcuakLbRf"
Content-Disposition: inline
In-Reply-To: <xmqq34tnrqxv.fsf@gitster.g>


--pGg8jbCKcuakLbRf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 09:22:36AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > 3:  e4e4fac05c ! 3:  32b24a3d4b refs/files: sort reflogs returned by th=
e reflog iterator
> >     @@ refs/files-backend.c: static struct ref_iterator *reflog_iterato=
r_begin(struct r
> >       	iter->dir_iterator =3D diter;
> >       	iter->ref_store =3D ref_store;
> >       	strbuf_release(&sb);
> >     +@@ refs/files-backend.c: static struct ref_iterator *files_reflog_=
iterator_begin(struct ref_store *ref_st
> >     + 		return reflog_iterator_begin(ref_store, refs->gitcommondir);
> >     + 	} else {
> >     + 		return merge_ref_iterator_begin(
> >     +-			0, reflog_iterator_begin(ref_store, refs->base.gitdir),
> >     ++			1, reflog_iterator_begin(ref_store, refs->base.gitdir),
> >     + 			reflog_iterator_begin(ref_store, refs->gitcommondir),
> >     + 			reflog_iterator_select, refs);
> >     + 	}
>=20
> This hunk is new.  Is there a downside to force merged iterators to
> always be sorted?  The ones that are combined are all sorted so it
> is natural to force sorting like this code does?  It might deserve
> explaining, and would certainly help future readers who runs "blame"
> on this code to figure out what made us think always sorting is a
> good direction forward.

Not really -- it merely gets passed down to the base ref iterator to
indicate that the entries are returned in lexicographic order. But I've
been jumping the gun here: the `reflog_iterator_select()` function does
not ensure lexicographic ordering between the two merged iterators right
now. I was assuming so because I implemented it in the reftable backend
like that. Should've double checked.

It's an easy fix though, which I'll add as another patch on top. Thanks
for making me think twice.

Patrick

--pGg8jbCKcuakLbRf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXV4uwACgkQVbJhu7ck
PpQSEQ//ZOTcJ/vV38hsseqGmsCCC9FGkrmIqZc03AOBDcreOD851oSGmpv3MXwr
xSh3vCBBuGjRg3qK3CkkAAG++hSgg0tz49MxCMUwkbXnWWaDGdoMrz95gQOhojBX
nudqdAxbBigOomMqs1ZClSX5z0friiE+mvgivDC/i4ybbuy0N56aJwnzBsXHP1Ep
AoSrqewa4QXMLQsLhnafymi6/cdkSJBgX5IMObg6RIxLbHR2nN5dpFRXDB1dOjSW
D+wt2/yrhNu1jypZEYg313dlwe3or20S2Kcfi5T15O5a5e4S6sSpNgwbeUQUQYxS
xdASoUZW1+qL6YvX53oakvQIW846q+dX9JAw3ePwHQJyxYwBidUNX7Iql1gQlawf
5u+SsIMHk41/FAI813XY0EaO4QT5hO1XYdI0TRuUKGHGJAzY+cT9pTO+2b+gxIPJ
MvQqUZxgQz9lGBKc2TLI6vRV6++GzPA2qdWbM6J4LwAVjGosXgzh4nOGI9sbyW7M
hvymotO4BUXU9dO3n/1SRZnUsLVCUlySHPIzgcZi+oO/9eamTEM6y6eVgSGVWYc6
ZPbXsLWMfg4Hnk4ZSXCTljbk9xqGS8thsAlBZYikVyIfMFPkNE2q8Risd9udRjcC
ReAs6qhlukEuDj00n1qFmaBwL+2mg5ABqU4e2jBpVlSn7gSMeng=
=Mv85
-----END PGP SIGNATURE-----

--pGg8jbCKcuakLbRf--
