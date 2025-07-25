Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8828A1DD
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426734; cv=none; b=OsFm+sHBAW/64UNUQMW61+ii6eKkiTTpcPOSTTyqR4hb5BvpbUAB8OG6urpQrVnRMRIqqKri5UF9Dj6U45+KZyrt+gp19G3Osa4+XVfHNMhcymNp5GgfB/k9S9IKrdX+2qPNAnf/6hpmEstFdDNDuZD++PB7O56W5sjhD+hoZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426734; c=relaxed/simple;
	bh=NRvRRKxwYhRorc6gfr31SDxLaqFXBnM2SzPedTJ926U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZW6FmIxPDCDoPWoqwem6n9PdH8meQ+mxvhqGf+8Xbv1be5OT6v8WeGi57BADqSfeES3BZx3fs0SNCXH6vMeSvUPVdCzKKAbpQU9s4phk7WUmjWbiJjpWp7IbNaVxZ7VJi/oQ5GZKwKWjdPAtOsC4+C5aSngXV8NPO7kWfz3FZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aBJgSpRv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dIWsO12v; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aBJgSpRv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dIWsO12v"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 35E2FEC03D3;
	Fri, 25 Jul 2025 02:58:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Jul 2025 02:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753426732;
	 x=1753513132; bh=NnRkYldrnCHAA1Eu4v366JmkmQ6StfohAWIv2Ku3Nvg=; b=
	aBJgSpRv8yGNQl17TfJQ0ZaA9WZcN+QToh1+qS5DE7ZZMakC6DhD+9wspef4kvSM
	22j2oAy2u1GvQNCJMogNXuD00kGReXqkfGqYxZBuHfrFqyj8k/Z4dqUXsjm4Lg2J
	oEa5oK1a5yxTvuRES96aGOmYYo7PhsApK3tUoI2Fz7f0D9N2ja0C+SvaolEgQwOP
	gAr2xFv3KyaQdDyCpI1SjEYfv68/q2AF/Ub73SzQdo0lu2uLweZa7u2kgh4WPKXx
	0LT+oDAof49O/8AcEqRQzl9EcB9JruvzG/TEfAZICJRba+80G0ij7AJNG1iQ0lFk
	vAEmiGQYTDRw/8PLI3HBmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753426732; x=
	1753513132; bh=NnRkYldrnCHAA1Eu4v366JmkmQ6StfohAWIv2Ku3Nvg=; b=d
	IWsO12vfLpqV1zUhuP3pgM7bx/ODaqz/MiGXioWrcVMvHi9RcLoSkW7eef2NZUM7
	3Te4tjojcJe/DmmbtPLnG03iTAQ0mc2zYa0HsAiwp8ZLDP78DRn41+AYiFeC6Zir
	JO91xCcJU3O+NtHakvTMoou4gyKUGbgXpKkJsUZJT7HOGu76ovfkAvg2bUxju4Fk
	xUDz6w1V6ANY/XjyDGuMDnsH1PLiqx3Oi/JemZldpfFkOJjW1e7hth03yZyAisMx
	I3IRePtjEjEyueRae6rKH1P+cn3tX2vpvsMKnZb51FN80hQURqCL15sILS0f6p1M
	om1S3/dYJ3tuuAYV275mQ==
X-ME-Sender: <xms:LCuDaN3wdaUTmjtvhhxcaChJTC0-a3j-Qs0BLhyr2rrzH11iqzbxGw>
    <xme:LCuDaMh2HWQlUCyyBY0jFCnUhgreqrAc4yutnZ7Xb3HMakKmTpelWhLUFI6DS8ITG
    v_pOnouciuO_L9H_g>
X-ME-Received: <xmr:LCuDaOWykO0P4SKQpLX9YRlawO4P6UFSEoNKHQIbTmMezJnpOGv34mEBCPUvz4hWEfOi3DR4uHGDvE_togAihn9Ulf-WcJskUlQJJM2nnYxC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:LCuDaLW45w6mivxfwpgp03-qFMYmhudG8M8EJxAJIIP8apmc2Lehxg>
    <xmx:LCuDaOhhqFTZHoVoJw5Z-njb3WxRA9feoLOmjgAfIvaVTmrq6uSAzQ>
    <xmx:LCuDaGaWkNMe8OKTG5Rxv2WfBg377TplZcMQrrASasHq5fJGI4Ot4g>
    <xmx:LCuDaLqxhRSotO9rB4GIpMVDG7PVYp0IxbyfBxwJJo9ek2QA9hVdLg>
    <xmx:LCuDaGVNjl37GXmNb32SlHN0Ktrp0YyPSKa9qoIftBaxUk6uV2VjrKIu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 02:58:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ba34488 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 06:58:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Jul 2025 08:58:29 +0200
Subject: [PATCH v2 7/8] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-pks-reflog-append-v2-7-e4e7cbe3f578@pks.im>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
In-Reply-To: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>
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
index a5f9ffaa45d..f88928de746 100644
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
index bf6f89b1d19..8b42fe18901 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2493,7 +2493,6 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
 	 * done when new_update is processed.
 	 */
 	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
-	update->flags &= ~REF_HAVE_OLD;
 
 	return 0;
 }
@@ -2508,8 +2507,9 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
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
@@ -3059,7 +3059,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
-		if ((update->flags & REF_HAVE_OLD) &&
+		if (!(update->flags & REF_LOG_ONLY) &&
+		    (update->flags & REF_HAVE_OLD) &&
 		    !is_null_oid(&update->old_oid))
 			BUG("initial ref transaction with old_sha1 set");
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f8688708519..95a4dc3902f 100644
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
index 4c3817f4ec1..44af58ac50b 100644
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
2.50.1.565.gc32cd1483b.dirty

