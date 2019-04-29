Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0587C1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 16:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfD2QTA (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 12:19:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37968 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfD2QS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 12:18:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id w11so2939697edl.5
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HykRyu1IlBeHo+DHHUB9371iqlTPm/cQFdQro1v/lDU=;
        b=nRFnh+zneD/BkN8CRVunsuSYE6yjkxSsA1TZT7coG1Mzvf0R7EAzonJTFhVCPANnio
         BfsrpTfXdaCfiJ02eoWvNIyV9+IUF47ruX6EoRNwK6lrci6XOPlx4ybtdgyb3JVA6RCB
         QuXHCS8M9N0syqag60VLbkyCp4IpBpsmnPZLu3F7/V+QVW1By4/RiIwKxdJ8Q1sHizZG
         XumOpBEBfCKz6cDbItKLy6ISFa4ShA1XFHLljzy7Lm8Xs4aLw8al44x05FPegBws3nH6
         Ko4/BqLH2EfPpq0s4KtbF3gg2ebMghC4/POT9/VtXwg5wRlngW/Fy6ivcZ5RPn6wKiPq
         2auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HykRyu1IlBeHo+DHHUB9371iqlTPm/cQFdQro1v/lDU=;
        b=N4ag1N/1/E59n0HtKPfzh7ss5tUwj1t6R9pz37gHKExYiLpTrIJoj4XPnrkjH7/bcE
         d88Z2JxjTVODQfX9jLfdq0YXxyCXOhsh573wRo7jIQA7/L8aVxGAmHneJ0UNGjm8eb+d
         WViY8aMe3KcQHw0EIz+9uI8yyWdmYVnFSdl9L/gIpng6BRW6yNHIPJHSMZrPzUcP8jEf
         x4qY4znI1GKut9pGDXvim7SsMYKjjad/8eo22fweCn1mYEB3OElkEvMhGdU/ZBJahngD
         bHSFeBSTtvXHTE2hjq4Ouh7fiezevAMQiI8woFO2tK0NNIgf63YiqtEl7g3yz5msfY+w
         OuAw==
X-Gm-Message-State: APjAAAVZ/sHs0Lpkm93kD6V7MrFBYRWzpwSz7x1OQCQlAzy9WGLgB4Hv
        m3FlV3+nIS1SbkER4EgN5A8JQ42t
X-Google-Smtp-Source: APXvYqyQAHDs3AV0RzywDe7W8vdvoV56/Mxp98hsCWXDYwa13py+XekYuYj35vRWVHgyxT3zXDolzg==
X-Received: by 2002:a50:b4bb:: with SMTP id w56mr40101981edd.40.1556554736051;
        Mon, 29 Apr 2019 09:18:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h37sm478697edh.94.2019.04.29.09.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 09:18:55 -0700 (PDT)
Date:   Mon, 29 Apr 2019 09:18:55 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 16:18:53 GMT
Message-Id: <3b6324df4d26f47058a714abe47b9df7811c383e.1556554734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.182.git.gitgitgadget@gmail.com>
References: <pull.182.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] midx: pass a repository pointer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Much of the multi-pack-index code focuses on the multi_pack_index
struct, and so we only pass a pointer to the current one. However,
we will insert a dependency on the packed_git linked list in a
future change, so we will need a repository reference. Inserting
these parameters is a significant enough change to split out.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/multi-pack-index.c |  2 +-
 builtin/pack-objects.c     |  2 +-
 midx.c                     | 22 ++++++++++++++--------
 midx.h                     |  7 ++++---
 packfile.c                 |  4 ++--
 5 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index ae6e476ad5..72dfd3dadc 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -46,7 +46,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
-		return verify_midx_file(opts.object_dir);
+		return verify_midx_file(the_repository, opts.object_dir);
 
 	die(_("unrecognized verb: %s"), argv[0]);
 }
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2d9a3bdc9d..e606b9ef03 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1078,7 +1078,7 @@ static int want_object_in_pack(const struct object_id *oid,
 
 	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
 		struct pack_entry e;
-		if (fill_midx_entry(oid, &e, m)) {
+		if (fill_midx_entry(the_repository, oid, &e, m)) {
 			struct packed_git *p = e.p;
 			off_t offset;
 
diff --git a/midx.c b/midx.c
index d5d2e9522f..8b8faec35a 100644
--- a/midx.c
+++ b/midx.c
@@ -201,7 +201,7 @@ void close_midx(struct multi_pack_index *m)
 	FREE_AND_NULL(m->pack_names);
 }
 
-int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id)
+int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id)
 {
 	struct strbuf pack_name = STRBUF_INIT;
 
@@ -261,7 +261,10 @@ static uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 	return get_be32(m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH);
 }
 
-static int nth_midxed_pack_entry(struct multi_pack_index *m, struct pack_entry *e, uint32_t pos)
+static int nth_midxed_pack_entry(struct repository *r,
+				 struct multi_pack_index *m,
+				 struct pack_entry *e,
+				 uint32_t pos)
 {
 	uint32_t pack_int_id;
 	struct packed_git *p;
@@ -271,7 +274,7 @@ static int nth_midxed_pack_entry(struct multi_pack_index *m, struct pack_entry *
 
 	pack_int_id = nth_midxed_pack_int_id(m, pos);
 
-	if (prepare_midx_pack(m, pack_int_id))
+	if (prepare_midx_pack(r, m, pack_int_id))
 		die(_("error preparing packfile from multi-pack-index"));
 	p = m->packs[pack_int_id];
 
@@ -301,14 +304,17 @@ static int nth_midxed_pack_entry(struct multi_pack_index *m, struct pack_entry *
 	return 1;
 }
 
-int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m)
+int fill_midx_entry(struct repository * r,
+		    const struct object_id *oid,
+		    struct pack_entry *e,
+		    struct multi_pack_index *m)
 {
 	uint32_t pos;
 
 	if (!bsearch_midx(oid, m, &pos))
 		return 0;
 
-	return nth_midxed_pack_entry(m, e, pos);
+	return nth_midxed_pack_entry(r, m, e, pos);
 }
 
 /* Match "foo.idx" against either "foo.pack" _or_ "foo.idx". */
@@ -1020,7 +1026,7 @@ static int compare_pair_pos_vs_id(const void *_a, const void *_b)
 			display_progress(progress, _n); \
 	} while (0)
 
-int verify_midx_file(const char *object_dir)
+int verify_midx_file(struct repository *r, const char *object_dir)
 {
 	struct pair_pos_vs_id *pairs = NULL;
 	uint32_t i;
@@ -1034,7 +1040,7 @@ int verify_midx_file(const char *object_dir)
 	progress = start_progress(_("Looking for referenced packfiles"),
 				  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
-		if (prepare_midx_pack(m, i))
+		if (prepare_midx_pack(r, m, i))
 			midx_report("failed to load pack in position %d", i);
 
 		display_progress(progress, i + 1);
@@ -1099,7 +1105,7 @@ int verify_midx_file(const char *object_dir)
 
 		nth_midxed_object_oid(&oid, m, pairs[i].pos);
 
-		if (!fill_midx_entry(&oid, &e, m)) {
+		if (!fill_midx_entry(r, &oid, &e, m)) {
 			midx_report(_("failed to load pack entry for oid[%d] = %s"),
 				    pairs[i].pos, oid_to_hex(&oid));
 			continue;
diff --git a/midx.h b/midx.h
index 26dd042d63..3eb29731f2 100644
--- a/midx.h
+++ b/midx.h
@@ -5,6 +5,7 @@
 
 struct object_id;
 struct pack_entry;
+struct repository;
 
 #define GIT_TEST_MULTI_PACK_INDEX "GIT_TEST_MULTI_PACK_INDEX"
 
@@ -37,18 +38,18 @@ struct multi_pack_index {
 };
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
-int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id);
+int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n);
-int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
+int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
 int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
 int write_midx_file(const char *object_dir);
 void clear_midx_file(struct repository *r);
-int verify_midx_file(const char *object_dir);
+int verify_midx_file(struct repository *r, const char *object_dir);
 
 void close_midx(struct multi_pack_index *m);
 
diff --git a/packfile.c b/packfile.c
index cdf6b6ec34..7b94a14726 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1035,7 +1035,7 @@ struct packed_git *get_all_packs(struct repository *r)
 		for (m = r->objects->multi_pack_index; m; m = m->next) {
 			uint32_t i;
 			for (i = 0; i < m->num_packs; i++) {
-				if (!prepare_midx_pack(m, i)) {
+				if (!prepare_midx_pack(r, m, i)) {
 					m->packs[i]->next = p;
 					p = m->packs[i];
 				}
@@ -1998,7 +1998,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 		return 0;
 
 	for (m = r->objects->multi_pack_index; m; m = m->next) {
-		if (fill_midx_entry(oid, e, m))
+		if (fill_midx_entry(r, oid, e, m))
 			return 1;
 	}
 
-- 
gitgitgadget

