Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359421598F6
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078687; cv=none; b=fe1noARQSWUYuhBgI6Er+gs5yy0P/MniYDOJawMORC1FbNQnK0Eh2Lbnl9mY6WiziHmgjm2ILyCC0Rl2JwIY9uRdFZwXpidgvzNlkK+fFQ1nkVh2UUonNn60K5nm2aOP91rECJhu6FiVWa6PMimFb7cPx68U+U4+ymp+Paxo148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078687; c=relaxed/simple;
	bh=cw3ugWhres0ZQGQzu1mndxx5Kw/Pm6abzi75Wh2kwBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcacisH/PgOYjkPyJ5C0Bm0mKWzGH/yj9125Cjr734jMy9nmssd5C40sWZJNxTpQsRPXF31qvHKEQH7tHj/Nl1l65sJdeSdtJ2eiuXHSuToIhIEBPtdHVR/gZJZFkH0PE2dqYduPFZF/mmg1Ar6QI0JpCoNlZENXwxlaj0dZaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EiIRP5Q7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MoP5Sr4P; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EiIRP5Q7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MoP5Sr4P"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4D2EB18000E1;
	Tue,  2 Apr 2024 13:24:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 02 Apr 2024 13:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078684; x=1712165084; bh=7QOUOWY8XT
	jcboKPTaeXK4AUtPE4GB6zpThVw8IMYiA=; b=EiIRP5Q7oxvrGocoFxeQwujAm+
	rk52Qs++yvs8T/O2QEPsy/zy+bOdjG7fsiPdFglswz4fs4LhSecZrf7IrbY29dwf
	o/pDOYrONK2enF+J/e3uy2KIB8QiYlHQ18+13hdxfCABUir5PscKEdm0ro+QdqMZ
	wYv+SPKh9Qqx4u1YnWw/NP+L+cZ6yinxXnnsngRaviMfGAe1RizpSiUrVKIiLSYQ
	0v4uRg+FHJ/zeBvGC+RJSdplFnkVfdb6eZkBKwMVaofjXC+4u38qDeADFV7JHtoM
	uhDHgv46m1IfdOw4FT5W+762o8/OH3VPUXC63pXzkCaGrdv8pVUICulaUSuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078684; x=1712165084; bh=7QOUOWY8XTjcboKPTaeXK4AUtPE4
	GB6zpThVw8IMYiA=; b=MoP5Sr4PzZwqnHtd9zRMWtBFQA4+Mmkb8HVE50wECWrs
	w7Bl4hQLoOznImbs986SgMnhHYeQCD45nuoZF8xEYL5IC2p9NLb1Rf2VEv3Ray/s
	J/IFWiMvGl7ADKsf+lNkxF5WWabgWMdxBKN0AVeQE2wo0Bcw3Zz26I+O50Fi+djD
	Lk6b1shHqE1JyLcAO/dmuh+kQXbfnNW/CRicMBydil3Y8/bsBFopnHErH3MlONq1
	VXRBq6v14kdHH3zf78THVXKiVCsbzGeRf7ICCB6QZaXEMeeBEU9HqeEItCFfjZAc
	qWNEJ0Wpxutvo+Qf+GtMyQVBo/51+LWCzZTxa6CgAw==
X-ME-Sender: <xms:XD8MZs4TFT_ocEuZm8x6Puh8q6F-9oyl0NdEK6tcNCptPQCBu0xKSw>
    <xme:XD8MZt6eovm8sJzOPNXLU8rWjcPrEMtISKZs4XUgkk50CldJhx6098ksZIErbZ1f1
    fIacaH8WpEqywubMg>
X-ME-Received: <xmr:XD8MZrdwAVW5fw8SJKPslgugDOFmzyTfL961G4vnFWGsD_yq5xWGUKrUeonsJmt6kO1iBpDlcJZTBlnyzYCSEyxF7d4RkZySuuTxs2uX3hZieXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:XD8MZhLUeFwPOS_uKnE4CSpU7Qd_6sPKyAZpf4JekqL07WV7PTgHXg>
    <xmx:XD8MZgI81kbGlJ5D8DnkUzIQ7w5g3KeegznaTVgemF-5cmkWqHT47g>
    <xmx:XD8MZiz13zHx28sCSnPE8bXJhTlOyx84ERxQ21VLv8oho034wcQ1yA>
    <xmx:XD8MZkJ9zhEp6JuE2m_gkaQJGT3G6YCwxETpVZKJzT9Rye1Y0-uhYg>
    <xmx:XD8MZk1UKTArl80jOw5Q9cDzRGUpJcYo6paD69TzyEg2Y26-XPa4vFGW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 13:24:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7eac6dd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 17:24:34 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:24:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/7] reftable/basics: fix return type of `binsearch()` to
 be `size_t`
Message-ID: <baa07ef14425ff45296c2eb677c07b085bacafb3.1712078263.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712078263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yCAfvj+jcpk3/FWU"
Content-Disposition: inline
In-Reply-To: <cover.1712078263.git.ps@pks.im>


--yCAfvj+jcpk3/FWU
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
2.44.GIT


--yCAfvj+jcpk3/FWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMP1gACgkQVbJhu7ck
PpTAiQ/+MJ9B7X9SDMdZJZ10Nhgx6gANhZUUqHZ1sXStym+LJN4c3MO4I0kvhJt0
9Rqhl0xl3HPonpIAoDxs0MgrvEbe53mTCH9Bw1rghdcqFgKrqudmB/nZO6VltrXy
gGK0APZ6jkoSg2u65w8Co1eNU9RxnX8KHBE29oBnedS/9OO/4To/tcUteK5tGKxS
Pd60bdN6SHW04ne6RNnW4r2RdF4G7tGRVHFMbLhKpsO8+lpkjEO5VMJj5sDN6w/7
2AK/NEuTfuZA9yLgsWta+M3U4ngYqPleEEfuei2dKDHgyVlRDJvEUWaDfRW93qc5
Mai1vMemwSBjcxGnNO0TffoBV22OduF3cQ2yVeJgZ1uncjWaDFCbhJk3AJlGeqin
khBHa28YvggTc3A/tx5XEXckcgbJ93yQiFUbl042UoUohQAIytqeHwv0zyDygJ+h
o9vq6e+cGVoUTPLRlz8ASI3Tsw1xXUe8PWWpx33I8iDUOFpwIhMtHeTIzymkipiq
99JJRizay4x9+BLCoAMdXH0jNuXr70VwjWqhJtktKAoJ2WFXjerL6z5lWB7oSuN5
3KidFr4/xCzp4PgeIBFFQ+qaqjqZbqrJaKGSChbg42O46VdL1TJ5PpxpwGrRjkNv
T4pXGU6m+nXS5w+jIiurKRSddBpSzL5wMa2QauLVkPXu/j5sI4s=
=olbV
-----END PGP SIGNATURE-----

--yCAfvj+jcpk3/FWU--
