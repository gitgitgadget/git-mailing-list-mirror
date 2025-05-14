Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437A20298D
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199568; cv=none; b=cHpv4rYIIO5D66wPMhd/Q8FIQBdnqDQvzVMFiDs3KeKPNykxm2b37kHJW0YPvo/mbnwiwb6QKinLuoCtPB7d2/UvyITsBa4grGChLeCXDheczeMMbZDcbrfRgsCP1m2BWQmj7oWkRQOXd4C+j75gra/qoy0dijWVLrWG35OVGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199568; c=relaxed/simple;
	bh=rLTU3LL4YPvSKNhPpt8GaHXX2kWl+oogoBv2PWKa8pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMl1qCMFyn5CrJ52pfPGsRcLrN7iQSP4bOkxOh99a1st1MrKMWjG4ad6u0jkrH6Pu6qJdJe7k+pCNTV7K2yv5koFF85bnZQLuIaOciPclQZAMPI6bi5e9oboXU9p8xVgk7SOCBMgCBfSq2DMK3/FgyxZb4UOcH/uICg2Vun37Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qKnYu71k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XBcGbmYQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qKnYu71k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBcGbmYQ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B2CB1140088;
	Wed, 14 May 2025 01:12:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 14 May 2025 01:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199565;
	 x=1747285965; bh=ZEZtU3Bzx//5hAaM/cJdPfn55S+aHLlw/wjjLCN40dA=; b=
	qKnYu71kVnjdNaYGvg28h0z6Nz6GHUeii658c3wyCXCps0l1S/u2pJ6dqxzLkGVy
	muXgFCT2nfoyLhKq5pWjJaldKKGOM7RHQCGz4o52gndZ0euTbjt0HHa54JDDqj29
	hiCcUWVQuUbWORYVPDpX5gsTtxGQGf0yHbEE+gyDTeIVzTk1NRXFNvW5BaCw9a6+
	6uWsKk0XalPXp9qX3ErU1RAEBVQWHzZ2qePK7a51CAQ1o8F6DcxLDX8ICfQ10VfB
	KS0ZEjRxTrkWIAqxO8TNom5OVJI4PmlDTBSpElk8wYHScCOC/2YdB/QI4UL2XXhR
	q1AAG8wnnnrzbBR4m4Iobw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199565; x=
	1747285965; bh=ZEZtU3Bzx//5hAaM/cJdPfn55S+aHLlw/wjjLCN40dA=; b=X
	BcGbmYQ8p9X6Dzh0Rc7+RiRGTHr2Ss9YiW4/WwwTyBX+mzr2HE3eNVom7sNB5eg7
	/Fulk6zWDcXzueK3q6hhzuWVDLZwfk9lqKJlZ0rtNlqwZM/dqqMdiOp/3zSj02R+
	6HU6EUfuecbueQx9LjdEKBFxr9gsYEl2gG7xuLIs99FbsW6zeXP4vwBWl+lhc9E7
	Lg7xAt8wigf64gFQP2eU1X+Z/VZ06w/dVO/mUgtIZVVzRVvQpjqzT6FRlqGY5Oxu
	pVHlPbAAU51r3nt+/i4IvluCt5K2C4SEFHwwT4mGqrE3LJ400fKoapLFWL9aUCdt
	LuLZGIX0ZaTaFglTr/LVw==
X-ME-Sender: <xms:TSYkaJ2n86uFQT1YJmOZv3XsG9oVLpkWbVT4YxiwrZwzhFnBg2QMZQ>
    <xme:TSYkaAGIBxLOmtqLUFOnMy7ai4PH--4EOLPuCR_71DBlBPXjoDrfsLnSDwWMxL6JY
    2Jp4hRqqldwsVIOAw>
X-ME-Received: <xmr:TSYkaJ4msqfs18sddim3YLlhOoikoOQqIxN1hM4mqrj8A-cMXOkGM7P_pf0SkOcwmQkc-L9Z2WzAQ6sxhsOaQElTK6mvgh9zDtMjRe7fNzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtg
    homh
X-ME-Proxy: <xmx:TSYkaG3RF1hd3PKzolg_2qNJt6rHhYgbgVMmb9ho_jyl1q5ovc5jVA>
    <xmx:TSYkaMHdC7vsViZ_M5RrJuM_nP1q87WfWWrN6t_p-fCvjzpkB4-C8w>
    <xmx:TSYkaH9tG5ramavS9fy_TSenk0mQHnbBI89m5rJx_fLvnS-bb8XKzQ>
    <xmx:TSYkaJlKv8fb1vY1Lyrdeh3na1TzgE8zAIbUPBkKg3pZlykAePnsag>
    <xmx:TSYkaIo-Y9bFQ1-raU4vqWLqq46wn1-RT601aeVeUSbjKstyZUtJxi1c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db901460 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 May 2025 07:12:38 +0200
Subject: [PATCH v3 15/17] odb: rename `has_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-15-47df1d4ead22@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Rename `has_object()` to `odb_has_object()` to match other functions
related to the object database and our modern coding guidelines.

Introduce a compatibility wrapper so that any in-flight topics will
continue to compile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c                  |  2 +-
 builtin/backfill.c       |  4 ++--
 builtin/cat-file.c       |  4 ++--
 builtin/clone.c          |  2 +-
 builtin/fetch.c          | 17 +++++++++--------
 builtin/fsck.c           |  2 +-
 builtin/index-pack.c     |  4 ++--
 builtin/pack-objects.c   |  4 ++--
 builtin/receive-pack.c   |  4 ++--
 builtin/remote.c         |  4 ++--
 builtin/show-ref.c       |  4 ++--
 builtin/unpack-objects.c |  4 ++--
 bulk-checkin.c           |  4 ++--
 cache-tree.c             | 15 ++++++++-------
 commit-graph.c           |  2 +-
 commit.c                 |  2 +-
 fetch-pack.c             |  8 ++++----
 http-push.c              | 14 ++++++++------
 http-walker.c            |  8 ++++----
 list-objects.c           |  4 ++--
 notes.c                  |  4 ++--
 odb.c                    |  6 +++---
 odb.h                    | 12 ++++++++++--
 reflog.c                 |  2 +-
 refs.c                   |  3 ++-
 remote.c                 |  2 +-
 send-pack.c              |  2 +-
 shallow.c                | 12 ++++++------
 upload-pack.c            |  2 +-
 walker.c                 |  4 ++--
 30 files changed, 87 insertions(+), 74 deletions(-)

diff --git a/apply.c b/apply.c
index 56cd0540350..7fb56517649 100644
--- a/apply.c
+++ b/apply.c
@@ -3204,7 +3204,7 @@ static int apply_binary(struct apply_state *state,
 		return 0; /* deletion patch */
 	}
 
-	if (has_object(the_repository, &oid, 0)) {
+	if (odb_has_object(the_repository->objects, &oid, 0)) {
 		/* We already have the postimage */
 		enum object_type type;
 		unsigned long size;
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 0b49baa39fa..80056abe473 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -67,8 +67,8 @@ static int fill_missing_blobs(const char *path UNUSED,
 		return 0;
 
 	for (size_t i = 0; i < list->nr; i++) {
-		if (!has_object(ctx->repo, &list->oid[i],
-				OBJECT_INFO_FOR_PREFETCH))
+		if (!odb_has_object(ctx->repo->objects, &list->oid[i],
+				    OBJECT_INFO_FOR_PREFETCH))
 			oid_array_append(&ctx->current_batch, &list->oid[i]);
 	}
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d6b9afca06e..571b5cc2ad5 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -169,8 +169,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		goto cleanup;
 
 	case 'e':
-		ret = !has_object(the_repository, &oid,
-				  HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR);
+		ret = !odb_has_object(the_repository->objects, &oid,
+				      HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR);
 		goto cleanup;
 
 	case 'w':
diff --git a/builtin/clone.c b/builtin/clone.c
index 3aabdf6570b..6d08abed37c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -506,7 +506,7 @@ static void write_followtags(const struct ref *refs, const char *msg)
 			continue;
 		if (ends_with(ref->name, "^{}"))
 			continue;
-		if (!has_object(the_repository, &ref->old_oid, 0))
+		if (!odb_has_object(the_repository->objects, &ref->old_oid, 0))
 			continue;
 		refs_update_ref(get_main_ref_store(the_repository), msg,
 				ref->name, &ref->old_oid, NULL, 0,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 82e9603ccab..2000299bcc5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -366,9 +366,9 @@ static void find_non_local_tags(const struct ref *refs,
 		 */
 		if (ends_with(ref->name, "^{}")) {
 			if (item &&
-			    !has_object(the_repository, &ref->old_oid, 0) &&
+			    !odb_has_object(the_repository->objects, &ref->old_oid, 0) &&
 			    !oidset_contains(&fetch_oids, &ref->old_oid) &&
-			    !has_object(the_repository, &item->oid, 0) &&
+			    !odb_has_object(the_repository->objects, &item->oid, 0) &&
 			    !oidset_contains(&fetch_oids, &item->oid))
 				clear_item(item);
 			item = NULL;
@@ -382,7 +382,7 @@ static void find_non_local_tags(const struct ref *refs,
 		 * fetch.
 		 */
 		if (item &&
-		    !has_object(the_repository, &item->oid, 0) &&
+		    !odb_has_object(the_repository->objects, &item->oid, 0) &&
 		    !oidset_contains(&fetch_oids, &item->oid))
 			clear_item(item);
 
@@ -403,7 +403,7 @@ static void find_non_local_tags(const struct ref *refs,
 	 * checked to see if it needs fetching.
 	 */
 	if (item &&
-	    !has_object(the_repository, &item->oid, 0) &&
+	    !odb_has_object(the_repository->objects, &item->oid, 0) &&
 	    !oidset_contains(&fetch_oids, &item->oid))
 		clear_item(item);
 
@@ -910,8 +910,8 @@ static int update_local_ref(struct ref *ref,
 	struct commit *current = NULL, *updated;
 	int fast_forward = 0;
 
-	if (!has_object(the_repository, &ref->new_oid,
-			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+	if (!odb_has_object(the_repository->objects, &ref->new_oid,
+			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
 
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
@@ -1330,7 +1330,8 @@ static int check_exist_and_connected(struct ref *ref_map)
 	 * we need all direct targets to exist.
 	 */
 	for (r = rm; r; r = r->next) {
-		if (!has_object(the_repository, &r->old_oid, HAS_OBJECT_RECHECK_PACKED))
+		if (!odb_has_object(the_repository->objects, &r->old_oid,
+				    HAS_OBJECT_RECHECK_PACKED))
 			return -1;
 	}
 
@@ -1485,7 +1486,7 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 			struct object_id oid;
 			if (repo_get_oid(the_repository, s, &oid))
 				die(_("%s is not a valid object"), s);
-			if (!has_object(the_repository, &oid, 0))
+			if (!odb_has_object(the_repository->objects, &oid, 0))
 				die(_("the object %s does not exist"), s);
 			oid_array_append(oids, &oid);
 			continue;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 08a79fe044d..74bfa182597 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -161,7 +161,7 @@ static int mark_object(struct object *obj, enum object_type type,
 		return 0;
 
 	if (!(obj->flags & HAS_OBJ)) {
-		if (parent && !has_object(the_repository, &obj->oid, 1)) {
+		if (parent && !odb_has_object(the_repository->objects, &obj->oid, 1)) {
 			printf_ln(_("broken link from %7s %s\n"
 				    "              to %7s %s"),
 				  printable_type(&parent->oid, parent->type),
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d33392cab65..0aa2f099cbe 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -893,8 +893,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 
 	if (startup_info->have_repository) {
 		read_lock();
-		collision_test_needed = has_object(the_repository, oid,
-						   HAS_OBJECT_FETCH_PROMISOR);
+		collision_test_needed = odb_has_object(the_repository->objects, oid,
+						       HAS_OBJECT_FETCH_PROMISOR);
 		read_unlock();
 	}
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 580a5c1996b..06bdeb4223b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3968,7 +3968,7 @@ static void show_object__ma_allow_any(struct object *obj, const char *name, void
 	 * Quietly ignore ALL missing objects.  This avoids problems with
 	 * staging them now and getting an odd error later.
 	 */
-	if (!has_object(the_repository, &obj->oid, 0))
+	if (!odb_has_object(the_repository->objects, &obj->oid, 0))
 		return;
 
 	show_object(obj, name, data);
@@ -3982,7 +3982,7 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
 	 * Quietly ignore EXPECTED missing objects.  This avoids problems with
 	 * staging them now and getting an odd error later.
 	 */
-	if (!has_object(the_repository, &obj->oid, 0) &&
+	if (!odb_has_object(the_repository->objects, &obj->oid, 0) &&
 	    is_promisor_object(to_pack.repo, &obj->oid))
 		return;
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8c157ea7d1b..27684dce3a4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1508,8 +1508,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 
 	if (!is_null_oid(new_oid) &&
-	    !has_object(the_repository, new_oid,
-			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+	    !odb_has_object(the_repository->objects, new_oid,
+			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		error("unpack should have generated %s, "
 		      "but I can't find it!", oid_to_hex(new_oid));
 		ret = "bad pack";
diff --git a/builtin/remote.c b/builtin/remote.c
index ac5b8d2a1a6..7cbda285ebe 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -454,8 +454,8 @@ static int get_push_ref_states(const struct ref *remote_refs,
 			info->status = PUSH_STATUS_UPTODATE;
 		else if (is_null_oid(&ref->old_oid))
 			info->status = PUSH_STATUS_CREATE;
-		else if (has_object(the_repository, &ref->old_oid,
-				    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) &&
+		else if (odb_has_object(the_repository->objects, &ref->old_oid,
+					HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) &&
 			 ref_newer(&ref->new_oid, &ref->old_oid))
 			info->status = PUSH_STATUS_FASTFORWARD;
 		else
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 90ec1de78f9..117709cb076 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -35,8 +35,8 @@ static void show_one(const struct show_one_options *opts,
 	const char *hex;
 	struct object_id peeled;
 
-	if (!has_object(the_repository, oid,
-			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+	if (!odb_has_object(the_repository->objects, oid,
+			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		die("git show-ref: bad ref %s (%s)", refname,
 		    oid_to_hex(oid));
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4bc6575a574..a69d59eb50c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -449,8 +449,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		delta_data = get_data(delta_size);
 		if (!delta_data)
 			return;
-		if (has_object(the_repository, &base_oid,
-			       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+		if (odb_has_object(the_repository->objects, &base_oid,
+				   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			; /* Ok we have this one */
 		else if (resolve_against_held(nr, &base_oid,
 					      delta_data, delta_size))
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 55406a539e7..16df86c0ba8 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -130,8 +130,8 @@ static void flush_batch_fsync(void)
 static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
 {
 	/* The object may already exist in the repository */
-	if (has_object(the_repository, oid,
-		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+	if (odb_has_object(the_repository->objects, oid,
+			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 1;
 
 	/* Might want to keep the list sorted */
diff --git a/cache-tree.c b/cache-tree.c
index 9786b32b3a1..a4bc14ad15c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -239,8 +239,8 @@ int cache_tree_fully_valid(struct cache_tree *it)
 	if (!it)
 		return 0;
 	if (it->entry_count < 0 ||
-	    has_object(the_repository, &it->oid,
-		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+	    odb_has_object(the_repository->objects, &it->oid,
+			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
 		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
@@ -292,8 +292,8 @@ static int update_one(struct cache_tree *it,
 	}
 
 	if (0 <= it->entry_count &&
-	    has_object(the_repository, &it->oid,
-		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+	    odb_has_object(the_repository->objects, &it->oid,
+			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return it->entry_count;
 
 	/*
@@ -399,8 +399,9 @@ static int update_one(struct cache_tree *it,
 		ce_missing_ok = mode == S_IFGITLINK || missing_ok ||
 			!must_check_existence(ce);
 		if (is_null_oid(oid) ||
-		    (!ce_missing_ok && !has_object(the_repository, oid,
-						   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))) {
+		    (!ce_missing_ok &&
+		     !odb_has_object(the_repository->objects, oid,
+				     HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
@@ -448,7 +449,7 @@ static int update_one(struct cache_tree *it,
 		struct object_id oid;
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
 				 OBJ_TREE, &oid);
-		if (has_object(the_repository, &oid, HAS_OBJECT_RECHECK_PACKED))
+		if (odb_has_object(the_repository->objects, &oid, HAS_OBJECT_RECHECK_PACKED))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
diff --git a/commit-graph.c b/commit-graph.c
index 84cfaf87639..cb81a5ce228 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1040,7 +1040,7 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
 		return NULL;
 	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
 		return NULL;
-	if (commit_graph_paranoia && !has_object(repo, id, 0))
+	if (commit_graph_paranoia && !odb_has_object(repo->objects, id, 0))
 		return NULL;
 
 	commit = lookup_commit(repo, id);
diff --git a/commit.c b/commit.c
index 28ee6b73ae6..15115125c36 100644
--- a/commit.c
+++ b/commit.c
@@ -575,7 +575,7 @@ int repo_parse_commit_internal(struct repository *r,
 		if (commit_graph_paranoia == -1)
 			commit_graph_paranoia = git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 0);
 
-		if (commit_graph_paranoia && !has_object(r, &item->object.oid, 0)) {
+		if (commit_graph_paranoia && !odb_has_object(r->objects, &item->object.oid, 0)) {
 			unparse_commit(r, &item->object.oid);
 			return quiet_on_missing ? -1 :
 				error(_("commit %s exists in commit-graph but not in the object database"),
diff --git a/fetch-pack.c b/fetch-pack.c
index 0f5de1c94d1..5e74235fc06 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -142,7 +142,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 	commit = lookup_commit_in_graph(the_repository, oid);
 	if (commit) {
 		if (mark_tags_complete_and_check_obj_db) {
-			if (!has_object(the_repository, oid, 0))
+			if (!odb_has_object(the_repository->objects, oid, 0))
 				die_in_commit_graph_only(oid);
 		}
 		return commit;
@@ -770,7 +770,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		if (!commit) {
 			struct object *o;
 
-			if (!has_object(the_repository, &ref->old_oid, 0))
+			if (!odb_has_object(the_repository->objects, &ref->old_oid, 0))
 				continue;
 			o = parse_object(the_repository, &ref->old_oid);
 			if (!o || o->type != OBJ_COMMIT)
@@ -1984,8 +1984,8 @@ static void update_shallow(struct fetch_pack_args *args,
 		struct oid_array extra = OID_ARRAY_INIT;
 		struct object_id *oid = si->shallow->oid;
 		for (i = 0; i < si->shallow->nr; i++)
-			if (has_object(the_repository, &oid[i],
-				       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+			if (odb_has_object(the_repository->objects, &oid[i],
+					   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 				oid_array_append(&extra, &oid[i]);
 		if (extra.nr) {
 			setup_alternate_shallow(&shallow_lock,
diff --git a/http-push.c b/http-push.c
index 9481825abfb..beb41732fb6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1447,8 +1447,8 @@ static void one_remote_ref(const char *refname)
 	 * may be required for updating server info later.
 	 */
 	if (repo->can_update_info_refs &&
-	    !has_object(the_repository, &ref->old_oid,
-			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+	    !odb_has_object(the_repository->objects, &ref->old_oid,
+			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		obj = lookup_unknown_object(the_repository, &ref->old_oid);
 		fprintf(stderr,	"  fetch %s for %s\n",
 			oid_to_hex(&ref->old_oid), refname);
@@ -1653,14 +1653,16 @@ static int delete_remote_branch(const char *pattern, int force)
 			return error("Remote HEAD symrefs too deep");
 		if (is_null_oid(&head_oid))
 			return error("Unable to resolve remote HEAD");
-		if (!has_object(the_repository, &head_oid, HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+		if (!odb_has_object(the_repository->objects, &head_oid,
+				    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			return error("Remote HEAD resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", oid_to_hex(&head_oid));
 
 		/* Remote branch must resolve to a known object */
 		if (is_null_oid(&remote_ref->old_oid))
 			return error("Unable to resolve remote branch %s",
 				     remote_ref->name);
-		if (!has_object(the_repository, &remote_ref->old_oid, HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+		if (!odb_has_object(the_repository->objects, &remote_ref->old_oid,
+				    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			return error("Remote branch %s resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", remote_ref->name, oid_to_hex(&remote_ref->old_oid));
 
 		/* Remote branch must be an ancestor of remote HEAD */
@@ -1881,8 +1883,8 @@ int cmd_main(int argc, const char **argv)
 		if (!force_all &&
 		    !is_null_oid(&ref->old_oid) &&
 		    !ref->force) {
-			if (!has_object(the_repository, &ref->old_oid,
-					HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) ||
+			if (!odb_has_object(the_repository->objects, &ref->old_oid,
+					    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) ||
 			    !ref_newer(&ref->peer_ref->new_oid,
 				       &ref->old_oid)) {
 				/*
diff --git a/http-walker.c b/http-walker.c
index 4b1cdd25a80..4e7024ebc5f 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -138,8 +138,8 @@ static int fill_active_slot(void *data UNUSED)
 	list_for_each_safe(pos, tmp, head) {
 		obj_req = list_entry(pos, struct object_request, node);
 		if (obj_req->state == WAITING) {
-			if (has_object(the_repository, &obj_req->oid,
-				       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+			if (odb_has_object(the_repository->objects, &obj_req->oid,
+					   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 				obj_req->state = COMPLETE;
 			else {
 				start_object_request(obj_req);
@@ -497,8 +497,8 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 	if (!obj_req)
 		return error("Couldn't find request for %s in the queue", hex);
 
-	if (has_object(the_repository, &obj_req->oid,
-		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+	if (odb_has_object(the_repository->objects, &obj_req->oid,
+			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		if (obj_req->req)
 			abort_http_object_request(&obj_req->req);
 		abort_object_request(obj_req);
diff --git a/list-objects.c b/list-objects.c
index c50b9578584..42c17d95739 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -74,8 +74,8 @@ static void process_blob(struct traversal_context *ctx,
 	 * of missing objects.
 	 */
 	if (ctx->revs->exclude_promisor_objects &&
-	    !has_object(the_repository, &obj->oid,
-			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) &&
+	    !odb_has_object(the_repository->objects, &obj->oid,
+			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) &&
 	    is_promisor_object(ctx->revs->repo, &obj->oid))
 		return;
 
diff --git a/notes.c b/notes.c
index 73eb5f00cf5..97b995f3f2d 100644
--- a/notes.c
+++ b/notes.c
@@ -794,8 +794,8 @@ static int prune_notes_helper(const struct object_id *object_oid,
 	struct note_delete_list **l = (struct note_delete_list **) cb_data;
 	struct note_delete_list *n;
 
-	if (has_object(the_repository, object_oid,
-		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+	if (odb_has_object(the_repository->objects, object_oid,
+			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 0; /* nothing to do for this note */
 
 	/* failed to find object => prune this note */
diff --git a/odb.c b/odb.c
index 5202f107af2..787611c8f60 100644
--- a/odb.c
+++ b/odb.c
@@ -880,7 +880,7 @@ int pretend_object_file(struct repository *repo,
 	char *co_buf;
 
 	hash_object_file(repo->hash_algo, buf, len, type, oid);
-	if (has_object(repo, oid, 0) ||
+	if (odb_has_object(repo->objects, oid, 0) ||
 	    find_cached_object(repo->objects, oid))
 		return 0;
 
@@ -962,7 +962,7 @@ void *read_object_with_reference(struct repository *r,
 	}
 }
 
-int has_object(struct repository *r, const struct object_id *oid,
+int odb_has_object(struct object_database *odb, const struct object_id *oid,
 	       unsigned flags)
 {
 	unsigned object_info_flags = 0;
@@ -974,7 +974,7 @@ int has_object(struct repository *r, const struct object_id *oid,
 	if (!(flags & HAS_OBJECT_FETCH_PROMISOR))
 		object_info_flags |= OBJECT_INFO_SKIP_FETCH_OBJECT;
 
-	return odb_read_object_info_extended(r->objects, oid, NULL, object_info_flags) >= 0;
+	return odb_read_object_info_extended(odb, oid, NULL, object_info_flags) >= 0;
 }
 
 void odb_assert_oid_type(struct object_database *odb,
diff --git a/odb.h b/odb.h
index fb56cc9e1fe..3a96de56bd6 100644
--- a/odb.h
+++ b/odb.h
@@ -367,8 +367,9 @@ enum {
  * Returns 1 if the object exists. This function will not lazily fetch objects
  * in a partial clone by default.
  */
-int has_object(struct repository *r, const struct object_id *oid,
-	       unsigned flags);
+int odb_has_object(struct object_database *odb,
+		   const struct object_id *oid,
+		   unsigned flags);
 
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect);
@@ -458,4 +459,11 @@ static inline void *repo_read_object_file(struct repository *r,
 	return odb_read_object(r->objects, oid, type, size);
 }
 
+static inline int has_object(struct repository *r,
+			     const struct object_id *oid,
+			     unsigned flags)
+{
+	return odb_has_object(r->objects, oid, flags);
+}
+
 #endif /* ODB_H */
diff --git a/reflog.c b/reflog.c
index 747b82eada8..39c205fd26e 100644
--- a/reflog.c
+++ b/reflog.c
@@ -152,7 +152,7 @@ static int tree_is_complete(const struct object_id *oid)
 	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 	complete = 1;
 	while (tree_entry(&desc, &entry)) {
-		if (!has_object(the_repository, &entry.oid,
+		if (!odb_has_object(the_repository->objects, &entry.oid,
 				HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) ||
 		    (S_ISDIR(entry.mode) && !tree_is_complete(&entry.oid))) {
 			tree->object.flags |= INCOMPLETE;
diff --git a/refs.c b/refs.c
index 82a70b502f8..d6475d5e745 100644
--- a/refs.c
+++ b/refs.c
@@ -376,7 +376,8 @@ int ref_resolves_to_object(const char *refname,
 {
 	if (flags & REF_ISBROKEN)
 		return 0;
-	if (!has_object(repo, oid, HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+	if (!odb_has_object(repo->objects, oid,
+			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		error(_("%s does not point to a valid object!"), refname);
 		return 0;
 	}
diff --git a/remote.c b/remote.c
index 72c36239d31..5edf2a9f4b2 100644
--- a/remote.c
+++ b/remote.c
@@ -1703,7 +1703,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
 			if (starts_with(ref->name, "refs/tags/"))
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
-			else if (!has_object(the_repository, &ref->old_oid, HAS_OBJECT_RECHECK_PACKED))
+			else if (!odb_has_object(the_repository->objects, &ref->old_oid, HAS_OBJECT_RECHECK_PACKED))
 				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
 			else if (!lookup_commit_reference_gently(the_repository, &ref->old_oid, 1) ||
 				 !lookup_commit_reference_gently(the_repository, &ref->new_oid, 1))
diff --git a/send-pack.c b/send-pack.c
index abca2dd38a7..d029f748232 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -45,7 +45,7 @@ int option_parse_push_signed(const struct option *opt,
 static void feed_object(struct repository *r,
 			const struct object_id *oid, FILE *fh, int negative)
 {
-	if (negative && !has_object(r, oid, 0))
+	if (negative && !odb_has_object(r->objects, oid, 0))
 		return;
 
 	if (negative)
diff --git a/shallow.c b/shallow.c
index d379756e39a..ef3adb635fd 100644
--- a/shallow.c
+++ b/shallow.c
@@ -310,8 +310,8 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	if (graft->nr_parent != -1)
 		return 0;
 	if (data->flags & QUICK) {
-		if (!has_object(the_repository, &graft->oid,
-				HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+		if (!odb_has_object(the_repository->objects, &graft->oid,
+				    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			return 0;
 	} else if (data->flags & SEEN_ONLY) {
 		struct commit *c = lookup_commit(the_repository, &graft->oid);
@@ -477,8 +477,8 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 	ALLOC_ARRAY(info->ours, sa->nr);
 	ALLOC_ARRAY(info->theirs, sa->nr);
 	for (size_t i = 0; i < sa->nr; i++) {
-		if (has_object(the_repository, sa->oid + i,
-			       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+		if (odb_has_object(the_repository->objects, sa->oid + i,
+				   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 			struct commit_graft *graft;
 			graft = lookup_commit_graft(the_repository,
 						    &sa->oid[i]);
@@ -515,8 +515,8 @@ void remove_nonexistent_theirs_shallow(struct shallow_info *info)
 	for (i = dst = 0; i < info->nr_theirs; i++) {
 		if (i != dst)
 			info->theirs[dst] = info->theirs[i];
-		if (has_object(the_repository, oid + info->theirs[i],
-			       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+		if (odb_has_object(the_repository->objects, oid + info->theirs[i],
+				   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			dst++;
 	}
 	info->nr_theirs = dst;
diff --git a/upload-pack.c b/upload-pack.c
index cec12cb478a..98cda156434 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -509,7 +509,7 @@ static int got_oid(struct upload_pack_data *data,
 {
 	if (get_oid_hex(hex, oid))
 		die("git upload-pack: expected SHA1 object, got '%s'", hex);
-	if (!has_object(the_repository, oid, 0))
+	if (!odb_has_object(the_repository->objects, oid, 0))
 		return -1;
 	return do_got_oid(data, oid);
 }
diff --git a/walker.c b/walker.c
index a8abe8a2e78..d131af04c7b 100644
--- a/walker.c
+++ b/walker.c
@@ -150,8 +150,8 @@ static int process(struct walker *walker, struct object *obj)
 		return 0;
 	obj->flags |= SEEN;
 
-	if (has_object(the_repository, &obj->oid,
-		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
+	if (odb_has_object(the_repository->objects, &obj->oid,
+			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		/* We already have it, so we should scan it now. */
 		obj->flags |= TO_SCAN;
 	}

-- 
2.49.0.1141.g47af616452.dirty

