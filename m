Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B383B6356
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678410; cv=none; b=PsIBYwJLvK+WSz0dfMYSJcxFHg0+yPcxv65NFzdUg80YYGRAmqxxwlyYH4u9+7F6N9tpscMmqP3RcEx0cs9mmg/7sxyi1s3GBJnQ2I2tuhJduXpf77WOol4AeV0Qvoy5HnynBGdJ7LkbNkUvDHmTTRaT2jLFFwF+BJWFs05wGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678410; c=relaxed/simple;
	bh=BtnSqthf+9ZNHm4LkxPz3lo9PlgKA7ZkcW73vYOz6hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EuU3pXtuzMY25xd1zo9qON7JDxnLqelNCKwTB4g63/dlq8feh1vavvnrNumyM36Pdvf3GZ0nWXwJz8mLJIAz2In8VFd+6DCrRn9lc7GuJkk2AMBPsVht+TApQ7h6SYsW+oYtjOi2CrFMREuhj4wLkW+jOJEcOZ4SkOhjmJhByJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NzwMsTjD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTRiOeMm; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NzwMsTjD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTRiOeMm"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 63EDC1D00128;
	Wed, 17 Jun 2026 02:40:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 02:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678408;
	 x=1781764808; bh=NLg1Y6K6gPtJXwNa6UfyeDM1u3Qvb64anFyL4e5Izdo=; b=
	NzwMsTjDQPr9UOxRjgaKeqOqdw+1IkxfhqKUcEW5xE/jFaTS8lgESFDlGh7DZ1Vy
	vDgGZvBgd3dXDcN/Wo7lLc53drt+ohqQ7EIVgW6iuzblaSsQ3PvQTcVaGNtms83s
	oHfDZwgNU4nEZVoheMeue5dyxNoOJa8SdhfxmICxe4nP7nafceaVZM+6RTnOITQw
	Hcffqu7bf/MVMce2KONRH6TKZSB7e374L8dTCiAs7LC1YLfNey8n/eurQWQ73P/8
	Gx6Fv2I1NXX4Fo2kslcWktBjcYK7uqqtooMdQ1Ojq1b/Tf+ZwjSWhncnuFKPzuWN
	gZE8ooQ1pf1oaUkLHF6UOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678408; x=
	1781764808; bh=NLg1Y6K6gPtJXwNa6UfyeDM1u3Qvb64anFyL4e5Izdo=; b=R
	TRiOeMmBB17xFNiB6HFALLezTlvC40pUZm5FI3fUU94xcNkDK+d08RKuYzkCF/iR
	Omf/BeMLWjubqfrjSSUJRB2yJT1hKrvVzofCZxLhyodCCuxYdpCNALjl095IC38h
	R6J+QR631kW6Iqlz4nfnIvvpXDQdqJVik10pZCcEkYPxJEF1BNda7RRObDByRvO1
	7WfoeusDkLVKy9z/FDb6IZPCxjjndUrDA7sZmreNlvMFOXeoYoAh44mh6sadIwB+
	lQd1JrTuVH3EfYGUmJ0bNQE6BKqC/7PfN4x3vS93cOOE82FQ+cB9q24CYALXH4eo
	qEKQkIINE0vUt4mqMy2+g==
X-ME-Sender: <xms:SEEyaibMj7IuWMh-L9yqh3JdNg-35QU2qOAWUJndY3hiIs9aBXIBIw>
    <xme:SEEyas0HfhF9GyB-4SihyuXpLbo3eMr73if8Mat6wdn34uGWuPu9H_OF0lcku1nHi
    avinfUuJbARWgmUv4zxYU6Z_H6lTDTSdviKn4f85_ZLoTGLUTEJ>
X-ME-Received: <xmr:SEEyaqWIJdlzfav4SuiLGkXYtCOeFVUMsBsrkOiJKaw2nLFPOhl4tkGBFtqk25OXDKSnC7NSy9D3bqzQFcAXAGc04uW4MNpTBHxPnxg>
X-ME-Proxy-Cause: dmFkZTFl07ipAIi9xJGEFtFdeXJ32YlTxjlf2nx1N6xtGXKrOC1bLbDlVvbrzzA5+wU1Co
    Syg+K8Q1ZQCASKzRK2+jUlv03fQMlni6m1uSDG9ZfsMez+CExN6BaOaB4dWww+dwFVrBWc
    MDEQgterYVrJX0duTt2YYH5sPQ0va9XcOu2v8cjr9lrtGWO3H/PAeE6gOAmLvw2VMk7fmQ
    bS0Z8M1QPaN6dBkHxm/qp0BwBioAlyPsS5cJKvA0SEp9LqrehZotcHKdpFgJTmQDXUKsqa
    EmWuysjWltbEijcyaQ8KC9W9onfmQCiSXmKIDwQVCz3CkB3vqB4j2FCfjXy4ARgFAuRiW7
    RPpdaT+tTBRnz3DN7lMYLkkKKk07n/oo8phyGDvAGgf3gQaFxYbk5/Zdd8lEij5eZAN2nI
    CRmr198ylxzoHAQGJr7LrRdsH3eMzkfhR5pDv5eIQXakgD8bfVaWU0tlzaDqnkYe4Ni8V3
    Ob1eom0XRlsxSqN+Z8d/7yLIkV9wlLh2IXweiRq9GVIgxOEIr/wYrfRzOA/tPRu83mux/X
    atYj2XYPSK6GgKL+yq3VBNb7EznFnDWceD/MulOKXqErSZ7GwONohB4RlhS/vARPh/n/yE
    gHw27P1U1RjH8A4z+Qxhkfx7F38GhGmZScaNbfG5UV5acq3TeohbOg7lp8lg
X-ME-Proxy: <xmx:SEEyauXvpST-j9NwXZZXV1je4c8rIanXH9ZgGPk2_ebYPYdMO5AYdQ>
    <xmx:SEEyahderNdVJkDp2pGi3t9kbVMEA5hfl2QAj_n8mR5QtABYHIHPlw>
    <xmx:SEEyavU6smrkYSJAI1_SbQN4hK38WqtfK3mVYxcRdsiAjYnHaFvuQg>
    <xmx:SEEyaidCiszFSkmOPWRo6TWFfStIhz4YIEEe-f5TcLup6Rbw0c_LFw>
    <xmx:SEEyauTUBMgXQR2ZFlktcyi4EMIGV-N9hS66pE3CTVmx4SqHC5wp5bIg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id da499d2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:47 +0200
Subject: [PATCH v3 04/17] odb/source-packed: store pointer to "files"
 instead of generic source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-4-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

The `struct odb_source_packed` holds a pointer to its owning parent
source. The way that Git is currently structured, this parent is always
the "files" source. In subsequent commits we're going to detangle that
so that the "packed" source doesn't have any owning parent source at
all, which makes it usable as a completely standalone source.

Detangling this mess is somewhat intricate though, and is made even more
intricate because it's not always clear which kind of source one is
holding at a specific point in time -- either the parent "files" source,
or the child "packed" source.

Make this relationship more explicit by storing a pointer to the "files"
source instead of storing a pointer to a generic `struct odb_source`.
This will help make subsequent steps a bit clearer by making it more
obvious whether we're using the generic "base" source or the owning
"files" source.

Note that this is a temporary step, only. At the end of this series
we will have dropped the "files" pointer completely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c |  4 ++--
 odb/source-packed.h |  4 ++--
 packfile.c          | 12 ++++++------
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 191562f316..e04525fb08 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -269,7 +269,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	CALLOC_ARRAY(files, 1);
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
 	files->loose = odb_source_loose_new(odb, path, local);
-	files->packed = odb_source_packed_new(&files->base);
+	files->packed = odb_source_packed_new(files);
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 1e94b47ea0..12e785be48 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -1,11 +1,11 @@
 #include "git-compat-util.h"
 #include "odb/source-packed.h"
 
-struct odb_source_packed *odb_source_packed_new(struct odb_source *source)
+struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 {
 	struct odb_source_packed *store;
 	CALLOC_ARRAY(store, 1);
-	store->source = source;
+	store->files = parent;
 	strmap_init(&store->packs_by_path);
 	return store;
 }
diff --git a/odb/source-packed.h b/odb/source-packed.h
index 327be4ad65..3c2d229a17 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -9,7 +9,7 @@
  * A store that manages packfiles for a given object database.
  */
 struct odb_source_packed {
-	struct odb_source *source;
+	struct odb_source_files *files;
 
 	/*
 	 * The list of packfiles in the order in which they have been most
@@ -67,6 +67,6 @@ struct odb_source_packed {
  * Allocate and initialize a new empty packfile store for the given object
  * database source.
  */
-struct odb_source_packed *odb_source_packed_new(struct odb_source *source);
+struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent);
 
 #endif
diff --git a/packfile.c b/packfile.c
index 99be5789ef..862a24ad49 100644
--- a/packfile.c
+++ b/packfile.c
@@ -802,7 +802,7 @@ struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 
 	p = strmap_get(&store->packs_by_path, key.buf);
 	if (!p) {
-		p = add_packed_git(store->source->odb->repo, idx_path,
+		p = add_packed_git(store->files->base.odb->repo, idx_path,
 				   strlen(idx_path), local);
 		if (p)
 			packfile_store_add_pack(store, p);
@@ -990,8 +990,8 @@ void packfile_store_prepare(struct odb_source_packed *store)
 	if (store->initialized)
 		return;
 
-	prepare_multi_pack_index_one(store->source);
-	prepare_packed_git_one(store->source);
+	prepare_multi_pack_index_one(&store->files->base);
+	prepare_packed_git_one(&store->files->base);
 
 	sort_packs(&store->packs.head, sort_pack);
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
@@ -1029,7 +1029,7 @@ int packfile_store_count_objects(struct odb_source_packed *store,
 	unsigned long count = 0;
 	int ret;
 
-	m = get_multi_pack_index(store->source);
+	m = get_multi_pack_index(&store->files->base);
 	if (m)
 		count += m->num_objects + m->num_objects_in_base;
 
@@ -2450,7 +2450,7 @@ static int packfile_store_for_each_prefixed_object(
 
 	store->skip_mru_updates = true;
 
-	m = get_multi_pack_index(store->source);
+	m = get_multi_pack_index(&store->files->base);
 	if (m) {
 		ret = for_each_prefixed_object_in_midx(store, m, opts, data);
 		if (ret)
@@ -2632,7 +2632,7 @@ int packfile_store_find_abbrev_len(struct odb_source_packed *store,
 	struct packfile_list_entry *e;
 	struct multi_pack_index *m;
 
-	m = get_multi_pack_index(store->source);
+	m = get_multi_pack_index(&store->files->base);
 	if (m)
 		find_abbrev_len_for_midx(m, oid, min_len, &min_len);
 

-- 
2.55.0.rc0.786.g65d90a0328.dirty

