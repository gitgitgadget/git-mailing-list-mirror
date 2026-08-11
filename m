Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAA372B3B
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470874; cv=none; b=hHfJeHSd5g1sQ4fSMPKryoNeqDWtW+CFUfVsjDNuy/jsjk7kpY01LkPj3Y+lpXAipK6SggElKTi8B+ITO79C9prhxG8IDHeYqgtcyahi6+L9k9Lj5kmVlLzmVEEwZHFmsltUIcdEuq/kecJHmEs50f9OrWweA5sw+1JRiiq3fm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470874; c=relaxed/simple;
	bh=mdZB7D9kOGGF60uk7ZSWYhL/XTX1DDOZg3/eZMtBBD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQKmH2bmzDgcA3B4omA4Uh0Ll+2957IBbuFZhZIs+voYQ7nv0x4p258nKCoYpbCGOa1531i8owcxpHp0/9iOJJhhUcYvaSK0O6DJudWv5bsyKAs60tTypWHF/GG6gfERbCeseIgA+14THVjtYTAroGn/fpIbUwOhg/G5GKr6V2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c44XZ9HL; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c44XZ9HL"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4ab70b882c5so88323b6e.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470871; x=1787075671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XEpiN/PgbrSK3k5Row5H0tIA0GjrBj5Rwt4GEwE59E=;
        b=c44XZ9HLOGHsI9NKK+V9pYHwPo5/ZtujaBov3w8DsxlXFrC+relWxrWskQDUDltqLj
         8sfUsnMkbY8yarU8XCCasHawMtyeeEaUBrlgCCU8FoGiu12VtMH+Lk/s99zLHx+NDxYD
         XNTyGMTDoqdGja5jfUVkg06bioJjPQe9nKmgCc+4qDKKMSlC8VIsIdWnO1ZeGePCC4sk
         QL9N9nJhDz1WLuydl/VssNoC0DW3EK3s3jgzj34av5mwjIN/aMudbD42HpVXRwTksi3y
         Ut9CFcevqHD/WAipDTzrxSa3NcZmlMtHBtxQD1viAu8kWzXRygzog9Oxkx/aZXHamBgI
         mESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470871; x=1787075671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3XEpiN/PgbrSK3k5Row5H0tIA0GjrBj5Rwt4GEwE59E=;
        b=cHeKbJoYA3GqG1rQkRev7bgTnFbHwTACAGV6VYKLGBDS2uP1OvFoqMj+jdKw+OR0nA
         QKOXWFo322XeocF3J9wctgjJtXS/K7fwcxg6/XvRdT4xEh+x3IisPyURHiMwNt2HrXW9
         JMhyudhK7CoLoMSHWajNwdRFpR+ZW/WGv6zjk5MEpdqIfFnj3eh+ngBrewoSUNnFOb1N
         /X5WrUll81qgk0OKYESBUpkVu8PiS57OrueAdB4HjGGlzGI48zueUAErJNcahT1HWBRT
         MCpjJKAMaP+gSQT+7mBn1wzj8zb+rX64QPGO55LOSMIkkEh/A5gjFb6OCaJiLLIN4GMP
         tzWA==
X-Gm-Message-State: AOJu0YzCRDjhnF3U+G8YUHp2xcWlLjg+Uf7fUrfT3EMzYlDv0gWfY8ZV
	Tq59VUfEfEU/eHEfGERblFebi8CUUPzOOSINcvhu2r58/8tsSD+c3tAUK8DOig==
X-Gm-Gg: AR+sD10zkDqISbD0fcWP3PCJrdfFmfGdNtU6IPDBdaUXjPuna1RcrR6WaBuutS+Y15k
	Dx/JjPW70IjaDQkl4ZwwnSzl9wceHKJboDJe7+Gs8MRUvhgyGsnyPfzwWnxrskQCr426tCjyqsT
	FT/FG1hkX2/slPXVMSPUD4ayu5wygJbv19DiumCg50gWFIid8JVFldCenswp/flX81vMB+hfUIA
	V6kgwIwUlmYFowqYa2k5sUwn1D+X4/1HKGdy48IDrgCGZdb/6HkSnQ3WyIdzEJUCGem1Ha3kv9D
	wUZwCGVTzT0xHnY08NbzDKF7iExYO/Cy1TKy0t0KkhPOcABHDmTFyVrpSWtCRL674g16BSriFKs
	Q2vrVRetjN2g4JTsN49b/24nTSCczpD5Q8LJ3X1uUbVPtXNtFmikXJ6ilXUTHErtjlI09Ve5Ib5
	OIHxK30jnD2jCUTOmWU6RQWlbrF0na9gY5Gc0K3ZGN/JrUI7WCW3/XAQu/0Au3nuo/gcft
X-Received: by 2002:a05:6808:221c:b0:490:315d:e0d5 with SMTP id 5614622812f47-4b1fd8bbe19mr4274407b6e.16.1786470870960;
        Tue, 11 Aug 2026 10:54:30 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2001331d2sm1241489b6e.11.2026.08.11.10.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:54:30 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 7/9] builtin/receive-pack: explicitly pass packfile fd
Date: Tue, 11 Aug 2026 12:54:13 -0500
Message-ID: <20260811175415.2044235-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260811175415.2044235-1-jltobler@gmail.com>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
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

