Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073B2594BE
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361482; cv=none; b=slF11RIfYqOX61Nk3LnSPQKnMYgwTYF0MqKG/UzbFxUy2+u5/d8e7x01g5hRM0Z5atRP25YBn9DA4lQ90Sp2lzXJedCzO9bR+mDN7SstrjUwj1im/D5g4bF075FmGLuhltWupK0QtYxV92rYy/4HT3c+3h4y+lDIxMRFBhG5Ay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361482; c=relaxed/simple;
	bh=xVmXQsTEZGelVYVwoQ0smDbmLEyqsmDsmPQVmVysR/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Twvyr0dPog69+AKu7j2xjswWwm4g/0Sje74P9eqpNtmk9vGIwpbp7CTaC/7Ck+YZuWjDk6BhbQ3e5KoVqaACkuxLH7YTFd3XMDYEfQ/HYL/2OfdWWCpRcw/nODNDUJ9t3YptOdlW7TZ6Tg1jJ/rxRfdpHdRXh5r43z4Ec8nxiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpD9DSG/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpD9DSG/"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6f7d7e128so103324985a.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 10:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736361479; x=1736966279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JY57OZwsj0U2BlrFEaC+IbbqHQ5k77T5ok4hCgHPWH4=;
        b=WpD9DSG/+I9avMlARSZJmSxC5wyUJ4TWtzLNiAVKfk6RgbXD2ISyegmDX/xmrUc8QN
         QRhDS+VoVjd8wjBQAgL2No7zmySTCfHCSRKfp+ID5dVgqAYgYE2j8kpAFOBm0e+93Eor
         xP+5O3TgHJfoVqNgGjpaL9p6Mz8Y+rilyc1LKaji2CZ9vnrXqwa2WALr+EDtYNmOw0ys
         U2g7ziwhGTEl8kdTvLY473Yy8d65/9qeJddP5kR0ndFP8BUrkunfxGAEt9Ypnu9JNoys
         E54s/RI+m65gd6rjAK+V3KCgrXYyNd0aHsuE381or2bkncDSGW8pbWEHU/ht8S1nRp5J
         vHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736361479; x=1736966279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY57OZwsj0U2BlrFEaC+IbbqHQ5k77T5ok4hCgHPWH4=;
        b=PmoO0swOxwzYbXAUC76eSRngZYn7YJ974HeGfoKl9UHprgJGt5bGAn7kf9z3fHC8N0
         l4mlSPymWTMAxzj+x5+483CqM0ywjUOqNG7dmHGf3MapK/pDb8KyVomdMGnko0FwoSq+
         kx3MzWtfSOQ6KIdfvmaFIdtqW9Zd/h67dU/QavG8B9FgUQAwn5Mx95eYLrBTahZO+WdN
         NjGRLNfnnE0pd2AKDDUC3Ee73gyCWHWOvquQyAvHrkRIcES46E5NinlXq9nweqtlpyj8
         vyiVTrhN1f1SL/s9zSecwHg1ydsq3Nqxcxt6ghL1EXyUjc4SiqwHFSQigZpjD1/8yMjX
         RzKA==
X-Gm-Message-State: AOJu0Yw1dTSgF1hMBAYCyXY6UKAt8zpTn96lQtQTbUn1zfyEyPad0Ckm
	cL9mDGSMd8GjCWHO2e/d5YERQwQLBhYdz0YMybbUKRr2lbBDJBAdMBRtFhdRM6I=
X-Gm-Gg: ASbGncsRFMCiXPlq/nSvPP2BSYr0klYlxW8nkOkLDDrBoCLj3+MwGwJohu/Gd6a0I/h
	adeGGJm30bItOiJK5CyFzWEDPZvhWs0FG6ZmI3yPo6RP1+Uwo6wwMs/anhlL+i0D6QwyXmQ1CBo
	O7lGw7AHI8sK9+6UhG4y8JL4ublnorGXalX8sxEZH8PGWU88Xv/5Argy8UiuJcbO6/8KhEKPgGI
	Ws+E+6zmS6esBwQaRnqZT4yHflpGKqs5IBWf3kwOSMMdMP3fv3B9HEAzQnzgHOZ0V2Z5t5DrAHf
	U1g32bMVRg==
X-Google-Smtp-Source: AGHT+IFbxR5OXNc/uLIPFuRYBvkcxZDAolP6kWC4V+rOvZzlWznBowG3e1Gslm0UmXC7HMQ24W/g0w==
X-Received: by 2002:a05:620a:2614:b0:7b6:dd22:31f0 with SMTP id af79cd13be357-7bce0f7c846mr79029185a.0.1736361479314;
        Wed, 08 Jan 2025 10:37:59 -0800 (PST)
Received: from localhost.localdomain ([184.148.194.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea74bsm193228036d6.25.2025.01.08.10.37.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jan 2025 10:37:59 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v9 2/8] cat-file: add declaration of variable i inside its for loop
Date: Wed,  8 Jan 2025 13:37:33 -0500
Message-ID: <20250108183740.67022-3-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108183740.67022-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com>
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
index b13561cf73..69ea642dc6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -676,12 +676,10 @@ static void dispatch_calls(struct batch_options *opt,
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
@@ -689,9 +687,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -717,7 +713,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -727,7 +722,7 @@ static void batch_objects_command(struct batch_options *opt,
 		if (isspace(*input.buf))
 			die(_("whitespace before command: '%s'"), input.buf);
 
-		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
 				continue;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 3a227721ed..f5a63f12cd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1329,9 +1329,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	if (advertise_sid && server_supports_v2("session-id"))
 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
 	if (server_options && server_options->nr) {
-		int i;
 		ensure_server_supports_v2("server-option");
-		for (i = 0; i < server_options->nr; i++)
+		for (size_t i = 0; i < server_options->nr; i++)
 			packet_buf_write(req_buf, "server-option=%s",
 					 server_options->items[i].string);
 	}
-- 
2.47.0

