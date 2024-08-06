Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C61BD508
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934793; cv=none; b=Bq8YIFJ5o7cku1IQ79n2Eq51rvP7Xol9td04aqPfdjJZjCTp2v2WghwyR1m6W+pytkfWpoooTKO1pO1KNA5nS5xN+ill3dRSaVrILfvBmJ8VXO66KKpGFLne3kciJG2VYL1JaZcbuxmQ+4PgeOBd/Kg5AIvFM85672Pt+cXdrdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934793; c=relaxed/simple;
	bh=9sqiCUGKL4fFhY9YtyG1+ukPoTUqyDC2a4zI3I3G6b8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/kdgZl5eoxnZWteIFcVK+3i2dcgrv1MTYSauhIIHszeNXGCu5an07hT1HFEeMrJVvtPOqjHTNBpHu8RPlpDLHfiWlSXHKUPYiLN0idqNb4xz+GjR5ySP3yOhWiUw4uD4wQxD573QEA/KV/hrDZnJ0s5UwnpemHskCxLp/4osA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NF+NsDYk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JesjnuRL; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NF+NsDYk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JesjnuRL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ECC141151B24
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 04:59:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Aug 2024 04:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934790; x=1723021190; bh=sEzBnOQkD1
	VBZQkPq+W7w7U4JSuW4yETUtc224/tFvI=; b=NF+NsDYk1PDtmuzvEOTHMJ7LtK
	NvGDqcZAnBdfMXJ4DdNsI2OqCdOKTUpoLgVOgQ+AjzjPYBxfFs5E5Y+7YCiPUqH5
	5Hyh6Nu2XGX9vz0jDUjIP8EoEBpb6QTDas4w4Q3O9pALR3vrC7iLEiVov9m9LdCr
	Ku0ieGILhcX9+r2KSus0JhTYKq+PaUK5BbMcLlOfKscS78NjMNJCYM3sKm9mhWPy
	EjP2Il7/ISI8FbljTkOBDs5a00dJKu7KItGL3KCh3N2Wa4tk50zru1C61kSLJQy/
	nLXDjufw9wmbAon0jrtZBd0MgVKec0HZeuzqzjPQjpIi3xVV2Itj4lPBcA2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934790; x=1723021190; bh=sEzBnOQkD1VBZQkPq+W7w7U4JSuW
	4yETUtc224/tFvI=; b=JesjnuRL3C52pOxuDDpvQABaAoFUTX0xH4T1tUTIvLvk
	QrM2jaP8dR4dvCr9Mq6x5eFM6lipRXUwXA+hTqWsmFUMWhWoUoFN0yWdTM0cpJYi
	CnDrk4rxHIhuD0qiVWM7G+8nFicSX/tO44uA231StDI/VHXwJbh79ftXyKqqwEwT
	2zYE4LISNuX3zRbRfWMfJpYDX0PUxf8rN1S4PCRBlIovd085IHoQAX3Sbnl5j6qI
	5agLns1S5f20UEHiAjjK5bTMFeJcoMvMYCbWAXtH0tR4mnf6fTRLO5c75uUtRDpJ
	FINJS37BV2dh6CaV9pUOkcrfoLTfeMoEmsGtBkEoNw==
X-ME-Sender: <xms:BuaxZmRn0XutpCVMkf9-owzIdVvgunT3TupF8WuSX8J9GO6xPIJlXA>
    <xme:BuaxZrz5MiucrdVDQnj6yxipxmyK1ZZrLtRwST5wtdGXsOfN8UEizlmsocNOUWVO6
    aQ3cnAntLuO-tc29Q>
X-ME-Received: <xmr:BuaxZj2Vw2lr3kWPqgSUCTHpz5cCUDAfTFucDbYhWyUW7PO7OUzJ-km9uXO1uGmAJj-5ihVVE2Jw_veAoaKiJSS8sM6BY4j2lmkg_XATvkul>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:BuaxZiDFen_WF010HgEqXcaZSHlhyIH-_7D2cf5neJVEsGkUTRwkLA>
    <xmx:BuaxZvhyJEqPxkuyANsTBuqShgWoU3-r4vSpNSL9ZjIG0w5Zcn9tpQ>
    <xmx:BuaxZupfVt4LJVOKcQoVsamd1-EmgU4bCKFB0Js5peIfuVTbmeRd6w>
    <xmx:BuaxZiikSA-dOnyLC7F3rPoSQHO3kIAfDRGX0VP0FneAgT0DCl4HQA>
    <xmx:BuaxZnZUOSgCrbpvQMJt1Do56oE6vM_GrN30HGimMg1d3ekCt3HkyUu_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 04:59:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a3ebe71e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 08:59:47 +0000 (UTC)
Date: Tue, 6 Aug 2024 10:59:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/22] object-file: fix memory leak when reading corrupted
 headers
Message-ID: <f7e67d02d29b3b5a087e1d69aa0ab1d7dd490f0a.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OdR/BZoholIFujQx"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--OdR/BZoholIFujQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reading corrupt object headers in `read_loose_object()`, then we
bail out immediately. This causes a memory leak though because we would
have already initialized the zstream in `unpack_loose_header()`, and it
is the callers responsibility to finish the zstream even on error. While
this feels weird, other callsites do it correctly already.

Fix this leak by ending the zstream even on errors. We may want to
revisit this interface in the future such that the callee handles this
for us already when there was an error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c   | 1 +
 t/t1450-fsck.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/object-file.c b/object-file.c
index 065103be3e..7c65c435cd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2954,6 +2954,7 @@ int read_loose_object(const char *path,
 	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
 				NULL) !=3D ULHR_OK) {
 		error(_("unable to unpack header of %s"), path);
+		git_inflate_end(&stream);
 		goto out;
 	}
=20
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8a456b1142..280cbf3e03 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -6,6 +6,7 @@ test_description=3D'git fsck random collection of tests
 * (main) A
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
--=20
2.46.0.dirty


--OdR/BZoholIFujQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5gMACgkQVbJhu7ck
PpSS9A/9HLXTCj+2cbiYdw7H536KSl/zh20ODQGn7YMlZJB0yNdi37nywOIgjmFj
lk2MnYCbGvFNP5m40AQowLEN2TkeiidVXRHlXHICfJFlrtPmwx/uP+bT03FPKVFO
oY29HXDTs95d8U8Qvcvf9xjpGgqZoqkrb7BpbsBqb0GaB9cIIIXB0XSNGaDLS7eb
ycHO1mDR1RMfw2J7kKjiD82KeHrAncsJScq1nraGII9Z5mcDzmhsg9qmgLy3+rDv
GcjF/QNeEe+tHJYps5ufw+vkEBdHisZceQfI4ICdV6/ytcui1o92x1bF/80gJfdE
FlibImo8AOQntEoewD0CcJcag+YL53pElBH4iwAa5YBFOc0ISVI8iOdB+6GhZI/n
nPk7M2MVdFhc9KV2vpTFtVsfSHuaYqCQPOE3LR6WRnHAfTKZtNzD8E/BH4ibPzDJ
6Aj2P14JC9WN9Glivhm8I/XKB8RqzL/UKRufoLwvoLzmUChhtIy1StD3QQ7ll2VY
44yuFF0ExHqPyINq9dLYd95fc41o5pkslyTEIlgSJw5yvSUj7vMQXWd4Nr6IB7+Y
CP77FiwiukFdc5u+0+pugPQTVyhOufW7Bgyi9ymorToUr+H0oA6Q/NyWrvUk7Yh6
d28BoiXUQLXsPafLvAAiCS656vt5h8jwV67vPR7n/XTesbWQnNQ=
=QDGn
-----END PGP SIGNATURE-----

--OdR/BZoholIFujQx--
