Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82BD2749E0
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779356; cv=none; b=PxiE3kmHZrerzQiorFXgaHHZAQC+1ZT3DVkGKkB+73hh2OJO6VdTtYAaM3ncp7N//Ag3XdV8vfgSynNAer3tk1jNT9HV0wc13XOIZpmslMZrO3F9NCZheqX9SPpnshV6ABPlViNPxZ9JL8Kzri/5YCYapZEXJxhz1JkWda1rFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779356; c=relaxed/simple;
	bh=cK9Gp+R6vAhWyznTDn/+INIv4iae9+cogcT2H/Rtj6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2dBzFbCG0EaLM8tHbcRZkBN7/mQOWqRlIEKwfjj9b+b8j81tUCydaG7EEQ1bOfCZ+0vtm5MUEJxu90J/QTHZqVEK1APaMwV3rNuxAISQNM6n+XXQCJ6McgVYG3it0z3iq8KutK3FoEaVm3YLyFEsVcH+b4iavimwomXkKw9SJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cyp7JrpU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QuL6H/uJ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cyp7JrpU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuL6H/uJ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DB9D71D002EC;
	Tue, 29 Jul 2025 04:55:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 29 Jul 2025 04:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753779353;
	 x=1753865753; bh=Tr1uyUbSWPOQciWwKYh8L2gi9cnMUXyK8gReTPsXBnY=; b=
	cyp7JrpUuLkJOImBae9bw2xXTnWACUPXjHWdV7L5/k7DOu3MaQaEjcHgSdEjqvc8
	wsgguwNVQE+vTUwyBJgdqtSjX70/1+QxpOnl26jLTjQRkpb1wXIyU/uj7wgHfdPt
	9/uaG+fjyCFpa9tlfXce2XqjNik/6Mdq9fTPoO9R01IdH2obNhGdoNoKTGWr5Zay
	cqw0nQhkOFrcbfHWsH+tYzdqWZkaEHFDVGqbLEU5coJOa9lR6aSP0wAJlP86hSOG
	VNDxB5Hx247MLI4Sxh7A+c0OTLGxxlJWLYzeqiw24UFOeMBykKuG9I4lRNn4OTDq
	6a1Sho6XDL0swy9EB3RWig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753779353; x=
	1753865753; bh=Tr1uyUbSWPOQciWwKYh8L2gi9cnMUXyK8gReTPsXBnY=; b=Q
	uL6H/uJ6S06HuG366VsxxZGm9PmE1AXSCrg88za6l4jq5bqLjUfnOoIEiMwbvQV+
	gsDRG9cjClu7CdXcdRjUkXjRgDWlER1qPPckUHe7ePPtd0W4kxwp7HcnXE+/uUkb
	RQTOTvXI8kUYJzc3YLIrs9VAfmSSEx79JgRZPuq7wN7vgmlFzE9U915Ioq9TKYoi
	4gGoeC9mc/AGsXM+zSI+YH0yruY8X481WBGNeHVf4LrZVH2cTGYlnzcioA4Le88E
	98x5Lk/QxpsVYSYkDpPWjmrPVjkg7nXjrRR1vO/ndLln5MK9BaXJ0JUTAC7O3VAJ
	uY2VhJyXWodcyLHqlGCRQ==
X-ME-Sender: <xms:mYyIaDqbylu4op8ORcyGZwiowz7ZVePZd-15stu6XyfN0NO7Yc3tRg>
    <xme:mYyIaKgIUAmqf3ojnTooRV0dZ11d9d3uZaHz2PqX1Gth9HILgIWVoNyFCQhQtXeLF
    OAUdA1Kh5WOhPmgEg>
X-ME-Received: <xmr:mYyIaP9UR5c7YQVo2aOHkeg1OmxMCdhhvyIID6-Uneot4cgtIL5m_Qq6aAU9daHPnOnPFCbEufauOLDn93mBTlrxFlAkbYmYTAM31gv7ctM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrh
    druggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mYyIaGV6UH7BjjXNaKBj-kYT7ijaVl7A3mepWtZ-3s5Mo0zmSuO7-A>
    <xmx:mYyIaDCR-JJnLOgii8W9jEiQfEZycaTu39xipxIQ74vQ4J3t8BwAJQ>
    <xmx:mYyIaLHtjSdD74i0erS9gQ9_S3Kr8FD2A2uePZ_83nVTo119D_SWxQ>
    <xmx:mYyIaE4h828mvVOziLefVRllrdumMQNDBVmjnnO364t3tle9kQi4Zg>
    <xmx:mYyIaJcrChep77oeXfvtIUJWfJkZi4MGmflLZOcpqLjI08RiKA6bWHjV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:55:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8eddc674 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:55:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 10:55:26 +0200
Subject: [PATCH v3 8/9] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-pks-reflog-append-v3-8-9614d310f073@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
In-Reply-To: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
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
index ba018b0984a..85ab2ef2b94 100644
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
2.50.1.619.g074bbf1d35.dirty

