Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817954D117
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 06:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124264; cv=none; b=UC7tuMhBKeztFSLlR/WmUE29cw9I6A2Nqesr5vfHLP1jP4APUrnfR6LVjp8JLjDn2xbtcnl4RB2ywLYPt9Qne3ZpKY7kOYoRNGkiLfvC28LmJXwUuXtqERrv1ENnaVmoTjiwqKV1kZzMnlY+4ROmJWzny52w3RJf7BEJukQNNvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124264; c=relaxed/simple;
	bh=vLB890cYTGdb9NgmSfBkmdTHg9m3d/oRVSp6C4v8dIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkY7r3Ssx1S1XVjxLiz3kL6yJSWXxy3780P++KNr4Nc0z982vVnYeNnprf0gUWi2Trmzhw3DLeoYuGw5UTSsBi3pOG3VUmY6z2IZYI/zUCW8tfjMN5sR3NqW2qkhCANsgJR1VMuPdb/IcSCnhv4YZNjcs7bKJPzBAsDVAu3wzXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TiK/+uO0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qO2v8OVb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TiK/+uO0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qO2v8OVb"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id A705C13800F3;
	Wed,  3 Apr 2024 02:04:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2024 02:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712124260; x=1712210660; bh=AwrZ06wBOj
	DUJE3SlS+DuxcfVVG2qsxOWXKJvgKIEQE=; b=TiK/+uO0rmI/4CtOrmU9ga99nR
	X6AKGfkvL5lTZKujK6yEWjuyDUduJBUqriwLEA14uG+ZFwvKcBl24R6daErQ0N5c
	6fc5LdxP7yYOfc73OB2rY8A1RhYUyGwaHkK8qCvj2etDgwPzl7nXdcb42j+IdF8S
	Wvik5IdAQO8cFGa02Sd0ptrFTdnzuokxj+rXbhpZLv7NlqTZfVSm1aReRzzch2eB
	qQBJ9VoW8MQnIhSvcoyfbzOA9U2rJzT00g+PLs0NUoC0LkxVBiKdkwsqLR1Nferb
	PZd9pXNAg9sKPzPfO2ad6sjEi8ptXXN/B9vaJK6lU2h0SvkTQ/PY6TtSP0AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712124260; x=1712210660; bh=AwrZ06wBOjDUJE3SlS+DuxcfVVG2
	qsxOWXKJvgKIEQE=; b=qO2v8OVbZjZMQvqZ25RZFzBcw0tPEZgLmiSAY1AhqLOU
	znbG6rHLctTtVoYnP0BufCwd+fII8dYPcHCYuwJY2VmfuseLLdw+9iYiMlA2uoOj
	0cIRGqGZTwEqw/G0q45uFje+Kkwq4ti1ZNKxI8LXYA2ctEKGr65oVyYsfUpwHjpK
	qigpsiCwnPfxmw3gXGqRws3IObbKYi1OlzwLltnoL4HJq1VJ3aHpiPHcdtT2vjTX
	KK/WOvn8rk3AO1oIghA8x2SNpnA2X+3dZeh2ik2ClQ4YtUPbj3kQL2cp/lKz/BXC
	MUsS2GuDHnUswGa5bjPbbD3uxYASVBvCbvCS2vNPqA==
X-ME-Sender: <xms:ZPEMZtXepML8K4apvp-6lM4Pt-Y7OV_CFQvOAANE0YmzdumvDSyYLw>
    <xme:ZPEMZtlauGoqS5icRy_ad0r155tV1oHm5jvKF6764nlZSrSxAL1tuY9YPKRVks4Yh
    fbxlCR_x9B9tpiaDw>
X-ME-Received: <xmr:ZPEMZpb8iffLxOgg-XN14rzVwtsc0U3gFJ6D8KV-6YFSwL6clYkHamGgDZ9DzWZKEj8Mjk26oPQ-L7nDn_XB4Nx0yrj3Iq9OPfzymWTReM98-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ZPEMZgW82pFV-FE5Hk-dta2xgPIZxtNEqW28OudniLWlHX9tk4zr0A>
    <xmx:ZPEMZnlQ7oWfVTNF8moE8RAPY-UagPanS7nJMKkRgMz6YA72F3NDlw>
    <xmx:ZPEMZteVN8HyXbMPlSITjTJd7WE8ApsPJ_11K2zLWnJ9JxF1Kk0ytg>
    <xmx:ZPEMZhGIGzwi8SOIdTWf0qGh9Of9eU3iuIv_akD1KLnmSGyiRtM6Xw>
    <xmx:ZPEMZlg_9oTFQQSd6XZ67XKD7QCammGEZ-JKAjwqmmYyW9lSj_b8zdgS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 02:04:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b4ba772 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 06:04:10 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:04:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 5/7] reftable/block: fix error handling when searching
 restart points
Message-ID: <52c238ee9fdd3257333931f938be38712d3532d5.1712123093.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712123093.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pUxHf9MUorwAsYQ3"
Content-Disposition: inline
In-Reply-To: <cover.1712123093.git.ps@pks.im>


--pUxHf9MUorwAsYQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When doing the binary search over restart points in a block we need to
decode the record keys. This decoding step can result in an error when
the block is corrupted, which we indicate to the caller of the binary
search by setting `args.error =3D 1`. But the only caller that exists
mishandles this because it in fact performs the error check before
calling `binsearch()`.

Fix this bug by checking for errors at the right point in time.
Furthermore, refactor `binsearch()` so that it aborts the search in case
the callback function returns a negative value so that we don't
needlessly continue to search the block.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 5 ++++-
 reftable/basics.h | 5 +++--
 reftable/block.c  | 9 ++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 2c5f34b39e..fea711db7e 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -39,8 +39,11 @@ size_t binsearch(size_t sz, int (*f)(size_t k, void *arg=
s), void *args)
 	 */
 	while (hi - lo > 1) {
 		size_t mid =3D lo + (hi - lo) / 2;
+		int ret =3D f(mid, args);
+		if (ret < 0)
+			return sz;
=20
-		if (f(mid, args))
+		if (ret > 0)
 			hi =3D mid;
 		else
 			lo =3D mid;
diff --git a/reftable/basics.h b/reftable/basics.h
index 2672520e76..523ecd5307 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -22,8 +22,9 @@ uint32_t get_be24(uint8_t *in);
 void put_be16(uint8_t *out, uint16_t i);
=20
 /*
- * find smallest index i in [0, sz) at which f(i) is true, assuming
- * that f is ascending. Return sz if f(i) is false for all indices.
+ * find smallest index i in [0, sz) at which `f(i) > 0`, assuming that f is
+ * ascending. Return sz if `f(i) =3D=3D 0` for all indices. The search is =
aborted
+ * and `sz` is returned in case `f(i) < 0`.
  *
  * Contrary to bsearch(3), this returns something useful if the argument i=
s not
  * found.
diff --git a/reftable/block.c b/reftable/block.c
index 57e3dbf658..ca217636ae 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -387,11 +387,6 @@ int block_reader_seek(struct block_reader *br, struct =
block_iter *it,
 	int err =3D 0;
 	size_t i;
=20
-	if (args.error) {
-		err =3D REFTABLE_FORMAT_ERROR;
-		goto done;
-	}
-
 	/*
 	 * Perform a binary search over the block's restart points, which
 	 * avoids doing a linear scan over the whole block. Like this, we
@@ -405,6 +400,10 @@ int block_reader_seek(struct block_reader *br, struct =
block_iter *it,
 	 * too many record.
 	 */
 	i =3D binsearch(br->restart_count, &restart_needle_less, &args);
+	if (args.error) {
+		err =3D REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
=20
 	/*
 	 * Now there are multiple cases:
--=20
2.44.GIT


--pUxHf9MUorwAsYQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM8WEACgkQVbJhu7ck
PpQeSw/+ImvPZ3wVqr4E3kU1FGzb9VmnPu8EWG4RQqP5oefiWjDRJy7lO+F7up6c
NfxAbn5QxR+mlnOLX6GLo4ooOVIbi39JbSN3jJhzrceyyrJs/VEvkwJOvJK8UlU3
yDz2ixOCmIRj3DOmiw3Eid2vLjzQ+cGLMnZPcoLgDUnMIjsZAHzJ6JDaipxX5E6G
XxDCDbYTR6lvYAT667qV5sPo1TisJapkvcvmtNCzTgLv3hn/cz1eIQpCPLKZpUf3
PMY7icXLaqQ7HOwxhZ7PJhhI6FOuqv9fkzClChyzfDjrJagiuS1SVXGE3Zxufp4I
7WS5rSpcXq6836jhnSUDuO9jpTkXruaU/cV5Spcca2lbzKmpMGiaDEFXPp2C19RK
Ayryt2gTS4MuWsHTbXDcP7ZC1R/mc1u4LH/Ur1lpP7FvJ9zPoQHKqbwPL7scCxne
ODjq2dA0uY2hkXkK8lw/jCQbNDyeznMmnWw7OPMo16KmFA5GhNoQ5LSYezpD9Xf0
Zw5F9vb6oqV7Tw396hHjN/0kswC4kmzSIgvoZgqLU8TisjIzrjqgWgozYLvI4vfI
op3KjcNMGm1qKn6qUWzfjHqKTHc+KTnignIaIOcENItw5bITvKluPs+7KO0+ZMh9
FoeXVBEydFYXYPPytbwo8BTP6WNjCWEGuUym0NWvJ63LaEVZF20=
=xQMi
-----END PGP SIGNATURE-----

--pUxHf9MUorwAsYQ3--
