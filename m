Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A47441A
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601547; cv=none; b=ShPPVthBKJx4lUa4EgMIc+gLSR4Exw3ckDRWOgjjWyg9QP9gNQIzpRGiXAyT6GQAcgTiqNGmsV1n3ovTX8Eim+orUyHp7zmgaWrs+RazR4l9FcDjfBldjM6mOcM/aN8g1GZmZh7SLpSWonV5cWcyMwMz6XmX1uOemXMy9XkVhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601547; c=relaxed/simple;
	bh=laTlMFAAmmBbP2uCpLm+OZgWTZBU3tZkzQRDYvj2Jeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsVwkTJzXGTjkgmIg50IZgI44e7AgVDyay0ymluIaPDYt2nj+chLi6how85MMpRFvLIN3tHYU900/gRnus8TQsZVCNveTeavLx494HV8GvDul+1eEeNQVkOXtUTv2Hg7jwxpI08fzC69hy0SOduZGS8pOYJXGSWo1dQh/0ke9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa2uhimW; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa2uhimW"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so4896646d6.1
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719601544; x=1720206344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+slh/48oQBtspnNSvuscqc1tLioXexbTriSECz5EdVs=;
        b=Xa2uhimWhcXg1nljP6wgGWv844v3wPI2y7JQLrcdK5AoCyZM5G+M3JPwB6bCJteXXh
         Akzp9t8/sO2mz4lxW8QTaXTxinHQVyYRvzMg6GCHjxH56iz3kCMT6CwkRbklgavJiNXV
         wyGeTRvYUaTkowtz99MeYpyKzasWdLZ6HSgx8BqZ0CvR+xWl7if1x4yu26VW061M0vDb
         kWzRYtIl6JRjUeEkXKGGhJnloIOrqn/SfPCiOG2DqCdaWFXXhuViTr3WekQBOvTRQC/j
         +QS8jGY20Dp9F2iua6clLdACqSwhRd93uCitXWoRleYhXU5iy1A4AEUz7uGIpY8TdiAi
         ONUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719601544; x=1720206344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+slh/48oQBtspnNSvuscqc1tLioXexbTriSECz5EdVs=;
        b=tOvzjZxHDo14Kne0CIitu0i+1H841LMoWbCp4sVN9A8z0+WTopmykYInO/6ED9n5lq
         Sr/fzcFUkRx1UdU2oAZHxJJODmARFqrF8XtolSgnD5iWjZTuJ5CtHaIdFmrXzsmgMKL2
         t0H+r2VXgzM8yipdJoNAYGgq20UxSu46oTt22VQu/RZWJN13WuXemC7hKUNQd4MQLRks
         ZkZcszf2nfAOV3ZvLscYN2R4puvrRHLzmyxLYqkYJ0/0wqN8ehp5Px7T5s+Ydt5ehUfx
         92ATafkh5JBWozafFqmo/Ztz6Hk/XYtlqw53oVrn120bfEksaQAe52RvD7QAhNro5ZNX
         +JDg==
X-Gm-Message-State: AOJu0YyxHUsyLuCdh7nDZ9Y5kh5rDyXCA6SJO7qd+cL2GVooQmUQ9Mta
	osgV8LTpZkRPMTXoy7H3TbtSWZrXXzVAz2/9/kk9LqchKOxH8gOY1/pFkjBj
X-Google-Smtp-Source: AGHT+IGLhknbow2p7+1OLZFOZ+a4qktRli0+8zO1QbTc3a1HW5Xckfd1sFHWQ8EM4z+QHJV1vlBGUw==
X-Received: by 2002:a0c:ac05:0:b0:6b5:3da3:adaa with SMTP id 6a1803df08f44-6b53da3ae08mr170879596d6.3.1719601544058;
        Fri, 28 Jun 2024 12:05:44 -0700 (PDT)
Received: from localhost.localdomain ([76.71.94.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e574cc4sm10262346d6.53.2024.06.28.12.05.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jun 2024 12:05:43 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	John Cai <johncai86@gmail.com>,
	Eric Ju <eric.peijian@gmail.com>
Subject: [PATCH 5/6] cat-file: add declaration of variable i inside its for loop
Date: Fri, 28 Jun 2024 15:05:02 -0400
Message-ID: <20240628190503.67389-6-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
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

Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/cat-file.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 43a1d7ac49..72a78cdc8c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -668,12 +668,10 @@ static void dispatch_calls(struct batch_options *opt,
 		struct queued_cmd *cmd,
 		int nr)
 {
-	int i;
-
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
+	for (int i = 0; i < nr; i++)
 		cmd[i].fn(opt, cmd[i].line, output, data);
 
 	fflush(stdout);
@@ -681,9 +679,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -709,7 +705,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -719,7 +714,7 @@ static void batch_objects_command(struct batch_options *opt,
 		if (isspace(*input.buf))
 			die(_("whitespace before command: '%s'"), input.buf);
 
-		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		for (int i = 0; i < ARRAY_SIZE(commands); i++) {
 			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
 				continue;
 
-- 
2.45.2

