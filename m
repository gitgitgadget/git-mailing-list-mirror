Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F861FD9
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877899; cv=none; b=LjSZehifZkjwSpdXJ5oQT2yN/DCwVkRoN6b662UKcpXm17Zbf8oe8peq/U+NRma/m8kTjajRNdFXjctcHY5KtLVl6wGXXh+zOMI1VHJXqw2v5a9R9rLePgBP5OJpvwYOpX2ge0JoF2dX0JMyXQ72l0WN68HARHNMjZ1gy+MKZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877899; c=relaxed/simple;
	bh=tIKKfkl+zVN5uIyHdHz/LW1ix6M2nEQ/QvFCB1G0wfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5AfnRY6A1tlKnG7iD1hGGwwdqg5cr2XHKbpXiEwFPI+i0g8seV+TfSBRxw0RoloLquRWltNakrn/a/0Uas37h4jxRgOumkJRjZO1q7RNRnvMZ8TH++naBuznh2vl1qeKIcGgiT/Mos/srNIpNKK5lO8G+3+M3eLPs5RW77KjeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MiYswOB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CNlgf+lY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MiYswOB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CNlgf+lY"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6D2A21140081;
	Tue, 28 May 2024 02:31:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 28 May 2024 02:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877897; x=1716964297; bh=TQx252N5ml
	VC7UBBN6DGXps2ibKc8Pw1jQNc8MBnZGU=; b=MiYswOB8eL5CQrLi6jKy65MgzT
	mRT63zj5os0c6mDto6bbr1EXFyhTQbO2TeHTpf+Oluxl/T3dAZQZpdhflO1Apth/
	88yMne1Eg7DV5xhzenOlSdp1YWYW7iulzexJ8h3cumCakY9N2Qt6ovW3S8TSRKJC
	InHKPS7XFUDel2NE+cNfegpRp2P9pROnk+0EBgij0BlANoAuPhapAmRaQt2CMSew
	iE6P2CzSFeab85KJsesEW6XMwr70ewoXy7j9wLXoIKcKUzMy3fYcydkK7H7NoQB6
	AtgXCP4w37NIThFsvRZ8UClsufGu2NO74wcm/qT9w4ezh8ZVBM4VFzGfRW5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877897; x=1716964297; bh=TQx252N5mlVC7UBBN6DGXps2ibKc
	8Pw1jQNc8MBnZGU=; b=CNlgf+lYZtV6f9TucYDRDehJtFOFFrtLXmna5dJFr2Pn
	MWgAQcvDDDnYD7XXlOGob+QkaNJgR7RLDGXquYhrRfHZNzp605WQeDc55jQPrQLG
	p+t2y5du2R5HmexnCSvvF4jS1L+9yQT7Xg6BfLchXKpwbUh1zFiKb+Sjf1SnLKyB
	mhSS878gxGvjyjFyTtRkmHTqgURVMK7vmPmfd2B/XTG2jO42nQofC3Rd8AbI5Rc/
	YhVkowCwhZTHEpzZUXTEJu77KFzR1+i7Uyjy628Z7dVd22KkK5Q6YixQNYnYKhVH
	TiY3VYymYxYMxJTcbD8rT1SGOezWHNGtlaVLIpkUKg==
X-ME-Sender: <xms:SXpVZr4OI4HzNifv4PFawuGBvpiaZ59psc-EP0W7P704n6kE2zEB-A>
    <xme:SXpVZg4XSh7bE4l9aw3x6gYsTe-yuWxQiIlUYCNOygsX_Mh78WBpFBsp1YGoqtQj3
    b_IPumHtIqchgCXJw>
X-ME-Received: <xmr:SXpVZie9itLZ198r-nYMZn2C3ylQZwq-4dgCz-Vvj0pAfKHu6b6Uj-D1bbqQkttdtMRmJgajFkfE83BOirJLWqZ9sRAczO2zIYarWAAr_8YP5XmZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:SXpVZsL_2sGA1wO3M6q-WhXkreT7NbjM1Uhs3iGJe9qDqubWfhId5w>
    <xmx:SXpVZvL1IotfLsrzh_bz8fwXKAZPzNsP8vTzeAkzAte3xMXfRzwWMw>
    <xmx:SXpVZlzA2L7QqMSiZe3pwlSq46AloRnpsPqMlAvpIvZ_ETcU7svkJQ>
    <xmx:SXpVZrIgio6ogyQUc3QsGVU84JAZOfnDAMw-ByTpvTL6a_xTpmHXvQ>
    <xmx:SXpVZlgFwGYrqZDaY1p4ANTLouGjXE27NksRGrtHM-F-prH9haRA55Y1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:31:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 200c9986 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:24 +0000 (UTC)
Date: Tue, 28 May 2024 08:31:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 05/12] refs/files: refactor
 `add_pseudoref_and_head_entries()`
Message-ID: <7f9ce5af2eb316477160224aa087ba6290cad672.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cT/w9gkarERo5Ohm"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--cT/w9gkarERo5Ohm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `add_pseudoref_and_head_entries()` function accepts both the ref
store as well as a directory name as input. This is unnecessary though
as the ref store already uniquely identifies the root directory of the
ref store anyway.

Furthermore, the function is misnamed now that we have clarified the
meaning of pseudorefs as it doesn't add pseudorefs, but root refs.
Rename it accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bd0d63bcba..b4e5437ffe 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -324,16 +324,14 @@ static void loose_fill_ref_dir(struct ref_store *ref_=
store,
 }
=20
 /*
- * Add pseudorefs to the ref dir by parsing the directory for any files
- * which follow the pseudoref syntax.
+ * Add root refs to the ref dir by parsing the directory for any files whi=
ch
+ * follow the root ref syntax.
  */
-static void add_pseudoref_and_head_entries(struct ref_store *ref_store,
-					 struct ref_dir *dir,
-					 const char *dirname)
+static void add_root_refs(struct files_ref_store *refs,
+			  struct ref_dir *dir)
 {
-	struct files_ref_store *refs =3D
-		files_downcast(ref_store, REF_STORE_READ, "fill_ref_dir");
 	struct strbuf path =3D STRBUF_INIT, refname =3D STRBUF_INIT;
+	const char *dirname =3D refs->loose->root->name;
 	struct dirent *de;
 	size_t dirnamelen;
 	DIR *d;
@@ -388,8 +386,7 @@ static struct ref_cache *get_loose_ref_cache(struct fil=
es_ref_store *refs,
 		dir =3D get_ref_dir(refs->loose->root);
=20
 		if (flags & DO_FOR_EACH_INCLUDE_ROOT_REFS)
-			add_pseudoref_and_head_entries(dir->cache->ref_store, dir,
-						       refs->loose->root->name);
+			add_root_refs(refs, dir);
=20
 		/*
 		 * Add an incomplete entry for "refs/" (to be filled
--=20
2.45.1.246.gb9cfe4845c.dirty


--cT/w9gkarERo5Ohm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVekUACgkQVbJhu7ck
PpRf0A/4hjoKh03qlGxL6n5xk0rv8CrdUfCItsRSRfYd1rqEyf71Hg2NA6hzIv4y
7TeTVdhWv7v74bnO7NFJ7o0W3ghz2cRpbRFfl1CufLTrgcSyDDww4wNRbU8QxHgZ
/DLvht+bdYYQpnxP3rbrl+Gc8PLxvbE7RYvUFKQk7I8ZbLEQkcLycnrNblvGWLXU
VEC/oH/QZs19FQxqk/2gVqsgsAOTah2PKC1n8tccIQScDJiVHZCpPB6sKVcmgZQo
HMDYFOysDkUotZ7cWW8hplljbG43xGJZ9C/vMVklRJRn28rixxfF1yDfUzZshoRg
Z4cX7qzn4Z3+HDCBRF4WoFpGf3tPU9BM1sUKHt7lz0bK9w9DCWp34wzAWghgqEKk
evzEm0PprzfmtzF8nYhmGsLJSZDaJSSX/HYhzg9r6MeXCBrFtF+9eYR7Ybo7QaNK
DHVgjkGilzh5Ixaj/boEzeKVUcoq9G8tQ8XkKxI7YgTo1V2ACZipAJ6uz3kRjxb3
/g3bNOiaIs7NDnIBzHjc/IpTng5jedjg0De+TQHftKXZ0Exr7+BSMkPqOm3ISn8Q
ejk+pRoUo5kxrSdPNZKKP3ZOUfGrhfvq7vOEPDr2VWw5BJ0LNeJSHV9jjM7AXjSZ
c/dJJqpaN3EMkGZQphIW0t1+8bdhasnz13LX0+GiW27WTWQ1HA==
=R/+G
-----END PGP SIGNATURE-----

--cT/w9gkarERo5Ohm--
