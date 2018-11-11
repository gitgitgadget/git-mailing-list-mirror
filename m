Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371CD1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 07:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeKKQ54 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:57:56 -0500
Received: from mout.web.de ([212.227.17.11]:46139 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbeKKQ54 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:57:56 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2018 11:57:54 EST
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqUXd-1fqVj10ODB-00e6aU; Sun, 11
 Nov 2018 08:05:06 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] Upcast size_t variables to uintmax_t when printing
Date:   Sun, 11 Nov 2018 08:05:04 +0100
Message-Id: <20181111070504.12858-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1WYWo5R62Mvqb0wBAO9KMKj5zoxYDF5UNTuaNm2FKhv0RwfpMeC
 ryL4+7uswh9/+8mj7TJCpR5ChF2OG2Dkl4tuRRDkBD0NVaLi1kk7puNPKhlqCWt7r9sQHha
 U83tW++9lhhhAbiGWdChhXsZC5KpouBBjIfyPYB6QeIHyh59FPQDPvhb3gymr/KbjSKPvRl
 z6JnBI/wD880KPJl8P7sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UEpwk37MIhs=:bS+orQDbVL7exQckVjDckk
 +pWXwZn/gi2kldyPqnn2ul16OhgsfHOlWqElP8NqKtU/PELcFPJd5DDNxIhxTMiNi0hDCiYWk
 GEOwKNTmLFF4Gi/gVWHuQH5hnYLdGfc8z+rk9LJJubT1GHUccvf8egDJyzvaMHLm1OtzCNU1m
 myRjdkMj+s1GYHjpD6vIUWBrdudrYe2QDtOoTgmwwJsZfRHsZ7iZYhLKdk0pgwYitcj9//UJ8
 r9F7UMZeDqyMOSg0Cr//EI70g3t8I4wOae3rA7E1l6JfR9WlEMjFaS7nAvwuE21mbXxqpDI7I
 6+08VEUv+VJYxFExidwvUK+OKq56TtreEr5gs7WyMagxMP+SNJ+mBLwT9mFeJQMbsc0QAZ5K0
 LH+6gS3iMHGnJKskttG0GiESO4uJq6xvCGKkhBnu2IoGnY0wQVcFuYQnhuCTQ5jMqkwsHoG+C
 o1yqPPY/lEp16IKNHzP1QFrDb8j3sD2n07mtXqtphiwB/+AHFR+oHYRMYAGic3xPSaKMy4VvF
 U/aVojxT6jcX6UtMa/MXcms+QIcn5o6ZMmTHybAsR8lp1STrmMc9w65p/NAtTJg/WBj9k8Md9
 WawOd6u4R9ZiHEPnWypc1pxR6Ahcw4dDcxF4nQTr9oO+GwIA4JJ47QQ5KUoSJDdvAdUpagqoh
 F0TUyvOECzaotNWxepSrfgGoslfILP+aGjAeunqqo+7LSjUdxBg7JEzpZqf/RxcOoFa7hUd63
 SL1y5x8oBZV6bGvGtFvzS6wOgK4OuNESBCk1Q1vodAYfbyMCY1FVNOtcjqDEYPoTz09LTIzqE
 pn/wnSL16LJpnP/bbnpayMW/js9Ah0/C3LgMpdDTn53ASTqUCM51Z1NYsXIBD8GCcLcG3Skul
 I6WMdVh5Wp0y5sGSSlaMCIV7dFPP/4Ffk7sOF1qV2WYC1A8AJnCcm9cNoMrSS3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When printing variables which contain a size, today "unsigned long"
is used at many places.
In order to be able to change the type from "unsigned long" into size_t
some day in the future, we need to have a way to print 64 bit variables
on a system that has "unsigned long" defined to be 32 bit, like Win64.

Upcast all those variables into uintmax_t before they are printed.
This is to prepare for a bigger change, when "unsigned long"
will be converted into size_t for variables which may be > 4Gib.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

Changes since V1:
- fixed typos in the commit message, thanks to Eric  Sunshime for careful reading

Applying it on pu  gives 1 conflict from the index/repo changes,
Should be easy to fix.

archive-tar.c          |  2 +-
 builtin/cat-file.c     |  4 ++--
 builtin/fast-export.c  |  2 +-
 builtin/index-pack.c   |  9 +++++----
 builtin/ls-tree.c      |  2 +-
 builtin/pack-objects.c | 12 ++++++------
 diff.c                 |  2 +-
 fast-import.c          |  4 ++--
 http-push.c            |  2 +-
 ref-filter.c           |  2 +-
 sha1-file.c            |  6 +++---
 11 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 7a535cba24..a58e1a8ebf 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -202,7 +202,7 @@ static void prepare_header(struct archiver_args *args,
 			   unsigned int mode, unsigned long size)
 {
 	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
-	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? size : 0);
+	xsnprintf(header->size, sizeof(header->size), "%011"PRIoMAX , S_ISREG(mode) ? (uintmax_t)size : (uintmax_t)0);
 	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
 
 	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8d97c84725..05decee33f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -92,7 +92,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		oi.sizep = &size;
 		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
-		printf("%lu\n", size);
+		printf("%"PRIuMAX"\n", (uintmax_t)size);
 		return 0;
 
 	case 'e':
@@ -238,7 +238,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		if (data->mark_query)
 			data->info.sizep = &data->size;
 		else
-			strbuf_addf(sb, "%lu", data->size);
+			strbuf_addf(sb, "%"PRIuMAX , (uintmax_t)data->size);
 	} else if (is_atom("objectsize:disk", atom, len)) {
 		if (data->mark_query)
 			data->info.disk_sizep = &data->disk_size;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 456797c12a..5790f0d554 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -253,7 +253,7 @@ static void export_blob(const struct object_id *oid)
 
 	mark_next_object(object);
 
-	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
+	printf("blob\nmark :%"PRIu32"\ndata %"PRIuMAX"\n", last_idnum, (uintmax_t)size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
 		die_errno("could not write blob '%s'", oid_to_hex(oid));
 	printf("\n");
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2004e25da2..2a8ada432b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -450,7 +450,8 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 	int hdrlen;
 
 	if (!is_delta_type(type)) {
-		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), size) + 1;
+		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX,
+				   type_name(type),(uintmax_t)size) + 1;
 		the_hash_algo->init_fn(&c);
 		the_hash_algo->update_fn(&c, hdr, hdrlen);
 	} else
@@ -1628,10 +1629,10 @@ static void show_pack_info(int stat_only)
 			chain_histogram[obj_stat[i].delta_depth - 1]++;
 		if (stat_only)
 			continue;
-		printf("%s %-6s %lu %lu %"PRIuMAX,
+		printf("%s %-6s %"PRIuMAX" %"PRIuMAX" %"PRIuMAX,
 		       oid_to_hex(&obj->idx.oid),
-		       type_name(obj->real_type), obj->size,
-		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
+		       type_name(obj->real_type), (uintmax_t)obj->size,
+		       (uintmax_t)(obj[1].idx.offset - obj->idx.offset),
 		       (uintmax_t)obj->idx.offset);
 		if (is_delta_type(obj->type)) {
 			struct object_entry *bobj = &objects[obj_stat[i].base_object_no];
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index fe3b952cb3..7d581d6463 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -100,7 +100,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 						  "BAD");
 				else
 					xsnprintf(size_text, sizeof(size_text),
-						  "%lu", size);
+						  "%"PRIuMAX, (uintmax_t)size);
 			} else
 				xsnprintf(size_text, sizeof(size_text), "-");
 			printf("%06o %s %s %7s\t", mode, type,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c99ee79c31..0d3921e009 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2095,9 +2095,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 			die(_("object %s cannot be read"),
 			    oid_to_hex(&trg_entry->idx.oid));
 		if (sz != trg_size)
-			die(_("object %s inconsistent object length (%lu vs %lu)"),
-			    oid_to_hex(&trg_entry->idx.oid), sz,
-			    trg_size);
+			die(_("object %s inconsistent object length (%"PRIuMAX" vs %"PRIuMAX")"),
+			    oid_to_hex(&trg_entry->idx.oid), (uintmax_t)sz,
+			    (uintmax_t)trg_size);
 		*mem_usage += sz;
 	}
 	if (!src->data) {
@@ -2122,9 +2122,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 			    oid_to_hex(&src_entry->idx.oid));
 		}
 		if (sz != src_size)
-			die(_("object %s inconsistent object length (%lu vs %lu)"),
-			    oid_to_hex(&src_entry->idx.oid), sz,
-			    src_size);
+			die(_("object %s inconsistent object length (%"PRIuMAX" vs %"PRIuMAX")"),
+			    oid_to_hex(&src_entry->idx.oid), (uintmax_t)sz,
+			    (uintmax_t)src_size);
 		*mem_usage += sz;
 	}
 	if (!src->index) {
diff --git a/diff.c b/diff.c
index 8647db3d30..88aaed7d49 100644
--- a/diff.c
+++ b/diff.c
@@ -3227,7 +3227,7 @@ static void emit_binary_diff_body(struct diff_options *o,
 	}
 
 	if (delta && delta_size < deflate_size) {
-		char *s = xstrfmt("%lu", orig_size);
+		char *s = xstrfmt("%"PRIuMAX , (uintmax_t)orig_size);
 		emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_HEADER_DELTA,
 				 s, strlen(s), 0);
 		free(s);
diff --git a/fast-import.c b/fast-import.c
index 95600c78e0..69886687ce 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2955,8 +2955,8 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 		die("Object %s is a %s but a blob was expected.",
 		    oid_to_hex(oid), type_name(type));
 	strbuf_reset(&line);
-	strbuf_addf(&line, "%s %s %lu\n", oid_to_hex(oid),
-						type_name(type), size);
+	strbuf_addf(&line, "%s %s %"PRIuMAX"\n", oid_to_hex(oid),
+		    type_name(type), (uintmax_t)size);
 	cat_blob_write(line.buf, line.len);
 	strbuf_release(&line);
 	cat_blob_write(buf, size);
diff --git a/http-push.c b/http-push.c
index d1f52cbdf6..cd48590912 100644
--- a/http-push.c
+++ b/http-push.c
@@ -365,7 +365,7 @@ static void start_put(struct transfer_request *request)
 	git_zstream stream;
 
 	unpacked = read_object_file(&request->obj->oid, &type, &len);
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), len) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
 
 	/* Set it up */
 	git_deflate_init(&stream, zlib_compression_level);
diff --git a/ref-filter.c b/ref-filter.c
index 0c45ed9d94..aaac48ad14 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -878,7 +878,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 			v->s = xstrdup(type_name(oi->type));
 		else if (!strcmp(name, "objectsize")) {
 			v->value = oi->size;
-			v->s = xstrfmt("%lu", oi->size);
+			v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
 		}
 		else if (deref)
 			grab_objectname(name, &oi->oid, v, &used_atom[i]);
diff --git a/sha1-file.c b/sha1-file.c
index dd0b6aa873..4a67e0e759 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -833,7 +833,7 @@ int check_object_signature(const struct object_id *oid, void *map,
 		return -1;
 
 	/* Generate the header */
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(obj_type), size) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(obj_type), (uintmax_t)size) + 1;
 
 	/* Sha1.. */
 	the_hash_algo->init_fn(&c);
@@ -1492,7 +1492,7 @@ static void write_object_file_prepare(const void *buf, unsigned long len,
 	git_hash_ctx c;
 
 	/* Generate the header */
-	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %lu", type, len)+1;
+	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %"PRIuMAX , type, (uintmax_t)len)+1;
 
 	/* Sha1.. */
 	the_hash_algo->init_fn(&c);
@@ -1758,7 +1758,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	buf = read_object(oid->hash, &type, &len);
 	if (!buf)
 		return error(_("cannot read sha1_file for %s"), oid_to_hex(oid));
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), len) + 1;
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime);
 	free(buf);
 
-- 
2.19.0.271.gfe8321ec05

