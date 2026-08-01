Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730B380FFE
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567219; cv=none; b=Bg8ZtnO/clhUz+yPoYBdZHB/1hCNuyxNHR6fwnht0ecCKSh38fgBijlKyTCW+Iyq3nRF2Fgq1RrAAo26eai8a3kJAEoYou2i65/62x7mOu/Qnd7LRfEVg1/fPINWTlEEZ6iRFe3vHTK/NbxhtoocfXplm1K9z+KrUXEAF3N1+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567219; c=relaxed/simple;
	bh=ERd+Ftbus6mhypzOuVLzkYW8tiAHCCRV58cYSQhQWDE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bev/roVF6IFSSQ9hzKRHSi9IURfeb6q+BQndlWe9tygjwd+xqZkTjoZIedX34EUlO/6A58N8rTTwOMgm935t3xE95uh89+78f5vowlI0m8cV6STkkoMCZtwH2+mu1YJCmWq1MP210vwwuNFcEHPG1qmyT7a5/xZXzoiQiWNZDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL3yM08d; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL3yM08d"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so1361467b3a.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785567217; x=1786172017; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yN+N/We4+Oe5nxZucSLFJd1zci+8k+2yOId6cwigGWA=;
        b=GL3yM08dOZk+0+A/imQ1QJ/OWzxkFXV5EHtFlQrlN3G571t/3W95SSdykZd+3NaRSY
         v5hVAyhN1bsbpLwthKfZwGOj0bTLjGr4D6jBbGFrfUpNasCJ5dGKXssFGQEUhpni0EN2
         01LZ+1Q8i+IoGUcmgBR/Duj5DRDn8AwCHMSrVU7+iGXSNglS1RIeDbHl/A6sNMXCdLSG
         8osHALrQuPxfF3Rm4gyu0O3CPex0WFJz4uBChUcSy/Y2kIWsWBKXLm1wUXioJOtBAJYL
         D1Sn4UUIFLpHV8UpqU1mt4USICqpxa8482Tp16suu41IBg7kF32Wtv/o1Mgp35HV48rA
         OVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567217; x=1786172017;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yN+N/We4+Oe5nxZucSLFJd1zci+8k+2yOId6cwigGWA=;
        b=bksMzshPQYnZDw8q1XOQkDsgxt6sr1OgQtTNxKmhwACZ/iOVdeYig7D0nI6yrn8Qfw
         2q4TR7iCAmPHLYk1j3SqOnEUx3mskVKdLatKxfYyfN5qciSiGZD5lxhNjXWPXpNC2K1N
         XoV52PPIvOjrnJPesdOV+8z94b8KF9vo8fXkbrOVN4cVlV80NwGjEfo/2Axplk4Y0vGB
         vCTjQHz62jjzRwxWQoaN5EAeAYh4Bu9OI7GL+Zt1d49AGJyCw6ITSjqZwrt9mP0MMGuW
         yyrPEEwF3ucoz56a4VyvkEibwzyDwaDdzGnt0yAk6++RVZvSyZoevGTm/dCFlqJPAgf0
         CLuw==
X-Gm-Message-State: AOJu0YybEVW9h13012/5fT37D9+Knj5VRP3MnaiMYR3gWNefnmCHuVo2
	nKpvyaE60KutQchcR3vbIgkrVQjrw4ywTxtdvBDygjNEoXJyfOjuqjgr65fQC8Nw
X-Gm-Gg: AR+sD13NjblvgCaoy3pkJ1HomqdHqtM4HvW8sZU56aK1i8A29xE0VAMxUsFOauDWb2b
	47dtDYYYCBMCDYP6vgDFjgkNtFoVF/fJIzwLHWvzmA1HzQrHBGWmRgcRZcz0h899OO0tmGUK8hR
	tnIvvs3QPtMUFkplgWPTJ8CjW6Z4pfNBqdkHJQ1aDZe1ezMUW1Ubv8WNRmu7WeM1bec7Q9xn5l6
	0ZZEFH8ZiveQ59v1qj4X2MJo0NO0Wn8+KWiuJBH08ibjiPekofbsweu7/TzwxhP1qYZoAewmJ2Y
	4Z7rVDbr122NTSFPI7L/APHhY1cCRz/McUouVSNfKAj0dwt+hGDAy8aOnK9WVoKp3f6VVGb18Ys
	TxFzLtgVq9E1SndLA3qb1KrlYCRvHKe7v0Er2Er3GvhpdycMPqGBsdzxRl+dh9PlX6dHEvFx+82
	LKPIAZnEklosHY7Cqimg/RzVUYFGpbMyWv8R/3QOIPPEOwQd6enqI7I9+YoS8zIpCAVe1Rj409I
	A==
X-Received: by 2002:a05:6a00:3cd2:b0:847:8b1d:230d with SMTP id d2e1a72fcca58-84ee482bb68mr2084274b3a.3.1785567217395;
        Fri, 31 Jul 2026 23:53:37 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.138.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe593basm1342452b3a.21.2026.07.31.23.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:53:36 -0700 (PDT)
Message-Id: <0762589e22f7bacfd436a2fe7c2d09c499701930.1785567209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
References: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
	<pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Aug 2026 06:53:28 +0000
Subject: [PATCH v11 3/4] sequencer: share the squash message marker helpers
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

