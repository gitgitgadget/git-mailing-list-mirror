Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569F17BEDB
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314766; cv=none; b=rItM2vndVHCUXXFzb5I9EctrNTE6cjJh/KgPTBXbRtzABnkuAP6K2NlJBPbaJFNohLAiBSjy3ZLd2CfNoMKntUXr5im6Mf99XbtvAJJ8PzPB3LQpq+7HYjH2HQWn0XMTk1/nOxwTwfOM3SlJSTg5MpuhZo0ZCGiDVdGhiPU5eqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314766; c=relaxed/simple;
	bh=Mm9+/1SceyHXOyZaWG0/N2P5ivOkKnxS1ycfKHWrQ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4+3ELoRc8RxCb7Rdq68ViqB1ki33ek+wZh7lNJsMOThIWwvbKrYutxlf3ufnunzDv603GMmBjF2mYT9ZGPMft2dZ/e4isljV8fgWS7k9HlJbUL/c4hvhJfghcMCsgEMc8LMpgHfQvsMKjENDflep/lv+ujgv4JJJAm09uY2XZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOtKBZSa; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOtKBZSa"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a99fd4ea26so40668385a.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727314763; x=1727919563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JPXn7kBfZYIq7EXLytY0LcWYnu6PVdvL3Wim3ylb9g=;
        b=hOtKBZSa78T5dSvFeM+4XRRQ1N/D8xuH+3JW35lhNvus6n54kwCGqnSo0R6S9yBnsj
         Up7lzT7dixytOqfd1RrqT3mP7u/6CHYNyVYtMbkFphYYwnskVItObcxVgYyvFQuxdzOY
         Q9k6Geofz0dqHCn+pyp5jj5E+BhI6xYOu6vME3L0EG2/7sG3/KTHQfBen/FMyoDLkADU
         SvmUjU1Dc0F064wVIZMO6vr/gWZjPZxXjPBB/AFnrWVNqsHAwBDllEW0CqXOmrg0k75T
         8E8EBXw+35UECur3RB/4K3iM6NjoP3P5rYzXf95Jp78Jc/s78MDFfYJv4FvS11y3B/T+
         2/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314763; x=1727919563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JPXn7kBfZYIq7EXLytY0LcWYnu6PVdvL3Wim3ylb9g=;
        b=RzY3RV6+LqoSPi3r1ZR28CqjLuSultPOHP45ajNlrcjJxl+UpWFK7bHfpjvbPJobW3
         mxoUcpctTbl7WMUb/lyv5bC1W0De8NK1zsLP0O6fBriGYzOYGiyGEf/utzIL+T+3fEOO
         K2XPyhW5RNLnqkFKBb97Nqx+H42zbVq+6myCgfxdwJBJn8hwxItguYG5+I5zlGLucDBH
         axfH5sBqIAdEOsRGtUsJIwFOycSZWU1oRzKV3WEMtdE6Fz+WUqLU/Wqp+yCUtP5MI3V2
         ot39YHXoLtUQxCkvVsAEdzIzEUgRM6A0lukYjYikNWcooJ8ddrF4twXJsHBG6sy7d3O+
         dW1Q==
X-Gm-Message-State: AOJu0Yw8lbGkWHrX8B+7k58/sWaAbxqKFqZUrSnQfM1gJnF6h/er51Bx
	DkPHehKk51LvdHlx16/5trmX3ftP5CXQi829sltY4GmfhYkQp/AE7++8xfZo
X-Google-Smtp-Source: AGHT+IFj2L+5MWf23phuHYs4FX3nM9O8sg8GkwrsqJCE7PLpYPbgmC7TUoKUowkjEEmbpxtWoUMm2g==
X-Received: by 2002:a05:620a:469f:b0:79f:12fb:ed1 with SMTP id af79cd13be357-7ace73ff73amr694301185a.16.1727314763572;
        Wed, 25 Sep 2024 18:39:23 -0700 (PDT)
Received: from localhost.localdomain ([142.188.15.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde49acebsm227789985a.0.2024.09.25.18.39.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Sep 2024 18:39:23 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v3 5/6] cat-file: add declaration of variable i inside its for loop
Date: Wed, 25 Sep 2024 21:38:55 -0400
Message-ID: <20240926013856.35527-6-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926013856.35527-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240926013856.35527-1-eric.peijian@gmail.com>
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
2.46.0

