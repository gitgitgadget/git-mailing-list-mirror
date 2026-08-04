Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530243CE46
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832260; cv=none; b=bj77R2ZxxO92/z8B6CwCkSLNhu1GI2HKtws0O2glRshCF0/sU0i8RJdxTVMjRyVEeS9ioMf1EkFP9lCZI7hbJ5eY1N8hVnO5mE8cjJm/P+KAiAmJY3+trdmSq/vdZ2UwkgS1gFvqGWG0DTc/2i4V4b5eIYkZ6WffrTcZDNomqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832260; c=relaxed/simple;
	bh=ERd+Ftbus6mhypzOuVLzkYW8tiAHCCRV58cYSQhQWDE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aYSwGJ1nEHr/7wXu2J3NecKAw5M6e9RnstR/JBXAF6c1oOKSyj8fszO6nZXl5lC6LyivSHmSRNARf6ISnizSdhH9pEtzU2rCpulhDiRhXx2z1puTVUs3LWqwRGNr+LEVAcMU23NGFOe8nrXnhSm0yDFHXUjoHF09dgpZLVa8kSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JR5Aqgsb; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR5Aqgsb"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8111c0c7561so50739587b3.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 01:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832258; x=1786437058; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yN+N/We4+Oe5nxZucSLFJd1zci+8k+2yOId6cwigGWA=;
        b=JR5Aqgsbd4w4/dRWWwgOvUYsy5Y39M3Yy8ugdWMJOykT8XDTQVrYu/pRj3jO9IH/Sg
         lSPeBj1YjkBWqbtfOvzBLLN7Vsn8HG0O8oC1LRWOR4pXBJ0QBG9suVHCrmmoHo0qU7yE
         5BqJpSY37XM33DI4JPrSlRweyJWHmFUkDm53tsLAR12kskKbaz23vDcm+qNUu/GfDVqI
         VWfQ91sGEbN1Kk4ZNpTzTajqyLmKt2NOWykhNW3MYnrLyHSXsPnph8ACuHd4XUhDYe7n
         KoxS7AMZhdgSyGEyNxHz/YuEUaKGe3WjWN972E+3vYQe+y7Xfy6aIJLXlHgwv2QvwVZC
         wlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832258; x=1786437058;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yN+N/We4+Oe5nxZucSLFJd1zci+8k+2yOId6cwigGWA=;
        b=W+v/pnYEue3Ka8GaNnU/zVfqnt4/vaFR7pAnzMQLUjOBf5NwkJTZaLonF9E23J6XUV
         x9xZfL3PufodbpHWC7CrgSkw7hvd1neLKoxFoxs0YERE9hCXeO5bv+kmTfxHTL7QzlAl
         mF8XZb7UpvKTdSaY8uUEVa5PuWpSe+LdQRtzWRsx5o78cgX+7n78a6lYS+D3Nnq8UfM2
         efpVxyubY+JfmM2olmjzXDV936vnlHrspBv/7p18J7cbzOO0/kGlTie4FvHC4I3d4QAW
         SgceCIA0X86ogEkYwHmh7MjDMdWJRLhSTAGHD7X/d5Z6YPGoeUQYXRnFThPLNznavyXM
         OeVQ==
X-Gm-Message-State: AOJu0Yy/HMMQ2wL+Z5e+Ia+fvSWwd8nvZaO/vMANCiMFaK2FUQ3cgj5T
	ZvvUfz4Qogdyw7Kv0A/WZo23Rq1/aNmmpNPC6bjStyFa/sUW0P6LkJLUBDT6Hg==
X-Gm-Gg: AR+sD12Z/dlCRC8wwIaEEWerw48J0zkPtuHYW8g8v0oYh54EOfX5qMTF7TRhZybPrq/
	sEBziVqHVjfmj7LfH/envbED2eH8zRUNiFrZvRtnAwsa+Ga2wYyP5WX4D2O0Fo/+6fdB4UYN0WV
	DHO3ZwYeexNUIK2Svcvlk4FFDdOOI46TD0wWVfXGbM8WkuO1sAeqS1OVYLNVOLHldVH2LdJV2Wx
	R1VV7ApNoy2AFqpe5je2DR/CnHjvjtYoxfo9fd3CMywwyxXse8x5vye/VnUsgd9DxuGk+LuZGNj
	AVjnMOnAJPNktIvUA6jO9HmXtIow150jTP6lhQzdLyVxBlrpFjpx3791VMmUKki3loVCaFjtAxu
	/4Qqymv86eGYc3HYH2YAlsfifacv3HBVGwJhbCcTC1Xr24c3BTvSjd0KEC0/TcvE3RZqg0PebWy
	IxEEwzJAKixmZoplABGlpmhGKyneTYzkGPSRLJ+eEcoYT5gJxgtDscIFw8sU/ZDVU=
X-Received: by 2002:a05:690c:9981:b0:81e:a471:e8b0 with SMTP id 00721157ae682-81fd4b3e2d0mr160689607b3.21.1785832258169;
        Tue, 04 Aug 2026 01:30:58 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.40])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820132307d1sm1602187b3.13.2026.08.04.01.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:30:57 -0700 (PDT)
Message-Id: <352db997e9da56b2d94eb98d8a90b9f90c0577e8.1785832251.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v12.git.git.1785832251.gitgitgadget@gmail.com>
References: <pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
	<pull.2337.v12.git.git.1785832251.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 04 Aug 2026 08:30:50 +0000
Subject: [PATCH v12 3/4] sequencer: share the squash message marker helpers
 and flags
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When "git rebase -i" squashes commits it builds an editor template with a
"This is a combination of N commits." banner, a "This is the 1st/Nth
commit message:" header above each kept message (or a "will be skipped"
header for a dropped one), and a commented-out subject for any fixup!,
squash! or amend! commit. The banner, the headers and the
subject-commenting all live in static helpers in sequencer.c wired to the
rebase state, so no other command can present a squash the same way.

Pull the three pieces out into add_squash_combination_header(),
add_squash_message_header() (which takes a flag for the "will be skipped"
variant) and squash_subject_comment_len(), and use them from
update_squash_messages() and append_squash_message(). Also move the
todo_item_flags enum to the header, so a caller reading the output of
todo_list_rearrange_squash() can tell an amend! (TODO_REPLACE_FIXUP_MSG)
from a plain fixup!. A later change reuses all of this to give "git
history squash" the same template.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 70 +++++++++++++++++++++++++++++------------------------
 sequencer.h | 30 +++++++++++++++++++++++
 2 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 82ab3c536f..642dfa9d91 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1880,18 +1880,38 @@ static int is_pick_or_similar(enum todo_command command)
 	}
 }
 
-enum todo_item_flags {
-	TODO_EDIT_MERGE_MSG    = (1 << 0),
-	TODO_REPLACE_FIXUP_MSG = (1 << 1),
-	TODO_EDIT_FIXUP_MSG    = (1 << 2),
-};
-
 static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
 static const char nth_commit_msg_fmt[] = N_("This is the commit message #%d:");
 static const char skip_first_commit_msg_str[] = N_("The 1st commit message will be skipped:");
 static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
 static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
 
+void add_squash_combination_header(struct strbuf *buf, int n)
+{
+	strbuf_addf(buf, "%s ", comment_line_str);
+	strbuf_addf(buf, _(combined_commit_msg_fmt), n);
+}
+
+void add_squash_message_header(struct strbuf *buf, int n, int skip)
+{
+	strbuf_addf(buf, "%s ", comment_line_str);
+	if (n == 1)
+		strbuf_addstr(buf, skip ? _(skip_first_commit_msg_str) :
+				   _(first_commit_msg_str));
+	else
+		strbuf_addf(buf, skip ? _(skip_nth_commit_msg_fmt) :
+			    _(nth_commit_msg_fmt), n);
+}
+
+size_t squash_subject_comment_len(const char *body, int squashing)
+{
+	if (starts_with(body, "amend!") ||
+	    (squashing && (starts_with(body, "squash!") ||
+			   starts_with(body, "fixup!"))))
+		return commit_subject_length(body);
+	return 0;
+}
+
 static int is_fixup_flag(enum todo_command command, unsigned flag)
 {
 	return command == TODO_FIXUP && ((flag & TODO_REPLACE_FIXUP_MSG) ||
@@ -2005,20 +2025,13 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 {
 	struct replay_ctx *ctx = opts->ctx;
 	const char *fixup_msg;
-	size_t commented_len = 0, fixup_off;
-	/*
-	 * amend is non-interactive and not normally used with fixup!
-	 * or squash! commits, so only comment out those subjects when
-	 * squashing commit messages.
-	 */
-	if (starts_with(body, "amend!") ||
-	    ((command == TODO_SQUASH || seen_squash(ctx)) &&
-	     (starts_with(body, "squash!") || starts_with(body, "fixup!"))))
-		commented_len = commit_subject_length(body);
+	size_t commented_len, fixup_off;
+
+	commented_len = squash_subject_comment_len(body,
+				command == TODO_SQUASH || seen_squash(ctx));
 
-	strbuf_addf(buf, "\n%s ", comment_line_str);
-	strbuf_addf(buf, _(nth_commit_msg_fmt),
-		    ++ctx->current_fixup_count + 1);
+	strbuf_addch(buf, '\n');
+	add_squash_message_header(buf, ++ctx->current_fixup_count + 1, 0);
 	strbuf_addstr(buf, "\n\n");
 	strbuf_add_commented_lines(buf, body, commented_len, comment_line_str);
 	/* buf->buf may be reallocated so store an offset into the buffer */
@@ -2083,9 +2096,8 @@ static int update_squash_messages(struct repository *r,
 		eol = !starts_with(buf.buf, comment_line_str) ?
 			buf.buf : strchrnul(buf.buf, '\n');
 
-		strbuf_addf(&header, "%s ", comment_line_str);
-		strbuf_addf(&header, _(combined_commit_msg_fmt),
-			    ctx->current_fixup_count + 2);
+		add_squash_combination_header(&header,
+					      ctx->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
 		if (is_fixup_flag(command, flag) && !seen_squash(ctx))
@@ -2109,12 +2121,9 @@ static int update_squash_messages(struct repository *r,
 			repo_unuse_commit_buffer(r, head_commit, head_message);
 			return error(_("cannot write '%s'"), rebase_path_fixup_msg());
 		}
-		strbuf_addf(&buf, "%s ", comment_line_str);
-		strbuf_addf(&buf, _(combined_commit_msg_fmt), 2);
-		strbuf_addf(&buf, "\n%s ", comment_line_str);
-		strbuf_addstr(&buf, is_fixup_flag(command, flag) ?
-			      _(skip_first_commit_msg_str) :
-			      _(first_commit_msg_str));
+		add_squash_combination_header(&buf, 2);
+		strbuf_addch(&buf, '\n');
+		add_squash_message_header(&buf, 1, is_fixup_flag(command, flag));
 		strbuf_addstr(&buf, "\n\n");
 		if (is_fixup_flag(command, flag))
 			strbuf_add_commented_lines(&buf, body, strlen(body),
@@ -2133,9 +2142,8 @@ static int update_squash_messages(struct repository *r,
 	if (command == TODO_SQUASH || is_fixup_flag(command, flag)) {
 		res = append_squash_message(&buf, body, command, opts, flag);
 	} else if (command == TODO_FIXUP) {
-		strbuf_addf(&buf, "\n%s ", comment_line_str);
-		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
-			    ++ctx->current_fixup_count + 1);
+		strbuf_addch(&buf, '\n');
+		add_squash_message_header(&buf, ++ctx->current_fixup_count + 1, 1);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body),
 					   comment_line_str);
diff --git a/sequencer.h b/sequencer.h
index 64a9c7fb1b..b01f897020 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -119,6 +119,13 @@ enum todo_command {
 	TODO_COMMENT
 };
 
+/* Bits for the "flags" member of struct todo_item */
+enum todo_item_flags {
+	TODO_EDIT_MERGE_MSG    = (1 << 0),
+	TODO_REPLACE_FIXUP_MSG = (1 << 1),
+	TODO_EDIT_FIXUP_MSG    = (1 << 2),
+};
+
 struct todo_item {
 	enum todo_command command;
 	struct commit *commit;
@@ -208,6 +215,29 @@ int todo_list_rearrange_squash(struct todo_list *todo_list);
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
+/*
+ * Append the "This is a combination of N commits." banner that "git rebase
+ * -i" writes at the top of a squashed commit's message, commented out with
+ * the comment character.
+ */
+void add_squash_combination_header(struct strbuf *buf, int n);
+
+/*
+ * Append the header (1-based N) that "git rebase -i" writes above each message
+ * when squashing, commented out with the comment character. With SKIP it reads
+ * "The ... commit message will be skipped" for a message that is dropped (a
+ * fixup), otherwise "This is the ... commit message".
+ */
+void add_squash_message_header(struct strbuf *buf, int n, int skip);
+
+/*
+ * Return the length of the leading subject of BODY when it should be commented
+ * out in a squash message, or 0 otherwise. An "amend!" subject always
+ * qualifies; "squash!" and "fixup!" subjects only when SQUASHING, since a
+ * plain fixup chain keeps them.
+ */
+size_t squash_subject_comment_len(const char *body, int squashing);
+
 void append_conflicts_hint(struct index_state *istate,
 		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
-- 
gitgitgadget

