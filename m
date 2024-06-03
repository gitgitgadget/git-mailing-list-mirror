Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF012880F
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407031; cv=none; b=HoHi7wruAZQOSBE/NfezuCiAfXFDQEy5EPiKczMXPHVDs9H9+iKVdLMjIMRy5/TaczVayFZ/iVcVZsT5FZHEipZnDKMJZzDK1i/4H1vBZ07LfiSnnuRSZoLfxnbN+D/Bi9cjRY7ScLe6m7xmu5TQgEmYCyv++jcsqd4Cj8MhBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407031; c=relaxed/simple;
	bh=ptV8BtLN8uul3sA3TQuN0lWEhIYL3CRh58d0Qgnts34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IklK2knnP7J0fWFwsyyhSzZD148Rr6Hr4mY+BKGPg+V3IQnAlMU4R5DDtfuHelinpuIFDSqGUg0adfYVX6s+yAIJGt/2nBOq2XeVRFELhM4/ofvKexOkEnSydEirvoVRvovTTajIthvcRAwh4qqMqgFOJ4AqVwEERcuhhaRiMfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FxUC+FCn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OXsLZdDE; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FxUC+FCn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OXsLZdDE"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4C1F3180009D;
	Mon,  3 Jun 2024 05:30:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407028; x=1717493428; bh=l1JDHoXns2
	j1X6DzZcunAsodmtAGeYosJhOZuC+Oecc=; b=FxUC+FCnUHu3+z8xLZ/+oQPH+b
	GNEZIXpjMtDC9XOowPXu2O14SqDex2Xas9zuRTdh6pSgH3UUfGA+cWxjH/EmPnrY
	qjjPzHo+DUDPgY3ctNnAgNqIelyuGFc9sZBtMqBdyI5E8/dXpg9SJ9Q8StP/kQly
	FKts1feGkseuavqdgDNxgpZBo/OgI7lqiXAuPaz9OqsgkkJMgTe/YvkIq7uwv+3c
	zs7JpJ3n1+h27PDT9Una/+25LM1tvk/yAl932cc/tLRR+wi+rUeUS6jo9+6DQmKD
	BbstT5QpIgEt9XCzYgiHbNgYTqukORP5QmzNdnmYL+kXuhAdLzI0CP3zsCiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407028; x=1717493428; bh=l1JDHoXns2j1X6DzZcunAsodmtAG
	eYosJhOZuC+Oecc=; b=OXsLZdDEexi8zr/p7+AXbqFUT1SYq7U5tfX98QFcmHL0
	79FswOHq/9nujY8Kzr4hKK+i0i9GWS3lhkfAiB96rCFUMxECqRBEiTlYs7TGsJv5
	qpyLsTOTIsuQB74yCjsnSy41Gl+HIaOvZgL3b0iukoeZ6gDcH5UwmMWuoF62KpsO
	Ty4F9uuPoKcK6ZgXBhCso4Ny5ExRnkCjrCfziXlV+xCr53Sie/QPBQOMu7Xfq4pI
	9F5Q3yvC614NAopogA1/hnjT0FzDoNjsrXQpETDluHXfUzTLSM53wodgja08pzMN
	08kJd4E47aDIbtInBv/wfOlMLZ7GZ9Ap4z/EAy3zQQ==
X-ME-Sender: <xms:NI1dZhFAZ6Z6NYDsy1q0C5C6mZIK3lKkspvWRKgSQY25NV6m_mW-cg>
    <xme:NI1dZmWpJ7P1931XfFM23iPJao_hVHsUi3AmFVjOBnvaZXCacycyLkghPThDvD-Q7
    KCfnz8FsrygQjJ_mg>
X-ME-Received: <xmr:NI1dZjI2kKCVsrE81zw71DG1WPh2parnwqwyetfnSr-yL5-oSujGIDARINU8KvdZ5O5X-EgFEy56MJIA5v-CmPmuN7V5jYNJkjJP5sTnvc1i4ij6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:NI1dZnFrE4Wp6R6SZ9r5w5cDd67PnI47LkUWNfp7YDJJoAWYN7Mfbg>
    <xmx:NI1dZnUJPGLT2_5x7dSd-A7Nuzy1SCKsTbCCj8iSb5M3kGlVrYf88w>
    <xmx:NI1dZiPB0XJGW-8wvuOJ57vzKRny27Tdgl0Fhdli_xGHqCI24mtJJQ>
    <xmx:NI1dZm0_ti9GsM4HAhkV_FzHJYjNGlwpcAw_aAfIkZZMQkTBnij7-w>
    <xmx:NI1dZtfRUnK4jMQNm3-yLwbTCCW0_bFaEuG1-Dt3M-xGs3nQmAcbU6lh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:30:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 40fafb0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:30:03 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:30:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 04/12] refs: allow to skip creation of reflog entries
Message-ID: <d0539b7456e29fad5c2d1af76657207a199a5d9a.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zRs+S4nFzginFjQB"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--zRs+S4nFzginFjQB
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
index 7c3f4df457..66e9585767 100644
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
2.45.1.410.g58bac47f8e.dirty


--zRs+S4nFzginFjQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjTAACgkQVbJhu7ck
PpQ/CRAAqHLA6M/vWVFLWs5S79nIS+jbK2PfwVDhgXJBoACpNm42AjvKYA0ju4qx
//aUOC80TGYbkpVyy9IB5FqYPI27cstsb9/KUboONRFqsWKqLVknLXCCw043FuC8
jUwIPNqt6tQ6hGdi3iZ1Jh8Mas4ob7hPQ6bALw+GQlqmhvHRPLuVEyw6k3gvsKF1
CddTgabXuQ3sifYNDD0JeYBdBnBJNKJvrBsU1yq7C4tGgXd2h7b40UUZZBDKanX7
1fSHoWrpjs4376+b1odnsmU3LQJRjVe0RPGSUwITibWqkj+88SysQUxFfuFIDtzK
ul2slkObAb9kU8tS+rGx7h2EbqqHvfJF4mH2riyC9xlRtDn8PcCoM8WuDHjKJShk
+UyIVF6WdlJse0MfjJIjTBA35LPPM5dn0iOlOed4o5xtfxp1cs1Axu/Pku7AYG34
rEIluX7n5ANcphJUUoxD5HbUpwQFRr66+ArSebZGiKS0S1tIxuVR1d1BBuFMhZIu
AYH8JbW9GX155+A15BiXNyksbKi2jdubyAvN3at+rDMclVrEMnVVFwZzvj5G3QiQ
EoAXuZ9PpXPnHcto91VnnV7jtPQC28cdYmTMPk5puqX5/MQsp6jxfWgaSpFht5ZH
jKVJ9a2ITmCfOW5sMOEIlQDD9n0A9AO2e3FKLmiK+2RfH70bVnQ=
=SpVq
-----END PGP SIGNATURE-----

--zRs+S4nFzginFjQB--
