Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B36D208AF
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209699; cv=none; b=lQ6ZybZ6Uz0arrgsD0gEaM76/j/gD4E4eHM5oyuxnMUJ7L9EdWWvfQdoEXA2zIzEA/HS7Sv5oLxE/0gSX51Mf9qes7EKjZ5yR1E1YcOQPriE6UMwDWcg/ie8wA5PxUWXRgJ6KdALJnkIJDa4f/1Cn3fLhW9YfXJxCVxQWRVdBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209699; c=relaxed/simple;
	bh=GlYVW5Eti7UP1Etxb7DUTU7R2mAHVgTpytAvUtkZ8x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvcaDW7xlYQApGJgr9DuCH8fGQKbgvHFeFW3v4pPXpJdVhBYmUDWYZ7f7ON15ShcSqTG/lboMHvN+M8rTiJS8+3yLhF6EFvPG9xDi2Ncy2wVKNH6MxohnB5AA1Clb0ScuFZj5ogOAr1285rgIVJkw/MUF55YgwnFHpHw3NrBRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WIXUb7cL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IseIReYO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WIXUb7cL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IseIReYO"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 966F411400D9;
	Thu,  4 Apr 2024 01:48:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 04 Apr 2024 01:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209696; x=1712296096; bh=6CXbXf1IGK
	RuXwqVpdV4fabxwS5YFmatFF2Q0irbMdQ=; b=WIXUb7cLIMCLwZwgPxq/UWgyFg
	SjRWiXeOX0fpkS9h2rczEWfAskK0iJ66+ohJiOp2a1hADguPPR+xeftuHKNvw5Lx
	T66To9u/nRNFqlotN2VkrtAIA2A35NbW7ynGVDJDieUCVaJ97MFCnDXAP7RKS3Kl
	IjUO3TgVJBB8USHBO/6XfabVnxB90K0DCo8/o1hp7vrYteets4/gGYLBlmZXXC4I
	HhNudv6H1o4JCxkBvhr2EYh9iWnB9wQrfRDvzk8nT7up4oeVocQcNxeoowTD7jOC
	EQ0yqgLEFcg6yq3DRIRimD7o4bzOj2mLiDOC/tD8a+kyA8jXYI6FAogESNsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209696; x=1712296096; bh=6CXbXf1IGKRuXwqVpdV4fabxwS5Y
	FmatFF2Q0irbMdQ=; b=IseIReYOiTFVhEM5zfCQuKBb95rqLpgeVRH6FU/yRJzy
	KN/YmcNcyIqjkT9FH1/zaaFJb53/fa+HxGgdvhKTCCbNmfI9gHlPHD+5rI52Gy2x
	hwjDy6eFWrFFHNdBlUtqN8qJHt5tY5//a6NKw935YoLuGuE8HPLUo5NeVJ+LdY/8
	njSI3xb78oaBoUz6sydAmcMYYIhRfMMAtIbA+F/Nn+Ey96YcsPOP32byWmvqno9a
	xkkIQo0ZepXD/UFvF/3MdtsJiRYrEP4VB1hYO4Fw0fVlkt6UB+1jaXM3S8sPo4oc
	t1rAZ5kYZItPZgB6hq7fZTse8Xply2zBifwUhDJ1rw==
X-ME-Sender: <xms:ID8OZon4HxvA_sgy_NGxl8znS6A5cv8PKiBY-wvX_D1UvQv3rx0ixQ>
    <xme:ID8OZn0EKno2PPz8EAZC8mKLku9R_LVBQyGNq-yfOjz3ujLZxECuSR--RATdrNYWP
    2jB8HoROdtsljUdqA>
X-ME-Received: <xmr:ID8OZmqPiETE_y3Aqv0BPcD-rcuMC6hwEk5g64WoU5TdbjK5tGRKtrmKlK8SEaS0_goiujCHBmUmI0NS6B5goexDcC9Jc2zINX2ot76iGTqnZa2n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ID8OZkm4mUUQD4xJ9SYHlJxt29qXHUnnHdB-hhLfixYIaB-fUJX51Q>
    <xmx:ID8OZm3RlCuS-P82JvDJw1BccyKBr1COE2l61vIHDDYncZ62HQ35fg>
    <xmx:ID8OZru151lyiZDPO72Y6vXOO1--O5UKPnd5964y6hGa66Z6__rzbw>
    <xmx:ID8OZiX075l4GWFKIp2T6uIsJgo_f1BjfOt5E3eazQZ37gY7_toM_w>
    <xmx:ID8OZpQC3HmE6dysJrZv3WEcKsmFonIMeSQvBfihZfI0hcwqkdbvy1fq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id dc34b43b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:12 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 02/11] refs/reftable: perform explicit D/F check when
 writing symrefs
Message-ID: <61901719066a2d0b70b99b275552030326fd375a.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lvOwefcdIZtKYTbZ"
Content-Disposition: inline
In-Reply-To: <cover.1712209149.git.ps@pks.im>


--lvOwefcdIZtKYTbZ
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


--lvOwefcdIZtKYTbZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPxwACgkQVbJhu7ck
PpRM2hAAicEm8d9kJ82uOyS0NMXmeCfKcDup91VUzjGf8bZ664rVrrVQquGXi4wR
LfaISh98Q3uMnBbUXWKCb6ZYgQG1mvt3fNFkNufwwGz8r4SBVdruKvOZCcJsSo10
DdPzEckvS57eUbUPtNfR1O82VgG6E+zQSr+QQC7bE1m+sEJ4rlsn8ioNWe86QEBZ
7hDLIM9SsWDkLULdV7DAyYE1rRXPVb91msQ0SIHY+RvRYS+wDJL6VoOiIR/tH/+3
NThw2/PJaaXoObYL8YnslKL1JyTGYQouvxV01oG82RWN4q7h4sf8bQAlGTWyU7oF
VLb50wALQXO8BuVIfmLI8qYI1rNJgXaXCHl2hlukglFqmtPp/RUklsdI6btnR5pW
rcRGPoxoFTHUskvn022lcWNpD8+X9My53w4pR7M4TnoIFxo6QGBxjfdkx18oGgtz
4yYu8mZAS/si9Fsd/9ne+UGvBxbbrMa4a030eRnAMG0D7kvFkB0BLSzmnMNrSdmU
177RpXKqsqOb3HtgaxTWbWyCOdPr5T5Lud00pCPXK6Err+/L/RVtwx4InAOVPs6v
3b7SsAn/N+lIKoV8Nb0vL3MHQ0RxpFy1iYIKR5gSGxm7f+E8yzwDLkAQLP0XRcSS
upkz5HIywRpzV+Exr+aEHb6xqW+p7L4lwkE/X3ZvjgyRvBCh9WU=
=NcRp
-----END PGP SIGNATURE-----

--lvOwefcdIZtKYTbZ--
