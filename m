Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF08308F3E
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230054; cv=none; b=jWI9sIdbSO9NB1B/TDKdibbtj67fPUPyWpgi9HlgAjtbP8jVEeI7J0ZwsTTQTYuVKgeMN814vkdwimn9XEQv8S+8pAN03ICdoSBLJrnjDD/L3a9QwHsjdxsL8oBUemVd1bQxsH7HWnmRqHDxFmll/P9rMy0EsfF3R9dUSqPf+Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230054; c=relaxed/simple;
	bh=eqtDG39R55pshzbkrDKxMryl52PLgkg/xAU/3HunU0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxL6Uyw3txQdsx0jkK6Waisz/2ezcemHSe+hbN2RGZi5igHlhIb2IrfZcvkxESD/C0HyYnfNVQYRaJaYxHpJstvW+cCcYjbjZK9IggujjRkRExtwFGfaHfRbtDkCh2dU+6UdtXVlqf4ICVmsaawErs7lxcazG3DF/ni9KoUNZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9RcY49S; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9RcY49S"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so8849975e9.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782230051; x=1782834851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L/fAqpVeCkVcwOJkyBwqAXtmHMnVphmzbkitbJ7Ew0Q=;
        b=J9RcY49SCE2/RSZqc6BI6qBzTLw180QWyi+Wssnr9qyNz8o0h4UIEUxrb7UoQJ2XqZ
         UKvzBin0zQu1diVE/U3KAZu/HaTjIZVyH3sj6piqRVob5Q0k9Hc6prNBy3HJ308NX7tl
         N7pMBEGz7zVz6hfHk/oFV+gsy6QfHlMmHOFOpBlUB64KhZ3mzG9YVPFuh5nP/qLaYPsc
         t+9sKtAbZDJooRDvk0XXKkhK/2XqF7fsArbK9gSBv2e+mo1Ha/cS+nGMHxxe22x5WwY8
         SqWiaISyLlA47wPwBLAH4ozq6329wJgb5Z6kQtTHcEp1eT3rlL88KlJlkODC/3g08UE8
         mHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230051; x=1782834851;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/fAqpVeCkVcwOJkyBwqAXtmHMnVphmzbkitbJ7Ew0Q=;
        b=OZdThbu0kPnfYfcJ2T6PXmki4OzP+CWq18EdeiEt2QsPJvikLYYnskFaxdHRh3QEee
         lWs86VXLxhlPapIKzUZ+8NNX8bbwysaPzoOp04/KHyJJrDz4LM0OExa0CXLmgGPjasci
         qBdwihNAncLL0Rp56JL6/55WLK8XQpNRu0JIwGmU960lVaChUQMc+nnZoRu1DIJkodJe
         2UBIbkroZzfTd9PI/+VrCroBWlN10KCIRnBXvgvkPyjA0A3lb1sHiH+uOReEVj1fPMME
         o/L1n2hwuWtyvdauGnM7EPhahEhFjz0Z8/JHP6gRKsd7p7MPSHnipZbC0tBQzzaMfbi6
         5TWw==
X-Gm-Message-State: AOJu0Yz8jJAMBQlR8SLff4KyO3j+LpfWXhN31OLJgCv/ktcldFgAIi5q
	aXCMwbsKUwSAiAsZdvJDNy0zE56aUQQCOlmpYvGhnDf5H+of/Und8IiHiSMbeg==
X-Gm-Gg: AfdE7ck2AUwkVl2UZNs6WVtpB56RRJ9rvdyAMZHIobJr/flRFCkLXRm0acqy9dMSQux
	5T1QXswtsU8IllG+DFuoABzyR0swH51LW1Z0yxOtucWlM0p+Py9EYtUMRkDt0Y9a2xPWl91HDqr
	g58PpCIvxIsvjuhBQj8ia6i9gZ2FtU/CVlpJjlNl3EMDFldDxvUInDNTLde1rH72IWGOkzkJ3Cx
	UX9aHkQWxOpgY723IS+/RTHW8FI84n6dzahw35tf2SmCptbRLO+AfgoGKxh2VhzyAWM035BKjXQ
	qp2cl2wmvzYAixukkSpWIPT+icHEeMD3PBOea36i8x/qpskiKm5rjFBuw0C4IZr66tuNykhj8p9
	ZfRHXs1BfsqOmPaRjxZfK2EdQCjjiw25xjM0D6ojO2GHrfxePqzfCNtK5u9qf4QSqfPn6w8LLv9
	K/aUgTON82WMX6VWQw
X-Received: by 2002:a05:600c:3e0a:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-4925a0a9ad9mr55095425e9.6.1782230050351;
        Tue, 23 Jun 2026 08:54:10 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b9e5sm371729505e9.10.2026.06.23.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:54:10 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 2/2] status: improve rebase todo list parsing
Date: Tue, 23 Jun 2026 16:53:57 +0100
Message-ID: <90c4659b87e1948ffb6d3018160785a091081b16.1782230024.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782230024.git.phillip.wood@dunelm.org.uk>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk> <cover.1782230024.git.phillip.wood@dunelm.org.uk>
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
index 479ccc3304b..de36303c526 100644
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
+	if (!sequencer_parse_todo_command((const char **)&p, &cmd))
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

