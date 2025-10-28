Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E882305946
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649731; cv=none; b=aHFiIstkPg8PjAhwE9ll6zc6wPPxz3Kp7vJFkhVxvJap473BXAfrc99B5nrjRqYQY9uXKlpdcWB/+06sZcPQMVE1CEWGBTNcpET1i+wSjZYNi07/SwPChW5dGjMeVMiZT5ST6QYPyPOJjPvAx3g+QH8Xfvl0c/nXBlENOdNNnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649731; c=relaxed/simple;
	bh=iaZiQerlNTyTg5bLlY6Wru5vwQaTFY9qKvZtXMPd+2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=igsBn4QolWjo2cjGEtbM2D1fKaz20ri7NcQF3D6BGIiMmV6U53tVgLnLvIL2JHf9o2ZE6K9DI+LQKOuAX1P0KLNhdbjF36fJlaHOlvHIXtiNvHXeTBWGXyELYn3uZpOyNS5Z/HHVXDDsW6DzJ01vdl1VwwBBDGYgRTn1AgcDdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RiagbQ0C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yldl1txL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RiagbQ0C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yldl1txL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D449EC039D;
	Tue, 28 Oct 2025 07:08:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 07:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761649728;
	 x=1761736128; bh=bSdLz+GlCoCS9awjIoZQvOHrOsWMUOj4fNkOKIrj7z0=; b=
	RiagbQ0CVMhwh8Y+6xDJs+IKnJJps4tdzppph8dgSO8C9/kg2/Ery7mzXDgxLzur
	3XHru6VEJomj3bAkJl8Ukj/VNKrvDDlCMJ3bqf6L/MF1/NwhonGZHg6bOrE/lqOK
	A74xXmCd863gHbQRIJd3O/EMZvj+RxaTC1q84yaG0hxhbauaVxzbh7MJhbeyMrsA
	UerK3V7OcdOvMjXXnZhFaj2L5KiCio/lSDupupc+PY6KUa4mVJwIhVTi8mxa0Z4L
	osYoOip9AM5TJU/QWN10eLe9juQeT0d8aWJQJBmqrh0eqqIULQVnhrMJwhuvbR7+
	4dhZnkJKS9ArzcqlPqbcGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761649728; x=
	1761736128; bh=bSdLz+GlCoCS9awjIoZQvOHrOsWMUOj4fNkOKIrj7z0=; b=Y
	ldl1txLHNvnyD9hcNaTqb5lxZIHQcjY5AQ1yniHgn+ZAUyjDl/Qlw3+b2ULiCY1B
	9elOQel2rOMP0CtuGmZVoG8pt95/VsbqO6S2FY7MSUTXeLNdqeJXUDPx9gmao5lY
	c91LKGUzMapb2kaRjJuEbMHLfCiuNUejJ5t4nCH9KrZlR8c/uoU+9FLwWm24BkK2
	TmnbnWN664jnZM+5RN4XJ4F0oRa+X3MjZoCPzZQeB4SZdhzpUCtpR3aCN7dHpdQc
	R7kXyMSNCnQtiJbz1ypbTiX2qFCqmkd/LJf67niIgf7xmQsNNp+XZZIiMxupIx3W
	E0IS388c1tlP9TT7n9Lyg==
X-ME-Sender: <xms:QKQAad7Uds7uq7lQQgwAI34TaNlbwrdaM7Mkrlcn9Af6uFjzNxkgqg>
    <xme:QKQAaSUOUh5PIUAUkx7J9kZcrZRm91Fu4BjDn9gpTt3rGNFaCRib27TLgEQalDIjj
    v9L-Ez2OeHWtYu4ucsAFUFUYX8S2HWz7g_bMw0mBrKIv49e2vl9VQ>
X-ME-Received: <xmr:QKQAaR1MP_a7qPydgb8j50JhpxiOoUdWPpAWuFrUjhCgixJOHPK_LZesGFwCrHGoN55P0SdXyLJl2vdfao4uHO3G-b-xLsI5qul4FOUQ4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:QKQAaf352_AC4TMxkHEN3MzBydgHRTVFaU9X5oSxHv8Zli_NS5ulmw>
    <xmx:QKQAaU864HV76t-69tnvjjY8tuzXLXDmP-MGiWAcbbfqRakjIP54VA>
    <xmx:QKQAac1OQfJM6jfhI9oVD7S05mwsswr1GvBMPzUNVTAxcYJfDqGYsQ>
    <xmx:QKQAaR_Faasc-SNnf3VjqjnWobCv_ta6YL1RTro1In7C9kw0MlWYrw>
    <xmx:QKQAaVOY9DoU1RHEcQWdAy-qmcKAGlbAkWBTD0HYMdu0_Dg5GkujNx5O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 07:08:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe62f77b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 11:08:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Oct 2025 12:08:33 +0100
Subject: [PATCH 3/8] http: refactor subsystem to use `packfile_list`s
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pks-packfiles-store-drop-list-v1-3-1a3b82030a7a@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

The dumb HTTP protocol directly fetches packfiles from the remote server
and temporarily stores them in a list of packfiles. Those packfiles are
not yet added to the repository's packfile store until we finalize the
whole fetch.

Refactor the code to instead use a `struct packfile_list` to store those
packs. This prepares us for a subsequent change where the `->next`
pointer of `struct packed_git` will go away.

Note that this refactoring creates some temporary duplication of code,
as we now have both `packfile_list_find_oid()` and `find_oid_pack()`.
The latter function will be removed in a subsequent commit though.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http-push.c   |  6 +++---
 http-walker.c | 26 +++++++++-----------------
 http.c        | 21 ++++++++-------------
 http.h        |  5 +++--
 packfile.c    |  9 +++++++++
 packfile.h    |  8 ++++++++
 6 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/http-push.c b/http-push.c
index a1c01e3b9b9..d86ce771198 100644
--- a/http-push.c
+++ b/http-push.c
@@ -104,7 +104,7 @@ struct repo {
 	int has_info_refs;
 	int can_update_info_refs;
 	int has_info_packs;
-	struct packed_git *packs;
+	struct packfile_list packs;
 	struct remote_lock *locks;
 };
 
@@ -311,7 +311,7 @@ static void start_fetch_packed(struct transfer_request *request)
 	struct transfer_request *check_request = request_queue_head;
 	struct http_pack_request *preq;
 
-	target = find_oid_pack(&request->obj->oid, repo->packs);
+	target = packfile_list_find_oid(repo->packs.head, &request->obj->oid);
 	if (!target) {
 		fprintf(stderr, "Unable to fetch %s, will not be able to update server info refs\n", oid_to_hex(&request->obj->oid));
 		repo->can_update_info_refs = 0;
@@ -683,7 +683,7 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 		get_remote_object_list(obj->oid.hash[0]);
 	if (obj->flags & (REMOTE | PUSHING))
 		return 0;
-	target = find_oid_pack(&obj->oid, repo->packs);
+	target = packfile_list_find_oid(repo->packs.head, &obj->oid);
 	if (target) {
 		obj->flags |= REMOTE;
 		return 0;
diff --git a/http-walker.c b/http-walker.c
index 0f7ae46d7f1..e886e648664 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -15,7 +15,7 @@
 struct alt_base {
 	char *base;
 	int got_indices;
-	struct packed_git *packs;
+	struct packfile_list packs;
 	struct alt_base *next;
 };
 
@@ -324,11 +324,8 @@ static void process_alternates_response(void *callback_data)
 				} else if (is_alternate_allowed(target.buf)) {
 					warning("adding alternate object store: %s",
 						target.buf);
-					newalt = xmalloc(sizeof(*newalt));
-					newalt->next = NULL;
+					CALLOC_ARRAY(newalt, 1);
 					newalt->base = strbuf_detach(&target, NULL);
-					newalt->got_indices = 0;
-					newalt->packs = NULL;
 
 					while (tail->next != NULL)
 						tail = tail->next;
@@ -435,7 +432,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo,
 
 	if (fetch_indices(walker, repo))
 		return -1;
-	target = find_oid_pack(oid, repo->packs);
+	target = packfile_list_find_oid(repo->packs.head, oid);
 	if (!target)
 		return -1;
 	close_pack_index(target);
@@ -584,17 +581,15 @@ static void cleanup(struct walker *walker)
 	if (data) {
 		alt = data->alt;
 		while (alt) {
-			struct packed_git *pack;
+			struct packfile_list_entry *e;
 
 			alt_next = alt->next;
 
-			pack = alt->packs;
-			while (pack) {
-				struct packed_git *pack_next = pack->next;
-				close_pack(pack);
-				free(pack);
-				pack = pack_next;
+			for (e = alt->packs.head; e; e = e->next) {
+				close_pack(e->pack);
+				free(e->pack);
 			}
+			packfile_list_clear(&alt->packs);
 
 			free(alt->base);
 			free(alt);
@@ -612,14 +607,11 @@ struct walker *get_http_walker(const char *url)
 	struct walker_data *data = xmalloc(sizeof(struct walker_data));
 	struct walker *walker = xmalloc(sizeof(struct walker));
 
-	data->alt = xmalloc(sizeof(*data->alt));
+	CALLOC_ARRAY(data->alt, 1);
 	data->alt->base = xstrdup(url);
 	for (s = data->alt->base + strlen(data->alt->base) - 1; *s == '/'; --s)
 		*s = 0;
 
-	data->alt->got_indices = 0;
-	data->alt->packs = NULL;
-	data->alt->next = NULL;
 	data->got_alternates = -1;
 
 	walker->corrupt_object_found = 0;
diff --git a/http.c b/http.c
index 17130823f00..41f850db16d 100644
--- a/http.c
+++ b/http.c
@@ -2413,8 +2413,9 @@ static char *fetch_pack_index(unsigned char *hash, const char *base_url)
 	return tmp;
 }
 
-static int fetch_and_setup_pack_index(struct packed_git **packs_head,
-	unsigned char *sha1, const char *base_url)
+static int fetch_and_setup_pack_index(struct packfile_list *packs,
+				      unsigned char *sha1,
+				      const char *base_url)
 {
 	struct packed_git *new_pack, *p;
 	char *tmp_idx = NULL;
@@ -2448,12 +2449,11 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	if (ret)
 		return -1;
 
-	new_pack->next = *packs_head;
-	*packs_head = new_pack;
+	packfile_list_prepend(packs, new_pack);
 	return 0;
 }
 
-int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
+int http_get_info_packs(const char *base_url, struct packfile_list *packs)
 {
 	struct http_get_options options = {0};
 	int ret = 0;
@@ -2477,7 +2477,7 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 		    !parse_oid_hex(data, &oid, &data) &&
 		    skip_prefix(data, ".pack", &data) &&
 		    (*data == '\n' || *data == '\0')) {
-			fetch_and_setup_pack_index(packs_head, oid.hash, base_url);
+			fetch_and_setup_pack_index(packs, oid.hash, base_url);
 		} else {
 			data = strchrnul(data, '\n');
 		}
@@ -2541,14 +2541,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 }
 
 void http_install_packfile(struct packed_git *p,
-			   struct packed_git **list_to_remove_from)
+			   struct packfile_list *list_to_remove_from)
 {
-	struct packed_git **lst = list_to_remove_from;
-
-	while (*lst != p)
-		lst = &((*lst)->next);
-	*lst = (*lst)->next;
-
+	packfile_list_remove(list_to_remove_from, p);
 	packfile_store_add_pack(the_repository->objects->packfiles, p);
 }
 
diff --git a/http.h b/http.h
index 553e16205ce..f9d45934047 100644
--- a/http.h
+++ b/http.h
@@ -2,6 +2,7 @@
 #define HTTP_H
 
 struct packed_git;
+struct packfile_list;
 
 #include "git-zlib.h"
 
@@ -190,7 +191,7 @@ struct curl_slist *http_append_auth_header(const struct credential *c,
 
 /* Helpers for fetching packs */
 int http_get_info_packs(const char *base_url,
-			struct packed_git **packs_head);
+			struct packfile_list *packs);
 
 /* Helper for getting Accept-Language header */
 const char *http_get_accept_language_header(void);
@@ -226,7 +227,7 @@ void release_http_pack_request(struct http_pack_request *preq);
  * from http_get_info_packs() and have chosen a specific pack to fetch.
  */
 void http_install_packfile(struct packed_git *p,
-			   struct packed_git **list_to_remove_from);
+			   struct packfile_list *list_to_remove_from);
 
 /* Helpers for fetching object */
 struct http_object_request {
diff --git a/packfile.c b/packfile.c
index 4d2d3b674f3..6aa2ca8ac9e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -121,6 +121,15 @@ void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
 	}
 }
 
+struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
+					  const struct object_id *oid)
+{
+	for (; packs; packs = packs->next)
+		if (find_pack_entry_one(oid, packs->pack))
+			return packs->pack;
+	return NULL;
+}
+
 void pack_report(struct repository *repo)
 {
 	fprintf(stderr,
diff --git a/packfile.h b/packfile.h
index 39ed1073e4a..a53336d722a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -65,6 +65,14 @@ void packfile_list_remove(struct packfile_list *list, struct packed_git *pack);
 void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack);
 void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
 
+/*
+ * Find the pack within the "packs" list whose index contains the object
+ * "oid". For general object lookups, you probably don't want this; use
+ * find_pack_entry() instead.
+ */
+struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
+					  const struct object_id *oid);
+
 /*
  * A store that manages packfiles for a given object database.
  */

-- 
2.51.2.997.g839fc31de9.dirty

