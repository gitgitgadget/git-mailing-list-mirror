Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA12C1A5
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812332; cv=none; b=cgDXPeIDipTYXvigwGYiEwuQpH4EJSqE1E6X0Sexlw+0JawyXWiQJvH3UdowknsNx3M+jt7clRXb5ByIdBRKBumBrUtvvV0AZlDf5IPsY0ONyouTjDouMvLYYlZ8heKAbmrHCnKyGfWdtgKZwi9Fwh3t4/jFIwuVD2B78iXA+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812332; c=relaxed/simple;
	bh=rLzqoGr+9bn9hl6mO116WbCPSYhSFjnnjMIIGmcgXtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzQSlUggETIxoaBrBBtd/gRZRJcRg3rrcMdtKZAovRqMZoT62BqsTRXMRn8OWbmcJFHj1LgkMrVsEegR76xhdXhgTz50RPrINXZ79ddPCzS5MtWdLgIzxI0yKTyN4GCVGqv7E8+MY6rahpLK97yLV8DfdXz6X1sR2OgUi+6oPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jlNIzhoC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WajimcnJ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jlNIzhoC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WajimcnJ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 941521380640;
	Wed, 24 Jul 2024 05:12:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 05:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721812329; x=1721898729; bh=T8sXQEfsfV
	zeA0tNa4gQAFWwrsk/eHwnjGPqur6gQYs=; b=jlNIzhoCRDiTaMz/23g7NZGgUg
	s1jrWJ6jQ/JHwOd++QNmTgMY53Svr8SENLk/YoL15Wg0nhzLR9i1QOXlVR8zJynS
	tMvzad5EIoc113yW2ipwW7+KZaAkqfEPiLzFrLIh2FgIN7ZVfdCsNRTjXMWdb2ZD
	ZjDDEAkhH7ChAxqST7QYbJGZTFeCE7V/MlX+S0fbb6PiSiJx9tXncNlw24McJhRI
	DTvnExLibY/CrXjLDvVV6P5873/mCSCOVSTNmahKto9BRkPzR2WGKCnwluLGnwha
	s8ZSmj+r4uGYVAxrN2SqF4pbGyG734ttCYp648Cl2h29SPcqxUfOZVgpuZ1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721812329; x=1721898729; bh=T8sXQEfsfVzeA0tNa4gQAFWwrsk/
	eHwnjGPqur6gQYs=; b=WajimcnJpVWEEp98MoQ5wY2EjLwqGh6oRPKq7N2MeLji
	CXb9j77D1f8KSCU0YxPpd2HvS27o9MtehOs/BBwCMPrFktp39xED+r9jZqvoPUpO
	T4hp73htgJmqyzdOFptCSVC0q1rWwa85KwSXmObV0VJ+qmAuQdPLVt4uFEEiE4Lz
	5iu8K3h6W6Ufwprzq39YIYzPdVmqKw29YWbG6jCxiR3zer4uvCL2Mp7ayv6epcye
	JVhuwyZYbOx9+TyR479yi6p6h+Zb4h1Vnjpr+YW0mv4kyeZqCW5tu01J7ILTafYo
	7BKEpMxipsgKv0mVvQNfQ/8Hb6IFWFhJdwLX2B8OxA==
X-ME-Sender: <xms:acWgZmx1bZw_vxJeVGiFgH0WenNXJ96zs0ZkLK1K-D00FobIiBhxSg>
    <xme:acWgZiQjoCFYOM-2No5Hfb3CiNad46ZoC9BGSz9-Bc0quh0gq2rb_VPZQzkFqlsg3
    XQrWyCut98zIgj5mw>
X-ME-Received: <xmr:acWgZoWmUcVAmDGxSzPhm6RdWSEJqEGXgkOC1pyeRx7tZu2VzfLiYxnTiabgHZFo-0mzMeQug-9ANFHPxqCmOfPv0rDgPd-FGcE7v9IsA6LGQhPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:acWgZsjQ3nx_LLzncaCNUlKJegyy1vknMBZoNMjgFIlhWa7u0tAz8g>
    <xmx:acWgZoBZFn_UUdMaXFGoO7XVk6SIMmQmHT_mXV9KT-AP8mMn2m5yPA>
    <xmx:acWgZtK30zNadYBhPY1wgGRrEicL5R9ZsEFoP4sjCB4508ho1wG3Kw>
    <xmx:acWgZvCBgUz45fW1g9BTC5aA8YKL4Uok0EUk-IpR7l7Of8lUoCcfOQ>
    <xmx:acWgZr9eB3lRgL7gGHDNkcjEASaoM86YrtGnuLgxm91OQyLhtcEVhllY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 05:12:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4bd0667e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 09:10:51 +0000 (UTC)
Date: Wed, 24 Jul 2024 11:12:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, chriscool@tuxfamily.org
Subject: Re: [PATCH v4 4/7] t-reftable-merged: improve the const-correctness
 of helper functions
Message-ID: <ZqDFZAWBlW39Q25T@tanuki>
References: <20240711040854.4602-1-chandrapratap3519@gmail.com>
 <20240712055041.6476-1-chandrapratap3519@gmail.com>
 <20240712055041.6476-5-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4KIgF1NtOS2/RLG3"
Content-Disposition: inline
In-Reply-To: <20240712055041.6476-5-chandrapratap3519@gmail.com>


--4KIgF1NtOS2/RLG3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 11:09:00AM +0530, Chandra Pratap wrote:
> In t-reftable-merged.c, a number of helper functions used by the
> tests can be re-defined with parameters made 'const' which makes
> it easier to understand if they're read-only or not. Re-define
> these functions along these lines.
>=20
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-merged.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-m=
erged.c
> index f4c14c5d47..ff2f448bb6 100644
> --- a/t/unit-tests/t-reftable-merged.c
> +++ b/t/unit-tests/t-reftable-merged.c
> @@ -15,7 +15,7 @@ license that can be found in the LICENSE file or at
>  #include "reftable/reftable-merged.h"
>  #include "reftable/reftable-writer.h"
> =20
> -static ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
> +static ssize_t strbuf_add_void(void *b, const void *data, const size_t s=
z)

It is quite uncustomary for the Git codebase to mark such plain values
as `const`. While there is value in marking pointers as constant such
that the caller knows that the data it points to won't get modified,
there isn't really any value in marking pass-by-value parameters.

As far as I can see all changes relate to pass-by-value parameters, so
I'd rather drop this patch.

Patrick

--4KIgF1NtOS2/RLG3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagxWMACgkQVbJhu7ck
PpQUbw/6AzHxFyi0QIRTLFq/yydFL0GfxJaVmiRXidr32NmgcZIzkNS2CtJGih8C
3UGG0S1wkILA06vsjcRGRm3kvYBcal/g93GJM3518MFIt6LyTpDEfN1gskpvryNg
whTmSElv8aI7aMI+oxhIw0mQvbFqYi6/T9oomIWHfszaFYe+n36CY9H7FLOTzNyn
ak/HYzRybtKec+rcnsSY+VK0PHzmdABDh/L5KFFouy3h9WvZI2iron2jWLs1zees
vYNT3s60BC5B+WL7Lxl6vgAtagh9Zu80/2ZC94rg2kVmpN+4mCUqTtEJ3MCGdgTC
kTDu6zqiov2iOWdjE+t9y2+MRyU6LfoTXHveyDxlEM42d5afvV8u5DkCA+92zQWZ
ylzBV/3oshD76tyJ/AIqmcGnxNrbdS5i1xTd8yUsPlWGl1gO4oWAePRIlY77sGVV
wla2aLusH+Cqb4ZcWHV1tvndeVMAzpsfMg4P0lD0wx19UTDmiKKOhBGHvWAz35fR
1u9VMjo3CGRtfCKNPXO/OS73+Re68CB5gb7nvfwmbT8x0d6gYn6Vex8D0RPzzcti
edMD/DUpBVnQpIWfD+C648LdkMnHKJd4MCxmRuqVRBTtQWbHipb39HPjdd05Nafs
N/ocpYi40l4E6ucwLZwnkSqIl6IMx4vq50xdwGKrAKNmH0QctpU=
=R+0h
-----END PGP SIGNATURE-----

--4KIgF1NtOS2/RLG3--
