Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E343E275F
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787176401; cv=none; b=h+PpdDJTbqL3v84Aw4M42+GrezoavW3tSb3vjFCQJcQIVzHNWtY1jM4xBteis9wvU+S9jtzSOkTLzs++U/zvX+zU9YvgC1zsd2QxWd3XG7WGRCXUGAc625WL2fl22RMbYwC82nGlyDg2HzJOlCYAYZslBINGpPWfE2kNznmd1ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787176401; c=relaxed/simple;
	bh=mdZB7D9kOGGF60uk7ZSWYhL/XTX1DDOZg3/eZMtBBD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDrR2xq5X0WxV2a1EdAkZTHm7TacZV7CYXML8YrLKXMcNhNA6/lQohJv045HbPMK0CmUibsUS2rnN7Y2zq+Hl+ElDTdh59XEv7I5COiKtXNXvC+g9pQrIbJILYN8j1xErp9FdQN/oXLJWHyLcbsbxc+ZbeNwuiXgTkv1kIK/AnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZMGkSZL; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZMGkSZL"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f18c0e03e3so908857a34.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787176399; x=1787781199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XEpiN/PgbrSK3k5Row5H0tIA0GjrBj5Rwt4GEwE59E=;
        b=OZMGkSZL6gsYEjJCSuw5NUYee8UK+iUjWsdZAG21/em6HCHTaV1G+x02MqBZR+P7M9
         4oIbuIbF6UBOcJgCx8F5udbtiCvtGdNSkNUbkorBhHV1IZRsQFfxj6GOMEvFCtJ3Vz6e
         WTLFB0XvC0h6owXusqKka5hmSKtmcCaB2mJwf1ACQNTS310O82GhwjRkAHr8dyCb4pyJ
         lz0BwEPM1oidHmSFrWbGutGMAlIvh51vH8lWfbTpFGDm2xgmkPn3Xq8z/FLwbW/egxAt
         Y+SuXftaGXlWq6543zvXvWEDUHNfaoxiB3+Cjg0BLZLhaYBlpKOoP88fv4tDrd5JSx+D
         Vekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787176399; x=1787781199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3XEpiN/PgbrSK3k5Row5H0tIA0GjrBj5Rwt4GEwE59E=;
        b=fH2qfNUAHkqZ/hpo5VBnGjyAKz6khlk4b30mBRV7BTKl2W41UiLOVZoeyCG9uToTnW
         7xgG+yHS7hKMTDq2zIYuoNtmqR5mTSG4yKP2I4v3D52+1E9eH1L4R9JMLyaixM8gHirw
         6N2XTxDvW+ey11LbXoe2bcwun5veMgiHW0gMsBaEJ0PeBZ9jbGLn3VEGo8WoIKX6meKt
         2ZRWMn921asm25uQLAoqd4Ecv8XAYCwF11o/80IyCQ5XY52LKNw88NDovHOcvMV0ekuJ
         wujqs6Jzx8jSgIzjAQdfcnx6UI0SR0dUzyY2LwkZc9/fcrKplfeMjMLrpT4hQ3rDJlnr
         i0yA==
X-Gm-Message-State: AOJu0YzB3zoRH7tNe+urB1CRo9NAnjJ7ZMjpncKWg7GPGCHIYVtNvkBU
	q42MaQLxL0qKvzPIQwXFkb3+1V6GmMXLzCRvNmspcdOXHRQXKmGpcYz6kUlVPQ==
X-Gm-Gg: AR+sD11YBLRLbNc4IJlqxiaMOIr3wERH/fFxxiXx4tRRa+6D2+b9Wzj7J1mRbiWVoPQ
	ffMDdu+OECrr6zLExzCHhtkEV2hE5iRUnYVgHr4vPesasqcdZRDYM1rC/179p5a2qrShh9fVmtV
	eTlJwbGJ32J5YBTAanUzVM2R1f3GjpP12CuKJApF+FBAYZ8NcAkAT0cjK9IwxkCugCdgVw5g2XQ
	nLDYGzLbCKzhTeiGntbYM9C7NlbKa2DOnoA7qsWt/vBPWFObQj/UhVpaS5ec9PUvPgXqdJczdu6
	rO5fBc4AWoB3IxGqJt0Ymf84Ivv3QHbIQPo268DtHa52aYDafNWD2Y4x7hjRi1dMhEsRkd4HLEV
	+ojVwO09XnTq1kENm+3UnzU28gUWtQOCqaLmbh9HoEGD0yWlk48t/Y0XIkOQxrWmEooIYHIgmc3
	uIfrIJFWa2j+me2LR1IW5fslhkqUHty8qouEO5upcR32ZzXWqOhVwk7cVheG9y4Q7D1Sfd
X-Received: by 2002:a05:6830:601a:b0:7e6:ee1f:96f1 with SMTP id 46e09a7af769-7f43f90705emr8302218a34.5.1787176399083;
        Wed, 19 Aug 2026 14:53:19 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7029dsm2718026a34.2.2026.08.19.14.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:53:18 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 7/9] builtin/receive-pack: explicitly pass packfile fd
Date: Wed, 19 Aug 2026 16:53:09 -0500
Message-ID: <20260819215311.3880274-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260819215311.3880274-1-jltobler@gmail.com>
References: <20260811175415.2044235-1-jltobler@gmail.com>
 <20260819215311.3880274-1-jltobler@gmail.com>
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
index 6df872697b..b369466783 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2292,9 +2292,9 @@ static void read_push_options(struct packet_reader *reader,
 	}
 }
 
-static const char *parse_pack_header(struct pack_header *hdr)
+static const char *parse_pack_header(struct pack_header *hdr, int pack_fd)
 {
-	switch (read_pack_header(0, hdr)) {
+	switch (read_pack_header(pack_fd, hdr)) {
 	case PH_ERROR_EOF:
 		return "eof before pack header was fully read";
 
@@ -2340,8 +2340,8 @@ struct unpack_opts {
 	int quiet;
 };
 
-static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
-		  const struct unpack_opts *opts)
+static int unpack(struct odb_transaction *transaction, int pack_fd,
+		  struct strbuf *err_msg, const struct unpack_opts *opts)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2349,7 +2349,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 	struct child_process child = CHILD_PROCESS_INIT;
 	int err_fd = opts->err_fd;
 
-	hdr_err = parse_pack_header(&hdr);
+	hdr_err = parse_pack_header(&hdr, pack_fd);
 	if (hdr_err) {
 		if (err_fd > 0)
 			close(err_fd);
@@ -2376,6 +2376,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				     (uintmax_t)opts->max_input_size);
 		child.no_stdout = 1;
+		child.in = pack_fd;
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = run_command(&child);
@@ -2410,6 +2411,7 @@ static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
 				     (uintmax_t)opts->max_input_size);
 		child.out = -1;
+		child.in = pack_fd;
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = start_command(&child);
@@ -2461,7 +2463,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 	int ret;
 
 	if (!use_sideband)
-		return unpack(transaction, err_msg, &opts);
+		return unpack(transaction, 0, err_msg, &opts);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2471,7 +2473,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 		return 0;
 
 	opts.err_fd = muxer.in;
-	ret = unpack(transaction, err_msg, &opts);
+	ret = unpack(transaction, 0, err_msg, &opts);
 
 	finish_async(&muxer);
 	return ret;
-- 
2.55.0.424.g13c7afec21

