Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CA3546F8
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351763; cv=none; b=CSGUpC6OiBEMBLK3mBEw5/mmqOJGbmiI7pc/42In3IbKvSibdM94CX3WjW35+BurvyonJ2vYXDwGrtkqodI7Lc+TFpR3LoyZw4oQC4/UA5oLC7WYoVhKeuxLwQlD6rXZEi1sOIiWj5P786kAmc5BaxccvcXO8TVkH20dizpb5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351763; c=relaxed/simple;
	bh=IWt+U+2vE9bj7f5460o3Br3eFn1cCtDfcPZYXnssjuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=soA+D2fuBzbKa4a6iG5IYGDPG/7Q4cYc2BFEQoD0LAufV++verTT/6XPksmHrEvcCeLlNq/gXErTN300v3X5Biy+J6o9foCnlUryS/6ZLZxzQonKYRNa6oNuIRGFUXLKKrSrtfUxTZ9MRN05fhScNEmqESNfyWF6maw+P4I1qFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q+Qk/jdo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d2tC+YUv; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q+Qk/jdo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d2tC+YUv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 83578EC0067
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 04:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351758;
	 x=1779438158; bh=DVAQpj9JF5BVE7NzsuJ3yMxICJR83rS8v7mGb8h+h30=; b=
	Q+Qk/jdodt4bqvEtbuTxcCxNp01u/4WP8TVsPdB35EPOv6Q+JUKpxenTFytrME7v
	s5YgGmiZZxYOFYNMsOahno3KkzRPDiRfELu6+mAsznubJEWRrMQR6AI3ButMOtRd
	eJA1p2aVKRwD0hqlx8wu/4tuUEnysfL50tueDK7G9w1cq4HL0gpFjDqnbaSbS/TD
	BkTpP9xvWYrO68pXBE9N7vBkKW4d3SIpCBnMZfMqILoyJEYcuqk7eHPA2V2iIc/B
	JCOHonvplJk+qyIcPlkbkeZk0JPOz6I6Rii8YuIuitgmm8/4nG4YUx02jW3SRBtU
	p0EP+2W/UEzq0lS8NxrBuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351758; x=
	1779438158; bh=DVAQpj9JF5BVE7NzsuJ3yMxICJR83rS8v7mGb8h+h30=; b=d
	2tC+YUv1GWZ5eOeMnkYa9UpD/rnG5g4FyoQAT145EXlWKvesTEc9DlDnqxRYxsXu
	BgC2XMxry4KLgo6IOcJZgBUta51eBlnjU5NWPQgxK2z0dKt0ywFFo1KISRUoksQK
	ueEzvA9BOwVYDWR+fwDbQvSh8PvdGthkl6ihOykLmR+YGWCMO4L6CpYcN68VoIc8
	YSOBUskQumR54RDKKT3MBb07KMse8pnOZzYY/r+asI/IxmrbueivVbjmaS58+KFf
	kka8MxNl1xsRJXw3Kq2BuRZEonZuGSDBCOdWa3+ZYogZNyYY5gpfT57Rl37tI2NP
	8XwBhP98qLwWunQUm2CgA==
X-ME-Sender: <xms:zsAOaocF_VETxsf6lliZllrGjLz6_0VliuNfkijQ-1b02w3dbV5S0w>
    <xme:zsAOahK5xgwgtNIQlV4y-4nISWlIYsLH6eV2212G34wiM-t7HzZHPbjngbEuTcJ63
    r_Pqycy8sIqyWevYkADfyLVdyRDLDul8orXGS9N-lsBA4406SbEL-A>
X-ME-Received: <xmr:zsAOavJjna_QEHDLMnmpD1nPZDv7eValoJU71p6Gcsi6wcrDRKdNQAmEND8g1SgnvoqtSgfAJliSvVZoBf7mSAYglsBY-Ejr8zZvgIs0QMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:zsAOajF7XJV5H2omLQmLh-gib0rfiubY08_9sj6PbJc2h7ggAezAhQ>
    <xmx:zsAOaklvX1-tPYw5NqXtZAl9W6BjWxubFqDUfKooKByPPjfvxIabTg>
    <xmx:zsAOagLllAAqSRMxyheW6GsH7kqvrw39hXdc2VAR5-1Re9SqcK5rNA>
    <xmx:zsAOalZX_O09m4GDgcGdEorh7EtFjLdquTCmSHo0qVETuvBt6xFaqg>
    <xmx:zsAOauP4mTnvmSh4Y0qkcyZRSj_Ab0qsQ5sElVwg5yYtYNij5uSrQzru>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4dd47cfc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:23 +0200
Subject: [PATCH 03/18] odb/source-loose: start converting to a proper
 `struct odb_source`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-3-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Start converting `struct odb_source_loose` into a proper pluggable
`struct odb_source` by embedding the base struct and assigning it the
new `ODB_SOURCE_LOOSE` type. Furthermore, wire up lifecycle management
of this source by implementing the `free` callback and taking ownership
of the chdir notifications.

Note that the loose source is not yet functional as a standalone `struct
odb_source`, as it's missing all of the callback implementations. These
will be wired up in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 17 -----------------
 object-file.h      |  2 --
 odb/source-files.c |  2 +-
 odb/source-loose.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 odb/source-loose.h | 14 ++++++++++++++
 odb/source.h       |  3 +++
 6 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/object-file.c b/object-file.c
index 7a1908bfc0..977d959d33 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2041,14 +2041,6 @@ static struct oidtree *odb_source_loose_cache(struct odb_source *source,
 	return files->loose->cache;
 }
 
-static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
-{
-	oidtree_clear(loose->cache);
-	FREE_AND_NULL(loose->cache);
-	memset(&loose->subdir_seen, 0,
-	       sizeof(loose->subdir_seen));
-}
-
 void odb_source_loose_reprepare(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
@@ -2205,15 +2197,6 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 	return &transaction->base;
 }
 
-void odb_source_loose_free(struct odb_source_loose *loose)
-{
-	if (!loose)
-		return;
-	odb_source_loose_clear_cache(loose);
-	loose_object_map_clear(&loose->map);
-	free(loose);
-}
-
 struct odb_loose_read_stream {
 	struct odb_read_stream base;
 	git_zstream z;
diff --git a/object-file.h b/object-file.h
index 1d8312cf7f..02c9680980 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,8 +21,6 @@ struct object_info;
 struct odb_read_stream;
 struct odb_source;
 
-void odb_source_loose_free(struct odb_source_loose *loose);
-
 /* Reprepare the loose source by emptying the loose object cache. */
 void odb_source_loose_reprepare(struct odb_source *source);
 
diff --git a/odb/source-files.c b/odb/source-files.c
index 185cc6903e..ccc637311b 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -27,7 +27,7 @@ static void odb_source_files_free(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
-	odb_source_loose_free(files->loose);
+	odb_source_free(&files->loose->base);
 	packfile_store_free(files->packed);
 	odb_source_release(&files->base);
 	free(files);
diff --git a/odb/source-loose.c b/odb/source-loose.c
index c9e7414814..92e18f5adb 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -1,10 +1,55 @@
 #include "git-compat-util.h"
+#include "abspath.h"
+#include "chdir-notify.h"
+#include "loose.h"
+#include "odb.h"
+#include "odb/source-files.h"
 #include "odb/source-loose.h"
+#include "oidtree.h"
+
+void odb_source_loose_clear_cache(struct odb_source_loose *loose)
+{
+	oidtree_clear(loose->cache);
+	FREE_AND_NULL(loose->cache);
+	memset(&loose->subdir_seen, 0,
+	       sizeof(loose->subdir_seen));
+}
+
+static void odb_source_loose_reparent(const char *name UNUSED,
+				      const char *old_cwd,
+				      const char *new_cwd,
+				      void *cb_data)
+{
+	struct odb_source_loose *loose = cb_data;
+	char *path = reparent_relative_path(old_cwd, new_cwd,
+					    loose->base.path);
+	free(loose->base.path);
+	loose->base.path = path;
+}
+
+static void odb_source_loose_free(struct odb_source *source)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	odb_source_loose_clear_cache(loose);
+	loose_object_map_clear(&loose->map);
+	chdir_notify_unregister(NULL, odb_source_loose_reparent, loose);
+	odb_source_release(&loose->base);
+	free(loose);
+}
 
 struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 {
 	struct odb_source_loose *loose;
+
 	CALLOC_ARRAY(loose, 1);
+	odb_source_init(&loose->base, files->base.odb, ODB_SOURCE_LOOSE,
+			files->base.path, files->base.local);
 	loose->files = files;
+
+	loose->base.free = odb_source_loose_free;
+
+	if (!is_absolute_path(loose->base.path))
+		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
+
 	return loose;
 }
diff --git a/odb/source-loose.h b/odb/source-loose.h
index bf61e767c8..441da9e418 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -12,6 +12,7 @@ struct oidtree;
  * file per object. This source is part of the files source.
  */
 struct odb_source_loose {
+	struct odb_source base;
 	struct odb_source_files *files;
 
 	/*
@@ -32,4 +33,17 @@ struct odb_source_loose {
 
 struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files);
 
+/*
+ * Cast the given object database source to the loose backend. This will cause
+ * a BUG in case the source uses doesn't use this backend.
+ */
+static inline struct odb_source_loose *odb_source_loose_downcast(struct odb_source *source)
+{
+	if (source->type != ODB_SOURCE_LOOSE)
+		BUG("trying to downcast source of type '%d' to loose", source->type);
+	return container_of(source, struct odb_source_loose, base);
+}
+
+void odb_source_loose_clear_cache(struct odb_source_loose *loose);
+
 #endif
diff --git a/odb/source.h b/odb/source.h
index 0a440884e4..8bcb67787e 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -14,6 +14,9 @@ enum odb_source_type {
 	/* The "files" backend that uses loose objects and packfiles. */
 	ODB_SOURCE_FILES,
 
+	/* The "loose" backend that uses loose objects, only. */
+	ODB_SOURCE_LOOSE,
+
 	/* The "in-memory" backend that stores objects in memory. */
 	ODB_SOURCE_INMEMORY,
 };

-- 
2.54.0.926.g75ba10bac6.dirty

