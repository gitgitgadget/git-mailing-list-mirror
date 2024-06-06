Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5666C37165
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651757; cv=none; b=sKh4Acgbc/nOz7CsgVydi1KTxfrHv0KHGS5pgMFPXTeCulky2xCbRYp9Zy7Izy3hUIRbUbgFilqXkJ07VRK3AWl5UjL5TZEkJFlLIEpNYZ27ixC2z5d2+dMZc7FWOD4/6hWGWBk6KW1IZ7muMsbwXkTMq6OIuz6WxcXk7PF1qO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651757; c=relaxed/simple;
	bh=Faatj/CchbgIN/DijmcNsYo159kEr5ryRlYN03cc4XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evEEOdwic5xdR9FTUkjECcDHE+WIGTOf2ppkdxl8pt7I7p1szq6DwwleXwG59k3wEaVfm0UtvxDcx8mTRgahzxnPWNN6OSHaqMkJheiXA/+b5WFsB0Kjf0QCx2yTyorgWEp7Edn87lqs1AeVmZVa/V6BHZh5hRW2oCkBW+/es2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y+mrjE78; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gLYrR+vq; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y+mrjE78";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLYrR+vq"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 34887180019D;
	Thu,  6 Jun 2024 01:29:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 01:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651754; x=1717738154; bh=dI+Q96esZj
	zF5B7TXZbygU9teTOcUNMShCKLNyfR7Zk=; b=Y+mrjE78PnKQqyiSnkAfl/Pn+f
	9OdD9X4OH5joH1x6+vVCCtwUvGFTEnUtpE+JNAJ43lHhBQl2QNCaQ81tp9WZVtG3
	W2FeheWRbBKhaDX5nx+Jyxblq3iEXvoPrYs3rxLSJgsxeapGQXE3z9j1DKXDXsSm
	M6j1r2ZyttO84zneqF4/rzinXSUD1WlWyJbcnvppk9Tz8AzhDICEYKVk6vjH4q/p
	n99rFcJ9uvn4j2Lj6GIzrred9KQtAB7JPDLBv+nGmMseQXW2/g35OllG87l3ViVF
	lH3f7r9cthUPPaFEoua3mcyY0/KEFFZESBd5qe9YK0xtIQRP8MuIo34qb22g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651754; x=1717738154; bh=dI+Q96esZjzF5B7TXZbygU9teTOc
	UNMShCKLNyfR7Zk=; b=gLYrR+vqgL9XohR6pAXm/SVXZcx954CoyKfuSzuKrsHb
	F02ZoifGVnZjNFJ1YNZWU2iBKqRZ1sSr7ip630aikkmzML4YUfbZAfVtsS/nSFoc
	N4+RufCZPVKd/4RjuTuCDR0zlTOvI5PoRjpYKn2uI+ohC/+QmweBJBKSDtjEG7yO
	VSEHWsIJ/bArWcN1iuMuR4TgOkbusU+2DYK1HEf+h4FUS3/IMSyTuP0F90SqLPel
	/KJqFxDMih+KVy9UTBkgC8RtiB5097EwNirh7wCbN/ZGYUQ6rtXAMAMeM+DSqkaz
	p1LN+CbTyjrHyIF3pOJuokm2SvNScNB3Yq1qdy/x0g==
X-ME-Sender: <xms:KklhZsBPTmxwOBGzH1cT6c1gQteDLgqGkqN_DVw1l7N2G888qxQeqg>
    <xme:KklhZuiQ9MWudMQxsUIZ81jfH4tspi9drF9mjT0QBlUwebcsfklabhMTjyMKdZGlW
    3JwYn7yWC7S8KzQ9w>
X-ME-Received: <xmr:KklhZvl6ksAhlPoP7FOY1Hn1vuEoVFFBML1lUp4cW6DdFuofCUyT7kdFQcOQc3agmlTBdn8oFGiIXhuPzNx2LzvpfO2qL2xwagq9rPg8Gvz9BQz9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:KklhZix-SSlqkJCZannfWfZ8JWqDoWbvcQ-zkU7UBrGiF9FWOjvPRw>
    <xmx:KklhZhQFelBBqAboHmeg9lGYsktfuQfM5wZ3bZzLQZfXc5hpNaztHg>
    <xmx:KklhZta92msPqESvsmQkYzmQEy1dsP85cNlYBXycHMyo3vd9NjB7Pg>
    <xmx:KklhZqSplnq6dL2l0oT-wsiKuGbud61gvGs2HTKU-pR5ycz6_zYo2Q>
    <xmx:KklhZiQlxMca6TfUHj7HlWhf22UWf05BE76YbAOvR9PPg_9evcAr0ihY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5efb1c21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:28:43 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:29:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 04/12] refs: allow to skip creation of reflog entries
Message-ID: <053f1be657dd7a8b9ebc3251f09123e815f9a24c.1717649802.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XrEsgYhEyY/Nl6at"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--XrEsgYhEyY/Nl6at
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ref backends do not have any way to disable the creation of reflog
entries. This will be required for upcoming ref format migration logic
so that we do not create any entries that didn't exist in the original
ref database.

Provide a new `REF_SKIP_CREATE_REFLOG` flag that allows the caller to
disable reflog entry creation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                    | 6 ++++++
 refs.h                    | 8 +++++++-
 refs/files-backend.c      | 4 ++++
 refs/reftable-backend.c   | 3 ++-
 t/helper/test-ref-store.c | 1 +
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 423684b8b8..fa3b0a82d4 100644
--- a/refs.c
+++ b/refs.c
@@ -1194,6 +1194,12 @@ int ref_transaction_update(struct ref_transaction *t=
ransaction,
 {
 	assert(err);
=20
+	if ((flags & REF_FORCE_CREATE_REFLOG) &&
+	    (flags & REF_SKIP_CREATE_REFLOG)) {
+		strbuf_addstr(err, _("refusing to force and skip creation of reflog"));
+		return -1;
+	}
+
 	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
 	    ((new_oid && !is_null_oid(new_oid)) ?
 		     check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
diff --git a/refs.h b/refs.h
index a7afa9bede..50a2b3ab09 100644
--- a/refs.h
+++ b/refs.h
@@ -659,13 +659,19 @@ struct ref_transaction *ref_store_transaction_begin(s=
truct ref_store *refs,
  */
 #define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
=20
+/*
+ * Skip creation of a reflog entry, even if it would have otherwise been
+ * created.
+ */
+#define REF_SKIP_CREATE_REFLOG (1 << 12)
+
 /*
  * Bitmask of all of the flags that are allowed to be passed in to
  * ref_transaction_update() and friends:
  */
 #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS                              =
    \
 	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION | \
-	 REF_SKIP_REFNAME_VERIFICATION)
+	 REF_SKIP_REFNAME_VERIFICATION | REF_SKIP_CREATE_REFLOG)
=20
 /*
  * Add a reference update to transaction. `new_oid` is the value that
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 73380d7e99..bd0d63bcba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1750,6 +1750,9 @@ static int files_log_ref_write(struct files_ref_store=
 *refs,
 {
 	int logfd, result;
=20
+	if (flags & REF_SKIP_CREATE_REFLOG)
+		return 0;
+
 	if (log_all_ref_updates =3D=3D LOG_REFS_UNSET)
 		log_all_ref_updates =3D is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_=
NORMAL;
=20
@@ -2251,6 +2254,7 @@ static int split_head_update(struct ref_update *updat=
e,
 	struct ref_update *new_update;
=20
 	if ((update->flags & REF_LOG_ONLY) ||
+	    (update->flags & REF_SKIP_CREATE_REFLOG) ||
 	    (update->flags & REF_IS_PRUNING) ||
 	    (update->flags & REF_UPDATE_VIA_HEAD))
 		return 0;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f6edfdf5b3..bffed9257f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1103,7 +1103,8 @@ static int write_transaction_table(struct reftable_wr=
iter *writer, void *cb_data
=20
 			if (ret)
 				goto done;
-		} else if (u->flags & REF_HAVE_NEW &&
+		} else if (!(u->flags & REF_SKIP_CREATE_REFLOG) &&
+			   (u->flags & REF_HAVE_NEW) &&
 			   (u->flags & REF_FORCE_CREATE_REFLOG ||
 			    should_write_log(&arg->refs->base, u->refname))) {
 			struct reftable_log_record *log;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index c9efd74c2b..ad24300170 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -126,6 +126,7 @@ static struct flag_definition transaction_flags[] =3D {
 	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
 	FLAG_DEF(REF_SKIP_OID_VERIFICATION),
 	FLAG_DEF(REF_SKIP_REFNAME_VERIFICATION),
+	FLAG_DEF(REF_SKIP_CREATE_REFLOG),
 	{ NULL, 0 }
 };
=20
--=20
2.45.2.409.g7b0defb391.dirty


--XrEsgYhEyY/Nl6at
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSSYACgkQVbJhu7ck
PpRorw/9FY219T0lCGEhWdgjxH53CmiCfDwNIUvT4jlW5XWKWl5I1JnDZ3tzX6Rm
IgpjueTzea0FaFP8qc/CNR7WZZK8L3q+U6F8Ty5SScWROEhv0Hq4wfnaDB/ez9bm
BQMoGngvVxlqcC/usVn4Y81sZ3A++m2Vb0/8Ak4YX/RRwYFyMl5GVHWgCTFt22ye
OtMYPQxrckHbJdumhAcb0mjs5NrE0faPpQm7SzksSyAyudnmpiDgd+SQ7GZ7J8JO
pahbYuhw6KeOBbzS7vfAO3YPhKC+d9E8B1OPonx0leei90NoCLMm39cRLzU94t9z
KWyzYVqYQntCrnuBu6gdDAMQGyltBXr2wRcQ0UTAU48jzFLBWkv7ARpeC3mfad9U
WByQTIkFocoQz0e13ibbP/FeNYzpJSnHExILRVfCzdqrWlnjz9hQsnUf5DoYufhA
5GI1ktaBekxybRdaZV0kegDtHgTAXEFgfj1qS6dlMWNKSlPbP2PYzWnV5oVuTZwn
oMSJcoWTPq7XuJqS35h/cToXxzMrKapH0c/ZizNmuUGbnzf6k26nrI/Bu5cQTBmh
5XYC5d9Idg9Q9NE04g0Qu1T+sC7dzZ/uVA5MLJbNPdjlZSGtzNxh3z5w+6dqrTOn
TjmO6xEqQH37Eyv8NvUZCUOx8y64OK1jOWqW+uRFPsgV1mL3Dhg=
=VjET
-----END PGP SIGNATURE-----

--XrEsgYhEyY/Nl6at--
