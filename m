Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891D4351FD5
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820737; cv=none; b=giUTcLLLa1S0SB/GJZ2aR+mNNfLTvwojAps59WNHt0+/V8gGDAZNDW7dQxCmupo6UAvHytNWIw8Wtcu5WpLJ0SU/IfY/5A0mcQItRnXGJ8fkN0QQKWCoU2OGf4ZPFJ4VF7MtvD2SHUz4XCyTGjKT/eeNBgGPqigX54KIuS0fM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820737; c=relaxed/simple;
	bh=iaZiQerlNTyTg5bLlY6Wru5vwQaTFY9qKvZtXMPd+2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3zIiASGcH6ltQGxhJf861BsTZGTMef/W+18ng1AcyF7pONdtz0lwqL4yuEprZEgoD1nAzFJqY54OGZ2fDQDAJQHuxe6TBVt+i37P0gs+rSsB/sEZ44pfCQzOe0xZ5Tcili0nfyM7FunhA+Vsf8v/B2fU+0/4m3QvLNfSj4d33o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XpFHsrHD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xtonxgb/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XpFHsrHD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xtonxgb/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9819214000FC;
	Thu, 30 Oct 2025 06:38:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 06:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761820734;
	 x=1761907134; bh=bSdLz+GlCoCS9awjIoZQvOHrOsWMUOj4fNkOKIrj7z0=; b=
	XpFHsrHD9FcYih2i4YrEGfbYKglgXeTlcZUxdo3pkyrwZp1KUVv/q0uHic9HODvH
	xwkmXptjerCWl+ASRCIw5x4YLeN4J8Udcx7wIjymV3z7+UkMaM5dAC/s2NwCgvmk
	lDmqzy7GaiJEdbYySNdSuZg/W78mSmRROpuaoJLJa1dtYc9viZcEMYVFj7I7LVpJ
	1Hi/8G+qp5rf9mrSn/4ixDTHrl0XhOTLV6vQ78ALmGWjanQ4uRInUSuUAfeX+Fhj
	Gv14pM7FXJlt3zi4HJGHUoOXQlPVFrZ4NSYZbhOJwSMl2+OvLzfVdu/AU5SLyrxm
	wM2Sq3f/H45R0RvfAv0QAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761820734; x=
	1761907134; bh=bSdLz+GlCoCS9awjIoZQvOHrOsWMUOj4fNkOKIrj7z0=; b=x
	tonxgb/nwjgb/lRHTmkEwEiINEYxtSafR3KdZA7MyaM87KD5zQIEFU+vTMuzhqr8
	VAu/otmUUtoC1OQOAlZrd+X7SylKLFtKpJhFigjUi6tzopCn1yDXRuZfJ72Bww7o
	mVmisGkMABumovaO1r9Q6eDy1hRtN6hX0iKO5c6ETPIk+1G8lhogFS70ZHjYQqnU
	GQ+eO8H8414p3A2mD4KOEM45pKxVf1w084c+PXxy/wbHQGv8LJwdLsD3Gq5VQccM
	Ocw8ZOyIb4pt3rfJw7I1YdZTSv8uJGmgJrE9mprzJAaiL36k6tiohxKRNtQ9jmNn
	kFU0jbdQfa8pxh1gdc+OQ==
X-ME-Sender: <xms:PkADaX5UCHCMSRl1iEL92Hs133PIsqQ_dM3ggJSjuC4Kmqo1cH-s8Q>
    <xme:PkADaT7uy7oWseplNhn_D1_YNV0XNGXEY7s_E-kKIO0wKjSZknd3Iem9tNp-2TCae
    tCyDhK9I6F-eW4VCjUD_FDzqBS3n2nLWY5nrBTJMjScK2boFKFI>
X-ME-Received: <xmr:PkADaTcy8pOUPMv8gQuenO0uQFkANL0zoYVLjc-ekvr4YORuIHZuzeSvFixxya-m8kiMOFLcJNEy7IU6yYS5OyOVIiB9wTeY5JvsfP114w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PkADaXDZEG2LQKVLR0dwRVIo28RC340hlc7c53FXcuZO39t0xEU3Gg>
    <xmx:PkADaW9qCNTspwZ2-ou3_fYxM-v80IEOvV_7THsO6Ss2gU21Cpvilg>
    <xmx:PkADaSJZH4Zs3nQmEw3dwnOa5vE42Xn8FOpZL9RgzkdnIpfmO-0WCQ>
    <xmx:PkADafiSsHQQ3LVwcRQsYijS59ZVg-GJQA7xLAj1kLx4n4LQeIP1YQ>
    <xmx:PkADaS-j3t2yntzxVwu4xptO5j9pyrnLTxxspaazM1r202X1OcQ0_LLm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 06:38:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4045332b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 10:38:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Oct 2025 11:38:40 +0100
Subject: [PATCH v2 3/8] http: refactor subsystem to use `packfile_list`s
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-pks-packfiles-store-drop-list-v2-3-84654f080cc0@pks.im>
References: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
In-Reply-To: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Toon Claes <toon@iotcl.com>
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

