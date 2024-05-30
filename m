Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62D17C7CE
	for <git@vger.kernel.org>; Thu, 30 May 2024 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076637; cv=none; b=OdIljfWyvmrXxo71alRe7pblz1umILVmWz2FaC6HjF+wPldssMc9UaLjnqxglgpkE2Lakt2JrJsfDpGEeFeknKJEdChnT4edeS7XiBItnnNE2GdOhfTlqUcbuzFp3TVpeu0T7eP0NIeVGDWWQa2Wkla/HOjLVUbhUw64QhNI10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076637; c=relaxed/simple;
	bh=KCjic7s/AG/mE9szmLmxEu3WvZgn3u332WudbOZy7Gc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R+FeDDLr0+XvwMwn5YFQ4BiUejC0M9JRkHGT1Exzhg3pZbcLkBwSlf3asTyiIRsWQvCiUDhNP3vr/34538aZQ9F4fBX3XugNGLQBLbNiHl52gtyigbmk4/qizGNIGB+QTpxvY2q4vDOf3rHgHBVawhAwX05OxWrCmo+KTc/wEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8DZKCK6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8DZKCK6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421124a0b37so5679155e9.1
        for <git@vger.kernel.org>; Thu, 30 May 2024 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717076633; x=1717681433; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4GKCP92169KMUszhC1hGw6XJz77a76xJIAVsemElz0=;
        b=O8DZKCK6BeoDDmeDx26YBBPOC06eywzAUc5qKIXj6i0jXN/Xlxq/QvmvuuCJV3271T
         bDUTegZGp2uhy4247I3v4EWkyEqDFXWisGMJRLfv4p1nT2+kv/mC+3xotIHOfMGp2Ank
         bM/+O6fI7TrjNhz/0rpRaxx3PK3RK7p5fZ9rY6KAKcY76SWl8bRG8hNMQ1eSgLfPTrTg
         +llcJJTIqoO2HvUNCNTc/gZAk1ajuJ/dD7bS6CK0Ls0tI0NudF1Dc5SQVHsKbAaBuhEW
         OKIS9o/G3xqtrZVfgL4n+RwpdjQuiLlN+pGnB7nJ2ddJryEY6Sm2cJymrSbx81ZIwdzi
         QssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717076633; x=1717681433;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4GKCP92169KMUszhC1hGw6XJz77a76xJIAVsemElz0=;
        b=t6pa2eXwywwK1eJIQkjY9dLGjk6/ODZzFwWhFn03nBhRUBfrazi2jQi0x973tN0g52
         PI12oavKVVgGOHk+xQ8CfPeW1tZpDINP8Sq96F/uK1psKIq/Dwy7g6CiU0Ufq2PbeNOb
         I6fldxIW4+VCku5qNIf6M3VtKLK2wGXJ+STMC+vCZlnKKexD4W3+YUpiU/0ot9njaYXt
         ekR0Ec2qCLoKs+YGwOF5Q/kfHknuSnN3NLH+CpJHUnuCXZlQPpw17IzDqXw/8PhX8WjY
         6E0J4p1d4sVHge3KtKj92HM6Pl6RMZCvm2DqZcfWv4Jc1TOFZIIBj7Zk7UToMtFbSKNy
         LQ4Q==
X-Gm-Message-State: AOJu0YwcZlveYwV26oAhuCvjXqlZaZMYAnJ8uMn1uHbHtIzSRWpFkJU0
	91CkrrGavGxkZbInmmQGqwsfOmAnomx/Eh/2NL67I0zJ0wWYdsqt+1/afQ==
X-Google-Smtp-Source: AGHT+IEWmrqNwOXHG36jvFjubxUHRegZAV3AMZsMMIimH8I94sbeGdyELwXsS3Tet7BP3FVVryrweg==
X-Received: by 2002:a05:600c:5487:b0:421:20d:e3a4 with SMTP id 5b1f17b1804b1-4212781a881mr28668565e9.17.1717076633489;
        Thu, 30 May 2024 06:43:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127061df9sm25631365e9.18.2024.05.30.06.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:43:53 -0700 (PDT)
Message-Id: <91c6f2f1b458fca8db19483cd43229b737214d3d.1717076630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1672.v3.git.1717076630.gitgitgadget@gmail.com>
References: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
	<pull.1672.v3.git.1717076630.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 May 2024 13:43:49 +0000
Subject: [PATCH v3 1/2] rebase -i: pass struct replay_opts to
 parse_insn_line()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This new parameter will be used in the next commit. As adding the
parameter requires quite a few changes to plumb it through the call
chain these are separated into their own commit to avoid cluttering up
the next commit with incidental changes.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c     | 17 +++++++++++------
 rebase-interactive.c | 21 +++++++++++++--------
 rebase-interactive.h |  9 ++++++---
 sequencer.c          | 22 ++++++++++++----------
 sequencer.h          |  4 ++--
 5 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0466d9414af..9fb0a6888d6 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -193,7 +193,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	return replay;
 }
 
-static int edit_todo_file(unsigned flags)
+static int edit_todo_file(unsigned flags, struct replay_opts *opts)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT,
@@ -204,7 +204,8 @@ static int edit_todo_file(unsigned flags)
 		return error_errno(_("could not read '%s'."), todo_file);
 
 	strbuf_stripspace(&todo_list.buf, comment_line_str);
-	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
+	res = edit_todo_list(the_repository, opts, &todo_list, &new_todo,
+			     NULL, NULL, flags);
 	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
 					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
 		res = error_errno(_("could not write '%s'"), todo_file);
@@ -295,8 +296,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 		error(_("could not generate todo list"));
 	else {
 		discard_index(the_repository->index);
-		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
-						&todo_list))
+		if (todo_list_parse_insn_buffer(the_repository, &replay,
+						todo_list.buf.buf, &todo_list))
 			BUG("unusable todo list");
 
 		ret = complete_action(the_repository, &replay, flags,
@@ -351,9 +352,13 @@ static int run_sequencer_rebase(struct rebase_options *opts)
 		replay_opts_release(&replay_opts);
 		break;
 	}
-	case ACTION_EDIT_TODO:
-		ret = edit_todo_file(flags);
+	case ACTION_EDIT_TODO: {
+		struct replay_opts replay_opts = get_replay_opts(opts);
+
+		ret = edit_todo_file(flags, &replay_opts);
+		replay_opts_release(&replay_opts);
 		break;
+	}
 	case ACTION_SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
diff --git a/rebase-interactive.c b/rebase-interactive.c
index c343e16fcdd..56fd7206a95 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -101,9 +101,10 @@ void append_todo_help(int command_count,
 	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_str);
 }
 
-int edit_todo_list(struct repository *r, struct todo_list *todo_list,
-		   struct todo_list *new_todo, const char *shortrevisions,
-		   const char *shortonto, unsigned flags)
+int edit_todo_list(struct repository *r, struct replay_opts *opts,
+		   struct todo_list *todo_list, struct todo_list *new_todo,
+		   const char *shortrevisions, const char *shortonto,
+		   unsigned flags)
 {
 	const char *todo_file = rebase_path_todo(),
 		*todo_backup = rebase_path_todo_backup();
@@ -114,7 +115,9 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 	 * it.  If there is an error, we do not return, because the user
 	 * might want to fix it in the first place. */
 	if (!initial)
-		incorrect = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list) |
+		incorrect = todo_list_parse_insn_buffer(r, opts,
+							todo_list->buf.buf,
+							todo_list) |
 			file_exists(rebase_path_dropped());
 
 	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
@@ -134,13 +137,13 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 	if (initial && new_todo->buf.len == 0)
 		return -3;
 
-	if (todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo)) {
+	if (todo_list_parse_insn_buffer(r, opts, new_todo->buf.buf, new_todo)) {
 		fprintf(stderr, _(edit_todo_list_advice));
 		return -4;
 	}
 
 	if (incorrect) {
-		if (todo_list_check_against_backup(r, new_todo)) {
+		if (todo_list_check_against_backup(r, opts, new_todo)) {
 			write_file(rebase_path_dropped(), "%s", "");
 			return -4;
 		}
@@ -228,13 +231,15 @@ int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
 	return res;
 }
 
-int todo_list_check_against_backup(struct repository *r, struct todo_list *todo_list)
+int todo_list_check_against_backup(struct repository *r,
+				   struct replay_opts *opts,
+				   struct todo_list *todo_list)
 {
 	struct todo_list backup = TODO_LIST_INIT;
 	int res = 0;
 
 	if (strbuf_read_file(&backup.buf, rebase_path_todo_backup(), 0) > 0) {
-		todo_list_parse_insn_buffer(r, backup.buf.buf, &backup);
+		todo_list_parse_insn_buffer(r, opts, backup.buf.buf, &backup);
 		res = todo_list_check(&backup, todo_list);
 	}
 
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 7239c60f791..8e5b181b334 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -3,17 +3,20 @@
 
 struct strbuf;
 struct repository;
+struct replay_opts;
 struct todo_list;
 
 void append_todo_help(int command_count,
 		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
-int edit_todo_list(struct repository *r, struct todo_list *todo_list,
-		   struct todo_list *new_todo, const char *shortrevisions,
-		   const char *shortonto, unsigned flags);
+int edit_todo_list(struct repository *r, struct replay_opts *opts,
+		   struct todo_list *todo_list, struct todo_list *new_todo,
+		   const char *shortrevisions, const char *shortonto,
+		   unsigned flags);
 
 int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
 int todo_list_check_against_backup(struct repository *r,
+				   struct replay_opts *opts,
 				   struct todo_list *todo_list);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index aa2a2398357..7ab465da14a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2626,8 +2626,9 @@ static int check_label_or_ref_arg(enum todo_command command, const char *arg)
 	return 0;
 }
 
-static int parse_insn_line(struct repository *r, struct todo_item *item,
-			   const char *buf, const char *bol, char *eol)
+static int parse_insn_line(struct repository *r, struct replay_opts *opts UNUSED,
+			   struct todo_item *item, const char *buf,
+			   const char *bol, char *eol)
 {
 	struct object_id commit_oid;
 	char *end_of_object_name;
@@ -2761,8 +2762,8 @@ int sequencer_get_last_command(struct repository *r UNUSED, enum replay_action *
 	return ret;
 }
 
-int todo_list_parse_insn_buffer(struct repository *r, char *buf,
-				struct todo_list *todo_list)
+int todo_list_parse_insn_buffer(struct repository *r, struct replay_opts *opts,
+				char *buf, struct todo_list *todo_list)
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
@@ -2780,7 +2781,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 
 		item = append_new_todo(todo_list);
 		item->offset_in_buf = p - todo_list->buf.buf;
-		if (parse_insn_line(r, item, buf, p, eol)) {
+		if (parse_insn_line(r, opts, item, buf, p, eol)) {
 			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
 			item->command = TODO_COMMENT + 1;
@@ -2930,7 +2931,7 @@ static int read_populate_todo(struct repository *r,
 	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
 		return -1;
 
-	res = todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
+	res = todo_list_parse_insn_buffer(r, opts, todo_list->buf.buf, todo_list);
 	if (res) {
 		if (is_rebase_i(opts))
 			return error(_("please fix this using "
@@ -2960,7 +2961,7 @@ static int read_populate_todo(struct repository *r,
 		struct todo_list done = TODO_LIST_INIT;
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
-		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
+		    !todo_list_parse_insn_buffer(r, opts, done.buf.buf, &done))
 			todo_list->done_nr = count_commands(&done);
 		else
 			todo_list->done_nr = 0;
@@ -5319,7 +5320,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			goto release_todo_list;
 
 		if (file_exists(rebase_path_dropped())) {
-			if ((res = todo_list_check_against_backup(r, &todo_list)))
+			if ((res = todo_list_check_against_backup(r, opts,
+								  &todo_list)))
 				goto release_todo_list;
 
 			unlink(rebase_path_dropped());
@@ -6363,7 +6365,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error(_("nothing to do"));
 	}
 
-	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
+	res = edit_todo_list(r, opts, todo_list, &new_todo, shortrevisions,
 			     shortonto, flags);
 	if (res == -1)
 		return -1;
@@ -6391,7 +6393,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	strbuf_release(&buf2);
 	/* Nothing is done yet, and we're reparsing, so let's reset the count */
 	new_todo.total_nr = 0;
-	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
+	if (todo_list_parse_insn_buffer(r, opts, new_todo.buf.buf, &new_todo) < 0)
 		BUG("invalid todo list after expanding IDs:\n%s",
 		    new_todo.buf.buf);
 
diff --git a/sequencer.h b/sequencer.h
index a309ddd712b..304ba4b4d35 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -136,8 +136,8 @@ struct todo_list {
 	.buf = STRBUF_INIT, \
 }
 
-int todo_list_parse_insn_buffer(struct repository *r, char *buf,
-				struct todo_list *todo_list);
+int todo_list_parse_insn_buffer(struct repository *r, struct replay_opts *opts,
+				char *buf, struct todo_list *todo_list);
 int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 			    const char *file, const char *shortrevisions,
 			    const char *shortonto, int num, unsigned flags);
-- 
gitgitgadget

