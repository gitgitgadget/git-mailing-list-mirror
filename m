Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C454FB5
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177865; cv=none; b=KCSB6/NlFUiAegdzltyZGflADNg7sxtBhU5y5+FC1nJT0a2NxahM0dSqFabFryXEbevP8cH49RFpxlyOsuWdyK/qWIt0cu+Nvz33Us/oGFptUJqLN+BLJTC1nQE/84QDWiFJMrBDGE0JSgz3qJjr8HhXpSWX2QSpKPYvJx6rEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177865; c=relaxed/simple;
	bh=zcUk8UC8s+gL/pUkq1P239pDGymqRJh7CfHqjg3YvDA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn+2kijUHi/g95cd6jwsVRihfP011xDVR0K3I9UPvGySClun+WfyAOPoFafYpfNjbknoWzMtAxX7EQnfSvOUpHO3JZEv3bcj77L2/ufQr7jfzDgPU48QMdw8Y+1ccdu3CXYxD5DIiG1uwkWTsOI5EtiMOPrETrrn+7NWaclXTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VMoTjXfS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HyXyqDN3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VMoTjXfS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HyXyqDN3"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 786551380159;
	Wed, 12 Jun 2024 03:37:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 12 Jun 2024 03:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718177862; x=1718264262; bh=bzeEmGPHYW
	+ywr31aofaAkK036qQz/2AyA9oLbEYTag=; b=VMoTjXfSKHIkYdcdhYQnCxtf4p
	v0qrV8cepvXvceYaL+ktErsY0SXzln3fw3Hsaz1GuRDTv8dQiCOt0J8DUdrYjFSQ
	rf8HIFzq6YmvOwGnzbu43lvAn006RBSB5CMNSVLa/idmFQCMhQXtV1iTJZpmTKjw
	YEkD3HueqIirhmt5qcOJ4jMNLcrRdbIaPTmO/16UBseLuJnNhh9P4N224LBZ+r47
	pp5fbDKXiu7P7ZSsUm4MAPs1jFA3YWTeuoPisHe8ft2NQJCsYLRD3Ru6xmkqWc4u
	pWfukKakZooC1pCB+3YtJ+wXYH33wXFQbBsuJEKuwomRgUXhPCvrk2JryC+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718177862; x=1718264262; bh=bzeEmGPHYW+ywr31aofaAkK036qQ
	z/2AyA9oLbEYTag=; b=HyXyqDN3WsBuBZ0aL8uXf7uu9LYhgk576hUgI77J99Qw
	KCB3aJPunM3QsuUhsrFQfEAdkFAHIEO3nRzhK6eHltN98rq5BK7v2uT9xkQQfAp5
	wI/npI16URFseQmt9uLw8kvRNX8Y9Mv4my+rwZT+f3t2DRm5r81LeF5FnzFC+VPc
	2DQ63D5e8NvI5+mjj7NtmPrapKbJNB/yUZsgmXYb8Ws9dFR3JBMvp5Q2rJHbai8H
	MoGQY1qXqkKy3uhmu5sKNP93peIDo7snCQr3mr/64vNf7BVqE7khwFygZyjxZBOo
	GagXnFHIpPSeDDby0J30pOc1gdHxYEN5skp8NR7BnQ==
X-ME-Sender: <xms:RlBpZvRfcjYJ1ofQ8cBrroO-p2I3jrsEtwmRayeFn1JkhyW4G1C7Xw>
    <xme:RlBpZgwvzkWJOi5K6YAWSO1UrGDnFLcqf9DavgCPXsSkvg2qV0v4Q3QdQDuUtLGhu
    yOQuEz-eUBmi5qsvw>
X-ME-Received: <xmr:RlBpZk0of7UkNF-2KZ5c0Zm1-BKzmsNj5_pbbPp4ks532SABPcGfTj90L-nfdz5fa7dfBCZCRgUAUJsL-xzAR0n4UKfSkRi2jlFLWcC92PUFkbGuoDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:RlBpZvDCOLctZePL-uAYXdvxpHkdmsZugvnQjJGWyQr5pFtFArEDDA>
    <xmx:RlBpZohk0hMkJ5KRKghmxR_Y7eBozgn7A0Og-peApO91eMaEdR4i5Q>
    <xmx:RlBpZjqaLZXahpqGRwFCtRRuPT6jMxbrariUtvYeLIIkJ_3aw2zclA>
    <xmx:RlBpZjhYEGkf0zuwlllZBXtE1EL2SFl-QZ0EL_KUHgIBeFWVzx6QUw>
    <xmx:RlBpZrt6Avddoq1lE3Y4GgF3L0QHqVXqM89hI2gET7FKJbN6MBGknaQu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 03:37:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8142d6bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 07:37:28 +0000 (UTC)
Date: Wed, 12 Jun 2024 09:37:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 00/21] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
Message-ID: <ZmlQQadfFyCHo_k1@tanuki>
References: <cover.1718106284.git.ps@pks.im>
 <ZmjcrqnDnHAZjr6V@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+XC4035BtXa+jZTd"
Content-Disposition: inline
In-Reply-To: <ZmjcrqnDnHAZjr6V@tapette.crustytoothpaste.net>


--+XC4035BtXa+jZTd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:24:30PM +0000, brian m. carlson wrote:
> On 2024-06-11 at 11:57:33, Patrick Steinhardt wrote:
> > Hi,
> >=20
> > use of the `the_repository` variable is nowadays considered to be
> > deprecated, and over time we want to convert our codebase to stop using
> > it in favor of explicitly passing down the repository to functions via
> > parameters. This effort faces some important problems though.
> >=20
> >   - It is hard to prove that a certain code unit does not use
> >     `the_repository` anymore when sending patch series. The reviewer has
> >     no way to verify that it's not used anymore without reading through
> >     the code itself.
> >=20
> >   - It is easy to sneak in new usages of `the_repository` by accident
> >     into a code unit that is already `the_repository`-clean.
> >=20
> >   - There are many functions which implicitly use `the_repository`,
> >     which is really hard to spot.
> >=20
> > This patch series aims to address those problems by introducing a new
> > `USE_THE_REPOSITORY_VARIABLE` macro. When unset, then the declarations
> > of `the_repository`, `the_hash_algo` and some functions that implicitly
> > depend on them will be hidden away. This makes it trivial to demonstrate
> > that a code unit is `the_repository`-free by removing the definition of
> > any such macro.
>=20
> Overall, I left a few comments, but I think this definitely moves us in
> the right direction and I'm glad to see it.  This obviously improves the
> experience with libification and unit testing in a lot of ways, which is
> good.
>=20
> My only caution is that using the *_any functions will cause us a world
> of pain if we ever adopt another 256-bit hash function, since it will be
> ambiguous which algorithm is to be used.  That's why, traditionally, we
> haven't assumed a hash algorithm based on the object ID length.  I don't
> think the amount of uses we have is excessive, even with your changes,
> but we'll need to be mindful of that going forward.

The only cases where I add new calls to `_any()` are in test helpers:

  - "t/helper/test-oidtree.c". This one is getting converted to a unit
    test by Ghanshyam, so I'll leave it to him to improve this.

  - "t/helper/test-proc-receive.c". Here we don't care about the actual
    algorithm, the only thing we care about is that we can correctly
    parse them and then eventually emit them via `oid_to_hex()` again.
    So even if we introduce a second hash function with the same length
    this code would continue to work alright.

So I think it should be fine in the context of this series. But the
remark is certainly valid and something we should be cautious about
going forward.

Thanks!

Patrick

--+XC4035BtXa+jZTd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpUEAACgkQVbJhu7ck
PpQ0ZxAAm6/dPHP/l17mPuYjOwL8db97HtjaINHvKuz4i5hee6WMZephdwdz1qi3
gHp8ygPG/XpWEQOX6+pYlRblFKw4CZXEsnz4KbGEuVCK1LSrexj8m64/EibCBBsc
0ftJYA2XSN3v4u9/2vsC/dmUjuSqr4eE7y+1Jr7bl1ZmVIepLrde5VHUeRHu4n9m
V/UXs/B5kCq4qF4fF53/Fb4XsNkK3T1GYFAzAqj4cw3U42AVhkZXdlSkYA09cdk4
i+I93g7b66TEA3XW3/XPoilTHk9Xy8XXHdzUPmdyHYa+54Qh/4tgewqido4GTWvp
VKpCW6HIypfVa266nyVs2xdzwWHjp5/hKoEBBguFwstdwWmneMkfVx7+QpAMCQkz
SjZNFboKOGWG+aLGttSBf+BHbwWcol27TpCWUgdf6p43aKPXeCT9aXOhIydCBUaf
gRe7c97Y+s2sue8ml6HPBmIBTQLVoIOpjHRioCmnzRZh0Ypt0F5SvI7UQrIrmJHq
yD2sRhwesY7gCwXWmXFQ1Czv9DdBInHXsaxwRY9AQrQy2Tv1RrAjrBv9D31DLW42
SyHgTlT/PDqj/GEFdNnCjLrPwBI1TrS7F4pGtmOqf7Y1z9NAdrugxluJ3jTYXze/
7+5l6fb9waO19PDW9ewyg8E2mnzcRHdmrx01HiUtqj6Ke0GxThE=
=RhPI
-----END PGP SIGNATURE-----

--+XC4035BtXa+jZTd--
