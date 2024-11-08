Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCEE208C4
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083102; cv=none; b=i8FFdZQLJ62xARdAMG+OaZLnjNp2kLJ69MvlHPYDyV7ydkMRguhNkioo21cTtWEEbht2sYTf7kZc9yobwzGxnnaB2XU5ZjcPU2cHVwZv6CyGBZsGaHPpOn85PnYfkCMoJpI4aPNAGNbSsqDNdBq4LtVUz3Mia1XKqthHV36g/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083102; c=relaxed/simple;
	bh=Buv0dIQpz936Bodofsl5frnz+GwoguVpovABuP8WosA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvMNyHmZnewurU+RZp7YBps7dXTlg/kQgGl3YI9wraIPZ3ZzPtbsxXZ2PjQj1IQcmY2fYeiXwCpYKcWI2b6A/MOLUmGLhfBvO9MfK36wGEUdEWkrf+hYC/myjowDxq+gREy9b395wZROUVdLOb3U6YCFguMiudOjVnYiEJqQS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWMIYDFS; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWMIYDFS"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e290554afb4so2503783276.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731083099; x=1731687899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I2EoROCz2Qp/2ZPdIAwrWdcVzp7Ds2rhkUKBlCwfGc=;
        b=VWMIYDFSIvb54lX6d2Rs/zmFZ0As3H/eJemz7hYpCZ1JQ2xll5UMAjBahmQDoJmdm0
         spUmnnl7vjcxDKq3hToN2Dt1cPWftvoUMSfjAjNlbTaFjuBnFg+IklkngNMYzu0Zq/yH
         qMqZBy7QrbcBLioTJD6h170WGLRPIe7ZGtPkb3Fc8kHQBBFG8vUob26ccxJxaeRZnbwH
         h+Oo70Qwe3tvD1eCfTM1h/CpQBIHCMJBXf6cJQcapwo0SZUi8LUS8iEmBrwXzvEvVyw3
         Xvk67dT7RcH826YG+VVIsElY/FKRqyUgZNPtU5c+E3LZtTyJZ15gIHZMhlbTJ1UIGTyj
         kWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083099; x=1731687899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I2EoROCz2Qp/2ZPdIAwrWdcVzp7Ds2rhkUKBlCwfGc=;
        b=fQhKkb0MApUikBlg32rXhXdeP0sCrpyS2l4eII/FVjWIlt7QNQg88gfHBsmCXVcTb9
         vigChQIi4imSATZWF+cAM5fcHe2JEiCgSCUk6bSDdI8c39fu1zpzNn5ymNIi1/l604NB
         MyPxlom5mZ2okQ7mmOI8CsOHxbA75vGx+gighvxj5rf6nMtbKxZIon5sXneMavYzyOt2
         cYRf6QumCG6sms7/7G6FblIO4D71mUKiNtBX86sNxpHsHjl388welCfyPs156dyCOHeO
         pun3ad7rvRScae9wLz43Hf0h2ahvVRAtTenBuSv6+zccxEwj3tSy2NESXPOHwi1DLnvj
         NbIQ==
X-Gm-Message-State: AOJu0YyATsqy3HXXOv1Ygog+o144nOjXaTrhNKIuidlyQ1KsqLwwDuUt
	rMVOi3tdGW+3vKnulU4dOJvE1XZpKhhxeVRTXUU8kc7k8uHAu1gOhIyig/Ni
X-Google-Smtp-Source: AGHT+IEV/L0eZ2EJfwf3hWQjcw0XiTrtOxJ4uK6VC6+paMm2tZmMmx21GNv79jH1LUiCREt55bEw8Q==
X-Received: by 2002:a05:6902:2ec8:b0:e2b:ad82:e592 with SMTP id 3f1490d57ef6-e337f8d0269mr3445384276.36.1731083099245;
        Fri, 08 Nov 2024 08:24:59 -0800 (PST)
Received: from localhost.localdomain ([174.95.142.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3ef11esm21928711cf.15.2024.11.08.08.24.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 Nov 2024 08:24:58 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v6 1/6] cat-file: add declaration of variable i inside its for loop
Date: Fri,  8 Nov 2024 11:24:36 -0500
Message-ID: <20241108162441.50736-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108162441.50736-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241108162441.50736-1-eric.peijian@gmail.com>
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
index f752da93a8..3699cf9945 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1326,9 +1326,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
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

