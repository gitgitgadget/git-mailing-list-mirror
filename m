Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5261FD9
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877895; cv=none; b=qtdeINzns+qZ1NhGGOqhUyBNDFuJkUxlOVAonPV9lrL2ZnFJxFxV68fyE5g3tKF77ApNFzBavWvOLTnBXrweGwTDkDG1yRgz7PDKWLN/yw9/o/B23ILMYh6dRB5nMRudY82THs2UyTZqfG+30oZpAZO21UjVUHSfHFI+WhTDzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877895; c=relaxed/simple;
	bh=aahlWehhd3PjFBs+oXFWyRRmv+tBK1McDj8kEVskpVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/TJXGIYKLPIdpmLvgGtFwtU/N9prp2rm8asRM2ddyNyQbEw7fwG0a9pkD/cJokXlwyczbSRGgOuWOgK1VlICK0I5qaXdQhbF+gVhqnH0LzeZccFAvhIwmYL48bMdrFiKa3V1w4EzFfj1e8aFQdD8av+lYbUBWRPzWV5DSBkeFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cbtHedKm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X8j6q8Db; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cbtHedKm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X8j6q8Db"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id E2AEF13800A6;
	Tue, 28 May 2024 02:31:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 28 May 2024 02:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877892; x=1716964292; bh=qPvNXdojrv
	pZr/XubcBo061Oa8wmJWPmTTBLJXDKCAA=; b=cbtHedKmA1CMPez7q/lxnv4cSm
	W7b53Y4BgDTConS+TOGc4HrZEqYXvxlq6hBcBFDlQHct9mqqdVLxRQ+nXxcRBcb+
	41iY0GT1gWWWUBsH5UsepoPF6mSRoScfUgM98PO7IXVelwNUri+Dwk3zoMc6hMNh
	rZSGzjcgP6oPLi6OqTBRHERkteR+TMWuz2mTVK8wYttEOAXMuBHZt8gonjmmu7I/
	yjGCt5+tqkmz2lPs5rvGNkkLXg/9z9JISiybvII5feTORLDgKH3GSYbve6Mq3AON
	G9I84yAXjwAiBKjpKYZ5vJjDMrZ1xLsFuUOGa9L0QzjSwLkbFKNow4jrNbOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877892; x=1716964292; bh=qPvNXdojrvpZr/XubcBo061Oa8wm
	JWPmTTBLJXDKCAA=; b=X8j6q8DbLmFXLrCv1fXLhGR/kKR8Yx6SW3+4btXSHam4
	gfF82iPEuQPdkzBZ8fbOzktxLeavtPMcV/jHYiu3DCH7QVuj8E/87+6i7I3st0GN
	DFSWN6DaBVCTUGHQ5QwUWd+yYD7sWYZD/Af6ShT3AdmmKD4FSVGgm3yN1eFtjEbz
	W1NI9YnACMnvnAWZAFiLPaSqOJ10exRq+2zs6mALAZgArqzS7OElU0tgySp8ZsEY
	fB1wsBBM2RVSxHT0t7O+ChvbHKSxlBZDYu4sBqk65zdk8yW4OP68Na5CxHjUl0BC
	Q7YC51oXG0epijYRro8OLCE0yA8s1QW1MVtyMjOHYg==
X-ME-Sender: <xms:RHpVZtoWCRMAWjSoDL4wtyoTZjWJqUZ1PdKAiFFAeEPsah2jn-8BnA>
    <xme:RHpVZvqyVKqIDJYz-rLl-eIHm21MwmI2L0zodTgneNS045N_IjyIxdczUJ-oTcTJV
    S7N0fe_jpSEeygZOg>
X-ME-Received: <xmr:RHpVZqMotWDRy6shHanktdNAPdVE0vUA4CEzm6feiPM2Kv56hwo8ZCEPnL7c_HlZB6ttcwGN1MmiIpxi7-rtZN5if7roPLHKKMyOMa6dgE1t-x3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:RHpVZo4rzAR_FaObytpbr8PJfUl02ZtO4QQI_qj56WCvHHpHKh2uAw>
    <xmx:RHpVZs7jOwHhqGq6KbmzGqrg_nsphMPLo4bqASOUqqavJiihVNwsEA>
    <xmx:RHpVZgiv-XtmVrGfy0YOye-2QglQimNGEAWxCBwkOY2t5wGyznYfkg>
    <xmx:RHpVZu5HjtrIvH1PvxokEmQKdyqjSSCoszxV-LV8-In0gSVvCdaXlw>
    <xmx:RHpVZmQnH1-NWEHMPJeRF7wPjbT2aXipQ__iiOMQWIgMFPKVLbWpvHbs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:31:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 31f9c575 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:19 +0000 (UTC)
Date: Tue, 28 May 2024 08:31:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 04/12] refs: allow to skip creation of reflog entries
Message-ID: <d0539b7456e29fad5c2d1af76657207a199a5d9a.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l9s49Zhxgj+KK4r0"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--l9s49Zhxgj+KK4r0
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
2.45.1.246.gb9cfe4845c.dirty


--l9s49Zhxgj+KK4r0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVekAACgkQVbJhu7ck
PpT2og/+I2VYqzvWykgp/TF9VkoNzFR16O0LnYPYrjbvdSJ7PRAmUXDww/ZyvawE
8BfRayGUEzPjpalzpmksIfd6C6Mi6r1p47ifb37i8VoG/hGDuPgMK+BcU32fHtqa
yjZIGxb5wCHm1jTcMtQT9C4sfoD8rNq0kWjfJpN09+pjQ9MNlqBHQHbBiKV8H/KD
oxkBdiW2+7J3j8bF/EH8egN2bJBv2MV1aq9qfLxyu9OTRRTZdsf2VUrx5bMvMhQ/
O6uoyizhdnAgW5lSU4QAlYPo/oEZ7Vek9BKIbNXjvTjvKyBqYCf0CvQXjyU6iEHk
QAjO8FAa40edLloFPF1MPda7TlHNY6t4Kh6yAUhPWMp21tYnsxdwyjLBbh0D4J18
dyn+uChPqBqTREELrxBvNbuhi1w+HT4xE09TjOD7t7Tppm51hI6qaxc8H3JPi2Aw
XoijDwypHsrFh+uJ39nn79u4I9pcXewjmt2lTG8tzojZkUk/q18xhsFxdaStaNWh
NuOjcOBNoi9Yacwvp0OIlMe1QDNuX/2gD+VFo93tQND3LY7u0yIQZVrxe9RwX3zv
DzF6OFb9Q/MMaHjRF5uWFdGec0FSjJlPai1PxuNJH+qIj4gu2hfo5WxwHC/S4M0Z
Jn/iWfw/f+DQv3DV4qlhiqLQdWxanVLb/DH65cJmmxfswzZfGgU=
=dirZ
-----END PGP SIGNATURE-----

--l9s49Zhxgj+KK4r0--
