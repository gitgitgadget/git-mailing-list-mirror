Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FB15278E
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976248; cv=none; b=S5TlFDUNKbNVOv0uiKwM675hd21aoS5R2NlGoJnXS2uMDaVybPzoutcNcwGvsw1qg1XTEAuP2aQaxpjHk5lryD6E2qY4+H4a8rxEDoPh4/LMg8oUMFrhCmd18d1pMv5TAqlAsWCr8+KhTcBOaaFP/ZIO19DC9yCIf0BGEBM7kXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976248; c=relaxed/simple;
	bh=N2M3l8cY/9AOoY+5J34qPWcE8IOI6j9ApYtbLggXhmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUKYEv8mIOd6OqyKqwNGXNjbTSr4fqGNsZsYI8NIvsRXF3CMHQ8Yu3LIfOilNt7c/OWA8415Wg30ZZlTHwxWAVZ236sYuzE5EBwcl33Gfp02w0iK3GiPdND4xRRL+y/lrxNgE5vSfdhTvGWLBbf3a3rwNDMQanMdNJ5ryh3Hc10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhhfPlhN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhhfPlhN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2363497cc4dso15877815ad.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 15:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976246; x=1751581046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQbHXFCb5uhpK0LfMem0SE82qmNUYi+r8dyYUtqOswQ=;
        b=EhhfPlhNoB72CUw7K+pmf6ZMEBdRp5ZxCkqWFShHOBK9jjW7GMkhIxz33PYXoVpEph
         tcmr3MUHBNojsZueoWJVrr306AwktjJPCLSoc7r100DRxhdexIEsOqhM8wZwM+xtMSR+
         b0hFPFb30DhheQWIE/RQ+iArqsNqwOTJQLJt3dmizDoMF3vsVz1bHkgxXGISaVXic7/R
         KzZbNTCVCYMDtqXEoohEqQWlEaPSigZ01hFySxJkHw/ycYSeTuq89tKyTQZ8QKOthapn
         chNu22m0HA35u8ciy4zdaDusJZyuN03lLq9hrO7jgbIEtiKLhzMdM7AyxcFcxz/BXxoO
         qPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976246; x=1751581046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQbHXFCb5uhpK0LfMem0SE82qmNUYi+r8dyYUtqOswQ=;
        b=PzgqOPRikda2VCpS5jGWva8H2YFSt7/7HQk7JK+UXcfQWIEl71t1KIF30bUFCls/Tr
         YftMovAM3SKoo5QYvSDMtRMLnqdFQTJFU7ZEH2udXr9rEv599Loz6vDzUIYjP1SRnaav
         UT5NfNmeOeK5hdDQsvmWy4FcOKFqTeQwVuwX5bTtlNvhgl1nmI9/3XzcTeeX2g+opraA
         ZwT53nINZ6gclaIIsgLjQqR6zlHnwyayYxvCBpHYjx0/t7VgWriijm+loRUWgHvfo420
         YLWVcDqWg074QbNX0Tn/OL01fDKxsK2G15pNsG8CeqZK/npm3JFbpmEfUfGV1zXrZxKD
         Mddg==
X-Forwarded-Encrypted: i=1; AJvYcCXqqy78QheIDnlOh6CpJ56z2cKVWdrh2UWEppIs64UhZvg5ZaYxxvdeWUGS5fKrc6FEVT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfU0E4JNFnAghGsfXnoPk4BgbX9O/+9sxtBV3A1RO4j1dhhU+T
	S8P+5ytNeNvfQVZt4exIUY/JpjGg0TIYLknOEed+J5QxaqdMJ7UWzKnU
X-Gm-Gg: ASbGnct2AJeO/iAAJYH9pxqs9He+w4PIUFv6FhjqGuCWt0oT4ZYTBGjga2R7mYTjeC1
	O4unWZou+a4ifPKj7aIW/LxiEeEE3RdYpNFQ4OY7D3y54E4oaGitTvHBrPLVfwfKBJSPJDZ734M
	pO8Zx+2pOMShCkvQLx9rQ5BWCVMCG57WpeeHfT8wxkR6SH4v0eXKxpzcs+UGGCnj2mp93cvTpS0
	vDyjy26K6DVo16MWdBUo4OI2ZA+tpd0tRQtmycBD9koGOLkMvkEy+LVbfYDk/2cnSq1pPz3xdV5
	KCLi/5WPsJsPBzAwZDg/RmAGy/lOvZ/HCeCFNANhM4i8e9bTATxGejGS+/yI5QElDref7Wh68xH
	A+bJW
X-Google-Smtp-Source: AGHT+IH6Zsc9isuChsHZrvZ5wJiY7BuismARPBvSKjy7EmPqbqqShWzQJhQUTtQKdVvd6oY4r9kGdg==
X-Received: by 2002:a17:903:46cd:b0:233:f3df:513d with SMTP id d9443c01a7336-23ac4607b79mr14717245ad.35.1750976246412;
        Thu, 26 Jun 2025 15:17:26 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c96:9e23:a08a:9fda:a9ee:44b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f1c78sm956035ad.71.2025.06.26.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:17:24 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	shyamthakkar001@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v2] commit: avoid scanning trailing comments when 'core.commentChar' is "auto"
Date: Fri, 27 Jun 2025 03:46:31 +0530
Message-ID: <20250626221631.457725-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626132233.414789-1-ayu.chandekar@gmail.com>
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When core.commentChar is set to "auto", Git selects a comment character
by scanning the commit message contents and avoiding any character
already present in the message.

If the message still contains old conflict comments (starting with a
comment character), Git assumes that character is in use and chooses a
different one. As a result, those existing comment lines are no longer
recognized as comments and end up being included in the final commit
message.

To avoid this, skip scanning the trailing comment block when selecting
the comment character. This allows Git to safely reuse the original
character when appropriate, keeping the commit message clean and free of
leftover conflict information.

Background:

The "auto" value for core.commentchar was introduced in the commit
84c9dc2c5a (commit: allow core.commentChar=auto for character auto
selection, 2014-05-17) but did not exhibt this issue at that time.

The bug was introduced in commit a6c2654f83 (rebase -m: fix --signoff
with conflicts, 2024-04-18) where Git started writing conflict comments
to the file at 'rebase_path_message()'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---

Thanks to Christian for mentoring, and to Kristopher and Junio for their reviews!

 builtin/commit.c           |  6 +++++-
 t/t3418-rebase-continue.sh | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fba0dded64..63e7158e98 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -688,6 +688,10 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	char candidates[] = "#;@!$%^&|:";
 	char *candidate;
 	const char *p;
+	size_t cutoff;
+
+	/* Ignore comment chars in trailing comments (e.g., Conflicts:) */
+	cutoff = sb->len - ignored_log_message_bytes(sb->buf, sb->len);
 
 	if (!memchr(sb->buf, candidates[0], sb->len)) {
 		free(comment_line_str_to_free);
@@ -700,7 +704,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	candidate = strchr(candidates, *p);
 	if (candidate)
 		*candidate = ' ';
-	for (p = sb->buf; *p; p++) {
+	for (p = sb->buf; p + 1 < sb->buf + cutoff; p++) {
 		if ((p[0] == '\n' || p[0] == '\r') && p[1]) {
 			candidate = strchr(candidates, p[1]);
 			if (candidate)
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 127216f722..ccfe77af6c 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -328,6 +328,20 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
 	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
 '
 
+test_expect_success 'no change in comment character due to conflicts markers with core.commentChar=auto' '
+	test_commit base file &&
+	git checkout -b branch-a &&
+	test_commit A file &&
+	git checkout -b branch-b base &&
+	test_commit B file &&
+	test_must_fail git rebase branch-a &&
+	printf "B\nA\n" >file &&
+	git add file &&
+	GIT_EDITOR="cat >actual" git -c core.commentChar=auto rebase --continue &&
+	# Check that "#" is still the comment character.
+	test_grep "^# Changes to be committed:$" actual
+'
+
 test_orig_head_helper () {
 	test_when_finished 'git rebase --abort &&
 		git checkout topic &&
-- 
2.49.0

