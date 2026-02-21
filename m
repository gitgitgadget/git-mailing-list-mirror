Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AF2C08D0
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771672012; cv=none; b=kQwgxln9OXNXzuzyFwbeYmUEVRBQX0y3Q6zlQTOxkZ+zRswC191Wk8+mOn2laZSsP94Oph76PuWsmj70U+7LT+IEONgsbS9sZiN4BFSsylrj1e54Be8fzN+TRAwP7Nevea6GE1DNpOSbed3DNDVVZn4EiTKQha+Ve9KskThI3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771672012; c=relaxed/simple;
	bh=z+Tq7m0vd7QVkbLH2hQnx+0rqmLXFu5UE4z7LmI0H1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJZR7ioKtI+/zNGsQsCJo3UjJqyNm5FUcx3z62v0JlGUyQ1nhfvq/DB8jGtJcNgibAK9MrkrjvGjAxzJtesEF/QOSqTAQARWgi28xXmsucbukrv6aTBattIaSPkY16S6IkKdHU11nysjWTSWCRya4TCNEl2k0CQ7J2bAZAJiqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPmcptmN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPmcptmN"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82311f4070cso1896911b3a.0
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 03:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771672010; x=1772276810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBMz/QYv//I140V+qgtIo7QvJDXptWue3HBKstMTB0M=;
        b=dPmcptmNFNoSUUoFzt8UJyzyFsoXzAfntNv+la6zvcbINhXA+umQiRVGfQMg2ZouTH
         FutrL+BQVoJBpC2KYktgiz02oxbhufQfCSVoilo9zwvKZXBcJwheFHGwJYmOARDCKm8R
         ggqL6V3Tq9xcpraQ6G1atsQKlI7zfBJ/tePbtVeiLLvTSjFo7e9fNFDZfK/4KMWgpYbk
         BN36HkKD33ck6KbkcxETeMk4llxQ4iexkXOBEPa9NCSPAJ9tP46CR1aicfKvtbNZNBJt
         7O2Je2SBCuPR1aRLf/pbATCu8wkgbJYPQF9m8+sLdimFqS0LLg4MBdm/CPzc7rZV1Dm3
         nHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771672010; x=1772276810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBMz/QYv//I140V+qgtIo7QvJDXptWue3HBKstMTB0M=;
        b=rGr8BvpLWaTKXcXVHlXAmyqlqHw2+n3s0YRbxaZDq64abbfgWN88Sni4U7QbvWVZFr
         9+tSjWwhDkDdJpphmVV7bZpzaj/wWRYrSlRQNmOzr+vJTf0yuNo3ZpODKaTnnTh3hTS1
         lGwd8x3lLED3IhWzSLiDnmNxUrBKUQgHeblxsINGeTe//fgeA970uwSX+fe59LNjHtkN
         k5VhVxyzqHZVF0hooARKa74mSC3A3Sgk5b7vtt+lProTuOH1zav5ypHFFHYSMTJHyRlq
         J1p1yQSc2awSQPBg8+BEkWWRxf6I9SJ61fex52iCn1wjcMZkbARTNs/zJ6Dcf1sglGvL
         aMPA==
X-Gm-Message-State: AOJu0YyTMWThj9ZYDqeqnHdfzvXowHmpGQma+z+0YoHWAzWChXjnYvkh
	C14GvHvyr1vFxz9o7mv+A4f8rcJYR1haQAGgaCEiWO8sak7970Yh3oPa
X-Gm-Gg: AZuq6aLxYwFcYysI7DOh7chnNcwkXH2L9xiZGg9OUMPd4kKYWv0lQ1oR7MkvjT/hvd7
	/e25/Lxvo9sHCSIFiKkHxdm/5NwtObr02LZJN2QhrSX4mP5FE+5kTcFzsKHxAkpKENpfeIEgNgx
	Y4b8GzC52Vum7yabx6/rqaOnLMekZEds8pbIBETH1nQ+QjEHoO4ZaoY77WZL8FAMSbE9h3NH/wp
	roH9msa4esbPgFMu06iMN6NvfQ6kkpI2dT6aHIUjtkDe7udLQc9w7NK1PJcye7On2LALDWaJQ1+
	P0KloLAGEwhUv+F/wEt8/gp/9C4s7Y5s/M/T8gq+Tf4wSRHpFy+gSWBgTRC+hVuVZ3T0kvedH5U
	DsXIg2Ie0K0oEY/dEU1vsEUrwd7FEnwHSRNNxVm7nuO2x4Qtg3iOk3M6kRogxLStx1isJsIC7zd
	UCAtslo8OyDMs4kxvFvdY7P83gIAmcEJEbAX95c5ceTib7
X-Received: by 2002:a05:6a00:4b4c:b0:7e8:3fcb:9b00 with SMTP id d2e1a72fcca58-826badc1ffcmr7565449b3a.22.1771672010039;
        Sat, 21 Feb 2026 03:06:50 -0800 (PST)
Received: from Pushkar.xu.edu.in ([103.92.44.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8bc0c8sm1804361b3a.54.2026.02.21.03.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 03:06:49 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	peff@peff.net,
	pushkarkumarsingh1970@gmail.com
Subject: [PATCH v3] path: factor out skip_slashes() in normalize_path_copy_len()
Date: Sat, 21 Feb 2026 11:05:12 +0000
Message-ID: <20260221110511.1592-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqms17cjjj.fsf@gitster.g>
References: <xmqqms17cjjj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract skip_slashes() to avoid repeating the same is_dir_sep()
loop in multiple places inside normalize_path_copy_len().

Keep the dot-component handling inline to preserve the original
control flow and readability, as suggested in review.

No functional changes. Behavior verified with t0060-path-utils.sh.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
Changes since v2:
- Clarify commit message to reflect reduced scope.
- Make intent explicit and ready for application.

 path.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/path.c b/path.c
index d726537622..1772fcb21c 100644
--- a/path.c
+++ b/path.c
@@ -1112,6 +1112,14 @@ const char *remove_leading_path(const char *in, const char *prefix)
  * end with a '/', then the callers need to be fixed up accordingly.
  *
  */
+
+static const char *skip_slashes(const char *p)
+{
+	while (is_dir_sep(*p))
+		p++;
+	return p;
+}
+
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 {
 	char *dst0;
@@ -1129,8 +1137,7 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 	}
 	dst0 = dst;
 
-	while (is_dir_sep(*src))
-		src++;
+	src = skip_slashes(src);
 
 	for (;;) {
 		char c = *src;
@@ -1150,8 +1157,7 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 			} else if (is_dir_sep(src[1])) {
 				/* (2) */
 				src += 2;
-				while (is_dir_sep(*src))
-					src++;
+				src = skip_slashes(src);
 				continue;
 			} else if (src[1] == '.') {
 				if (!src[2]) {
@@ -1161,8 +1167,7 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 				} else if (is_dir_sep(src[2])) {
 					/* (4) */
 					src += 3;
-					while (is_dir_sep(*src))
-						src++;
+					src = skip_slashes(src);
 					goto up_one;
 				}
 			}
@@ -1182,6 +1187,8 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 
 	up_one:
 		/*
+		 * strip the last component
+		 *
 		 * dst0..dst is prefix portion, and dst[-1] is '/';
 		 * go up one level.
 		 */
-- 
2.43.0

