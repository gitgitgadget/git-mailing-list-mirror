Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A71EE02A
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147724; cv=none; b=tfd7PoMgU224iB7PbkzN/x1NB+d9S6aRTmQNRMmAlyDMm/E1JZ0WmOYPDrG+Zak+vD8K4LhDWHKGiNO44wFvHDhqRhBnZiCWnZ5PcHzeLFVgudVzg8DdoOpBPD5OMgahMDYD1tnaSgHsLjHJ7MmRdNg2rZYdUlbNnmNPYyjAp30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147724; c=relaxed/simple;
	bh=FMOM9jhFBpxYkrmdNgtvOsXn4xzPCnMWTBVYg03X7m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZl4cXXG1S2xNqVljTJf0L2FAgt1A7JzA9tSZFl6Y1F2fsedJxg54Kj6PrDMhqigdf6o62io4vyjc264W4LTSVLX0Y5ZLbKyqYyPh2bVYN6eApFd/qLJjxU8sWi4VnLF0GTcdVy/IPSOybEkH8Tc5pt++4xjs4fQ51EXS4n0oXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY4E2zS/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY4E2zS/"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460c2418e37so37421751cf.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730147721; x=1730752521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bXXKwzFSC0TkD8Nt5yO4VGdeeX7EPsBU1Pyy8CMfhc=;
        b=dY4E2zS/5EwBS0qXMgq01xNmmg1isrUJNBXVFYD9Bt5Q42yhWgQcftrfYwqVDu/ziz
         8z1r6vGv87SXGil+FjWUGz3TxZZoOR8l5pHF/6leTOQ+CneMK1VLGuDVWk3C8Yzb3iRU
         8hKUDMrt99/XiJ170xj7rloDlyzRjVZO/QUt6LnpXW64rlHYXHeiBxcg/0oI06Bb+C1j
         62qUC57qwJKYSPyN+QKosdTAcQUcGROmAnWxM+0d93UOnGCuIXt+vrzXIoNA9bgqwwB1
         Xmi3E8xSYgxacYtq9r0XU+QwC+m6lSJ3q258N5XvARogktNa4/Jhn7svwkFD80M3UI4w
         1Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147721; x=1730752521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bXXKwzFSC0TkD8Nt5yO4VGdeeX7EPsBU1Pyy8CMfhc=;
        b=bLnIl/ZYVYSsOUAcZOh3TB4eTknS8QYCAE5J3fBAORZ+cZieFYQtvDezyKjoKiU+VJ
         Yxypr4Z/1ywirhNlyz8vD5qzJ7CpdmrwVBGJoCazzg7p3FLQrErPibqzrdZz8fcVtH3d
         /fFSqAxK8JNiH4fouduQs62+m54NChSvHV5/0F8ntMBnKxf/loEMK9/wnnfz8Xq9D3Wb
         ZmWUnLdeodRPY9KHQOdRVnA73YfP5jdzb13sCNmQREEYNncX2hmSkIuvmH5EIAL1FuPK
         YM8sw+5lYeMTksfvMTeFo75BwGjN8DLkUZx3GRAg7zfGkNabhCpPpzkdn701XtWaNCgy
         nw9Q==
X-Gm-Message-State: AOJu0YxYBhugySpQv13IK8NVMtyAzi2sw1kDO/viQg5SLxX8bQOQc80w
	wmXutTS41wkuukwZM6Pw0vjChPHnvQXO4CKx4QjTjT+oFw4EAVp96l5OnaZD
X-Google-Smtp-Source: AGHT+IGF5psGdRIG6wLW/pK4hvomWhXlY8RmPKHYlc2edfBbzkFa0MiDXXSPVwBiqU97+5hXWEkBJA==
X-Received: by 2002:a05:622a:1181:b0:458:2622:808a with SMTP id d75a77b69052e-4613c00d122mr179171481cf.20.1730147721431;
        Mon, 28 Oct 2024 13:35:21 -0700 (PDT)
Received: from localhost.localdomain ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613228c099sm38215791cf.46.2024.10.28.13.35.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Oct 2024 13:35:21 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v5 5/6] cat-file: add declaration of variable i inside its for loop
Date: Mon, 28 Oct 2024 16:34:56 -0400
Message-ID: <20241028203457.19715-6-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028203457.19715-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241028203457.19715-1-eric.peijian@gmail.com>
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

