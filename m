Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83717BB5
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087155; cv=none; b=nn32OnrJanxwnpoE88y2EhmR1S+btU0X3xXZiBn080CFytRCqPn2koR856SetfCmYi/qnDp10FCGSSgbQxvet2TChlNNvYf1JYWPl+gCKSDmDvJDm9wxpCUlPRjwLZBvhY/vPuYui3KeB5U73T3F9e73eNnYxw3cKgHPljNkY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087155; c=relaxed/simple;
	bh=Uohrgi9WGeF6HLAX+6CdzAMQa1GHzxfAEZZ0tul1y+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NywcPOkSk2uEp0n7CQDT8S8VMKJrQIMngmEpPZzllb3d+S9hWWzVzJSBlqs60RAN5OTh6ANs3/40Uk4bsknauJQTScxmZTjhEZxF7EfTYLTTS9i1HLoq02cL6z2x78xpKN2/R4JFt9ovLlnrxHuFmbDbGRZ7nFjo9svNYtY4AUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G+F4I9op; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=plyxdfQT; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G+F4I9op";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="plyxdfQT"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id E32063200A4E;
	Wed, 24 Jan 2024 04:05:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Jan 2024 04:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706087152; x=1706173552; bh=PH2/GMTf9n
	4qfDYcyhVeUTXbSKiO31hkHmPvEHXfhns=; b=G+F4I9oprZ3tEQtBYaQFnNGqgO
	h+4DqkVIv8SKjT90QrB8LCAtU9JXn+noeVwdTAzixqoTdqDQR83+v2nWUh5dbKeD
	OCNnJSOTVn1v+mTnAso8VrrCIp3xxQgZq+yc3iuJdaEBLTyTGTmVSUKZobr++sWF
	IaDg+B2alA+kMjaI3AWrns8x1amWWeaf30IpnRiaEtUSHrOow26kZxZTURNa6o1v
	oRkUaNe3bHtQjGxqO31CWIoFO/sWcD5S7o9freAQAqhFXFOacBtyNe3ctb+R3eYn
	y8HJkNHuZw4wJmJzA+K6/jRjd/VvvHboakFNvk0ZCu2Jhgdjz5shnOP3VL9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706087152; x=1706173552; bh=PH2/GMTf9n4qfDYcyhVeUTXbSKiO
	31hkHmPvEHXfhns=; b=plyxdfQTsqS057zPJP4SweRd9l5FnEOyRWh4KGosNbUM
	c6MuTXMJt7IyzC/FxkfmGYeBZDijz2pxYhrzGwBr3xjY4RHjNCPaz3GNmxpzrxjh
	biLgv0oSo+6ThBjjaxRcP70TVFvjnaoKXGwRGuyRYJVGNGS1QqH77J7xh913h7WB
	f3wPSBxxsfOl/MEzDDyMfWcS6mD6p/Y7n+yb6SKN7198kofLwFBa9RP+6g3yJE5P
	UeGmdo0gUmDxKLyfq7kc4hM3Gsrg0DxggnkYkUjukJrWuy/p8OiUt9OBxEfGLcGL
	e4iJ3ss3gvWJijZBt39gHk69nUHCdZvpK2x2S39Qtg==
X-ME-Sender: <xms:7NKwZVuGLpaJuNbEwscjEb65WqkzdAVDVQGZIWlOTcTp-Q9h1r6A6Q>
    <xme:7NKwZecSX8wMja3JjFBLYhQHYXCOj45j2ZzkscgMmTqUoz9esQNct-5c5KwT6YpDz
    m6hIPatHJ33RidmTg>
X-ME-Received: <xmr:7NKwZYzuyiVc3vOyp82aclBneGuCVkZkqaFrRx0q0Al0H2mOkKoXwQky5l6s26LSED8xDn9-4lJS3akenbk1fK9D2vO2Zlp5mrgKVGrsC5WhzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:7NKwZcPFrP9Hyv4y9Bzso1fSFSQ5CaICq4zm_QCQDd5OFxLahHUyfA>
    <xmx:7NKwZV8qRbxcODcqKWepeOfl8szIRaxEoG_omDRiPy9orkaaGAPgeQ>
    <xmx:7NKwZcUA_z_-fzU4nkpJfeRlc7kuEJNUupbw5e_toFs-_SYuya7rgw>
    <xmx:8NKwZSHR2n-X2k-wOGUGwJDuJ7AV8ZPIoKX5i-W3U9BI7fDEs8d5fA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 04:05:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64a9b6f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 09:02:40 +0000 (UTC)
Date: Wed, 24 Jan 2024 10:05:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] Documentation: add "special refs" to the glossary
Message-ID: <ZbDS6B5mjLeQ8pIy@tanuki>
References: <cover.1705659748.git.ps@pks.im>
 <2a0943a78d0db0f489962520536594845970e0b0.1705659748.git.ps@pks.im>
 <4f60dd83-913d-4c66-989d-282ec1845f4b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9GD7XM4s5Vx7ql5D"
Content-Disposition: inline
In-Reply-To: <4f60dd83-913d-4c66-989d-282ec1845f4b@gmail.com>


--9GD7XM4s5Vx7ql5D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 04:27:20PM +0000, Phillip Wood wrote:
> Hi Patrick
>=20
> On 19/01/2024 10:40, Patrick Steinhardt wrote:
> > Add the "special refs" term to our glossary.
>=20
> Related to this the glossary entry for pseudorefs says
>=20
>         Pseudorefs are a class of files under `$GIT_DIR` which behave
>         like refs for the purposes of rev-parse, but which are treated
>         specially by git.  Pseudorefs both have names that are all-caps,
>         and always start with a line consisting of a
>         <<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
>         pseudoref, because it is sometimes a symbolic ref.  They might
>         optionally contain some additional data.  `MERGE_HEAD` and
>         `CHERRY_PICK_HEAD` are examples.  Unlike
>         <<def_per_worktree_ref,per-worktree refs>>, these files cannot
>         be symbolic refs, and never have reflogs.  They also cannot be
>         updated through the normal ref update machinery.  Instead,
>         they are updated by directly writing to the files.  However,
>         they can be read as if they were refs, so `git rev-parse
>         MERGE_HEAD` will work.
>=20
> which is very file-centric. We should probably update that as we're moving
> away from filesystem access except for special refs.

Good point indeed, thanks for the hint! Will update in a future patch
series.

Patrick

--9GD7XM4s5Vx7ql5D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWw0ucACgkQVbJhu7ck
PpQnkhAArlR05WOq+JlJCVJ0GVu40pXVLORKwF7jDC1SfYLtSADUvmF64RRZUnHJ
c8spmunrOgpMcBoLkM2ZWCacn0NN5VlpjSRGXARRLDcw2vF/QEUZt22Jv10GpC5f
LuQUjAO0o2r05AOuQp7bZ1ggMgmvfOdWUtqPq6UpOthxW/z0mCw5M1lgcLWcL+HX
384/nDENXSGE6Szy4M9kXk2XIKMr0i11F3yl/T6Msauptax/y+l+DqMYYlEPHDPG
BIAUEolQgCgMIrqwuiW5Dcfy6QjJle5PDOptPvBEdtAYouHT1eySOVQfFKXskgCu
kOKrjLTO3Hhn/Zy2xkjLiupjqoGztZy9C6ruhpaEpJ7OqwR1n0hdJX6UI78+Wwyp
W8AOrLGip0vHL0Gm2kb6thcKL5ZAycWCqbsS1etXi2PJKW3eRz6Yojfmz3mnGM6e
Y1olGLMbhyu7KIt8xOdbVxBE9jD95ZyvJGUJey50+qLGzHH57h0YPSD2XYrOsh1J
h0UvadFctuUqAl8wL1D2ivAOjMA4BblSZla23Tvc5XsailMHDXqNioE6Te0d7daK
L7+V10uaG6xg4RaPT7hEPkRVlzNUH0ZDh/bjH8yoNdxGkPiNo2bu+egCqqQ9UMRm
9BTJf0qjFkE5MpJIMDmkxnHijkoU3OyB0WdlJseXfsawLZBmh6w=
=gDna
-----END PGP SIGNATURE-----

--9GD7XM4s5Vx7ql5D--
