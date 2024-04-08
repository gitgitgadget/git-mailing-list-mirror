Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021EB6A8AD
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579042; cv=none; b=ZN7TSPfxdGr9QGOZxRUuUNt0DFARe5AIYekgp26bw4O/ERskNywUQWHbhww6VhoFrkL/e6g6JUnvwNYldXI5rtAfb+aA4QniNAJJ4OA5nc3jypt22ynwqTUFTpcPweJ7DuAlzrN81/UO0x4mwEuQan7dTfSAAvXXw+cTPtI/3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579042; c=relaxed/simple;
	bh=8UEk3P16u8wm7vxHESNtofyoU/W56N/LhrF0GXD0cTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KixxgaL1khwpTHivzcsNQxZwbxDzsV63KIHDwIt52ozRIzp1Fgme0Fyvx1Rpk7kge6w+n4rXYOwKKXFHPhnQUKjVV2z9v1Beq+oDZL8vo7VkDR88OcKKN4hGyOdB7rVGum8+3DgsDkE90yo7xtKrdQ5WAWX9GzYQbb5+wnJHylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p1mOzCqs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b711VvMp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p1mOzCqs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b711VvMp"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 173A013800D5;
	Mon,  8 Apr 2024 08:24:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 08 Apr 2024 08:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579040; x=1712665440; bh=P6xXQdSZK2
	A5GAunZCCBmZl6zF+TSASzbY/6+1qtQXo=; b=p1mOzCqsdc/A34JSGdQYn1NtZO
	eR5U7qaCZCLTHcs1NPRPftRlyl0KMw0c661J6Y7SE2khi1MOrsVesHZJSldHzLqB
	c5JS9eWjLTn2YkII0jEJuh4vzu+yh/Zf71/6nib/phDVitbS/v5OTYF81fVTIIrY
	fclBwbzce/kH7Rk7nwzzP4ZCUIoct6EY790rsE4QJVJQandAwjMTT5TGBLMyJTE1
	k5R3S5NB5ues2RMwRGEL3k8pvnFvrU7Hw3jET+5zfIXImKtF4dVVWOB5LcSVHUnV
	C1Lhbrcy2+jJk7K975ar29VtGqyfGrMLwMJWyp2z6PpCwYTVDgMdTTBe5IAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579040; x=1712665440; bh=P6xXQdSZK2A5GAunZCCBmZl6zF+T
	SASzbY/6+1qtQXo=; b=b711VvMpg7VLmiYQ2pCQ7MYUiTZ7FPbte857Xd3vSj9U
	zlMPhyE0Amy3Wb4VHIw/EaJ+7nX8oJYE5w+fMJO041GSXzZzV4RWxToI+zDFwYge
	rxRyLi+GYa9oCkUkqYkgY5o2hVHSbSaq8yxF20YRFcnk85IjrNQnA42sFdF1mjW/
	6oVFwUVpkT1+Lvu5hextaPeW8+zozdh/xiZTGMgvuCLcqAOhQi/ea7buJ27GuUyS
	AJRwBbvfwXN3eg/Nure7uiNLt1G3/Iy2S25HeyDq85zcrqKEczedxrl3eFl/NpG/
	e5xicHo8JO6ovzOiB3wSypFI/cCBMEDJ2Qh8epi71g==
X-ME-Sender: <xms:3-ETZlESM8DwYL8gzTH8YaPgdAf5qtCTr9nlTndQ6iBeYMSI4QZ5uQ>
    <xme:3-ETZqWu1SB49-XpGTLotejcae8bp_M0CvMfBcJc4V4FBZ-V5Yq-SdhS8mHruQ6dh
    mEustYfKX1vTdsZNg>
X-ME-Received: <xmr:3-ETZnLyXwPtBb4t64BnKojDju31FbnONPBGAs8isIxG7mVBTJ1VLlmuHJSZ3cs4LPgMx5KmRhXDD0KLQdF527a8_NL6k-Zf5GUewgSW9HT96pRgEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:3-ETZrESqEU3XNtrVJIDfRHVEHdRmJpKk9uGNrKs6JtRMs3-V1ZrPA>
    <xmx:3-ETZrW_yp6uEvZPNR9FzL9gSVkAniqZNSTbbljKB779euhZdWkUNg>
    <xmx:3-ETZmPaUvYD0q9mXOK1BbrOCMj6D0Rt1x19rSxvQXQoXtMU92WdEg>
    <xmx:3-ETZq1_XfGZLo5D4oJY73BsngoSihSSocX07T2BS8fsszSCCqmsRQ>
    <xmx:4OETZmQJSSk0JrxLnRtjGOjJLlFeV66d7Y65mMQdHmTgLO_M12G2RpID>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:23:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b793b8a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:23:53 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:23:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 02/11] refs/reftable: perform explicit D/F check when
 writing symrefs
Message-ID: <fe3f00d85a15da3b2b81dde27a016d1edcb72c2b.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ps1sdvtHuuevStsx"
Content-Disposition: inline
In-Reply-To: <cover.1712578837.git.ps@pks.im>


--Ps1sdvtHuuevStsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We already perform explicit D/F checks in all reftable callbacks which
write refs, except when writing symrefs. For one this leads to an error
message which isn't perfectly actionable because we only tell the user
that there was a D/F conflict, but not which refs conflicted with each
other. But second, once all ref updating callbacks explicitly check for
D/F conflicts, we can disable the D/F checks in the reftable library
itself and thus avoid some duplicated efforts.

Refactor the code that writes symref tables to explicitly call into
`refs_verify_refname_available()` when writing symrefs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    | 20 +++++++++++++++++---
 t/t0610-reftable-basics.sh |  2 +-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 0358da14db..8a54b0d8b2 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1217,6 +1217,7 @@ static int reftable_be_pack_refs(struct ref_store *re=
f_store,
 struct write_create_symref_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
+	struct strbuf *err;
 	const char *refname;
 	const char *target;
 	const char *logmsg;
@@ -1239,6 +1240,11 @@ static int write_create_symref_table(struct reftable=
_writer *writer, void *cb_da
=20
 	reftable_writer_set_limits(writer, ts, ts);
=20
+	ret =3D refs_verify_refname_available(&create->refs->base, create->refnam=
e,
+					    NULL, NULL, create->err);
+	if (ret < 0)
+		return ret;
+
 	ret =3D reftable_writer_add_ref(writer, &ref);
 	if (ret)
 		return ret;
@@ -1280,12 +1286,14 @@ static int reftable_be_create_symref(struct ref_sto=
re *ref_store,
 	struct reftable_ref_store *refs =3D
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create_symref");
 	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
+	struct strbuf err =3D STRBUF_INIT;
 	struct write_create_symref_arg arg =3D {
 		.refs =3D refs,
 		.stack =3D stack,
 		.refname =3D refname,
 		.target =3D target,
 		.logmsg =3D logmsg,
+		.err =3D &err,
 	};
 	int ret;
=20
@@ -1301,9 +1309,15 @@ static int reftable_be_create_symref(struct ref_stor=
e *ref_store,
=20
 done:
 	assert(ret !=3D REFTABLE_API_ERROR);
-	if (ret)
-		error("unable to write symref for %s: %s", refname,
-		      reftable_error_str(ret));
+	if (ret) {
+		if (err.len)
+			error("%s", err.buf);
+		else
+			error("unable to write symref for %s: %s", refname,
+			      reftable_error_str(ret));
+	}
+
+	strbuf_release(&err);
 	return ret;
 }
=20
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 055231a707..12b0004781 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -255,7 +255,7 @@ test_expect_success 'ref transaction: creating symbolic=
 ref fails with F/D confl
 	git init repo &&
 	test_commit -C repo A &&
 	cat >expect <<-EOF &&
-	error: unable to write symref for refs/heads: file/directory conflict
+	error: ${SQ}refs/heads/main${SQ} exists; cannot create ${SQ}refs/heads${S=
Q}
 	EOF
 	test_must_fail git -C repo symbolic-ref refs/heads refs/heads/foo 2>err &&
 	test_cmp expect err
--=20
2.44.GIT


--Ps1sdvtHuuevStsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4dwACgkQVbJhu7ck
PpQNQA/+KpShqDAghIdGB4dsyL6RzguOhfKXgyZuJWC4R6ONNYgvVfEhjoD7ndTo
KV3kvSDtkZVZKAAIP9o5clLxwA7gwuQKG8li5y4o4DoW8ga3dndmc40Na8sFJzUU
3YQeevqmPFzmsA/oAMZytq+MyaDsq/PUWXOXsepTC36vsUnoPULBaNBvFT1sq1N8
myA/TGd4hOendx3cXoI4HBgns7Lzu69opyQDFNokElpa2rdntM6JDhYH4/FTgXw8
BflP/EcgUGCTN+n4Aya7+e0U83Tm+EHNJ0Vx2rQTCPJhucTnfKoEda86ZeH72OUY
nKeNXBwmSwJ95whRd9vZACzQdeh+TlBZ3PdRW0hSd1I/IL4xReXfsn6e/kSfPBHd
CVz/rN5yMduvPspJa3CEsQWSi8iUb2qe3wyouYp9/sabC6whPksTjdYFFadofW6m
6JT0mX//WdXCQzeMMmxxcg5U0IXjvGZZggm8RZbX/cW6OTvgKq/AkMPef6ttxBep
KwsSbVCNRvkVRNFIUUABQqHhrGaqJLbkFPDd2IeI+d0SAuDoz5JZq/xS0pv+AGsY
R1GsAvUaDPHsRHAp39jBqYBVj2L6xn/53HkJ4NPe+WKsAEUuhkEQ5XKsSxQf+XHv
9gxmogDOVIwPoRTUgKDlTkjVmdFH9JxOznPTdlwcdcGAJnT0OEU=
=D81w
-----END PGP SIGNATURE-----

--Ps1sdvtHuuevStsx--
