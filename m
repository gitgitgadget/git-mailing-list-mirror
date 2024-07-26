Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E697E57E
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996352; cv=none; b=hvz6GsEUIxueqjRKOwJuSNUDvvIrcVkxKRfyVdPaBewmbLU925NyQqO9Efmlvmv1FxXEApr6jVbU5/yzHpMmRq9n6HdxEKrvF5mBZg8h11zaoiDpaAJ+qd/+CZDrbDdq1tDgvUTdWwqox6rtuE19jZc4J+OfireKs9L52zlHDU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996352; c=relaxed/simple;
	bh=rmpiy5hwE4FV64d8alnUwdZLadBiln3/H1UwsdLc6Es=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9ICUVdDthnbo8zzWJrBDvlW3qekGTbNup6oqUqtLjy5HR8yzyskiJXY34EmPlP0GHebwX9gcSvYGw6yD+8PF+0mX6VVYlZ82tMqL/g4QF4nMCvFK/8/aZNz8JeULbssF+6hH4YhlSaFTZcZ39fz9nTovomogS8KqBVUrDWXoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gq50Wn2W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJJ1e5OO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gq50Wn2W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJJ1e5OO"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5BA4313800B5
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:19:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 26 Jul 2024 08:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996350; x=1722082750; bh=oenikin661
	0tWh48CMlXxSfi3YtE5E1SlEkRwQxdGyw=; b=gq50Wn2W74D2L1LzlaYYgsGCrh
	lH9v13ghbXHzvLfGYhjkwki4Zo8Knn6t6zcS4PdlZteEr5Kfa1HvZnRFzoZW0W+U
	KWBPBgLpp9ZIIjFzzfvsm/rkruOaHrYQ45XyLyzXEfss+CLVNow6d4REDIYownCr
	VcDGtvZu3pOFzhHh2P7RPtmH7CqU13w/drkDVtlN5p/hwB7PleCt5gadIO9mkhji
	mxQJC3RDBsPVqMFY3y3MMmnJElBw3i/O9b0lDKiJUA3dDlPfbjfEct1v1TOvYiYp
	JyyA+NOJcpI0Zan5WgLTVhE4KAsjjGjSYQZWcJFm0JSZl3XlXbkGAl3W5Vdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996350; x=1722082750; bh=oenikin6610tWh48CMlXxSfi3YtE
	5E1SlEkRwQxdGyw=; b=VJJ1e5OOFw9vN2oE8a8fyzbpOmJXh8hhaSaYJIOy/+LH
	mUh/hG0xP3iZo9OmQOMuV6cdkvhsgI09NodeDYgf95yhuYRCR6saaam2QQyKOeEF
	qEvCpLpECMSIHyQa9fMi6RXvbEUxJDvLyZ7w0A8LCRf4pJVPUZCTv7p8+nCoN0EY
	lof6KfNdLcaSYsEJQ6qaLNBnYih62Y+sbTIN/R1MTrvdVUi8uiSEMqE7a9WCziaL
	MthOLGk4g6vDtpFe9zdUI9GeKKfZDZx+QG59tyczWDGG4YhRYe65vhpHQoAhVydO
	kztfLKTzwA95Rr3zMme2W3HhAMKSTJNEFOjQmAV8Zw==
X-ME-Sender: <xms:PpSjZpoXS4tJKxG19yMPutG88AX7vc6QfjYEhnwXi0Hq4M9BHt3p6w>
    <xme:PpSjZrqEG1y5w9IERnEc6NEsvTQ70WXJsDPSGEgcqBevlls1kzy8bQE7YSWYay742
    Wx9Xurlmj81O0ZKjw>
X-ME-Received: <xmr:PpSjZmP3zo9E6gphJTSqsiWyPTCVztrIBYKfx5BKTP75jxewXeKdPQdJUW_LBLmH3k9Er90aeTZUQm9B-OqghZzx6xH5zxPDE9QaCd21xGY4P1Mr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:PpSjZk6ziVv1axjQPeW2ZQGQEWz0QTOUy76yZ0FOk1lTqUEopZqhtg>
    <xmx:PpSjZo4w5dzMZf7VxOPvx6HwnyK_ROyRU_e44CpQa5wrKRe01eRBTw>
    <xmx:PpSjZsjcA1_1706_PVL_6kuJ3eLlq4TUivFCH67CT0MlAmJreMx0fA>
    <xmx:PpSjZq5C_ldBiHNWlH8mE4Iqth3bhI9efXP0IXs7_cMEJS7DJUpfgQ>
    <xmx:PpSjZmSauspzUCaDGHgMgOsMR6HyaJIcamNZc8QPpMfhfE5gtUr-82gI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:19:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3c606302 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:17:49 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:18:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 21/23] entry: fix leaking pathnames during delayed checkout
Message-ID: <e426fd7ec5b3a93b4110d05fb4e3580c4f6e7d52.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+RphFvCEjhoWRV0k"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--+RphFvCEjhoWRV0k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When filtering files during delayed checkout, we pass a string list to
`async_query_available_blobs()`. This list is initialized with NODUP,
and thus inserted strings will not be owned by the list. In the latter
function we then try to hand over ownership by passing an `xstrup()`'d
value to `string_list_insert()`. But this is not how this works: a NODUP
list does not take ownership of allocated strings and will never free
them for the caller.

Fix this issue by initializing the list as `DUP` instead and dropping
the explicit call to `xstrdup()`. This is okay to do given that this is
the single callsite of `async_query_available_blobs()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 convert.c                               | 2 +-
 entry.c                                 | 4 +++-
 t/t2080-parallel-checkout-basics.sh     | 1 +
 t/t2082-parallel-checkout-attributes.sh | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index d8737fe0f2..61a540e212 100644
--- a/convert.c
+++ b/convert.c
@@ -960,7 +960,7 @@ int async_query_available_blobs(const char *cmd, struct=
 string_list *available_p
 	while ((line =3D packet_read_line(process->out, NULL))) {
 		const char *path;
 		if (skip_prefix(line, "pathname=3D", &path))
-			string_list_insert(available_paths, xstrdup(path));
+			string_list_insert(available_paths, path);
 		else
 			; /* ignore unknown keys */
 	}
diff --git a/entry.c b/entry.c
index e7ed440ce2..3143b9996b 100644
--- a/entry.c
+++ b/entry.c
@@ -191,7 +191,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 		progress =3D start_delayed_progress(_("Filtering content"), dco->paths.n=
r);
 	while (dco->filters.nr > 0) {
 		for_each_string_list_item(filter, &dco->filters) {
-			struct string_list available_paths =3D STRING_LIST_INIT_NODUP;
+			struct string_list available_paths =3D STRING_LIST_INIT_DUP;
=20
 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
@@ -245,6 +245,8 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 				} else
 					errs =3D 1;
 			}
+
+			string_list_clear(&available_paths, 0);
 		}
=20
 		filter_string_list(&dco->filters, 0, string_is_not_null, NULL);
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkou=
t-basics.sh
index 5ffe1a41e2..59e5570cb2 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -8,6 +8,7 @@ working tree.
 '
=20
 TEST_NO_CREATE_REPO=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
=20
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-che=
ckout-attributes.sh
index f3511cd43a..aec55496eb 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -10,6 +10,7 @@ properly (without access to the index or attribute stack).
 '
=20
 TEST_NO_CREATE_REPO=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
 . "$TEST_DIRECTORY/lib-encoding.sh"
--=20
2.46.0.rc1.dirty


--+RphFvCEjhoWRV0k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajlCwACgkQVbJhu7ck
PpTneg//Zbar9hcktgefJwx1f69e43bexzK/FSx9h0XjETFWpjJXe2H/EkUjZoIK
IK4rvmS6xNq8DyN0AtIVCf0w++x03QECFkkoR/qF/csLO8DLUWtEjEsu3PCRqarh
e8UbsstRMdyRvM01yf5As7Urv1epkGyNO6tLrpfj7FaRCd+Ec5Dv7Oyi6swqSH2J
o1kbU/BsQ1lU7rqv5jAP2dey2PHBoFgRjg9oiVn5Q9JS35GOwIt+4hR9rkBprUaf
OiFtHZzxZmXPi4olXOcyvYSord4awaZ8n5fGHdAhy03468GDk2r1ytitu8+IpILj
v8oEtG+HeyTxW/jCFd8eHAEWyZ23JgbF1bJnGwc0jrLxMgIf/kQBtjIck2iANUkB
4jAjvrW2TWuz2IuwWXedcpIQHCtpuCUSJenODil3az0WqGS8fdYDYD+SoGvwyaMy
E/r9xu4TTGtVr4T/d21Mt++im0kxfvGqiJRhgF0Kjeyjz/cZQ4bxsCXj/NkSTNMk
FiYWo+Ob9Y9ERsCjhu/OtyKFnMgnGNvinqFw/fAUyPzSBLXg6gmprCtiHhrUG/D5
t944J36SA8WypkZJUt8sldcAD9getqJ2hAqDmTr91CWN2Jm7jws20zZZFuBjnKDV
sfP64g77NCLbQoYpNWtV0QQvjh7+7y428YTqdRkviKpi4F6DSQY=
=OD8h
-----END PGP SIGNATURE-----

--+RphFvCEjhoWRV0k--
