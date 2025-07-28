Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2687261C
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708143; cv=none; b=BETR3BOYABRLar0ZhxXZcZD/9kPKyOkbLH7T9wtQz+uQLN53rayMNx4SUDt3dh3mRcUap/RTZOffY9Vg2ZcpP45Q8Y4XRXTk6n32XbAHwgGoOu7ZS7HYLCiO7CTpCK4UGJ74oQ+uJETUSWRA6D4JIuCrkec3ayNxH9NFZwkfq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708143; c=relaxed/simple;
	bh=S2ixmAAKGyznMhMsJ4ib21rInMev4yXFuSTfzQW6O+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trWiJ+rviWore1Q6dC6Bwsf/HG6tr4DoPtADZk0P5f8k/w7EPKze9+P8jH3+HYok1DULFHumWTsTfsueW2G3FPopCkuOsxPzZpCaHgvI55Q/lc2Ri+aqHxpeIkLqrFe8PgLiMM5IKPzIIUE0f2l4gjYvAc9992ciAsWC3MjNqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FdSUyF3d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Db4Y8kle; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FdSUyF3d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Db4Y8kle"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F72DEC1216;
	Mon, 28 Jul 2025 09:09:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 28 Jul 2025 09:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753708140;
	 x=1753794540; bh=mCBMVx5xDVbdZ6khmoN0dnUHU5Xhf8hvrAaQp19/pAE=; b=
	FdSUyF3dd/gPwky8oUmc8lQWsdOZJpjzZgwF47z2E3d0H6ckoJfY0EVPAOeOJCri
	lcedoYtnnQiARaQ3Vx69tg7luYdvibowg0dSFiu6Vaq9ij99TmSzQog1pTWhTek0
	LKvli4f/9OBVX2bQYPncx97CltFCTyzqxiDojWtafFq8ODnW1lmOhTAmNBcIIXAG
	qrtBejE6qLMv6jUgLeVBXQ6CGPa1ajq3AjSvv7CXv1LSdJrcX9Aj2lEGIuVuwgBD
	Us1NqqW2VZAFSWjiYJ5uFSU1TK1yMuaBDbWowJajg/92zg6qEYhNRoADyxA8h91q
	b8cBQ526QlW9UW+zILIdFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753708140; x=
	1753794540; bh=mCBMVx5xDVbdZ6khmoN0dnUHU5Xhf8hvrAaQp19/pAE=; b=D
	b4Y8klelcA+rVl39LB+lKP1wtKtr49M0vMsZLZvPakwoe098gS3xEbCv+1kHlJFK
	NBhugo0d+fPJuj+QEbXvLNYDcvBcAsk8ePdL08Q2SH9ERI2xdox2RFmkFeEuiDJZ
	1f3acMIRV7fIgjFu17IkLheZimWUtxTrUU2H1Xxgxyg3/WzF+VPvdfMLXWsK2K4E
	c054nJmg7FYoFfgFlwdZpOweP4WSdtfBy31+kNiDYR9/C3Rjsmyoo6JU4nepnUgP
	FBt8zdVCTPa9Kdp4jYNwiBdoNZdLfh/YA5A/BL5NmoSTU+X7Fw4MhQd1EfDqukyY
	i7N/acFYzYWKpG0iaH4Ig==
X-ME-Sender: <xms:bHaHaIaqgD2MjuX4kM6VvP1mAbC5vdEVFjv5A8-p3WLKm_RUFvsBeA>
    <xme:bHaHaN8Mb571gJoafO1i8PEesZgXQ-ujhsmy_ku3FXZZKw0kjM5B3xkEjx_ysb4ve
    27wA_ukDskmTk5KWQ>
X-ME-Received: <xmr:bHaHaPjijFOy90xRkFCW-BohESDrai1AKPyh4uyYIX4OwR4A04suHmr408k-V5cWRVAlpmSIdx4ANfr5xuWBQJurGCi1AkwRcuFN562U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeiteekheevhfejieffudduheekieeuudfghe
    elvddtkeffgfeiudelkeehhffgfeenucffohhmrghinhepuhhpuggrthgvrdhnrghmvgdp
    uhhpuggrthgvrdgvmhgrihhlpdhuphgurghtvgdrthiinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjhhgtrghrlh
    dtkedugeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:bHaHaFepyCAEkSWS-SMnAbRu-4Znhvx_p8oRREsLXXllZUFHpAA9NA>
    <xmx:bHaHaOqRXhrNmeM5nvde25ZnSQch9jRe1SkGVXuHgDf9PdZTi1iQkA>
    <xmx:bHaHaCBw_yjhcOZMG8zokOtnDEvwu6OdSb6rkm41KWxy1vYXZfqL7g>
    <xmx:bHaHaDZkLCy8qt8dH-fYR8dZ6qF6N4joEvtP-HOpiQib20kG2FHOnA>
    <xmx:bHaHaJrRQU7DfKtIf9MUPdsTBDQQLH7st4d5CP9vfMJzWiAqI8EvsjJC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 09:08:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 122969e6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Jul 2025 13:08:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Jul 2025 15:08:45 +0200
Subject: [PATCH 1/4] refs: pass refname when invoking reflog entry callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-pks-remote-rename-improvements-v1-1-f654f2b5c5ae@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Han Jiang <jhcarl0814@gmail.com>
X-Mailer: b4 0.14.2

With `refs_for_each_reflog_ent()` callers can iterate through all the
reflog entries for a given reference. The callback that is being invoked
for each such entry does not receive the name of the reference that we
are currently iterating through. This isn't really a limiting factor, as
callers can simply pass the name via the callback data.

But this layout sometimes does make for a bit of an awkward calling
pattern. One example: when iterating through all reflogs, and for each
reflog we iterate through all refnames, we have to do some extra book
keeping to track which reference name we are currently yielding reflog
entries for.

Change the signature of the callback function so that the reference name
of the reflog gets passed through to it. Adapt callers accordingly and
start using the new parameter in trivial cases. The next commit will
refactor the reference migration logic to make use of this parameter so
that we can simplify its logic a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c            |  9 ++++-----
 builtin/gc.c              |  3 ++-
 builtin/stash.c           |  6 ++++--
 commit.c                  |  3 ++-
 object-name.c             |  3 ++-
 reflog-walk.c             |  7 ++++---
 reflog.c                  |  3 ++-
 reflog.h                  |  3 ++-
 refs.c                    | 19 +++++++++----------
 refs.h                    |  1 +
 refs/debug.c              |  5 +++--
 refs/files-backend.c      | 15 +++++++++------
 refs/reftable-backend.c   |  2 +-
 remote.c                  |  6 ++++--
 revision.c                |  3 ++-
 t/helper/test-ref-store.c |  3 ++-
 wt-status.c               |  6 ++++--
 17 files changed, 57 insertions(+), 40 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0084cf7400b..67eb5e4fa0f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -502,13 +502,12 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 	}
 }
 
-static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid,
+static int fsck_handle_reflog_ent(const char *refname,
+				  struct object_id *ooid, struct object_id *noid,
 				  const char *email UNUSED,
 				  timestamp_t timestamp, int tz UNUSED,
-				  const char *message UNUSED, void *cb_data)
+				  const char *message UNUSED, void *cb_data UNUSED)
 {
-	const char *refname = cb_data;
-
 	if (verbose)
 		fprintf_ln(stderr, _("Checking reflog %s->%s"),
 			   oid_to_hex(ooid), oid_to_hex(noid));
@@ -525,7 +524,7 @@ static int fsck_handle_reflog(const char *logname, void *cb_data)
 	strbuf_worktree_ref(cb_data, &refname, logname);
 	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
 				 refname.buf, fsck_handle_reflog_ent,
-				 refname.buf);
+				 NULL);
 	strbuf_release(&refname);
 	return 0;
 }
diff --git a/builtin/gc.c b/builtin/gc.c
index fab8f4dd4f7..9ae87065d35 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -312,7 +312,8 @@ struct count_reflog_entries_data {
 	size_t limit;
 };
 
-static int count_reflog_entries(struct object_id *old_oid, struct object_id *new_oid,
+static int count_reflog_entries(const char *refname UNUSED,
+				struct object_id *old_oid, struct object_id *new_oid,
 				const char *committer, timestamp_t timestamp,
 				int tz, const char *msg, void *cb_data)
 {
diff --git a/builtin/stash.c b/builtin/stash.c
index e2f95cc2ebc..a1ed67661e3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -738,7 +738,8 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
-static int reject_reflog_ent(struct object_id *ooid UNUSED,
+static int reject_reflog_ent(const char *refname UNUSED,
+			     struct object_id *ooid UNUSED,
 			     struct object_id *noid UNUSED,
 			     const char *email UNUSED,
 			     timestamp_t timestamp UNUSED,
@@ -2173,7 +2174,8 @@ struct stash_entry_data {
 	size_t count;
 };
 
-static int collect_stash_entries(struct object_id *old_oid UNUSED,
+static int collect_stash_entries(const char *refname UNUSED,
+				 struct object_id *old_oid UNUSED,
 				 struct object_id *new_oid,
 				 const char *committer UNUSED,
 				 timestamp_t timestamp UNUSED,
diff --git a/commit.c b/commit.c
index 15115125c36..7ebd05f3527 100644
--- a/commit.c
+++ b/commit.c
@@ -1031,7 +1031,8 @@ static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
 	commit->object.flags |= TMP_MARK;
 }
 
-static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
+static int collect_one_reflog_ent(const char *refname UNUSED,
+				  struct object_id *ooid, struct object_id *noid,
 				  const char *ident UNUSED,
 				  timestamp_t timestamp UNUSED, int tz UNUSED,
 				  const char *message UNUSED, void *cbdata)
diff --git a/object-name.c b/object-name.c
index ddafe7f9b13..9ec192c3731 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1516,7 +1516,8 @@ struct grab_nth_branch_switch_cbdata {
 	struct strbuf *sb;
 };
 
-static int grab_nth_branch_switch(struct object_id *ooid UNUSED,
+static int grab_nth_branch_switch(const char *refname UNUSED,
+				  struct object_id *ooid UNUSED,
 				  struct object_id *noid UNUSED,
 				  const char *email UNUSED,
 				  timestamp_t timestamp UNUSED,
diff --git a/reflog-walk.c b/reflog-walk.c
index c7070b13b00..4f1ce047498 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -22,9 +22,10 @@ struct complete_reflogs {
 	int nr, alloc;
 };
 
-static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
+static int read_one_reflog(const char *refname UNUSED,
+			   struct object_id *ooid, struct object_id *noid,
+			   const char *email, timestamp_t timestamp, int tz,
+			   const char *message, void *cb_data)
 {
 	struct complete_reflogs *array = cb_data;
 	struct reflog_info *item;
diff --git a/reflog.c b/reflog.c
index 39c205fd26e..2264b3bd605 100644
--- a/reflog.c
+++ b/reflog.c
@@ -492,7 +492,8 @@ void reflog_expiry_cleanup(void *cb_data)
 	free_commit_list(cb->mark_list);
 }
 
-int count_reflog_ent(struct object_id *ooid UNUSED,
+int count_reflog_ent(const char *refname UNUSED,
+		     struct object_id *ooid UNUSED,
 		     struct object_id *noid UNUSED,
 		     const char *email UNUSED,
 		     timestamp_t timestamp, int tz UNUSED,
diff --git a/reflog.h b/reflog.h
index 63bb56280f4..44b306c08ae 100644
--- a/reflog.h
+++ b/reflog.h
@@ -63,7 +63,8 @@ void reflog_expiry_prepare(const char *refname, const struct object_id *oid,
 int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 			     const char *email, timestamp_t timestamp, int tz,
 			     const char *message, void *cb_data);
-int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
+int count_reflog_ent(const char *refname,
+		     struct object_id *ooid, struct object_id *noid,
 		     const char *email, timestamp_t timestamp, int tz,
 		     const char *message, void *cb_data);
 int should_expire_reflog_ent_verbose(struct object_id *ooid,
diff --git a/refs.c b/refs.c
index 4bd80287054..fd9a5f36b20 100644
--- a/refs.c
+++ b/refs.c
@@ -1022,7 +1022,6 @@ int is_branch(const char *refname)
 }
 
 struct read_ref_at_cb {
-	const char *refname;
 	timestamp_t at_time;
 	int cnt;
 	int reccnt;
@@ -1052,7 +1051,8 @@ static void set_read_ref_cutoffs(struct read_ref_at_cb *cb,
 		*cb->cutoff_cnt = cb->reccnt;
 }
 
-static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
+static int read_ref_at_ent(const char *refname,
+			   struct object_id *ooid, struct object_id *noid,
 			   const char *email UNUSED,
 			   timestamp_t timestamp, int tz,
 			   const char *message, void *cb_data)
@@ -1072,13 +1072,13 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 			oidcpy(cb->oid, noid);
 			if (!oideq(&cb->ooid, noid))
 				warning(_("log for ref %s has gap after %s"),
-					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
+					refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
 		}
 		else if (cb->date == cb->at_time)
 			oidcpy(cb->oid, noid);
 		else if (!oideq(noid, cb->oid))
 			warning(_("log for ref %s unexpectedly ended on %s"),
-				cb->refname, show_date(cb->date, cb->tz,
+				refname, show_date(cb->date, cb->tz,
 						       DATE_MODE(RFC2822)));
 		cb->reccnt++;
 		oidcpy(&cb->ooid, ooid);
@@ -1094,7 +1094,8 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
-static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
+static int read_ref_at_ent_oldest(const char *refname UNUSED,
+				  struct object_id *ooid, struct object_id *noid,
 				  const char *email UNUSED,
 				  timestamp_t timestamp, int tz,
 				  const char *message, void *cb_data)
@@ -1117,7 +1118,6 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 	struct read_ref_at_cb cb;
 
 	memset(&cb, 0, sizeof(cb));
-	cb.refname = refname;
 	cb.at_time = at_time;
 	cb.cnt = cnt;
 	cb.msg = msg;
@@ -2976,14 +2976,14 @@ static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
 
 struct reflog_migration_data {
 	uint64_t index;
-	const char *refname;
 	struct ref_store *old_refs;
 	struct ref_transaction *transaction;
 	struct strbuf *errbuf;
 	struct strbuf *sb, *name, *mail;
 };
 
-static int migrate_one_reflog_entry(struct object_id *old_oid,
+static int migrate_one_reflog_entry(const char *refname,
+				    struct object_id *old_oid,
 				    struct object_id *new_oid,
 				    const char *committer,
 				    timestamp_t timestamp, int tz,
@@ -3006,7 +3006,7 @@ static int migrate_one_reflog_entry(struct object_id *old_oid,
 	strbuf_reset(data->sb);
 	strbuf_addstr(data->sb, fmt_ident(data->name->buf, data->mail->buf, WANT_BLANK_IDENT, date, 0));
 
-	ret = ref_transaction_update_reflog(data->transaction, data->refname,
+	ret = ref_transaction_update_reflog(data->transaction, refname,
 					    new_oid, old_oid, data->sb->buf,
 					    msg, data->index++, data->errbuf);
 	return ret;
@@ -3016,7 +3016,6 @@ static int migrate_one_reflog(const char *refname, void *cb_data)
 {
 	struct migration_data *migration_data = cb_data;
 	struct reflog_migration_data data = {
-		.refname = refname,
 		.old_refs = migration_data->old_refs,
 		.transaction = migration_data->transaction,
 		.errbuf = migration_data->errbuf,
diff --git a/refs.h b/refs.h
index 99b58d0b73c..a39f873b1fe 100644
--- a/refs.h
+++ b/refs.h
@@ -559,6 +559,7 @@ int refs_delete_reflog(struct ref_store *refs, const char *refname);
  * functions.
  */
 typedef int each_reflog_ent_fn(
+		const char *refname,
 		struct object_id *old_oid, struct object_id *new_oid,
 		const char *committer, timestamp_t timestamp,
 		int tz, const char *msg, void *cb_data);
diff --git a/refs/debug.c b/refs/debug.c
index 485e3079d7a..5e113db307a 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -276,7 +276,8 @@ struct debug_reflog {
 	void *cb_data;
 };
 
-static int debug_print_reflog_ent(struct object_id *old_oid,
+static int debug_print_reflog_ent(const char *refname,
+				  struct object_id *old_oid,
 				  struct object_id *new_oid,
 				  const char *committer, timestamp_t timestamp,
 				  int tz, const char *msg, void *cb_data)
@@ -291,7 +292,7 @@ static int debug_print_reflog_ent(struct object_id *old_oid,
 	if (new_oid)
 		oid_to_hex_r(n, new_oid);
 
-	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
+	ret = dbg->fn(refname, old_oid, new_oid, committer, timestamp, tz, msg,
 		      dbg->cb_data);
 	trace_printf_key(&trace_refs,
 			 "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%.*s\"\n",
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3ebe0323d4e..24d0a8ebde0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2109,7 +2109,9 @@ static int files_delete_reflog(struct ref_store *ref_store,
 	return ret;
 }
 
-static int show_one_reflog_ent(struct files_ref_store *refs, struct strbuf *sb,
+static int show_one_reflog_ent(struct files_ref_store *refs,
+			       const char *refname,
+			       struct strbuf *sb,
 			       each_reflog_ent_fn fn, void *cb_data)
 {
 	struct object_id ooid, noid;
@@ -2136,7 +2138,7 @@ static int show_one_reflog_ent(struct files_ref_store *refs, struct strbuf *sb,
 		message += 6;
 	else
 		message += 7;
-	return fn(&ooid, &noid, p, timestamp, tz, message, cb_data);
+	return fn(refname, &ooid, &noid, p, timestamp, tz, message, cb_data);
 }
 
 static char *find_beginning_of_line(char *bob, char *scan)
@@ -2220,7 +2222,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
 				scanp = bp;
 				endp = bp + 1;
-				ret = show_one_reflog_ent(refs, &sb, fn, cb_data);
+				ret = show_one_reflog_ent(refs, refname, &sb, fn, cb_data);
 				strbuf_reset(&sb);
 				if (ret)
 					break;
@@ -2232,7 +2234,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 				 * Process it, and we can end the loop.
 				 */
 				strbuf_splice(&sb, 0, 0, buf, endp - buf);
-				ret = show_one_reflog_ent(refs, &sb, fn, cb_data);
+				ret = show_one_reflog_ent(refs, refname, &sb, fn, cb_data);
 				strbuf_reset(&sb);
 				break;
 			}
@@ -2282,7 +2284,7 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 		return -1;
 
 	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
-		ret = show_one_reflog_ent(refs, &sb, fn, cb_data);
+		ret = show_one_reflog_ent(refs, refname, &sb, fn, cb_data);
 	fclose(logfp);
 	strbuf_release(&sb);
 	return ret;
@@ -3323,7 +3325,8 @@ struct expire_reflog_cb {
 		     dry_run:1;
 };
 
-static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
+static int expire_reflog_ent(const char *refname UNUSED,
+			     struct object_id *ooid, struct object_id *noid,
 			     const char *email, timestamp_t timestamp, int tz,
 			     const char *message, void *cb_data)
 {
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 99fafd75ebe..25a1d516184 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2148,7 +2148,7 @@ static int yield_log_record(struct reftable_ref_store *refs,
 
 	full_committer = fmt_ident(log->value.update.name, log->value.update.email,
 				   WANT_COMMITTER_IDENT, NULL, IDENT_NO_DATE);
-	return fn(&old_oid, &new_oid, full_committer,
+	return fn(log->refname, &old_oid, &new_oid, full_committer,
 		  log->value.update.time, log->value.update.tz_offset,
 		  log->value.update.message, cb_data);
 }
diff --git a/remote.c b/remote.c
index e965f022f12..db9eea4fa45 100644
--- a/remote.c
+++ b/remote.c
@@ -2578,7 +2578,8 @@ struct check_and_collect_until_cb_data {
 };
 
 /* Get the timestamp of the latest entry. */
-static int peek_reflog(struct object_id *o_oid UNUSED,
+static int peek_reflog(const char *refname UNUSED,
+		       struct object_id *o_oid UNUSED,
 		       struct object_id *n_oid UNUSED,
 		       const char *ident UNUSED,
 		       timestamp_t timestamp, int tz UNUSED,
@@ -2589,7 +2590,8 @@ static int peek_reflog(struct object_id *o_oid UNUSED,
 	return 1;
 }
 
-static int check_and_collect_until(struct object_id *o_oid UNUSED,
+static int check_and_collect_until(const char *refname UNUSED,
+				   struct object_id *o_oid UNUSED,
 				   struct object_id *n_oid,
 				   const char *ident UNUSED,
 				   timestamp_t timestamp, int tz UNUSED,
diff --git a/revision.c b/revision.c
index 212ca0de276..0fc1a167a10 100644
--- a/revision.c
+++ b/revision.c
@@ -1699,7 +1699,8 @@ static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 	}
 }
 
-static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
+static int handle_one_reflog_ent(const char *refname UNUSED,
+				 struct object_id *ooid, struct object_id *noid,
 				 const char *email UNUSED,
 				 timestamp_t timestamp UNUSED,
 				 int tz UNUSED,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 8d9a271845c..b2380d57ba3 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -215,7 +215,8 @@ static int cmd_for_each_reflog(struct ref_store *refs,
 	return refs_for_each_reflog(refs, each_reflog, NULL);
 }
 
-static int each_reflog_ent(struct object_id *old_oid, struct object_id *new_oid,
+static int each_reflog_ent(const char *refname UNUSED,
+			   struct object_id *old_oid, struct object_id *new_oid,
 			   const char *committer, timestamp_t timestamp,
 			   int tz, const char *msg, void *cb_data UNUSED)
 {
diff --git a/wt-status.c b/wt-status.c
index 454601afa15..71bd17b610a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -972,7 +972,8 @@ static void wt_longstatus_print_changed(struct wt_status *s)
 	wt_longstatus_print_trailer(s);
 }
 
-static int stash_count_refs(struct object_id *ooid UNUSED,
+static int stash_count_refs(const char *refname UNUSED,
+			    struct object_id *ooid UNUSED,
 			    struct object_id *noid UNUSED,
 			    const char *email UNUSED,
 			    timestamp_t timestamp UNUSED, int tz UNUSED,
@@ -1664,7 +1665,8 @@ struct grab_1st_switch_cbdata {
 	struct object_id noid;
 };
 
-static int grab_1st_switch(struct object_id *ooid UNUSED,
+static int grab_1st_switch(const char *refname UNUSED,
+			   struct object_id *ooid UNUSED,
 			   struct object_id *noid,
 			   const char *email UNUSED,
 			   timestamp_t timestamp UNUSED, int tz UNUSED,

-- 
2.50.1.565.gc32cd1483b.dirty

