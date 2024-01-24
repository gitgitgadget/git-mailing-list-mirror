Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996062BB03
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100838; cv=none; b=uu2vLugfxyEyLpFU/fk2YpSq4YznLTK0QGa0bchbqRg4BOkODeje2SELH51RrHGYBHW/dE4RluR9cEJfZN34KLi6q3tERs0wmN8hDjopd1bKxwg5rmlySZk8LdKLSoDdveuxzJ+PjIoUWTrhfE2lSQ7V6H+XmuYKTw25mGOBo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100838; c=relaxed/simple;
	bh=uSk89YxiM6bc5/mEA5e1kij5TxQRcdvThDuZP2hx6LM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA7I2QGSf5hizYOaN6mp0K/bCPIhHL06FmQ5TpVd9oc/0y1GGbjs3ggWMqmIqLYVYCnuvqBVmrsPGom6bsWk1pmC+XY6mA1VPLTGb16fXPN8r/+EHQakUrysplBgC9XT7AD9Y5xYIVQoz36h2cIuKgi6cvgETLWOYcxhfHkQg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CO2TdqtR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GFkBEo3i; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CO2TdqtR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GFkBEo3i"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id DCC2C3200AA0
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 07:53:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Jan 2024 07:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706100835; x=1706187235; bh=iE3RZ68w2V
	6oT2wIHta/qhSnGf0sBHJKXEgCe6jy5WA=; b=CO2TdqtR3+0m1LO5RO4UpO1RzV
	EelIEfSz1CzSWTHcOLAl4GRPn6QHmh4pqGB9Z7uzo9c3UesQcpAA/EUG3Xx1f70z
	N7U9qZbJiUowfx9nMaugeNJVkOCEvLmSfuMZknXCuR16wKsC9+CFYz7x5pSyVsF8
	CodcEKDzaEABgQAx3DjJSuEfbk410l4qlsVUEaKzn31kCwlVgMfbXrv5py8BpJFT
	dbwLebRcFmVqKeDWsAVP1DYWucHeqnCOt/wpLKa0x6xmsjTDTbYRVZyZIB1DJRkW
	WjiXZVjxPPq7tbxTW9xv5oq6mxoG6XPeNI63pC3fqFlYH8LaujJMTFacmQcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706100835; x=1706187235; bh=iE3RZ68w2V6oT2wIHta/qhSnGf0s
	BHJKXEgCe6jy5WA=; b=GFkBEo3ijjjBBmFjNgSYfsGUYgUdCGO/f8sqqXfgFOXy
	xKVmwegdRWyiOXDvERHHwO0rz5PpJAjNGjooBvVCeeGOYFLNS/wKVWIfwGy5oLDM
	fF+Y+jVnUtQedQN1NV1sHrMuvvNR3a4Qifpu5QPI3GDfTlN5ZyGJhcHIwUlMj2Km
	TAMZt7CC66XQDKJTcnCUvFUWL6VbFB8SRkVCSErH4IXdhXMvHC1tlnKJXWuJNtxh
	9e6AKyL5vTFNvzSIYZ96ZK/isx1z9jp3jpKhdZvMNLhMnyuTG4ENq2dGMCa+bsdO
	fWt3VE389/F4RjchLg9HLxAoZZeOrVHtuJsGCPPGgQ==
X-ME-Sender: <xms:YwixZVqUgHTYej2miqBGlbJcIwX4jIXIl0abS2g7CQOgBrtKlkjBHg>
    <xme:YwixZXoi9jbGU9HdCJhRHvWETH2ucb48SXaqvuXrEywLkVqFBpl_-7eOEOf-Vu8TX
    WKEjqm0hGporVQ1Dw>
X-ME-Received: <xmr:YwixZSOinhUVDSeVGK56KOpnZcDHsMk2bz-3UXXI0oPIRlCGCChXnM_FNhyjLm8XtFSdEm0-ANd_J8__07pPdjyPRN9y9L8OiEq31UTM0eHD2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:YwixZQ7nXdGYmZElabA0N_Kc7epOs8Zqbe61ci8-UZ0bgJ1abZxUKA>
    <xmx:YwixZU65veOj6wafkaTVcObEUK51xYcWEP8qosoT162vuuWkDeFkLg>
    <xmx:YwixZYiWEmX5ql_89YmCSun-GcVrrZWSHsp_Nu2Q95zqTzHCW9mS7w>
    <xmx:YwixZZVqiiby1pBhhYzdN4PKFQVaHb9WNvj14eTVUJpS06exhEFX5w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 24 Jan 2024 07:53:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c0a6630e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 24 Jan 2024 12:50:46 +0000 (UTC)
Date: Wed, 24 Jan 2024 13:53:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2] reftable/stack: adjust permissions of compacted tables
Message-ID: <b2fb6f5ad0c558527341bd8040544d6b0ae5d8a2.1706100744.git.ps@pks.im>
References: <cover.1706099090.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="28idhwkAzXzFhe2z"
Content-Disposition: inline
In-Reply-To: <cover.1706099090.git.ps@pks.im>


--28idhwkAzXzFhe2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When creating a new compacted table from a range of preexisting ones we
don't set the default permissions on the resulting table when specified
by the user. This has the effect that the "core.sharedRepository" config
will not be honored correctly.

Fix this bug and add a test to catch this issue.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Ugh, I totally forgot about the fact that fchmod(3P) isn't actually
available on Windows. I've thus evicted the first patch and changed the
second patch to use chmod(3P) instead. Too bad.

 reftable/stack.c      |  6 ++++++
 reftable/stack_test.c | 25 +++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 7ffeb3ee10..38e784a8ab 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -731,6 +731,12 @@ static int stack_compact_locked(struct reftable_stack =
*st, int first, int last,
 	strbuf_addstr(temp_tab, ".temp.XXXXXX");
=20
 	tab_fd =3D mkstemp(temp_tab->buf);
+	if (st->config.default_permissions &&
+	    chmod(temp_tab->buf, st->config.default_permissions) < 0) {
+		err =3D REFTABLE_IO_ERROR;
+		goto done;
+	}
+
 	wr =3D reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
=20
 	err =3D stack_write_compact(st, wr, first, last, config);
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 289e902146..2e7d1768b7 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -443,15 +443,16 @@ static void test_reftable_stack_add(void)
 	int err =3D 0;
 	struct reftable_write_options cfg =3D {
 		.exact_log_message =3D 1,
+		.default_permissions =3D 0660,
 	};
 	struct reftable_stack *st =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-
 	struct reftable_ref_record refs[2] =3D { { NULL } };
 	struct reftable_log_record logs[2] =3D { { NULL } };
+	struct strbuf scratch =3D STRBUF_INIT;
+	struct stat stat_result;
 	int N =3D ARRAY_SIZE(refs);
=20
-
 	err =3D reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
 	st->disable_auto_compact =3D 1;
@@ -509,12 +510,32 @@ static void test_reftable_stack_add(void)
 		reftable_log_record_release(&dest);
 	}
=20
+#ifndef GIT_WINDOWS_NATIVE
+	strbuf_addstr(&scratch, dir);
+	strbuf_addstr(&scratch, "/tables.list");
+	err =3D stat(scratch.buf, &stat_result);
+	EXPECT(!err);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+
+	strbuf_reset(&scratch);
+	strbuf_addstr(&scratch, dir);
+	strbuf_addstr(&scratch, "/");
+	/* do not try at home; not an external API for reftable. */
+	strbuf_addstr(&scratch, st->readers[0]->name);
+	err =3D stat(scratch.buf, &stat_result);
+	EXPECT(!err);
+	EXPECT((stat_result.st_mode & 0777) =3D=3D cfg.default_permissions);
+#else
+	(void) stat_result;
+#endif
+
 	/* cleanup */
 	reftable_stack_destroy(st);
 	for (i =3D 0; i < N; i++) {
 		reftable_ref_record_release(&refs[i]);
 		reftable_log_record_release(&logs[i]);
 	}
+	strbuf_release(&scratch);
 	clear_dir(dir);
 }
=20

base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
--=20
2.43.GIT


--28idhwkAzXzFhe2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWxCF0ACgkQVbJhu7ck
PpROog/+J8EztpJTWH/Ekhn7PoRi50N/V0bMK47uW4h6CSoYDl9IzeyOJPrUl7Sl
KiaZl1MCNrc5Gj5vmstGoZns1wVH5tkV6/okop4D1z59kuEgg4UYIZbFPO6XJcCy
xJGRdyhzDgo46CRyFJ7t9jzThKExm5W9C3HCeR/Km21LLoj13zxnWBVrl8mwX0hJ
j9msnhBd2PGEeNiLHVMgJfnThUTi4qqjClpYJ1RV+Q5I3DGwdB6wBVNwCgOjxPeU
gwX5XhL3E3VEImda4wiOFfVcJJ7WEGo7rB2YYQFC5/kFOK+eBZGCr1MtqraXi+0N
adiShRnbpxuPVxD5xLv6FSgPLN1Mhum8Abam5MQX8TbR+MIWVj5B8O9dWIDzVn9S
waZtz10rGEr7KVsb8IwZhiFttzUwfpsJS+xCIKCJUO4Kkaokzjez5oshOTLzvkSP
4moPBLtKBLeXBb1XXhXLer6/WqqBaC638Uq5p66SUjOkeoGxfyncvNATP4DD1aO7
2/cO7MC4zimdKZJS+jx4iENzS/7vRMut1Gcl9r1wwERx1wzRSq50FJuetVJG9p77
3XW9l9L5e8wNjyTbOTjJEH/MZW+JNwJhApQ99b6oDLQ1AW46h7nplL95YE7mnYpB
nLrpD7uY1ZVVNo4TP+R9KQrV5Ncdwo5VCXb+B/rMSJ0mlcpJADs=
=DsA7
-----END PGP SIGNATURE-----

--28idhwkAzXzFhe2z--
