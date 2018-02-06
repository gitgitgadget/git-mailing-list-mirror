Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE551F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeBFAbG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:31:06 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40899 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFAbB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:31:01 -0500
Received: by mail-pl0-f66.google.com with SMTP id g18so139763plo.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZyjllGwtsfi0pbJA0Fhb3Ai6TsP3XMrWzqYdRCqMz/8=;
        b=seR53uMnNiXdPKR5IM5hjMV6Rrahb9LZBugQkEFTTCVLFq01E/Ma1AqqFck2ljzaxU
         puqfl5R7ep/UZpCqN+w/HR2jV7RbApISEYNBzrhPxC219DzrIUxZ2NA8NCpNHotPKN5R
         ZXhDmDGaW3EajSqeJKgEBpLNwvDhjZvfzuurHOr8Jq2vr+O9UQyUfVydpepU4chm6bYd
         aMfYNAB6eAxTeY9VDS1EyRc2jUzKJhKFu/nuEoT6lzfrvrrHynnnkLsPzUSa9DjKdGb9
         PzpG6deUbXIuycGyLUyQu94rlciLIoC0oncvtyJ+p1zt+dB523dHE2Lx8La/Eetc2Uvh
         ix+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZyjllGwtsfi0pbJA0Fhb3Ai6TsP3XMrWzqYdRCqMz/8=;
        b=WqvQMy7kDtZi/47VSsfhq+c6lpl5XupwWt98IiBHboD81m3eArgrA9PqnNhhOf89PW
         5EgC9WaAYyk0Jzdfa8qtu45o0sVwigiWb18GTgJyQUjlqbxLCiZDy/eNumNyaaUPdk4M
         kVSlw7QpQj2cd6tFcstipZNqLNIeKYWlG2PUJutOkVY/yFqPqUCjTWb2n6fNUrbU2OOa
         +P0rJkcvPVzHV109ZPtOAtssIfBv67cq6QSG83fXecqmiKvJoCndloM0fHGFc1glTUwg
         bvld9db6JCZ4AJlIWnIsOGN4YHEh0xu/viHo2o+ymNqhOF1UWFvkjCL1CAmuFbMkdTRI
         Mnzg==
X-Gm-Message-State: APf1xPB1jqiLHeX380Aj5B+6j65e0jZPkwR6Y61rzSVyM8XJBH4eHdMT
        LAbu9KwMkA1vAXPyhbaVx3Pf7J27X00=
X-Google-Smtp-Source: AH8x224esmSPfknXJ8COYCd5NnC5113tr4zNSKFbc8aRCsNfz/pt9/4C43zHAbKA+Ar+YAUYOHbO1g==
X-Received: by 2002:a17:902:b60b:: with SMTP id b11-v6mr572006pls.210.1517877060407;
        Mon, 05 Feb 2018 16:31:00 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m1sm5367279pfi.120.2018.02.05.16.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:30:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 182/194] commit: add repository argument to get_commit_buffer
Date:   Mon,  5 Feb 2018 16:17:37 -0800
Message-Id: <20180206001749.218943-84-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fast-export.c                      |  2 +-
 builtin/fmt-merge-msg.c                    |  2 +-
 builtin/log.c                              |  3 ++-
 builtin/replace.c                          |  2 +-
 commit.c                                   |  8 ++++----
 commit.h                                   |  3 ++-
 contrib/coccinelle/submodule_reading.cocci |  7 +++++++
 fsck.c                                     |  3 ++-
 merge-recursive.c                          |  3 ++-
 notes-merge.c                              |  3 ++-
 pretty.c                                   |  2 +-
 sequencer.c                                | 13 ++++++++-----
 sha1_name.c                                |  2 +-
 13 files changed, 34 insertions(+), 19 deletions(-)
 create mode 100644 contrib/coccinelle/submodule_reading.cocci

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 80853bb91a..bc04e3f0a7 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -561,7 +561,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	rev->diffopt.output_format = DIFF_FORMAT_CALLBACK;
 
 	parse_commit_or_die(commit);
-	commit_buffer = get_commit_buffer(commit, NULL);
+	commit_buffer = get_commit_buffer(the_repository, commit, NULL);
 	author = strstr(commit_buffer, "\nauthor ");
 	if (!author)
 		die ("Could not find author in commit %s",
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index c54f045ccd..6dedb92d61 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -261,7 +261,7 @@ static void record_person_from_buf(int which, struct string_list *people,
 static void record_person(int which, struct string_list *people,
 			  struct commit *commit)
 {
-	const char *buffer = get_commit_buffer(commit, NULL);
+	const char *buffer = get_commit_buffer(the_repository, commit, NULL);
 	record_person_from_buf(which, people, buffer);
 	unuse_commit_buffer(the_repository, commit, buffer);
 }
diff --git a/builtin/log.c b/builtin/log.c
index 3ccab366e7..bb9d909f59 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1022,7 +1022,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte);
 
 	for (i = 0; !need_8bit_cte && i < nr; i++) {
-		const char *buf = get_commit_buffer(list[i], NULL);
+		const char *buf = get_commit_buffer(the_repository, list[i],
+						    NULL);
 		if (has_non_ascii(buf))
 			need_8bit_cte = 1;
 		unuse_commit_buffer(the_repository, list[i], buf);
diff --git a/builtin/replace.c b/builtin/replace.c
index 1a92c0082a..46bb7cdfe8 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -401,7 +401,7 @@ static int create_graft(int argc, const char **argv, int force)
 		die(_("Not a valid object name: '%s'"), old_ref);
 	commit = lookup_commit_or_die(&old, old_ref);
 
-	buffer = get_commit_buffer(commit, &size);
+	buffer = get_commit_buffer(the_repository, commit, &size);
 	strbuf_add(&buf, buffer, size);
 	unuse_commit_buffer(the_repository, commit, buffer);
 
diff --git a/commit.c b/commit.c
index ac65c1dbd7..b241cc7979 100644
--- a/commit.c
+++ b/commit.c
@@ -277,7 +277,7 @@ const void *get_cached_commit_buffer(struct repository *r, const struct commit *
 	return v->buffer;
 }
 
-const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
+const void *get_commit_buffer_the_repository(const struct commit *commit, unsigned long *sizep)
 {
 	const void *ret = get_cached_commit_buffer(the_repository, commit, sizep);
 	if (!ret) {
@@ -617,7 +617,7 @@ define_commit_slab(author_date_slab, unsigned long);
 static void record_author_date(struct author_date_slab *author_date,
 			       struct commit *commit)
 {
-	const char *buffer = get_commit_buffer(commit, NULL);
+	const char *buffer = get_commit_buffer(the_repository, commit, NULL);
 	struct ident_split ident;
 	const char *ident_line;
 	size_t ident_len;
@@ -1163,7 +1163,7 @@ int parse_signed_commit(const struct commit *commit,
 {
 
 	unsigned long size;
-	const char *buffer = get_commit_buffer(commit, &size);
+	const char *buffer = get_commit_buffer(the_repository, commit, &size);
 	int in_signature, saw_signature = -1;
 	const char *line, *tail;
 
@@ -1320,7 +1320,7 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 {
 	struct commit_extra_header *extra = NULL;
 	unsigned long size;
-	const char *buffer = get_commit_buffer(commit, &size);
+	const char *buffer = get_commit_buffer(the_repository, commit, &size);
 	extra = read_commit_extra_header_lines(buffer, size, exclude);
 	unuse_commit_buffer(the_repository, commit, buffer);
 	return extra;
diff --git a/commit.h b/commit.h
index d2d5e66b53..b9eb079e21 100644
--- a/commit.h
+++ b/commit.h
@@ -88,7 +88,8 @@ const void *get_cached_commit_buffer(struct repository *r, const struct commit *
  * from disk. The resulting memory should not be modified, and must be given
  * to unuse_commit_buffer when the caller is done.
  */
-const void *get_commit_buffer(const struct commit *, unsigned long *size);
+#define get_commit_buffer(r, c, s) get_commit_buffer_##r(c, s)
+const void *get_commit_buffer_the_repository(const struct commit *, unsigned long *size);
 
 /*
  * Tell the commit subsytem that we are done with a particular commit buffer.
diff --git a/contrib/coccinelle/submodule_reading.cocci b/contrib/coccinelle/submodule_reading.cocci
new file mode 100644
index 0000000000..17c2e02512
--- /dev/null
+++ b/contrib/coccinelle/submodule_reading.cocci
@@ -0,0 +1,7 @@
+@@
+expression E;
+expression F;
+@@
+ get_commit_buffer(
++the_repository,
+ E, F)
diff --git a/fsck.c b/fsck.c
index 3155b77348..7788b60bf4 100644
--- a/fsck.c
+++ b/fsck.c
@@ -791,7 +791,8 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 static int fsck_commit(struct commit *commit, const char *data,
 	unsigned long size, struct fsck_options *options)
 {
-	const char *buffer = data ?  data : get_commit_buffer(commit, &size);
+	const char *buffer = data ?  data : get_commit_buffer(the_repository,
+							      commit, &size);
 	int ret = fsck_commit_buffer(commit, buffer, size, options);
 	if (!data)
 		unuse_commit_buffer(the_repository, commit, buffer);
diff --git a/merge-recursive.c b/merge-recursive.c
index 6e06634993..30ddfcb94e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -237,7 +237,8 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 			strbuf_addstr(&o->obuf, _("(bad commit)\n"));
 		else {
 			const char *title;
-			const char *msg = get_commit_buffer(commit, NULL);
+			const char *msg = get_commit_buffer(the_repository,
+							    commit, NULL);
 			int len = find_commit_subject(msg, &title);
 			if (len)
 				strbuf_addf(&o->obuf, "%.*s\n", len, title);
diff --git a/notes-merge.c b/notes-merge.c
index 58b518ae0a..1cb1c4f8f4 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -672,7 +672,8 @@ int notes_merge_commit(struct notes_merge_options *o,
 	DIR *dir;
 	struct dirent *e;
 	struct strbuf path = STRBUF_INIT;
-	const char *buffer = get_commit_buffer(partial_commit, NULL);
+	const char *buffer = get_commit_buffer(the_repository, partial_commit,
+					       NULL);
 	const char *msg = strstr(buffer, "\n\n");
 	int baselen;
 
diff --git a/pretty.c b/pretty.c
index 9a7f19f8c7..c5a2f0b018 100644
--- a/pretty.c
+++ b/pretty.c
@@ -602,7 +602,7 @@ const char *logmsg_reencode(const struct commit *commit,
 	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
 	char *encoding;
-	const char *msg = get_commit_buffer(commit, NULL);
+	const char *msg = get_commit_buffer(the_repository, commit, NULL);
 	char *out;
 
 	if (!output_encoding || !*output_encoding) {
diff --git a/sequencer.c b/sequencer.c
index 521da238b5..40ba4b6047 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -859,7 +859,7 @@ static int update_squash_messages(enum todo_command command,
 			return error(_("need a HEAD to fixup"));
 		if (!(head_commit = lookup_commit_reference(the_repository, &head)))
 			return error(_("could not read HEAD"));
-		if (!(head_message = get_commit_buffer(head_commit, NULL)))
+		if (!(head_message = get_commit_buffer(the_repository, head_commit, NULL)))
 			return error(_("could not read HEAD's commit message"));
 
 		find_commit_subject(head_message, &body);
@@ -883,7 +883,7 @@ static int update_squash_messages(enum todo_command command,
 		unuse_commit_buffer(the_repository, head_commit, head_message);
 	}
 
-	if (!(message = get_commit_buffer(commit, NULL)))
+	if (!(message = get_commit_buffer(the_repository, commit, NULL)))
 		return error(_("could not read commit message of %s"),
 			     oid_to_hex(&commit->object.oid));
 	find_commit_subject(message, &body);
@@ -1549,7 +1549,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 
 	while ((commit = get_revision(opts->revs))) {
 		struct todo_item *item = append_new_todo(todo_list);
-		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *commit_buffer = get_commit_buffer(the_repository,
+							      commit, NULL);
 		const char *subject;
 		int subject_len;
 
@@ -1816,7 +1817,8 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
 
 	strbuf_addf(&buf, "%s/message", get_dir(opts));
 	if (!file_exists(buf.buf)) {
-		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *commit_buffer = get_commit_buffer(the_repository,
+							      commit, NULL);
 		find_commit_subject(commit_buffer, &subject);
 		res |= write_message(subject, strlen(subject), buf.buf, 1);
 		unuse_commit_buffer(the_repository, commit, commit_buffer);
@@ -2906,7 +2908,8 @@ int rearrange_squash(void)
 		item->commit->util = item;
 
 		parse_commit(the_repository, item->commit);
-		commit_buffer = get_commit_buffer(item->commit, NULL);
+		commit_buffer = get_commit_buffer(the_repository,
+						  item->commit, NULL);
 		find_commit_subject(commit_buffer, &subject);
 		format_subject(&buf, subject, " ");
 		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
diff --git a/sha1_name.c b/sha1_name.c
index 7675ec634f..ee889daead 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1150,7 +1150,7 @@ static int get_oid_oneline(const char *prefix, struct object_id *oid,
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
 		if (!parse_object(the_repository, &commit->object.oid))
 			continue;
-		buf = get_commit_buffer(commit, NULL);
+		buf = get_commit_buffer(the_repository, commit, NULL);
 		p = strstr(buf, "\n\n");
 		matches = negative ^ (p && !regexec(&regex, p + 2, 0, NULL, 0));
 		unuse_commit_buffer(the_repository, commit, buf);
-- 
2.15.1.433.g936d1b9894.dirty

