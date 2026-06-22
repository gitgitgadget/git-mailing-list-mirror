Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9C390CB4
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117392; cv=none; b=m8R/mTiK8UuXqKU5Qo5lR5fCj8Zx5XDAFnCEZiTQ3iHECCKdF36CD7oIx9YvdQY8vntjIImJsCG8YqG0ci1vN5Xb9xT+TSQqM5f3QRC/Cpt6EiISvE+em2IBa6TGfHPCo8bBxW+N8qEqN05Ymv/oJlVZPFa6qGORWhTrHYQPAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117392; c=relaxed/simple;
	bh=uqsSjviFc0FLjv8WdZARSeIU94L6ShAS4fuKI7Pj8sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9QGssL5Gt1b5RONRF9/tAN54eRTsxcAYZvvLXgWHutokQWsj34H/de4O3NurtOOt2rHLgKkO2nVYrOnW7qo1QmmdsDOcU+IT/Vqplkdpfx1CaM3dkcLPmx/tGISHQmsYr/UIX+25ASae9vWWG4fS+HjdGyMckTQomO1bZsFF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXnXgPjU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXnXgPjU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4924593f45dso23631245e9.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782117388; x=1782722188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xTqOYwjR6jCoAREA/7FSWhUcomoyYHarQfL9UGN/iT4=;
        b=aXnXgPjUYYyvX7BbhUe+dXHzoseb1Wbs1bmpYzdLNKoEt9/poXuK2HJNlpuPJYp3gr
         n+6hlf5ipSKxyHDeo9I3t+/E0/rU+4WmV/5snRwNjztcfa/Ul+OJGQYzVanExLGMPI1s
         9FMfmOLgTVp59CAjBWQdqPBv7QKubDMpRbFexsAI1ECcxqKQrlphfbFqPqZqCBIXgUfd
         fZHVQJWpATOyKQ4QsMyzF5msmPrqELw8fD5AChLCTbi1RqSqIk4OoXOxbhSve0FlbFVe
         bFTeciikyl416KAE79LEO1XSRMHhtF7m5idfYMuwTfhII0p/6YnHoyQwSBXxovfJglXZ
         bjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117388; x=1782722188;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTqOYwjR6jCoAREA/7FSWhUcomoyYHarQfL9UGN/iT4=;
        b=DOEfJ7AN4Y4yMu6B+I6Q1yxQvmrtlCKLH8n3TIaD3eS4xmogbA75ZB5INb53yGkiym
         9z0rjmfCnY7KL6hTt3F+YqohvDMgMVHa1gud1M8X4SzTEf43gktiyF9jhFQcKWFV84go
         5mPlMrg/NJSJ1JBfpkKpU0tyAxFaaug1Ml4cXKcVl1YY8wo0QjfCBLzzCpxqC3pvbBXq
         gtsaaO2JihoFGEj8iM26x7hDRvJ+d9Wy+BrLGEr3KUTISLdz4wvxpDiC725z30DOyHHp
         M7YDYpebMjVH18M7buA350H2/5+pGDyOBWWTIPwbIEDwc6+WPbOqw6TTt6TxRO4UcUm2
         JSuQ==
X-Gm-Message-State: AOJu0YzMCYl5l1reYrIIhuhHIyWDwmeV49MnKk76uzZCcHVfv7i5HxMd
	zMk8QvAHaT9RYMIvkZnJq/jODdugk474++j4bHH8zk+VQSQmjgZa4WJG7miptg==
X-Gm-Gg: AfdE7cnyEXiZyt8ZU1WMT23/9B8V7muoW94Yrj7rgQ1tg2MgkDTtV8qYbWb0MYemq8H
	qulhGzHF9ZT1C5Ur79wrRvjj3L+zJtWyLZ8S9bm7aZlOHROLX78j5bM7eCwjdq3ImJjb6pq1lt9
	nJXSwLI32ZmWF17z+BErsPCc9/Y24Bp9G6vXKJ7UPUcbhndh/C9kZq6eu7uC0gTBXNR45womYS9
	OVHZ+SEFhU7Pz/AjDUCQJpK5Yxd60GoxYu4Jg19gFKnZ0V961mc9E05vV5qQexhtmTv8Ch+oCCQ
	KfNyfHNMNoSnD803fDohV7W2+u26UEwDV+nZkCuKXe9dEsZpOfCJzXJZ8k55eyAITgKvTIAenVC
	e1socYOAjxusR6fNwDylfrGZCSM3BAZCY7CsOZjmiSVralJNLPWCN+NO9xKfqbSn3sk/khIcO9f
	+ySJubsCXxDTmAD8Ne
X-Received: by 2002:a05:600c:6298:b0:48e:7854:1608 with SMTP id 5b1f17b1804b1-4923f5872d5mr237782105e9.25.1782117388322;
        Mon, 22 Jun 2026 01:36:28 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494497ffsm201186945e9.11.2026.06.22.01.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:36:27 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 2/2] status: improve rebase todo list parsing
Date: Mon, 22 Jun 2026 09:36:04 +0100
Message-ID: <b3514e9b1c9515bf1a7f7983b9f120d63edba97f.1782117361.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782117361.git.phillip.wood@dunelm.org.uk>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk> <cover.1782117361.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When there is rebase in progress "git status" displays the last couple
of completed and the next couple of pending commands from the todo
list. When it does this it tries to abbreviate the object ids of
the commits to be picked. Unfortunately it does not abbreviate the
object ids when the line starts with "fixup -C" or "merge -C". It
also mistakenly replaces the refname in "reset main" and "update-ref
refs/heads/main" with the object id that the ref points to.

Fix this by using the function added in the last commit to parse the
command name and only try to abbreviate the argument for commands that
take an object id. If a command accepts a label then try to resolve the
object name as a label first and only if that fails try to resolve it
as an object_id. When trying to abbreviate an object id, only replace
the object name if it starts with the abbreviated object id so that
tag or branch names that contain only hex digits are left unchanged.

Comments are now processed after stripping any leading
whitespace from the line. This matches what the sequencer does in
parse_insn_line(). The existing test cases are updated to test a
wider variety of commands. Only the pending commands in the tests
are changed to avoid removing existing coverage.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t7512-status-help.sh |  74 +++++++++++++-------
 wt-status.c            | 154 +++++++++++++++++++++++++++++++++--------
 2 files changed, 175 insertions(+), 53 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 08e82f79140..aca4b6d3326 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -224,7 +224,7 @@ test_expect_success 'status when splitting a commit' '
 	COMMIT3=$(git rev-parse --short split_commit) &&
 	test_commit four_split main.txt four &&
 	COMMIT4=$(git rev-parse --short split_commit) &&
-	FAKE_LINES="1 edit 2 3" &&
+	FAKE_LINES="reword 1 edit 2 fixup_-C 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
@@ -233,10 +233,10 @@ test_expect_success 'status when splitting a commit' '
 	cat >expected <<EOF &&
 interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
-   pick $COMMIT2 # two_split
+   reword $COMMIT2 # two_split
    edit $COMMIT3 # three_split
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_split
+   fixup -C $COMMIT4 # four_split
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
@@ -297,7 +297,7 @@ test_expect_success 'prepare for several edits' '
 
 
 test_expect_success 'status: (continue first edit) second edit' '
-	FAKE_LINES="edit 1 edit 2 3" &&
+	FAKE_LINES="edit 1 edit 2 drop 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
@@ -312,7 +312,7 @@ Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+   drop $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -327,7 +327,7 @@ EOF
 
 test_expect_success 'status: (continue first edit) second edit and split' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
+	FAKE_LINES="edit 1 edit 2 squash 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
@@ -343,7 +343,7 @@ Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+   squash $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
@@ -362,7 +362,7 @@ EOF
 
 test_expect_success 'status: (continue first edit) second edit and amend' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
+	FAKE_LINES="edit 1 edit 2 fixup 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
@@ -378,7 +378,7 @@ Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+   fixup $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -393,7 +393,7 @@ EOF
 
 test_expect_success 'status: (amend first edit) second edit' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
+	FAKE_LINES="edit 1 edit 2 fixup_-c 3" &&
 	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
@@ -409,7 +409,7 @@ Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+   fixup -c $COMMIT4 # four_edits
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -460,14 +460,20 @@ EOF
 
 test_expect_success 'status: (amend first edit) second edit and amend' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
-	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
 	COMMIT3=$(git rev-parse --short several_edits^) &&
 	COMMIT4=$(git rev-parse --short several_edits) &&
 	ONTO=$(git rev-parse --short HEAD~3) &&
-	git rebase -i HEAD~3 &&
+	cat >todo <<-EOF &&
+	edit several_edits^^ # two_edits
+	edit several_edits^ # three_edits
+	merge $(git rev-parse main) $(git rev-parse several_edits)
+	EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i HEAD~3
+	) &&
 	git commit --amend -m "c" &&
 	git rebase --continue &&
 	git commit --amend -m "d" &&
@@ -477,7 +483,7 @@ Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
 Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+   merge $(git rev-parse --short main) $COMMIT4
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
@@ -525,14 +531,21 @@ EOF
 
 test_expect_success 'status: (split first edit) second edit and split' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
-	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
 	COMMIT3=$(git rev-parse --short several_edits^) &&
 	COMMIT4=$(git rev-parse --short several_edits) &&
+	cat >todo <<-EOF &&
+	edit several_edits^^ # two_edits
+	edit several_edits^ # three_edits
+	reset $(git rev-parse main)
+	merge -C several_edits topic # title
+	EOF
 	ONTO=$(git rev-parse --short HEAD~3) &&
-	git rebase -i HEAD~3 &&
+	(
+		set_replace_editor todo &&
+		git rebase -i HEAD~3
+	) &&
 	git reset HEAD^ &&
 	git add main.txt &&
 	git commit --amend -m "f" &&
@@ -543,8 +556,9 @@ interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
-Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+Next commands to do (2 remaining commands):
+   reset $(git rev-parse --short main)
+   merge -C $COMMIT4 topic # title
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
@@ -563,14 +577,21 @@ EOF
 
 test_expect_success 'status: (split first edit) second edit and amend' '
 	git reset --hard several_edits &&
-	FAKE_LINES="edit 1 edit 2 3" &&
-	export FAKE_LINES &&
 	test_when_finished "git rebase --abort" &&
+	git branch cafe main &&
 	COMMIT2=$(git rev-parse --short several_edits^^) &&
 	COMMIT3=$(git rev-parse --short several_edits^) &&
-	COMMIT4=$(git rev-parse --short several_edits) &&
+	cat >todo <<-EOF &&
+	edit several_edits^^ # two_edits
+	edit several_edits^ # three_edits
+	update-ref refs/heads/main
+	reset cafe
+	EOF
 	ONTO=$(git rev-parse --short HEAD~3) &&
-	git rebase -i HEAD~3 &&
+	(
+		set_replace_editor todo &&
+		git rebase -i HEAD~3
+	) &&
 	git reset HEAD^ &&
 	git add main.txt &&
 	git commit --amend -m "g" &&
@@ -581,8 +602,9 @@ interactive rebase in progress; onto $ONTO
 Last commands done (2 commands done):
    edit $COMMIT2 # two_edits
    edit $COMMIT3 # three_edits
-Next command to do (1 remaining command):
-   pick $COMMIT4 # four_edits
+Next commands to do (2 remaining commands):
+   update-ref refs/heads/main
+   reset cafe
   (use "git rebase --edit-todo" to view and edit)
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
diff --git a/wt-status.c b/wt-status.c
index 479ccc3304b..4b15bda76f4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1363,6 +1363,71 @@ static int split_commit_in_progress(struct wt_status *s)
 	free(rebase_orig_head);
 
 	return split_in_progress;
+}
+
+/*
+ * If the whitespace-delimited token starting at or just after *pp
+ * is a hex object id that is longer than its default abbreviation,
+ * abbreviate it in-place, shrinking `line` accordingly. On return
+ * *pp points one past the (possibly abbreviated) token. Leaves both
+ * `line` and *pp-advanced-past-the-token unchanged in all other cases
+ * (non-hex token, label name, unresolvable, or a refname that happens
+ * to consist only of hex digits).
+ */
+static void abbrev_oid_in_line(struct repository *r, struct strbuf *scratch,
+			       struct strbuf *line, bool maybe_label, char **pp)
+{
+	char *p = *pp;
+	char *end_of_object_name, saved;
+	const char *abbrev;
+	struct object_id oid;
+	bool have_oid;
+
+	p += strspn(p, " \t");
+	end_of_object_name = p + strcspn(p, " \t");
+	/*
+	 * For "merge" and "reset" the object name may be a label or
+	 * ref rather than a hex object id. Only abbreviate the object
+	 * name if it is a hex object id.
+	 */
+	for (const char *q = p; q < end_of_object_name; q++) {
+		if (!isxdigit(*q))
+			goto out;
+	}
+	if (maybe_label) {
+		strbuf_reset(scratch);
+		strbuf_addf(scratch, "refs/rewritten/%.*s",
+			    (int)(end_of_object_name - p), p);
+		if (refs_ref_exists(get_main_ref_store(r), scratch->buf))
+			goto out; /* object name was a label */
+	}
+	saved = *end_of_object_name;
+	*end_of_object_name = '\0';
+	have_oid = !repo_get_oid(r, p, &oid);
+	*end_of_object_name = saved;
+	if (!have_oid)
+		goto out; /* invalid object name */
+	abbrev = repo_find_unique_abbrev(r, &oid, DEFAULT_ABBREV);
+	if (!starts_with(p, abbrev))
+		goto out; /* object name was a refname containing only xdigits */
+	p += strlen(abbrev);
+	strbuf_remove(line, p - line->buf, end_of_object_name - p);
+	end_of_object_name = p;
+out:
+	*pp = end_of_object_name;
+}
+
+/* Skip "[ \t]*(-[cC])?", returns true if "-c/-C" was skipped. */
+static bool skip_dash_c(char **pp)
+{
+	bool ret;
+	char *p = *pp;
+
+	p += strspn(p, " \t");
+	ret = skip_prefix(p, "-C", &p) || skip_prefix(p, "-c", &p);
+	*pp = p;
+
+	return ret;
 }
 
 /*
@@ -1371,29 +1436,68 @@ static int split_commit_in_progress(struct wt_status *s)
  * into
  * "pick d6a2f03 some message"
  *
- * The function assumes that the line does not contain useless spaces
- * before or after the command.
+ * Returns false on comment lines, true otherwise
  */
-static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
+static bool format_todo_line(struct repository *r, struct strbuf *line)
 {
-	struct string_list split = STRING_LIST_INIT_DUP;
-	struct object_id oid;
-
-	if (starts_with(line->buf, "exec ") ||
-	    starts_with(line->buf, "x ") ||
-	    starts_with(line->buf, "label ") ||
-	    starts_with(line->buf, "l "))
-		return;
-
-	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
-	    !repo_get_oid(r, split.items[1].string, &oid)) {
-		strbuf_reset(line);
-		strbuf_addf(line, "%s ", split.items[0].string);
-		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
-		for (size_t i = 2; i < split.nr; i++)
-			strbuf_addf(line, " %s", split.items[i].string);
-	}
-	string_list_clear(&split, 0);
+	enum todo_command cmd;
+	struct strbuf scratch = STRBUF_INIT;
+	char *p = line->buf;
+
+	if (!sequencer_parse_todo_command((const char**)&p, &cmd))
+		return true; /* keep invalid lines */
+
+	switch (cmd) {
+	case TODO_COMMENT:
+		return false;
+
+	case TODO_MERGE: {
+		/*
+		 * The argument to -C cannot be a label, but the parents
+		 * can be labels.
+		 */
+		bool maybe_label = !skip_dash_c(&p);
+
+		while (true) {
+			p += strspn(p, " \t");
+			if (!p[0] || (p[0] == '#' && (!p[1] || isspace(p[1]))))
+				break;
+			abbrev_oid_in_line(r, &scratch, line, maybe_label, &p);
+			maybe_label = true;
+		}
+		break;
+	}
+
+	case TODO_FIXUP:
+		skip_dash_c(&p);
+		/* fallthrough */
+	case TODO_DROP:
+	case TODO_EDIT:
+	case TODO_PICK:
+	case TODO_REVERT:
+	case TODO_REWORD:
+	case TODO_SQUASH:
+		abbrev_oid_in_line(r, &scratch, line, false, &p);
+		break;
+
+	case TODO_RESET:
+		abbrev_oid_in_line(r, &scratch, line, true, &p);
+		break;
+	/*
+	 * Avoid "default" and instead list all the other commands so
+	 * that -Wswitch (which is included in -Wall) warns if a new
+	 * command is added without handling it in this function.
+	 */
+	case TODO_BREAK:
+	case TODO_EXEC:
+	case TODO_LABEL:
+	case TODO_NOOP:
+	case TODO_UPDATE_REF:
+		break;
+	}
+
+	strbuf_release(&scratch);
+	return true;
 }
 
 static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
@@ -1411,13 +1515,9 @@ static int read_rebase_todolist(struct repository *r, const char *fname, struct
 			  repo_git_path_replace(r, &buf, "%s", fname));
 	}
 	while (!strbuf_getline_lf(&buf, f)) {
-		if (starts_with(buf.buf, comment_line_str))
-			continue;
 		strbuf_trim(&buf);
-		if (!buf.len)
-			continue;
-		abbrev_oid_in_line(r, &buf);
-		string_list_append(lines, buf.buf);
+		if (format_todo_line(r, &buf))
+			string_list_append(lines, buf.buf);
 	}
 	fclose(f);
 
-- 
2.54.0.200.gfd8d68259e3

