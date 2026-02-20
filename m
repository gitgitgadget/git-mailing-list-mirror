Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E43358BE
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575903; cv=none; b=N3itudl261VZd27k32INd8CRDnlHFNpEPsl/1oa/NIfvDfYvMZUt3hzgQ4qwQSkszNL0z6xzssAL2ZWrcIjaA8CI+4Mj5KY8qMhHbfW9joHGLNTWzSqBAdfEgrl4XJcY+vFlBUTIlq11jLFbb1YDsedEyIQfoJR7s3MqrlulTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575903; c=relaxed/simple;
	bh=Kl5jt1hFP7VKkuUnf63RW+2/EwuLyA/vu/Nd10e3zfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ccWiuV1afZn4dedEIYFqO1vu/P6QzdRYqtCoT9cuPoblXggRc2oqbOcIz4p1J+fbMViPrJZMGSDAAtyKrf8ZPYzz0aIZFs6CGDtmin/rTQJ5LUKVBtP/xV3B8211YYasWHhK9vY9B2MQZxG53OmUea6GGi1iQNLXd4nB/iCOzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LzyTmXzI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dwybJkFL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LzyTmXzI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dwybJkFL"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F2E21D00011;
	Fri, 20 Feb 2026 03:25:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 20 Feb 2026 03:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575901;
	 x=1771662301; bh=5/c6PmwdGT9y/CTAcUPUvWzLW4wNa6QgDKu/2CPVlY4=; b=
	LzyTmXzIrRVRwuqhzg4/GOtzS5f8mvkky2iUJissG3ldAuUIb3FVlfVTHWVVAXtb
	5CbtXJbpQgF+lm6eUYvjxsjZTH/wOtME/kyuIR4W1hYNM5joZF6ya3mltfPfHc7T
	F4ba4VDbIHvr1PYca05Z6fyh142dry2aWHp61qS9ZO98c8hm6AZTgQsAx4wpkEoo
	Vsw59wAERNGrdwoCCJiTNtGmK5JuWQPxn0X33FNsgVpBRyFVWWeayFtxaR15npYQ
	Qr8h6+VJgPQs34pjIGcYt+4ilwlipgj0E7XvjkLLK7l8hmbiNXwEZZAQFaYSzEX3
	4uSsF0F2eyBxZULj1J5Znw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575901; x=
	1771662301; bh=5/c6PmwdGT9y/CTAcUPUvWzLW4wNa6QgDKu/2CPVlY4=; b=d
	wybJkFL5OfIZ1pzH0tcU2yPRjw1V3kpailgWz+Jb2UEuR5boaRNrEbxIWd/Ted+m
	ECoqLEINc/rEcLEmw5Rkv37SlwC0oseQwtWRKDMKNbzuNGS8IhyNfkd42B7w555M
	hlv4iOO+Rd7SWyiDjsiTho9ICv7ms5atxuo1jqP180EOUW+aq1HeDRrF/nTFqT6Y
	1e6ideoFqkfQ+Zo/0Q4UfhJE88Ji52TKPh0LBp466MynJAxhhjF2wivm/OA8wH6E
	JQGki56TZiYgE0/L3fyD1CegajLPHE5BnazojNyvrofSX9jmShG3hrFAor/GrpyP
	O1QCbBNSRmbQP4H1s3WCA==
X-ME-Sender: <xms:XRqYaQta4ZSyRGNPylLfNVfC1dTb-kcbmy9nTVoR6yiUI37Ur8iYTg>
    <xme:XRqYaTfYkD_adIyBxd8D2H7YQT8KJ4AvJu0z70M2lZhlAkJy2lzqwCsmGi4zQQq7Q
    Xxu9NHTWp7kc4nAGG6KD0wM9Vp2TW79JRu7hHTriwsOVQqpCGbF3w>
X-ME-Received: <xmr:XRqYaZZv6mt8z-iOqnlJrffzYRL1k1KEem5Qp-epUp0KiarikuEzA1HOGP2ac4H6nC3CzUyur26b-rNp56zMnj9yT0qGgPFfJfANptJfgR6Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XRqYaeWPNK0XMhI21iFodb-ZwBYLQPyLJQ3zZiGoI4wPJVcr9U2xwA>
    <xmx:XRqYaTiAix-gBdh69QnvLLzXAjAY1h0hNisjuZjkQd0dzWg1KpDPbA>
    <xmx:XRqYaUXTzyR-W1fzrOhoZauk8AmsbeTEdXjX7FB7k9rtTP0rHwp_pg>
    <xmx:XRqYaSOlfdmIRQLEpb_A-JGz01X_VF1WNBc6UVpsxfkIuoLAW4OfqQ>
    <xmx:XRqYabe92XoDDB3zarxyQw4GLpRa4vcVEI_SXpitLWKq6uYiHqH1wRnu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:25:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e122b18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:16 +0100
Subject: [PATCH 12/17] refs: replace `refs_for_each_rawref()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-12-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_rawref()` with the newly introduced
`refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/describe.c   |  7 +++++--
 builtin/fsck.c       |  7 +++++--
 fetch-pack.c         | 15 +++++++++++----
 refs.c               | 10 ++++------
 refs.h               |  1 -
 refs/files-backend.c |  7 +++++--
 6 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index abfe3525a5..bffeed13a3 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -641,6 +641,9 @@ int cmd_describe(int argc,
 		 const char *prefix,
 		 struct repository *repo UNUSED )
 {
+	struct refs_for_each_ref_options for_each_ref_opts = {
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
 	int contains = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "contains",   &contains, N_("find the tag that comes after the commit")),
@@ -738,8 +741,8 @@ int cmd_describe(int argc,
 	}
 
 	hashmap_init(&names, commit_name_neq, NULL, 0);
-	refs_for_each_rawref(get_main_ref_store(the_repository), get_name,
-			     NULL);
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      get_name, NULL, &for_each_ref_opts);
 	if (!hashmap_get_size(&names) && !always)
 		die(_("No names found, cannot describe anything."));
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0512f78a87..24cdb657f5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -598,6 +598,9 @@ static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
 
 static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 {
+	struct refs_for_each_ref_options opts = {
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
 	struct worktree **worktrees, **p;
 	const char *head_points_at;
 	struct object_id head_oid;
@@ -623,8 +626,8 @@ static void snapshot_refs(struct snapshot *snap, int argc, const char **argv)
 		return;
 	}
 
-	refs_for_each_rawref(get_main_ref_store(the_repository),
-			     snapshot_ref, snap);
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      snapshot_ref, snap, &opts);
 
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
diff --git a/fetch-pack.c b/fetch-pack.c
index 40316c9a34..570caa03fa 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -292,11 +292,14 @@ static int next_flush(int stateless_rpc, int count)
 static void mark_tips(struct fetch_negotiator *negotiator,
 		      const struct oid_array *negotiation_tips)
 {
+	struct refs_for_each_ref_options opts = {
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
 	int i;
 
 	if (!negotiation_tips) {
-		refs_for_each_rawref(get_main_ref_store(the_repository),
-				     rev_list_insert_ref_oid, negotiator);
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      rev_list_insert_ref_oid, negotiator, &opts);
 		return;
 	}
 
@@ -792,8 +795,12 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	 */
 	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
 	if (!args->deepen) {
-		refs_for_each_rawref(get_main_ref_store(the_repository),
-				     mark_complete_oid, NULL);
+		struct refs_for_each_ref_options opts = {
+			.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+		};
+
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      mark_complete_oid, NULL, &opts);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
diff --git a/refs.c b/refs.c
index b42a1bfa3f..5739804870 100644
--- a/refs.c
+++ b/refs.c
@@ -524,7 +524,10 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 		.indent = indent,
 		.dry_run = dry_run,
 	};
-	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
+	struct refs_for_each_ref_options opts = {
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
+	refs_for_each_ref_ext(refs, warn_if_dangling_symref, &data, &opts);
 }
 
 int refs_for_each_tag_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
@@ -1969,11 +1972,6 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_rawref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
-{
-	return refs_for_each_rawref_in(refs, "", fn, cb_data);
-}
-
 int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
 			    refs_for_each_cb cb, void *cb_data)
 {
diff --git a/refs.h b/refs.h
index c9f8d3e6cb..7a0c9c3693 100644
--- a/refs.h
+++ b/refs.h
@@ -542,7 +542,6 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 				 refs_for_each_cb fn, void *cb_data);
 
 /* can be used to learn about broken ref and symref */
-int refs_for_each_rawref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data);
 int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
 			    refs_for_each_cb fn, void *cb_data);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6c98e14414..ab96760781 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3149,6 +3149,9 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 					    struct ref_transaction *transaction,
 					    struct strbuf *err)
 {
+	struct refs_for_each_ref_options opts = {
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
 	size_t i;
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
@@ -3173,8 +3176,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	 * so here we really only check that none of the references
 	 * that we are creating already exists.
 	 */
-	if (refs_for_each_rawref(&refs->base, ref_present,
-				 &transaction->refnames))
+	if (refs_for_each_ref_ext(&refs->base, ref_present,
+				  &transaction->refnames, &opts))
 		BUG("initial ref transaction called with existing refs");
 
 	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,

-- 
2.53.0.414.gf7e9f6c205.dirty

