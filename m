Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69130C2FC
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865705; cv=none; b=Rx6wTewzacf33eHyp9Uo6iAQVzAChelpcXHcrjkONSofp4V3ZmIVY2cVF9NU4sw6/NS24IPIwC35OKNiIV6V3Un8+nT/BvEf2nJtAR/v87U2VjrR4mKH0qR08t+SO4SCbKnWdUtlwEmP9pu+wLM67gmyKMSB6D8qHpct0NuXV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865705; c=relaxed/simple;
	bh=q0iH77iBlO9EgPgTtmsyP7NuxhQH6wd5xUy1y/bcLJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcOctjj84aa4zh7Zz3xgf0wdJox6Nw54J5H5bk+rQFuKMCYn7h1Rh/UJlXezKPm6M54qWh8OW5Yb2a3+bETtuPP9vi2JMTcc5Lhz4V+mmIIManDtDoBLNR3SgKCtN+YkrSo1ScjLhzqNdaKO6EedlG1S0/MMJYB8XxqtyzSYWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n31hGBwx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g+IEC0hI; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n31hGBwx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g+IEC0hI"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 79DE3138FC4C;
	Mon,  5 Aug 2024 09:48:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 09:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722865702; x=1722952102; bh=X22u/nBDyr
	qxH8Aq+CRLHP4KcdTlluTYEokdpI/kWSM=; b=n31hGBwxUlExDI+VkwcxiyCZaK
	FPFn5OTKTZpR28QGNuXA9z3E6AJ9GK74EMIxZ2S0LbjKRYuf5vkJiJQYA8mZl9qU
	aMMVNg8IduDP7j/1KodtIYmkjbYNIrR9nafaOLWq54JxCwaem2meX6w1qZT9wxcW
	aUWgZs6/MrH1GFcuAuJM2ztLuW6wXvqwKTK6baiCNdf99YkiPVW5cJxdvYaK3AnV
	DuVufbcMw6m0/uqx+cxh7E4BJ5LkjJyPpmeB7VvHm1j+xo2VjOHBe58k7Z/HCexx
	be8xjkXfnafAWuRtRJt4JOupTtcura/Y+imqud7gLWPzpWOKGkaYTnZ6KfSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722865702; x=1722952102; bh=X22u/nBDyrqxH8Aq+CRLHP4KcdTl
	luTYEokdpI/kWSM=; b=g+IEC0hI88lTaqaU/HqbimTkXm1d6xQyb5WpWvC255rS
	zuyTfmoJ6+9+NWFp3qZYRaj/Ob3PFxeFVScP63jmz1nTU8nTtKMJpgZJky//GSS/
	+AKmfhMURwChK1f507KJ9I7QhUDa2BRwNHJyzJixVewB8rlT3SDAWP04hHC4qIHw
	1q4iSnFKwhOBUjEGfC/r921VmVcyeyxHeMb7cCwhVNoaOP0ZfoJy79bKb93XzmEW
	rYTaQfby0SrCjeZ6C9EvJrK0kGTjr3Zghc3mwgAAWq3T9YO7K3WMK+Ch/vOKKzJ8
	1PAsr/tmqk6nM3HbZyi/XHqlbAOvmgJ4R9JDK7FI5w==
X-ME-Sender: <xms:JtiwZj8hmdc1Q4I8Ee7Cou5YQi5r4NazEwvWXCi_GrdedZOXKDLncA>
    <xme:JtiwZvvdG_C0jykBM7SMTXKxP7So_vah2amHmc8cGuouBgbyajviPYxuIYE2QmM9c
    rZTpC-Z_cXXli-f6g>
X-ME-Received: <xmr:JtiwZhBeEYpu8fBGGkIN6NqWofIkBtIZoTrUeGCE0vbzL3mqcxFs6oalX_Vahn7kFgGC608coecTkZFrYjW4rnxK5eCkYfWbbfNT_cItx2maBgRRIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfhffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:JtiwZvfYij_UzZsqPHV5IraT8JeJoQw1RbVTWns6dxW8qu1YVwxu4Q>
    <xmx:JtiwZoMPBD8d9FCYu4IIdEL5OIFm3LH9X3SDV7mPweKgfdUehg8pdA>
    <xmx:JtiwZhnpVOIIMDYBO4MTfjGjrtogHBFHs7Pq6iPk8dtn-zyfMTLArg>
    <xmx:JtiwZitHPavwP5TOAa6lPRJKEa7sTO5Bmj7HJPb57-7KaVDew98MIQ>
    <xmx:JtiwZn2oe3E6Qz7AQO1hUY3AjpuTlo4M0ZSMlqzBeCAQ12VnGiSOx4GT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:48:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7cf910d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 13:48:18 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:48:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
Message-ID: <ZrDYIFolRlERFdUT@tanuki>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-4-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FPM12b5i+LDOH4yH"
Content-Disposition: inline
In-Reply-To: <20240731134014.2299361-4-christian.couder@gmail.com>


--FPM12b5i+LDOH4yH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 03:40:13PM +0200, Christian Couder wrote:
> diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol=
-v2.txt
> index 414bc625d5..4d8d3839c4 100644
> --- a/Documentation/gitprotocol-v2.txt
> +++ b/Documentation/gitprotocol-v2.txt
> @@ -781,6 +781,43 @@ retrieving the header from a bundle at the indicated=
 URI, and thus
>  save themselves and the server(s) the request(s) needed to inspect the
>  headers of that bundle or bundles.
> =20
> +promisor-remote=3D<pr-infos>
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The server may advertise some promisor remotes it is using, if it's OK
> +for the server that a client uses them too. In this case <pr-infos>
> +should be of the form:
> +
> +	pr-infos =3D pr-info | pr-infos ";" pr-info
> +
> +	pr-info =3D "name=3D" pr-name | "name=3D" pr-name "," "url=3D" pr-url
> +
> +where `pr-name` is the name of a promisor remote, and `pr-url` the
> +urlencoded URL of that promisor remote.
> +
> +In this case a client wanting to use one or more promisor remotes the
> +server advertised should reply with "promisor-remote=3D<pr-names>" where
> +<pr-names> should be of the form:
> +
> +	pr-names =3D pr-name | pr-names ";" pr-name
> +
> +where `pr-name` is the name of a promisor remote the server
> +advertised.
> +
> +If the server prefers a client not to use any promisor remote the
> +server uses, or if the server doesn't use any promisor remote, it
> +should only advertise "promisor-remote" without any value or "=3D" sign
> +after it.
> +
> +In this case, or if the client doesn't want to use any promisor remote
> +the server advertised, the client should reply only "promisor-remote"
> +without any value or "=3D" sign after it.

Why does the client have to advertise anything if they don't want to use
any of the promisor remotes?

> +The "promisor.advertise" and "promisor.acceptFromServer" configuration
> +options can be used on the server and client side respectively to
> +control what they advertise or accept respectively. See the
> +documentation of these configuration options for more information.

One thing I'm not totally clear on is the consequence of this
capability. What is the expected consequence if the client accepts one
of the promisor remotes? What is the consequence if the client accepts
none?

In the former case I'd expect that the server is free to omit objects,
but that isn't made explicit anywhere, I think. Also, is there any
mechanism that tells the client exactly which objects have been omitted?
In the latter case I assume that the result will be a full clone, that
is the server fetched any objects it didn't have from the promisor?

Or does the server side continue to only honor whatever the client has
provided as object filters, but signals to the client that it shall
please contact somebody else when backfilling those promised objects?

Patrick

--FPM12b5i+LDOH4yH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaw2B8ACgkQVbJhu7ck
PpTyHA/+L/ufQUIzkfGHd+Y7J54pFMf7R6ul4R5SHgiULcCxVT05b0u0G9sFNaj/
XZQxaNQH8KlgRs8zWP3g5TIqimJ2QRnQFcLkVvWoTMaPjyhkWQAj76/VUWWZItYl
kg+tiKefA8DYA55UcfioE13EyrvU07n2i6KMJhyCgfV6Jb3SkfjkGfQk1umEihj9
7r+nzaxXkqtYQkj+kxrEudBBw5x7Yd0LrKvcQfGtmZdVCLjATX76OQg9b/atcZQv
/2PL0lUfdf1GE940uscQMuPlx8/UZttsMWBq5SvfnEJZAf7QT54HVjb7qeHt8KRZ
ADrUXtPvySlrhBKqjNttO+WS0Ugn2ueNeGDA1BednOiG+4Tmf8NkoJdh7xYRD05I
ci0zt/RRdTcA8ZalLHr10w6/qJiELRQ1u2sdlnqENu9+e2spw5u7bsuVTYUFwvys
V5EStAeM0foMjng0at1Mowr80NsTxnsgf9dDPWkVs88gzusDLYVO4BV0eAKgZdnq
+audRvVra65xAGIuTw7fz+ORrGdbn9fxFOxrac9K9ZhGTsjEN5fccR2TXBmuyR4W
D1KavwfmfDHboZGRldn/JVo7GW4O9lkzuLVlG6LxcodX/yDfmPzJiGk6XIC6tKVh
mm8K8JKf/ejRRhQXifClzugdjPiRrupHCzsWFYEKaFwjpFSTfdw=
=97P9
-----END PGP SIGNATURE-----

--FPM12b5i+LDOH4yH--
