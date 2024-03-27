Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33BB250E0
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526571; cv=none; b=ShQHb6FUfvZf9zC4/DMV42nhugz/0WV4Hqowok+obPmN9hEOPM016akURn8u7/A/emoTQu4WXKUPknuMJVNAPr4JM2axl5tyhe8uUzZnxMhB26iouTi7TNPpQEM87ekKMWJvORISmE5ukHIpC2FBAtdWNxGPk1RVgZxhCHhOD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526571; c=relaxed/simple;
	bh=/wyEJ58iPDxlpuFe33Meopf81UiqAib1r0WtEl2Cjt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTTDbb+gB5/F0QWnR7ZM9cGvmRcVggzkmxdcgvU3F+rAjGbpfZrjOi4VYU0HSx/SbNCgRWXE/UW7a6nKHIe64xnLPLgElLtZX0LGv1szmVkpjFNhfiRUmSr4aPMgLSgWfeycCqGtgGZenc2VUGs30evxkMHX2nkbYxoRC+mlQ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YN1VcP1g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZoVo4PA/; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YN1VcP1g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZoVo4PA/"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9F9065C0040;
	Wed, 27 Mar 2024 04:02:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 04:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711526568; x=1711612968; bh=Mw+g8ciZUW
	Kr0DsfWzr2vPmdL0IFvwuP/zqnDWc2ujk=; b=YN1VcP1gtjOFeIQTD8bRjLNQMx
	nCyo9Tbdz7ZJYU/adByQ7PgJdi9M0aK1QUhKMusWmcCY2yQTVP+i4Awq/1cImEct
	TfaMBoCg4xm34727LyA37k+5/APRt2Ng6idZ60Ytsx720g4Yhv7ZcKbClPdFB6ll
	BfiIflQqFup0lId0rI1knHsM7QmkE0ahT2vXsfXdBt79lIqBLEVpXKJ0/5Ml8fez
	gc0HyAhELL5baaVPKv5xoA1WGdgDWDBzVCK3h8Tr6Ol0oducWv/c+wMgZRgpTGrm
	IpRRbQk9WC46zrJ0rOzhOOCeh0/8BmqUicuF4zPj0Da8SFTnHOvD2i2A7VPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711526568; x=1711612968; bh=Mw+g8ciZUWKr0DsfWzr2vPmdL0IF
	vwuP/zqnDWc2ujk=; b=ZoVo4PA/UXlE1k9dF6LGjG+AfL3fTWoWQSv903fTWAJq
	QEkjnUSmjo39GaIEjyrsEv5PE7tPaNFbI80RLlnKfN4OrRODNkGgGjdcYcZJ9ur9
	iJaTdDXpHGCGmlRNv5a9j0HAp8EkZX7J4QO6GSOg8RkSwijB6TtGFNnzweEArxsc
	TtnaHl5b0/qB5T2rH5B2AIxEO0ZP+vfU33Is95Qj68quY3BV7uz2Lg3OX+d58/gD
	yj3HYiICkv0np5p4B9p/aJH5HWI/X7Alib5Jy3oD+gWgFzLv9tDDxF6NF0bP5/S9
	XWvt2HWt2cvLLE4mC2X3noPvCSxgl67sZp1kPmkGsQ==
X-ME-Sender: <xms:qNIDZvkt2kHx7VwFi6n-HFm2gi-UfMa_L8QQcS4H70EqDmgcWqbHaw>
    <xme:qNIDZi1ltaZ-jgItIjX_ZUEpYPxqL5RUdAXwtckfu4B5dIblRUkL5EdJetlBHiA-X
    XQ23nCfiuwCs-llIg>
X-ME-Received: <xmr:qNIDZlra_jZZgJyWPm3TLDVNbvzYyINgFlRQJQywGosddK_1g4VaTw-OVr4NpUgRLqD12wg6h0a6BIU2Mr93tInNpjkMSrZ7SCUI1HjZDcoOJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:qNIDZnlAi_4RzQoZtam59sYyHdZCjIEmW1-xwrbk-0OaSPYnJG7JEg>
    <xmx:qNIDZt3tBhe6bAhBUf9FH6qWRq00gZVW6LcpfKYPByIQkcpD5sb1hA>
    <xmx:qNIDZmtxSnbcb6BRbIlE8_a3qhGeMX4E6PjKTZTOuKpGmflwzyVFpg>
    <xmx:qNIDZhX-2Qrb0AVitbMLDc5iRDfIh-SwYa2iv2O5cCBhNZePJW_gUQ>
    <xmx:qNIDZl8YGWniR13bc3WORCNLqlx6DdQV4bdUw2UW3exuw9Kfq2kahQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:02:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f5d7aa58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:02:34 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:02:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 12/13] strvec: implement swapping two strvecs
Message-ID: <ZgPSpYVSSmQ9Muec@tanuki>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-13-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xavLmJhJAi1gpNKn"
Content-Disposition: inline
In-Reply-To: <20240324011301.1553072-13-sandals@crustytoothpaste.net>


--xavLmJhJAi1gpNKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 01:13:00AM +0000, brian m. carlson wrote:
> In a future commit, we'll want the ability to efficiently swap the
> contents of two strvec instances without needing to copy any data.
> Since a strvec is simply a pointer and two sizes, swapping them is as
> simply as copying the two pointers and sizes, so let's do that.
>=20
> We use a temporary here simply because C doesn't provide a standard
> swapping function, unlike C++ and Rust, but a good optimizing compiler
> will recognize this syntax and handle it appropriately using an
> optimization pass.
>=20
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  strvec.c | 7 +++++++
>  strvec.h | 5 +++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/strvec.c b/strvec.c
> index 178f4f3748..93006f1e63 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -106,3 +106,10 @@ const char **strvec_detach(struct strvec *array)
>  		return ret;
>  	}
>  }
> +
> +void strvec_swap(struct strvec *a, struct strvec *b)
> +{
> +	struct strvec t =3D *a;
> +	*a =3D *b;
> +	*b =3D t;
> +}

Isn't this equivalent to `SWAP(*a, *b)`?

Patrick

--xavLmJhJAi1gpNKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD0qUACgkQVbJhu7ck
PpQK1w//cpqEX/29A7NpfRqhdnLr+a73tnYJnL1vm+O7DqtMZ+6tkdYR0rEjLkAe
CNpMsCLH0MdkhW17Bt5/S+WCuwyEoW9T/KRinnWV35NEKHfejEACxWF+SUovx0gm
sGuCR0OumzcbbY4+6JhuI6vFKOPdqORDvN2I7q0HbH7KdcjScjRgUwMXoW4ek06F
9NPRCU4HmdWJaNDkL0c8kzxIv0DpArIryWxALOFKOKFD+UyUr4XFsisypU5+exyX
N7cZTBDnH58vYjaHLZ7ZhlZIfQjddKJqrN0x2RDcTMzqKIXXng5xL5M4MjZOTb1m
9hGVQ9nH6w8oxjW/+fHn05xD+h2RSiXOrld7dv/EDs26MGRAIg6c6JNFq5Z/C0Mw
qFyYATvZn69lj0rUuATfqqH0OQSrId64tIIUqUx+j7eomROQrpQOis96KCqk/E2Y
BPP3sqMZ6nnTatyhV7EYUWI8RW6h4/9+HfCWsxjU2M7Bo0op1beCU+86R7/Fl8Cm
L/7d5mQc/0qEJZKV8gavDez5o4cGUF1SLo/XGJAmSKPb7EhH2kE9VzE/uCS0UYZY
UvBpJ/6JZ1wPSweAEU3cnLupBnmAESoZhM0MpHWMSX1OYrzcTNHokhautOaCE9UX
5VtamcjsBne9NHrzRthNz2J+pulVNNEEUtiJqUPrmWZFILTBex0=
=G684
-----END PGP SIGNATURE-----

--xavLmJhJAi1gpNKn--
