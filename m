Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5161DA21
	for <git@vger.kernel.org>; Wed,  7 May 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629634; cv=none; b=DX5Hl0KbveDdfVGLo6dvQ2mCxfekMnzsZxUy+OQhlFpOGRMR4DT6RKk08GEqeLLpvx62/BhBmJb9nqS2KmnRZOxks0tmvObvJyh8PpeVuVrR2FnEY1WH9KuJzLwwVQAHqpQiAfj7g2OwoWCe76SDHC1IrD+D/vS7R4XTmaitHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629634; c=relaxed/simple;
	bh=bUISYwzdo265oNRuE2YO6S7Yva1Hb7XoEqo7n8jB4rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIbDt19GmPxm/qi0H80LndpzFKCwAb0qxeeJqzvXN1nfEE0zSb4yDyoWjlwf4XyCXYfDBKVRRd9kZ3CB7yY/JJKS+R6R+dpzMpSOJihin/fN3Lszj+Gbfie50MI4aPJMtX/yz0SZwPpNyFJNXZWJKBwCcG9Rl+9ZUPT2exU9NjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7AHar22; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7AHar22"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736c3e7b390so7906422b3a.2
        for <git@vger.kernel.org>; Wed, 07 May 2025 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746629631; x=1747234431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phDKJw+UjD1EoQwB2QJFAsXgBkQ7/qGdwj4hF79beqU=;
        b=Y7AHar22YSqwKaAWJMTTxb64WkAxL2DUfejr1niqHg4yjqZj9m9Gk3vFulOl9ElMKo
         B9S681+zwXeQlY+wIZntEDkVNYAbLNLzrujxxjSrGoUzfnrkXLjszQxMmjQ6yKfRZ0Ew
         0RZ3vPu8XrMd+fHC10m0bTlXP/qNDbrzIAsiu+oOLgtx31Rh81sAupT4vl8Y7E0Jm0Si
         YDMPQA1pTcK2VQqoj9x4C14bb8bvX/SC80RAq0evoR+NV3UPSnixu1JOqdtyYCH0s7Gw
         rJcY+L/JN1ahhrd2ycpcTucrXI6VguVPh/BuXpRMSYyIRXnesEgDsdSFbabrQsIKfhUv
         B+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746629631; x=1747234431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phDKJw+UjD1EoQwB2QJFAsXgBkQ7/qGdwj4hF79beqU=;
        b=Ia+e/TZx0ycGSZe8yvlZyD1PsBVURTNxGluOm8h8RUaXCgKGiLPzEZQQ3RUzhvQutL
         CxfhesahenjRNhxVIMPqCD1tF5dIvIqcEiszPXyGleWsOR9hs+HTcmnsz65f//u1qrM+
         oCVBw3upvqcQ/y4umXh2E36ahH3xBHtvv7t6vkqzu10677MKtIi4XGFW9Czc7ERtls2f
         beuoFJ+pKsDUGM1nKeCCOO6JbOZIYqZuWFYi16ljV2c/F4HUrJD8u6qtQvQQrZH0jWsC
         BYOauCzQuIwSwvUKfPWWDHsdWJYJayNU1rD62p58Iap+GfsfPSBmt6NFlbFxDOMPaOLY
         V35A==
X-Gm-Message-State: AOJu0Yysx1suLCyTCewGUODVmDKgFjJjqbL4hlhWAFQnLy45aXGTs7/8
	Z39CryiSmE/PUMM2sLCtc9vUizEj6BGr+VwimkZOzXpArgF3hxVMbirVZySih2M=
X-Gm-Gg: ASbGncuaBoQTehjrDuS6/zhgF7CMmUsU/wGXgmaC3OVB3OivvbRHtzQdMKJqTg1CNAh
	ENtYpl5WZb4WmH35hzOUZy2QoG6c3X851Qr/g8kun+0fbve1JU7Uru/OwBrRv5yCxhDRXa87Hk8
	I7UYsY2bUp+P466sM0tt48/YDtDr5PUGyqrNkmb6rhfYelzt6a/4x5Gbn8h3X6lkmkv6m7X1aHd
	+8wqohaMv5UxUybVQp+YghsvVnt0mHbF1NJh+6yWyk0/vLBEOH8jrC4nIBDwPgIN7xbGz/WCcdV
	EBxsX21r58jxEOi2Tp22+rf6P9NFADVx7dpgS/ccICe0cfI=
X-Google-Smtp-Source: AGHT+IGurPR4pair1jH36hNy2OdN2W+pCc65iEiYiMj7G/P37PDtoyprqzu56ykTtljsCjQM80mZ6w==
X-Received: by 2002:a05:6a00:4ac5:b0:730:95a6:375f with SMTP id d2e1a72fcca58-7409cee4245mr6138454b3a.3.1746629631588;
        Wed, 07 May 2025 07:53:51 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74058d7a47esm11286445b3a.29.2025.05.07.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:53:50 -0700 (PDT)
Date: Wed, 7 May 2025 22:53:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/4] packed-backend: extract snapshot allocation in
 `load_contents`
Message-ID: <aBtz-2A2VkhdNAyH@ArchLinux>
References: <aBtzn4nwLsI9p5Cp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBtzn4nwLsI9p5Cp@ArchLinux>

"load_contents" would choose which way to load the content of the
"packed-refs". However, we cannot directly use this function when
checking the consistency due to we don't want to open the file. And we
also need to reuse the logic to avoid causing repetition.

Let's create a new helper function "allocate_snapshot_buffer" to extract
the snapshot allocation logic in "load_contents" and update the
"load_contents" to align with the behavior.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 54 +++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 0dd6c6677b..e582227772 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -517,6 +517,32 @@ static int refname_contains_nul(struct strbuf *refname)
 
 #define SMALL_FILE_SIZE (32*1024)
 
+static int allocate_snapshot_buffer(struct snapshot *snapshot, int fd, struct stat *st)
+{
+	ssize_t bytes_read;
+	size_t size;
+
+	size = xsize_t(st->st_size);
+	if (!size)
+		return 0;
+
+	if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
+		snapshot->buf = xmalloc(size);
+		bytes_read = read_in_full(fd, snapshot->buf, size);
+		if (bytes_read < 0 || bytes_read != size)
+			die_errno("couldn't read %s", snapshot->refs->path);
+		snapshot->mmapped = 0;
+	} else {
+		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		snapshot->mmapped = 1;
+	}
+
+	snapshot->start = snapshot->buf;
+	snapshot->eof = snapshot->buf + size;
+
+	return 1;
+}
+
 /*
  * Depending on `mmap_strategy`, either mmap or read the contents of
  * the `packed-refs` file into the snapshot. Return 1 if the file
@@ -525,10 +551,9 @@ static int refname_contains_nul(struct strbuf *refname)
  */
 static int load_contents(struct snapshot *snapshot)
 {
-	int fd;
 	struct stat st;
-	size_t size;
-	ssize_t bytes_read;
+	int ret = 1;
+	int fd;
 
 	fd = open(snapshot->refs->path, O_RDONLY);
 	if (fd < 0) {
@@ -550,27 +575,12 @@ static int load_contents(struct snapshot *snapshot)
 
 	if (fstat(fd, &st) < 0)
 		die_errno("couldn't stat %s", snapshot->refs->path);
-	size = xsize_t(st.st_size);
-
-	if (!size) {
-		close(fd);
-		return 0;
-	} else if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
-		snapshot->buf = xmalloc(size);
-		bytes_read = read_in_full(fd, snapshot->buf, size);
-		if (bytes_read < 0 || bytes_read != size)
-			die_errno("couldn't read %s", snapshot->refs->path);
-		snapshot->mmapped = 0;
-	} else {
-		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		snapshot->mmapped = 1;
-	}
-	close(fd);
 
-	snapshot->start = snapshot->buf;
-	snapshot->eof = snapshot->buf + size;
+	if (!allocate_snapshot_buffer(snapshot, fd, &st))
+		ret = 0;
 
-	return 1;
+	close(fd);
+	return ret;
 }
 
 static const char *find_reference_location_1(struct snapshot *snapshot,
-- 
2.49.0

