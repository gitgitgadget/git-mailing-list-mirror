Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C61BDAA7
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934874; cv=none; b=sQiOFC5BsPxdVULfihp4wWwuP+e9uezCwcmDdVO63OErSNBJGwBtl+5L4ABcf382YvJJXy6dxHrEvV2v+g3NA3GubLiLuzELVpKOsAVOWaWgpUXNmjGLFCZ66+RnStCnT5uIR1tjn2fBwVTvDdrAUr3we7CyCIPnFi0BpqI9LSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934874; c=relaxed/simple;
	bh=4H8UBhpOWSDL2aQdBLb0wXFW1TjrgUGOyFb6HYLr7y0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqjIWxU7WzahLNNrfcTuWPCQ2mnM3bOb/Qvjhm60mZa4KVQ346dj1Yn9vB+xHcyAKZppOyGovVHabynlMdm46JZaIxKlgJ7swVOa4VkNd1ky5iZzqiUBesHr2C+4Ggr+C9Uhbh5xI0mwKplTIpib32RHA3OgQiWC6Mx6KSyH+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=af7taoAL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PBDQXXCm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="af7taoAL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBDQXXCm"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 654771151B49
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:01:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Aug 2024 05:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934872; x=1723021272; bh=P62sWqzSl3
	z5Y5q2PlI3IcI4ailrNCxWax2ZR527ySY=; b=af7taoALPltDngEPM2pelSH8Oa
	2Js+G7wQrndPOmTcpSxLqGF9TpEAQHAYLVoSoCZhjGjiLfH6rL01Tj7BPlimUJOn
	oF0BRl6E7DQigAly0FXqY97G8wkn68jZV693v9SkdvMMTYcHfjy/kq+dZEYiPFet
	upZeBqvh+bx00hsgfGlzB2SvnnwinP305+PH8v8oYC9pURzoXob+6V7ThRwjcUEi
	K1DJpXmVLb1jFyXLn0vvBxoOx7kBisixYTUktLuufnMVqUs5BamKjo6zx2W/NOm+
	FxNZCpewvlplKGdjfDFII4PZHdyoNsXrozg80MO/TxUjKGPAgy5vd3+GQcnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934872; x=1723021272; bh=P62sWqzSl3z5Y5q2PlI3IcI4ailr
	NCxWax2ZR527ySY=; b=PBDQXXCmKa3PBpcP+Cv7Htk24nvu7pbdIQDprYpbA5uW
	LLx8wUupzLMMHGKAzQkcArkAh4a1xb5Vrr3h+FGd7UQc1dejLHouSoetA81HkEiu
	9ztz2nM6dMxJWE1KUUka5M02Cn+u1Qw9QC9bx4p8kJaLSbGY3qBWyazS3SUzxpQY
	jbuV2vNLkuqZUzs3V5RNMcvqPNWty2iYhqBGuzY3LNGwqfbmEYjv3/hV0hAZDVVV
	U4pofVEyTJ4yhP1cMJaBdI7+1ANTlQvw/RsN39fc3FzkCP6O9H2hHwAmO1k3WuAq
	hCVK1c/BKsxYQEIqPh3iCdgUSpzHFwff5m/2N5xg9A==
X-ME-Sender: <xms:WOaxZvIXfsLXMsfB3CNEHLqx4n-TPJA8L-8hJdCMMVVg5AzZttl-8g>
    <xme:WOaxZjK6QVC8V7wyyylvbIIUkf77MUJlGhC7dqEztSGM7TEfF13evTZs6oBwubMCy
    -5D-hLQIJb60cO8bA>
X-ME-Received: <xmr:WOaxZnuLvTLTJDD41t_HUCoj5iPYBOAQXt4Msy64T-wrOkGmAsq2OuK1qR_csaDlVBnvaKb_zobXVYGZCNJQPgy7Ee9goqKsrqX70r0T0vjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:WOaxZoZRTGpqXNQWzLLOtjEPn_FsXitJ2frUB6yLd0eGNfYNtjw8dQ>
    <xmx:WOaxZmbeiGsGmWKtVCb0zmFDLJp1Er0iQW1DFelXCGNzWnog_KeScQ>
    <xmx:WOaxZsDxBLwrGqBDApJv9zER5fCNwd4nGyq-TV9hRPXLRz270lOQpw>
    <xmx:WOaxZkYA604x_DEVNTZ5jKxt7a_-MqCI085ITHAZZMe3VrpQoIQhmQ>
    <xmx:WOaxZpzHLTh_Svn_QYRY8hqvPQnzPpQcWPNZNaoNEbGM7nvSvtKlJw1O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:01:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb9c8056 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:01:08 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:01:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/22] builtin/log: fix leak when showing converted blob
 contents
Message-ID: <f3882986a37c8f6b2f532c955bd5609842414e60.1722933643.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PxujXknaR2bn0aB/"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--PxujXknaR2bn0aB/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `show_blob_object()`, we proactively call `textconv_object()`. In
case we have a textconv driver for this blob we will end up showing the
converted contents, otherwise we'll show the un-converted contents of it
instead.

When the object has been converted we never free the buffer containing
the converted contents. Fix this to plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c            | 1 +
 t/t4030-diff-textconv.sh | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index ff997a0d0e..1a684b68f2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -707,6 +707,7 @@ static int show_blob_object(const struct object_id *oid=
, struct rev_info *rev, c
=20
 	write_or_die(1, buf, size);
 	object_context_release(&obj_context);
+	free(buf);
 	return 0;
 }
=20
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index a39a626664..29f6d610c2 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'diff.*.textconv tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 find_diff() {
--=20
2.46.0.dirty


--PxujXknaR2bn0aB/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5lQACgkQVbJhu7ck
PpR4PQ/+LghMN+pY8+wXSvm14YYKvfmMANm6Ja1nkJYldly5jOOmdvQlBIFKbaQr
x0wHEPen1oC3o0/kVDh2zXtEUPPHWMpG7605ky9SpGaucFf8n2n4Ml79yb2ZS9kI
gOvoWsgC4keV/3RCLQ/Iu5ma+z/qOKJjtKL2qQAz93cUg19171mGGBQqYbs0y3bH
hCJvUOfaViqYC0wGLWuDqYhRttHQH3zSaZWAQe4U4SjLug9U86ECiz8rrbox8wiG
1P6mq6SsyAkZKzY+08rwabQRxwuaoh7W7V4WNs7PMehwl8q94Siy2QYhzcgWNe6Q
xCoN3OrMbd57KJACHosy2b6hVc76agueU8pElYlY11zOBlgQpsKPx2GNZyGXr6fX
ApLnmVm6BSptO2yHjBgZ3JCaW6UFuvxVeQ2wzTEfJMymJYHao4Wg5eJo957dPMkm
9jbaNeUEOMF+i9QoZEdwLOcNTZS0Q5gtRZNrs4fKWpx+SjZwxD6j70RuPYRbNPxM
CqvaqMxIfKNgwfn3RxyZQHjlbYiop9cNCFhrZS/7baXaA+K2x19MjgUUgf4SsxuR
KGTILnzYw73Uv6IO+2Q8CQ1Gj8yAZSYRSL5J7w5MHUmUjJVYzfzt0mCKvu8rgbLh
QfG7zdHIpNUv6aDKw+J16q9ElB2+4hZAQPTE1VdhxRkKfFYp9XA=
=kNd1
-----END PGP SIGNATURE-----

--PxujXknaR2bn0aB/--
