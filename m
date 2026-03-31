Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318CE3DD52C
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001489; cv=none; b=jcocktKiYSmEHiI4PxbUJnplEKfuZiKTJyXe0TKb+dfrq3EPV+2I3L5u6wJs/Wb2H/AFgjZV0Cs4nAwapFk3APPZd+jMMH+E7OcaNW0bDMBZTD0t7NlSNSjaFV/SATfMnUZxFbsgAE2z+Sc0fpIFkk4iP3wNUsZ+CXoTBo2qt6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001489; c=relaxed/simple;
	bh=ZFw0styXWN1YIgGp2NJf258HLmvpfQVaCzRa18pFF6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGiEiyjP/EqCjFjkEv0o/vKwr6IxZdNnO1il9EisPM0dM+dNjdYZnmyfBydp8qiMhj0PROaO2prPw7FTNIoyPLY4AZjo8FBfe2DBAMBWYnqXS7kuX65qCfZZhVcfZHr23NVWg5KnnFt4fnxtea+9hl/nBwpd+u6j94UqivJ/PTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N4rO+fYQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KwdQ1Uht; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N4rO+fYQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KwdQ1Uht"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 81475EC0258
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 19:58:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 19:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775001487;
	 x=1775087887; bh=lD4O/5Bo23NWnH5TOGtzvd9ajg0jQSTKSuUszlkFqFE=; b=
	N4rO+fYQbv09dh+r3ZyVrs72e7gL4QZtVosb+EG52wHXnLAPlUeAgaKdLTUm421t
	VRfIH3DA4MIRHWQY5J2BoWt5x0LhBQSXWpjDL/CLzMQDgTcQARL5Ipf7pQhIiWYr
	at6pt80y4SzzDyxtvUbjPehqHxd1hbNH0PQcgLO9d8F6bpX6kNx8hPm6PEHma4PC
	kfVgLHi1IEdgFD6QhxJn4QPn4Cvn8N0fsReNe2uPZxCETUoHcVxQ42mSX7umbXgD
	8NGiELaK/K1B3xnU94bDt3FaHiPsgEJ7fZ2upuPM1jX4SVTwY1SS7ZSO2Ft12V1a
	eWQvYWWhzFvNGKb1AXVrPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775001487; x=
	1775087887; bh=lD4O/5Bo23NWnH5TOGtzvd9ajg0jQSTKSuUszlkFqFE=; b=K
	wdQ1UhtqRwI79s4whTfnhGLNOBCL49jPsN/SSvD/sFjiGRXfDg4VYjKNioGufCCN
	rbxEGslTUsyXHxDk5/AUDIXvKW8U6nRXJ+kMr0ZA+a3goV6Bfdb40PqrVHMPEma7
	myNm+ZIhSijZ6jtCUvZzKbwsSZML8ESG6Q/K8SSSm/ExgPFPEzT4Ee/PPyum/c/E
	rmPTOfoh3datXZv9fnkR3GZM7mGw1T9Xir7ZaKNuTzRx4igSCpCQiVC24DsgxSDi
	+dKviK/T50dVuJyS7sJdSo06jQV89yJxXqPFooIuHTojU1nTQi66EswibnhKPhZQ
	OJhM8JnucJi8lSsOJr2KQ==
X-ME-Sender: <xms:j1_MaWmd2vqJnWhRG7tkVoMsJEUZosvhe4RfAXzxMzusBtqe2hQCHw>
    <xme:j1_MaUxw7QkwSPW6JMLIOLQpz8krylOmYTugITAT54kGyqGBNPv2G1GLA-Y6cG5XN
    L9o8AZ0uVl2jJd85u173nKVIToZwcjmX7Nguj3tsqF5nnYsz8Pfew>
X-ME-Received: <xmr:j1_MaaSDL3fIOom1fN5EDRIBPPUNdL_nB5PGZ-b0qXBe8QgSdX6jKUB5ccjmbp-N_D_Stmae8rYXR_16_4lXlY9POXLIrfK7MHag0JBR9D8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:j1_MafvlJWvfQ9NnDWMHO_1_49vr3gnImjJ-In-_Xs5CSXQb-2yf1w>
    <xmx:j1_MaUtjS_oi1XUREZOX_GkHaqQNOpQMbXO7fF-l-RHbOFGlbAsRQg>
    <xmx:j1_MadyVHaJ7iApoJZADeaf8v5kQLNeiMC52lbkg2Zh6GJJuN2zMag>
    <xmx:j1_MaSiAC5kEGvo4TsXSyFRBDAvAwGLTRm8vVnalCiAQXy5DaBGzlQ>
    <xmx:j1_MaS2qGzjkHJzSe0OdcjO9c2qewWV8NzXYiL6tn3VLW7Otj2fHShCd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 19:58:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c979bc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 23:58:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Apr 2026 01:57:50 +0200
Subject: [PATCH 5/6] odb: rename `odb_has_object()` flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-pks-odb-cleanups-v1-5-89adba9ada68@pks.im>
References: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
In-Reply-To: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Rename `odb_has_object()` flags to be properly prefixed with the
function name.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c       | 2 +-
 builtin/fetch.c          | 4 ++--
 builtin/fsck.c           | 2 +-
 builtin/index-pack.c     | 2 +-
 builtin/receive-pack.c   | 2 +-
 builtin/remote.c         | 2 +-
 builtin/show-ref.c       | 2 +-
 builtin/unpack-objects.c | 2 +-
 cache-tree.c             | 8 ++++----
 fetch-pack.c             | 4 ++--
 http-push.c              | 8 ++++----
 http-walker.c            | 4 ++--
 list-objects.c           | 2 +-
 notes.c                  | 2 +-
 object-file.c            | 2 +-
 odb.c                    | 6 +++---
 odb.h                    | 8 ++++----
 reflog.c                 | 2 +-
 refs.c                   | 2 +-
 remote.c                 | 2 +-
 shallow.c                | 6 +++---
 walker.c                 | 2 +-
 22 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index cd13a3a89f..d9fbad5358 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -161,7 +161,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 
 	case 'e':
 		ret = !odb_has_object(the_repository->objects, &oid,
-				      HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR);
+				      ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR);
 		goto cleanup;
 
 	case 'w':
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4795b2a13c..a22c319467 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -946,7 +946,7 @@ static int update_local_ref(struct ref *ref,
 	int fast_forward = 0;
 
 	if (!odb_has_object(the_repository->objects, &ref->new_oid,
-			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+			    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
 
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
@@ -1396,7 +1396,7 @@ static int check_exist_and_connected(struct ref *ref_map)
 	 */
 	for (r = rm; r; r = r->next) {
 		if (!odb_has_object(the_repository->objects, &r->old_oid,
-				    HAS_OBJECT_RECHECK_PACKED))
+				    ODB_HAS_OBJECT_RECHECK_PACKED))
 			return -1;
 	}
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9bab32effe..4bd0faeff1 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -163,7 +163,7 @@ static int mark_object(struct object *obj, enum object_type type,
 
 	if (!(obj->flags & HAS_OBJ)) {
 		if (parent && !odb_has_object(the_repository->objects, &obj->oid,
-					      HAS_OBJECT_RECHECK_PACKED)) {
+					      ODB_HAS_OBJECT_RECHECK_PACKED)) {
 			printf_ln(_("broken link from %7s %s\n"
 				    "              to %7s %s"),
 				  printable_type(&parent->oid, parent->type),
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d1e47279a8..d96d0eb8cf 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -891,7 +891,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 	if (startup_info->have_repository) {
 		read_lock();
 		collision_test_needed = odb_has_object(the_repository->objects, oid,
-						       HAS_OBJECT_FETCH_PROMISOR);
+						       ODB_HAS_OBJECT_FETCH_PROMISOR);
 		read_unlock();
 	}
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e34edff406..32b0223884 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1546,7 +1546,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 	if (!is_null_oid(new_oid) &&
 	    !odb_has_object(the_repository->objects, new_oid,
-			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+			    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR)) {
 		error("unpack should have generated %s, "
 		      "but I can't find it!", oid_to_hex(new_oid));
 		ret = "bad pack";
diff --git a/builtin/remote.c b/builtin/remote.c
index 0fddaa1773..de989ea3ba 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -473,7 +473,7 @@ static int get_push_ref_states(const struct ref *remote_refs,
 		else if (is_null_oid(&ref->old_oid))
 			info->status = PUSH_STATUS_CREATE;
 		else if (odb_has_object(the_repository->objects, &ref->old_oid,
-					HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) &&
+					ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR) &&
 			 ref_newer(&ref->new_oid, &ref->old_oid))
 			info->status = PUSH_STATUS_FASTFORWARD;
 		else
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 5d31acea7c..d508441632 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -37,7 +37,7 @@ static void show_one(const struct show_one_options *opts,
 	struct object_id peeled;
 
 	if (!odb_has_object(the_repository->objects, ref->oid,
-			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+			    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 		die("git show-ref: bad ref %s (%s)", ref->name,
 		    oid_to_hex(ref->oid));
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6fc64e9e4b..871fc8fff5 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -449,7 +449,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		if (!delta_data)
 			return;
 		if (odb_has_object(the_repository->objects, &base_oid,
-				   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+				   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 			; /* Ok we have this one */
 		else if (resolve_against_held(nr, &base_oid,
 					      delta_data, delta_size))
diff --git a/cache-tree.c b/cache-tree.c
index 60059edfb0..fe41068c34 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -239,7 +239,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
 		return 0;
 	if (it->entry_count < 0 ||
 	    odb_has_object(the_repository->objects, &it->oid,
-			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+			   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
 		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
@@ -292,7 +292,7 @@ static int update_one(struct cache_tree *it,
 
 	if (0 <= it->entry_count &&
 	    odb_has_object(the_repository->objects, &it->oid,
-			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+			   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 		return it->entry_count;
 
 	/*
@@ -400,7 +400,7 @@ static int update_one(struct cache_tree *it,
 		if (is_null_oid(oid) ||
 		    (!ce_missing_ok &&
 		     !odb_has_object(the_repository->objects, oid,
-				     HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))) {
+				     ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
@@ -448,7 +448,7 @@ static int update_one(struct cache_tree *it,
 		struct object_id oid;
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
 				 OBJ_TREE, &oid);
-		if (odb_has_object(the_repository->objects, &oid, HAS_OBJECT_RECHECK_PACKED))
+		if (odb_has_object(the_repository->objects, &oid, ODB_HAS_OBJECT_RECHECK_PACKED))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index 6ecd468ef7..0f24722a70 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -145,7 +145,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 	if (commit) {
 		if (mark_tags_complete_and_check_obj_db) {
 			if (!odb_has_object(the_repository->objects, oid,
-					    HAS_OBJECT_RECHECK_PACKED))
+					    ODB_HAS_OBJECT_RECHECK_PACKED))
 				die_in_commit_graph_only(oid);
 		}
 		return commit;
@@ -2013,7 +2013,7 @@ static void update_shallow(struct fetch_pack_args *args,
 		struct object_id *oid = si->shallow->oid;
 		for (i = 0; i < si->shallow->nr; i++)
 			if (odb_has_object(the_repository->objects, &oid[i],
-					   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+					   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 				oid_array_append(&extra, &oid[i]);
 		if (extra.nr) {
 			setup_alternate_shallow(&shallow_lock,
diff --git a/http-push.c b/http-push.c
index 9ae6062198..06c3acbb5d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1449,7 +1449,7 @@ static void one_remote_ref(const char *refname)
 	 */
 	if (repo->can_update_info_refs &&
 	    !odb_has_object(the_repository->objects, &ref->old_oid,
-			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+			    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR)) {
 		obj = lookup_unknown_object(the_repository, &ref->old_oid);
 		fprintf(stderr,	"  fetch %s for %s\n",
 			oid_to_hex(&ref->old_oid), refname);
@@ -1655,7 +1655,7 @@ static int delete_remote_branch(const char *pattern, int force)
 		if (is_null_oid(&head_oid))
 			return error("Unable to resolve remote HEAD");
 		if (!odb_has_object(the_repository->objects, &head_oid,
-				    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+				    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 			return error("Remote HEAD resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", oid_to_hex(&head_oid));
 
 		/* Remote branch must resolve to a known object */
@@ -1663,7 +1663,7 @@ static int delete_remote_branch(const char *pattern, int force)
 			return error("Unable to resolve remote branch %s",
 				     remote_ref->name);
 		if (!odb_has_object(the_repository->objects, &remote_ref->old_oid,
-				    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+				    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 			return error("Remote branch %s resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", remote_ref->name, oid_to_hex(&remote_ref->old_oid));
 
 		/* Remote branch must be an ancestor of remote HEAD */
@@ -1886,7 +1886,7 @@ int cmd_main(int argc, const char **argv)
 		    !is_null_oid(&ref->old_oid) &&
 		    !ref->force) {
 			if (!odb_has_object(the_repository->objects, &ref->old_oid,
-					    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) ||
+					    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR) ||
 			    !ref_newer(&ref->peer_ref->new_oid,
 				       &ref->old_oid)) {
 				/*
diff --git a/http-walker.c b/http-walker.c
index e886e64866..1b6d496548 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -139,7 +139,7 @@ static int fill_active_slot(void *data UNUSED)
 		obj_req = list_entry(pos, struct object_request, node);
 		if (obj_req->state == WAITING) {
 			if (odb_has_object(the_repository->objects, &obj_req->oid,
-					   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+					   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 				obj_req->state = COMPLETE;
 			else {
 				start_object_request(obj_req);
@@ -495,7 +495,7 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 		return error("Couldn't find request for %s in the queue", hex);
 
 	if (odb_has_object(the_repository->objects, &obj_req->oid,
-			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+			   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR)) {
 		if (obj_req->req)
 			abort_http_object_request(&obj_req->req);
 		abort_object_request(obj_req);
diff --git a/list-objects.c b/list-objects.c
index 91b23e22f7..724d723c48 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -75,7 +75,7 @@ static void process_blob(struct traversal_context *ctx,
 	 */
 	if (ctx->revs->exclude_promisor_objects &&
 	    !odb_has_object(the_repository->objects, &obj->oid,
-			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) &&
+			    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR) &&
 	    is_promisor_object(ctx->revs->repo, &obj->oid))
 		return;
 
diff --git a/notes.c b/notes.c
index 51a7ef9f83..8f315e2a00 100644
--- a/notes.c
+++ b/notes.c
@@ -796,7 +796,7 @@ static int prune_notes_helper(const struct object_id *object_oid,
 	struct note_delete_list *n;
 
 	if (odb_has_object(the_repository->objects, object_oid,
-			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+			   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 		return 0; /* nothing to do for this note */
 
 	/* failed to find object => prune this note */
diff --git a/object-file.c b/object-file.c
index 2146104de8..98a4678ca4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1378,7 +1378,7 @@ static int already_written(struct odb_transaction_files *transaction,
 {
 	/* The object may already exist in the repository */
 	if (odb_has_object(transaction->base.source->odb, oid,
-			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+			   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 		return 1;
 
 	/* Might want to keep the list sorted */
diff --git a/odb.c b/odb.c
index 8220661356..9b28fe25ef 100644
--- a/odb.c
+++ b/odb.c
@@ -872,15 +872,15 @@ void *odb_read_object_peeled(struct object_database *odb,
 }
 
 int odb_has_object(struct object_database *odb, const struct object_id *oid,
-		   enum has_object_flags flags)
+		   enum odb_has_object_flags flags)
 {
 	unsigned object_info_flags = 0;
 
 	if (!startup_info->have_repository)
 		return 0;
-	if (!(flags & HAS_OBJECT_RECHECK_PACKED))
+	if (!(flags & ODB_HAS_OBJECT_RECHECK_PACKED))
 		object_info_flags |= OBJECT_INFO_QUICK;
-	if (!(flags & HAS_OBJECT_FETCH_PROMISOR))
+	if (!(flags & ODB_HAS_OBJECT_FETCH_PROMISOR))
 		object_info_flags |= OBJECT_INFO_SKIP_FETCH_OBJECT;
 
 	return odb_read_object_info_extended(odb, oid, NULL, object_info_flags) >= 0;
diff --git a/odb.h b/odb.h
index 9aadc1177a..8d739e118b 100644
--- a/odb.h
+++ b/odb.h
@@ -395,11 +395,11 @@ int odb_read_object_info(struct object_database *odb,
 			 const struct object_id *oid,
 			 unsigned long *sizep);
 
-enum has_object_flags {
+enum odb_has_object_flags {
 	/* Retry packed storage after checking packed and loose storage */
-	HAS_OBJECT_RECHECK_PACKED = (1 << 0),
+	ODB_HAS_OBJECT_RECHECK_PACKED = (1 << 0),
 	/* Allow fetching the object in case the repository has a promisor remote. */
-	HAS_OBJECT_FETCH_PROMISOR = (1 << 1),
+	ODB_HAS_OBJECT_FETCH_PROMISOR = (1 << 1),
 };
 
 /*
@@ -408,7 +408,7 @@ enum has_object_flags {
  */
 int odb_has_object(struct object_database *odb,
 		   const struct object_id *oid,
-		   enum has_object_flags flags);
+		   enum odb_has_object_flags flags);
 
 int odb_freshen_object(struct object_database *odb,
 		       const struct object_id *oid);
diff --git a/reflog.c b/reflog.c
index 1460ae9d0d..82337078d0 100644
--- a/reflog.c
+++ b/reflog.c
@@ -168,7 +168,7 @@ static int tree_is_complete(const struct object_id *oid)
 	complete = 1;
 	while (tree_entry(&desc, &entry)) {
 		if (!odb_has_object(the_repository->objects, &entry.oid,
-				HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) ||
+				ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR) ||
 		    (S_ISDIR(entry.mode) && !tree_is_complete(&entry.oid))) {
 			tree->object.flags |= INCOMPLETE;
 			complete = 0;
diff --git a/refs.c b/refs.c
index 685a0c247b..97cdea1f76 100644
--- a/refs.c
+++ b/refs.c
@@ -425,7 +425,7 @@ int ref_resolves_to_object(const char *refname,
 	if (flags & REF_ISBROKEN)
 		return 0;
 	if (!odb_has_object(repo->objects, oid,
-			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+			    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR)) {
 		error(_("%s does not point to a valid object!"), refname);
 		return 0;
 	}
diff --git a/remote.c b/remote.c
index 7ca2a6501b..a664cd166a 100644
--- a/remote.c
+++ b/remote.c
@@ -1723,7 +1723,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
 			if (starts_with(ref->name, "refs/tags/"))
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
-			else if (!odb_has_object(the_repository->objects, &ref->old_oid, HAS_OBJECT_RECHECK_PACKED))
+			else if (!odb_has_object(the_repository->objects, &ref->old_oid, ODB_HAS_OBJECT_RECHECK_PACKED))
 				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
 			else if (!lookup_commit_reference_gently(the_repository, &ref->old_oid, 1) ||
 				 !lookup_commit_reference_gently(the_repository, &ref->new_oid, 1))
diff --git a/shallow.c b/shallow.c
index 7a3dd56795..a8ad92e303 100644
--- a/shallow.c
+++ b/shallow.c
@@ -360,7 +360,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 		return 0;
 	if (data->flags & QUICK) {
 		if (!odb_has_object(the_repository->objects, &graft->oid,
-				    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+				    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 			return 0;
 	} else if (data->flags & SEEN_ONLY) {
 		struct commit *c = lookup_commit(the_repository, &graft->oid);
@@ -528,7 +528,7 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 	ALLOC_ARRAY(info->theirs, sa->nr);
 	for (size_t i = 0; i < sa->nr; i++) {
 		if (odb_has_object(the_repository->objects, sa->oid + i,
-				   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+				   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR)) {
 			struct commit_graft *graft;
 			graft = lookup_commit_graft(the_repository,
 						    &sa->oid[i]);
@@ -567,7 +567,7 @@ void remove_nonexistent_theirs_shallow(struct shallow_info *info)
 		if (i != dst)
 			info->theirs[dst] = info->theirs[i];
 		if (odb_has_object(the_repository->objects, oid + info->theirs[i],
-				   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+				   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
 			dst++;
 	}
 	info->nr_theirs = dst;
diff --git a/walker.c b/walker.c
index 91332539d3..e98eb6da53 100644
--- a/walker.c
+++ b/walker.c
@@ -155,7 +155,7 @@ static int process(struct walker *walker, struct object *obj)
 	obj->flags |= SEEN;
 
 	if (odb_has_object(the_repository->objects, &obj->oid,
-			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+			   ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR)) {
 		/* We already have it, so we should scan it now. */
 		obj->flags |= TO_SCAN;
 	}

-- 
2.53.0.1185.g05d4b7b318.dirty

