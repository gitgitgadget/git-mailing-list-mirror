Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A420E029
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459691; cv=none; b=kkr4KdyNnPymJof5N5hI7IORSANFHISdDYGT27kalSZOJCwsDn57Jt5dWgVtT01363E4ljlUbvOF4L5fWYlKHW+QZsiJvo/9cJXhE6neyjTbql3iH/RTudEkne+uKRJqeBzD5GLCPNgyW3IAmp1XJiJYpx2CMbcwChdn0iNfPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459691; c=relaxed/simple;
	bh=0FcQS2SG4f1ewtMRCV7GmLFVed3d85y4XcxcKwXUA7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cWjiKgUEn6OpSYjank38IUeatL92cxwtBEYhGBxTIoBvtZoWlP3OY952ZolBKr9vHl21ZxzgwQH4gG3Zf1weQrh0VllFlQ03xm3jhZMpCpw5IgXHFNUDHWiyhLzCZ++ztstIegDFK3SkS9jFttETU5kTBxhhBlNLVP64PKX5PXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ePWkifeR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MTmUpGcQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ePWkifeR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MTmUpGcQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 26ADA1D00167;
	Wed,  6 Aug 2025 01:54:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Aug 2025 01:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754459689;
	 x=1754546089; bh=bb9X4+B4jci0f3cgXoGcz0Uy+4IMaqcGSJ858a2Szr4=; b=
	ePWkifeR3aYEzw/ICG4Y30aPvHYYN/DQ2dW674Vp5US5SWq+ifOHSLfdZAp0hLVC
	dVMl9jdBsqFajJ+KnL+s+2H6W0B5wE6zYEQJ86xADH0RlVV3zG7AphP6q84BUtaZ
	sEKSTlkedFDkEwTa8KjeFbRRYRPf+y3L1TguBBgTsHHW51ObaSPN3NJkWoIO1H7a
	OEG3UzNFFlIwNH+oSz6W06FChEch7QGjRyJbr/wUz/m+wIeutF7yWzk1VNq0YIRA
	DdXM5V5d/hg61r9cAVnyb4DQQ9pRp3zIIgG0VlbBNPGVTGegvAYp11z1qn8t2KKx
	ENvSrzgEZHd1q48sdxGtGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754459689; x=
	1754546089; bh=bb9X4+B4jci0f3cgXoGcz0Uy+4IMaqcGSJ858a2Szr4=; b=M
	TmUpGcQXvqRrKfe94PeGgOQ77vjwjxi8gBo/kZIbXwyj3qCK8S5jpQqtrLAzJY/p
	2N0/Cko5Ga9KueKOkzODbBrK9jL+khP0HY3z3zP4ydZq7oxn3YB0zv1Vo8U5JmwO
	QlXcYa1UWAqeIl9S7Nd6yPrHxRcl1QWCc2EA1JQQinNMee+KlAk0+N4WkpfSo0RF
	yiUKXMDdJXv3LxtJmxOhKvh9H9SIdwFCrqbWvkNoe/y/jJ4DkrzD/XjgeufQqdKF
	MhyN4Vy2wnNdtzUD+oCc0+DuMikO/RQlP4w1ZGQfV2eAnVKxqJP0nUHn2bIq+lCZ
	A/RJaIlFXefeYEPJl7MwQ==
X-ME-Sender: <xms:KO6SaIcEWGnVvS636c0WzycxtAs4Pu7eENdUvy8H5LNZ6QnSqxXrIA>
    <xme:KO6SaF5wpaAAV8kn7K_6vFABe1w5JtQ4ziFPHGw6M-cou_X3PA7RixWgbTTycoeUO
    dRFsjq2EMDVKc3Siw>
X-ME-Received: <xmr:KO6SaF9NglSP779gwihXFyTcD_1BXREcbFBxs3AB2-1Kddlm6UQriTQglHZU5BAYm1wP7iKUhKvASG3DhqBB9ttV3yc4lPwNtkSLuyUcYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtg
    hpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:KO6SaHEjsB5S46AEINwNdeiwnPlGRPgTbMtB6tYDlCinfrNAdLd7Tg>
    <xmx:KO6SaKUUBdTna5WTUQiBBa4t_EteFu86t9PLUPLcQuFYihgP9ZpjDQ>
    <xmx:KO6SaD9xkoh8ACjmMAWbGrTctlIvysIdF0kAOsijxA5SFRC_-e5mmg>
    <xmx:KO6SaH7inoKPUTfGn0nVpOY8NP85Z5Qjn4nopxknWVBw42SCw0NWag>
    <xmx:KO6SaKKiCEgugPujzHEI67uhuceHk71szjCizoj8IT4ESlb_tn-v1-sP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 01:54:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99328cd0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 05:54:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 07:54:19 +0200
Subject: [PATCH v6 8/9] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-pks-reflog-append-v6-8-a50839653766@pks.im>
References: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
In-Reply-To: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
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
2.51.0.rc0.215.g125493bb4a.dirty

