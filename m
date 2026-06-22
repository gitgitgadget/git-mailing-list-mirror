Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6068352029
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117390; cv=none; b=rObDQFtBYGkG4FeYmBelKYRzSioKKqyK1GRTRGS2XGwZejlc4O18+FAtO0bvlJw9kGz/uwEGIHhrBqQnMR7wfL+iPAx+qnFUDyKabzgNqZYHSOWxX+3dd9XwVWVf8WPDbt0ZuJy3gkoXmyd513LGv6Y1cLquGz7TOL+D/PgCoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117390; c=relaxed/simple;
	bh=MSNUFxE/MgGFC4CieMZmOo1iWNF5nS38ZxGfeYmYAaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggQqArblF7wkk5Vh8qnMacWMgiU/xVbdXyEokR8xSRCYAk82bhQx70lbty9+VKsi2uJetSoBK7xiSO4cW6Fp8zAtjWlgwNDS1uRdVr/mnulR+ccqrj0K8wklwyBjnubMeGIqCn/vEzlshA0ZQLHHoIYnRZ4snHclOO6mgInBmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoWkRNSc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoWkRNSc"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4924944fe6bso11137125e9.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782117387; x=1782722187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MA5Niqm9lYKMWCnFMXi1w84kmIeZMqnEigF9MGcguXw=;
        b=aoWkRNScOCQn6n8x9jbyZzxo3xVoqPrHfqwmsfeN0nE7f9JJwaI0XFX/+D7JC5FZ+4
         N8FqsTRfuAfvFCDEZqXnzGdmEAshZU4AKFxt5XqPGcN4FRMWsk5KXJcxE3mtNGyi+yth
         x/NrYsGQXDYKBrFUR4L7aDN8yVrEz/Qzjg9WFSY/fjH+sfh9t6NFvIybkbZJ9L5CC4f5
         AEQDVI8ghQOQ4M4XSGPSYr0PuzkO/HxFKPm6DlM23mVan2WbsVik+S1b/KESb2gs2uSe
         hu5E7HjH8mKx3YYkyAvbPtYm+p5371Bhmi3OR8pJQKEJnIb1GwvtcpRX4YGKAC0XoGic
         sXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117387; x=1782722187;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MA5Niqm9lYKMWCnFMXi1w84kmIeZMqnEigF9MGcguXw=;
        b=EiIX/LMO4IlKIzCUdC8y0e1LJIvESVs5CMdGp3NDKg1lvUrJWpxA8fMkQ6NqiHvtJM
         G5LYcGUrg87uuNozQL3YK0RISZWvhX8g1j/8yPyNoe6QBB/EqHPw9x43hm/BlByJwfyE
         9H77IJD5I4bFhUWrSw+dbb9Fpl82RVsmbUONOAfo0AMX4Wj5H7rDy1nqdqFg9O6CZ31k
         NQM7BEBNuH4jekIj6t2ZVbSaSe3/PUzCR/YPR01Z3CvS3ZcS/6u3+RY4EdZc6zsu75Mp
         J1ItqbhWQYoihoyI0M8hp5iQB08dvdSuRPsq40xSj3jbk+DdNUtY+SCAKwHribylNdZp
         xpDw==
X-Gm-Message-State: AOJu0YxxINjI3lGgYIdGvTdYGpxcg8XzUVcfOPqKVpJ+9jzf88p6uLM+
	kNK6iz94Z5su6ZPBplRYKwAG1aonb56CZ7ET+JIVVT30/nIKBSJYf7AaF5aKag==
X-Gm-Gg: AfdE7cksu3Xa7miPrhQIIDB2i3s1XuCgmbNMFbKDoPX++5IUHAvXp8sQ7JzFR2kP84H
	Ogh2neHeA3HaU/Jm8ImQQuhi1JXJ/mYXQyUBTnuUMonDoGVo0Lz8hIOdfvWcQgNb6lgCju0Q1wO
	zRletzKGfIRlYCO53VsM3+c4lS3UlFg7FlOZNlS2iOOGqgckNbXFd8XXnwrlYXR/RxyT00HixRa
	ygl8otWS2x/HL41H6qW304Ig5ueO2X6hssnyRTUAotarjXhzxiFPmZmIUBMioKRWL4RUGNfKWIn
	CTtKxGL/64xjt2bSstwAMvbt+2Cjn/RDiMY4AdTNWo6cg8OU0YogR9LrQwGvZHe/NBW3en5/orA
	z+XzAOpUCJj2ZrDaZcF4FsrecCynfBGwfrt4muk6rpe1avS8JQWUeBcZnXvh9F9Q6bblp9bBmdb
	aJuwM2GPQ/LpBDIsJy
X-Received: by 2002:a05:600c:4592:b0:492:32a0:7f92 with SMTP id 5b1f17b1804b1-49240e0598amr223952205e9.12.1782117387187;
        Mon, 22 Jun 2026 01:36:27 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494497ffsm201186945e9.11.2026.06.22.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:36:26 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/2] sequencer: factor out parsing of todo commands
Date: Mon, 22 Jun 2026 09:36:03 +0100
Message-ID: <d27dddff93144f7b6d7fc89719bdf53b6856c9fc.1782117361.git.phillip.wood@dunelm.org.uk>
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

Move the code that parses todo commands into a separate function so
that it can be shared with "git status" in the next commit. As we
know the input is NUL terminated we do not pass a pointer to the end
of the line and instead test for a blank line by looking for NUL, CR
LF, or LF. We use starts_with() instead of starts_with_mem() for the
same reason. This results in slightly different behavior when there
a CR at the start of the line that is not followed by LF. Previously
such a line was treated as a comment rather than an invalid line.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 45 ++++++++++++++++++++++++++++++---------------
 sequencer.h |  8 ++++++++
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f4..b8e860434a8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2625,6 +2625,27 @@ static int is_command(enum todo_command command, const char **bol)
 		return 1;
 	}
 	return 0;
+}
+
+bool sequencer_parse_todo_command(const char **p, enum todo_command *cmd)
+{
+	const char *s = *p;
+
+	for (int i = 0; i < TODO_COMMENT; i++)
+		if (is_command(i, p)) {
+			*cmd = i;
+			return true;
+		}
+
+	if (starts_with(s, comment_line_str)) {
+		*cmd = TODO_COMMENT;
+		return true;
+	} else if (s[0] == '\n' || (s[0] == '\r' && s[1] == '\n') || !s[0]) {
+		*cmd = TODO_COMMENT;
+		return true;
+	}
+
+	return false;
 }
 
 static int check_label_or_ref_arg(enum todo_command command, const char *arg)
@@ -2716,29 +2737,23 @@ static int parse_insn_line(struct repository *r, struct replay_opts *opts,
 {
 	struct object_id commit_oid;
 	char *end_of_object_name;
-	int i, saved, status, padding;
+	int saved, status, padding;
 
 	item->flags = 0;
 
 	/* left-trim */
 	bol += strspn(bol, " \t");
 
-	if (bol == eol || *bol == '\r' || starts_with_mem(bol, eol - bol, comment_line_str)) {
-		item->command = TODO_COMMENT;
-		item->commit = NULL;
-		item->arg_offset = bol - buf;
-		item->arg_len = eol - bol;
-		return 0;
-	}
-
-	for (i = 0; i < TODO_COMMENT; i++)
-		if (is_command(i, &bol)) {
-			item->command = i;
-			break;
-		}
-	if (i >= TODO_COMMENT)
+	if (!sequencer_parse_todo_command(&bol, &item->command))
 		return error(_("invalid command '%.*s'"),
 			     (int)strcspn(bol, " \t\r\n"), bol);
+
+	if (item->command == TODO_COMMENT) {
+		item->commit = NULL;
+		item->arg_offset = bol - buf;
+		item->arg_len = eol - bol;
+		return 0;
+	}
 
 	/* Eat up extra spaces/ tabs before object name */
 	padding = strspn(bol, " \t");
diff --git a/sequencer.h b/sequencer.h
index a6fa670c7c1..28fabef926f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -262,6 +262,14 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      struct commit *onto, const struct object_id *orig_head);
 void sequencer_post_commit_cleanup(struct repository *r, int verbose);
+
+/*
+ * Try to parse the todo command pointed to by *p. On success sets cmd,
+ * advances p and returns true. On failure returns false, leaves p and
+ * cmd unchanged.
+ */
+bool sequencer_parse_todo_command(const char **p, enum todo_command *cmd);
+
 int sequencer_get_last_command(struct repository* r,
 			       enum replay_action *action);
 int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
-- 
2.54.0.200.gfd8d68259e3

