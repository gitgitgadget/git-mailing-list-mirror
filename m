Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8313783C3
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411412; cv=none; b=MUZcPbR8JDTd+X//UxmJ76lzA0qOCez9r1Ekm1V1a6NQdtvi/bPnoTPP+fOYxBq3ay7a5odgVy5TtOul5fY7nTY5kIVAFzr/HiH+uxZcP01rigOt559jl/xq+/HP9Od4o6imctyaaBgep0CRsLEnBXKLZ51Xl3/ysIDzb2INXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411412; c=relaxed/simple;
	bh=f5N5tWnhRdlIyrj5zcbsJ7/LWTSbXx3OQbDPj89FBTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b141nMPhB5/hOCqjqHxp5hClZb+gPxbW7Zz+Exi1tZj9LEyW2usWzijjoDZsxCCyrUwOdEcFjExdinTuYLQeOitjLQvcjTvEA7jEbhUZGFR/Ci6K9lO1A0CJYbeymPapFdrwGqYpGkIZmg0XYutNq4x38av72yrOEcijP1osO0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyeu77JO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyeu77JO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4955158f26aso4394955e9.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411409; x=1785016209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KW8AyFp369QxJe9yYHf5IRM+uNNxxl/pg6bEDv3Cano=;
        b=pyeu77JOJXI5IHYEqpT/ZczCeIqVfZLkug1VatHkpKI3TJZnUnGUnpMXHO6bnn6I7y
         X4Ybv30p/BD+Axzi5m+8RyF0zvND2K8ib4vq6LOn+9kLPr+ay0/UxEYpnBprhGkmEwq8
         1W+doZm+t6SiLfxgsmQtSTUmTXh0rkRn1q/AYQFWvYwJudRBbqk7HwTKhLCvATkV60iy
         CrTzysAPYlS35R01aM6gPUH3BZujvvIOVp3LkfqWow1Omd7p0cedY7/Z4RRHkWE7iXxj
         Lz62gxtsBU50TQmweU1ZDKsK7WnPcYEqh0mxKf5B+hbs9k4JpGSWJ8HGvebHpyhvZeGV
         OjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411409; x=1785016209;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KW8AyFp369QxJe9yYHf5IRM+uNNxxl/pg6bEDv3Cano=;
        b=p7jYizZ6AeHjDUImV6JZUFRLkTgf6BrUIFrrgokZPI2JPk7XSsWKHd1Rniw25itKax
         2GIhIAG9ZQBRHxCC0ufLy7Xin3BGhB3jNo4OBE7hObeWEfhTEPKwg+Aw0rYE13RuVNOy
         v7n+0DRiiHY9WruP/2nYkrLt1LTE+x1VTBqcAbe01fhlnloW8dqv9mXmqu69YUNru2j8
         y33So9DyAIdn8w123qm8io7I8Gi1BMfTw5L337g6vQdIl75kJtUnUi7qhuS+SVGyGxp2
         i+is4o7dm36eZaSkQVY+vOiiEXoWv+8LOziml95BphNw5/8kmOZkfh7cKj4SxGf2jVWw
         iaxg==
X-Gm-Message-State: AOJu0YxSwPpqhfcmXDyxUxilgYvVLh91HDkQ7lawVn1tnhuPTrHwAhdy
	uHoXayOb9QEyOGvwSEOOALi46SNdo9ifSzu4ONQ64blK90Viu5YhYxFtUiTmBTQr
X-Gm-Gg: AfdE7ck55+SnQabF6Ks+Yj5fr5bXWMfaZGLUt+vxtosjL22+wwMDg9jZnRMeLk+28Al
	oX0Op+5eSTs0MFmhqiKFT9wUQ/pfvuUbFVTJVuh20gaJgXFtNdoTc5Dt6QQVzLccxGybpeBw1NQ
	L/IxNLkCS0QQAbJn3GBJyCh0zvnVeJnMv7b4WUajtlXVbM5H5gQB5rDoR++bsEoHvnEQLyiHNrZ
	KzAAHV5vMlDomyYHMzGBxAlQlkvyDOO+MUdhqV5fgLnLmxKPQVTCxq0yERNhgiPVMM3Cwkk66X9
	fCeTZnK8oCSpNm1umSqXvRLzQktVfF/gq34UCxYN+PFpX46D2XOqerKBe4PuiD1/mfl0CFCC6KR
	k4QMM+rMSgA5y5DAdE9+ArBhvDA9SN6XvR51jjdqTBn806/rqsjWOHEPA4+ziXJ2ExfAGVjVwGz
	8NJ9cNunqt0IqXOBH0gU5GtVMIvvfF/NV2m9HEgeMdkg3Cc+d7cfiOSLtFfW0VQTSMMKRWSVxhb
	9YsW/qxUCvSb/c9RdktVW+zBqjUO16KwNZaUAA1bG4OamPmTglG4dC05nLovdV2bIh5Nxk47fuL
	Sf2ZKsfe2xg1JcoV3BW/ZMWxKOG1E6jO
X-Received: by 2002:a05:600c:81b:b0:493:df1d:7488 with SMTP id 5b1f17b1804b1-4954a3f1611mr58679275e9.16.1784411408965;
        Sat, 18 Jul 2026 14:50:08 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm146225145e9.13.2026.07.18.14.50.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:50:08 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	szeder.dev@gmail.com
Subject: [PATCH GSoC v20 02/13] cat-file: declare loop counter inside for()
Date: Sat, 18 Jul 2026 23:49:51 +0200
Message-ID: <20260718-ps-eric-work-rebase-v20-2-0c13962ac532@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

Declare loop counters in the for statement when they are only used
within the loop body, limiting their scope and improving readability.

While updating the loop counters, use size_t instead of int for counters
that iterate over object counts.

Update the 'nr' parameter of dispatch_calls() to size_t as all callers
already pass a value of that type.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c | 13 ++++---------
 fetch-pack.c       |  3 +--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b4b99a73da..03afc44c5e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -721,14 +721,12 @@ static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
 		struct queued_cmd *cmd,
-		int nr)
+		size_t nr)
 {
-	int i;
-
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
+	for (size_t i = 0; i < nr; i++)
 		cmd[i].fn(opt, cmd[i].line, output, data);
 
 	fflush(stdout);
@@ -736,9 +734,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -765,7 +761,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -775,7 +770,7 @@ static void batch_objects_command(struct batch_options *opt,
 		if (isspace(*input.buf))
 			die(_("whitespace before command: '%s'"), input.buf);
 
-		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
 				continue;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 29c41132ee..9eb8fc5399 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1388,9 +1388,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
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
2.54.0
