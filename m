From: Alangi Derick <alangiderick@gmail.com>
Subject: [PATCH] fixed translation error in fast-export
Date: Mon, 4 May 2015 12:33:57 +0100
Message-ID: <554767e1.e33ac20a.753d.ffffc684@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon May 04 14:36:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpFcG-0003NH-L5
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 14:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbbEDMgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 08:36:53 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38784 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbbEDMgv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 08:36:51 -0400
Received: by wiun10 with SMTP id n10so108434111wiu.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject;
        bh=ezgY+77e22jgTY0Jpg6ruxMshLQkzZpRDsCppxILnvo=;
        b=00rYyCiGR246hWjZw8wpUfZvZU+YZ4MJ4Ti8Gnvu+e1jsZnF14rd/YBhEPgGIEPdVN
         orJE1FITkakEoIS+zEex4Nk9Clxpwv9qBD3RjICXfYCOQpoNVews4rQUb9hlNL7WEMh7
         UPJeM4O5364H0PYKmO1VZCaiUlSEmU9yjr7UnExE1OT0NNv7fWW9HY4+5K9qAR0HN2rD
         HcOkok5AuawsDAPjCjbgi5mQZzYrqb0Wu/ph1V1ByEeAa+G0IOiKgHtO3wx9eI9wQbBW
         B7o8vzYew9p0ny7DPOxAAsLcY0HlXmOTtz4kp1QUAuSZ6Cs7xRvyDaejV9QDRZpoLp20
         8qng==
X-Received: by 10.180.90.169 with SMTP id bx9mr18811499wib.50.1430743010250;
        Mon, 04 May 2015 05:36:50 -0700 (PDT)
Received: from localhost ([195.24.220.134])
        by mx.google.com with ESMTPSA id u3sm20437810wjq.36.2015.05.04.05.36.47
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 05:36:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268318>

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 builtin/fast-export.c | 64 +++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b8182c2..0af5a68 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -51,7 +51,7 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
 	else if (!strcmp(arg, "strip"))
 		signed_tag_mode = STRIP;
 	else
-		return error("Unknown signed-tags mode: %s", arg);
+		return error(_("Unknown signed-tags mode: %s"), arg);
 	return 0;
 }
 
@@ -65,7 +65,7 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 	else if (!strcmp(arg, "rewrite"))
 		tag_of_filtered_mode = REWRITE;
 	else
-		return error("Unknown tag-of-filtered mode: %s", arg);
+		return error(_("Unknown tag-of-filtered mode: %s"), arg);
 	return 0;
 }
 
@@ -236,20 +236,20 @@ static void export_blob(const unsigned char *sha1)
 	} else {
 		buf = read_sha1_file(sha1, &type, &size);
 		if (!buf)
-			die ("Could not read blob %s", sha1_to_hex(sha1));
+			die(_("Could not read blob %s"), sha1_to_hex(sha1));
 		if (check_sha1_signature(sha1, buf, size, typename(type)) < 0)
-			die("sha1 mismatch in blob %s", sha1_to_hex(sha1));
+			die(_("sha1 mismatch in blob %s"), sha1_to_hex(sha1));
 		object = parse_object_buffer(sha1, type, size, buf, &eaten);
 	}
 
 	if (!object)
-		die("Could not read blob %s", sha1_to_hex(sha1));
+		die(_("Could not read blob %s"), sha1_to_hex(sha1));
 
 	mark_next_object(object);
 
 	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
-		die_errno ("Could not write blob '%s'", sha1_to_hex(sha1));
+		die_errno(_("Could not write blob '%s'"), sha1_to_hex(sha1));
 	printf("\n");
 
 	show_progress();
@@ -394,7 +394,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 			break;
 
 		default:
-			die("Unexpected comparison status '%c' for %s, %s",
+			die(_("Unexpected comparison status '%c' for %s, %s"),
 				q->queue[i]->status,
 				ospec->path ? ospec->path : "none",
 				spec->path ? spec->path : "none");
@@ -501,7 +501,7 @@ static void anonymize_ident_line(const char **beg, const char **end)
 	/* skip "committer", "author", "tagger", etc */
 	end_of_header = strchr(*beg, ' ');
 	if (!end_of_header)
-		die("BUG: malformed line fed to anonymize_ident_line: %.*s",
+		die(_("BUG: malformed line fed to anonymize_ident_line: %.*s"),
 		    (int)(*end - *beg), *beg);
 	end_of_header++;
 	strbuf_add(out, *beg, end_of_header - *beg);
@@ -542,13 +542,13 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	commit_buffer = get_commit_buffer(commit, NULL);
 	author = strstr(commit_buffer, "\nauthor ");
 	if (!author)
-		die ("Could not find author in commit %s",
+		die(_("Could not find author in commit %s"),
 		     sha1_to_hex(commit->object.sha1));
 	author++;
 	author_end = strchrnul(author, '\n');
 	committer = strstr(author_end, "\ncommitter ");
 	if (!committer)
-		die ("Could not find committer in commit %s",
+		die(_("Could not find committer in commit %s"),
 		     sha1_to_hex(commit->object.sha1));
 	committer++;
 	committer_end = strchrnul(committer, '\n');
@@ -659,14 +659,14 @@ static void handle_tag(const char *name, struct tag *tag)
 		tagged = ((struct tag *)tagged)->tagged;
 	}
 	if (tagged->type == OBJ_TREE) {
-		warning("Omitting tag %s,\nsince tags of trees (or tags of tags of trees, etc.) are not supported.",
+		warning(_("Omitting tag %s,\nsince tags of trees (or tags of tags of trees, etc.) are not supported."),
 			sha1_to_hex(tag->object.sha1));
 		return;
 	}
 
 	buf = read_sha1_file(tag->object.sha1, &type, &size);
 	if (!buf)
-		die ("Could not read tag %s", sha1_to_hex(tag->object.sha1));
+		die(_("Could not read tag %s"), sha1_to_hex(tag->object.sha1));
 	message = memmem(buf, size, "\n\n", 2);
 	if (message) {
 		message += 2;
@@ -703,17 +703,17 @@ static void handle_tag(const char *name, struct tag *tag)
 		if (signature)
 			switch(signed_tag_mode) {
 			case ABORT:
-				die ("Encountered signed tag %s; use "
-				     "--signed-tags=<mode> to handle it.",
+				die(_("Encountered signed tag %s; use "
+				     "--signed-tags=<mode> to handle it."),
 				     sha1_to_hex(tag->object.sha1));
 			case WARN:
-				warning ("Exporting signed tag %s",
+				warning(_("Exporting signed tag %s"),
 					 sha1_to_hex(tag->object.sha1));
 				/* fallthru */
 			case VERBATIM:
 				break;
 			case WARN_STRIP:
-				warning ("Stripping signature from tag %s",
+				warning(_("Stripping signature from tag %s"),
 					 sha1_to_hex(tag->object.sha1));
 				/* fallthru */
 			case STRIP:
@@ -728,15 +728,15 @@ static void handle_tag(const char *name, struct tag *tag)
 	if (!tagged_mark) {
 		switch(tag_of_filtered_mode) {
 		case ABORT:
-			die ("Tag %s tags unexported object; use "
-			     "--tag-of-filtered-object=<mode> to handle it.",
+			die(_("Tag %s tags unexported object; use "
+			     "--tag-of-filtered-object=<mode> to handle it."),
 			     sha1_to_hex(tag->object.sha1));
 		case DROP:
 			/* Ignore this tag altogether */
 			return;
 		case REWRITE:
 			if (tagged->type != OBJ_COMMIT) {
-				die ("Tag %s tags unexported %s!",
+				die(_("Tag %s tags unexported %s!"),
 				     sha1_to_hex(tag->object.sha1),
 				     typename(tagged->type));
 			}
@@ -749,7 +749,7 @@ static void handle_tag(const char *name, struct tag *tag)
 				if (!(p->object.flags & TREESAME))
 					break;
 				if (!p->parents)
-					die ("Can't find replacement commit for tag %s\n",
+					die(_("Can't find replacement commit for tag %s\n"),
 					     sha1_to_hex(tag->object.sha1));
 				p = p->parents->item;
 			}
@@ -781,7 +781,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
 			tag = (struct tag *)tag->tagged;
 		}
 		if (!tag)
-			die("Tag %s points nowhere?", e->name);
+			die(_("Tag %s points nowhere?"), e->name);
 		return (struct commit *)tag;
 		break;
 	}
@@ -817,7 +817,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 
 		commit = get_commit(e, full_name);
 		if (!commit) {
-			warning("%s: Unexpected object of type %s, skipping.",
+			warning(_("%s: Unexpected object of type %s, skipping."),
 				e->name,
 				typename(e->item->type));
 			continue;
@@ -830,7 +830,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 			export_blob(commit->object.sha1);
 			continue;
 		default: /* OBJ_TAG (nested tags) is already handled */
-			warning("Tag points to object of unexpected type %s, skipping.",
+			warning(_("Tag points to object of unexpected type %s, skipping."),
 				typename(commit->object.type));
 			continue;
 		}
@@ -881,7 +881,7 @@ static void export_marks(char *file)
 
 	f = fopen(file, "w");
 	if (!f)
-		die_errno("Unable to open marks file %s for writing.", file);
+		die_errno(_("Unable to open marks file %s for writing."), file);
 
 	for (i = 0; i < idnums.size; i++) {
 		if (deco->base && deco->base->type == 1) {
@@ -898,7 +898,7 @@ static void export_marks(char *file)
 	e |= ferror(f);
 	e |= fclose(f);
 	if (e)
-		error("Unable to write marks file %s.", file);
+		error(_("Unable to write marks file %s."), file);
 }
 
 static void import_marks(char *input_file)
@@ -906,7 +906,7 @@ static void import_marks(char *input_file)
 	char line[512];
 	FILE *f = fopen(input_file, "r");
 	if (!f)
-		die_errno("cannot read '%s'", input_file);
+		die_errno(_("cannot read '%s'"), input_file);
 
 	while (fgets(line, sizeof(line), f)) {
 		uint32_t mark;
@@ -918,20 +918,20 @@ static void import_marks(char *input_file)
 
 		line_end = strchr(line, '\n');
 		if (line[0] != ':' || !line_end)
-			die("corrupt mark line: %s", line);
+			die(_("corrupt mark line: %s"), line);
 		*line_end = '\0';
 
 		mark = strtoumax(line + 1, &mark_end, 10);
 		if (!mark || mark_end == line + 1
 			|| *mark_end != ' ' || get_sha1_hex(mark_end + 1, sha1))
-			die("corrupt mark line: %s", line);
+			die(_("corrupt mark line: %s"), line);
 
 		if (last_idnum < mark)
 			last_idnum = mark;
 
 		type = sha1_object_info(sha1, NULL);
 		if (type < 0)
-			die("object not found: %s", sha1_to_hex(sha1));
+			die(_("object not found: %s"), sha1_to_hex(sha1));
 
 		if (type != OBJ_COMMIT)
 			/* only commits */
@@ -939,12 +939,12 @@ static void import_marks(char *input_file)
 
 		commit = lookup_commit(sha1);
 		if (!commit)
-			die("not a commit? can't happen: %s", sha1_to_hex(sha1));
+			die(_("not a commit? can't happen: %s"), sha1_to_hex(sha1));
 
 		object = &commit->object;
 
 		if (object->flags & SHOWN)
-			error("Object %s already has a mark", sha1_to_hex(sha1));
+			error(_("Object %s already has a mark"), sha1_to_hex(sha1));
 
 		mark_object(object, mark);
 
@@ -1044,7 +1044,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	get_tags_and_duplicates(&revs.cmdline);
 
 	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 	revs.diffopt.format_callback = show_filemodify;
 	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
 	while ((commit = get_revision(&revs))) {
-- 
2.4.0.7.g31e7007.dirty
