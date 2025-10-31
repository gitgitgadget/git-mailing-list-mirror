Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6402E1743
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920549; cv=none; b=daRZD1ukBnOXJTNw/Nrd/g1Ewa86ipivGy57wgpz/32JdsAg2Tmo+hrXL1PaHkAu30Zymnng5Cpi62pHVmtzNoxozcvLkvL7YKqyO4mC/Jyr2EqvJiBNk7uDPugq+AwTjMoJDbdVzeyeKpWcfLsMODgj0aTOCw4K8zC+4ExvgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920549; c=relaxed/simple;
	bh=iq4PbT/DZeJnXs/D18iqqBMx/PzGzqCHrhQEgU4WQNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VRZXQDN8eeUQ1sHaBCiryHpBFwzcUE/iCV/9EdEqNkTBdC4qdw7hiZQS+yec8zrmEA6Ia9BZBuAKqN5dsXdsosbZrF1JkbLAvndjXhyadtNUdaMzkPkfYKv/TM78Bd/5ugn3bYm+hvnvBDv36D+/qoFiYcyZg1+PcY89yv5PGBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZG5AQaO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZG5AQaO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47710acf715so11954355e9.1
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761920545; x=1762525345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9BOAk7Y5htZA6WLGUI/p934y6pZ0yDljX9vvseljzI=;
        b=ZZG5AQaOskQ37PX3qVAiptcQaJUFDA8U/7X+N90frmGMzMIIjjFqkrOsWW1xdkc4Oe
         7hVP1apypQ3GUYOvFMOAApjZ0dXUpSrpTn9HvL2kl/E6OFGtTxwlKS3fLjc85UTsIbN3
         sk2XwOPK4OBtdaQTSkd40xi930IThcxHZmLk7lO4ehAtjsyr6f+aFYvkTALID9BigRWe
         ouZCXFhSZQP31cKbJPmetljoAEB9I9MoOWRWMJGjgoyiZmY3bPrEGD0e6i/HjOMv26TY
         i5g3ZUDblDXlCuHd6pNYod+PyvescBXJGFsFt8/EZru33hFh2KT4UlI+xc8naZU4+Fgv
         2NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920545; x=1762525345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9BOAk7Y5htZA6WLGUI/p934y6pZ0yDljX9vvseljzI=;
        b=Lcz/ESJ4bojpv1z5knkC+/nosj5FSitlRQ5dBQlmiKdDxy6hWhwRVegsm2SrqlY3mM
         mUEw+SRUCrUqkeNIatzIrh2JBnLD8P/Krn8Bbq9TJnTW2kg93hrqOOH3aKQ0ACNVIN44
         BJOZM1Ruj+NB6kKWER/iBv/6oATOQQtk2AFiFMN4bCJ+MnokASDzz17f4Log3jdGIaG0
         vxOofg3BreH3lzq+KDRS+bn5xvycUoZCmAaMUPbQdpVQob3s+yvs0IyzAQcdJxf4uoXW
         9S5RopW8DaCiSyani1NYzdmn5rhf+j5OecGEhPjL6gPDFtkVkhaTCEUKb01hGCe7DMt/
         c7NQ==
X-Gm-Message-State: AOJu0YzMNpyoRsBhFFVW8+AgMA4K+389yujOKPIKr1QPHeay9UnMp+Bt
	sPKn7xGuvewldMf3zJe0InkrLxKmdyXjMEf6rOqGSKzCBSMtQ8pJGYDVwEUuC8pM
X-Gm-Gg: ASbGncv25O/lnJ+OVv8mahJmcrOBVUjS86XKRprNOr6wloR6zuRCJ+CH61CMctRXudD
	hH6hVJZTgm6F8u24ERvIGNbKkbZGDq9hbfCxN84eB2jj+NU3SNP0hb/tSa5X8fVAwphj7V3OIb7
	r1q/0Vflrim2y1jA5X7CpAonquJ2GjqyxZDikf1/bWyw0NSKlsnVNQcwHTvMK7H8ZgernNbPnD3
	kWRhlepzk9uxGwPlyOhu7lSNPF4xU3DyxJ6LaX1+PYvGBm6Y+c1CzlBuyq5TD0hA04C001qnTrW
	ExtvRIs7CP3vCPSSgQTJ9Y+nXRnE7zbjbAh4ACc7il1412oe/x72cKI76Y0k09CVIe7kNgvWIO2
	5oULsLIrZ4A71cSG0AVWMEsDhhwACkPyOcMyr0TaaqhaLB4ntdL/sUnK51ZF+IsyPIpEhmkGSqR
	ugv5ex547z9LJwGw==
X-Google-Smtp-Source: AGHT+IG9eP/n6ebjE9S+fiRx8RadH8GehOiGnVd6lNOhBVDPQdAaT4NRyZu7pskDByqHa1AuBzQiNg==
X-Received: by 2002:a05:600c:820f:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-477308a07e5mr36316065e9.21.1761920545174;
        Fri, 31 Oct 2025 07:22:25 -0700 (PDT)
Received: from [127.0.0.2] ([213.61.187.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2eae9csm570435e9.1.2025.10.31.07.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:22:24 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 31 Oct 2025 15:22:22 +0100
Subject: [PATCH 2/5] reftable/stack: add function to check if optimization
 is required
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-2-a03d53e28d0e@gmail.com>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3349; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=iq4PbT/DZeJnXs/D18iqqBMx/PzGzqCHrhQEgU4WQNQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkExh6fhL0GRnVZpJuPS9VrpOhVMsBV5xDNu
 9nzT5eFbcidJIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpBMYeAAoJED7VnySO
 Rox/OloL/2IZ53qX61+GD0MC06dCleGm7vVu1jdj+2cpdXFR2bS+pxT8wRmnGvJYczMBejUKOc2
 uN/QN8B/sXdziZMzkFQrvMMDIdG8N3T++oWqdN7s1M3mqRe6E1Afl+l1DzCSVPlISkYthOtVcTy
 PFkQdhRCOpZAixNFIU32xGUPBt4DKM+eEAYO0DVFoILCINNMHdcGDkUN90FVOij2++/vUmWgIFK
 2+cILVlKRnxGl/cTT+erv577JsVxxr+jx5sdAc1ER5otQ8zycDn1hEIoaklH1Ar+tFDl5+apKpz
 iw2SiJXCDxxwQYKuNRsjCyO5Za+1cx3zHrigO0+9eIp1gRXS/LxwM6CA6L6C3mGv5/HJbPX39gX
 PgeQBNwdTGCnuCR2mi4uIVghc60nc6D7dOdZ00twcJYXxACXeVN8k2yQPRJslAP/7hXX9hAHBzU
 14VkD+Tpx/z1QU4gtIDuVjBSN+pjja3FaWAczj2zHAq7aVSiK13fQuXZyXZ2muWHpq4CQCYI0Q4
 aE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reftable backend, performs auto-compaction as part of its regular
flow, which is required to keep the number of tables part of a stack at
bay. This allows it to stay optimized.

Compaction can also be triggered voluntarily by the user via the 'git
pack-refs' or the 'git refs optimize' command. However, currently there
is no way for the user to check if optimization is required without
actually performing it.

Add and expose `reftable_stack_compaction_required()` which will allow
users to check if the reftable backend can be optimized.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/reftable-stack.h       |  5 +++++
 reftable/stack.c                | 25 +++++++++++++++++++++++++
 t/unit-tests/u-reftable-stack.c | 12 ++++++++++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index d70fcb705d..a875149439 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -123,6 +123,11 @@ struct reftable_log_expiry_config {
 int reftable_stack_compact_all(struct reftable_stack *st,
 			       struct reftable_log_expiry_config *config);
 
+/* Check if compaction is required. */
+int reftable_stack_compaction_required(struct reftable_stack *st,
+				       bool use_heuristics,
+				       bool *required);
+
 /* heuristically compact unbalanced table stack. */
 int reftable_stack_auto_compact(struct reftable_stack *st);
 
diff --git a/reftable/stack.c b/reftable/stack.c
index 49387f9344..18fa41cd5c 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1647,6 +1647,31 @@ static int stack_segments_for_compaction(struct reftable_stack *st,
 	return 0;
 }
 
+int reftable_stack_compaction_required(struct reftable_stack *st,
+				       bool use_heuristics,
+				       bool *required)
+{
+	struct segment seg;
+	int err = 0;
+
+	if (st->merged->tables_len < 2) {
+		*required = false;
+		return 0;
+	}
+
+	if (!use_heuristics) {
+		*required = true;
+		return 0;
+	}
+
+	err = stack_segments_for_compaction(st, &seg);
+	if (err)
+		return err;
+
+	*required = segment_size(&seg) > 0;
+	return 0;
+}
+
 int reftable_stack_auto_compact(struct reftable_stack *st)
 {
 	struct segment seg;
diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
index a8b91812e8..b8110cdeee 100644
--- a/t/unit-tests/u-reftable-stack.c
+++ b/t/unit-tests/u-reftable-stack.c
@@ -1067,6 +1067,7 @@ void test_reftable_stack__add_performs_auto_compaction(void)
 			.value_type = REFTABLE_REF_SYMREF,
 			.value.symref = (char *) "master",
 		};
+		bool required = false;
 		char buf[128];
 
 		/*
@@ -1087,10 +1088,17 @@ void test_reftable_stack__add_performs_auto_compaction(void)
 		 * auto compaction is disabled. When enabled, we should merge
 		 * all tables in the stack.
 		 */
-		if (i != n)
+		cl_assert_equal_i(reftable_stack_compaction_required(st, true, &required), 0);
+		if (i != n) {
 			cl_assert_equal_i(st->merged->tables_len, i + 1);
-		else
+			if (i < 1)
+				cl_assert_equal_b(required, false);
+			else
+				cl_assert_equal_b(required, true);
+		} else {
 			cl_assert_equal_i(st->merged->tables_len, 1);
+			cl_assert_equal_b(required, false);
+		}
 	}
 
 	reftable_stack_destroy(st);

-- 
2.51.0

