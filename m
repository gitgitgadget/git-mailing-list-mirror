Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9940BF5
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110158; cv=none; b=erqSwyMfu73ZUbtR+Oxd1Dv6u2sN6y0iQAxyisptc8A/mOdL0/a4Swr0Trk9t3RU2PEKEh88KWD2EuY4ksk41KHG8x3XXrPDGFwSuSyiP08NyC7a8XRFJnaPZ1C6ni9ytXsX7KLZ4ZuA5fNKHUTz36v6ynsG7JQQwWQ8iPeiNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110158; c=relaxed/simple;
	bh=R4CkqGfM3uVLn/P5K39gjJ7SoIpQtvV1GgeWdSjzlTo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4gMkrKwtHiCyk9sj62nJ9ZksYv8r5FxJ9XgCPwbralBs3QULdT+UhIBNzHYA9qg1/cFtp0r2FTT03jcw791kQD6WAAfSdTYKfsRB11itw1NszFkE9kCKG3L2fx7UPANzB9I2jb/hEwT3Myk4oqTpC5q4Hw0lfYO97MgVnTHch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qb+D7Cuw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v6vJF0y0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qb+D7Cuw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v6vJF0y0"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7ECB3114013C
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 22 Mar 2024 08:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711110153; x=1711196553; bh=GjH2fo8ECo
	SfW8dEbznRXafQRWSFIQAL29EYm3QyQjY=; b=qb+D7CuweRfQkgeXVaJoq9VHmr
	wxy4+wuC2537WhN57U0qdSDC7XXkIBD2eHxr5lX41H/mUVaqdLiWvWKEuj6oIRXC
	w8cZDv3hlnWivnaB0NPS/Fhmnctdf7DVqjZUHvcASVk62hWUl7tO555MpCGJ2X6r
	dNSe9Sq5WsZhOSPwvQctE7VMEB3ynrV/y6i7+EvuFWpPt52crjj7SVbI4r0rK2Kl
	hFVbNFMqCqew3QpMRgnZRq1D1YJkkP2wTexVolfEpKh/NwsCtL8l0eQ93iw+WjjG
	Cuk9PEhLWR/ymA4tFKTuCBJxMmHy2b4bVSLgJSi4bBA4ZPmjuknmjDHUkYjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711110153; x=1711196553; bh=GjH2fo8ECoSfW8dEbznRXafQRWSF
	IQAL29EYm3QyQjY=; b=v6vJF0y0MHo0D0o+5Ms416vYETo6Z6+RNelU1QEY8mHY
	nCgncV0WhoG4xrNDfP0m/Yk8kgLSoCtxz3c7cQajgSbhIdT5RIEJdbJL6Om2hOLw
	ArqV1M0UsHAEuXt1gfq+JtMlvGdw0BxA9uezqUcKF+iJBURQ77zccaWRkkrN1i0z
	DTGQ7RnONGEE1xuiWhaZyXDFH1wAOSdo8K1s7TbtLdp8CUJk+FMpn17zMc5jZ7x/
	cEJbAgaNMZbQtELtKisfR/8tE9QNZsEOUh9lqCVnN42jxVLfZ5eXhZj8thHqjo8x
	9+zMgevzGsxVyEH0xuGN0ua4P05pXlU7XAn8XonrdA==
X-ME-Sender: <xms:CXj9ZaEqg2bQkrUli5BCLpC5Yi18HSBSJzaChwZvceLMIPOJ8fHGtA>
    <xme:CXj9ZbXoh7Bc8CXoLc3Qldkk6uNAxXbHzIYKk5h_6sGhOjpQp4Rrw_VA7hvi4CBi2
    GSAvGtVL9z9npVj4Q>
X-ME-Received: <xmr:CXj9ZUILLbn1Glj12mGK0Mv7ZCDOMD96FiBArCenVVet5qxnpfdH7MI9mqI9OJDrZwiHx_meWgTUQhNwCbSv6lxX2F1xea07AmBaizeP89o950fB9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CXj9ZUGDBjJHmd_I2VnOJHGFc4jLUPcr7ovcMdfPnRKXgDwlhxTjSQ>
    <xmx:CXj9ZQUN4sDa4aD83qcF6BsTSQkrMhM4VfiPfhuB_BiJQNFxttpphg>
    <xmx:CXj9ZXOldA8vhDxTytwnUX7azChNLl_FK-khvxGFjb1jmuQPuLk4yQ>
    <xmx:CXj9ZX1V8RMbqxJyZ0d6UkQotTD9512v-ntENZjMrJ6BIe2j1hrmlQ>
    <xmx:CXj9ZdjVvfxROZvlBLYtuc_jiiXO3ueQt2oO8GDFDUJhqiby1lKtEQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ce5bfa80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 22 Mar 2024 12:22:27 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:22:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/7] reftable/basics: fix return type of `binsearch()` to be
 `size_t`
Message-ID: <cd82ac6531f87917c736c4b523496ef270be34b5.1711109214.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IaendBED3d/I7wWT"
Content-Disposition: inline
In-Reply-To: <cover.1711109214.git.ps@pks.im>


--IaendBED3d/I7wWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `binsearch()` function can be used to find the first element for
which a callback functions returns a truish value. But while the array
size is of type `size_t`, the function in fact returns an `int` that is
supposed to index into that array.

Fix the function signature to return a `size_t`. This conversion does
not change any semantics given that the function would only ever return
a value in the range `[0, sz]` anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c      |  2 +-
 reftable/basics.h      |  2 +-
 reftable/basics_test.c |  6 +++---
 reftable/block.c       |  3 ++-
 reftable/refname.c     | 17 +++++++----------
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 0785aff941..2c5f34b39e 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -27,7 +27,7 @@ void put_be16(uint8_t *out, uint16_t i)
 	out[1] =3D (uint8_t)(i & 0xff);
 }
=20
-int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
+size_t binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
 {
 	size_t lo =3D 0;
 	size_t hi =3D sz;
diff --git a/reftable/basics.h b/reftable/basics.h
index 91f3533efe..2672520e76 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -28,7 +28,7 @@ void put_be16(uint8_t *out, uint16_t i);
  * Contrary to bsearch(3), this returns something useful if the argument i=
s not
  * found.
  */
-int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args);
+size_t binsearch(size_t sz, int (*f)(size_t k, void *args), void *args);
=20
 /*
  * Frees a NULL terminated array of malloced strings. The array itself is =
also
diff --git a/reftable/basics_test.c b/reftable/basics_test.c
index 1fcd229725..dc1c87c5df 100644
--- a/reftable/basics_test.c
+++ b/reftable/basics_test.c
@@ -34,15 +34,15 @@ static void test_binsearch(void)
=20
 	int i =3D 0;
 	for (i =3D 1; i < 11; i++) {
-		int res;
+		size_t res;
+
 		args.key =3D i;
 		res =3D binsearch(sz, &binsearch_func, &args);
=20
 		if (res < sz) {
 			EXPECT(args.key < arr[res]);
-			if (res > 0) {
+			if (res > 0)
 				EXPECT(args.key >=3D arr[res - 1]);
-			}
 		} else {
 			EXPECT(args.key =3D=3D 10 || args.key =3D=3D 11);
 		}
diff --git a/reftable/block.c b/reftable/block.c
index e2a2cee58d..422885bddb 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -382,7 +382,8 @@ int block_reader_seek(struct block_reader *br, struct b=
lock_iter *it,
 	};
 	struct block_iter next =3D BLOCK_ITER_INIT;
 	struct reftable_record rec;
-	int err =3D 0, i;
+	int err =3D 0;
+	size_t i;
=20
 	if (args.error) {
 		err =3D REFTABLE_FORMAT_ERROR;
diff --git a/reftable/refname.c b/reftable/refname.c
index 7570e4acf9..64eba1b886 100644
--- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -33,10 +33,9 @@ static int modification_has_ref(struct modification *mod=
, const char *name)
 			.names =3D mod->add,
 			.want =3D name,
 		};
-		int idx =3D binsearch(mod->add_len, find_name, &arg);
-		if (idx < mod->add_len && !strcmp(mod->add[idx], name)) {
+		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
+		if (idx < mod->add_len && !strcmp(mod->add[idx], name))
 			return 0;
-		}
 	}
=20
 	if (mod->del_len > 0) {
@@ -44,10 +43,9 @@ static int modification_has_ref(struct modification *mod=
, const char *name)
 			.names =3D mod->del,
 			.want =3D name,
 		};
-		int idx =3D binsearch(mod->del_len, find_name, &arg);
-		if (idx < mod->del_len && !strcmp(mod->del[idx], name)) {
+		size_t idx =3D binsearch(mod->del_len, find_name, &arg);
+		if (idx < mod->del_len && !strcmp(mod->del[idx], name))
 			return 1;
-		}
 	}
=20
 	err =3D reftable_table_read_ref(&mod->tab, name, &ref);
@@ -77,7 +75,7 @@ static int modification_has_ref_with_prefix(struct modifi=
cation *mod,
 			.names =3D mod->add,
 			.want =3D prefix,
 		};
-		int idx =3D binsearch(mod->add_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
 		if (idx < mod->add_len &&
 		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
 			goto done;
@@ -96,11 +94,10 @@ static int modification_has_ref_with_prefix(struct modi=
fication *mod,
 				.names =3D mod->del,
 				.want =3D ref.refname,
 			};
-			int idx =3D binsearch(mod->del_len, find_name, &arg);
+			size_t idx =3D binsearch(mod->del_len, find_name, &arg);
 			if (idx < mod->del_len &&
-			    !strcmp(ref.refname, mod->del[idx])) {
+			    !strcmp(ref.refname, mod->del[idx]))
 				continue;
-			}
 		}
=20
 		if (strncmp(ref.refname, prefix, strlen(prefix))) {
--=20
2.44.0


--IaendBED3d/I7wWT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX9eAUACgkQVbJhu7ck
PpQ/GA/+O67k367Es+tFHabytpkcYU1RCmm0uK9fac80FtxO5FcOPchNOc/BfJuC
JLtks6owS2uvyRrd0lEIm4w/njBzBp6JuNaH1wdIQZMS7Xp4KfHcAhGusxGcgRVY
Onbhj0wqmACBSSXRQ+QQase47D0AXzj2Rmn5h2TmEW+zrU9AVsUPmO1bRS6IDKXJ
puBzIx2RLHp/C/IBj68+6kX/pVYwx8K/sbUFICURiopp/XE/Sa5vtW7X/jKJyQaj
DszIMDM+9k0aKPmzXeNwNp0PKxeIcBAofXeGp/6/5ts9NW66Hh9dj5TgBryf8afW
MStkcllADmGlkCtUNXFeu9AwGM453doxOvcC93l/4AcL5eFtoIcssgO48Q9xCrpB
nlgjav2QEJhZhHE2JJXZwHvXh0ChxZqYt1fU2j7BWYRpgyYegvOBArghhzpdb4l7
UnqEbkyOtkPpTaqBihh8tBVo9VaWyISNGVPNDNuaPnh4hVWHhyAROh2HKr7DjwkV
4LtYwWdct/+gMhgVd9pe9r4ZXnRFAfZC27Skx0UlRX2e4++o7pP3rWMnFu0ITX+1
U/yVBUIZZdXTDTIShhDAZXKRys4bCjEAEujSiCMJ/geiNXjqpLC9x9EY988fq5bB
IRwjwfnYfqtp1uNAacaGoSTOVPyUGKvjL6xtagv8RzfY2cYNddY=
=1F05
-----END PGP SIGNATURE-----

--IaendBED3d/I7wWT--
