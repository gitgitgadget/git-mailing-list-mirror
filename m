Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E299B18E34B
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244149; cv=none; b=unD4dh4g/xf9VMKHw76pOAwnt19zS6mBYdmsp73I48C371BYI1gzBYuYW3l3vuW8GE9juBJ4TJFX+XaHPmiNjmxv5CkB82xXxp7XxhFUnDPT3VQ/0Ut4cL86kiRZBdRkA5EdxBmyasufQ5oLDNdPVPEnjCUtIGQ3ndhWwlqe2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244149; c=relaxed/simple;
	bh=AFFKBAJ5Q++FqG+OBgl0aHym6OgHA2PnBKd6KKwGxZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScpOjzBYtAlZHgUZwkKcr+zK751fqfR/k63Jw5OnniilGWrkOgIxA8QIKCFLF8vOK/GbaxMGBvpka2eOSe82QAYNgu2KjUCq4bKdtWMonMtIzOUkM0KxcTbZYt8v75QRplVXiUs7LuNMb/rdELjfhb7dha4fpERoF1kSb55WtUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmoRcyja; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmoRcyja"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cd830e0711so663043a12.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244147; x=1724848947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jfhaCnbxJpZdGs0IIOV1vnMpU20Pn9A130jjmjoGBI=;
        b=QmoRcyjajRlUn/NfoCeT9LQYSGiHvumJa+ixkRkioxIQejju0gcQw9KozvpntenHkZ
         nBv7Rdx5cIumWSIEX2kWYQA71hMpjgLqRaNqvtCSfEbgJ+N9/9ZgO4VJvMnWWJLllMdU
         4WkMvxiMl6miIPI8DqbxJts5QrBf2wXU0Xhfe1tqLixJEQ5UxkQExJmrrdMsABE3hyYY
         yN6EWeFGKjX6RKXdrmQ6L26jhuUpMhoiXgLBsnRpz0kc/CZOGbL7iDz4QpgZfTH101gL
         xnqPl3soI0C+KB2baavTlfGR+2fyCOi48COJBcLAGmG8kEpSkJRi4v+EQGEKIvUA4qFH
         2Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244147; x=1724848947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jfhaCnbxJpZdGs0IIOV1vnMpU20Pn9A130jjmjoGBI=;
        b=pVFLEbcqQ3VRyRTUAwqu+QRaAKurbiUg8zPeMXDcmckcq0EHSh1E8qhy6xtR9uy4bq
         7qLI99ZibCakAu3Xx/E5wWLQaYjY3+fDgfc94Ma7tiO1R32XgDhqWDCpU/UezXGQnOSV
         wyZksDUgaiot91o4vbEBKf51NRG8HFiPjVUFV0mEOjuEHr0C+R3PxQYakjhqhMw0tvxK
         Lv42wpnP7oJkEbQn+aCXkvCCHVAQ+6jRV3v1Z2Ik/NQH5ypOiTzKt0eFhRWyvcJ0VxAn
         T4w7y77tqhaagic5GMVWKKUHl2VhPwNeKwPJFVJL+2S/ciEzdGtuyZ1eUfdYd0V8ztv+
         VseQ==
X-Gm-Message-State: AOJu0YxtCcrSzAIfF7vfEK4u23gaFSP2y4c1P0Cpk1BbxH43bAzkXTeC
	wLlYe/usfvVQ9DoN84V/kuznKoMnBs0Llihp1xbBB73aG1FQ56FoXf0HhiiS
X-Google-Smtp-Source: AGHT+IHT5Kl/az2IZyWSC0CVz0REh3UkDUMgJ7w2WU6KQ9LqIVGJu8EdNHzdS9OaJUdiS6it12SOMw==
X-Received: by 2002:a17:90b:33c5:b0:2c9:7343:71f1 with SMTP id 98e67ed59e1d1-2d5e9a419dbmr3624164a91.14.1724244146619;
        Wed, 21 Aug 2024 05:42:26 -0700 (PDT)
Received: from Ubuntu.. ([27.59.95.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5ebba8853sm1670963a91.56.2024.08.21.05.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:42:26 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 04/11] t-reftable-block: use reftable_record_equal() instead of check_str()
Date: Wed, 21 Aug 2024 18:00:54 +0530
Message-ID: <20240821124150.4463-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240821124150.4463-1-chandrapratap3519@gmail.com>
References: <20240816175414.5169-1-chandrapratap3519@gmail.com>
 <20240821124150.4463-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup, operations like read and write for
reftable blocks as defined by reftable/block.{c, h} are verified by
comparing only the keys of input and output reftable records. This is
not ideal because there can exist inequal reftable records with the
same key. Use the dedicated function for record comparison,
reftable_record_equal(), instead of key-based comparison.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index eafe1fdee9..b106d3c1e4 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -15,8 +15,8 @@ license that can be found in the LICENSE file or at
 static void t_block_read_write(void)
 {
 	const int header_off = 21; /* random */
-	char *names[30];
-	const size_t N = ARRAY_SIZE(names);
+	struct reftable_record recs[30];
+	const size_t N = ARRAY_SIZE(recs);
 	const size_t block_size = 1024;
 	struct reftable_block block = { 0 };
 	struct block_writer bw = {
@@ -47,11 +47,11 @@ static void t_block_read_write(void)
 		char name[100];
 		snprintf(name, sizeof(name), "branch%02"PRIuMAX, (uintmax_t)i);
 
-		rec.u.ref.refname = name;
+		rec.u.ref.refname = xstrdup(name);
 		rec.u.ref.value_type = REFTABLE_REF_VAL1;
 		memset(rec.u.ref.value.val1, i, GIT_SHA1_RAWSZ);
 
-		names[i] = xstrdup(name);
+		recs[i] = rec;
 		ret = block_writer_add(&bw, &rec);
 		rec.u.ref.refname = NULL;
 		rec.u.ref.value_type = REFTABLE_REF_DELETION;
@@ -74,7 +74,7 @@ static void t_block_read_write(void)
 			check_int(i, ==, N);
 			break;
 		}
-		check_str(names[j], rec.u.ref.refname);
+		check(reftable_record_equal(&recs[j], &rec, GIT_SHA1_RAWSZ));
 		j++;
 	}
 
@@ -84,7 +84,7 @@ static void t_block_read_write(void)
 	for (i = 0; i < N; i++) {
 		struct block_iter it = BLOCK_ITER_INIT;
 		strbuf_reset(&want);
-		strbuf_addstr(&want, names[i]);
+		strbuf_addstr(&want, recs[i].u.ref.refname);
 
 		ret = block_iter_seek_key(&it, &br, &want);
 		check_int(ret, ==, 0);
@@ -92,7 +92,7 @@ static void t_block_read_write(void)
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, ==, 0);
 
-		check_str(names[i], rec.u.ref.refname);
+		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
 
 		want.len--;
 		ret = block_iter_seek_key(&it, &br, &want);
@@ -100,7 +100,7 @@ static void t_block_read_write(void)
 
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, ==, 0);
-		check_str(names[10 * (i / 10)], rec.u.ref.refname);
+		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
 
 		block_iter_close(&it);
 	}
@@ -110,7 +110,7 @@ static void t_block_read_write(void)
 	reftable_block_done(&br.block);
 	strbuf_release(&want);
 	for (i = 0; i < N; i++)
-		reftable_free(names[i]);
+		reftable_record_release(&recs[i]);
 }
 
 int cmd_main(int argc, const char *argv[])
-- 
2.45.GIT

