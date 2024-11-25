Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC731E517
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513002; cv=none; b=EUrMfE1hHoCqtChT08rgtiCVO+aoEsj7G5w00CgcVtUE7TS0KW2AoE4LtsI9ATIJH0R7gUYKOIxGPbRbf/jJJVwmAZXBEOYhItmysGyI7pMSdmcGuiH/0FjIXu82yem9mKnjZitI7z263LEUM9gigx31YfBsuxIpxhWtxK0+yLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513002; c=relaxed/simple;
	bh=8XUsHVbsUJvnHR10hW5O9/35WUtbS4IEB/tHGmtIjaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEo/aqn4zAjGOU2wcwSIhe5dOzjnR+EiW4PgQlHMuLJLsEAIKodF8ex72HLS1oZhrKXzyBvJ/nEQY6Jnw5zgXcUcStJM2ZGAr3T/IhsTiiSoAZ2hITQi2+fTPD2wYZqTKM5ZJI/+q5QUwbBZy+kfsvwtmWlCiIL5Al00RHDI1Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd8nnGG5; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd8nnGG5"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b65db9b69fso109274185a.2
        for <git@vger.kernel.org>; Sun, 24 Nov 2024 21:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732512998; x=1733117798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij4eZgVcQZU4ZhgublYtvEonf8UPeLM4VekVwjMDq8U=;
        b=Xd8nnGG5DqocfqGA4Wm0G93AzpYEAZh45N79WK19laWsLUSllhVgN2kGK1+7jLFknR
         sTRPq+WY6fQKAi6CwI3Xtn5mRKnceCMg3OIrqmBHsbQOAZ4XAZd34dnnnyuxQOGGrkBd
         ePPgq24GFD7rHJ2MbvwcLL4JtU3v1lqaCtY20WEruxd72RAipy7mxf7R8Ot+XvlmKF3O
         caPPGLcK3kYSrqLN8GTCYLMuOPYlGLwt3qL+55Hq99i7VLQrU5h10ANYgC42khxxR7JB
         XRWvjnfHV48hhHf7xNCEFmeoAD/nLaoNk5N6oeixJ4LwNwKhjQQ7EJEUojBOYbx1FgjN
         F59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732512998; x=1733117798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ij4eZgVcQZU4ZhgublYtvEonf8UPeLM4VekVwjMDq8U=;
        b=GylRlgdYt/cW4MxbznHUWVvMj8Chj2+sBjt7sQ3mlvAV1w8Wd+Gbq+4gifhKwJ79G9
         JrahBgZJFCH2w9VHgn1bbtxmmxHasNbCwzoEsrnmqtI3Fsw+33OL7opM9232iyrk7T9L
         DgWkbKMs3Gd76qnBiytlmozXbmI6JyiUMdvZTK219EOJQh/LyWBwVOrodz8ulF0g3WvJ
         KUvCPe7EPPdZn7DamLRSL+p4IZNYYUmeRwsktgKxoA9MjZ8FGL9Ljji6iCvV81x28zI2
         xVvZhwmz2Q7KNPLLXZVTKz1cdY65Gb2O1mwITvkxHIU2aLYgyLKj1IRdBsGejk9fM7ij
         QHEg==
X-Gm-Message-State: AOJu0YyfR72a/RFiSYCfNtqc0/7EeGL7SyDgzLj9dbfb/+UH4Yi1VhAc
	kLsWOC0NDQ+dnrd5YNVG0EHm3uKScZZHPxRANCsqmPZ/RScgeAULntbCxoaQ
X-Gm-Gg: ASbGncswrnG4NhXzLpKoksyIK6jLk/B/qhm2NFLMI5KqpfhvUy0kmFie5/NjhWnTLQA
	AbmvgF0sqJTgnbUVP+s2ZMNdBqJbTf7MNxvBLQQriDe3RmOVIQvh4U1zdZIHAgFx4PJYlBqOCSQ
	kM3n07oE/WPUrrjmOUsVg1uw1e2RCENs+j86i14BkDEcavrcKcHJpqjp7mUzOHbyR3pDr7mDrMF
	q0MwrDLt+/BG1LuFzV31oHhPyJ/uen0SqWT6Au1zJ+NQFOEPK7zebRsUjB3yZ4WUdJ5j3Gf/Inl
	cw==
X-Google-Smtp-Source: AGHT+IGW0D2gcqJS/0D4NilPlk4R9YUFAmBtKoeQ90DHo+6t/eaDiYa3BXuH9mFK6pULybQfb10Bxg==
X-Received: by 2002:a05:620a:4451:b0:7b6:668a:598 with SMTP id af79cd13be357-7b6668a07bdmr522386685a.62.1732512998175;
        Sun, 24 Nov 2024 21:36:38 -0800 (PST)
Received: from localhost.localdomain ([184.146.186.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513f90534sm320522585a.25.2024.11.24.21.36.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Nov 2024 21:36:37 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v7 1/6] cat-file: add declaration of variable i inside its for loop
Date: Mon, 25 Nov 2024 00:36:11 -0500
Message-ID: <20241125053616.25170-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125053616.25170-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some code used in this series declares variable i and only uses it
in a for loop, not in any other logic outside the loop.

Change the declaration of i to be inside the for loop for readability.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
---
 builtin/cat-file.c | 11 +++--------
 fetch-pack.c       |  3 +--
 2 files changed, 4 insertions(+), 10 deletions(-)

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
 
diff --git a/fetch-pack.c b/fetch-pack.c
index fe1fb3c1b7..bb7ec96963 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1328,9 +1328,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	if (advertise_sid && server_supports_v2("session-id"))
 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
 	if (server_options && server_options->nr) {
-		int i;
 		ensure_server_supports_v2("server-option");
-		for (i = 0; i < server_options->nr; i++)
+		for (int i = 0; i < server_options->nr; i++)
 			packet_buf_write(req_buf, "server-option=%s",
 					 server_options->items[i].string);
 	}
-- 
2.47.0

