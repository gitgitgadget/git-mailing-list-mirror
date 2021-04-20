Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6765C43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863C6613CE
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhDTNBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhDTNBE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058A1C06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so10555587wmq.4
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FqPcX4gnwW2Dgru7wqkMzNr7+YlmS9N+ZP+y2U3v+I4=;
        b=MbDVE376ooy0sGHHP4H8CgaIHKQucPYTFcbCSbMRfnptDJ3b9Hag4kpJsUawWHkTJ3
         E2XpLtmycCRw0DhuUfJ+eqHTXgOwoTG1EiIaGLFav/I/16a35qWu3O/fEjdifv3XPgrs
         HE8AzMq+tnggyNUojhca2b8GQ7O1A83o+HClkZ7JSheye2VHEMI4ZJAzC5Rdu4PIAzPN
         nFY55aZ/JkPPOe17Dxjdg6w0Qctp0OAdappPJAK1OTxv9CESuU5/E8oLpjHrGbGQHqQG
         OX6MC5VYKVy4bbzwQosW/Nl2uf5mKeqHrUASp9PfV8FhSgbfkG6wcPCeVj7KBRSEnHXp
         o5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FqPcX4gnwW2Dgru7wqkMzNr7+YlmS9N+ZP+y2U3v+I4=;
        b=ittZeX1qP4r56nvWpE7PTrBQOWUx4NP3kCMS9XWQ2oKjh1WOcgx5M4594x/8gYLsO1
         xbMmhMXPCC9YgTLmMRTXjuaxvh4GfYOsIoPQWlsYpcHSkfJjt0u3l4UcmGLdx0/gVX7F
         ZtPMYZEzToCU3D+mFFH8zleGX5UiTU7zqDsd9H2U5Lr2mWEzGd1paWSvpMkPnK2+1SSV
         bQf8lNFSQv3wpCVuWK20OgU3Kv6Nz4v7mBLQ7+N9T1UXMdkW5YjwMAFGq3HE+VuoELkI
         a7DvJMuq1OBTg4npjljmL/Iq8E5HB2Io1k/C6LtzgNQWEJf43UXX/bPIEuTsfSEXYzZ0
         IdZw==
X-Gm-Message-State: AOAM530bIJRHwz1L1PHtQbhMp8+lmBdO0a4izyWn5PEafLNxMnJNPCEb
        am9b2isNEqzu13beYLnHiOw/+OHkzM+AIA==
X-Google-Smtp-Source: ABdhPJz6rZb8PIMwhNjRafFJUq1p2YX285+su/KXdTMXgWiJZPIonOB9+vPwwj2ffUi55sQ4ROQGKw==
X-Received: by 2002:a1c:720d:: with SMTP id n13mr4183800wmc.89.1618923631401;
        Tue, 20 Apr 2021 06:00:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm24452523wrt.74.2021.04.20.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:00:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] object-file.c: make oid_object_info() return "enum object_type"
Date:   Tue, 20 Apr 2021 15:00:10 +0200
Message-Id: <patch-04.10-fa97396517-20210420T125416Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change oid_object_info() to return an "enum object_type". Unlike
oid_object_info_extended() function the simpler oid_object_info()
explicitly returns the oi.typep member, which is itself an "enum
object_type".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c      |  2 +-
 builtin/index-pack.c |  2 +-
 object-file.c        |  8 +++-----
 object-name.c        | 19 +++++++++----------
 object-store.h       |  4 +++-
 packfile.c           |  2 +-
 6 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9a..5dd3c38a8c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -810,7 +810,7 @@ static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
 	oidcpy(&oid, oid_ret);
 	while (1) {
 		struct object *obj;
-		int kind = oid_object_info(r, &oid, NULL);
+		enum object_type kind = oid_object_info(r, &oid, NULL);
 		if (kind == OBJ_COMMIT) {
 			oidcpy(oid_ret, &oid);
 			return 0;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 15507b5cff..c0e3768c32 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -237,7 +237,7 @@ static unsigned check_object(struct object *obj)
 
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
-		int type = oid_object_info(the_repository, &obj->oid, &size);
+		enum object_type type = oid_object_info(the_repository, &obj->oid, &size);
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
diff --git a/object-file.c b/object-file.c
index 4af4748edd..398f2b60f9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1572,11 +1572,9 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 	return ret;
 }
 
-
-/* returns enum object_type or negative */
-int oid_object_info(struct repository *r,
-		    const struct object_id *oid,
-		    unsigned long *sizep)
+enum object_type oid_object_info(struct repository *r,
+				 const struct object_id *oid,
+				 unsigned long *sizep)
 {
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
diff --git a/object-name.c b/object-name.c
index 64202de60b..4d7f0c66cf 100644
--- a/object-name.c
+++ b/object-name.c
@@ -239,9 +239,8 @@ static int disambiguate_committish_only(struct repository *r,
 					void *cb_data_unused)
 {
 	struct object *obj;
-	int kind;
+	enum object_type kind = oid_object_info(r, oid, NULL);
 
-	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
@@ -258,7 +257,7 @@ static int disambiguate_tree_only(struct repository *r,
 				  const struct object_id *oid,
 				  void *cb_data_unused)
 {
-	int kind = oid_object_info(r, oid, NULL);
+	enum object_type kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_TREE;
 }
 
@@ -267,7 +266,7 @@ static int disambiguate_treeish_only(struct repository *r,
 				     void *cb_data_unused)
 {
 	struct object *obj;
-	int kind;
+	enum object_type kind;
 
 	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
@@ -286,7 +285,7 @@ static int disambiguate_blob_only(struct repository *r,
 				  const struct object_id *oid,
 				  void *cb_data_unused)
 {
-	int kind = oid_object_info(r, oid, NULL);
+	enum object_type kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_BLOB;
 }
 
@@ -361,7 +360,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 {
 	const struct disambiguate_state *ds = data;
 	struct strbuf desc = STRBUF_INIT;
-	int type;
+	enum object_type type;
 
 	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
 		return 0;
@@ -405,10 +404,10 @@ static int repo_collect_ambiguous(struct repository *r,
 static int sort_ambiguous(const void *a, const void *b, void *ctx)
 {
 	struct repository *sort_ambiguous_repo = ctx;
-	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
-	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
-	int a_type_sort;
-	int b_type_sort;
+	enum object_type a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
+	enum object_type b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
+	enum object_type a_type_sort;
+	enum object_type b_type_sort;
 
 	/*
 	 * Sorts by hash within the same object type, just as
diff --git a/object-store.h b/object-store.h
index ec32c23dcb..eab9674d08 100644
--- a/object-store.h
+++ b/object-store.h
@@ -208,7 +208,9 @@ static inline void *repo_read_object_file(struct repository *r,
 #endif
 
 /* Read and unpack an object file into memory, write memory to an object file */
-int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
+enum object_type oid_object_info(struct repository *r,
+				 const struct object_id *,
+				 unsigned long *);
 
 int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		     unsigned long len, const char *type,
diff --git a/packfile.c b/packfile.c
index 8668345d93..ccfebc0567 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1269,7 +1269,7 @@ static int retry_bad_packed_offset(struct repository *r,
 				   struct packed_git *p,
 				   off_t obj_offset)
 {
-	int type;
+	enum object_type type;
 	uint32_t pos;
 	struct object_id oid;
 	if (offset_to_pack_pos(p, obj_offset, &pos) < 0)
-- 
2.31.1.723.ga5d7868e4a

