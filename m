From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 39/72] gettextize: git-merge basic messages
Date: Sat, 19 Feb 2011 19:24:22 +0000
Message-ID: <1298143495-3681-40-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsVM-00042j-4W
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397Ab1BSTaB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:30:01 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39339 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756033Ab1BST2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:00 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347149eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=HrCpVp+QxXE0/CeYCczpgxZSMG8yhFV3id0zK9Ri8NI=;
        b=lCuHNwOOIEKWwjCjfkfVknPBttGzRPR9WOEPtTONnGsAxye84WDaccA9ek4HPgm309
         9lcNmEtxmAVwMDq3z2vsvIl9meMaDdUlwIbs54pjGFRfOVxpQ43Dy159HJb4fZB2F6oa
         duVYfj/zAKA/fwslhzK7foHy7tAjEj6GNyQPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=I821l+VYsVQM1aKcBx3QkvhWjacAXKEeU1x2YfA5PnJBOOVu9fdML1HbYJRSZNk2By
         o5Hq/k0X5xpD5B2jkW9qvJe/ygZCAUmpkgYYMYpeuWNEWh1E4r6CEj9aOb1xKt7zo40K
         jWj83cwbj/rZ5cdNmoHhq4giJsRwJSfE7DdJ4=
Received: by 10.213.29.148 with SMTP id q20mr2531538ebc.73.1298143679541;
        Sat, 19 Feb 2011 11:27:59 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.58
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:58 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167369>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/merge.c            |  124 ++++++++++++++++++++++--------------=
--------
 t/t7607-merge-overwrite.sh |   10 +++-
 t/t7611-merge-abort.sh     |   20 ++++++--
 3 files changed, 86 insertions(+), 68 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 8c58c3c..0be4dfa 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -80,7 +80,7 @@ static int option_parse_message(const struct option *=
opt,
 		strbuf_addf(buf, "%s%s", buf->len ? "\n\n" : "", arg);
 		have_message =3D 1;
 	} else
-		return error("switch `m' requires a value");
+		return error(_("switch `m' requires a value"));
 	return 0;
 }
=20
@@ -117,13 +117,13 @@ static struct strategy *get_strategy(const char *=
name)
 		exclude_cmds(&main_cmds, &not_strategies);
 	}
 	if (!is_in_cmdlist(&main_cmds, name) && !is_in_cmdlist(&other_cmds, n=
ame)) {
-		fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
-		fprintf(stderr, "Available strategies are:");
+		fprintf(stderr, _("Could not find merge strategy '%s'.\n"), name);
+		fprintf(stderr, _("Available strategies are:"));
 		for (i =3D 0; i < main_cmds.cnt; i++)
 			fprintf(stderr, " %s", main_cmds.names[i]->name);
 		fprintf(stderr, ".\n");
 		if (other_cmds.cnt) {
-			fprintf(stderr, "Available custom strategies are:");
+			fprintf(stderr, _("Available custom strategies are:"));
 			for (i =3D 0; i < other_cmds.cnt; i++)
 				fprintf(stderr, " %s", other_cmds.names[i]->name);
 			fprintf(stderr, ".\n");
@@ -224,17 +224,17 @@ static void save_state(void)
 	cp.git_cmd =3D 1;
=20
 	if (start_command(&cp))
-		die("could not run stash.");
+		die(_("could not run stash."));
 	len =3D strbuf_read(&buffer, cp.out, 1024);
 	close(cp.out);
=20
 	if (finish_command(&cp) || len < 0)
-		die("stash failed");
+		die(_("stash failed"));
 	else if (!len)
 		return;
 	strbuf_setlen(&buffer, buffer.len-1);
 	if (get_sha1(buffer.buf, stash))
-		die("not a valid object: %s", buffer.buf);
+		die(_("not a valid object: %s"), buffer.buf);
 }
=20
 static void read_empty(unsigned const char *sha1, int verbose)
@@ -252,7 +252,7 @@ static void read_empty(unsigned const char *sha1, i=
nt verbose)
 	args[i] =3D NULL;
=20
 	if (run_command_v_opt(args, RUN_GIT_CMD))
-		die("read-tree failed");
+		die(_("read-tree failed"));
 }
=20
 static void reset_hard(unsigned const char *sha1, int verbose)
@@ -269,7 +269,7 @@ static void reset_hard(unsigned const char *sha1, i=
nt verbose)
 	args[i] =3D NULL;
=20
 	if (run_command_v_opt(args, RUN_GIT_CMD))
-		die("read-tree failed");
+		die(_("read-tree failed"));
 }
=20
 static void restore_state(void)
@@ -298,7 +298,7 @@ static void restore_state(void)
 static void finish_up_to_date(const char *msg)
 {
 	if (verbosity >=3D 0)
-		printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
+		printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
 	drop_save();
 }
=20
@@ -311,10 +311,10 @@ static void squash_message(void)
 	int fd;
 	struct pretty_print_context ctx =3D {0};
=20
-	printf("Squash commit -- not updating HEAD\n");
+	printf(_("Squash commit -- not updating HEAD\n"));
 	fd =3D open(git_path("SQUASH_MSG"), O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
-		die_errno("Could not write to '%s'", git_path("SQUASH_MSG"));
+		die_errno(_("Could not write to '%s'"), git_path("SQUASH_MSG"));
=20
 	init_revisions(&rev, NULL);
 	rev.ignore_merges =3D 1;
@@ -329,7 +329,7 @@ static void squash_message(void)
=20
 	setup_revisions(0, NULL, &rev, NULL);
 	if (prepare_revision_walk(&rev))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
=20
 	ctx.abbrev =3D rev.abbrev;
 	ctx.date_mode =3D rev.date_mode;
@@ -342,9 +342,9 @@ static void squash_message(void)
 		pretty_print_commit(rev.commit_format, commit, &out, &ctx);
 	}
 	if (write(fd, out.buf, out.len) < 0)
-		die_errno("Writing SQUASH_MSG");
+		die_errno(_("Writing SQUASH_MSG"));
 	if (close(fd))
-		die_errno("Finishing SQUASH_MSG");
+		die_errno(_("Finishing SQUASH_MSG"));
 	strbuf_release(&out);
 }
=20
@@ -364,7 +364,7 @@ static void finish(const unsigned char *new_head, c=
onst char *msg)
 		squash_message();
 	} else {
 		if (verbosity >=3D 0 && !merge_msg.len)
-			printf("No merge message -- not updating HEAD\n");
+			printf(_("No merge message -- not updating HEAD\n"));
 		else {
 			const char *argv_gc_auto[] =3D { "gc", "--auto", NULL };
 			update_ref(reflog_message.buf, "HEAD",
@@ -386,7 +386,7 @@ static void finish(const unsigned char *new_head, c=
onst char *msg)
 		if (diff_use_color_default > 0)
 			DIFF_OPT_SET(&opts, COLOR_DIFF);
 		if (diff_setup_done(&opts) < 0)
-			die("diff_setup_done failed");
+			die(_("diff_setup_done failed"));
 		diff_tree_sha1(head, new_head, "", &opts);
 		diffcore_std(&opts);
 		diff_flush(&opts);
@@ -415,7 +415,7 @@ static void merge_name(const char *remote, struct s=
trbuf *msg)
 	memset(branch_head, 0, sizeof(branch_head));
 	remote_head =3D peel_to_type(remote, 0, NULL, OBJ_COMMIT);
 	if (!remote_head)
-		die("'%s' does not point to a commit", remote);
+		die(_("'%s' does not point to a commit"), remote);
=20
 	if (dwim_ref(remote, strlen(remote), branch_head, &found_ref) > 0) {
 		if (!prefixcmp(found_ref, "refs/heads/")) {
@@ -480,7 +480,7 @@ static void merge_name(const char *remote, struct s=
trbuf *msg)
=20
 		fp =3D fopen(git_path("FETCH_HEAD"), "r");
 		if (!fp)
-			die_errno("could not open '%s' for reading",
+			die_errno(_("could not open '%s' for reading"),
 				  git_path("FETCH_HEAD"));
 		strbuf_getline(&line, fp, '\n');
 		fclose(fp);
@@ -510,7 +510,7 @@ static int git_merge_config(const char *k, const ch=
ar *v, void *cb)
 		buf =3D xstrdup(v);
 		argc =3D split_cmdline(buf, &argv);
 		if (argc < 0)
-			die("Bad branch.%s.mergeoptions string: %s", branch,
+			die(_("Bad branch.%s.mergeoptions string: %s"), branch,
 			    split_cmdline_strerror(argc));
 		argv =3D xrealloc(argv, sizeof(*argv) * (argc + 2));
 		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
@@ -532,7 +532,7 @@ static int git_merge_config(const char *k, const ch=
ar *v, void *cb)
 		int is_bool;
 		shortlog_len =3D git_config_bool_or_int(k, v, &is_bool);
 		if (!is_bool && shortlog_len < 0)
-			return error("%s: negative length %s", k, v);
+			return error(_("%s: negative length %s"), k, v);
 		if (is_bool && shortlog_len)
 			shortlog_len =3D DEFAULT_MERGE_LOG_LEN;
 		return 0;
@@ -579,7 +579,7 @@ static int read_tree_trivial(unsigned char *common,=
 unsigned char *head,
 static void write_tree_trivial(unsigned char *sha1)
 {
 	if (write_cache_as_tree(sha1, 0, NULL))
-		die("git write-tree failed to write a tree");
+		die(_("git write-tree failed to write a tree"));
 }
=20
 int try_merge_command(const char *strategy, size_t xopts_nr,
@@ -621,7 +621,7 @@ int try_merge_command(const char *strategy, size_t =
xopts_nr,
 	free(args);
 	discard_cache();
 	if (read_cache() < 0)
-		die("failed to read the cache");
+		die(_("failed to read the cache"));
 	resolve_undo_clear();
=20
 	return ret;
@@ -638,7 +638,7 @@ static int try_merge_strategy(const char *strategy,=
 struct commit_list *common,
 	if (active_cache_changed &&
 			(write_cache(index_fd, active_cache, active_nr) ||
 			 commit_locked_index(lock)))
-		return error("Unable to write index.");
+		return error(_("Unable to write index."));
 	rollback_lock_file(lock);
=20
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
@@ -651,7 +651,7 @@ static int try_merge_strategy(const char *strategy,=
 struct commit_list *common,
 		struct commit_list *j;
=20
 		if (remoteheads->next) {
-			error("Not handling anything other than two heads merge.");
+			error(_("Not handling anything other than two heads merge."));
 			return 2;
 		}
=20
@@ -663,7 +663,7 @@ static int try_merge_strategy(const char *strategy,=
 struct commit_list *common,
=20
 		for (x =3D 0; x < xopts_nr; x++)
 			if (parse_merge_opt(&o, xopts[x]))
-				die("Unknown option for merge-recursive: -X%s", xopts[x]);
+				die(_("Unknown option for merge-recursive: -X%s"), xopts[x]);
=20
 		o.branch1 =3D head_arg;
 		o.branch2 =3D remoteheads->item->util;
@@ -677,7 +677,7 @@ static int try_merge_strategy(const char *strategy,=
 struct commit_list *common,
 		if (active_cache_changed &&
 				(write_cache(index_fd, active_cache, active_nr) ||
 				 commit_locked_index(lock)))
-			die ("unable to write %s", get_index_file());
+			die (_("unable to write %s"), get_index_file());
 		rollback_lock_file(lock);
 		return clean ? 0 : 1;
 	} else {
@@ -749,7 +749,7 @@ int checkout_fast_forward(const unsigned char *head=
, const unsigned char *remote
 		return -1;
 	if (write_cache(fd, active_cache, active_nr) ||
 		commit_locked_index(lock_file))
-		die("unable to write new index file");
+		die(_("unable to write new index file"));
 	return 0;
 }
=20
@@ -852,7 +852,7 @@ static int suggest_conflicts(int renormalizing)
=20
 	fp =3D fopen(git_path("MERGE_MSG"), "a");
 	if (!fp)
-		die_errno("Could not open '%s' for writing",
+		die_errno(_("Could not open '%s' for writing"),
 			  git_path("MERGE_MSG"));
 	fprintf(fp, "\nConflicts:\n");
 	for (pos =3D 0; pos < active_nr; pos++) {
@@ -868,8 +868,8 @@ static int suggest_conflicts(int renormalizing)
 	}
 	fclose(fp);
 	rerere(allow_rerere_auto);
-	printf("Automatic merge failed; "
-			"fix conflicts and then commit the result.\n");
+	printf(_("Automatic merge failed; "
+			"fix conflicts and then commit the result.\n"));
 	return 1;
 }
=20
@@ -883,7 +883,7 @@ static struct commit *is_old_style_invocation(int a=
rgc, const char **argv)
 			return NULL;
 		second_token =3D lookup_commit_reference_gently(second_sha1, 0);
 		if (!second_token)
-			die("'%s' is not a commit", argv[1]);
+			die(_("'%s' is not a commit"), argv[1]);
 		if (hashcmp(second_token->object.sha1, head))
 			return NULL;
 	}
@@ -951,7 +951,7 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
 		const char *nargv[] =3D {"reset", "--merge", NULL};
=20
 		if (!file_exists(git_path("MERGE_HEAD")))
-			die("There is no merge to abort (MERGE_HEAD missing).");
+			die(_("There is no merge to abort (MERGE_HEAD missing)."));
=20
 		/* Invoke 'git reset --merge' */
 		return cmd_reset(nargc, nargv, prefix);
@@ -966,10 +966,10 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		 * add/rm <file>', just 'git commit'.
 		 */
 		if (advice_resolve_conflict)
-			die("You have not concluded your merge (MERGE_HEAD exists).\n"
-			    "Please, commit your changes before you can merge.");
+			die(_("You have not concluded your merge (MERGE_HEAD exists).\n"
+				  "Please, commit your changes before you can merge."));
 		else
-			die("You have not concluded your merge (MERGE_HEAD exists).");
+			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
 	resolve_undo_clear();
=20
@@ -978,12 +978,12 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
=20
 	if (squash) {
 		if (!allow_fast_forward)
-			die("You cannot combine --squash with --no-ff.");
+			die(_("You cannot combine --squash with --no-ff."));
 		option_commit =3D 0;
 	}
=20
 	if (!allow_fast_forward && fast_forward_only)
-		die("You cannot combine --no-ff with --ff-only.");
+		die(_("You cannot combine --no-ff with --ff-only."));
=20
 	if (!argc)
 		usage_with_options(builtin_merge_usage,
@@ -1011,16 +1011,16 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 		 * We do the same for "git pull".
 		 */
 		if (argc !=3D 1)
-			die("Can merge only exactly one commit into "
-				"empty head");
+			die(_("Can merge only exactly one commit into "
+				"empty head"));
 		if (squash)
-			die("Squash commit into empty head not supported yet");
+			die(_("Squash commit into empty head not supported yet"));
 		if (!allow_fast_forward)
-			die("Non-fast-forward commit does not make sense into "
-			    "an empty head");
+			die(_("Non-fast-forward commit does not make sense into "
+			    "an empty head"));
 		remote_head =3D peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
 		if (!remote_head)
-			die("%s - not something we can merge", argv[0]);
+			die(_("%s - not something we can merge"), argv[0]);
 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
 				DIE_ON_ERR);
 		read_empty(remote_head->sha1, 0);
@@ -1066,7 +1066,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
=20
 		o =3D peel_to_type(argv[i], 0, NULL, OBJ_COMMIT);
 		if (!o)
-			die("%s - not something we can merge", argv[i]);
+			die(_("%s - not something we can merge"), argv[i]);
 		commit =3D lookup_commit(o->sha1);
 		commit->util =3D (void *)argv[i];
 		remotes =3D &commit_list_insert(commit, remotes)->next;
@@ -1158,11 +1158,11 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 		if (allow_trivial && !fast_forward_only) {
 			/* See if it is really trivial. */
 			git_committer_info(IDENT_ERROR_ON_NO_NAME);
-			printf("Trying really trivial in-index merge...\n");
+			printf(_("Trying really trivial in-index merge...\n"));
 			if (!read_tree_trivial(common->item->object.sha1,
 					head, remoteheads->item->object.sha1))
 				return merge_trivial();
-			printf("Nope.\n");
+			printf(_("Nope.\n"));
 		}
 	} else {
 		/*
@@ -1195,7 +1195,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	}
=20
 	if (fast_forward_only)
-		die("Not possible to fast-forward, aborting.");
+		die(_("Not possible to fast-forward, aborting."));
=20
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_ERROR_ON_NO_NAME);
@@ -1221,11 +1221,11 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 	for (i =3D 0; i < use_strategies_nr; i++) {
 		int ret;
 		if (i) {
-			printf("Rewinding the tree to pristine...\n");
+			printf(_("Rewinding the tree to pristine...\n"));
 			restore_state();
 		}
 		if (use_strategies_nr !=3D 1)
-			printf("Trying merge strategy %s...\n",
+			printf(_("Trying merge strategy %s...\n"),
 				use_strategies[i]->name);
 		/*
 		 * Remember which strategy left the state in the working
@@ -1286,17 +1286,17 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 		restore_state();
 		if (use_strategies_nr > 1)
 			fprintf(stderr,
-				"No merge strategy handled the merge.\n");
+				_("No merge strategy handled the merge.\n"));
 		else
-			fprintf(stderr, "Merge with strategy %s failed.\n",
+			fprintf(stderr, _("Merge with strategy %s failed.\n"),
 				use_strategies[0]->name);
 		return 2;
 	} else if (best_strategy =3D=3D wt_strategy)
 		; /* We already have its result in the working tree. */
 	else {
-		printf("Rewinding the tree to pristine...\n");
+		printf(_("Rewinding the tree to pristine...\n"));
 		restore_state();
-		printf("Using the %s to prepare resolving by hand.\n",
+		printf(_("Using the %s to prepare resolving by hand.\n"),
 			best_strategy);
 		try_merge_strategy(best_strategy, common, head_arg);
 	}
@@ -1312,35 +1312,35 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 				sha1_to_hex(j->item->object.sha1));
 		fd =3D open(git_path("MERGE_HEAD"), O_WRONLY | O_CREAT, 0666);
 		if (fd < 0)
-			die_errno("Could not open '%s' for writing",
+			die_errno(_("Could not open '%s' for writing"),
 				  git_path("MERGE_HEAD"));
 		if (write_in_full(fd, buf.buf, buf.len) !=3D buf.len)
-			die_errno("Could not write to '%s'", git_path("MERGE_HEAD"));
+			die_errno(_("Could not write to '%s'"), git_path("MERGE_HEAD"));
 		close(fd);
 		strbuf_addch(&merge_msg, '\n');
 		fd =3D open(git_path("MERGE_MSG"), O_WRONLY | O_CREAT, 0666);
 		if (fd < 0)
-			die_errno("Could not open '%s' for writing",
+			die_errno(_("Could not open '%s' for writing"),
 				  git_path("MERGE_MSG"));
 		if (write_in_full(fd, merge_msg.buf, merge_msg.len) !=3D
 			merge_msg.len)
-			die_errno("Could not write to '%s'", git_path("MERGE_MSG"));
+			die_errno(_("Could not write to '%s'"), git_path("MERGE_MSG"));
 		close(fd);
 		fd =3D open(git_path("MERGE_MODE"), O_WRONLY | O_CREAT | O_TRUNC, 06=
66);
 		if (fd < 0)
-			die_errno("Could not open '%s' for writing",
+			die_errno(_("Could not open '%s' for writing"),
 				  git_path("MERGE_MODE"));
 		strbuf_reset(&buf);
 		if (!allow_fast_forward)
 			strbuf_addf(&buf, "no-ff");
 		if (write_in_full(fd, buf.buf, buf.len) !=3D buf.len)
-			die_errno("Could not write to '%s'", git_path("MERGE_MODE"));
+			die_errno(_("Could not write to '%s'"), git_path("MERGE_MODE"));
 		close(fd);
 	}
=20
 	if (merge_was_ok) {
-		fprintf(stderr, "Automatic merge went well; "
-			"stopped before committing as requested\n");
+		fprintf(stderr, _("Automatic merge went well; "
+			"stopped before committing as requested\n"));
 		return 0;
 	} else
 		return suggest_conflicts(option_renormalize);
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 5f731a1..ccd5a56 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -150,8 +150,14 @@ test_expect_success 'will not overwrite untracked =
file on unborn branch' '
 	git rm -fr . &&
 	git checkout --orphan new &&
 	cp important c0.c &&
-	test_must_fail git merge c0 2>out &&
-	test_cmp out expect &&
+	test_must_fail git merge c0 2>out
+'
+
+test_expect_success NO_GETTEXT_POISON 'will not overwrite untracked fi=
le on unborn branch: output' '
+	test_cmp out expect
+'
+
+test_expect_success 'will not overwrite untracked file on unborn branc=
h .git/MERGE_HEAD sanity etc.' '
 	test_path_is_missing .git/MERGE_HEAD &&
 	test_cmp important c0.c
 '
diff --git a/t/t7611-merge-abort.sh b/t/t7611-merge-abort.sh
index 61890bc..760271c 100755
--- a/t/t7611-merge-abort.sh
+++ b/t/t7611-merge-abort.sh
@@ -46,8 +46,14 @@ test_expect_success 'setup' '
 pre_merge_head=3D"$(git rev-parse HEAD)"
=20
 test_expect_success 'fails without MERGE_HEAD (unstarted merge)' '
-	test_must_fail git merge --abort 2>output &&
-	grep -q MERGE_HEAD output &&
+	test_must_fail git merge --abort 2>output
+'
+
+test_expect_success NO_GETTEXT_POISON 'fails without MERGE_HEAD (unsta=
rted merge): fatal output' '
+	grep -q MERGE_HEAD output
+'
+
+test_expect_success 'fails without MERGE_HEAD (unstarted merge): .git/=
MERGE_HEAD sanity' '
 	test ! -f .git/MERGE_HEAD &&
 	test "$pre_merge_head" =3D "$(git rev-parse HEAD)"
 '
@@ -57,8 +63,14 @@ test_expect_success 'fails without MERGE_HEAD (compl=
eted merge)' '
 	test ! -f .git/MERGE_HEAD &&
 	# Merge successfully completed
 	post_merge_head=3D"$(git rev-parse HEAD)" &&
-	test_must_fail git merge --abort 2>output &&
-	grep -q MERGE_HEAD output &&
+	test_must_fail git merge --abort 2>output
+'
+
+test_expect_success NO_GETTEXT_POISON 'fails without MERGE_HEAD (compl=
eted merge): output' '
+	grep -q MERGE_HEAD output
+'
+
+test_expect_success 'fails without MERGE_HEAD (completed merge): .git/=
MERGE_HEAD sanity' '
 	test ! -f .git/MERGE_HEAD &&
 	test "$post_merge_head" =3D "$(git rev-parse HEAD)"
 '
--=20
1.7.2.3
