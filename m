Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861D53D6CB1
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572351; cv=none; b=Dtcx/8pJOoNt/dOtmBPdPkkjAkjOJYAVSxmPg0M8O3hmCnmm32k7yMUxhjlNRVD0xijubkHpgdeDqquEUY/7+mkM2Alvpak3pBEULQP3qA6W5f9plQi7M8EDdKG2TC7/dZ2qEtHhqFOdAwcN5x9NZ9lnyiX44gMafwuP6unn6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572351; c=relaxed/simple;
	bh=5QM2HGHc2KCKj4FLMpagCOL3eD8aizb+AGnvb1EeZfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apzUx1Pj8XEveyjDcj6WgaLuMwcjAvhA7ndRkNGhrYsZQoXtT9Lx7zlstszHY8fY1Mv50HQYZ52cSnYbGvYet8+ujyVLTgq3XtFfTlzASDbrhqMZGKxBExVuo+Ef+3X6sv+HzaivdfVlK+66/kgkDuKqymYqAR1HzBoZv7exjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UsOGRA69; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cxlk3rA6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UsOGRA69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cxlk3rA6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C1414EC00CA
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:25:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Jun 2026 07:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572349;
	 x=1780658749; bh=Hbr4a9V4rtMUnf6KO/3bd8T0FG9x7I9tj1WFFBrvJaY=; b=
	UsOGRA69kdMlFeBej3seiz0ccXuhb8IIan9Hj92zYNaoO1JgXD7e152CO+HABR8V
	IqXZmAhYYrWyIIHtVsIPWouheHoU5Xn3F9b+ikk381rWaaLwapYd/xgH7eHgLXLW
	6dValrvtn1WK9kBtpDY+4EhoCFWDxI9dThMsZt0zMpKWIxhD2bRri/fkuMRLmSlT
	no8Wl6/9++FaOQ6oO7vQC7tbU2ijQOWz56J3+VGSEttItjzYdvFYALgzvqeMd0cz
	suz5UlyaKE2H+SfFO+eaup4YQxKSHoklDGgeEQ0ht7NDhf4Y1D61x8MTZs11UWFV
	4BwghCiKrozKlS5QFKgi+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572349; x=
	1780658749; bh=Hbr4a9V4rtMUnf6KO/3bd8T0FG9x7I9tj1WFFBrvJaY=; b=c
	xlk3rA6Eqh9cNdCuRLNEDzYMGlYWgrjC5w4G4MWtTiAF9f2rLfYU2S11R7ijYbw0
	KitQqdCdVMqPe0JMmBYsrXI/w46y89vQ2f8DPGisP3Zh98maeaUBKuJRHqfqdaSk
	JAeM0BnbQJg41aGKCTSIE5PDlhD9uuR3EpDrJV/DwVUZdue63ZUE02CvQj1/8Z5I
	NaZQeP4WwpxRx3Osp8wlp0FVhLI1jATKjlIpj+Iti0rsPIcYSwUHbN0oK9I6nsWH
	MTdSPt32eAAJLwkU7Ys3WZLquKTDmue1i81SgSohEoMTp8VmvN3WPmx3OxxTpSku
	kV0vwewKxS5TqLWyDof7A==
X-ME-Sender: <xms:vWAhagHR7gY6HpqzWEFthGsRXyjgUpHCGEuF7LUHb3Ps2WJnoVSsWw>
    <xme:vWAhagT4AbXOILLl18VvgHY4FlXFkfD-dod0ETsJm1jyuL68RuC5l51HQW-i8Nb8G
    kaJQco3Q9n0qJO_vv0aM7_-TU7AeGKJF_-5oTcDBUhOEsnVOw>
X-ME-Received: <xmr:vWAhavycfG4Bhriq019QF_mw2jsxthdQBb5q5UNZgjrA257N6hlQ1vb1BP87dulpqlCZg6fXyOEl4qbpDuJg6E3Qo76pIOQG4FsXaYU9v1I>
X-ME-Proxy-Cause: dmFkZTEgCyScvAHJZtwScmArpd3MPVD65pRFEMle7OxDyvGrBgzCBJpJZt/i/e/55qfMB2
    OZ+A4mOijyyVR7BQZ8gApb6Lys3WwA/DRBZO1Z6gq18/NjHv9k/YmqxGulaGbdjpGbGIe8
    TR7oy8jORNRJjZkYPAiPkwIOcJg76HwsAVLzInKh/aA4zWo5I7a3yFoBSrwplR1bXvqyzb
    7cwWjx66LW0j/HaZcKLdC3JWI1rUB6+uoj5Ia8HwsvfkXaZepnJEy9rr0yADWxKwm6t/hJ
    h4TWvBlU4kw/rB+rZbM4p/EdiFJ50OcReCBplYqL1Hq7W/DA0KsY8Jaj3WslUYFsjaCmK3
    nE5BpByWAvaKn/FizubjctgMD7V6NdaJRspZAWIH/jDclxg0eU+2T/nWuvwfzasv1s4Nb+
    wjo3lFDkX05A/oKDuhUWpSNkKX44XXwXG8OOOMP8C4Ai2Cy3NlAJLzE0WUUbdnugB56+Qf
    nQYzFCRnfQPgjCho3WcqIC+c1ek/6YeA+y0WZrRGe8Y2FDQkCi9rQTeh5XHv7L1aznjAGo
    n59FAssjQMwBpEV10ma14DiUXKQyyN0OyKrb/2nMrT0mz8C6WXAYG3y5uLNQEm4Gv2NsWA
    9zlbmxvdkfjgYWGFvwlcMg9c6Wk4d4CGBxdSyjTGB32DLLs00xk43vtbwhGg
X-ME-Proxy: <xmx:vWAhanPA3qi2OXIHFzfjPibWQNHcVz-G3T6s1UFRkN0RFc8mgmYclA>
    <xmx:vWAhamM46Mzd8PXAa6h0csAfsAaVO2is8FX1VTrpPUcw4Hknrg03Ng>
    <xmx:vWAhahThd3jJdEECBjmEzm7KY6D-8d_z6FukoRtU5f3JqGnM3255zg>
    <xmx:vWAhagDXseTCZun0in4OEJxCfQWRhSqIr9_5rpQoW1D0JP33j8W7YA>
    <xmx:vWAhaqUSIFT456Gd6DnXDk3w1gOZSudfiz-Az8gy1R9bz_aStzd76duK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:25:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 953854a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:25:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:31 +0200
Subject: [PATCH 04/16] odb/source-packed: start converting to a proper
 `struct odb_source`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-4-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Start converting `struct odb_source_packed` into a proper pluggable
`struct odb_source` by embedding the base struct and assigning it the
new `ODB_SOURCE_PACKED` type. Furthermore, wire up lifecycle management
of this source by implementing the `free` callback and taking ownership
of the chdir notifications.

Note that the packed source is not yet functional as a standalone `struct
odb_source`, as it's missing all of the callback implementations. These
will be wired up in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 odb/source-packed.h | 12 ++++++++++++
 odb/source.h        |  3 +++
 packfile.c          | 10 ----------
 packfile.h          |  6 ------
 6 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index e04525fb08..3608808e7c 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -29,7 +29,7 @@ static void odb_source_files_free(struct odb_source *source)
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
 	odb_source_free(&files->loose->base);
-	packfile_store_free(files->packed);
+	odb_source_free(&files->packed->base);
 	odb_source_release(&files->base);
 	free(files);
 }
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 12e785be48..f81a990cbd 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -1,11 +1,50 @@
 #include "git-compat-util.h"
+#include "abspath.h"
+#include "chdir-notify.h"
 #include "odb/source-packed.h"
+#include "packfile.h"
+
+static void odb_source_packed_reparent(const char *name UNUSED,
+				       const char *old_cwd,
+				       const char *new_cwd,
+				       void *cb_data)
+{
+	struct odb_source_packed *packed = cb_data;
+	char *path = reparent_relative_path(old_cwd, new_cwd,
+					    packed->base.path);
+	free(packed->base.path);
+	packed->base.path = path;
+}
+
+static void odb_source_packed_free(struct odb_source *source)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+
+	chdir_notify_unregister(NULL, odb_source_packed_reparent, packed);
+
+	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
+		free(e->pack);
+	packfile_list_clear(&packed->packs);
+
+	strmap_clear(&packed->packs_by_path, 0);
+	odb_source_release(&packed->base);
+	free(packed);
+}
 
 struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 {
-	struct odb_source_packed *store;
-	CALLOC_ARRAY(store, 1);
-	store->files = parent;
-	strmap_init(&store->packs_by_path);
-	return store;
+	struct odb_source_packed *packed;
+
+	CALLOC_ARRAY(packed, 1);
+	odb_source_init(&packed->base, parent->base.odb, ODB_SOURCE_PACKED,
+			parent->base.path, parent->base.local);
+	packed->files = parent;
+	strmap_init(&packed->packs_by_path);
+
+	packed->base.free = odb_source_packed_free;
+
+	if (!is_absolute_path(parent->base.path))
+		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
+
+	return packed;
 }
diff --git a/odb/source-packed.h b/odb/source-packed.h
index 6e5c79a77a..abe3310069 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -17,6 +17,7 @@ struct packfile_list_entry {
  * A store that manages packfiles for a given object database.
  */
 struct odb_source_packed {
+	struct odb_source base;
 	struct odb_source_files *files;
 
 	/*
@@ -77,4 +78,15 @@ struct odb_source_packed {
  */
 struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent);
 
+/*
+ * Cast the given object database source to the packed backend. This will cause
+ * a BUG in case the source doesn't use this backend.
+ */
+static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_source *source)
+{
+	if (source->type != ODB_SOURCE_PACKED)
+		BUG("trying to downcast source of type '%d' to packed", source->type);
+	return container_of(source, struct odb_source_packed, base);
+}
+
 #endif
diff --git a/odb/source.h b/odb/source.h
index 8bcb67787e..6865e1f71a 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -17,6 +17,9 @@ enum odb_source_type {
 	/* The "loose" backend that uses loose objects, only. */
 	ODB_SOURCE_LOOSE,
 
+	/* The "packed" backend that uses packfiles. */
+	ODB_SOURCE_PACKED,
+
 	/* The "in-memory" backend that stores objects in memory. */
 	ODB_SOURCE_INMEMORY,
 };
diff --git a/packfile.c b/packfile.c
index 2af07f5e1a..8fefc4358e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2832,16 +2832,6 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-void packfile_store_free(struct odb_source_packed *store)
-{
-	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
-		free(e->pack);
-	packfile_list_clear(&store->packs);
-
-	strmap_clear(&store->packs_by_path, 0);
-	free(store);
-}
-
 void packfile_store_close(struct odb_source_packed *store)
 {
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next) {
diff --git a/packfile.h b/packfile.h
index 6f76df3589..d6814b564e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -67,12 +67,6 @@ void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
 struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
 					  const struct object_id *oid);
 
-/*
- * Free the packfile store and all its associated state. All packfiles
- * tracked by the store will be closed.
- */
-void packfile_store_free(struct odb_source_packed *store);
-
 /*
  * Close all packfiles associated with this store. The packfiles won't be
  * free'd, so they can be re-opened at a later point in time.

-- 
2.54.0.1064.gd145956f57.dirty

