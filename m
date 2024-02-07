Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811B200A5
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707291764; cv=none; b=pQcLTTJU24QqpJe374IGoYdQ519n7XeErXuUkTBWLRO1+JMpBsfZUobivAFEliWoit/FM2Y+1lYVrS0SwQKY4fRC2Gh6idN8ippbLC+meRJiuwRniLnf7lag/sfB6aQ2WJgOE/UPeRoiakGWghV797ND/OWTcS4msnxbvs69MNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707291764; c=relaxed/simple;
	bh=FqcdOsPm/UjA6MJzmZyjE9UB4IGbVpStmD1JBqWRy80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYOSzpjf1AYGiXux4hZ41YEtiKiYH2rHW4zT+6Eh9SSImJcx4Sa+d70gWofNiWtuOlKuIoBJGM2dOSO9FRANeK8OzZNmZsycJ3akgFGDpj8jKI/FYWlYmAS+D/WnYo4v2NR5DnK10WQUlVYDZx2GXtEDFqh1J+ELVxo/jbpeswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IaRRqCMU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dStj26LT; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IaRRqCMU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dStj26LT"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 8BFD65C012D;
	Wed,  7 Feb 2024 02:42:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 07 Feb 2024 02:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707291761; x=1707378161; bh=LijIN/dcFq
	AE1b72DvmRS7DVwcbZ5d1gxgHRNZr87QI=; b=IaRRqCMUEZ4Qj9XnUedhTgDX/4
	xHH+LDpdNxIwyynApiwOsTODT8L49I3o8Hk0B2na/TyvRLYrU0nrrRBxflclbrPE
	UmktrrImIo2ZLylDUI5tbmwdyMjzwzpqlh5GzNwQBj9OakHz/RdpL+OU6LgWFkrP
	9nPT+Iu1iu5JR25b7lwkNu9mUtchIX8n9AAsAtc1nGKp3rBgZHcWPalOd6xhpl+k
	wynsKU3H+lAf5vHU7d6bbvdOWtQcuah+rV08+Yq5QEJfnMDWauEcZCspO0+KqBrb
	mJzkpTlI/z6fSBM8dXWjLmPwl3/7dtRQvULKVGDC3RBI0b01IfpWHywItLmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707291761; x=1707378161; bh=LijIN/dcFqAE1b72DvmRS7DVwcbZ
	5d1gxgHRNZr87QI=; b=dStj26LTFUXsef3o00z1UR2y8c9JH7n0Cw7yfaF3zNFV
	OFrhgj+y3kpF2UV1wYLTvREdryaYhczurq7RUUmI8WZ06mvALIRav7Cbvb9o68Yv
	Rr5Bo0SUagbriouUyn/luxbFZP6TnIuyuSaD2Xj9Z4PB/PR5xfkX2TVjQGee2mcK
	P2cl4BW70iTXJcUdvAsOo/MsbMDkblNTEUXrgwUFA3cK/t7HOMfkItHTY8NJNrcb
	cRqhXQe+x0Ulw75+Ct00BptLFkP51wwjUFeWqDiPJx96yyjF+ysFVdOLRRm6/Pf1
	iMxChNJX3WHu4+lheiVtV4il0rtOxkPAaYbnpoA0QQ==
X-ME-Sender: <xms:cTTDZd89y3xWA82QhzWM8Ybi3z5aBV4fLUvpJhw2fgI6YSG8oaN8AQ>
    <xme:cTTDZRvOqW859PUJfyyCUoVTXmYXGIS6qizSEidMCMnJgigV5bh_WXIg9qsgzv6wM
    rHavmOrP_dKFGQSIA>
X-ME-Received: <xmr:cTTDZbBbvXwXrO9-YKPhmIV9q6ktvX83tRi5hVQpdZk6AqtgckyoMVZs2ur-w-ETE19lyp8rl8texi_NbQSLDuS7Oy-bHlXUH8a2RS3dKMPNcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:cTTDZReWI6i05lXRJgzjURjEAt01N7tG2r_rett9sMfALiBW0M1iPw>
    <xmx:cTTDZSNWdxtcLY4OLy3FQ1GIrFus-LWNI5ivuweFlsKukFCpJlQ6kQ>
    <xmx:cTTDZTm7XSza6fh16HxqnkICfnVUEn_A7UoJn1nQfhlnYi7zrmHmBQ>
    <xmx:cTTDZbbku5UKg9QTldbiQ5NjGNS5LxXHpxHTBrAzm-u5GJV8UJYuSQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 02:42:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 84d0a538 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Feb 2024 07:39:09 +0000 (UTC)
Date: Wed, 7 Feb 2024 08:42:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Always check `parse_tree*()`'s return value
Message-ID: <ZcM0blqMPppLn2oB@tanuki>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
 <93abd7000b81bbcd7f5422715b4bbb60c69a7cde.1707212981.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NlBOpg0vOzHoVYUQ"
Content-Disposition: inline
In-Reply-To: <93abd7000b81bbcd7f5422715b4bbb60c69a7cde.1707212981.git.gitgitgadget@gmail.com>


--NlBOpg0vOzHoVYUQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 09:49:41AM +0000, Johannes Schindelin via GitGitGad=
get wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
[snip]
> diff --git a/cache-tree.c b/cache-tree.c
> index 641427ed410..c6508b64a5c 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -779,8 +779,8 @@ static void prime_cache_tree_rec(struct repository *r,
>  			struct cache_tree_sub *sub;
>  			struct tree *subtree =3D lookup_tree(r, &entry.oid);
> =20
> -			if (!subtree->object.parsed)
> -				parse_tree(subtree);
> +			if (!subtree->object.parsed && parse_tree(subtree) < 0)
> +				exit(128);

It's somewhat weird that we have the `subtree->object.parsed` check in
the first place, because the first thing that `parse_tree_gently()` does
is to check that flag and immediately return when the tree is parsed
already. It's a preexisting issue though, so this is fine.

Patrick

--NlBOpg0vOzHoVYUQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXDNG0ACgkQVbJhu7ck
PpTQ1BAAg0EtZlYOAvQgvTXoTQp49SBwn9JdBXVm56eMdlffwYPcw3o+/9TvbyAU
PZuHXirkxMhcct7gHkqMc21OvrOxa9OZ2zo4Ag9oY0EqxsYTzDwKJoFucFwXo4zb
tYAeUcfPf0IPs/Nj+75CM4sW/x+ilRNuZ59H6hV3IOuSq9BJD3q8xnlufapYK9cb
zPn8cYqmQFfFPiL8HQUC1UIMjZXqDl4C9bC+H1JFP0qsuiFZF5TJUrjE9mbEM2g7
6d5mTqMuTAE1KoW1i57kYpdphpw4BU8Kx66gZvpeEWxVUYQ7j96zLvhcHmd+PAo0
hdme0j0TRgIOK7xIkhy6F4+5kAHioLl0a2kfIwWOUW3gCTakvk9VsySsT0s5/H4F
1Wc2C3mczidPpSZug9xXTj9yrEw+31zc0v05GRY2aPJfTbtToVG1oOg+bz8kOhLV
843SGNp8MyZT1Ga4GE7CcBPmq1nJKSFlS7FeHw3mBONttCfHh4c7/u1YWby2OHyg
iKd1zq78KVdwUfJvna8u1C+kMJB0DbY1KEtMVyEIJZKbG7tVqApc8fuIwyi6BoWO
0OR35get6y984DtIVL3icFCrv7Md5PuA8edzRacJT+ksu7hSxTdZseA9rYe2nAai
znDIHTMB0JiRRVSZytEwphiSHjn8EipQEKSbZcb1AIeiaPx0FEo=
=MNwc
-----END PGP SIGNATURE-----

--NlBOpg0vOzHoVYUQ--
