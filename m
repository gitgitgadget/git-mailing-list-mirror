Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9521E0DD9
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363809; cv=none; b=eRSAOPtX/q3bfZqG2BKIJrzHFPoBInVC2Wc2zhqoh7y70FXMpzT0E1K+RkSkomiXvX5f6CppZ0pJTiNxQcbua6sVf2LyugaNz/2SE1KZCqOcWQhI/MhCOGixUlIMWwlV8UfM5iNH46oAWR9YEq21o8OV11LoS3LNEVj+p+9IvQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363809; c=relaxed/simple;
	bh=KGHw4JsM8G1ERG5o8mVdcbgl38BkW5a5lQK/wPn6/uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+7mslimnWN15yM+n3lNUnq17YemKj76+4rZNDldNSqJTWmfmM7CYByVJsol8W8tgk0muDCvU0rtKUhbOTUlsCOZImNwV7Sqm6tTFeunrxvYRa7NNEaPCFAwjOqa3QZRbqb8K2SvXlJ3A9WjpmfrOEeSTnoGOu/MN5Nl5/PLoSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iYknIGMw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIr0sT5s; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iYknIGMw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIr0sT5s"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DFD21380297;
	Fri, 11 Apr 2025 05:30:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Apr 2025 05:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744363806;
	 x=1744450206; bh=+ocGpRTpQxmbpjMLn6aprsamgh43ciXH4uq3JP0ymKA=; b=
	iYknIGMwJUQfTKwTwy7Aq311js8ByyH4gBGcJ4HFpK42xSYj6QaCF1amKEZXp1Ai
	DvUWpnqG8UDMuwzIrB4Ixr9/FGpPXagQv6caNFbTpMxRZ+AcpdJmVWaDK55zt02B
	OTJJkJNKIVc5Z3xvtXCHSzl8KWjuKjFyxSCaTUR+ITydZ/eU3HK5GLbfXAuWp0VU
	WZ9NoRPlPot1fdM5OOze30bDLaix/W9AlZkGcyi9IBku6KBk8dO+ze6M+IL42WkK
	VGPFipvJ2Y/73orz4nMKxt1qI6NG0pCfkMWzmtpmFNxltr7ocv+OTE6SIqbM9LQ0
	tePoPNviW0d8SJPh0Z1BkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744363806; x=
	1744450206; bh=+ocGpRTpQxmbpjMLn6aprsamgh43ciXH4uq3JP0ymKA=; b=e
	Ir0sT5sll0S8HUABT69qzmiIZ8Grq8pML750+OX6zNu0XVT+VCGF6lckwvW8S8lA
	dTQX9WIJmyyjJEaea1SPmUkx5xSfw55Dwe5MOBeoVASa67RWe951mYh2D3bl3OLv
	xsydplg2fFtw14mTKiUMrqKKqPRhhXMSSGobh9BGzNYhnu57UEuB4YBrQ4ItnuYM
	xdulQ9dl9oaFl6NyZ0VNquhucvMewvCxMIHuMFqEeLt50pdUzGx2fzN59bLX24zT
	pwcNe3aCERxAhCVmzJlpavk8uLygxsC2pgOuPvn7uU9UeIJS1O588Fl+7Rhg69us
	N5hGwpH4EHzi4U/68aNsA==
X-ME-Sender: <xms:HuH4Z8lGHtYDqKrJrf5ucFf8TV_vHtXVbHpuUC2u0stIDy0-ha5AGA>
    <xme:HuH4Z73VvjX9UcRBc6ItI6jCfJjuRBzQFbqjzrb-2Q3rgpGozw9XSeRgQAxQsZr0G
    ulchATlkn-TQBBSTA>
X-ME-Received: <xmr:HuH4Z6on5T0iYwbNjCuaIZzgrIakbhS2d-OPHClPQ6dP-Js0Bar90GaW5iskW7vQA0Gb8g3I1jQ9CdnS9ZzDZ_ExivImynOb3B0lOxG2MF69PAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehn
    vgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HuH4Z4kL0H01YOqlnZQXi9y7ZAq982OsXBpj01MsDBpvbZYW_ca_xw>
    <xmx:HuH4Z63DgSgXtD5qDTYLB02dMgvdqJFXh35lHRcZ7qdwgWUX-jy1iA>
    <xmx:HuH4Z_tacL9BWO50jsQKuh1XM7NzINrhPd4EAbY31G0Tc2aUbB9w_g>
    <xmx:HuH4Z2XQlXDJLYhUcKpR5tXqo8qxylBt-EfrVhkbT0ChuDFfZvRMLQ>
    <xmx:HuH4Z7jvagDCFj1CMnuMN8BDxkvEaDggzzLjhi8H9f5mTMgjba0yw4Z0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:30:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 400faa3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:30:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Apr 2025 11:29:56 +0200
Subject: [PATCH v2 7/9] object: split out functions relating to object
 store subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-pks-split-object-file-v2-7-2bea0c9033ae@pks.im>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
In-Reply-To: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Split out functions relating to the object store subsystem from
"object.c". This helps us to separate concerns.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-store-ll.h |  3 ---
 object-store.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 object.c          | 67 -------------------------------------------------------
 3 files changed, 66 insertions(+), 70 deletions(-)

diff --git a/object-store-ll.h b/object-store-ll.h
index 8ae80b8a5fa..8bb0f33f9a8 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -92,9 +92,6 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 /* Empty the loose object cache for the specified object directory. */
 void odb_clear_loose_cache(struct object_directory *odb);
 
-/* Clear and free the specified object directory */
-void free_object_directory(struct object_directory *odb);
-
 struct packed_git {
 	struct hashmap_entry packmap_ent;
 	struct packed_git *next;
diff --git a/object-store.c b/object-store.c
index e5f1f00cdde..ea2d86c429b 100644
--- a/object-store.c
+++ b/object-store.c
@@ -2,11 +2,13 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "commit-graph.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
+#include "loose.h"
 #include "object-file-convert.h"
 #include "object-file.h"
 #include "object-store.h"
@@ -361,6 +363,14 @@ struct object_directory *set_temporary_primary_odb(const char *dir, int will_des
 	return new_odb->next;
 }
 
+static void free_object_directory(struct object_directory *odb)
+{
+	free(odb->path);
+	odb_clear_loose_cache(odb);
+	loose_object_map_clear(&odb->loose_map);
+	free(odb);
+}
+
 void restore_primary_odb(struct object_directory *restore_odb, const char *old_path)
 {
 	struct object_directory *cur_odb = the_repository->objects->odb;
@@ -970,3 +980,59 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect)
 		die(_("%s is not a valid '%s' object"), oid_to_hex(oid),
 		    type_name(expect));
 }
+
+struct raw_object_store *raw_object_store_new(void)
+{
+	struct raw_object_store *o = xmalloc(sizeof(*o));
+
+	memset(o, 0, sizeof(*o));
+	INIT_LIST_HEAD(&o->packed_git_mru);
+	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
+	pthread_mutex_init(&o->replace_mutex, NULL);
+	return o;
+}
+
+static void free_object_directories(struct raw_object_store *o)
+{
+	while (o->odb) {
+		struct object_directory *next;
+
+		next = o->odb->next;
+		free_object_directory(o->odb);
+		o->odb = next;
+	}
+	kh_destroy_odb_path_map(o->odb_by_path);
+	o->odb_by_path = NULL;
+}
+
+void raw_object_store_clear(struct raw_object_store *o)
+{
+	FREE_AND_NULL(o->alternate_db);
+
+	oidmap_free(o->replace_map, 1);
+	FREE_AND_NULL(o->replace_map);
+	pthread_mutex_destroy(&o->replace_mutex);
+
+	free_commit_graph(o->commit_graph);
+	o->commit_graph = NULL;
+	o->commit_graph_attempted = 0;
+
+	free_object_directories(o);
+	o->odb_tail = NULL;
+	o->loaded_alternates = 0;
+
+	INIT_LIST_HEAD(&o->packed_git_mru);
+	close_object_store(o);
+
+	/*
+	 * `close_object_store()` only closes the packfiles, but doesn't free
+	 * them. We thus have to do this manually.
+	 */
+	for (struct packed_git *p = o->packed_git, *next; p; p = next) {
+		next = p->next;
+		free(p);
+	}
+	o->packed_git = NULL;
+
+	hashmap_clear(&o->pack_map);
+}
diff --git a/object.c b/object.c
index 154525a4972..ccda798b75f 100644
--- a/object.c
+++ b/object.c
@@ -6,16 +6,13 @@
 #include "object.h"
 #include "replace-object.h"
 #include "object-file.h"
-#include "object-store.h"
 #include "blob.h"
 #include "statinfo.h"
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
 #include "alloc.h"
-#include "packfile.h"
 #include "commit-graph.h"
-#include "loose.h"
 
 unsigned int get_max_object_index(const struct repository *repo)
 {
@@ -567,70 +564,6 @@ struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
 	return o;
 }
 
-struct raw_object_store *raw_object_store_new(void)
-{
-	struct raw_object_store *o = xmalloc(sizeof(*o));
-
-	memset(o, 0, sizeof(*o));
-	INIT_LIST_HEAD(&o->packed_git_mru);
-	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
-	pthread_mutex_init(&o->replace_mutex, NULL);
-	return o;
-}
-
-void free_object_directory(struct object_directory *odb)
-{
-	free(odb->path);
-	odb_clear_loose_cache(odb);
-	loose_object_map_clear(&odb->loose_map);
-	free(odb);
-}
-
-static void free_object_directories(struct raw_object_store *o)
-{
-	while (o->odb) {
-		struct object_directory *next;
-
-		next = o->odb->next;
-		free_object_directory(o->odb);
-		o->odb = next;
-	}
-	kh_destroy_odb_path_map(o->odb_by_path);
-	o->odb_by_path = NULL;
-}
-
-void raw_object_store_clear(struct raw_object_store *o)
-{
-	FREE_AND_NULL(o->alternate_db);
-
-	oidmap_free(o->replace_map, 1);
-	FREE_AND_NULL(o->replace_map);
-	pthread_mutex_destroy(&o->replace_mutex);
-
-	free_commit_graph(o->commit_graph);
-	o->commit_graph = NULL;
-	o->commit_graph_attempted = 0;
-
-	free_object_directories(o);
-	o->odb_tail = NULL;
-	o->loaded_alternates = 0;
-
-	INIT_LIST_HEAD(&o->packed_git_mru);
-	close_object_store(o);
-
-	/*
-	 * `close_object_store()` only closes the packfiles, but doesn't free
-	 * them. We thus have to do this manually.
-	 */
-	for (struct packed_git *p = o->packed_git, *next; p; p = next) {
-		next = p->next;
-		free(p);
-	}
-	o->packed_git = NULL;
-
-	hashmap_clear(&o->pack_map);
-}
-
 void parsed_object_pool_reset_commit_grafts(struct parsed_object_pool *o)
 {
 	for (int i = 0; i < o->grafts_nr; i++) {

-- 
2.49.0.777.g153de2bbd5.dirty

