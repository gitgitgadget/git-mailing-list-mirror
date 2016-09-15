Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D26E2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 15:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbcIOPBF (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 11:01:05 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:48051 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751757AbcIOPBE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 11:01:04 -0400
Received: (qmail 9871 invoked from network); 15 Sep 2016 15:01:02 -0000
Received: (qmail 22969 invoked from network); 15 Sep 2016 15:00:54 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 15 Sep 2016 15:00:52 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/14] notes: lowercase first word of error messages
Date:   Thu, 15 Sep 2016 14:59:04 +0000
Message-Id: <1473951548-31733-10-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow the usual case style.

Update one test to reflect these changes.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/notes.c                  | 64 ++++++++++++++++++++--------------------
 t/t3320-notes-merge-worktrees.sh |  2 +-
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 229ad6d..5248a9b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -191,7 +191,7 @@ static void prepare_note_data(const unsigned char *object, struct note_data *d,
 		strbuf_reset(&d->buf);
 
 		if (launch_editor(d->edit_path, &d->buf, NULL)) {
-			die(_("Please supply the note contents using either -m or -F option"));
+			die(_("please supply the note contents using either -m or -F option"));
 		}
 		strbuf_stripspace(&d->buf, 1);
 	}
@@ -202,7 +202,7 @@ static void write_note_data(struct note_data *d, unsigned char *sha1)
 	if (write_sha1_file(d->buf.buf, d->buf.len, blob_type, sha1)) {
 		error(_("unable to write note object"));
 		if (d->edit_path)
-			error(_("The note contents have been left in %s"),
+			error(_("the note contents have been left in %s"),
 				d->edit_path);
 		exit(128);
 	}
@@ -251,14 +251,14 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 		strbuf_addch(&d->buf, '\n');
 
 	if (get_sha1(arg, object))
-		die(_("Failed to resolve '%s' as a valid ref."), arg);
+		die(_("failed to resolve '%s' as a valid ref."), arg);
 	if (!(buf = read_sha1_file(object, &type, &len))) {
 		free(buf);
-		die(_("Failed to read object '%s'."), arg);
+		die(_("failed to read object '%s'."), arg);
 	}
 	if (type != OBJ_BLOB) {
 		free(buf);
-		die(_("Cannot read note data from non-blob object '%s'."), arg);
+		die(_("cannot read note data from non-blob object '%s'."), arg);
 	}
 	strbuf_add(&d->buf, buf, len);
 	free(buf);
@@ -298,13 +298,13 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 		split = strbuf_split(&buf, ' ');
 		if (!split[0] || !split[1])
-			die(_("Malformed input line: '%s'."), buf.buf);
+			die(_("malformed input line: '%s'."), buf.buf);
 		strbuf_rtrim(split[0]);
 		strbuf_rtrim(split[1]);
 		if (get_sha1(split[0]->buf, from_obj))
-			die(_("Failed to resolve '%s' as a valid ref."), split[0]->buf);
+			die(_("failed to resolve '%s' as a valid ref."), split[0]->buf);
 		if (get_sha1(split[1]->buf, to_obj))
-			die(_("Failed to resolve '%s' as a valid ref."), split[1]->buf);
+			die(_("failed to resolve '%s' as a valid ref."), split[1]->buf);
 
 		if (rewrite_cmd)
 			err = copy_note_for_rewrite(c, from_obj, to_obj);
@@ -313,7 +313,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 					combine_notes_overwrite);
 
 		if (err) {
-			error(_("Failed to copy notes from '%s' to '%s'"),
+			error(_("failed to copy notes from '%s' to '%s'"),
 			      split[0]->buf, split[1]->buf);
 			ret = 1;
 		}
@@ -342,7 +342,7 @@ static struct notes_tree *init_notes_check(const char *subcommand,
 	if (!starts_with(ref, "refs/notes/"))
 		/* TRANSLATORS: the first %s will be replaced by a
 		   git notes command: 'add', 'merge', 'remove', etc.*/
-		die(_("Refusing to %s notes in %s (outside of refs/notes/)"),
+		die(_("refusing to %s notes in %s (outside of refs/notes/)"),
 		    subcommand, ref);
 	return t;
 }
@@ -369,13 +369,13 @@ static int list(int argc, const char **argv, const char *prefix)
 	t = init_notes_check("list", 0);
 	if (argc) {
 		if (get_sha1(argv[0], object))
-			die(_("Failed to resolve '%s' as a valid ref."), argv[0]);
+			die(_("failed to resolve '%s' as a valid ref."), argv[0]);
 		note = get_note(t, object);
 		if (note) {
 			puts(sha1_to_hex(note));
 			retval = 0;
 		} else
-			retval = error(_("No note found for object %s."),
+			retval = error(_("no note found for object %s."),
 				       sha1_to_hex(object));
 	} else
 		retval = for_each_note(t, 0, list_each_note, NULL);
@@ -424,7 +424,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	object_ref = argc > 1 ? argv[1] : "HEAD";
 
 	if (get_sha1(object_ref, object))
-		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
+		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("add", NOTES_INIT_WRITABLE);
 	note = get_note(t, object);
@@ -510,12 +510,12 @@ static int copy(int argc, const char **argv, const char *prefix)
 	}
 
 	if (get_sha1(argv[0], from_obj))
-		die(_("Failed to resolve '%s' as a valid ref."), argv[0]);
+		die(_("failed to resolve '%s' as a valid ref."), argv[0]);
 
 	object_ref = 1 < argc ? argv[1] : "HEAD";
 
 	if (get_sha1(object_ref, object))
-		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
+		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("copy", NOTES_INIT_WRITABLE);
 	note = get_note(t, object);
@@ -534,7 +534,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 
 	from_note = get_note(t, from_obj);
 	if (!from_note) {
-		retval = error(_("Missing notes on source object %s. Cannot "
+		retval = error(_("missing notes on source object %s. Cannot "
 			       "copy."), sha1_to_hex(from_obj));
 		goto out;
 	}
@@ -593,7 +593,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	object_ref = 1 < argc ? argv[1] : "HEAD";
 
 	if (get_sha1(object_ref, object))
-		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
+		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check(argv[0], NOTES_INIT_WRITABLE);
 	note = get_note(t, object);
@@ -656,13 +656,13 @@ static int show(int argc, const char **argv, const char *prefix)
 	object_ref = argc ? argv[0] : "HEAD";
 
 	if (get_sha1(object_ref, object))
-		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
+		die(_("failed to resolve '%s' as a valid ref."), object_ref);
 
 	t = init_notes_check("show", 0);
 	note = get_note(t, object);
 
 	if (!note)
-		retval = error(_("No note found for object %s."),
+		retval = error(_("no note found for object %s."),
 			       sha1_to_hex(object));
 	else {
 		const char *show_args[3] = {"show", sha1_to_hex(note), NULL};
@@ -682,11 +682,11 @@ static int merge_abort(struct notes_merge_options *o)
 	 */
 
 	if (delete_ref("NOTES_MERGE_PARTIAL", NULL, 0))
-		ret += error(_("Failed to delete ref NOTES_MERGE_PARTIAL"));
+		ret += error(_("failed to delete ref NOTES_MERGE_PARTIAL"));
 	if (delete_ref("NOTES_MERGE_REF", NULL, REF_NODEREF))
-		ret += error(_("Failed to delete ref NOTES_MERGE_REF"));
+		ret += error(_("failed to delete ref NOTES_MERGE_REF"));
 	if (notes_merge_abort(o))
-		ret += error(_("Failed to remove 'git notes merge' worktree"));
+		ret += error(_("failed to remove 'git notes merge' worktree"));
 	return ret;
 }
 
@@ -706,11 +706,11 @@ static int merge_commit(struct notes_merge_options *o)
 	 */
 
 	if (get_sha1("NOTES_MERGE_PARTIAL", sha1))
-		die(_("Failed to read ref NOTES_MERGE_PARTIAL"));
+		die(_("failed to read ref NOTES_MERGE_PARTIAL"));
 	else if (!(partial = lookup_commit_reference(sha1)))
-		die(_("Could not find commit from NOTES_MERGE_PARTIAL."));
+		die(_("could not find commit from NOTES_MERGE_PARTIAL."));
 	else if (parse_commit(partial))
-		die(_("Could not parse commit from NOTES_MERGE_PARTIAL."));
+		die(_("could not parse commit from NOTES_MERGE_PARTIAL."));
 
 	if (partial->parents)
 		hashcpy(parent_sha1, partial->parents->item->object.oid.hash);
@@ -723,10 +723,10 @@ static int merge_commit(struct notes_merge_options *o)
 	o->local_ref = local_ref_to_free =
 		resolve_refdup("NOTES_MERGE_REF", 0, sha1, NULL);
 	if (!o->local_ref)
-		die(_("Failed to resolve NOTES_MERGE_REF"));
+		die(_("failed to resolve NOTES_MERGE_REF"));
 
 	if (notes_merge_commit(o, t, partial, sha1))
-		die(_("Failed to finalize notes merge"));
+		die(_("failed to finalize notes merge"));
 
 	/* Reuse existing commit message in reflog message */
 	memset(&pretty_ctx, 0, sizeof(pretty_ctx));
@@ -796,7 +796,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 	}
 
 	if (do_merge && argc != 1) {
-		error(_("Must specify a notes ref to merge"));
+		error(_("must specify a notes ref to merge"));
 		usage_with_options(git_notes_merge_usage, options);
 	} else if (!do_merge && argc) {
 		error(_("too many parameters"));
@@ -820,7 +820,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 
 	if (strategy) {
 		if (parse_notes_merge_strategy(strategy, &o.strategy)) {
-			error(_("Unknown -s/--strategy: %s"), strategy);
+			error(_("unknown -s/--strategy: %s"), strategy);
 			usage_with_options(git_notes_merge_usage, options);
 		}
 	} else {
@@ -857,10 +857,10 @@ static int merge(int argc, const char **argv, const char *prefix)
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
 		wt = find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
 		if (wt)
-			die(_("A notes merge into %s is already in-progress at %s"),
+			die(_("a notes merge into %s is already in-progress at %s"),
 			    default_notes_ref(), wt->path);
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
-			die(_("Failed to store link to current notes ref (%s)"),
+			die(_("failed to store link to current notes ref (%s)"),
 			    default_notes_ref());
 		printf(_("Automatic notes merge failed. Fix conflicts in %s and "
 			 "commit the result with 'git notes merge --commit', or "
@@ -1016,7 +1016,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	else if (!strcmp(argv[0], "get-ref"))
 		result = get_ref(argc, argv, prefix);
 	else {
-		result = error(_("Unknown subcommand: %s"), argv[0]);
+		result = error(_("unknown subcommand: %s"), argv[0]);
 		usage_with_options(git_notes_usage, options);
 	}
 
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 6e05115..b9c3bc2 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -52,7 +52,7 @@ test_expect_success 'merge z into y while mid-merge in another workdir fails' '
 		cd worktree &&
 		git config core.notesRef refs/notes/y &&
 		test_must_fail git notes merge z 2>err &&
-		test_i18ngrep "A notes merge into refs/notes/y is already in-progress at" err
+		test_i18ngrep "a notes merge into refs/notes/y is already in-progress at" err
 	) &&
 	test_path_is_missing .git/worktrees/worktree/NOTES_MERGE_REF
 '
-- 
2.7.4

