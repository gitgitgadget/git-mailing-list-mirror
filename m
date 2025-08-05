Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE227A108
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406732; cv=none; b=CBFm+nawFQ3nXhvauJdVwW9/cSIl7CP8hL2ENNF3DL6gYv2bFk+sioOIG4Wadk8TaUTp0F/FIE8uMfvVbfNrh4OrsIBl7j+vlwUAX2ot6aMkWyJ3BMZCA/7QuG2oUm6UXwkggixTFE2vGkh8NernhwvIE4xYBkHfoD8Ezk56jsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406732; c=relaxed/simple;
	bh=B3TEm7xTCqjDn3vEOqB/tW6p6lEK46QSnky8Mff9kTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTm7hi72uvGW1cICpekqJkj0NRE7SdDcJYsckrzUPJSa4jX9tLR8Xi2PYu8pHcheAqQ+8ZNIW5/HmOtTwW5L+9RRllybuNkJPwXunQ6GZPsJqd3QJGtEFSvEImqHqVF4sWDyTlC9ibGU9n9LnK6QHlRlps0C1lV5en2e2Bylrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hyi0SalS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kvBk5glT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hyi0SalS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kvBk5glT"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85339140018C;
	Tue,  5 Aug 2025 11:12:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 05 Aug 2025 11:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754406729;
	 x=1754493129; bh=h6cpwTKc8U41orkyRfGHpN8LgbW0c0T5GKG6sc1LX4g=; b=
	hyi0SalSB7TwwLCtCw0e0YL4kETdN1GdB0zkHzqg3iTtFQU5YA4JB14nxS+0jr3H
	DUAQM8tkXC1aHPqP8SC4h+dZ7QNrzfrcpK/CQVo1lzwi92fUMaI2keq4XThXbdeA
	k8Aq458OkklpJefSy02haRFTzyQv8dfWopBA7TOW3Hs4LIvZX+TYGzjglwHF0PdG
	rOEj/bpzjsQcbgv8kFOvddaiVkUvF6NNQDEkYLw8A912zDlTjQLkyiGW6K6FPkaI
	Usf+sxZws/zHR1OcsBhV66WRww2jpYNsyv1ItB930djJFFHfrM4gkoDUMb55h8bq
	4eYvDGV5x+RmyKxsOXXWrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754406729; x=
	1754493129; bh=h6cpwTKc8U41orkyRfGHpN8LgbW0c0T5GKG6sc1LX4g=; b=k
	vBk5glTjyRol94QFHRL5xKaNJH4O9K2ZaIlRA2MUGR7+h8SQ3l0ZsV6R7SAVniCA
	YYrMp3A9pMb+sEb2p6nCh+X6/dsxzW0yy14/9j7BP7fvUnylY9SSVBJ7kcLpS2V5
	myvcOUeKRrhyrnluT+m4XAo11Xmrwjsy3wJYAGyd6GDh29LdJIfYkdhvSgAgvyhf
	2zm7UEXvEwz08FkdpInoW30DaxATQPeQGFPo+b3DKTy7Z+8AaO6552QvbuoJlcyP
	k10e5HHvdNWqktPDd/i96z9bg9si0eatZYKPLEk/8te2GAdaj7BCJFbgb+SXtDz9
	pn+r061WA99Vb9N8bT4jw==
X-ME-Sender: <xms:SR-SaFk7POHWSl1Aggp1iy63BWwTSnyo10tvHjt061QgctVOUzX-mA>
    <xme:SR-SaNsPIW-iP4AYCUp_ux4G9JIEx_sgijzH9y6mVFf2UvZmRiRMmsxqRyGfwIJ_x
    xlUEy-Vi1ad3P3_gQ>
X-ME-Received: <xmr:SR-SaLY3w5rp1nL8Vb3YqIvsdD35yH6tXRAb8TcgCQhQS_5M5ZmzMWessMp-_Cxf4KFaWjY9jeheAbktcbXyM6YBYOZrI69MqCjeBmyc3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhn
    sehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SR-SaFBsdPpPkOPFT0SoS4V15CWFTL-y9u9Q9H5lftiwWdw1FEdF4w>
    <xmx:SR-SaD-0Q4h81u0ARfkQJ7vSxo5ufYnylfwzCid-3s-O1qInuchDOg>
    <xmx:SR-SaBRV3224pFiLaL15kk8V3Nljs44zTp2lYa8wnYcNE3NjWitY2A>
    <xmx:SR-SaHUYw6wfaPl-0G5r7OdKfK7R0tAuzoMufdqq0aPgr6i0y3z91g>
    <xmx:SR-SaGKUpdx4JEA-kusYd6v4gpGsSm69M6MHda6blpVc-HRrimcgX0L3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 11:12:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b603d377 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 15:12:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 05 Aug 2025 17:11:38 +0200
Subject: [PATCH v5 8/9] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-pks-reflog-append-v5-8-050997db09d5@pks.im>
References: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
In-Reply-To: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

The `REF_HAVE_OLD` flag indicates whether a given ref update has its old
object ID set. If so, the value of that field is used to verify whether
the current state of the reference matches this expected state. It is
thus an important part of mitigating races with a concurrent process
that updates the same set of references.

When writing reflogs though we explicitly unset that flag. This is a
sensible thing to do: the old state of reflog entry updates may not
necessarily match the current on-disk state of its accompanying ref, but
it's only intended to signal what old object ID we want to write into
the new reflog entry. For example when migrating refs we end up writing
many reflog entries for a single reference, and most likely those reflog
entries will have many different old object IDs.

But unsetting this flag also removes a useful signal, namely that the
caller _did_ provide an old object ID for a given reflog entry. This
signal will become useful in a subsequent commit, where we add a new
flag that tells the transaction to use the provided old and new object
IDs to write a reflog entry. The `REF_HAVE_OLD` flag is then used as a
signal to verify that the caller really did provide an old object ID.

Stop unsetting the flag so that we can use it as this described signal
in a subsequent commit. Skip checking the old object ID for log-only
updates so that we don't expect it to match the current on-disk state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  |  8 +++-----
 refs/files-backend.c    |  9 +++++----
 refs/refs-internal.h    |  3 ++-
 refs/reftable-backend.c | 12 +++---------
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index a5f9ffaa45..f88928de74 100644
--- a/refs.c
+++ b/refs.c
@@ -1393,11 +1393,6 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
 	update = ref_transaction_add_update(transaction, refname, flags,
 					    new_oid, old_oid, NULL, NULL,
 					    committer_info, msg);
-	/*
-	 * While we do set the old_oid value, we unset the flag to skip
-	 * old_oid verification which only makes sense for refs.
-	 */
-	update->flags &= ~REF_HAVE_OLD;
 	update->index = index;
 
 	/*
@@ -3318,6 +3313,9 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 
 int ref_update_expects_existing_old_ref(struct ref_update *update)
 {
+	if (update->flags & REF_LOG_ONLY)
+		return 0;
+
 	return (update->flags & REF_HAVE_OLD) &&
 		(!is_null_oid(&update->old_oid) || update->old_target);
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ba018b0984..85ab2ef2b9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2500,7 +2500,6 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
 	 * done when new_update is processed.
 	 */
 	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
-	update->flags &= ~REF_HAVE_OLD;
 
 	return 0;
 }
@@ -2515,8 +2514,9 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
 						struct object_id *oid,
 						struct strbuf *err)
 {
-	if (!(update->flags & REF_HAVE_OLD) ||
-		   oideq(oid, &update->old_oid))
+	if (update->flags & REF_LOG_ONLY ||
+	    !(update->flags & REF_HAVE_OLD) ||
+	    oideq(oid, &update->old_oid))
 		return 0;
 
 	if (is_null_oid(&update->old_oid)) {
@@ -3095,7 +3095,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
-		if ((update->flags & REF_HAVE_OLD) &&
+		if (!(update->flags & REF_LOG_ONLY) &&
+		    (update->flags & REF_HAVE_OLD) &&
 		    !is_null_oid(&update->old_oid))
 			BUG("initial ref transaction with old_sha1 set");
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f868870851..95a4dc3902 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -802,7 +802,8 @@ enum ref_transaction_error ref_update_check_old_target(const char *referent,
 
 /*
  * Check if the ref must exist, this means that the old_oid or
- * old_target is non NULL.
+ * old_target is non NULL. Log-only updates never require the old state to
+ * match.
  */
 int ref_update_expects_existing_old_ref(struct ref_update *update);
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4c3817f4ec..44af58ac50 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1180,8 +1180,6 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 	if (ret > 0) {
 		/* The reference does not exist, but we expected it to. */
 		strbuf_addf(err, _("cannot lock ref '%s': "
-
-
 				   "unable to resolve reference '%s'"),
 			    ref_update_original_update_refname(u), u->refname);
 		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
@@ -1235,13 +1233,8 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 
 			new_update->parent_update = u;
 
-			/*
-			 * Change the symbolic ref update to log only. Also, it
-			 * doesn't need to check its old OID value, as that will be
-			 * done when new_update is processed.
-			 */
+			/* Change the symbolic ref update to log only. */
 			u->flags |= REF_LOG_ONLY | REF_NO_DEREF;
-			u->flags &= ~REF_HAVE_OLD;
 		}
 	}
 
@@ -1265,7 +1258,8 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 		ret = ref_update_check_old_target(referent->buf, u, err);
 		if (ret)
 			return ret;
-	} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
+	} else if ((u->flags & (REF_LOG_ONLY | REF_HAVE_OLD)) == REF_HAVE_OLD &&
+		   !oideq(&current_oid, &u->old_oid)) {
 		if (is_null_oid(&u->old_oid)) {
 			strbuf_addf(err, _("cannot lock ref '%s': "
 					   "reference already exists"),

-- 
2.50.1.723.g3e08bea96f.dirty

