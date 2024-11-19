Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6F1D04B9
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030628; cv=none; b=TS3S21XR0yGOnfHQEI8emQxXe+uO6lBoNYQX6Vs1ROu7bw1hxcTzhliosgzybcOmV08OV9bIXNp6m2Pjo5/Cf0AxZKRkaw8ZxYQX0yWRembQkeG8VtkHTMUCKBKaUQCpr7BGwgab9cDjSgn/fUH9lPdTB/w7AXMw+/LWc1/8KwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030628; c=relaxed/simple;
	bh=0Bk49L3zNr0ivHPQSUglzSBLCsWe699RCqd9yH/88sE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAJButhJaA7Sq92KGpGdbEis3Cq13hTwdC5IsDOHkbpcWkOitHbvpJMVDRU7Y/F6h90zNg3hU9X20GuPg4d/+eq/+LVwBV8vaM7VMYxGDTZtLxNM9+Xu50aau1RGCm6tKHb/ZWmfp8JqRuMqOtzjOHCnmryCSn/BtX6w5EFJ0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsKzSY8o; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsKzSY8o"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so1452429e87.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030624; x=1732635424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwG+HR2FAYkztAibkKtJ+EnXujqMAqHiNNdLjV8Qy4I=;
        b=LsKzSY8oqBUzf2BE8gjGDoQfaauzm2bpqVb2HX/AXzEQhsM1xV1mTUNm+T4A+GwTnz
         6rns8XWI7OFq25gEZkOvR/O+Hz+1aCiEWMw4X5tOpoKgz0r1dR/H3tfgjJHxEC6ujtbz
         Jyuh+uE0b4d42P91La8cjmYqtSAuHnfeVxsE48vwct9wKVsTmiAlT2uDbucmufDRn2DZ
         L3CkNDWiigoX7fndU8I6VB7IJcLm7Gbkl8CkjmgKH416r+6vx1kjPYWViw9mJCFf0EqZ
         25fFoUEnEKpzb6IyMAvqmlemo04/CAbfy6LX0+uSjEU0hcloTtDzZofLj/r3EI/7vOyU
         Jglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030624; x=1732635424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwG+HR2FAYkztAibkKtJ+EnXujqMAqHiNNdLjV8Qy4I=;
        b=C7i1wI6sSUlovFWVrJaK6/yM4Lr7Vj3OC4XaI/nPJN7xKtTzg4x8NA+8ozTnKdIkA8
         iqKiukcDL07o8Oc35V/f2OgNMgB5jlW34p1FyukX2UB2Os7+srrYiKCaFGEfIYfs9N0q
         8I8YG3j4+K79Y7GwG57FJ8VNxBxtfgd7Z2ll2yJX5D5aac8fGB5xaec5G2D8szQCnk9H
         kaacGa31TjIWSwYIdMr/3XFRCWUi0ev56y8u42H0gF3+pnhX3x3iqgKprE5ayOIaFq8b
         eAyggI7UmQ1S56mSePBbkev4NK+uy3Vi3l03mgb3ePrGyYGQS/b0cPF4GhEHMsMzQoj1
         RkkA==
X-Gm-Message-State: AOJu0Yy4s+kEvAvCO3N8uvoxeSJ6AB/nn8cCJwTfXtrgDky9iz/DCe3P
	Y0I6JdRfr3KIlV0pjQByP9KXuKiaNL+MBhSWSdDQ/nOksg9MK/Rj
X-Google-Smtp-Source: AGHT+IGyD6Sg2L6vILtDxv7UsW/1NT+LFcpsBtmZOkGcKul+Qxx3pINNVPyoaIm2DBJ1/Inp9UD4Iw==
X-Received: by 2002:a05:6512:1307:b0:539:f675:84d7 with SMTP id 2adb3069b0e04-53dab2a84bfmr9086851e87.32.1732030624327;
        Tue, 19 Nov 2024 07:37:04 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm661900566b.42.2024.11.19.07.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:37:03 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Nov 2024 16:36:46 +0100
Subject: [PATCH v2 07/10] midx: pass `repository` to
 `load_multi_pack_index`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-7-e2f607174efc@gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, shejialuo@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4558; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=0Bk49L3zNr0ivHPQSUglzSBLCsWe699RCqd9yH/88sE=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnPLCYKeWoKBiPgszYPpKsxSYFWr+xvoDbJYO7X
 O4oDGtV9g6JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzywmAAKCRA+1Z8kjkaM
 f6Z+C/93B9uuDZPo1JeQ1wkEpENigo/1hEmrPbKSol/+r5U3BSAyTkqQHVSw05zZaV2KKDjVRDu
 k3yokiTusK3+4J/PN2q+exw5YoNxY+axCoXO6WyAA4SMYd6Y3O8IEUUfo3YgC5PVznachEPXUQL
 h+hoeGR4UXeSBxiJDtE2gMQlIJzEiPe0DlD/KZosxOMhYrNUZ8qr7GTz3N9RZQq3VCRQ8d1iM0Z
 jQnMfZGaloFEadZAhzeFimPFmXOIDL79PzvdIxpIEXqAlaIWRmrkINiw/OGxs4aoJwcu7VBfANL
 zf4NfpBm4g2EowAnvc8Hcr3dlE3cHTD+RzyMF/z6PoNsnXJlq2Dfhe0bI6rxKF/hkM4FRKa4hqN
 yRbwpqkwaSMT8rAWP4MhvBKtfVltS1Z8GOAcx0XwzyUb7BQUC/RWVMdIAnIFdbiq/Rl4v88I7N+
 XDifhW2C1jVbd6Fn7iO4HkocoaumwqGoahwn5DPFtJHToZmMpNMt2FYQRdONwpYwnnP1A=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `load_multi_pack_index` function in midx uses `the_repository`
variable to access the `repository` struct. Modify the function and its
callee's to send the `repository` field.

This moves usage of `the_repository` to the `test-read-midx.c` file.
While that is not optimal, it is okay, since the upcoming commits will
slowly move the usage of `the_repository` up the layers and remove it
eventually.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx.c                    | 11 ++++++-----
 midx.h                    |  4 +++-
 t/helper/test-read-midx.c |  8 ++++----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/midx.c b/midx.c
index 6f0fb8285af14843da132ef1b0c3a8bdd06732c9..98ee84d4a8bf388906634ad695ff39acdaa2c6d5 100644
--- a/midx.c
+++ b/midx.c
@@ -372,7 +372,8 @@ static struct multi_pack_index *load_multi_pack_index_chain(struct repository *r
 	return m;
 }
 
-struct multi_pack_index *load_multi_pack_index(const char *object_dir,
+struct multi_pack_index *load_multi_pack_index(struct repository *r,
+					       const char *object_dir,
 					       int local)
 {
 	struct strbuf midx_name = STRBUF_INIT;
@@ -380,10 +381,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir,
 
 	get_midx_filename(&midx_name, object_dir);
 
-	m = load_multi_pack_index_one(the_repository, object_dir,
+	m = load_multi_pack_index_one(r, object_dir,
 				      midx_name.buf, local);
 	if (!m)
-		m = load_multi_pack_index_chain(the_repository, object_dir, local);
+		m = load_multi_pack_index_chain(r, object_dir, local);
 
 	strbuf_release(&midx_name);
 
@@ -727,7 +728,7 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 		if (!strcmp(object_dir, m_search->object_dir))
 			return 1;
 
-	m = load_multi_pack_index(object_dir, local);
+	m = load_multi_pack_index(r, object_dir, local);
 
 	if (m) {
 		struct multi_pack_index *mp = r->objects->multi_pack_index;
@@ -881,7 +882,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	struct pair_pos_vs_id *pairs = NULL;
 	uint32_t i;
 	struct progress *progress = NULL;
-	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	struct multi_pack_index *m = load_multi_pack_index(r, object_dir, 1);
 	struct multi_pack_index *curr;
 	verify_midx_error = 0;
 
diff --git a/midx.h b/midx.h
index c37ad5b5242b56d21fd76bd59957a1bdb82786ec..78efa28d35371795fa33c68660278182debb60ab 100644
--- a/midx.h
+++ b/midx.h
@@ -97,7 +97,9 @@ void get_midx_chain_filename(struct strbuf *buf, const char *object_dir);
 void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
 				 const unsigned char *hash, const char *ext);
 
-struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
+struct multi_pack_index *load_multi_pack_index(struct repository *r,
+					       const char *object_dir,
+					       int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
 				   uint32_t pack_int_id);
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 438fb9fc6197fc465f79d9a65b719ae315fed373..fc632369618917e2d8cdcb77bd9073c61e1544c1 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -18,7 +18,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 	struct multi_pack_index *m;
 
 	setup_git_directory();
-	m = load_multi_pack_index(object_dir, 1);
+	m = load_multi_pack_index(the_repository, object_dir, 1);
 
 	if (!m)
 		return 1;
@@ -82,7 +82,7 @@ static int read_midx_checksum(const char *object_dir)
 	struct multi_pack_index *m;
 
 	setup_git_directory();
-	m = load_multi_pack_index(object_dir, 1);
+	m = load_multi_pack_index(the_repository, object_dir, 1);
 	if (!m)
 		return 1;
 	printf("%s\n", hash_to_hex(get_midx_checksum(m)));
@@ -98,7 +98,7 @@ static int read_midx_preferred_pack(const char *object_dir)
 
 	setup_git_directory();
 
-	midx = load_multi_pack_index(object_dir, 1);
+	midx = load_multi_pack_index(the_repository, object_dir, 1);
 	if (!midx)
 		return 1;
 
@@ -121,7 +121,7 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 
 	setup_git_directory();
 
-	midx = load_multi_pack_index(object_dir, 1);
+	midx = load_multi_pack_index(the_repository, object_dir, 1);
 	if (!midx)
 		return 1;
 

-- 
2.47.0

