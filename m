Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084228A1C3
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709909; cv=none; b=BVz8DZxc2dSnUJKs9Y84kZONe2HT3HwO02RTqT++nN8vYpyHYbXP8NznE4opXbrZnfzFctDiVSOGVTzKOX7DT5oY9nZl/ASSwZ+gM2z6xB1muxnZsc92XH5BBU7As0oRdTGqpxUFdyX4WDquhahEFiTYXFcDg1JOXhYxYVRrNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709909; c=relaxed/simple;
	bh=A19cYy16rCHKbqGiW8AdUpoglEdr+OpNUt6RymmKN+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2O1ZzGuPs4/ZUvpV8tthP/djBEcoxbOAaQ+JfXMaM9M1IuWhuuMkJdfy7Vzha5I95jbt5C5kpCbdbnFBh7LELuvGu0E/e1Lj/PsHGGR0uNgIQQ37Xuv6uDAV2y/oVo3D6vC/KATQ89+YwdgFuf4wl6O9FTVd0xAW4KkXzEN9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l5yj45W5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=onfxGXCi; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l5yj45W5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="onfxGXCi"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 998D41140318;
	Tue, 15 Apr 2025 05:38:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 05:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744709906;
	 x=1744796306; bh=Jk3YWNxoPtsz9JRdq4wACWWt/fGiQUNUg4nFFQ1RcTA=; b=
	l5yj45W544TDHEhDsqC5JSEKjrBCMOeVUvuluys9Sj+4q0tNjAho9VuFtZkjIszm
	KRVJ+ViPPPFPBnuA+YQ0IeUcu5y2ohxVR7KTWtFBcKM92IlXN6Lu+eYQYsxB2bgD
	bUUQH4bdG89QDIn4222bhLfNzcM3vkH6GZyaTjv/bR9BrjtbTO5uXBiL2kgLptW6
	/xne8HhSdXoKjYpJ6ZyffM7dUJzZRLGyocZ74DAsxidFIN8h+7E7pu3Dgv1VqZyC
	rUE4dM31QPnZbB2Of+cdPaecKkkxP5BK4V/rk7+jVOwML99rwgKytHtLu+NWD2P7
	b5y9csFwMWkdwvi57mCXSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744709906; x=
	1744796306; bh=Jk3YWNxoPtsz9JRdq4wACWWt/fGiQUNUg4nFFQ1RcTA=; b=o
	nfxGXCi3Uwj8OD6C1g7xkF3KwM2aPx+5rWaYBWuIb2/TqmICSFswYqRQpRDIZ+YU
	Bc3wGrH1UWdH8TFen8lF5Iu/FcjvFo34xY2jXbQWyJTH7mMo9lVnWr/KH8tBWwfY
	GI8bUIZEqufgmW1OUFVrVNvtE8amJmG7Owgu9EwnBsKsBJvQhE2Fd+1lpPUgaOJ7
	B1eRaQdxtIRPpphSLSr3nNG4WkQhXig/wxDkeMpoXF5VhL5C7aXOWbYNlZCeHfRP
	H/8kuysomkdoEG69edJ9h50qmTmCeoSZw6QhdirVnHOkI6GFBAvTElfYMhEABXOL
	LWMi4FRrNco0Hj/GMKzQg==
X-ME-Sender: <xms:Ein-ZyNfWbIeKU1c2wXndoZe5dXps-SERqGz3PbgU59WPd_WUFTBpg>
    <xme:Ein-Zw8QwZE51gwrGH3H_vZxVQTt_k1Op_rnposw5hhs6KqtyYcAA2X-gIt9049s4
    nLneo7N7DRhwydMCg>
X-ME-Received: <xmr:Ein-Z5So1UoCUK0GsJ2SaJHq--MO0TnCC26Guugw1n0ZhKGWFo6NogetWvEZyHSKTD9iH5gCmdU5WaN6VqPi0w0uSEkWCNj64eGjm2JEmOROjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ein-ZysrwdcXp5KMr5M5g4CZLiyPTNb0EGnOJEIBv6WhPiRFT-a8QA>
    <xmx:Ein-Z6fH77tP7eJbFsq0Pw0Px-1WEJmlE-289MIUkWFlNXhoNdMj8w>
    <xmx:Ein-Z22oUtM_zxiVvgjQ3MmByOOzx4n8Ffi1FUiEhl_u4sq7H-oJAA>
    <xmx:Ein-Z-81nXq-FiRhNTbs8UPgBl2Fc_Si5OVX2c5j5Kh-E74QGFtTJg>
    <xmx:Ein-Z2F7SPxb6fUpVH9A7bNY7hH946Z5Z0ZxG5E5NN2OLKqmmPdg8CUb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:38:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 362f8869 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:38:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:38:21 +0200
Subject: [PATCH v3 08/10] object: split out functions relating to object
 store subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-pks-split-object-file-v3-8-6aa7db7ad7b0@pks.im>
References: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
In-Reply-To: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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
index a2004dca15a..896d9ac3509 100644
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
2.49.0.805.g082f7c87e0.dirty

