Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E34D8AE
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725769103; cv=none; b=b2u0yxgiszISOFvQaxutwm0eBzUEt8SZQLR9Vsj5yzijpGZuC6dwvpPVP0gz1g04OofW/P+VTw1jPSCAr0ehl4dryQ6fXxZ2sUO2zSwJTyakfs1BLStYTmwBBjHypF6pSe4d+WmWjebntCXsXNrDVNNYtWWW3rmBlwva9bkljnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725769103; c=relaxed/simple;
	bh=tiMt8eQ9Wz/dZ4NqLnOpFeE7lFDBFWSkekVpry+AGsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUE+s3lQ15JgtlWPsRxMtYadPfNBtcH9ailybNSOL1invWMU/z9mp+r/uFNP6lGztf9qq4ehsyfMRDO2HgQ6/sCNHI2YkHpUODFFi6tC72PkQ1/ZLz/EaJ9TS6TDnmDWqjTxRWEandbTNTBCwPk7MB+4y515OFbLsLzlxmoRnnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eISM3dkG; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eISM3dkG"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e034fac53bso1017606b6e.3
        for <git@vger.kernel.org>; Sat, 07 Sep 2024 21:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725769100; x=1726373900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OO0eIpA11/USeXurWqLSkyt3PnVO+RdsJ8RPpz7mv8=;
        b=eISM3dkGBcIY0Ai1Qkk3HFPtak3CrTm4WTgDQJf9hYkM0szIRhTveMUJaHRV+lLh4A
         bZFjwUrXg9s/cwhCUaXpOCYCH6Egq0fZ84L609Byp482JThItJt0CRgAScO5o3mVoVdg
         n2bUZuBQlSme9URfi1YxDpmuTkItMpYQT8UF9GsnRASpR5QZ9rL1NC0+PwJ59F0aV6SC
         B4EMweE6BfLo0P3b0u3BU0RN9+unxEpy00WSzXm+rzt6GHXCeb7TSetfZXbK6iYdHBkB
         YMbMG7hR6liZp/blqDuLKk4zWY3zLEG7CMfxzq4FW5+1CLJax9xLG8e89bTJf3NMe0Qj
         2CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725769100; x=1726373900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OO0eIpA11/USeXurWqLSkyt3PnVO+RdsJ8RPpz7mv8=;
        b=jYOMHjrnlaAx0Ph8Zk9HzdBYVxSmi2fZCEtw+EwFSlzOr8duARNghopEtnn7eAoez7
         0fCBhEJgy1pQDhGRQlpxpAMT4MGVSASIf67s5Rp0ifpqWNzqmiZYEoyuOOaE0LmxG1v/
         Liw136M1Sf+xy1nVnjqj+7TihvWLgOa07PqndzPe8y1LNiotXkN3/C8caxl1d/6ytf9I
         /aqsu/bh3vee9bbqwwVEPdtlgLKyKS4YFPvPiE1GjYOITmqqnsXc2LYQw8WOMiNGW99T
         4dzszq8yaCvOgt1Vq53M90WJIGdPIXiWZPFjxqgKMh/+OPwMdYx4aFF1WIBKCxVJEfYO
         SFBQ==
X-Gm-Message-State: AOJu0Yx4JHqN2XO0b9V0VCLpuXwBOn4VQrYR/irOGzs0qvOaZMsW1Bw5
	nDYyCphQYxCi3vTE7N52BshPSmIDphFNSTiiiMfYiTiDADkytaXpdJh4/ztFNI8=
X-Google-Smtp-Source: AGHT+IFO2JTZ6Sb3do3NKyA3fJpPgEA31n9/fmZlWrQGgBwZmkdceldH5vS6spMnr+A4xXCHsEi+Hg==
X-Received: by 2002:a05:6870:15c5:b0:25d:8d4:68ab with SMTP id 586e51a60fabf-27b83027d4bmr9027120fac.40.1725769100402;
        Sat, 07 Sep 2024 21:18:20 -0700 (PDT)
Received: from Ubuntu.. ([27.59.86.31])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e596883csm1533253b3a.121.2024.09.07.21.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 21:18:19 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 5/6] t-reftable-stack: add test for non-default compaction factor
Date: Sun,  8 Sep 2024 09:36:00 +0530
Message-ID: <20240908041632.4948-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240908041632.4948-1-chandrapratap3519@gmail.com>
References: <20240906113746.8903-1-chandrapratap3519@gmail.com>
 <20240908041632.4948-1-chandrapratap3519@gmail.com>
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

