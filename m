Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2A1CA6AA
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623115; cv=none; b=c5YP6bTbubYbl+hP1Q8poXBye+s3yARYsluBz1sYjrY8eBfzFh9SZ8wdWWyVNF/Tj/tZTCb2UlyfhwXz0yZ45ApFj7t+tQbMAj1i0RDmCMpaYxamu+g23UkKoQjU8EsZxcdCXtBSzw4QURi6YTL2nzK24hSC+1SoUOgtUiHIuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623115; c=relaxed/simple;
	bh=tiMt8eQ9Wz/dZ4NqLnOpFeE7lFDBFWSkekVpry+AGsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptkoD4eS8mgeikDgBRlDb5k0+tBHm6bnAS/lBqgUTFvf7EamsVtMUVfarGxzpvAC2e5+IpzBv474ti1VrwsEzTC3fEHGfhQmTWNbaBrr/1LICNSet9/1mVlOuVoKelYesC2ghbzPCk5BfQJeLUZ2uFKgB7pjROuPDHkUsdQPwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8cnZ/9i; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8cnZ/9i"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20551e2f1f8so18873375ad.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 04:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725623113; x=1726227913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OO0eIpA11/USeXurWqLSkyt3PnVO+RdsJ8RPpz7mv8=;
        b=K8cnZ/9iMIYWzaO74UzkimDxT8pdN3YKoxrALZi8hMPnnGjVgtFDLZW9V7cEpgTnXJ
         5IJOeOnp9/uiF3VL7Ebzz1dw5tcXldesXCDVucsN/VkiYSoGiPEYYO29GgQZ7LcjPyOx
         rCcqchg4et/WHsS0VTqq9bxRmdamYkGrWdwdslERNnG5+YwfAcDy8INTen5De6d4DWP/
         hrGwOJJ8Gbdu6zZtoQctV2MncDfRK6mR4gvM/9kYVroCTClE+1b7wF8BcS8W9hkn37g3
         +GkNj1CFnRY6oYgOnPgGkRsWEtEfjM/R7F50xFQ3xcAxvPFY5WQ1vY0YLydeB+yOGNQ7
         rE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623113; x=1726227913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OO0eIpA11/USeXurWqLSkyt3PnVO+RdsJ8RPpz7mv8=;
        b=dhrED6GPEZX3o5NUfE6lubFTG3W0ZvB02b8cJKUZmSU1Ad8UYGmrxoq0pJekbtm5yM
         B9XE+OxJ64+ZkxPvjy3Ig9RozwUUZ4d59GyNDXE4I7tg9gs7HFAlFy12zDUABWN1sQ0/
         lHQZBWNApxDE3DadQ7GNfb3qMGwlIJMSF71voMQcBHidZ/bP9toP6o1yccxvLxsLoe7l
         KTgmjTiSOTt+17gLOWotVBlUm93eygJ0MVk97mCGs95AbF+RXRJqs03l6KmDFhgs4Yjm
         2HPQWfTwjm0F39FM2IVHBn+VAPEApnNOLY3FHuIX0QjZ4Ec86wXmaYKho091GH+EIxJf
         ps8w==
X-Gm-Message-State: AOJu0YyBgaAx7xY6ktojmQfmdT5Jc+eziAS9tLddzAEORjET5VQ7K5mj
	abcjGvV2I/qcuJ/jVhCEPGRLWUsiR22/GbhZVd9Dq8txs+WsbwFNj1+ct7q3
X-Google-Smtp-Source: AGHT+IHH3xu0C54h2xlwLvOlgxQjPi4A6xINkF8IsJsen15RaF7bmmJU4/LpT84WwOwQ3/04cf3Fkg==
X-Received: by 2002:a17:902:ec83:b0:1fd:5fa0:e98f with SMTP id d9443c01a7336-206f05afd8fmr24373225ad.44.1725623112934;
        Fri, 06 Sep 2024 04:45:12 -0700 (PDT)
Received: from Ubuntu.. ([106.221.74.130])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae91371bsm41903685ad.26.2024.09.06.04.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:45:12 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 5/7] t-reftable-stack: add test for non-default compaction factor
Date: Fri,  6 Sep 2024 16:59:14 +0530
Message-ID: <20240906113746.8903-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240906113746.8903-1-chandrapratap3519@gmail.com>
References: <20240904150132.11567-1-chandrapratap3519@gmail.com>
 <20240906113746.8903-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a recent codebase update (commit ae8e378430, merge branch
'ps/reftable-write-options', 2024/05/13) the geometric factor used
in auto-compaction of reftable tables was made configurable. Add
a test to verify the functionality introduced by this update.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 41 +++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 4f2ef1a8cc..4acf07ab0c 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -831,12 +831,12 @@ static void t_empty_add(void)
 	reftable_stack_destroy(st2);
 }
 
-static int fastlog2(uint64_t sz)
+static int fastlogN(uint64_t sz, uint64_t N)
 {
 	int l = 0;
 	if (sz == 0)
 		return 0;
-	for (; sz; sz /= 2)
+	for (; sz; sz /= N)
 		l++;
 	return l - 1;
 }
@@ -869,11 +869,43 @@ static void t_reftable_stack_auto_compaction(void)
 
 		err = reftable_stack_auto_compact(st);
 		check(!err);
-		check(i < 3 || st->merged->readers_len < 2 * fastlog2(i));
+		check(i < 2 || st->merged->readers_len < 2 * fastlogN(i, 2));
 	}
 
 	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
-	       (uint64_t)(N * fastlog2(N)));
+	       (uint64_t)(N * fastlogN(N, 2)));
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
+static void t_reftable_stack_auto_compaction_factor(void)
+{
+	struct reftable_write_options opts = {
+		.auto_compaction_factor = 5,
+	};
+	struct reftable_stack *st = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+	int err;
+	size_t N = 100;
+
+	err = reftable_new_stack(&st, dir, &opts);
+	check(!err);
+
+	for (size_t i = 0; i < N; i++) {
+		char name[20];
+		struct reftable_ref_record ref = {
+			.refname = name,
+			.update_index = reftable_stack_next_update_index(st),
+			.value_type = REFTABLE_REF_VAL1,
+		};
+		xsnprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
+
+		err = reftable_stack_add(st, &write_test_ref, &ref);
+		check(!err);
+
+		check(i < 5 || st->merged->readers_len < 5 * fastlogN(i, 5));
+	}
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
@@ -1186,6 +1218,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	TEST(t_reftable_stack_add_one(), "add a single ref record to stack");
 	TEST(t_reftable_stack_add_performs_auto_compaction(), "addition to stack triggers auto-compaction");
 	TEST(t_reftable_stack_auto_compaction(), "stack must form geometric sequence after compaction");
+	TEST(t_reftable_stack_auto_compaction_factor(), "auto-compaction with non-default geometric factor");
 	TEST(t_reftable_stack_auto_compaction_fails_gracefully(), "failure on auto-compaction");
 	TEST(t_reftable_stack_auto_compaction_with_locked_tables(), "auto compaction with locked tables");
 	TEST(t_reftable_stack_compaction_concurrent(), "compaction with concurrent stack");
-- 
2.45.GIT

