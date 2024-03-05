Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47E5A0FA
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640684; cv=none; b=keiEC9rVKdtiy0/m18W/JuGVU/X8wtUHgH16lXpNiIeE89iBqOc8RVF72Hj+eylWMjs3W8iWq5XwPEWV/544Une54Le/ACMyubpLf/VLTyzjVGzr/ZeqwkYu/lzX8Jj2I2Bl5D33VFKjeOAp2qCNjAHpLqTw9LQfRwo+YuXzL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640684; c=relaxed/simple;
	bh=3R5mi9XLorxR5mWhqOYVbbcNUODKZrsp1PSF9/lWst4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7Aw5Fc1126QbDXKK3toHbT8/vtaEbSIyaAjn4epopiIr2J4ubvc5GmxioXzFTmxgeRyUj+rTKFrBX52WesbSpyLYzUnt28wzNpnu0ZwPXCv5cd0GMA1Anen8ZVthMIicIW+TEEjk3QekLzgy+Ko/LpAWZ0MHMRBKn90sAl5X8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JcNqW7fL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W2KvjH8d; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JcNqW7fL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W2KvjH8d"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5C9C411401B6
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 07:11:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 05 Mar 2024 07:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709640682; x=1709727082; bh=99O3wkPsbU
	QJoW9zhCqu0vAWyYRoTNOssRZw29eailc=; b=JcNqW7fLxCyCsUJcreHzAS3oxN
	qxYHaT0wetO8zUZzDOZx7RQRC/8QPczjsfa3/zbszGR4JHYDPkfm6hf3myJFEPzf
	BDYjMjtzq/f6ceG3UZvMz79G+DQpdFOsNazglTqziikmlu0k9vBDVIF8UUJDSzB/
	L7fB4Xn6v+zgFzrefPH6kMeg3pyMJYPvkNuABnPUESIsVzMZjOc2uUef9i9o/w/e
	qi+mKCNBcW8bJRpqVUd8wUnUwuCDVweuYRwy8XNKn0I430VpNxOl228iM12Y83Cp
	Iw6qtM9Tr/gAngdPvPd/BZ4WhzOAPmBfhdeR9hN76B5oPbxs48A/Bnx7hXZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709640682; x=1709727082; bh=99O3wkPsbUQJoW9zhCqu0vAWyYRo
	TNOssRZw29eailc=; b=W2KvjH8d1XIuEdFRzp8uqNZ58yHYYB5soRO2RkUHd5pS
	8tep2xNs9VI8IONO+l2kBYDkITBCnzOshsTbv1OwdOYofX8rIFAKPUcRttUxwqSi
	oPjNP4Az5e9Te+sUYNhlgA6BZXxnkYQOqVc/N39E+tam2bBOeigUreUMtURHjHg8
	7eOUHM61kgOVRfNvYBQLbz3DuJBT92GG67tOylLx0EeXdrttjGBGSex0qy5cleuM
	3CkgA1GU9n+RO7lxMbSHi5mkAwNOwoRYxGV1sBaXOo/eaR2gD2GUi9pc4nqkB4LF
	fUmLjYF80vHNOQX7pOJKpT/mGrLqvw0sIRc5sladHg==
X-ME-Sender: <xms:6gvnZYn688YyDiMo9fH535Jh1FM3l3u0iow0nW5IZSzcIm9mqo27AA>
    <xme:6gvnZX3eOvVXkjwaNNqtJVxyffTyPJb3WxuP3nGhoc6zwllgNjyWSbDkvu01sHxW-
    npr3AsPLxAnX_IFDA>
X-ME-Received: <xmr:6gvnZWphkcYlLMcEQ4-XnaW54lmbyc5BVmEkzSWETu8F2MtuX5ONi0cwwz0B9XE1aDaw6Xsns5kr4ABFQFpim0FJrHkKx5MFRFEw4ivFQLiEjzE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:6gvnZUkiByjAZ1A_LmevziTl93_gqWhBJRNacsUguZptOD8F0RBDTA>
    <xmx:6gvnZW3zZpmBtKjlUvuArm8u9kEHVLcx7JbUB6Ap1LDlsKPccg4_YQ>
    <xmx:6gvnZbsv7D4F2x0C7mN_x9YV90kgTrMzoFi4azWF3GZD9sEd8zUsQA>
    <xmx:6gvnZb_NGv6lHmn6yUGKJV0Q_CwAGehotcKNrBkORZITmWhdIKgkQA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 5 Mar 2024 07:11:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d231cf1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 5 Mar 2024 12:06:55 +0000 (UTC)
Date: Tue, 5 Mar 2024 13:11:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/7] refs/reftable: track last log record name via strbuf
Message-ID: <f56dd2177e42927dd4cfa88c2adc344f42dbefac.1709640322.git.ps@pks.im>
References: <cover.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1CZDR2JBMQd05w7L"
Content-Disposition: inline
In-Reply-To: <cover.1709640322.git.ps@pks.im>


--1CZDR2JBMQd05w7L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reflog iterator enumerates all reflogs known to a ref backend. In
the "reftable" backend there is no way to list all existing reflogs
directly. Instead, we have to iterate through all reflog entries and
discard all those redundant entries for which we have already returned a
reflog entry.

This logic is implemented by tracking the last reflog name that we have
emitted to the iterator's user. If the next log record has the same name
we simply skip it until we find another record with a different refname.

This last reflog name is stored in a simple C string, which requires us
to free and reallocate it whenever we need to update the reflog name.
Convert it to use a `struct strbuf` instead, which reduces the number of
allocations. Before:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 1,068,485 allocs, 1,068,363 frees, 281,122,886 byte=
s allocated

After:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 68,485 allocs, 68,363 frees, 256,234,072 bytes allo=
cated

Note that even after this change we still allocate quite a lot of data,
even though the number of allocations does not scale with the number of
log records anymore. This remainder comes mostly from decompressing the
log blocks, where we decompress each block into newly allocated memory.
This will be addressed at a later point in time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 2de57c047a..12960d93ff 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1575,7 +1575,7 @@ struct reftable_reflog_iterator {
 	struct reftable_ref_store *refs;
 	struct reftable_iterator iter;
 	struct reftable_log_record log;
-	char *last_name;
+	struct strbuf last_name;
 	int err;
 };
=20
@@ -1594,15 +1594,15 @@ static int reftable_reflog_iterator_advance(struct =
ref_iterator *ref_iterator)
 		 * we've already produced this name. This could be faster by
 		 * seeking directly to reflog@update_index=3D=3D0.
 		 */
-		if (iter->last_name && !strcmp(iter->log.refname, iter->last_name))
+		if (!strcmp(iter->log.refname, iter->last_name.buf))
 			continue;
=20
 		if (check_refname_format(iter->log.refname,
 					 REFNAME_ALLOW_ONELEVEL))
 			continue;
=20
-		free(iter->last_name);
-		iter->last_name =3D xstrdup(iter->log.refname);
+		strbuf_reset(&iter->last_name);
+		strbuf_addstr(&iter->last_name, iter->log.refname);
 		iter->base.refname =3D iter->log.refname;
=20
 		break;
@@ -1635,7 +1635,7 @@ static int reftable_reflog_iterator_abort(struct ref_=
iterator *ref_iterator)
 		(struct reftable_reflog_iterator *)ref_iterator;
 	reftable_log_record_release(&iter->log);
 	reftable_iterator_destroy(&iter->iter);
-	free(iter->last_name);
+	strbuf_release(&iter->last_name);
 	free(iter);
 	return ITER_DONE;
 }
@@ -1655,6 +1655,7 @@ static struct reftable_reflog_iterator *reflog_iterat=
or_for_stack(struct reftabl
=20
 	iter =3D xcalloc(1, sizeof(*iter));
 	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable);
+	strbuf_init(&iter->last_name, 0);
 	iter->refs =3D refs;
=20
 	ret =3D refs->err;
--=20
2.44.0


--1CZDR2JBMQd05w7L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXnC+cACgkQVbJhu7ck
PpRZKw/+LmTVeotgQkSdIiBusREQacFT/FX0YoxYB9pS7/8lS8ORj3wajUgg/UTZ
W2nL2qFo1vVQGgXqt/gq/3Zg4YwUDap4U0+AUVFDqdQqhMr7cACoXodezWTz5gAg
8mdFdK+3JwdWC02XSklCtcEhxdUqT3KUEXGL6iK6jtR3aqTx6y1HN1mQtOtL6FId
YfRBx0FjQsLDTrh5n297tQCOGm197QTUvyQoqRnK/7w2uJAxnEIhH6H04iHfkyYq
vybCqK6MCe2q+rmRnd0TREaMA/cKim1/nTZwloSF1u2bhPP0KrX7aHYj12NN+4aD
Z4SFPBA3XgIg8UzIPms9ANFIr8arPFAYIcdsZXVBzSYdNgHDzSThBOmCA/jcNLSs
82eA37vK8PAaS49w8fc8QGpY2iKLvOZe59MP2WO0P18532V656e8qo3IqYMAfOoL
7M1J2YTuway95LEmzsrOG9LT8+9XTYTvTpIXhFDtlkVXq5emQ9M57Wr3wLO4WEE5
f8sPwChXW5RiX0uKpxtJ6Rn2yBJSu3qY6KlKFoYUruDHkWVzEMoaOnjbmwcEiiII
NpdY41xTo5uxzn1svRwxjSUIvhBxqxav9wJRRlGE+Q19Bd3Cg5/HLcMTRuFqJcZS
KZgRdsAisdjqei2fD2RnLbuAzbPFE7m1ZC4FmN5fb4onYkikWzo=
=fVXI
-----END PGP SIGNATURE-----

--1CZDR2JBMQd05w7L--
