Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE2E1C3780
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830906; cv=none; b=Dt5VfY7FRBWIT3TmZKlthfKJ9JUXkFxFfuuMChBBKvpQJDyuJnPqAzawIR3znWatVtftlH/woFTPLf0RadQdC8WWSXXLTZOWV5SSdA1eZ6UnQ+PlaDnUw0GSHp4wzKSZ8JhBs8sa3e1MXeL+nJH72rjWcceRHrQipUenXyfgsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830906; c=relaxed/simple;
	bh=AFFKBAJ5Q++FqG+OBgl0aHym6OgHA2PnBKd6KKwGxZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEfV7CbhlekXwfbXFx6DK60I9jrTgumqjdtGKbO8gjkW0hxu+BihJl7lDABCR7RRLGANa2kyx8m78wvsD2Vna8MzpGJTi/VHu8AtLXMgWRnxT1hFHV5q3RIKuUxyFOa+HXnw1G56oZLsoFBB55rKXv3BTcX4luDJjiGC9PEKbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyGTCxcI; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyGTCxcI"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso1704411a12.2
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830904; x=1724435704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jfhaCnbxJpZdGs0IIOV1vnMpU20Pn9A130jjmjoGBI=;
        b=UyGTCxcIjVu2QUk6pFI2olWsRtpD0JlKAOy/L8UlgTiqOODKC6QxE5+2sgZA9JDa/Y
         hrMrHMl+sWb2raxfuOWhbzaxY8PijTF8h0OOvnULYqEDB8o467H+RAS7lNk9F77djz2L
         m3thT5GrX2i8MuellQPOnJUl0ENE1isn/kricgjbUCqLOiBdfkzl9/E+HjHrq0mhdb+d
         Ca7fKu3IWCDflI1xVGL+pzuFd2XGhEjUQY2jrcW8CFrtFTNvKYeT576eTZ6duNQwO9qH
         M0ht4sS1XvFxi9rtn7mGdvUxLieHlrWk6pxsdUlQFNFx/GESCFWq9XWKq8M3uFAaiQL0
         NIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830904; x=1724435704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jfhaCnbxJpZdGs0IIOV1vnMpU20Pn9A130jjmjoGBI=;
        b=ZYUzbT19g9X01ZVZ8Phx0Yak+MIJqRCARHxtUr199S7ADqJJvbj+amPYj5ESWemf3s
         RZ1ktqAQZKJ3lB1j31TgXcvKKXVdrpRrcPOuZ3B6AZW45orki2ZX2Sxa8VQaYsfGP7T4
         CRp/p/i5YpWUBPvyTRXGTbKmmZ1WnHO6lY+a7BbnI7jyV0mubXNRk6J2O8gB3TMUJed/
         X6s4e4BJyinFSf93sJCrW81+vsAF4+dVXVIfYDBu+w0uDYlQFOKjyNaYMHxhsi8vRE+e
         cqHmpUf4Hrt7LXX1w2c4zGlK1+w91ID6CJADXfd3weY1rV+Bb8caG7Gp5og8/pot8FOh
         h6xw==
X-Gm-Message-State: AOJu0Ywgmml1nZmfmvQ+DGflEIqf587JaUu/cgxd5dZsa86G5fQUlTmn
	gqDo6qkvH1fh/Frlb4QXdhXxVez+F/IqLxdevh0IJmC6ZcgC5REgxOxnmQ==
X-Google-Smtp-Source: AGHT+IF+1/j6kKKCfKuYNk/k6x/DwHv3teVREp3JFrA+tfk5tdw3UTJZiY+BBi+H1KOI6eOGcidWIw==
X-Received: by 2002:a05:6a20:1b14:b0:1ca:a3aa:e5d9 with SMTP id adf61e73a8af0-1caa3aae5ffmr308362637.0.1723830903573;
        Fri, 16 Aug 2024 10:55:03 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:55:03 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 04/11] t-reftable-block: use reftable_record_equal() instead of check_str()
Date: Fri, 16 Aug 2024 22:55:27 +0530
Message-ID: <20240816175414.5169-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240816175414.5169-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-1-chandrapratap3519@gmail.com>
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

