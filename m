Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC7B1F404
	for <e@80x24.org>; Wed, 25 Apr 2018 09:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeDYJyY (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:54:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:44815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751785AbeDYJyT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:19 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MEKZg-1f96Le3j6e-00FPIC; Wed, 25 Apr 2018 11:54:15 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v5 04/11] replace: "libify" create_graft() and callees
Date:   Wed, 25 Apr 2018 11:54:08 +0200
Message-Id: <bd3a15bb41680b99bc888d3a775cd40508ec89f7.1524650029.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:HqPXYvlW1+Eyzk0xX45mTAkzPKAI19QQLaXU+mvPyN+Wf8HaQIe
 wE78hod25T2dxwlwwDMGoSD3/uXDXyqRdQcrIkUhtMbPxU5j4hPrLE9PiUFNkZWVjOcUoTV
 V3OXaa3Rli8N330HEIwTdAZ+Orl62+JoGYFhDlz4ewZbMpOUogsZRECcJeQLa3OB5kgBx/c
 L6ephC3d/QQ+6OlFM03tA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BxeneuwlB50=:75D4V5bygmDhBmAwtFfElk
 8Js7bNhGs0ONXhK2Oo8WIGebNUtg9cndCNYB7p8kbQpwSecCx+xnG83hsSLq9/Bq1yaqE4U+W
 ojI09WXufSTFa03AFtCyI1mgEfR915IxPeuewuFznPcxAT56MmW39pOxQufIp7/jvBcYfcpAb
 p20mnXSKYmPxpmNtuV+ysRGzEmgUbNEXtX/STs6HrGhCHEO6CIMyaYup0HEU2KQEDX3qx4wcH
 Vf5A5mw8ygc5izsIm7Qpm6KuA8CmyjkIdMsD5pn18IaX1Zf6KPEccOcsg+MZHZ/WMwg7di2sX
 MPcI7GlUNFwUkm5b5ShfNQ9TGdww2AFqaQrlQbbEYH2fVLD0WmZRDCE/smOhbs1mDjw+P54cQ
 jI5VILkfRqka+YlnLXH25OZ4pu3cO6MRidqTH3cq7dDYy97cY5rmVZw6ewCV0aNwXbTsBXlfo
 fQ6q6oy6k3UdhqREjLFnosWDbnbPBepTe1JOSONG5hVkehGFI/mqcfs6vVJ3f0paJ1qXILZFr
 9K7kFNfNX6/X1vSvrri3FSi91/oBYXZMymVrU6w/3noTm2yQe5e6R7K/dK2vC4zCLOuXY8/3J
 cRBO1HPBu534WT4ZpW+3Sz0b0Jv62gav7rt+MVY8ApNHdnJKuZFI12AhOeqMQcoIoduXTPSMb
 1NlDF4K+jEDiFRWKA1wIZ++F5vTkEpaIf4duy0niZ6lHZkJrdOKxIZMlcXX7X8HRx/LDl7YKC
 6GPxi25gzYFhhu6g5j6DarAFAK1Synol6kNrDwdsV4wkcynBuV7j08Ji67L8Sp5S1uHezjCyX
 JIGYzHEisfzxg75jTMq74C+TKtmHk1ISvVcRIjG2bcj4mWrKGqUH/a4Qaz/Xh4lAvyqkJCy
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
 builtin/replace.c | 164 ++++++++++++++++++++++++++++++----------------
 1 file changed, 107 insertions(+), 57 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index e345a5a0f1c..e92f364e29a 100644
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
@@ -161,28 +162,33 @@ static int replace_object_oid(const char *object_ref,
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
-
-	check_ref_valid(object, &prev, &ref, force);
+		return error("Objects must be of the same type.\n"
+			     "'%s' points to a replaced object of type '%s'\n"
+			     "while '%s' points to a replacement object of "
+			     "type '%s'.",
+			     object_ref, type_name(obj_type),
+			     replace_ref, type_name(repl_type));
+
+	if (check_ref_valid(object, &prev, &ref, force)) {
+		strbuf_release(&ref);
+		return -1;
+	}
 
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
@@ -190,9 +196,11 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
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
@@ -202,7 +210,7 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
  * If "raw" is true, then the object's raw contents are printed according to
  * "type". Otherwise, we pretty-print the contents for human editing.
  */
-static void export_object(const struct object_id *oid, enum object_type type,
+static int export_object(const struct object_id *oid, enum object_type type,
 			  int raw, const char *filename)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -210,7 +218,7 @@ static void export_object(const struct object_id *oid, enum object_type type,
 
 	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
-		die_errno("unable to open %s for writing", filename);
+		return error_errno("unable to open %s for writing", filename);
 
 	argv_array_push(&cmd.args, "--no-replace-objects");
 	argv_array_push(&cmd.args, "cat-file");
@@ -223,7 +231,8 @@ static void export_object(const struct object_id *oid, enum object_type type,
 	cmd.out = fd;
 
 	if (run_command(&cmd))
-		die("cat-file reported failure");
+		return error("cat-file reported failure");
+	return 0;
 }
 
 /*
@@ -231,14 +240,14 @@ static void export_object(const struct object_id *oid, enum object_type type,
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
@@ -250,27 +259,40 @@ static void import_object(struct object_id *oid, enum object_type type,
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
+			error_errno("unable to read from mktree");
+			close(fd);
+			close(cmd.out);
+			return -1;
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
+			error_errno("unable to fstat %s", filename);
+			close(fd);
+			return -1;
+		}
 		if (index_fd(oid, fd, &st, type, NULL, flags) < 0)
-			die("unable to write object to database");
+			return error("unable to write object to database");
 		/* index_fd close()s fd for us */
 	}
 
@@ -278,30 +300,38 @@ static void import_object(struct object_id *oid, enum object_type type,
 	 * No need to close(fd) here; both run-command and index-fd
 	 * will have done it for us.
 	 */
+	return 0;
 }
 
 static int edit_and_replace(const char *object_ref, int force, int raw)
 {
-	char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
+	char *tmpfile;
 	enum object_type type;
 	struct object_id old_oid, new_oid, prev;
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
+	if (check_ref_valid(&old_oid, &prev, &ref, force)) {
+		strbuf_release(&ref);
+		return -1;
+	}
 	strbuf_release(&ref);
 
-	export_object(&old_oid, type, raw, tmpfile);
-	if (launch_editor(tmpfile, NULL, NULL) < 0)
-		die("editing object file failed");
-	import_object(&new_oid, type, raw, tmpfile);
-
+	tmpfile = git_pathdup("REPLACE_EDITOBJ");
+	if (export_object(&old_oid, type, raw, tmpfile) ||
+	    (launch_editor(tmpfile, NULL, NULL) < 0 &&
+	     error("editing object file failed")) ||
+	    import_object(&new_oid, type, raw, tmpfile)) {
+		free(tmpfile);
+		return -1;
+	}
 	free(tmpfile);
 
 	if (!oidcmp(&old_oid, &new_oid))
@@ -310,7 +340,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	return replace_object_oid(object_ref, &old_oid, "replacement", &new_oid, force);
 }
 
-static void replace_parents(struct strbuf *buf, int argc, const char **argv)
+static int replace_parents(struct strbuf *buf, int argc, const char **argv)
 {
 	struct strbuf new_parents = STRBUF_INIT;
 	const char *parent_start, *parent_end;
@@ -327,9 +357,15 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 	/* prepare new parents */
 	for (i = 0; i < argc; i++) {
 		struct object_id oid;
-		if (get_oid(argv[i], &oid) < 0)
-			die(_("Not a valid object name: '%s'"), argv[i]);
-		lookup_commit_or_die(&oid, argv[i]);
+		if (get_oid(argv[i], &oid) < 0) {
+			strbuf_release(&new_parents);
+			return error(_("Not a valid object name: '%s'"),
+				     argv[i]);
+		}
+		if (!lookup_commit_reference(&oid)) {
+			strbuf_release(&new_parents);
+			return error(_("could not parse %s"), argv[i]);
+		}
 		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&oid));
 	}
 
@@ -338,6 +374,7 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 		      new_parents.buf, new_parents.len);
 
 	strbuf_release(&new_parents);
+	return 0;
 }
 
 struct check_mergetag_data {
@@ -358,21 +395,23 @@ static int check_one_mergetag(struct commit *commit,
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
@@ -394,24 +433,35 @@ static int create_graft(int argc, const char **argv, int force)
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
+	if (replace_parents(&buf, argc - 1, &argv[1]) < 0) {
+		strbuf_release(&buf);
+		return -1;
+	}
 
 	if (remove_signature(&buf)) {
 		warning(_("the original commit '%s' has a gpg signature."), old_ref);
 		warning(_("the signature will be removed in the replacement commit!"));
 	}
 
-	check_mergetags(commit, argc, argv);
+	if (check_mergetags(commit, argc, argv)) {
+		strbuf_release(&buf);
+		return -1;
+	}
 
-	if (write_object_file(buf.buf, buf.len, commit_type, &new_oid))
-		die(_("could not write replacement commit for: '%s'"), old_ref);
+	if (write_object_file(buf.buf, buf.len, commit_type, &new_oid)) {
+		strbuf_release(&buf);
+		return error(_("could not write replacement commit for: '%s'"),
+			     old_ref);
+	}
 
 	strbuf_release(&buf);
 
-- 
2.17.0.windows.1.33.gfcbb1fa0445


