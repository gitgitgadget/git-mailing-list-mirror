Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3719E975
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803287; cv=none; b=gqBfa1muXh9YrVitTrDERf6ngC2M15WlOsaGN+UW25BFiEh510o7gpokysRSWc2WF2Nlx+o5cmhoZ6sa/9pOrd09qhu7ptcACnzbZ5/cD0wDnfvZis0/EzqBuoBJc5cQcEtWkgUxLcUNRcHLGIVo4+Bq2GDJCJu8TPAr8KOF7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803287; c=relaxed/simple;
	bh=FMOM9jhFBpxYkrmdNgtvOsXn4xzPCnMWTBVYg03X7m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGZ51c5tv02mM+CvejjgBOdzBXOJhU06yUEuiku6G+U/prqNmiep9vnrWa0xWRo8zCcqKhgp/XFQXGDfOCM7vfFSwwfZwe7UxMwP5wKtEGGuLAocwdhVJIT6StV40M4LtTChVPAAf3zNtE1jIhTfvsyERQa7tgBTmFsWPqBIS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7jv8CR7; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7jv8CR7"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7ac83a98e5eso129292785a.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729803284; x=1730408084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bXXKwzFSC0TkD8Nt5yO4VGdeeX7EPsBU1Pyy8CMfhc=;
        b=l7jv8CR7epV/1qeqDLi8mDiNVX1fi1UK8YK0a6GKBHwoUOMnwGQ+2s72glROWZK5DU
         7SDoL8E1HgEzib8Kj3J4I2sCmKtKgd/namKi/I+5YGX39sbpGkeoxtx+4TOucZQDLcsy
         3UUmp4ZyFE7ZySFMi8uMQA8yz/FGJsEw6sBJTBlVb3m3aDzehdZ/xbcIcCLBmSyCqi6h
         Xn5bYRNG/29eTwU0nVvgeOE8eWZ7CC7PNJ0oWkQMjPbNnfntf56YcPAR2Ijl8k1T2iAw
         LB8pBySuVqhbkiRQ9pHqGioGcBS4jobPVbH1RzYhKFQM5NnemB3w7rG6ho8Ghj5TmNQd
         3//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803284; x=1730408084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bXXKwzFSC0TkD8Nt5yO4VGdeeX7EPsBU1Pyy8CMfhc=;
        b=DQgLPH7XILz9CqGKSs4WQW3K+pWa+IL1XzcUHmm27o1sgaBdyeOhFhdBbVmBFryeU1
         DeCuNKgWHzWLdTtfCpAYC6wM2jom+J+kxZSwoi2hf9yeBrZ4o18PXO7dc4Re+XdiTeDF
         fvZc5aJnwsAq2+LDLCDKdmWF5LijU2JtqAX8JsNDxyK0FZHp3jch4m5ux4itblkzpqsF
         miO6zStB9pVU5GZAS/bC4wJVrcdpGcAEjVHWCD5iryHQeLm9RMWwfqA6ERzfEm2YHkGk
         ZTXjmrZsEtK+qiteHxQHp0WNqli59WDdYIzPiE2VZLE01/XseUwrXhmEtGre9BZcA8Kx
         sa7w==
X-Gm-Message-State: AOJu0YxpPgMgVol9I7E1w/YrRmZyLpHEduUuRWiPC1wZZORjPAfUjfbv
	3tnd9ouxzvAUgT+7Nx+N/RGhrGWet04ndB4Z76cxu0WKWSeiFIjPRlsOBDZm
X-Google-Smtp-Source: AGHT+IGjqyXIg2JaFtXVVrgldG123ZkUGTap6Jz2BquSsWpCNCS2dZsNxrC7Knysq5QDyAZGTfv8MQ==
X-Received: by 2002:a05:620a:4711:b0:7b1:4890:d177 with SMTP id af79cd13be357-7b18662a4cbmr526829985a.33.1729803283815;
        Thu, 24 Oct 2024 13:54:43 -0700 (PDT)
Received: from PeijianitLabMBP.home ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008b951esm53421556d6.22.2024.10.24.13.54.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Oct 2024 13:54:43 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v4 5/6] cat-file: add declaration of variable i inside its for loop
Date: Thu, 24 Oct 2024 16:53:58 -0400
Message-ID: <20241024205359.16376-6-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024205359.16376-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some code declares variable i and only uses it
in a for loop, not in any other logic outside the loop.

Change the declaration of i to be inside the for loop for readability.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
---
 builtin/cat-file.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bfdfb51c7c..5db55fabc4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -673,12 +673,10 @@ static void dispatch_calls(struct batch_options *opt,
 		struct queued_cmd *cmd,
 		int nr)
 {
-	int i;
-
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
+	for (size_t i = 0; i < nr; i++)
 		cmd[i].fn(opt, cmd[i].line, output, data);
 
 	fflush(stdout);
@@ -686,9 +684,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -714,7 +710,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -724,7 +719,7 @@ static void batch_objects_command(struct batch_options *opt,
 		if (isspace(*input.buf))
 			die(_("whitespace before command: '%s'"), input.buf);
 
-		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
 				continue;
 
-- 
2.47.0

