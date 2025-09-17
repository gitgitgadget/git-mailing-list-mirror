Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52E22ACEF
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071821; cv=none; b=qDvXaktfcfdT7CjvuyJbiqfCBE1XoFWYsTGglXqLodr4y+SCMpw4wW5a8z64WRK/IOiNEltOYWo6qicf4+VFWsta97LQ8j+iN1yO2tNSEcB8h1NUTkfWmpwz25NsQbrjMoba8p3ICIW6XTBdkYmfkI8oeNG4pISff6c/5RbyDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071821; c=relaxed/simple;
	bh=G9CF8riXs1GyckWT3w7xvdCd+ZFALJ/YzkgN72hPHqs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rqsIQ2RzX4kHwgVm5mCzNSA68s1TnU8pqfi1qbx8Ga1zeV9Jp+cxNOkWKQiFKatBWyJ0PNa6ZvEaUWnBmbr0iph8sFZF6aXDjg9OmXN9Fow5XXSKmPJaUyjU3BA6a9FIvIa5cSrnZq9LAgHyRYThpvQ3rq6yiuh2IYQRKKhRprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOnjASF0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOnjASF0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2680cf68265so1167155ad.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071819; x=1758676619; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwxQg85ZOuUnac/s/nD5tFFV2DasBpK/0KRo7jXprP8=;
        b=dOnjASF00htQ990w1Rf3qf4L7K7UThPOGueVy9SZwjDPmrwyyBJ5IGjCOH5ftS7ZeJ
         wXQAnUsW4kqH+/vxfy8iU5Bg2QQj1cDDIu/Bi8YhpMATYWoSSUkd99QFhGnSf+LAxrsK
         Ym2tV5tAYjFUg1Sc4hQlNbUIW7d1v6cv5CZfT8aK4XR+izHPZs7lQv+VdqBRr8NgzWJ2
         ApZaBQzDhmX4SMPx/dXAO3dbnzbfQ0DhtVhSXk3xwK8DNyTKXMdMiO/i/9DZ+Z0K47Gp
         5Bmuj83ksztpwA5iYe9OdOe9eIjzCG73TOImBnMzVSb0mKumefzJn2DhpuviJlgUy19E
         nLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071819; x=1758676619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwxQg85ZOuUnac/s/nD5tFFV2DasBpK/0KRo7jXprP8=;
        b=K1eL3R6wxIW/b8nQd9KIqxRAz3wRZ9LjyNi5/GaCu/Xp1QACfcsbsSYgk/8hSAa5QA
         b90oLvYSpnrGnNvGg0QQegJYVWgTYGaQCzTWymJ9n6kbYuVhT211aWsxIKV/8UQZE6eZ
         C1H2+kcuhFrsqgiasoyFNDIJX79roboG0FWpifqIWnou5AykFwr9WyaaD+TwrF+Eloki
         dUgBWtUC82zwpXB1IksGmJvqZPTME16JtuoFxmOKiom02xhJyrbsKqTHEKS5Y/kQEpG3
         S/1ERagmTS9ia6Tm2bNfeFQFM4pdtAYz6xwCz3ugpVP/AhztoVro1G4KR70pw6yB2tv+
         9llg==
X-Gm-Message-State: AOJu0Yx7uGpMEPAQSC9/3/tVUyLECla0eGbPSqC2wbLBMhp+gJACGtBe
	wihTBxmWya8jT/lSpFKDLldn0n/DgEva8eCgZD8HaKKLFB/Eku3MkjhnJzcLoA==
X-Gm-Gg: ASbGncsyVxT829aJb0s6fFDPJE3T/+vdVLLW+tOzSiegbqMK+dXzTFhxWHBj5qdZAK2
	TwIIcwGlnkcZntvdAeUdJgMYsZM3IK5vJ5tWSJv25v5FBi5e2BhGEFnu8sWgVnuC4EmeK4Rj6jY
	ykuzflGqFIL8Bdo4hGleBv/0Wau3kgo5eIj2wL8O+qL8IbszzJIj78wRPbtve9aAbbc0VrXZ1Jj
	H7fM2fF/mZFE50BD0AUBTMNn5k7rfuo1/Urd+Wg282C5bpAm3twGjq6cXFWhrEVU78m0zLKTYrq
	g4LR3RFj0zFp8R63GllAQszwbLEVci4NYzbPQfy7o3+ig0gwBumUbj8Vs4gRsPMGsVAMxdC6pXi
	xfWdP6wIaz1hAgDMn21ZRpdRcLdg=
X-Google-Smtp-Source: AGHT+IGvNNmAquaejB05gzfESsotNSsOj+tnTIg2uW6jCV+MFd1zbqnib3rWdNPH51nZUCEfuIS9bQ==
X-Received: by 2002:a17:903:3d06:b0:24c:be1f:c204 with SMTP id d9443c01a7336-26812191442mr3675625ad.22.1758071818899;
        Tue, 16 Sep 2025 18:16:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25d9c7e5b16sm141910815ad.87.2025.09.16.18.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:58 -0700 (PDT)
Message-Id: <df837fdb4d399be1218a9a39eab47a85fa44e8d3.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Patrick Steinhardt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:35 +0000
Subject: [PATCH v2 15/18] varint: use explicit width for integers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>

From: Patrick Steinhardt <ps@pks.im>

The varint subsystem currently uses implcit widths for integers. On the
one hand we use `uintmax_t` for the actual value. On the other hand, we
use `int` for the length of the encoded varint.

Both of these have known maximum vaules, as we only support at most 16
bytes when encoding varints. Thus, we know that we won't ever exceed
`uint64_t` for the actual value and `uint8_t` for the prefix length.

Refactor the code to use explicit widths. Besides making the logic
platform-independent, it also makes our life a bit easier in the next
commit, where we reimplement "varint.c" in Rust.

Suggested-by: Ezekiel Newren <ezekielnewren@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 dir.c        | 18 ++++++++++--------
 read-cache.c |  6 ++++--
 varint.c     |  6 +++---
 varint.h     |  4 ++--
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/dir.c b/dir.c
index dfb4d40103..b92a5d750e 100644
--- a/dir.c
+++ b/dir.c
@@ -3579,7 +3579,8 @@ static void write_one_dir(struct untracked_cache_dir *untracked,
 	struct stat_data stat_data;
 	struct strbuf *out = &wd->out;
 	unsigned char intbuf[16];
-	unsigned int intlen, value;
+	unsigned int value;
+	uint8_t intlen;
 	int i = wd->index++;
 
 	/*
@@ -3632,7 +3633,7 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	struct ondisk_untracked_cache *ouc;
 	struct write_data wd;
 	unsigned char varbuf[16];
-	int varint_len;
+	uint8_t varint_len;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
 	CALLOC_ARRAY(ouc, 1);
@@ -3738,7 +3739,7 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	struct untracked_cache_dir ud, *untracked;
 	const unsigned char *data = rd->data, *end = rd->end;
 	const unsigned char *eos;
-	unsigned int value;
+	uint64_t value;
 	int i;
 
 	memset(&ud, 0, sizeof(ud));
@@ -3830,7 +3831,8 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	struct read_data rd;
 	const unsigned char *next = data, *end = (const unsigned char *)data + sz;
 	const char *ident;
-	int ident_len;
+	uint64_t ident_len;
+	uint64_t varint_len;
 	ssize_t len;
 	const char *exclude_per_dir;
 	const unsigned hashsz = the_hash_algo->rawsz;
@@ -3867,8 +3869,8 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	if (next >= end)
 		goto done2;
 
-	len = decode_varint(&next);
-	if (next > end || len == 0)
+	varint_len = decode_varint(&next);
+	if (next > end || varint_len == 0)
 		goto done2;
 
 	rd.valid      = ewah_new();
@@ -3877,9 +3879,9 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	rd.data	      = next;
 	rd.end	      = end;
 	rd.index      = 0;
-	ALLOC_ARRAY(rd.ucd, len);
+	ALLOC_ARRAY(rd.ucd, varint_len);
 
-	if (read_one_dir(&uc->root, &rd) || rd.index != len)
+	if (read_one_dir(&uc->root, &rd) || rd.index != varint_len)
 		goto done;
 
 	next = rd.data;
diff --git a/read-cache.c b/read-cache.c
index 06ad74db22..41b44148b1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1807,7 +1807,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 
 	if (expand_name_field) {
 		const unsigned char *cp = (const unsigned char *)name;
-		size_t strip_len, previous_len;
+		uint64_t strip_len, previous_len;
 
 		/* If we're at the beginning of a block, ignore the previous name */
 		strip_len = decode_varint(&cp);
@@ -2655,8 +2655,10 @@ static int ce_write_entry(struct hashfile *f, struct cache_entry *ce,
 		hashwrite(f, ce->name, len);
 		hashwrite(f, padding, align_padding_size(size, len));
 	} else {
-		int common, to_remove, prefix_size;
+		int common, to_remove;
+		uint8_t prefix_size;
 		unsigned char to_remove_vi[16];
+
 		for (common = 0;
 		     (common < previous_name->len &&
 		      ce->name[common] &&
diff --git a/varint.c b/varint.c
index 409c4977a1..03cd54416b 100644
--- a/varint.c
+++ b/varint.c
@@ -1,11 +1,11 @@
 #include "git-compat-util.h"
 #include "varint.h"
 
-uintmax_t decode_varint(const unsigned char **bufp)
+uint64_t decode_varint(const unsigned char **bufp)
 {
 	const unsigned char *buf = *bufp;
 	unsigned char c = *buf++;
-	uintmax_t val = c & 127;
+	uint64_t val = c & 127;
 	while (c & 128) {
 		val += 1;
 		if (!val || MSB(val, 7))
@@ -17,7 +17,7 @@ uintmax_t decode_varint(const unsigned char **bufp)
 	return val;
 }
 
-int encode_varint(uintmax_t value, unsigned char *buf)
+uint8_t encode_varint(uint64_t value, unsigned char *buf)
 {
 	unsigned char varint[16];
 	unsigned pos = sizeof(varint) - 1;
diff --git a/varint.h b/varint.h
index f78bb0ca52..eb401935bd 100644
--- a/varint.h
+++ b/varint.h
@@ -1,7 +1,7 @@
 #ifndef VARINT_H
 #define VARINT_H
 
-int encode_varint(uintmax_t, unsigned char *);
-uintmax_t decode_varint(const unsigned char **);
+uint8_t encode_varint(uint64_t, unsigned char *);
+uint64_t decode_varint(const unsigned char **);
 
 #endif /* VARINT_H */
-- 
gitgitgadget

