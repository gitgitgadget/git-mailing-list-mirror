Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C771D88D5
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462132; cv=none; b=m1S6sp+oOV0stvMX/nXGGRLC1n0X/QegXMme6PWf5KCDPazM3kwB5JAbfunFcP2hS1GI5hFtEmpD0AV+5k+olAL4d/HVo1HZYXP4hbS0+sVIpi4cHtNP0EdgsqmhYWWd/BPDa20R4ItMTn87yo8RCiSk/rP7YjpzfuM+Mixcxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462132; c=relaxed/simple;
	bh=tiMt8eQ9Wz/dZ4NqLnOpFeE7lFDBFWSkekVpry+AGsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUc6tTvptSPig8LIURhuBI/0rXYRR9cMtXj4RJZLrGYRfgnOc66fBhlafnzU/0Gswhjfpw36KpZZPjDovIlmQCg0Y34xnYINW5VjubG042uewHArc6/fuL8jCKoI1OeohGpEQoEgLm7hOaREJ0DRo8teQiL9wINHHfiQYcG2t+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzgExYNq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzgExYNq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2053f6b8201so34649215ad.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462129; x=1726066929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OO0eIpA11/USeXurWqLSkyt3PnVO+RdsJ8RPpz7mv8=;
        b=YzgExYNqnoNCO5D7/MCW+HbOcuIiDCA5CQTP2Gga8KrnT6JDed3k6qth+Ws77Enb0F
         1kdmmvTxPRQrmyAJavEI3CKNZIWznNmQZiyxFvLyBZ8BrORsq5oO+sdfBWLL+nN9SgEF
         vu2rq9K9/QUJJNCGKn1ZkmrVEBAu2kiTA+ITWQCMABVJsfUxBFs4XZwtY65zXCjSgIhN
         NAWtwRN9mBVeToE9U7JoB+d/Tym6e5hN6yLhvoaK3rVn1rt5igcKFW04wNoe9t8A9VDn
         0nbue9alxnGK5QRve2TISY1RTRvri5NOyBITRneCM8CJ+G9vCDaYZDa1ifBpvg5p3a1W
         SeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462129; x=1726066929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OO0eIpA11/USeXurWqLSkyt3PnVO+RdsJ8RPpz7mv8=;
        b=lxynj1H1jvME4u2smfPv/IE2JRGShomxNfPSVlpSaBU+i8vCNdMO28zrWxwtyYsm9y
         sBi9ltlKg2zC0Z85lrS+5l4yqbiQPicPKFYDkEHX5xLoqgjXAVMpYITevFQ0gE8ioGBg
         zKKyrhVbiC5DrT3O3kjy6VB5E0996db8phPfqvPHNV/tZ8z1t+dXlPOURiuZBdXP3nmX
         kOk2Ayzmvjb3PBiPtXAheGugD0q0xPeAWwLJJBqUhkLIlz6rnoBif8/jIO5HVPNERFad
         r4alQeJ4D/07EFjt5V79MWYLRuaQM3X+2StUyrAEB9LpjCgQwkTFmxlT7/Btc2TMvj2J
         FNyQ==
X-Gm-Message-State: AOJu0YwkRBuZyLtfeGqLKCDTBw5mDo3GcvcTPrEFyWAciS0JGhkjrQgN
	zCoqawBhyzt4ESX9L2D5oqS23rMfHsZPLOU2moETRHQm8WueBx7HsGq5s2l5
X-Google-Smtp-Source: AGHT+IFCGkurI6t+DL4+g0dnzA85Eqxq947ZvFnwvAAmbRXPMt3d0B7tvdSWGRSf7w6WfWnzkO4qug==
X-Received: by 2002:a17:902:e550:b0:1fa:9c04:946a with SMTP id d9443c01a7336-20545e44a65mr212874075ad.1.1725462128712;
        Wed, 04 Sep 2024 08:02:08 -0700 (PDT)
Received: from Ubuntu.. ([106.194.60.213])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206aea65fe6sm14549395ad.257.2024.09.04.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:02:08 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 5/6] t-reftable-stack: add test for non-default compaction factor
Date: Wed,  4 Sep 2024 20:08:05 +0530
Message-ID: <20240904150132.11567-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240904150132.11567-1-chandrapratap3519@gmail.com>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com>
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

