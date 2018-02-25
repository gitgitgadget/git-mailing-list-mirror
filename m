Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7922F1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBYVOB (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:14:01 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751904AbeBYVMg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:36 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 16ABC60E51;
        Sun, 25 Feb 2018 21:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593154;
        bh=3DGfWVjm1F2pCHqI0w4a4tbedSQ+ZPOuU2fTt8bJ7KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BRh0Ji/+tgM7T/gwUZk/0entjtJidB1vinm/yzltB4g2jLFMjd+/pcug7HhNTDQS3
         uRtdaP4e7BFnvT8YopFQyqxJ+DmXcqItv4g+FqFEPd3FhWcRW7aNkhSiC+MtizGnor
         ASMRhA2EEmot5BC1nd324invkdcpCUKRwpUJrl20SEnj2TGITDtsQ8nqh1TmcaFlxx
         HSDUoJ8K9xrDVQoBXPX+JFhm8pJVIWIzxbuNQpBVCeGoRamqMCKsE8HCUkyJNSJCwD
         AQ+TZ04wZ2DeR3dnS4VRUU5e2tXSkbkFgvalTQHHBpRWhrHCPLLLUowqADAN6gqwk1
         6dZBZHSzQMb5MwdWQfWt0EmQEkZhNMKlV4/GuVXPua9JqHlJbPrmMPKMg3ByRuUqGO
         RRqdGuxiLVy8s67YS5c5+LmDORNetG+uEsuzyaQxAAEVp7yTcQhdPYXYFax6nD+8UJ
         K7pFBkGrjQr36KEIvvfl9hQ1fhRy8tMCpoxa+NEbVMdtEtxDZFV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/36] Convert find_unique_abbrev* to struct object_id
Date:   Sun, 25 Feb 2018 21:11:46 +0000
Message-Id: <20180225211212.477570-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert find_unique_abbrev and find_unique_abbrev_r to each take a
pointer to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/blame.c        |  2 +-
 builtin/branch.c       |  2 +-
 builtin/checkout.c     |  6 +++---
 builtin/describe.c     |  4 ++--
 builtin/log.c          |  4 ++--
 builtin/ls-files.c     |  4 ++--
 builtin/ls-tree.c      |  4 ++--
 builtin/merge.c        |  6 +++---
 builtin/name-rev.c     |  2 +-
 builtin/receive-pack.c |  8 ++++----
 builtin/reset.c        |  2 +-
 builtin/rev-list.c     |  2 +-
 builtin/rev-parse.c    |  2 +-
 builtin/show-branch.c  |  2 +-
 builtin/show-ref.c     |  4 ++--
 builtin/tag.c          |  6 ++++--
 builtin/worktree.c     |  4 ++--
 cache.h                |  6 +++---
 combine-diff.c         |  4 ++--
 diff.c                 |  2 +-
 log-tree.c             | 12 ++++++------
 ref-filter.c           |  4 ++--
 sequencer.c            |  2 +-
 sha1_name.c            | 12 ++++++------
 strbuf.c               |  2 +-
 tag.c                  |  4 ++--
 transport.c            |  2 +-
 wt-status.c            |  6 +++---
 28 files changed, 61 insertions(+), 59 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 005f55aaa2..21b496517a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -499,7 +499,7 @@ static int read_ancestry(const char *graft_file)
 
 static int update_auto_abbrev(int auto_abbrev, struct blame_origin *suspect)
 {
-	const char *uniq = find_unique_abbrev(suspect->commit->object.oid.hash,
+	const char *uniq = find_unique_abbrev(&suspect->commit->object.oid,
 					      auto_abbrev);
 	int len = strlen(uniq);
 	if (auto_abbrev < len)
diff --git a/builtin/branch.c b/builtin/branch.c
index 8dcc2ed058..659deb36f3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -273,7 +273,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			       bname.buf,
 			       (flags & REF_ISBROKEN) ? "broken"
 			       : (flags & REF_ISSYMREF) ? target
-			       : find_unique_abbrev(oid.hash, DEFAULT_ABBREV));
+			       : find_unique_abbrev(&oid, DEFAULT_ABBREV));
 		}
 		delete_branch_config(bname.buf);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bc68d423e5..e6ee955671 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -405,10 +405,10 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
 	if (print_sha1_ellipsis()) {
 		fprintf(stderr, "%s %s... %s\n", msg,
-			find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
+			find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV), sb.buf);
 	} else {
 		fprintf(stderr, "%s %s %s\n", msg,
-			find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
+			find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV), sb.buf);
 	}
 	strbuf_release(&sb);
 }
@@ -778,7 +778,7 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 			" git branch <new-branch-name> %s\n\n",
 			/* Give ngettext() the count */
 			lost),
-			find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
+			find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV));
 }
 
 /*
diff --git a/builtin/describe.c b/builtin/describe.c
index c428984706..dc5c3aa9f9 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -285,7 +285,7 @@ static void append_name(struct commit_name *n, struct strbuf *dst)
 
 static void append_suffix(int depth, const struct object_id *oid, struct strbuf *dst)
 {
-	strbuf_addf(dst, "-%d-g%s", depth, find_unique_abbrev(oid->hash, abbrev));
+	strbuf_addf(dst, "-%d-g%s", depth, find_unique_abbrev(oid, abbrev));
 }
 
 static void describe_commit(struct object_id *oid, struct strbuf *dst)
@@ -383,7 +383,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	if (!match_cnt) {
 		struct object_id *cmit_oid = &cmit->object.oid;
 		if (always) {
-			strbuf_add_unique_abbrev(dst, cmit_oid->hash, abbrev);
+			strbuf_add_unique_abbrev(dst, cmit_oid, abbrev);
 			if (suffix)
 				strbuf_addstr(dst, suffix);
 			return;
diff --git a/builtin/log.c b/builtin/log.c
index 32a744bfd2..411339c1ed 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1873,12 +1873,12 @@ static void print_commit(char sign, struct commit *commit, int verbose,
 {
 	if (!verbose) {
 		fprintf(file, "%c %s\n", sign,
-		       find_unique_abbrev(commit->object.oid.hash, abbrev));
+		       find_unique_abbrev(&commit->object.oid, abbrev));
 	} else {
 		struct strbuf buf = STRBUF_INIT;
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
 		fprintf(file, "%c %s %s\n", sign,
-		       find_unique_abbrev(commit->object.oid.hash, abbrev),
+		       find_unique_abbrev(&commit->object.oid, abbrev),
 		       buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 9df66ba307..a71f6bd088 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -240,7 +240,7 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 			printf("%s%06o %s %d\t",
 			       tag,
 			       ce->ce_mode,
-			       find_unique_abbrev(ce->oid.hash, abbrev),
+			       find_unique_abbrev(&ce->oid, abbrev),
 			       ce_stage(ce));
 		}
 		write_eolinfo(repo->index, ce, fullname);
@@ -271,7 +271,7 @@ static void show_ru_info(const struct index_state *istate)
 			if (!ui->mode[i])
 				continue;
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
-			       find_unique_abbrev(ui->oid[i].hash, abbrev),
+			       find_unique_abbrev(&ui->oid[i], abbrev),
 			       i + 1);
 			write_name(path);
 		}
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c613dd7b82..c98253adbb 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -103,11 +103,11 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			} else
 				xsnprintf(size_text, sizeof(size_text), "-");
 			printf("%06o %s %s %7s\t", mode, type,
-			       find_unique_abbrev(oid->hash, abbrev),
+			       find_unique_abbrev(oid, abbrev),
 			       size_text);
 		} else
 			printf("%06o %s %s\t", mode, type,
-			       find_unique_abbrev(oid->hash, abbrev));
+			       find_unique_abbrev(oid, abbrev));
 	}
 	baselen = base->len;
 	strbuf_addstr(base, pathname);
diff --git a/builtin/merge.c b/builtin/merge.c
index 861b170468..66cdaa5e0b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1289,7 +1289,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 			check_commit_signature(commit, &signature_check);
 
-			find_unique_abbrev_r(hex, commit->object.oid.hash, DEFAULT_ABBREV);
+			find_unique_abbrev_r(hex, &commit->object.oid, DEFAULT_ABBREV);
 			switch (signature_check.result) {
 			case 'G':
 				break;
@@ -1385,9 +1385,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		if (verbosity >= 0) {
 			printf(_("Updating %s..%s\n"),
-			       find_unique_abbrev(head_commit->object.oid.hash,
+			       find_unique_abbrev(&head_commit->object.oid,
 						  DEFAULT_ABBREV),
-			       find_unique_abbrev(remoteheads->item->object.oid.hash,
+			       find_unique_abbrev(&remoteheads->item->object.oid,
 						  DEFAULT_ABBREV));
 		}
 		strbuf_addstr(&msg, "Fast-forward");
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 9e088ebd11..387ddf85d2 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -328,7 +328,7 @@ static void show_name(const struct object *obj,
 	else if (allow_undefined)
 		printf("undefined\n");
 	else if (always)
-		printf("%s\n", find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
+		printf("%s\n", find_unique_abbrev(oid, DEFAULT_ABBREV));
 	else
 		die("cannot describe '%s'", oid_to_hex(oid));
 	strbuf_release(&buf);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 75e7f18ace..2bf7f2d1a3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1242,11 +1242,11 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	rp_error("refusing inconsistent update between symref '%s' (%s..%s) and"
 		 " its target '%s' (%s..%s)",
 		 cmd->ref_name,
-		 find_unique_abbrev(cmd->old_oid.hash, DEFAULT_ABBREV),
-		 find_unique_abbrev(cmd->new_oid.hash, DEFAULT_ABBREV),
+		 find_unique_abbrev(&cmd->old_oid, DEFAULT_ABBREV),
+		 find_unique_abbrev(&cmd->new_oid, DEFAULT_ABBREV),
 		 dst_cmd->ref_name,
-		 find_unique_abbrev(dst_cmd->old_oid.hash, DEFAULT_ABBREV),
-		 find_unique_abbrev(dst_cmd->new_oid.hash, DEFAULT_ABBREV));
+		 find_unique_abbrev(&dst_cmd->old_oid, DEFAULT_ABBREV),
+		 find_unique_abbrev(&dst_cmd->new_oid, DEFAULT_ABBREV));
 
 	cmd->error_string = dst_cmd->error_string =
 		"inconsistent aliased update";
diff --git a/builtin/reset.c b/builtin/reset.c
index 5da0f75de9..7f1c3f02a3 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -109,7 +109,7 @@ static void print_new_head_line(struct commit *commit)
 	struct strbuf buf = STRBUF_INIT;
 
 	printf(_("HEAD is now at %s"),
-		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
+		find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV));
 
 	pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
 	if (buf.len > 0)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 48300d9e11..71afab5388 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -108,7 +108,7 @@ static void show_commit(struct commit *commit, void *data)
 	if (!revs->graph)
 		fputs(get_revision_mark(revs, commit), stdout);
 	if (revs->abbrev_commit && revs->abbrev)
-		fputs(find_unique_abbrev(commit->object.oid.hash, revs->abbrev),
+		fputs(find_unique_abbrev(&commit->object.oid, revs->abbrev),
 		      stdout);
 	else
 		fputs(oid_to_hex(&commit->object.oid), stdout);
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 96d06a5d01..fd16f9fad8 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -159,7 +159,7 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
 		}
 	}
 	else if (abbrev)
-		show_with_type(type, find_unique_abbrev(oid->hash, abbrev));
+		show_with_type(type, find_unique_abbrev(oid, abbrev));
 	else
 		show_with_type(type, oid_to_hex(oid));
 }
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e8a4aa40cb..6c2148b71d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -292,7 +292,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 		}
 		else
 			printf("[%s] ",
-			       find_unique_abbrev(commit->object.oid.hash,
+			       find_unique_abbrev(&commit->object.oid,
 						  DEFAULT_ABBREV));
 	}
 	puts(pretty_str);
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 41e5e71cad..f2eb1a7724 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -29,7 +29,7 @@ static void show_one(const char *refname, const struct object_id *oid)
 	if (quiet)
 		return;
 
-	hex = find_unique_abbrev(oid->hash, abbrev);
+	hex = find_unique_abbrev(oid, abbrev);
 	if (hash_only)
 		printf("%s\n", hex);
 	else
@@ -39,7 +39,7 @@ static void show_one(const char *refname, const struct object_id *oid)
 		return;
 
 	if (!peel_ref(refname, &peeled)) {
-		hex = find_unique_abbrev(peeled.hash, abbrev);
+		hex = find_unique_abbrev(&peeled, abbrev);
 		printf("%s %s^{}\n", hex, refname);
 	}
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index 99dba2d907..17d6bc0836 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -99,7 +99,8 @@ static int delete_tag(const char *name, const char *ref,
 {
 	if (delete_ref(NULL, ref, oid, 0))
 		return 1;
-	printf(_("Deleted tag '%s' (was %s)\n"), name, find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
+	printf(_("Deleted tag '%s' (was %s)\n"), name,
+	       find_unique_abbrev(oid, DEFAULT_ABBREV));
 	return 0;
 }
 
@@ -551,7 +552,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
 	if (force && !is_null_oid(&prev) && oidcmp(&prev, &object))
-		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev.hash, DEFAULT_ABBREV));
+		printf(_("Updated tag '%s' (was %s)\n"), tag,
+		       find_unique_abbrev(&prev, DEFAULT_ABBREV));
 
 	UNLEAK(buf);
 	UNLEAK(ref);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9efdc22466..dba1f90111 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -484,7 +484,7 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 		strbuf_addstr(&sb, "(bare)");
 	else {
 		strbuf_addf(&sb, "%-*s ", abbrev_len,
-				find_unique_abbrev(wt->head_oid.hash, DEFAULT_ABBREV));
+				find_unique_abbrev(&wt->head_oid, DEFAULT_ABBREV));
 		if (wt->is_detached)
 			strbuf_addstr(&sb, "(detached HEAD)");
 		else if (wt->head_ref) {
@@ -509,7 +509,7 @@ static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
 
 		if (path_len > *maxlen)
 			*maxlen = path_len;
-		sha1_len = strlen(find_unique_abbrev(wt[i]->head_oid.hash, *abbrev));
+		sha1_len = strlen(find_unique_abbrev(&wt[i]->head_oid, *abbrev));
 		if (sha1_len > *abbrev)
 			*abbrev = sha1_len;
 	}
diff --git a/cache.h b/cache.h
index 21fbcc2414..09cd994bcc 100644
--- a/cache.h
+++ b/cache.h
@@ -951,14 +951,14 @@ extern void sha1_file_name(struct strbuf *buf, const unsigned char *sha1);
  * more calls to find_unique_abbrev are made.
  *
  * The `_r` variant writes to a buffer supplied by the caller, which must be at
- * least `GIT_SHA1_HEXSZ + 1` bytes. The return value is the number of bytes
+ * least `GIT_MAX_HEXSZ + 1` bytes. The return value is the number of bytes
  * written (excluding the NUL terminator).
  *
  * Note that while this version avoids the static buffer, it is not fully
  * reentrant, as it calls into other non-reentrant git code.
  */
-extern const char *find_unique_abbrev(const unsigned char *sha1, int len);
-extern int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len);
+extern const char *find_unique_abbrev(const struct object_id *oid, int len);
+extern int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len);
 
 extern const unsigned char null_sha1[GIT_MAX_RAWSZ];
 extern const struct object_id null_oid;
diff --git a/combine-diff.c b/combine-diff.c
index 18c74dad51..3d86304c5a 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -915,11 +915,11 @@ static void show_combined_header(struct combine_diff_path *elem,
 			 "", elem->path, line_prefix, c_meta, c_reset);
 	printf("%s%sindex ", line_prefix, c_meta);
 	for (i = 0; i < num_parent; i++) {
-		abb = find_unique_abbrev(elem->parent[i].oid.hash,
+		abb = find_unique_abbrev(&elem->parent[i].oid,
 					 abbrev);
 		printf("%s%s", i ? "," : "", abb);
 	}
-	abb = find_unique_abbrev(elem->oid.hash, abbrev);
+	abb = find_unique_abbrev(&elem->oid, abbrev);
 	printf("..%s%s\n", abb, c_reset);
 
 	if (mode_differs) {
diff --git a/diff.c b/diff.c
index 21c3838b25..94117bcbbf 100644
--- a/diff.c
+++ b/diff.c
@@ -3811,7 +3811,7 @@ static int similarity_index(struct diff_filepair *p)
 static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
 {
 	if (startup_info->have_repository)
-		return find_unique_abbrev(oid->hash, abbrev);
+		return find_unique_abbrev(oid, abbrev);
 	else {
 		char *hex = oid_to_hex(oid);
 		if (abbrev < 0)
diff --git a/log-tree.c b/log-tree.c
index fc0cc0d6d1..8bd398b18d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -177,7 +177,7 @@ static void show_parents(struct commit *commit, int abbrev, FILE *file)
 	struct commit_list *p;
 	for (p = commit->parents; p ; p = p->next) {
 		struct commit *parent = p->item;
-		fprintf(file, " %s", find_unique_abbrev(parent->object.oid.hash, abbrev));
+		fprintf(file, " %s", find_unique_abbrev(&parent->object.oid, abbrev));
 	}
 }
 
@@ -185,7 +185,7 @@ static void show_children(struct rev_info *opt, struct commit *commit, int abbre
 {
 	struct commit_list *p = lookup_decoration(&opt->children, &commit->object);
 	for ( ; p; p = p->next) {
-		fprintf(opt->diffopt.file, " %s", find_unique_abbrev(p->item->object.oid.hash, abbrev));
+		fprintf(opt->diffopt.file, " %s", find_unique_abbrev(&p->item->object.oid, abbrev));
 	}
 }
 
@@ -558,7 +558,7 @@ void show_log(struct rev_info *opt)
 
 		if (!opt->graph)
 			put_revision_mark(opt, commit);
-		fputs(find_unique_abbrev(commit->object.oid.hash, abbrev_commit), opt->diffopt.file);
+		fputs(find_unique_abbrev(&commit->object.oid, abbrev_commit), opt->diffopt.file);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit, opt->diffopt.file);
 		if (opt->children.name)
@@ -620,7 +620,8 @@ void show_log(struct rev_info *opt)
 
 		if (!opt->graph)
 			put_revision_mark(opt, commit);
-		fputs(find_unique_abbrev(commit->object.oid.hash, abbrev_commit),
+		fputs(find_unique_abbrev(&commit->object.oid,
+					 abbrev_commit),
 		      opt->diffopt.file);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit, opt->diffopt.file);
@@ -628,8 +629,7 @@ void show_log(struct rev_info *opt)
 			show_children(opt, commit, abbrev_commit);
 		if (parent)
 			fprintf(opt->diffopt.file, " (from %s)",
-			       find_unique_abbrev(parent->object.oid.hash,
-						  abbrev_commit));
+			       find_unique_abbrev(&parent->object.oid, abbrev_commit));
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), opt->diffopt.file);
 		show_decorations(opt, commit);
 		if (opt->commit_format == CMIT_FMT_ONELINE) {
diff --git a/ref-filter.c b/ref-filter.c
index 9cbd92611c..62834f7153 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -742,13 +742,13 @@ static int grab_objectname(const char *name, const struct object_id *oid,
 {
 	if (starts_with(name, "objectname")) {
 		if (atom->u.objectname.option == O_SHORT) {
-			v->s = xstrdup(find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
+			v->s = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
 			return 1;
 		} else if (atom->u.objectname.option == O_FULL) {
 			v->s = xstrdup(oid_to_hex(oid));
 			return 1;
 		} else if (atom->u.objectname.option == O_LENGTH) {
-			v->s = xstrdup(find_unique_abbrev(oid->hash, atom->u.objectname.length));
+			v->s = xstrdup(find_unique_abbrev(oid, atom->u.objectname.length));
 			return 1;
 		} else
 			die("BUG: unknown %%(objectname) option");
diff --git a/sequencer.c b/sequencer.c
index d2fc1871ed..ed7c42ba7d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -282,7 +282,7 @@ struct commit_message {
 
 static const char *short_commit_name(struct commit *commit)
 {
-	return find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV);
+	return find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV);
 }
 
 static int get_message(struct commit *commit, struct commit_message *out)
diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24dd..dd68e68f45 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -380,7 +380,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	}
 
 	advise("  %s %s%s",
-	       find_unique_abbrev(oid->hash, DEFAULT_ABBREV),
+	       find_unique_abbrev(oid, DEFAULT_ABBREV),
 	       typename(type) ? typename(type) : "unknown type",
 	       desc.buf);
 
@@ -569,7 +569,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 		find_abbrev_len_for_pack(p, mad);
 }
 
-int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
+int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 {
 	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
@@ -596,14 +596,14 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 			len = FALLBACK_DEFAULT_ABBREV;
 	}
 
-	sha1_to_hex_r(hex, sha1);
+	oid_to_hex_r(hex, oid);
 	if (len == GIT_SHA1_HEXSZ || !len)
 		return GIT_SHA1_HEXSZ;
 
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
-	mad.hash = sha1;
+	mad.hash = oid->hash;
 
 	find_abbrev_len_packed(&mad);
 
@@ -621,13 +621,13 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 	return mad.cur_len;
 }
 
-const char *find_unique_abbrev(const unsigned char *sha1, int len)
+const char *find_unique_abbrev(const struct object_id *oid, int len)
 {
 	static int bufno;
 	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
 	char *hex = hexbuffer[bufno];
 	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
-	find_unique_abbrev_r(hex, sha1, len);
+	find_unique_abbrev_r(hex, oid, len);
 	return hex;
 }
 
diff --git a/strbuf.c b/strbuf.c
index 128fbec503..3099c39f79 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -874,7 +874,7 @@ void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 {
 	int r;
 	strbuf_grow(sb, GIT_SHA1_HEXSZ + 1);
-	r = find_unique_abbrev_r(sb->buf + sb->len, oid->hash, abbrev_len);
+	r = find_unique_abbrev_r(sb->buf + sb->len, oid, abbrev_len);
 	strbuf_setlen(sb, sb->len + r);
 }
 
diff --git a/tag.c b/tag.c
index fcbe012f7a..0b63c3f1ec 100644
--- a/tag.c
+++ b/tag.c
@@ -46,7 +46,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 		return error("%s: cannot verify a non-tag object of type %s.",
 				name_to_report ?
 				name_to_report :
-				find_unique_abbrev(oid->hash, DEFAULT_ABBREV),
+				find_unique_abbrev(oid, DEFAULT_ABBREV),
 				typename(type));
 
 	buf = read_sha1_file(oid->hash, &type, &size);
@@ -54,7 +54,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 		return error("%s: unable to read file.",
 				name_to_report ?
 				name_to_report :
-				find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
+				find_unique_abbrev(oid, DEFAULT_ABBREV));
 
 	ret = run_gpg_verify(buf, size, flags);
 
diff --git a/transport.c b/transport.c
index 87de35dd5e..b9dfa11bd2 100644
--- a/transport.c
+++ b/transport.c
@@ -461,7 +461,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 static int measure_abbrev(const struct object_id *oid, int sofar)
 {
 	char hex[GIT_MAX_HEXSZ + 1];
-	int w = find_unique_abbrev_r(hex, oid->hash, DEFAULT_ABBREV);
+	int w = find_unique_abbrev_r(hex, oid, DEFAULT_ABBREV);
 
 	return (w < sofar) ? sofar : w;
 }
diff --git a/wt-status.c b/wt-status.c
index 698fa1d42a..e3e75e99a9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1349,7 +1349,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 					const char *color)
 {
 	status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
-			find_unique_abbrev(state->cherry_pick_head_oid.hash, DEFAULT_ABBREV));
+			find_unique_abbrev(&state->cherry_pick_head_oid, DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1368,7 +1368,7 @@ static void show_revert_in_progress(struct wt_status *s,
 					const char *color)
 {
 	status_printf_ln(s, color, _("You are currently reverting commit %s."),
-			 find_unique_abbrev(state->revert_head_oid.hash, DEFAULT_ABBREV));
+			 find_unique_abbrev(&state->revert_head_oid, DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1488,7 +1488,7 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 		state->detached_from = xstrdup(from);
 	} else
 		state->detached_from =
-			xstrdup(find_unique_abbrev(cb.noid.hash, DEFAULT_ABBREV));
+			xstrdup(find_unique_abbrev(&cb.noid, DEFAULT_ABBREV));
 	oidcpy(&state->detached_oid, &cb.noid);
 	state->detached_at = !get_oid("HEAD", &oid) &&
 			     !oidcmp(&oid, &state->detached_oid);
