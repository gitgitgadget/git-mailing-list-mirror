Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453931F453
	for <e@80x24.org>; Mon, 29 Apr 2019 16:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfD2QS7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 12:18:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37969 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfD2QS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 12:18:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id w11so2939701edl.5
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r2pGn9LJociYBAS0a9zIzsvKId8hEIgHXSKQDQIjmlQ=;
        b=LX6k/5aZA0FQAx5TFbsyFFVlMNXkVjjOdiedJzJ5EEZhlnJuNmK5IiGpO/amlqmnCA
         +/92EDM8T9kxloZ9JWtMkcdzqg1f8G/osFxrOic151jTyCujuXYdRQsvlIocC9nD8Pcy
         L9f+wBLOGp3+IDx/r9RCgITEkjVtTVbyLWtI3ipH4pCCuAL3uzL8/nUELXigVdXJfdtD
         D9UplNENQGKr7GPEM7vIyiPr7yxArMiDd2f6HDnEZH4W1WSviphLjw1i+EbsnjmxWdvH
         ujqZ1ZOFy67I2Z2glIP7ZCLeMIu5rx+ARghieP8HTjvnp0ydGOr38k6sSpQgnVHa7xmX
         eg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r2pGn9LJociYBAS0a9zIzsvKId8hEIgHXSKQDQIjmlQ=;
        b=QQq/ZsIqwl0CPA8GTsYznzgDWzgW6QDYc/EQ3G7WuOery2p5tQMC/Laa+fW2YGh7Gk
         HgVmsNgzIM6w2eAzFdNlD0fd0aJm4tM73L5u5QUWYKBrrsumXreBsq+zQ5OSR6e8QxAf
         Oob/s327kCEQeaq0qkWHqihocJpNo8AWymoqlfYiRsBsD5kBeio5+qNZDNMJLe0O1ft5
         C3hTIt7Tc00vRMhZK/quYIztxmmuD+h9Mj6whHIJWYxd4jSioySFxfk7BxE+vyR8PgLk
         FIFrJOmV2FutRLsPxd2KxjX8YVuD2DQJcxwhWgB+mkX/AMX94++9V2VuYJrAl1jysk3x
         f+5w==
X-Gm-Message-State: APjAAAW7tovgJgXlz3Wl4MJ7+VPMZSUxfLfA0ejsSCE9STBQrGtIzGQY
        ZshKj1OmTOZs56BtbZAzg8kdrre9
X-Google-Smtp-Source: APXvYqwRsonkho3PAAtCBraCmdowiSyfkP3CclXxG3zfqezXl1iEx8vWuz8+lDsVujWSt0TqTY5ekQ==
X-Received: by 2002:aa7:c403:: with SMTP id j3mr4395460edq.144.1556554736848;
        Mon, 29 Apr 2019 09:18:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11sm5895839ejq.59.2019.04.29.09.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 09:18:56 -0700 (PDT)
Date:   Mon, 29 Apr 2019 09:18:56 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 16:18:54 GMT
Message-Id: <6db8c5dce7073583a9bf3ab7bd7e4f9d74c015c4.1556554734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.182.git.gitgitgadget@gmail.com>
References: <pull.182.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] midx: add packs to packed_git linked list
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

The multi-pack-index allows searching for objects across multiple
packs using one object list. The original design gains many of
these performance benefits by keeping the packs in the
multi-pack-index out of the packed_git list.

Unfortunately, this has one major drawback. If the multi-pack-index
covers thousands of packs, and a command loads many of those packs,
then we can hit the limit for open file descriptors. The
close_one_pack() method is used to limit this resource, but it
only looks at the packed_git list, and uses an LRU cache to prevent
thrashing.

Instead of complicating this close_one_pack() logic to include
direct references to the multi-pack-index, simply add the packs
opened by the multi-pack-index to the packed_git list. This
immediately solves the file-descriptor limit problem, but requires
some extra steps to avoid performance issues or other problems:

1. Create a multi_pack_index bit in the packed_git struct that is
   one if and only if the pack was loaded from a multi-pack-index.

2. Skip packs with the multi_pack_index bit when doing object
   lookups and abbreviations. These algorithms already check the
   multi-pack-index before the packed_git struct. This has a very
   small performance hit, as we need to walk more packed_git
   structs. This is acceptable, since these operations run binary
   search on the other packs, so this walk-and-ignore logic is
   very fast by comparison.

3. When closing a multi-pack-index file, do not close its packs,
   as those packs will be closed using close_all_packs(). In some
   cases, such as 'git repack', we run 'close_midx()' without also
   closing the packs, so we need to un-set the multi_pack_index bit
   in those packs. This is necessary, and caught by running
   t6501-freshen-objects.sh with GIT_TEST_MULTI_PACK_INDEX=1.

To manually test this change, I inserted trace2 logging into
close_pack_fd() and set pack_max_fds to 10, then ran 'git rev-list
--all --objects' on a copy of the Git repo with 300+ pack-files and
a multi-pack-index. The logs verified the packs are closed as
we read them beyond the file descriptor limit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c         | 20 ++++++++++++++------
 object-store.h |  9 ++-------
 packfile.c     | 28 ++++++++--------------------
 sha1-name.c    |  6 ++++++
 4 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/midx.c b/midx.c
index 8b8faec35a..e7e1fe4d65 100644
--- a/midx.c
+++ b/midx.c
@@ -192,10 +192,8 @@ void close_midx(struct multi_pack_index *m)
 	m->fd = -1;
 
 	for (i = 0; i < m->num_packs; i++) {
-		if (m->packs[i]) {
-			close_pack(m->packs[i]);
-			free(m->packs[i]);
-		}
+		if (m->packs[i])
+			m->packs[i]->multi_pack_index = 0;
 	}
 	FREE_AND_NULL(m->packs);
 	FREE_AND_NULL(m->pack_names);
@@ -204,6 +202,7 @@ void close_midx(struct multi_pack_index *m)
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id)
 {
 	struct strbuf pack_name = STRBUF_INIT;
+	struct packed_git *p;
 
 	if (pack_int_id >= m->num_packs)
 		die(_("bad pack-int-id: %u (%u total packs)"),
@@ -215,9 +214,18 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t
 	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
 		    m->pack_names[pack_int_id]);
 
-	m->packs[pack_int_id] = add_packed_git(pack_name.buf, pack_name.len, m->local);
+	p = add_packed_git(pack_name.buf, pack_name.len, m->local);
 	strbuf_release(&pack_name);
-	return !m->packs[pack_int_id];
+
+	if (!p)
+		return 1;
+
+	p->multi_pack_index = 1;
+	m->packs[pack_int_id] = p;
+	install_packed_git(r, p);
+	list_add_tail(&p->mru, &r->objects->packed_git_mru);
+
+	return 0;
 }
 
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result)
diff --git a/object-store.h b/object-store.h
index b086f5ecdb..7acbc7fffe 100644
--- a/object-store.h
+++ b/object-store.h
@@ -76,7 +76,8 @@ struct packed_git {
 		 pack_keep_in_core:1,
 		 freshened:1,
 		 do_not_close:1,
-		 pack_promisor:1;
+		 pack_promisor:1,
+		 multi_pack_index:1;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct revindex_entry *revindex;
 	/* something like ".git/objects/pack/xxxxx.pack" */
@@ -128,12 +129,6 @@ struct raw_object_store {
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
 
-	/*
-	 * A linked list containing all packfiles, starting with those
-	 * contained in the multi_pack_index.
-	 */
-	struct packed_git *all_packs;
-
 	/*
 	 * A fast, rough count of the number of objects in the repository.
 	 * These two fields are not meant for direct access. Use
diff --git a/packfile.c b/packfile.c
index 7b94a14726..060de420d1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -994,8 +994,6 @@ static void prepare_packed_git(struct repository *r)
 	}
 	rearrange_packed_git(r);
 
-	r->objects->all_packs = NULL;
-
 	prepare_packed_git_mru(r);
 	r->objects->packed_git_initialized = 1;
 }
@@ -1026,26 +1024,16 @@ struct multi_pack_index *get_multi_pack_index(struct repository *r)
 
 struct packed_git *get_all_packs(struct repository *r)
 {
-	prepare_packed_git(r);
-
-	if (!r->objects->all_packs) {
-		struct packed_git *p = r->objects->packed_git;
-		struct multi_pack_index *m;
-
-		for (m = r->objects->multi_pack_index; m; m = m->next) {
-			uint32_t i;
-			for (i = 0; i < m->num_packs; i++) {
-				if (!prepare_midx_pack(r, m, i)) {
-					m->packs[i]->next = p;
-					p = m->packs[i];
-				}
-			}
-		}
+	struct multi_pack_index *m;
 
-		r->objects->all_packs = p;
+	prepare_packed_git(r);
+	for (m = r->objects->multi_pack_index; m; m = m->next) {
+		uint32_t i;
+		for (i = 0; i < m->num_packs; i++)
+			prepare_midx_pack(r, m, i);
 	}
 
-	return r->objects->all_packs;
+	return r->objects->packed_git;
 }
 
 struct list_head *get_packed_git_mru(struct repository *r)
@@ -2004,7 +1992,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 
 	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
-		if (fill_pack_entry(oid, e, p)) {
+		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
 			list_move(&p->mru, &r->objects->packed_git_mru);
 			return 1;
 		}
diff --git a/sha1-name.c b/sha1-name.c
index 07c71a7567..42ac1c5bb6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -157,6 +157,9 @@ static void unique_in_pack(struct packed_git *p,
 	uint32_t num, i, first = 0;
 	const struct object_id *current = NULL;
 
+	if (p->multi_pack_index)
+		return;
+
 	if (open_pack_index(p) || !p->num_objects)
 		return;
 
@@ -589,6 +592,9 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	struct object_id oid;
 	const struct object_id *mad_oid;
 
+	if (p->multi_pack_index)
+		return;
+
 	if (open_pack_index(p) || !p->num_objects)
 		return;
 
-- 
gitgitgadget
