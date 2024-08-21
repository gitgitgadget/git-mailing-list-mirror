Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3619994D
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244155; cv=none; b=HdIqVHny/WoVHA4Vb2Cz0VobtVjtz5rVYiV1L+eG1JRntjckCNREXiR7PvdypS5bMBSq4O8mOwP5eH3Xy99lYRpaaA9hzIe82fsNDlw85jTQdKxWJAeT607XayBBNdNHuLBdibIlzOwBzpg45b8F2Y9Jym7R00heWClENbPkuwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244155; c=relaxed/simple;
	bh=PsOooERAZjZyHL3/j9gPbuqa1tYlDESA7VjO0KeY37k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEOK0hC3QO/r8yInRwpOyklLD28FfbychC+DP8WbYXjL5Aig9/x1wPjAnmgvvSWYBUzyAgBbNE5PBa5jnqfIWvr/WgqnPII1KHfDAX0fKabsCVGI+tI6Xy9DGndXOyyl9NURDVwUNJThQFDJjcwF2Pl0CN+dr7KFVScRWc0RWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzHLQoa4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzHLQoa4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3b595c18dso545966a91.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244152; x=1724848952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMJHWmO4DYLCJNkhQovtJqi+UPTsbUpUjWKqfJ2dsAM=;
        b=mzHLQoa4yYTDui4y+7PgJUyaFzjYu25Ah2VJ2TobKRHgoRddXl+aHdlrVdRoWwhB6G
         93J6waHsPUZUgKvVqQ44gxP2oZ0NJuye8sKxXHFHI7VIa5w3eu8MPFFLjGmxDJFjkJjR
         7V+EIcaRJpgeUh6XQO/lXTJTN36xO5DbclBfnTSEnv55UdSjqCoNUh1nhqZ0xVP2YNOL
         oOaISGkiLl45IxNuZZ92L00XIB6HpTkkUeZzcCsYUViHOuC8McbjPoppzXDHc8/ZbHsu
         Mp9mY0zHEYoWzKmeSN8jzmCNnVlhHo4C4LL6+68MfG13HPfNZ3KylCmNR+YqtSL6KBJJ
         n1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244152; x=1724848952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMJHWmO4DYLCJNkhQovtJqi+UPTsbUpUjWKqfJ2dsAM=;
        b=n4naJ6PKIbDlRyhJWqD5Xx4BmuZsn2+uQ0uqe47KREGHBuJUBBFHEQReKMjKEp0fzz
         k1Ba/0aagfVXBRR+Wqy3SsOxwGNrGNHNgoQlg6WZH6GDrlv6M8n7Rq98YFXoYP/DU1V5
         ollisD5My2FXAm9A1VP7zuqt9J85e5TyUMcc6+vWF9teE2DH38FYT7s+i8FYlgyqcJmG
         u6zDHyuH12wXPxTfPbHgA3utdd/e++hBNfIufpdW1pYU6vvBURgHXW51eF0wszVuklEJ
         l6Po2yrVQHIW86M+QV9jaAJkAHZ0WWAuEXPp2+D3gTCXxkgesM9RmmdeUE7ewoqv5v4Z
         vovg==
X-Gm-Message-State: AOJu0YxB7d+TJ4Km3OhlhtpOsuoEE8HnMoC4NzWBt5nD6amNPvJtIxzT
	mRYWlQhbbXDIOGIMM92vwuqw8wnKG5vH1+4Iy2Rm73vbOnKDS8Aczy44sUls
X-Google-Smtp-Source: AGHT+IHXpcgPfZT9CTt7mPR65Ju6SnltKcRsjxH4zLyg4q4YrkROPOSjwLTjxBfkmivxGwAF9Gnr4A==
X-Received: by 2002:a17:90a:70c1:b0:2c8:4250:66a1 with SMTP id 98e67ed59e1d1-2d5e995c991mr3863006a91.3.1724244152415;
        Wed, 21 Aug 2024 05:42:32 -0700 (PDT)
Received: from Ubuntu.. ([27.59.95.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5ebba8853sm1670963a91.56.2024.08.21.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:42:31 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 06/11] t-reftable-block: use block_iter_reset() instead of block_iter_close()
Date: Wed, 21 Aug 2024 18:00:56 +0530
Message-ID: <20240821124150.4463-7-chandrapratap3519@gmail.com>
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

block_iter_reset() restores a block iterator to its state at the time
of initialization without freeing any memory while block_iter_close()
deallocates the memory for the iterator.

In the current testing setup, a block iterator is allocated and
deallocated for every iteration of a loop, which hurts performance.
Improve upon this by using block_iter_reset() at the start of each
iteration instead. This has the added benifit of testing
block_iter_reset(), which currently remains untested.

Similarly, remove reftable_record_release() for a reftable record
that is still in use.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 5887e9205d..ad3d128ea7 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -78,11 +78,8 @@ static void t_block_read_write(void)
 		j++;
 	}
 
-	reftable_record_release(&rec);
-	block_iter_close(&it);
-
 	for (i = 0; i < N; i++) {
-		struct block_iter it = BLOCK_ITER_INIT;
+		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
 		ret = block_iter_seek_key(&it, &br, &want);
@@ -100,11 +97,10 @@ static void t_block_read_write(void)
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, ==, 0);
 		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
-
-		block_iter_close(&it);
 	}
 
 	block_reader_release(&br);
+	block_iter_close(&it);
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
 	strbuf_release(&want);
-- 
2.45.GIT

