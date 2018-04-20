Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E97F1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeDTWWI (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:22:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:42673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752647AbeDTWWH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:22:07 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mcyxq-1erR4i3YWI-00IGkZ; Sat, 21
 Apr 2018 00:22:03 +0200
Date:   Sat, 21 Apr 2018 00:21:45 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 04/11] replace: "libify" create_graft() and callees
In-Reply-To: <cover.1524262793.git.johannes.schindelin@gmx.de>
Message-ID: <11ee7383bae422789c29bf1b5637cea8e23c0679.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AInp+bsNVv/uhbVwurSzLoKLQFYFCcnKn6IP0hAYxsCVT2CyZRy
 XIcFI0BdhFJLfl1mXoPv1kUROUd+jAuV/H3ZMU+qWj9lV85CQo/oIarSwgpY1GGA7iOLxSI
 OGXISOBFiQziqBTDY/y621HwqLfDUfKrW3gwoPeS6zBnLrsfcABmnZNgfkLag8ihIvigN6B
 djQg+3m9e6zv0D5jOKbQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AvKEIDIu894=:GaHenu/rizM8KEfL3jFKfU
 /Y4t/3e/+eGCXF07PfZdhW3ILz4b33PMjf7tv/PAnTgtPixECoLHSITWLPRsk0/umh7/9yiRZ
 ak0XouNyUpGqe6rWFT8hBBvCbD/QuqwTgvl0zH2epKCoG6Ke3DmCjo3tfzIX4x+TEuzi6GBbk
 gNXFNehN9yLrkwQlc0F/BeAbZTcTm4dJiGE3R3cDgnhInkCuJyGOptqxRbJfp3LXT44YSnH2X
 4Hu0bOZ62Acht/Bb2phypqVheRL/7zKLagQiwkpXzhzfKh4GeYnw+dxDwma8xyQf0qg52oBGA
 pNnZ2EHv+dYY0TxBhvidsIUEI6kxcxpe7zX7jrjA0W1804KcTcB7GIZ0czvHkTmBYKqMRsWDD
 PU0XIR6OMYtwtT0In88AqdtH3ubS3IBWZ/oJoVbGcHgzTfxE3PvIN5qgJL72Lj3jMh9YTnz1n
 UbxuL080qhcYr8hIlQT+G0RX9lqU2YNtL31kFgc3R2LqkDEAd3HURY/be2z5Ixm+qVzKEkWY0
 1n7iugKx3fpK5rELiniPaifpHgzSc/j+LsSVZK/sLaAheLT4sDHtV/o12Pte9IZqJgyUtlRuL
 6WCzidUXJXkhMXtyyLDuKALm3aCT9Xqs1crjXIgspc9RlZBmMg44RDpXLbVqdNFIZIT4XhDHg
 /gYmGQrip42sDGjthnce3CGyPR9S13awRUHXRMLfeZsjtnw7tvA0JpcHqhetTj7eizExqApTK
 XHPtTNpLqpmbxwxmzygjiygnW2cbnkSAZFiLMHMeLLt1ktiIRoMlyttHDeY1UmJ05+ts1LDtM
 n5pjBlrxOnjfZ7E8csYCeLCXXqtIpaJI8q/9enSaEY78oibjUY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

File this away as yet another patch in the "libification" category.

As with all useful functions, in the next commit we want to use
create_graft() from a higher-level function where it would be
inconvenient if the called function simply die()s: if there is a
problem, we want to let the user know how to proceed, and the callee
simply has no way of knowing what to say.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c | 135 ++++++++++++++++++++++++++++------------------
 1 file changed, 84 insertions(+), 51 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index e345a5a0f1c..f63df405fd0 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -79,9 +79,9 @@ static int list_replace_refs(const char *pattern, const char *format)
 	else if (!strcmp(format, "long"))
 		data.format = REPLACE_FORMAT_LONG;
 	else
-		die("invalid replace format '%s'\n"
-		    "valid formats are 'short', 'medium' and 'long'\n",
-		    format);
+		return error("invalid replace format '%s'\n"
+			     "valid formats are 'short', 'medium' and 'long'\n",
+			     format);
 
 	for_each_replace_ref(show_reference, (void *)&data);
 
@@ -134,7 +134,7 @@ static int delete_replace_ref(const char *name, const char *ref,
 	return 0;
 }
 
-static void check_ref_valid(struct object_id *object,
+static int check_ref_valid(struct object_id *object,
 			    struct object_id *prev,
 			    struct strbuf *ref,
 			    int force)
@@ -142,12 +142,13 @@ static void check_ref_valid(struct object_id *object,
 	strbuf_reset(ref);
 	strbuf_addf(ref, "%s%s", git_replace_ref_base, oid_to_hex(object));
 	if (check_refname_format(ref->buf, 0))
-		die("'%s' is not a valid ref name.", ref->buf);
+		return error("'%s' is not a valid ref name.", ref->buf);
 
 	if (read_ref(ref->buf, prev))
 		oidclr(prev);
 	else if (!force)
-		die("replace ref '%s' already exists", ref->buf);
+		return error("replace ref '%s' already exists", ref->buf);
+	return 0;
 }
 
 static int replace_object_oid(const char *object_ref,
@@ -161,28 +162,31 @@ static int replace_object_oid(const char *object_ref,
 	struct strbuf ref = STRBUF_INIT;
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
+	int res = 0;
 
 	obj_type = oid_object_info(object, NULL);
 	repl_type = oid_object_info(repl, NULL);
 	if (!force && obj_type != repl_type)
-		die("Objects must be of the same type.\n"
-		    "'%s' points to a replaced object of type '%s'\n"
-		    "while '%s' points to a replacement object of type '%s'.",
-		    object_ref, type_name(obj_type),
-		    replace_ref, type_name(repl_type));
+		return error("Objects must be of the same type.\n"
+			     "'%s' points to a replaced object of type '%s'\n"
+			     "while '%s' points to a replacement object of "
+			     "type '%s'.",
+			     object_ref, type_name(obj_type),
+			     replace_ref, type_name(repl_type));
 
-	check_ref_valid(object, &prev, &ref, force);
+	if (check_ref_valid(object, &prev, &ref, force))
+		return -1;
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, repl, &prev,
 				   0, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
-		die("%s", err.buf);
+		res = error("%s", err.buf);
 
 	ref_transaction_free(transaction);
 	strbuf_release(&ref);
-	return 0;
+	return res;
 }
 
 static int replace_object(const char *object_ref, const char *replace_ref, int force)
@@ -190,9 +194,11 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
 	struct object_id object, repl;
 
 	if (get_oid(object_ref, &object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
+		return error("Failed to resolve '%s' as a valid ref.",
+			     object_ref);
 	if (get_oid(replace_ref, &repl))
-		die("Failed to resolve '%s' as a valid ref.", replace_ref);
+		return error("Failed to resolve '%s' as a valid ref.",
+			     replace_ref);
 
 	return replace_object_oid(object_ref, &object, replace_ref, &repl, force);
 }
@@ -202,7 +208,7 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
  * If "raw" is true, then the object's raw contents are printed according to
  * "type". Otherwise, we pretty-print the contents for human editing.
  */
-static void export_object(const struct object_id *oid, enum object_type type,
+static int export_object(const struct object_id *oid, enum object_type type,
 			  int raw, const char *filename)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -210,7 +216,7 @@ static void export_object(const struct object_id *oid, enum object_type type,
 
 	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
-		die_errno("unable to open %s for writing", filename);
+		return error_errno("unable to open %s for writing", filename);
 
 	argv_array_push(&cmd.args, "--no-replace-objects");
 	argv_array_push(&cmd.args, "cat-file");
@@ -223,7 +229,8 @@ static void export_object(const struct object_id *oid, enum object_type type,
 	cmd.out = fd;
 
 	if (run_command(&cmd))
-		die("cat-file reported failure");
+		return error("cat-file reported failure");
+	return 0;
 }
 
 /*
@@ -231,14 +238,14 @@ static void export_object(const struct object_id *oid, enum object_type type,
  * interpreting it as "type", and writing the result to the object database.
  * The sha1 of the written object is returned via sha1.
  */
-static void import_object(struct object_id *oid, enum object_type type,
+static int import_object(struct object_id *oid, enum object_type type,
 			  int raw, const char *filename)
 {
 	int fd;
 
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
-		die_errno("unable to open %s for reading", filename);
+		return error_errno("unable to open %s for reading", filename);
 
 	if (!raw && type == OBJ_TREE) {
 		const char *argv[] = { "mktree", NULL };
@@ -250,27 +257,38 @@ static void import_object(struct object_id *oid, enum object_type type,
 		cmd.in = fd;
 		cmd.out = -1;
 
-		if (start_command(&cmd))
-			die("unable to spawn mktree");
+		if (start_command(&cmd)) {
+			close(fd);
+			return error("unable to spawn mktree");
+		}
 
-		if (strbuf_read(&result, cmd.out, 41) < 0)
-			die_errno("unable to read from mktree");
+		if (strbuf_read(&result, cmd.out, 41) < 0) {
+			close(fd);
+			close(cmd.out);
+			return error_errno("unable to read from mktree");
+		}
 		close(cmd.out);
 
-		if (finish_command(&cmd))
-			die("mktree reported failure");
-		if (get_oid_hex(result.buf, oid) < 0)
-			die("mktree did not return an object name");
+		if (finish_command(&cmd)) {
+			strbuf_release(&result);
+			return error("mktree reported failure");
+		}
+		if (get_oid_hex(result.buf, oid) < 0) {
+			strbuf_release(&result);
+			return error("mktree did not return an object name");
+		}
 
 		strbuf_release(&result);
 	} else {
 		struct stat st;
 		int flags = HASH_FORMAT_CHECK | HASH_WRITE_OBJECT;
 
-		if (fstat(fd, &st) < 0)
-			die_errno("unable to fstat %s", filename);
+		if (fstat(fd, &st) < 0) {
+			close(fd);
+			return error_errno("unable to fstat %s", filename);
+		}
 		if (index_fd(oid, fd, &st, type, NULL, flags) < 0)
-			die("unable to write object to database");
+			return error("unable to write object to database");
 		/* index_fd close()s fd for us */
 	}
 
@@ -278,6 +296,7 @@ static void import_object(struct object_id *oid, enum object_type type,
 	 * No need to close(fd) here; both run-command and index-fd
 	 * will have done it for us.
 	 */
+	return 0;
 }
 
 static int edit_and_replace(const char *object_ref, int force, int raw)
@@ -288,19 +307,23 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	struct strbuf ref = STRBUF_INIT;
 
 	if (get_oid(object_ref, &old_oid) < 0)
-		die("Not a valid object name: '%s'", object_ref);
+		return error("Not a valid object name: '%s'", object_ref);
 
 	type = oid_object_info(&old_oid, NULL);
 	if (type < 0)
-		die("unable to get object type for %s", oid_to_hex(&old_oid));
+		return error("unable to get object type for %s",
+			     oid_to_hex(&old_oid));
 
-	check_ref_valid(&old_oid, &prev, &ref, force);
+	if (check_ref_valid(&old_oid, &prev, &ref, force))
+		return -1;
 	strbuf_release(&ref);
 
-	export_object(&old_oid, type, raw, tmpfile);
+	if (export_object(&old_oid, type, raw, tmpfile))
+		return -1;
 	if (launch_editor(tmpfile, NULL, NULL) < 0)
-		die("editing object file failed");
-	import_object(&new_oid, type, raw, tmpfile);
+		return error("editing object file failed");
+	if (import_object(&new_oid, type, raw, tmpfile))
+		return -1;
 
 	free(tmpfile);
 
@@ -310,7 +333,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	return replace_object_oid(object_ref, &old_oid, "replacement", &new_oid, force);
 }
 
-static void replace_parents(struct strbuf *buf, int argc, const char **argv)
+static int replace_parents(struct strbuf *buf, int argc, const char **argv)
 {
 	struct strbuf new_parents = STRBUF_INIT;
 	const char *parent_start, *parent_end;
@@ -328,8 +351,10 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 	for (i = 0; i < argc; i++) {
 		struct object_id oid;
 		if (get_oid(argv[i], &oid) < 0)
-			die(_("Not a valid object name: '%s'"), argv[i]);
-		lookup_commit_or_die(&oid, argv[i]);
+			return error(_("Not a valid object name: '%s'"),
+				     argv[i]);
+		if (!lookup_commit_reference(&oid))
+			return error(_("could not parse %s"), argv[i]);
 		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&oid));
 	}
 
@@ -338,6 +363,7 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 		      new_parents.buf, new_parents.len);
 
 	strbuf_release(&new_parents);
+	return 0;
 }
 
 struct check_mergetag_data {
@@ -358,21 +384,23 @@ static int check_one_mergetag(struct commit *commit,
 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &tag_oid);
 	tag = lookup_tag(&tag_oid);
 	if (!tag)
-		die(_("bad mergetag in commit '%s'"), ref);
+		return error(_("bad mergetag in commit '%s'"), ref);
 	if (parse_tag_buffer(tag, extra->value, extra->len))
-		die(_("malformed mergetag in commit '%s'"), ref);
+		return error(_("malformed mergetag in commit '%s'"), ref);
 
 	/* iterate over new parents */
 	for (i = 1; i < mergetag_data->argc; i++) {
 		struct object_id oid;
 		if (get_oid(mergetag_data->argv[i], &oid) < 0)
-			die(_("Not a valid object name: '%s'"), mergetag_data->argv[i]);
+			return error(_("Not a valid object name: '%s'"),
+				     mergetag_data->argv[i]);
 		if (!oidcmp(&tag->tagged->oid, &oid))
 			return 0; /* found */
 	}
 
-	die(_("original commit '%s' contains mergetag '%s' that is discarded; "
-	      "use --edit instead of --graft"), ref, oid_to_hex(&tag_oid));
+	return error(_("original commit '%s' contains mergetag '%s' that is "
+		       "discarded; use --edit instead of --graft"), ref,
+		     oid_to_hex(&tag_oid));
 }
 
 static int check_mergetags(struct commit *commit, int argc, const char **argv)
@@ -394,24 +422,29 @@ static int create_graft(int argc, const char **argv, int force)
 	unsigned long size;
 
 	if (get_oid(old_ref, &old_oid) < 0)
-		die(_("Not a valid object name: '%s'"), old_ref);
-	commit = lookup_commit_or_die(&old_oid, old_ref);
+		return error(_("Not a valid object name: '%s'"), old_ref);
+	commit = lookup_commit_reference(&old_oid);
+	if (!commit)
+		return error(_("could not parse %s"), old_ref);
 
 	buffer = get_commit_buffer(commit, &size);
 	strbuf_add(&buf, buffer, size);
 	unuse_commit_buffer(commit, buffer);
 
-	replace_parents(&buf, argc - 1, &argv[1]);
+	if (replace_parents(&buf, argc - 1, &argv[1]) < 0)
+		return -1;
 
 	if (remove_signature(&buf)) {
 		warning(_("the original commit '%s' has a gpg signature."), old_ref);
 		warning(_("the signature will be removed in the replacement commit!"));
 	}
 
-	check_mergetags(commit, argc, argv);
+	if (check_mergetags(commit, argc, argv))
+		return -1;
 
 	if (write_object_file(buf.buf, buf.len, commit_type, &new_oid))
-		die(_("could not write replacement commit for: '%s'"), old_ref);
+		return error(_("could not write replacement commit for: '%s'"),
+			     old_ref);
 
 	strbuf_release(&buf);
 
-- 
2.17.0.windows.1.15.gaa56ade3205


