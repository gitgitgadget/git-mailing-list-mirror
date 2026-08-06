Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F5423E99
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052354; cv=none; b=LhuDa6EpLH1+Odjkw0rh1lXD3MDMWLxGurg2x5ovtcmQhCGkqkyhXx45tjSrFkhJcdTSkufF+sXgnmfTnqa8O/Qp9IB0JQ/C0yp6yW03xQnKwdNixPYR3yGqU5iPF17vC/XwCrW/lKxtiVW63hfbLxtKqsfcnk7j70rQIfR+hYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052354; c=relaxed/simple;
	bh=8/7YZOn+t4Y10naYd9sbfmLN0yHMAB9qL5v8V7Qohqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGuPp5YrHNGO7D+CADoSMHrryiFVfxV/Z3Jn/fF1CKYOuKiZNj8+dx5r6NvErk4Z/2yv3d5FZnlS9Fza3rNTSLtoVP6RzzoktoRfViw0RAt28N3lm4AXksVsig4KvcoGH3I3rjXukSq8XmWicWASDXcS1OCabimEBDz2mfJJ4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu6tYSKK; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu6tYSKK"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6ae9b721927so1432808eaf.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052347; x=1786657147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xkp0E8wojGY0TWq8lXcWWvHddvuJm9pD41vygX/lUso=;
        b=iu6tYSKKsXKzfB0KAxWqBnOfC8XvnbWg+GaZkGnuTT32JHOZPVmGl9GbisH8+jWB0C
         WxqjKZmnjq4HUgw8OZK34R9iRWrZ9LcCh8hm7Y9sGBTr0ohlu0mZ4mpeFd8/S44p1IKE
         FzXWzM6fv5o4NxCLnXTzO9qC7GsIBL2pFdZTRHUCj78mfp5GVgpT+DU6yzKvrALUBO1t
         LYw3dRGHUxH780xIrusO806ZpYntRojrgReuY1LKDsYOvNK4dt5WedS5Qd7K/4TnQOyW
         MD1vaDR3vYdJPWhwR9EG5y9ovcM5r9uJnXy5UxBWoYWWvZDw0wWlYL0Bgi3/iSz2CrvK
         9HKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052347; x=1786657147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xkp0E8wojGY0TWq8lXcWWvHddvuJm9pD41vygX/lUso=;
        b=nMjG00fONWF9ywJeuDn63hQrcRZ1iUByChFaOgv3Bic+nRUyvFvrS/SnjLYXhgyvCF
         /K5+o8uq/u70YSO6M4eriYkxvfpmMKTPUlYNieWFbS3o8L2UzAmn1aix804j6258vsOj
         dZ5haGBnGR0Hik8yTEkQjmFsnKrIdhtHAq3lbFEa5Vx8kr8h2OnH8AdPJVa6tVd6yp+B
         E6UvIFbSNkbesTNo8bLwOb1UgcZ/72IKGfozndbYPpZBWYbul/O98cpj8gEfZS1mtHxz
         z7xNxlLMvgmW4Wz6r+7O05Jz89NZ00gzku3jWUOnkRs7NTsqU2tmnV8Sh8t66Fs7FHiL
         KTQg==
X-Gm-Message-State: AOJu0YwukK16ach2b67lBbYvotQPjiO1k+dM7ijNwJwmz7MjsXSNt7pN
	/d90nYK7G6vUy9AHw34+GYX3UbAWMJDQTr/l254tpPwB6Kjzalck7qnWqYCs0Q==
X-Gm-Gg: AR+sD13/PN572jJTIalOuiCVEY5X1/kDBX+3arp61IdWy4PUSdY+H5LZGLLaJ+kkCsc
	LLwDcz0BCuINxbWxKAhPtQp/JlTStmGhtVmuIpHE2fd4N6WgCnsaqSJw1kKabcSq7DnfZatwPaZ
	5DRxZt0DFZRa6qGeex3F+ubpOBRcweAzp6ITLs9wxPDG8+tHrNlfciS+ehryvUFDpaDE9D9GpFS
	vN0f+5Dvd5xD8L3WLhWCfd+e4zxT5ICBx6MpwZlmyOWQMzEOQeQnIn7HYsQqAMSp8vlD1ny10Xi
	wcsmRp0f972AunyrG1cpWQ6OQYRcGYAUPhIx4OkEaPQVMtU8J8BUWT49Bjly8VTtBfcdEERyF8u
	f1EqsJrLqP0hrs9MbHUctN+NJVCZmYeLA/0hW0n1Bzo6DbXXJLEPLIDviXY6Ln+xpF/rV+tKzaQ
	Avukryx4YVO9z4z+6G20lSagU1BaukKnJQIK7TAG7I0/+aAfSfygcnZvBABqDtQFurbLVD
X-Received: by 2002:a05:6820:81e:b0:6ae:871c:e3f2 with SMTP id 006d021491bc7-6ae970269a4mr8600746eaf.29.1786052347520;
        Thu, 06 Aug 2026 14:39:07 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02be475b6sm587078eaf.11.2026.08.06.14.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:39:07 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 5/6] builtin/receive-pack: explicitly pass packfile fd
Date: Thu,  6 Aug 2026 16:38:58 -0500
Message-ID: <20260806213859.816157-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260806213859.816157-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing the incoming packfile in git-receive-pack(1), `unpack()`
assumes it should always read it from stdin. In preparation for
`unpack()` logic being moved behind a generic ODB transaction interface,
update the function signature to take the an explicit fd provided by
callers to read the incoming packfile from instead. Call sites are
updated accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7635b82bd3..743005f1f5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2305,9 +2305,9 @@ static void read_push_options(struct packet_reader *reader,
 	}
 }
 
-static const char *parse_pack_header(struct pack_header *hdr)
+static const char *parse_pack_header(struct pack_header *hdr, int pack_fd)
 {
-	switch (read_pack_header(0, hdr)) {
+	switch (read_pack_header(pack_fd, hdr)) {
 	case PH_ERROR_EOF:
 		return "eof before pack header was fully read";
 
@@ -2344,8 +2344,8 @@ struct unpack_opts {
 	int quiet;
 };
 
-static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
-		  const struct unpack_opts *opts)
+static int unpack(struct odb_transaction *transaction, int pack_fd,
+		  struct strbuf *err_msg, const struct unpack_opts *opts)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2353,7 +2353,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 	struct child_process child = CHILD_PROCESS_INIT;
 	int err_fd = opts->err_fd;
 
-	hdr_err = parse_pack_header(&hdr);
+	hdr_err = parse_pack_header(&hdr, pack_fd);
 	if (hdr_err) {
 		if (err_fd > 0)
 			close(err_fd);
@@ -2380,6 +2380,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				     (uintmax_t)opts->max_input_size);
 		child.no_stdout = 1;
+		child.in = pack_fd;
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = run_command(&child);
@@ -2414,6 +2415,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				     (uintmax_t)opts->max_input_size);
 		child.out = -1;
+		child.in = pack_fd;
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = start_command(&child);
@@ -2460,7 +2462,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 	int ret;
 
 	if (!use_sideband)
-		return unpack(transaction, err_msg, &opts);
+		return unpack(transaction, 0, err_msg, &opts);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2470,7 +2472,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 		return 0;
 
 	opts.err_fd = muxer.in;
-	ret = unpack(transaction, err_msg, &opts);
+	ret = unpack(transaction, 0, err_msg, &opts);
 
 	finish_async(&muxer);
 	return ret;
-- 
2.55.0.424.g13c7afec21

