Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56967188CBC
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244160; cv=none; b=gUFw13oJ1aA0glTswi4H/CyI28QcwVQBDTXkLjPEehGInwZyWnZA9wVS/hRRt07WYMKXTpHeTsXZKxdMapgd4T53A7EpfWWdbOMtiVUJY1nlQQhoH8/gnQK87gItBlUDwS5nZSn+Ii/aIajPKINDbFC9w9HI3ae1CjgChxVVGao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244160; c=relaxed/simple;
	bh=fYVq6x6OTAxVrRyB9SNlLxuuV5rAOds4y2R7OPJDboE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSK9rzCknMsoyPQ0lNBR5IieHK22frcXPRIJj7Mtv84a5VW6491l9RBUWK/fm227bSDgVGNuMZasYcPYRKASM1YvCAOcw1EqVi1ShJlQKFfTnQJj3xW0ykE87yi+qUyb5bCawvqHWxz3rwb0p6IjhDUHcIV9E8uzFZindjZlyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH3cE/nA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH3cE/nA"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7141285db14so1239574b3a.1
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244158; x=1724848958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1usnlTgK4r1JKqKCnaxdmYmZV0LRBT8lm6vrlKlxjM=;
        b=MH3cE/nAIVkaGtU9Flk8uGSLPydvwfGFNeqmBVRGFUs+tAZmMenr6kcj3H0y8MgE98
         N3I82nPJRtM8ZobZlxUY+y2ArfAYg2Lh/VO8FdAsO/ALmsMl6Pa9EAi4ScD0hePL3Uvc
         jMvAwtxh6KSwRLsPAwcAx7hVYE6y3tW4GUu5YOYSmFJJeQKu0YpGSF9ioXOq/IaBmIjH
         OeL224welDTCof7vXH6/bFnzJKOcVBbOvT5/h1HQhIulHd2rnw5r5//Ovox6KeOfMQv2
         F6n0W11eR0H/PdyD+Y5qwDSNYxDaIAMkFwClX8IL57aVtP/Aux932hffQIucR8gem3hC
         utlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244158; x=1724848958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1usnlTgK4r1JKqKCnaxdmYmZV0LRBT8lm6vrlKlxjM=;
        b=Dlc4KzbJqcqOgsHlYOgCyqcTdQqlm7PQhpQJ8ikeU1mP2LctgyBFmz8cd/iimCFENi
         xOFsmB1sXjw0N9DgO9rf8/jeqVbwb0Zu1CWojnjBlHNfEFCYe0gkp/nvH77aiIx76Ydy
         e0ICWAsVDdD9Cv7OhPSaWjCpO8tsM4Q78AJUdTirRgXoz4PDJH+oQXGg2d2jwIf1vQX7
         8TTfFhNIPWxJhw3BWUSbUDh8BNabtAh64J0WXguuWtjk6tSKGL6TzBgIGT/8alI5YXOS
         DPUm6N2ykodYcxEN23fYVxWfYx6Ogi9C6vYqpVWahPKMZehRnRuXuoePYa0J3OlNSrmK
         9VFQ==
X-Gm-Message-State: AOJu0YyqNO30+Do8EajJ9U3xq1SJO/8Re4zeGRHnTpEHpqQrejvusACk
	l1aVRR037nm39yUoU5Rnh5qogMsmDA+BHnnlNtgQSTn/7Iywe0SG8RphAIj5
X-Google-Smtp-Source: AGHT+IH3dDZvLQyVmtWgOjyHSWJUchmKdBN6AoDnjcwiNTqPOTBAQFsEWo2BXKIEBDa+ac8+TFjtcw==
X-Received: by 2002:a05:6a20:9e4e:b0:1c4:b8a1:6d54 with SMTP id adf61e73a8af0-1cad8145eeamr2933582637.36.1724244158183;
        Wed, 21 Aug 2024 05:42:38 -0700 (PDT)
Received: from Ubuntu.. ([27.59.95.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5ebba8853sm1670963a91.56.2024.08.21.05.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:42:37 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 08/11] t-reftable-block: remove unnecessary variable 'j'
Date: Wed, 21 Aug 2024 18:00:58 +0530
Message-ID: <20240821124150.4463-9-chandrapratap3519@gmail.com>
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

Currently, there are two variables for array indices, 'i' and 'j'.
The variable 'j' is used only once and can be easily replaced with
'i'. Get rid of 'j' and replace its occurence with 'i'.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 81484bc646..6aa86a3edf 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -29,7 +29,6 @@ static void t_block_read_write(void)
 	int ret;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	size_t j = 0;
 	struct strbuf want = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
@@ -64,15 +63,14 @@ static void t_block_read_write(void)
 
 	block_iter_seek_start(&it, &br);
 
-	while (1) {
+	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, >=, 0);
 		if (ret > 0) {
 			check_int(i, ==, N);
 			break;
 		}
-		check(reftable_record_equal(&recs[j], &rec, GIT_SHA1_RAWSZ));
-		j++;
+		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
 	}
 
 	for (i = 0; i < N; i++) {
-- 
2.45.GIT

