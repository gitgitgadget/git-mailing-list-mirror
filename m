Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB821F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeBFAZo (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:25:44 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33930 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbeBFAZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:25:42 -0500
Received: by mail-pg0-f66.google.com with SMTP id s73so186571pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=69mHSNIRILYSanRW7N0YFfJGz9yL6aHYA9FN9cupeNk=;
        b=rQzZUjGj68OfPL+T1xSehc0J5ZXyAKRBEVvu/18YfMVf4IVtEvYJuC3O3k4V/vi4cA
         9XqA774Bz8SmEa81dwlBCRv39iECFeV9BaQiWHz2cAQaTtY5LdRBWkBCtsY/6aKghCWd
         rkP+Pj7+ZwCIXi8brmNU5e0Guf4hvRTgptagyChF8O4Xx5cwJCqQMvb5rNdFHLFvszL7
         4FF6Q+IPQ/OrnSu/CK5oSkJw90IKxgVRf/k7ERAZrquPq1KtumzhmiH4eFwZzA4XWB9s
         N3x9or64DX/Qmnf/1tiedMj7tqZbp7R/TV+d+EU7nkxfzmmpexZ5qECs4OSCZiYyHhNr
         mj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=69mHSNIRILYSanRW7N0YFfJGz9yL6aHYA9FN9cupeNk=;
        b=t6OXoN3cLNjzyNqAcD8Fursicwr6t5i2qpkEYHnk86yDbOPdeAQcbzMXSYNsGyE795
         Vn0Im9+q7mJhV9ZxYI49iacO9aUtn2lHFPv+viGISbIqomz9GkAvXqJ6qEPdS4LPPjZN
         65EnrJwkk1amaGByg2fQjRz60GfTh9yzS6jJKecb/SniaKYviO6FPpc9ppI+8/AQ5ved
         qchcIvi9szD9VxqXBSmTGuUDIz/x18ckvrjnEMlh82ZTyIAMgJFTzeaXs4nODEmqDGFd
         rHL5zgYvYYfzL/H2ahay3EyQuS6I9tfqugSYHHv/WzS9lml4OaFxTGfflZGS9FUCPXaN
         gypw==
X-Gm-Message-State: APf1xPCdlYMxy/+IJWh3N09mYCwvDT6IQnhgIf1L9/4iQkJIZqWCm1/N
        pZ2HJddt5tDct2LLLK0hUSQ910Ugwz4=
X-Google-Smtp-Source: AH8x227TOHoEm0lgGH903wJI3JYGlfNEef9oXrF/SQ7kRgC+iWmPagT28jZMWOfcUNy79jhHQff7dA==
X-Received: by 10.98.24.80 with SMTP id 77mr542776pfy.145.1517876740794;
        Mon, 05 Feb 2018 16:25:40 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e71sm10892156pgc.79.2018.02.05.16.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:25:40 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 147/194] commit: add repository argument to unuse_commit_buffer
Date:   Mon,  5 Feb 2018 16:17:02 -0800
Message-Id: <20180206001749.218943-49-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of unuse_commit_buffer to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/am.c                          |  2 +-
 builtin/blame.c                       |  4 ++--
 builtin/fast-export.c                 |  2 +-
 builtin/fmt-merge-msg.c               |  2 +-
 builtin/log.c                         |  2 +-
 builtin/replace.c                     |  2 +-
 builtin/reset.c                       |  2 +-
 commit.c                              |  8 ++++----
 commit.h                              |  3 ++-
 contrib/coccinelle/object_store.cocci |  7 +++++++
 fsck.c                                |  2 +-
 merge-recursive.c                     |  2 +-
 notes-merge.c                         |  2 +-
 pretty.c                              |  6 +++---
 revision.c                            |  2 +-
 sequencer.c                           | 16 +++++++++-------
 sha1_name.c                           |  2 +-
 17 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 83bc22649e..7072ec78cb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1358,7 +1358,7 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 		die(_("unable to parse commit %s"), oid_to_hex(&commit->object.oid));
 	state->msg = xstrdup(msg + 2);
 	state->msg_len = strlen(state->msg);
-	unuse_commit_buffer(commit, buffer);
+	unuse_commit_buffer(the_repository, commit, buffer);
 }
 
 /**
diff --git a/builtin/blame.c b/builtin/blame.c
index 815b0c75ed..956df42c67 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -192,7 +192,7 @@ static void get_commit_info(struct commit *commit,
 		    &ret->author_time, &ret->author_tz);
 
 	if (!detailed) {
-		unuse_commit_buffer(commit, message);
+		unuse_commit_buffer(the_repository, commit, message);
 		return;
 	}
 
@@ -206,7 +206,7 @@ static void get_commit_info(struct commit *commit,
 	else
 		strbuf_addf(&ret->summary, "(%s)", oid_to_hex(&commit->object.oid));
 
-	unuse_commit_buffer(commit, message);
+	unuse_commit_buffer(the_repository, commit, message);
 }
 
 /*
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1562ac4927..80853bb91a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -618,7 +618,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 			  ? strlen(message) : 0),
 	       reencoded ? reencoded : message ? message : "");
 	free(reencoded);
-	unuse_commit_buffer(commit, commit_buffer);
+	unuse_commit_buffer(the_repository, commit, commit_buffer);
 
 	for (i = 0, p = commit->parents; p; p = p->next) {
 		int mark = get_object_mark(&p->item->object);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index ac98556a1d..c54f045ccd 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -263,7 +263,7 @@ static void record_person(int which, struct string_list *people,
 {
 	const char *buffer = get_commit_buffer(commit, NULL);
 	record_person_from_buf(which, people, buffer);
-	unuse_commit_buffer(commit, buffer);
+	unuse_commit_buffer(the_repository, commit, buffer);
 }
 
 static int cmp_string_list_util_as_integral(const void *a_, const void *b_)
diff --git a/builtin/log.c b/builtin/log.c
index fce7b07df4..7080c5f776 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1025,7 +1025,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		const char *buf = get_commit_buffer(list[i], NULL);
 		if (has_non_ascii(buf))
 			need_8bit_cte = 1;
-		unuse_commit_buffer(list[i], buf);
+		unuse_commit_buffer(the_repository, list[i], buf);
 	}
 
 	if (!branch_name)
diff --git a/builtin/replace.c b/builtin/replace.c
index d1a939c17b..1a92c0082a 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -403,7 +403,7 @@ static int create_graft(int argc, const char **argv, int force)
 
 	buffer = get_commit_buffer(commit, &size);
 	strbuf_add(&buf, buffer, size);
-	unuse_commit_buffer(commit, buffer);
+	unuse_commit_buffer(the_repository, commit, buffer);
 
 	replace_parents(&buf, argc - 1, &argv[1]);
 
diff --git a/builtin/reset.c b/builtin/reset.c
index ea600bc62a..891dd77a5f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -123,7 +123,7 @@ static void print_new_head_line(struct commit *commit)
 	}
 	else
 		printf("\n");
-	unuse_commit_buffer(commit, msg);
+	unuse_commit_buffer(the_repository, commit, msg);
 }
 
 static void update_index_from_diff(struct diff_queue_struct *q,
diff --git a/commit.c b/commit.c
index 1863900824..fa578a2d22 100644
--- a/commit.c
+++ b/commit.c
@@ -290,7 +290,7 @@ const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-void unuse_commit_buffer(const struct commit *commit, const void *buffer)
+void unuse_commit_buffer_the_repository(const struct commit *commit, const void *buffer)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
 	if (!(v && v->buffer == buffer))
@@ -630,7 +630,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	*(author_date_slab_at(author_date, commit)) = date;
 
 fail_exit:
-	unuse_commit_buffer(commit, buffer);
+	unuse_commit_buffer(the_repository, commit, buffer);
 }
 
 static int compare_commits_by_author_date(const void *a_, const void *b_,
@@ -1186,7 +1186,7 @@ int parse_signed_commit(const struct commit *commit,
 		}
 		line = next;
 	}
-	unuse_commit_buffer(commit, buffer);
+	unuse_commit_buffer(the_repository, commit, buffer);
 	return saw_signature;
 }
 
@@ -1314,7 +1314,7 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 	unsigned long size;
 	const char *buffer = get_commit_buffer(commit, &size);
 	extra = read_commit_extra_header_lines(buffer, size, exclude);
-	unuse_commit_buffer(commit, buffer);
+	unuse_commit_buffer(the_repository, commit, buffer);
 	return extra;
 }
 
diff --git a/commit.h b/commit.h
index bcecb23722..85dd52d1bf 100644
--- a/commit.h
+++ b/commit.h
@@ -102,7 +102,8 @@ const void *get_commit_buffer(const struct commit *, unsigned long *size);
  * from an earlier call to get_commit_buffer.  The buffer may or may not be
  * freed by this call; callers should not access the memory afterwards.
  */
-void unuse_commit_buffer(const struct commit *, const void *buffer);
+#define unuse_commit_buffer(r, c, b) unuse_commit_buffer_##r(c, b)
+void unuse_commit_buffer_the_repository(const struct commit *, const void *buffer);
 
 /*
  * Free any cached object buffer associated with the commit.
diff --git a/contrib/coccinelle/object_store.cocci b/contrib/coccinelle/object_store.cocci
index 3ffb34d5b5..b56ebef884 100644
--- a/contrib/coccinelle/object_store.cocci
+++ b/contrib/coccinelle/object_store.cocci
@@ -60,3 +60,10 @@ expression E;
 + the_repository,
  E)
 
+@@
+expression E;
+expression F;
+@@
+ unuse_commit_buffer(
++the_repository,
+ E, F)
diff --git a/fsck.c b/fsck.c
index 494b4e3b30..3155b77348 100644
--- a/fsck.c
+++ b/fsck.c
@@ -794,7 +794,7 @@ static int fsck_commit(struct commit *commit, const char *data,
 	const char *buffer = data ?  data : get_commit_buffer(commit, &size);
 	int ret = fsck_commit_buffer(commit, buffer, size, options);
 	if (!data)
-		unuse_commit_buffer(commit, buffer);
+		unuse_commit_buffer(the_repository, commit, buffer);
 	return ret;
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 719fa58ab1..c749785b0b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -241,7 +241,7 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 			int len = find_commit_subject(msg, &title);
 			if (len)
 				strbuf_addf(&o->obuf, "%.*s\n", len, title);
-			unuse_commit_buffer(commit, msg);
+			unuse_commit_buffer(the_repository, commit, msg);
 		}
 	}
 	flush_output(o);
diff --git a/notes-merge.c b/notes-merge.c
index 02729fc474..df66d96811 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -722,7 +722,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 
 	create_notes_commit(partial_tree, partial_commit->parents,
 			    msg, strlen(msg), result_oid->hash);
-	unuse_commit_buffer(partial_commit, buffer);
+	unuse_commit_buffer(the_repository, partial_commit, buffer);
 	if (o->verbosity >= 4)
 		printf("Finalized notes merge commit: %s\n",
 			oid_to_hex(result_oid));
diff --git a/pretty.c b/pretty.c
index f82d30cd97..9a7f19f8c7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -644,7 +644,7 @@ const char *logmsg_reencode(const struct commit *commit,
 		 */
 		out = reencode_string(msg, output_encoding, use_encoding);
 		if (out)
-			unuse_commit_buffer(commit, msg);
+			unuse_commit_buffer(the_repository, commit, msg);
 	}
 
 	/*
@@ -1545,7 +1545,7 @@ void format_commit_message(const struct commit *commit,
 	}
 
 	free(context.commit_encoding);
-	unuse_commit_buffer(commit, context.message);
+	unuse_commit_buffer(the_repository, commit, context.message);
 }
 
 static void pp_header(struct pretty_print_context *pp,
@@ -1858,7 +1858,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	if (cmit_fmt_is_mail(pp->fmt) && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	unuse_commit_buffer(commit, reencoded);
+	unuse_commit_buffer(the_repository, commit, reencoded);
 }
 
 void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
diff --git a/revision.c b/revision.c
index 56c1a9a78f..754d7b438e 100644
--- a/revision.c
+++ b/revision.c
@@ -3037,7 +3037,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		retval = grep_buffer(&opt->grep_filter,
 				     (char *)message, strlen(message));
 	strbuf_release(&buf);
-	unuse_commit_buffer(commit, message);
+	unuse_commit_buffer(the_repository, commit, message);
 	return opt->invert_grep ? !retval : retval;
 }
 
diff --git a/sequencer.c b/sequencer.c
index e94ed30965..fbbe5267f7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -260,7 +260,7 @@ static void free_message(struct commit *commit, struct commit_message *msg)
 	free(msg->parent_label);
 	free(msg->label);
 	free(msg->subject);
-	unuse_commit_buffer(commit, msg->message);
+	unuse_commit_buffer(the_repository, commit, msg->message);
 }
 
 static void print_advice(int show_hint, struct replay_opts *opts)
@@ -865,7 +865,8 @@ static int update_squash_messages(enum todo_command command,
 		find_commit_subject(head_message, &body);
 		if (write_message(body, strlen(body),
 				  rebase_path_fixup_msg(), 0)) {
-			unuse_commit_buffer(head_commit, head_message);
+			unuse_commit_buffer(the_repository, head_commit,
+					    head_message);
 			return error(_("cannot write '%s'"),
 				     rebase_path_fixup_msg());
 		}
@@ -879,7 +880,7 @@ static int update_squash_messages(enum todo_command command,
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_addstr(&buf, body);
 
-		unuse_commit_buffer(head_commit, head_message);
+		unuse_commit_buffer(the_repository, head_commit, head_message);
 	}
 
 	if (!(message = get_commit_buffer(commit, NULL)))
@@ -901,7 +902,7 @@ static int update_squash_messages(enum todo_command command,
 		strbuf_add_commented_lines(&buf, body, strlen(body));
 	} else
 		return error(_("unknown command: %d"), command);
-	unuse_commit_buffer(commit, message);
+	unuse_commit_buffer(the_repository, commit, message);
 
 	res = write_message(buf.buf, buf.len, rebase_path_squash_msg(), 0);
 	strbuf_release(&buf);
@@ -1560,7 +1561,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
 			short_commit_name(commit), subject_len, subject);
-		unuse_commit_buffer(commit, commit_buffer);
+		unuse_commit_buffer(the_repository, commit, commit_buffer);
 	}
 	return 0;
 }
@@ -1818,7 +1819,7 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
 		const char *commit_buffer = get_commit_buffer(commit, NULL);
 		find_commit_subject(commit_buffer, &subject);
 		res |= write_message(subject, strlen(subject), buf.buf, 1);
-		unuse_commit_buffer(commit, commit_buffer);
+		unuse_commit_buffer(the_repository, commit, commit_buffer);
 	}
 	strbuf_release(&buf);
 
@@ -2908,7 +2909,8 @@ int rearrange_squash(void)
 		find_commit_subject(commit_buffer, &subject);
 		format_subject(&buf, subject, " ");
 		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
-		unuse_commit_buffer(item->commit, commit_buffer);
+		unuse_commit_buffer(the_repository, item->commit,
+				    commit_buffer);
 		if ((skip_prefix(subject, "fixup! ", &p) ||
 		     skip_prefix(subject, "squash! ", &p))) {
 			struct commit *commit2;
diff --git a/sha1_name.c b/sha1_name.c
index 43fe20b927..a60eaf14d2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1153,7 +1153,7 @@ static int get_oid_oneline(const char *prefix, struct object_id *oid,
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
 		matches = negative ^ (p && !regexec(&regex, p + 2, 0, NULL, 0));
-		unuse_commit_buffer(commit, buf);
+		unuse_commit_buffer(the_repository, commit, buf);
 
 		if (matches) {
 			oidcpy(oid, &commit->object.oid);
-- 
2.15.1.433.g936d1b9894.dirty

