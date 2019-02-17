Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319EA1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfBQKKS (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45808 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKKR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id v21so4075739pfm.12
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc47mFbEhCe/rjci/bM5sRxXAnLBHajQDNlYl8qKTsc=;
        b=Fm6J5z9gAmiuB065xMAgm1YAyTE7Q6uyaXgMP6EIkcUb+VxqkoooLTQFWN2HCPVNBc
         5LgFQUzfu1Ey/nMX4DIcMdysE52sxB4r9KQPy5Mbx/Jvyxeo/2Prd8iMOT/MldaJkDgJ
         10MleFBmifzvX7bMPLqgdkf3ZG3Lyh7ZPG3JrVodsyMbCv/HfH9kbBYAzhqyna2avV+8
         2CCExKzJ5ADHD2dwNimqy0Y9qzwgcvIj3C02dY4/pUahHiDQQn9sCBt7xSQwwzxnUXnm
         AKXG6LWvHi/PZHljvw125p06o7uspAPMWdXlkOapQWo1hqGwGTn/CZlUqvNJZdFsJ6/8
         BZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc47mFbEhCe/rjci/bM5sRxXAnLBHajQDNlYl8qKTsc=;
        b=GoDdlfElcpzEwdvFh0y9XISFoHs3CSBvPQS41JUJneO5Oxp8h+t3/7sTiBERncF2T1
         rVs1KSUqqSITxMoYKDix8DK7AHddUsbNY9NF6VAZrGQR5xr9GqWQGFf+bebhyf4gqCbL
         5SSVByJNbVAvyer2lHiDcBmGmDM/EGUahBti7tN7HxVjtR6VTfcQusrR9230xh+8vClG
         7PJRPJhEtqqu0GD8a3IVykMx+7p3zl2RxkM6FLMdLC15fkf/seMPGqp1+zyUgzQeX8qt
         LyeF4tXgQLtgk//Ux0j378yfG9DdTv0FgXvLVQVshOonjbIV1t5o85R9XwB6eieTQo32
         P7KQ==
X-Gm-Message-State: AHQUAuZQ1+eUXB8jQw4ZxgKL7WDsTAygse5bF1Vl3kw3b0ie3xSKGNk1
        mdkY+6r3OyrPHOiNBbm+FlVCH2Wa
X-Google-Smtp-Source: AHgI3Ib9A+DMdhjWUbMyFnM1TMPxWU+tw2+BlifMKvlrdONWRlWQLEgBUsgs6SVkNYVDhhRGg0ARzg==
X-Received: by 2002:a63:7503:: with SMTP id q3mr12755110pgc.98.1550398216523;
        Sun, 17 Feb 2019 02:10:16 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y20sm17324923pfd.161.2019.02.17.02.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/31] sha1-name.c: store and use repo in struct disambiguate_state
Date:   Sun, 17 Feb 2019 17:08:55 +0700
Message-Id: <20190217100913.4127-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 95 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 36 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 9b57787b76..a75992eb54 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -17,13 +17,14 @@
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
-typedef int (*disambiguate_hint_fn)(const struct object_id *, void *);
+typedef int (*disambiguate_hint_fn)(struct repository *, const struct object_id *, void *);
 
 struct disambiguate_state {
 	int len; /* length of prefix in hex chars */
 	char hex_pfx[GIT_MAX_HEXSZ + 1];
 	struct object_id bin_pfx;
 
+	struct repository *repo;
 	disambiguate_hint_fn fn;
 	void *cb_data;
 	struct object_id candidate;
@@ -38,7 +39,7 @@ struct disambiguate_state {
 static void update_candidates(struct disambiguate_state *ds, const struct object_id *current)
 {
 	if (ds->always_call_fn) {
-		ds->ambiguous = ds->fn(current, ds->cb_data) ? 1 : 0;
+		ds->ambiguous = ds->fn(ds->repo, current, ds->cb_data) ? 1 : 0;
 		return;
 	}
 	if (!ds->candidate_exists) {
@@ -58,7 +59,7 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	}
 
 	if (!ds->candidate_checked) {
-		ds->candidate_ok = ds->fn(&ds->candidate, ds->cb_data);
+		ds->candidate_ok = ds->fn(ds->repo, &ds->candidate, ds->cb_data);
 		ds->disambiguate_fn_used = 1;
 		ds->candidate_checked = 1;
 	}
@@ -71,7 +72,7 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	}
 
 	/* if we reach this point, we know ds->candidate satisfies fn */
-	if (ds->fn(current, ds->cb_data)) {
+	if (ds->fn(ds->repo, current, ds->cb_data)) {
 		/*
 		 * if both current and candidate satisfy fn, we cannot
 		 * disambiguate.
@@ -89,9 +90,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	struct object_directory *odb;
 
-	for (odb = the_repository->objects->odb;
-	     odb && !ds->ambiguous;
-	     odb = odb->next) {
+	for (odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next) {
 		int pos;
 		struct oid_array *loose_objects;
 
@@ -182,10 +181,10 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 	struct multi_pack_index *m;
 	struct packed_git *p;
 
-	for (m = get_multi_pack_index(the_repository); m && !ds->ambiguous;
+	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
 	     m = m->next)
 		unique_in_midx(m, ds);
-	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
+	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -215,7 +214,7 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 		 * same repository!
 		 */
 		ds->candidate_ok = (!ds->disambiguate_fn_used ||
-				    ds->fn(&ds->candidate, ds->cb_data));
+				    ds->fn(ds->repo, &ds->candidate, ds->cb_data));
 
 	if (!ds->candidate_ok)
 		return SHORT_NAME_AMBIGUOUS;
@@ -224,59 +223,67 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 	return 0;
 }
 
-static int disambiguate_commit_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_commit_only(struct repository *r,
+				    const struct object_id *oid,
+				    void *cb_data_unused)
 {
-	int kind = oid_object_info(the_repository, oid, NULL);
+	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_COMMIT;
 }
 
-static int disambiguate_committish_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_committish_only(struct repository *r,
+					const struct object_id *oid,
+					void *cb_data_unused)
 {
 	struct object *obj;
 	int kind;
 
-	kind = oid_object_info(the_repository, oid, NULL);
+	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(the_repository, parse_object(the_repository, oid),
-			NULL, 0);
+	obj = deref_tag(r, parse_object(r, oid), NULL, 0);
 	if (obj && obj->type == OBJ_COMMIT)
 		return 1;
 	return 0;
 }
 
-static int disambiguate_tree_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_tree_only(struct repository *r,
+				  const struct object_id *oid,
+				  void *cb_data_unused)
 {
-	int kind = oid_object_info(the_repository, oid, NULL);
+	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_TREE;
 }
 
-static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_treeish_only(struct repository *r,
+				     const struct object_id *oid,
+				     void *cb_data_unused)
 {
 	struct object *obj;
 	int kind;
 
-	kind = oid_object_info(the_repository, oid, NULL);
+	kind = oid_object_info(r, oid, NULL);
 	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(the_repository, parse_object(the_repository, oid),
-			NULL, 0);
+	obj = deref_tag(r, parse_object(r, oid), NULL, 0);
 	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
 		return 1;
 	return 0;
 }
 
-static int disambiguate_blob_only(const struct object_id *oid, void *cb_data_unused)
+static int disambiguate_blob_only(struct repository *r,
+				  const struct object_id *oid,
+				  void *cb_data_unused)
 {
-	int kind = oid_object_info(the_repository, oid, NULL);
+	int kind = oid_object_info(r, oid, NULL);
 	return kind == OBJ_BLOB;
 }
 
@@ -310,7 +317,8 @@ int set_disambiguate_hint_config(const char *var, const char *value)
 	return error("unknown hint type for '%s': %s", var, value);
 }
 
-static int init_object_disambiguation(const char *name, int len,
+static int init_object_disambiguation(struct repository *r,
+				      const char *name, int len,
 				      struct disambiguate_state *ds)
 {
 	int i;
@@ -341,7 +349,8 @@ static int init_object_disambiguation(const char *name, int len,
 
 	ds->len = len;
 	ds->hex_pfx[len] = '\0';
-	prepare_alt_odb(the_repository);
+	ds->repo = r;
+	prepare_alt_odb(r);
 	return 0;
 }
 
@@ -351,25 +360,25 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	struct strbuf desc = STRBUF_INIT;
 	int type;
 
-	if (ds->fn && !ds->fn(oid, ds->cb_data))
+	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
 		return 0;
 
-	type = oid_object_info(the_repository, oid, NULL);
+	type = oid_object_info(ds->repo, oid, NULL);
 	if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(the_repository, oid);
+		struct commit *commit = lookup_commit(ds->repo, oid);
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
 			format_commit_message(commit, " %ad - %s", &desc, &pp);
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(the_repository, oid);
+		struct tag *tag = lookup_tag(ds->repo, oid);
 		if (!parse_tag(tag) && tag->tag)
 			strbuf_addf(&desc, " %s", tag->tag);
 	}
 
 	advise("  %s %s%s",
-	       find_unique_abbrev(oid, DEFAULT_ABBREV),
+	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
 	       type_name(type) ? type_name(type) : "unknown type",
 	       desc.buf);
 
@@ -383,6 +392,13 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static int repo_collect_ambiguous(struct repository *r,
+				  const struct object_id *oid,
+				  void *data)
+{
+	return collect_ambiguous(oid, data);
+}
+
 static struct repository *sort_ambiguous_repo;
 static int sort_ambiguous(const void *a, const void *b)
 {
@@ -428,7 +444,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
 
-	if (init_object_disambiguation(name, len, &ds) < 0)
+	if (init_object_disambiguation(the_repository, name, len, &ds) < 0)
 		return -1;
 
 	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
@@ -483,11 +499,11 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 	struct disambiguate_state ds;
 	int ret;
 
-	if (init_object_disambiguation(prefix, strlen(prefix), &ds) < 0)
+	if (init_object_disambiguation(the_repository, prefix, strlen(prefix), &ds) < 0)
 		return -1;
 
 	ds.always_call_fn = 1;
-	ds.fn = collect_ambiguous;
+	ds.fn = repo_collect_ambiguous;
 	ds.cb_data = &collect;
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
@@ -543,6 +559,13 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	return 0;
 }
 
+static int repo_extend_abbrev_len(struct repository *r,
+				  const struct object_id *oid,
+				  void *cb_data)
+{
+	return extend_abbrev_len(oid, cb_data);
+}
+
 static void find_abbrev_len_for_midx(struct multi_pack_index *m,
 				     struct min_abbrev_data *mad)
 {
@@ -668,10 +691,10 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 
 	find_abbrev_len_packed(&mad);
 
-	if (init_object_disambiguation(hex, mad.cur_len, &ds) < 0)
+	if (init_object_disambiguation(r, hex, mad.cur_len, &ds) < 0)
 		return -1;
 
-	ds.fn = extend_abbrev_len;
+	ds.fn = repo_extend_abbrev_len;
 	ds.always_call_fn = 1;
 	ds.cb_data = (void *)&mad;
 
-- 
2.21.0.rc0.328.g0e39304f8d

