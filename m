Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682993EA9A
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 04:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670984; cv=none; b=ivZMj3xdU5XmQdHjFhQmCV5XdwpPJNmpsDxp4gen5poBTemoGgyTIEwZ7xsZ//6eS+jv8mmePZ0W43BolFa5NRINOcvQXO6HBnJUQOxPyQziaz7/IdzMf+1Am2SgDAkNiT7YvveNh/x2tWZnMfgCDuIIlBOK2kDiaoYqyWEaQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670984; c=relaxed/simple;
	bh=z8R3TRpztrhJoG5bdL+rj059Xb77E1s5ds4ThX/46AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSzdleIWShySBMw4i6aQOmmCvTny19daOoLQjnYOC5au+AJfpzjNJoANfsLsAFW+IYnR3vFNGyo7ekM3J411+8m43RJTP2MtAqsdhHTc+Q56VCIOUfIhiw57hDuDZtkU+tdbzoGMHbvXvpMeSiLBgPIsN1ulRoF/8on4Xjxppdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQhKNUvG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQhKNUvG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb3cf78fcaso2634125ad.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 21:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720670981; x=1721275781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpjFXvjBf8E+SMnf3piFFJYNEyLRj9qrl2phkzKNLEU=;
        b=FQhKNUvG7udWlpgkCPWcB91WVknU9w65kpjKwY7qAyWGK44lZE/EYNEsEmANSKdqnb
         vUwDvriJRdl4TYg0+vux2DjU+Tcusd6K6AhO6WMewIIirC0q+E7rqybku7Ldcd3vpMqn
         8TWXGaJs69M9InNpAwcfk+Y6LtQ7YQEp15PnGUChNFnU/zqECr3MsoqtuneZmSiLHRWo
         vdnsdCum75SommLNwkrsnV0/tqeQz5LE1c4Ouvo1Aotp4jTLfNbu0UImz01FjEzgCMEQ
         OM1oMeIOfcTbcwtPoSHqjSwwIH6Ze5OFOxdHxde0yW5goyagaB+F/eTdD+L+JKTfGU2w
         CezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720670981; x=1721275781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpjFXvjBf8E+SMnf3piFFJYNEyLRj9qrl2phkzKNLEU=;
        b=KRS0WwbkNaL1dz4ZfpO1AGVsYX1W4Fm+7IhvLtWecQ18ekH7G2iCDLkstNZ3/j2jSZ
         F5tHgEb4eIYFIxlNQLKKvDbcPWurcuqlJLBUMrbUHy7sbBgV6HjeKjTsMOubdGwoFN5w
         pjmt5r6CZr7X9GcfKimnnXqHNQnQyLpfUPGDgTIGTHQlWBE5ro4gKelhRXVFv4QITcua
         k35yLwSAZJ5uHNCQrctIXjSQkNFUuaycv8+U4o3vv82Pw4rMKFUSgtKX5XjB6DwRqABo
         HtNmx2K+RKbeYcOfB2oEfo1swMak5K1Mz/Z62WV6dqz+XEVEVHQEWU5Y6lFCw52jOmCt
         NAdA==
X-Gm-Message-State: AOJu0Yy+4RrNQT3atozrDm4y2JdiOAclOhxG1kYTB619mJDH5MJeC1hw
	EQ82ZImwxsPwZpotiXcSG4NQ8kLJI1AcDSKbCb/WZk8o52C/jia0u569ZjDL
X-Google-Smtp-Source: AGHT+IFDUMC7PndNSBivwun5xW30AouCc16nRsYLH+wfcN9aT+s1f71jVgcEodYl3Th+A4Sf3YoQrw==
X-Received: by 2002:a17:902:d50e:b0:1fb:38c0:173d with SMTP id d9443c01a7336-1fbb6d5aac7mr69125315ad.39.1720670981320;
        Wed, 10 Jul 2024 21:09:41 -0700 (PDT)
Received: from Ubuntu.. ([106.206.206.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fbb6abf738sm40808595ad.198.2024.07.10.21.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 21:09:40 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v3 3/7] t-reftable-merged: improve the test t_merged_single_record()
Date: Thu, 11 Jul 2024 09:28:32 +0530
Message-ID: <20240711040854.4602-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240711040854.4602-1-chandrapratap3519@gmail.com>
References: <20240709053847.4453-1-chandrapratap3519@gmail.com>
 <20240711040854.4602-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In t-reftable-merged.c, the test t_merged_single_record() ensures
that a ref ('a') which occurs in only one of the records ('r2')
can be retrieved. Improve this test by adding another record 'r3'
to ensure that ref 'a' only occurs in 'r2' and that merged tables
don't simply read the last record.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index a984116619..85ebb96aaa 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -136,14 +136,19 @@ static void t_merged_single_record(void)
 		.update_index = 2,
 		.value_type = REFTABLE_REF_DELETION,
 	} };
+	struct reftable_ref_record r3[] = { {
+		.refname = (char *) "c",
+		.update_index = 3,
+		.value_type = REFTABLE_REF_DELETION,
+	} };
 
-	struct reftable_ref_record *refs[] = { r1, r2 };
-	int sizes[] = { 1, 1 };
-	struct strbuf bufs[2] = { STRBUF_INIT, STRBUF_INIT };
+	struct reftable_ref_record *refs[] = { r1, r2, r3 };
+	int sizes[] = { 1, 1, 1 };
+	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
 	struct reftable_block_source *bs = NULL;
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt =
-		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
+		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
 	struct reftable_ref_record ref = { 0 };
 	struct reftable_iterator it = { 0 };
 	int err;
@@ -157,7 +162,7 @@ static void t_merged_single_record(void)
 	check_int(ref.update_index, ==, 2);
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
-	readers_destroy(readers, 2);
+	readers_destroy(readers, 3);
 	reftable_merged_table_free(mt);
 	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
 		strbuf_release(&bufs[i]);
-- 
2.45.GIT

