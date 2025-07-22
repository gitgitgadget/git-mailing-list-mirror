Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BD2E427F
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183288; cv=none; b=lZHxR1cQinWlhUXh5RvrGsHGAjTTLRBOT6fgpF70yWdqSLKXYfjtnpqNl9rwJM8YP9RV82qOGCCetmL6k2AdVkRe8/jJ+7gXIgVCLZyk6t6VyHqARHYv3kKVwhDXJr93fSxpBM8fvgpl3ioMfK1owco5/FYo1K1hW4LDTdNnn9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183288; c=relaxed/simple;
	bh=dQGWRIxhgjlJtVZ7wGtIIg8yNr76m3rl3cBQAv1u6Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKoXb2dlRJSCcXHSp7aZsqWszRLxyDbluZMgJH52yKP70R7mranqq0TNieBREQrV/hvg1bNL/C4e0vStW9QBwUxws/Q9NlwjQAXu9GMBkKnBjsFfcHvCUOATRJ3HkBBj7b9dSU1As08xMyX276/4KuznlpByQupbl5aVOpD+fEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OVP41Q1D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oe2EZqnl; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OVP41Q1D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oe2EZqnl"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A7EFE1D0020E;
	Tue, 22 Jul 2025 07:21:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 22 Jul 2025 07:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753183285;
	 x=1753269685; bh=/waeBx2Hx5knG6HBJCEgjrP/jAEW4uvf89RzsFmn8uc=; b=
	OVP41Q1DQf45o7RlKDCZJHH9txg4uQBX0raZGzUFrCXtdeHx/ocIcaW/j5otzTbH
	Jli8jUk34iPMo/KHJYdLkw8UjjxVYjzVFBKQOoV+m2yc2EE5Usufc/6+/lOEi7Jd
	B06pFQmkjJK1gfkiGWYoF7M0NPMTWor7/vunBUymm6R4tx5iKlBbPoqt5LnL6BIK
	8WI7j0s5KW54JcgGqRa+0+uzDOoegTXgJxFzNkR7cHhK/j93qIDs+iB9yVAoe9Yo
	fjKASpdVrJANgabIed7NAWWkg2BkIbncp3O6iTrIoVEQ/QOB0IuNRcJWt5KWfHnk
	q3gLS5Dnqg8JeRRQKAkQTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753183285; x=
	1753269685; bh=/waeBx2Hx5knG6HBJCEgjrP/jAEW4uvf89RzsFmn8uc=; b=O
	e2EZqnlKjcAtk3IMF6Bkin8LdMrZwRXSsrHuFI3r2KhiqOra8vTpqpSXl340oNw1
	X29Mfi1eRnsPFlx+3UkmvZYB70R5EWZPEDPdJYqaOwBQzcise80IubLix5x2WD+b
	ohsv4HY2OF2u5tKOgpuBKyP9LHmD9zQB6IXpTLdIWQkZLrx62C7CvP4/FlEee0Bd
	g9A7HAYtp25IHI+MbSIeJlKE2epi+0uNUcnVK3KZGtQxd5Q/CyeoE5FUOhAOwe9t
	k9F829zc4maqYxyutVIZOy7ydWCcZX6Fg8/eyYT0VzwH8Zslde5P8NOoW6A37Zse
	A0IVikihBLjOKVyaKxliQ==
X-ME-Sender: <xms:NXR_aCXIUKqrcBXRpD6zewxn8nrwvnUl2v3mVk2js2X9QETokAZ2Og>
    <xme:NXR_aOxrm-T7vwlEm93b7NN0tolEMgrlbiG7sjyHjuOB5VsGYzguADe0jLjdQEfr3
    eqsBougYxE0yc6dug>
X-ME-Received: <xmr:NXR_aINEjUbgRUS9pisJgHU5-LeV6a0UTnCWW8tt-VgoE5mx287I66dEeENftT5rl0z6WSns1GqaQ-BdjCOWw6ATU_NbqktUjvMYeSkaQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NXR_aH5bPqJUFAzDHKRUCBacUPqzTaobsxRZCwbhG2tGeX4tX3NYSw>
    <xmx:NXR_aBMUgFRQBXY6gLzL2XeCH_bTjqHqphk5YT2t0tYshQp0UEjp5A>
    <xmx:NXR_aNlQquMDSzpkZ9qQCdpTdiGHsl2lIlFhHTg3On8BAo7Ep_6ONQ>
    <xmx:NXR_aARaBVxLQwpLFcuhYun3YCnLQy8ELcKj0xMmk4ATl9ZS6VH9sQ>
    <xmx:NXR_aEmP8vLa1oxbbKPyhi2iZCV2klY8rw-MW5SFsXIGGtXeO3NboOW1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 07:21:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28173cf5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 11:21:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Jul 2025 13:20:56 +0200
Subject: [PATCH 7/8] refs: stop unsetting REF_HAVE_OLD for log-only updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-pks-reflog-append-v1-7-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The `REF_HAVE_OLD` flag indicates whether a given ref update has its old
object ID set. If so, the value of that field is used to verify whteher
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
signal is useful to determine whether we have to resolve the refname
manually to figure out the current state, or whether we should just go
with what the caller has provided.

This actually causes real issues when migrating reflogs, as we don't
know to actually use the caller-provided old object ID when writing
those entries. Instead, reflog entries simply end up with the all-zero
object ID.

Stop unsetting the flag so that we can use it as this described signal,
which we'll do in a subsequent commit. Skip checking the old object ID
for log-only updates so that we don't expect it to match the current
on-disk state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  |  7 +------
 refs/files-backend.c    |  9 +++++----
 refs/reftable-backend.c | 12 +++---------
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index 64544300dc3..c78d5be6e20 100644
--- a/refs.c
+++ b/refs.c
@@ -1384,11 +1384,6 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
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
@@ -3310,7 +3305,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 
 int ref_update_expects_existing_old_ref(struct ref_update *update)
 {
-	return (update->flags & REF_HAVE_OLD) &&
+	return (update->flags & (REF_HAVE_OLD | REF_LOG_ONLY)) == REF_HAVE_OLD &&
 		(!is_null_oid(&update->old_oid) || update->old_target);
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 89ae4517a97..d519bb615fa 100644
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
@@ -3061,7 +3061,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
-		if ((update->flags & REF_HAVE_OLD) &&
+		if (!(update->flags & REF_LOG_ONLY) &&
+		    (update->flags & REF_HAVE_OLD) &&
 		    !is_null_oid(&update->old_oid))
 			BUG("initial ref transaction with old_sha1 set");
 
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
2.50.1.465.gcb3da1c9e6.dirty

