Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9EDC1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 14:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJQWf0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 18:35:26 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:37025 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeJQWf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 18:35:26 -0400
Received: by mail-qt1-f181.google.com with SMTP id d14-v6so30249371qto.4
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0Cw9cwzamNP15H3a130kz5XCR4wPmYpYrC+nh8aEgwU=;
        b=fwgV/Qphh0gnO21Rmo0J1tN+LWoV7c7aZ4rNAErsRMTcMZdagRx/9431pVaGyvPNgt
         bBB2NsA+9BUP2TOekL8RX/cAyDC7OTPuzDF1UI5gtILXrM95GG+NMvszLrJ17ccP4OKk
         0YCZ3yr7q3GEpuKpaD27uORD2e5R44Czreh3lEgsDMYaoBIupYoLD5HjTUPx8OSqe+cY
         vHfPfH3GTXmLQqDdrcdxqyubIh7nSskDMN0ZYZTK6F6QyaFktuvkssiTkdFoXTHfsBRe
         gAtnq5SqDMGlGwGuesDiuVFOG23HnUekcgmWf3cc36RB6T5zuc0XfUst0iREiIKucc4W
         xOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=0Cw9cwzamNP15H3a130kz5XCR4wPmYpYrC+nh8aEgwU=;
        b=rA7F2q6naR6NvbRLdUscCsy6Q4r0pVL7a72IW/2JcSJxCRMFyggU3yHeZM8kNCcAuK
         Z1kiXC40AkdSqkMvTOb9AXz019Herwz97jle4QsHQp9M5E+s8kdu0K71gEbcY9uEs5a4
         s9NHDYGcwOyFttGi0B24s1aJRzZhKK0G1S/o9UrulUCD3wtcr2jk+Mvs1nwaobzCmZA0
         rigSRRkockrwGEklfeGvqN9bwUOWy//ttPdtPAJLU5+0E1utBhe+xCTjT49FPvEGhikR
         iyIiwb6zxn1SgbRqYQXJiRVNE65ntX84WWHtib8Bzvl0FQbBJbpBHqpGNFvVWEfemLGq
         G9xg==
X-Gm-Message-State: ABuFfoiEvp7Uli1ff2i7Ydpv8mwzQAwUgwVQiAjabM99nWgQsMk6Y9yE
        1E1zosQbfEjJPPSJjvE0BLzRzRiu
X-Google-Smtp-Source: ACcGV63eZC3YcTHtCfVZtMctwGScpvfBYHfV2exiL6c0GYPfJ3Ibzb90yisCZTvoGRCJ4X02pfZxtA==
X-Received: by 2002:ac8:32c9:: with SMTP id a9-v6mr25621197qtb.41.1539787165076;
        Wed, 17 Oct 2018 07:39:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::5:5411])
        by smtp.gmail.com with ESMTPSA id c85-v6sm8997285qke.89.2018.10.17.07.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 07:39:24 -0700 (PDT)
Date:   Wed, 17 Oct 2018 07:39:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     kernel-team@fb.com
Subject: [RFC] cherry-pick notes to find out cherry-picks from the origin
Message-ID: <20181017143921.GR270328@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Junio, Jeff.

A while ago, I proposed changes to name-rev and describe so that they
can identify the commits cherry-picked from the one which is being
shown.

  https://public-inbox.org/git/20180726153714.GX1934745@devbig577.frc2.facebook.com/T/

While the use-cases - e.g. tracking down which release / stable
branches a given commit ended up in - weren't controversial, it was
suggested that it'd make more sense to use notes to link cherry-picks
instead of building the feature into name-rev.

The patch appended to this message implements most of it (sans tests
and documentation).  It's composed of the following two parts.

* A new built-in command note-cherry-picks, which walks the specified
  commits and if they're marked with the cherry-pick trailer, adds the
  backlink to the origin commit using Cherry-picked-to tag in a
  cherry-picks note.

* When formatting a cherry-picks note for display, nested cherry-picks
  are followed from each Cherry-picked-to tag and printed out with
  matching indentations.

Combined with name-rev --stdin, it can produce outputs like the following.

    commit 82cddd79f962de0bb1e7cdd95d48b48633335816 (branch2)
    Author: Tejun Heo <tj@kernel.org>
    Date:   Wed Jul 25 21:31:35 2018 -0700

	commit 4

    (cherry picked from commit 10f7ce0a0e524279f022b48460c088a108b45d54 (master~1))
    (cherry picked from commit d433e3b4d5a19b3d29e2c8349fe88ceade5f6190 (branch1))

    commit d433e3b4d5a19b3d29e2c8349fe88ceade5f6190 (branch1)
    Author: Tejun Heo <tj@kernel.org>
    Date:   Wed Jul 25 21:31:35 2018 -0700

	commit 4

	(cherry picked from commit 10f7ce0a0e524279f022b48460c088a108b45d54 (master~1))

    Notes (cherry-picks):
	Cherry-picked-to: 82cddd79f962de0bb1e7cdd95d48b48633335816 (branch2)

    commit 10f7ce0a0e524279f022b48460c088a108b45d54 (master~1)
    Author: Tejun Heo <tj@kernel.org>
    Date:   Wed Jul 25 21:31:35 2018 -0700

	commit 4

    Notes (cherry-picks):
	Cherry-picked-to: d433e3b4d5a19b3d29e2c8349fe88ceade5f6190 (branch1)
	Cherry-picked-to:   82cddd79f962de0bb1e7cdd95d48b48633335816 (branch2)
	Cherry-picked-to: 2dd08fe869986c26bc1152a0bcec8c2fa48c50f7 (branch5)
	Cherry-picked-to: fa8b79edc5dfff21753c2ccfc1a1828336c4c070 (branch4~5)
	Cherry-picked-to:   a1fb6024e3bda5549de1d15d8fa37e8c3a7eecbe (branch4~2)
	Cherry-picked-to:     58964342321a65e316ff47db33f7063743bc0de8 (branch4)
	Cherry-picked-to:   45e0d5f31c869dcc89b9737853e64489e2ad80b0 (branch4~1)
	Cherry-picked-to: 58a8d36b2532feb0a14b4fc2a50d587e64f38324 (branch3)

Locally, the notes can be kept up-to-date with a trivial post-commit
hook which invokes note-cherry-picks on the new commit; however, I'm
having a bit of trouble figuring out a way to keep it up-to-date when
multiple trees are involved.  AFAICS, there are two options.

1. Ensuring that the notes are always generated on local commits and
   whenever new commits are received through fetch/pulls.

2. Ensuring that the notes are always generated on local commits and
   transported with push/pulls.

3. A hybrid approach - also generate notes on the receiving end and
   ensure that fetch/pulls receives the notes together (ie. similar to
   --tags option to git-fetch).

#1 seems simpler and more robust to me.  Unfortunately, I can't see a
way to implement any of the three options with the existing hooks.
For #1, there's no post-fetch hook.  For #2 and #3, there doesn't seem
to be a fool-proof way to make sure that the notes are transported
together.  Any suggestions would be greatly appreciated.

Please let me know what you think.

Thanks.

---
 Makefile                    |    1 
 builtin.h                   |    1 
 builtin/note-cherry-picks.c |  197 ++++++++++++++++++++++++++++++++++++++++++++
 builtin/notes.c             |   17 ++-
 git.c                       |    1 
 notes.c                     |   95 +++++++++++++++++++++
 notes.h                     |    7 +
 object.c                    |    4 
 object.h                    |    6 +
 9 files changed, 320 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 5c8307b7c..fb0ff3ce9 100644
--- a/Makefile
+++ b/Makefile
@@ -1073,6 +1073,7 @@ BUILTIN_OBJS += builtin/multi-pack-index.o
 BUILTIN_OBJS += builtin/mv.o
 BUILTIN_OBJS += builtin/name-rev.o
 BUILTIN_OBJS += builtin/notes.o
+BUILTIN_OBJS += builtin/note-cherry-picks.o
 BUILTIN_OBJS += builtin/pack-objects.o
 BUILTIN_OBJS += builtin/pack-redundant.o
 BUILTIN_OBJS += builtin/pack-refs.o
diff --git a/builtin.h b/builtin.h
index 962f0489a..d9d019abc 100644
--- a/builtin.h
+++ b/builtin.h
@@ -195,6 +195,7 @@ extern int cmd_multi_pack_index(int argc, const char **argv, const char *prefix)
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_notes(int argc, const char **argv, const char *prefix);
+extern int cmd_note_cherry_picks(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
diff --git a/builtin/note-cherry-picks.c b/builtin/note-cherry-picks.c
new file mode 100644
index 000000000..343e22c0d
--- /dev/null
+++ b/builtin/note-cherry-picks.c
@@ -0,0 +1,197 @@
+#include "builtin.h"
+#include "cache.h"
+#include "strbuf.h"
+#include "repository.h"
+#include "config.h"
+#include "commit.h"
+#include "notes.h"
+#include "trailer.h"
+#include "revision.h"
+#include "argv-array.h"
+#include "commit-slab.h"
+#include "list-objects.h"
+#include "object-store.h"
+#include "parse-options.h"
+
+define_commit_slab(commit_cherry_picks, struct object_array *);
+
+static const char * const note_cherry_picks_usage[] = {
+	N_("git note-cherry-picks [<options>] [<commit-ish>...]"),
+	NULL
+};
+
+static const char cherry_picked_prefix[] = "(cherry picked from commit ";
+static const char cherry_picked_to_tag[] = "Cherry-picked-to: ";
+static int verbose, clear;
+static struct object_array cherry_picked = OBJECT_ARRAY_INIT;
+static struct commit_cherry_picks cherry_picks;
+
+static struct object_array *get_commit_cherry_picks(struct commit *commit)
+{
+	struct object_array **slot =
+		commit_cherry_picks_peek(&cherry_picks, commit);
+
+	return slot ? *slot : NULL;
+}
+
+static struct object_array *get_create_commit_cherry_picks(struct commit *commit)
+{
+	struct object_array **slot =
+		commit_cherry_picks_at(&cherry_picks, commit);
+	struct object_array *cps = *slot;
+	int i;
+
+	if (cps)
+		return cps;
+
+	add_object_array(&commit->object, oid_to_hex(&commit->object.oid),
+			 &cherry_picked);
+	*slot = cps = xmalloc(sizeof(struct object_array));
+	*cps = (struct object_array)OBJECT_ARRAY_INIT;
+
+	read_cherry_picks_note(&commit->object.oid, cps);
+	if (verbose) {
+		for (i = 0; i < cps->nr; i++)
+			fprintf(stderr, "Read  note %s -> %s\n",
+				oid_to_hex(&commit->object.oid),
+				cps->objects[i].name);
+	}
+	return cps;
+}
+
+static void record_cherry_pick(struct commit *commit, void *unused)
+{
+	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+	struct trailer_info info;
+	int i;
+
+	buffer = read_object_file(&commit->object.oid, &type, &size);
+	trailer_info_get(&info, buffer, &opts);
+
+	/* when nested, the last trailer describes the latest cherry-pick */
+	for (i = info.trailer_nr - 1; i >= 0; i--) {
+		const int prefix_len = sizeof(cherry_picked_prefix) - 1;
+		char *line = info.trailers[i];
+
+		if (!strncmp(line, cherry_picked_prefix, prefix_len)) {
+			struct object_id from_oid;
+			struct object *from_object;
+			struct commit *from_commit;
+			struct object_array *from_cps;
+			char cherry_hex[GIT_MAX_HEXSZ + 1];
+
+			if (get_oid_hex(line + prefix_len, &from_oid))
+				continue;
+
+			from_object = parse_object(the_repository, &from_oid);
+			if (!from_object || from_object->type != OBJ_COMMIT)
+				continue;
+
+			from_commit = (struct commit *)from_object;
+			from_cps = get_create_commit_cherry_picks(from_commit);
+
+			oid_to_hex_r(cherry_hex, &commit->object.oid);
+
+			if (!object_array_contains_name(from_cps, cherry_hex))
+				add_object_array(&commit->object, cherry_hex,
+						 from_cps);
+			break;
+		}
+	}
+
+	free(buffer);
+}
+
+static void clear_cherry_pick_note(struct commit *commit, void *prefix)
+{
+	struct argv_array args;
+
+	argv_array_init(&args);
+	argv_array_pushl(&args, "notes", "--ref", "cherry-picks", "remove",
+			 "--ignore-missing",
+			 oid_to_hex(&commit->object.oid), NULL);
+	cmd_notes(args.argc, args.argv, prefix);
+}
+
+static int note_cherry_picks(struct commit *commit, const char *prefix)
+{
+	char from_hex[GIT_MAX_HEXSZ + 1];
+	struct strbuf note = STRBUF_INIT;
+	struct argv_array args;
+	struct object_array *cps;
+	int i, ret;
+
+	cps = get_commit_cherry_picks(commit);
+	if (!cps)
+		return 0;
+
+	oid_to_hex_r(from_hex, &commit->object.oid);
+
+	for (i = 0; i < cps->nr; i++) {
+		const char *cherry_hex = cps->objects[i].name;
+
+		strbuf_addf(&note, "%s%s\n", NOTES_CHERRY_PICKED_TO, cherry_hex);
+		if (verbose)
+			fprintf(stderr, "Write note %s -> %s\n",
+				from_hex, cherry_hex);
+	}
+
+	argv_array_init(&args);
+	argv_array_pushl(&args, "notes", "--ref", "cherry-picks", "add",
+			 "--force", "--message", note.buf, from_hex, NULL);
+	if (!verbose)
+		argv_array_push(&args, "--quiet");
+	ret = cmd_notes(args.argc, args.argv, prefix);
+	strbuf_release(&note);
+	return ret;
+}
+
+int cmd_note_cherry_picks(int argc, const char **argv, const char *prefix)
+{
+	struct rev_info revs;
+	int i, ret;
+	struct setup_revision_opt s_r_opt = {
+		.def = "HEAD",
+		.revarg_opt = REVARG_CANNOT_BE_FILENAME
+	};
+	struct option options[] = {
+		OPT_BOOL(0, "clear", &clear, N_("clear cherry-pick notes from the specified commits")),
+		OPT__VERBOSE(&verbose, N_("verbose")),
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	init_revisions(&revs, prefix);
+	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
+	argc = parse_options(argc, argv, prefix, options,
+			     note_cherry_picks_usage, 0);
+	if (argc > 1)
+		die(_("unrecognized argument: %s"), argv[1]);
+
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+
+	if (clear) {
+		traverse_commit_list(&revs, clear_cherry_pick_note, NULL,
+				     (void *)prefix);
+		return 0;
+	}
+
+	init_commit_cherry_picks(&cherry_picks);
+	traverse_commit_list(&revs, record_cherry_pick, NULL, NULL);
+
+	object_array_remove_duplicates(&cherry_picked);
+
+	for (i = 0; i < cherry_picked.nr; i++) {
+		ret = note_cherry_picks((void *)cherry_picked.objects[i].item,
+					prefix);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/builtin/notes.c b/builtin/notes.c
index c05cd004a..6b623b25c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -26,7 +26,7 @@
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
-	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] add [-f] [-q] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
 	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
 	N_("git notes [--ref <notes-ref>] append [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
 	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
@@ -394,7 +394,7 @@ static int append_edit(int argc, const char **argv, const char *prefix);
 
 static int add(int argc, const char **argv, const char *prefix)
 {
-	int force = 0, allow_empty = 0;
+	int force = 0, quiet = 0, allow_empty = 0;
 	const char *object_ref;
 	struct notes_tree *t;
 	struct object_id object, new_note;
@@ -416,6 +416,7 @@ static int add(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
 		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
+		OPT__QUIET(&quiet, N_("suppress informational messages")),
 		OPT_END()
 	};
 
@@ -455,8 +456,9 @@ static int add(int argc, const char **argv, const char *prefix)
 			argv[0] = "edit";
 			return append_edit(argc, argv, prefix);
 		}
-		fprintf(stderr, _("Overwriting existing notes for object %s\n"),
-			oid_to_hex(&object));
+		if (!quiet)
+			fprintf(stderr, _("Overwriting existing notes for object %s\n"),
+				oid_to_hex(&object));
 	}
 
 	prepare_note_data(&object, &d, note);
@@ -466,8 +468,9 @@ static int add(int argc, const char **argv, const char *prefix)
 			BUG("combine_notes_overwrite failed");
 		commit_notes(t, "Notes added by 'git notes add'");
 	} else {
-		fprintf(stderr, _("Removing note for object %s\n"),
-			oid_to_hex(&object));
+		if (!quiet)
+			fprintf(stderr, _("Removing note for object %s\n"),
+				oid_to_hex(&object));
 		remove_note(t, object.hash);
 		commit_notes(t, "Notes removed by 'git notes add'");
 	}
@@ -898,7 +901,7 @@ static int remove_one_note(struct notes_tree *t, const char *name, unsigned flag
 static int remove_cmd(int argc, const char **argv, const char *prefix)
 {
 	unsigned flag = 0;
-	int from_stdin = 0;
+	int from_stdin = 0, quiet = 0;
 	struct option options[] = {
 		OPT_BIT(0, "ignore-missing", &flag,
 			N_("attempt to remove non-existent note is not an error"),
diff --git a/git.c b/git.c
index a6f4b44af..aedafff02 100644
--- a/git.c
+++ b/git.c
@@ -512,6 +512,7 @@ static struct cmd_struct commands[] = {
 	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 	{ "name-rev", cmd_name_rev, RUN_SETUP },
 	{ "notes", cmd_notes, RUN_SETUP },
+	{ "note-cherry-picks", cmd_note_cherry_picks, RUN_SETUP },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT },
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
diff --git a/notes.c b/notes.c
index 25cdce28b..19fa3451d 100644
--- a/notes.c
+++ b/notes.c
@@ -1189,6 +1189,26 @@ void free_notes(struct notes_tree *t)
 	memset(t, 0, sizeof(struct notes_tree));
 }
 
+static void walk_cherry_picks(struct object_id *from_oid, struct strbuf *sb,
+			      int level)
+{
+	struct object_array cps = OBJECT_ARRAY_INIT;
+	int i;
+
+	read_cherry_picks_note(from_oid, &cps);
+
+	for (i = 0; i < cps.nr; i++) {
+		strbuf_addf(sb, "    %s%*s%s\n",
+			    NOTES_CHERRY_PICKED_TO, 2 * level, "",
+			    cps.objects[i].name);
+		if (cps.objects[i].item)
+			walk_cherry_picks(&cps.objects[i].item->oid, sb,
+					  level + 1);
+	}
+
+	object_array_clear(&cps);
+}
+
 /*
  * Fill the given strbuf with the notes associated with the given object.
  *
@@ -1208,6 +1228,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	char *msg, *msg_p;
 	unsigned long linelen, msglen;
 	enum object_type type;
+	int format_cherry_picks;
 
 	if (!t)
 		t = &default_notes_tree;
@@ -1250,6 +1271,8 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 		}
 	}
 
+	format_cherry_picks = !raw && !strcmp(t->ref, "refs/notes/cherry-picks");
+
 	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
 		linelen = strchrnul(msg_p, '\n') - msg_p;
 
@@ -1257,6 +1280,17 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 			strbuf_addstr(sb, "    ");
 		strbuf_add(sb, msg_p, linelen);
 		strbuf_addch(sb, '\n');
+
+		if (format_cherry_picks &&
+		    starts_with(msg_p, NOTES_CHERRY_PICKED_TO)) {
+			struct object_id oid;
+
+			if (get_oid_hex(msg_p + strlen(NOTES_CHERRY_PICKED_TO),
+					&oid))
+				continue;
+
+			walk_cherry_picks(&oid, sb, 1);
+		}
 	}
 
 	free(msg);
@@ -1309,3 +1343,64 @@ void expand_loose_notes_ref(struct strbuf *sb)
 		expand_notes_ref(sb);
 	}
 }
+
+void read_cherry_picks_note(const struct object_id *commit_oid,
+			    struct object_array *result)
+{
+	static struct notes_tree notes_tree;
+	const struct object_id *note_oid;
+	unsigned long size;
+	enum object_type type;
+	char *note;
+	struct strbuf **lines, **pline;
+
+	if (!notes_tree.initialized)
+		init_notes(&notes_tree, NOTES_CHERRY_PICKS_REF, NULL, 0);
+
+	note_oid = get_note(&notes_tree, commit_oid);
+	if (!note_oid)
+		return;
+
+	note = read_object_file(note_oid, &type, &size);
+	if (!size) {
+		free(note);
+		return;
+	}
+
+	lines = strbuf_split_buf(note, size, '\n', 0);
+
+	for (pline = lines; *pline; pline++) {
+		struct strbuf *line = *pline;
+		const char *cherry_hex;
+		struct object_id cherry_oid;
+		struct object *cherry_obj;
+
+		strbuf_trim(line);
+
+		if (!starts_with(line->buf, NOTES_CHERRY_PICKED_TO)) {
+			warning("read invalid cherry-pick note on %s: %s",
+				oid_to_hex(commit_oid), line->buf);
+			continue;
+		}
+
+		cherry_hex = line->buf + strlen(NOTES_CHERRY_PICKED_TO);
+
+		if (get_oid_hex(cherry_hex, &cherry_oid)) {
+			warning("read invalid cherry-pick sha1 on %s: %s",
+				oid_to_hex(commit_oid), line->buf);
+			continue;
+		}
+
+		cherry_obj = parse_object(the_repository, &cherry_oid);
+		if (!cherry_obj || cherry_obj->type != OBJ_COMMIT) {
+			warning("read invalid cherry-pick commit on %s: %s",
+				oid_to_hex(commit_oid), line->buf);
+			continue;
+		}
+
+		add_object_array(cherry_obj, cherry_hex, result);
+	}
+
+	strbuf_list_free(lines);
+	free(note);
+}
diff --git a/notes.h b/notes.h
index 414bc6855..b58899c74 100644
--- a/notes.h
+++ b/notes.h
@@ -2,10 +2,14 @@
 #define NOTES_H
 
 #include "string-list.h"
+#include "object.h"
 
 struct object_id;
 struct strbuf;
 
+#define NOTES_CHERRY_PICKS_REF		"refs/notes/cherry-picks"
+#define NOTES_CHERRY_PICKED_TO		"Cherry-picked-to: "
+
 /*
  * Function type for combining two notes annotating the same object.
  *
@@ -317,4 +321,7 @@ void expand_notes_ref(struct strbuf *sb);
  */
 void expand_loose_notes_ref(struct strbuf *sb);
 
+void read_cherry_picks_note(const struct object_id *commit_oid,
+			    struct object_array *result);
+
 #endif
diff --git a/object.c b/object.c
index e54160550..f79652a34 100644
--- a/object.c
+++ b/object.c
@@ -404,7 +404,7 @@ void object_array_clear(struct object_array *array)
 /*
  * Return true iff array already contains an entry with name.
  */
-static int contains_name(struct object_array *array, const char *name)
+int object_array_contains_name(struct object_array *array, const char *name)
 {
 	unsigned nr = array->nr, i;
 	struct object_array_entry *object = array->objects;
@@ -422,7 +422,7 @@ void object_array_remove_duplicates(struct object_array *array)
 
 	array->nr = 0;
 	for (src = 0; src < nr; src++) {
-		if (!contains_name(array, objects[src].name)) {
+		if (!object_array_contains_name(array, objects[src].name)) {
 			if (src != array->nr)
 				objects[array->nr] = objects[src];
 			array->nr++;
diff --git a/object.h b/object.h
index 0feb90ae6..ee14ce595 100644
--- a/object.h
+++ b/object.h
@@ -172,6 +172,12 @@ typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
 void object_array_filter(struct object_array *array,
 			 object_array_each_func_t want, void *cb_data);
 
+/*
+ * Returns 1 if array already contains an entry with the specified name.
+ * Otherwise, 0.
+ */
+int object_array_contains_name(struct object_array *array, const char *name);
+
 /*
  * Remove from array all but the first entry with a given name.
  * Warning: this function uses an O(N^2) algorithm.
