Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AACF31352D
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245855; cv=none; b=CvLBpyxOnKfIcYWzbjPUCJgzhhWiavaq4z2a7Sc+pXSdUHlpHx19sExZiJK6WcC3ZmVi80xs00mrYP/gNsnUFoXpMvlEj2SDycwwyjP/a5mFTBWdrQRzlZCQppjkZg1PgFTGOewSQ0Urk+ApTThUnhLkTmVqknoZ/FwbltyRjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245855; c=relaxed/simple;
	bh=6GUSFgO+7hucAShpBwoDV6vnUjGpwii8vmEzjFLwdSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=boRn1LNVcTM+pk02qByYwwNXcG+1zF4KsBYjF94tYKIOQxlYjN9I+auWd0KVgvr32cxAGnwZNQl0asdK7l7ImIW3diP46uHsgWHdHnraycNvtyUiS6IcOqMdXBN1MkudoB+oGCWBqw4/fmIYOFt2gmxbRCECZg6gfjFjakZIOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAdPpu91; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAdPpu91"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477563e28a3so2407915e9.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 00:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762245849; x=1762850649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMi0iY33PHqUGcSwBcblB83B3E7QigygIaZCIrrCM4k=;
        b=gAdPpu91Rb9um5xO57mbSWhweUITuZ+6k3fzxOUCaLyWMAMV7ClIGADiHGwYgLGDtY
         rzFXm8YFv8U3LmNE8Hsu1ZmuBAPUr/+pgXIZ0S7tNTEAC3P9ajgV+EiPKBkbjm7BUGd7
         NXtJXMlELpnzFUAvWWlFssAIemAonfA9YPSrLT0JVZjyNdeqWUroZdjdixAWEFL14ZNF
         KGPxWl5+gdo8Jy7Sd82ZUeqx9DOHskflRoXbcIl3pv3SfPbibFnDYMcYzGgGTqYMBXI7
         yG51ALgJ2tOP0a2WTsQ1JsqhX646docgM55HxgqRGXT5JLg1yQnpqGzHRtSzxIFQVF3W
         1d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245849; x=1762850649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMi0iY33PHqUGcSwBcblB83B3E7QigygIaZCIrrCM4k=;
        b=rA93UbfOxo1XoHhzWj6vZV30BLeB2xtJU5fYXJqlu6cXn74waA7npnUl/t+VeRq3qR
         k7Hyjy9p0VIBjvsIPWCyS6N2jAKBBTN8hD7WnCp85l2dNVlE8gNKQHqUFK7hfmcUe9hf
         Bbd/9d1NJx24Fen9auCJMKYby5laF6k87Gf39ca/jCcJOa/niZVg7e5mGPiuRwtFPK6I
         wrLR06l8NZ3BGz/JzPmIozyre12GmDjzn1vNPgpIP6GqJc865ULE96sumleA68xQDxSG
         1v5lzkRliGvsgOXt0YoO3QyuKiD0YS15K4sna53UZ6GIwHw35Xhctc/UzbgE2DNU6src
         RN6Q==
X-Gm-Message-State: AOJu0YxnHrj/mtwOtDvRMd07OI/ko4C2KhZ+jSTDb6l0xgpErOdMm1ge
	nHJ//ik9dw59N6x9oXZDe5AX75Zwd1RlNNVkOQVqVjevSoiIKst+Upk6
X-Gm-Gg: ASbGnctfuHiAFZLxnV0N0FhUGKuqso+eVk5lktLeRokhp/kwzubXsO0VYtS+oZXXyGC
	2QJomYPeCalaEezSoX0xO050I7ucU7kBaYVf+5OXzfUNN0+a4Ppopb4uTCJzoOEHnOISWz/lKvU
	50LkT7banpk70DNWdCpl+WRREawxjj/7YXDUMTLote+Ijt2NGkitDeFvc8lJ9egxegnYC/91K2i
	m729S00DHOM9+mtBH9tj0fyb9S+tOA3RPX/1a1dFwmYACAhZIOD1yPbcWkNrd4kmX0lVP7A2awQ
	xmJ0dEdB0fzbFFNpkIc+tA/w42LaMiH4wpV6ezttwXurRG/HOVT/kICy85Z41rLfccn9K8qXj6C
	nsmfLby9qGruAIf2sOoXmm8YXm+qL++YD+SjhLSTQ89evp3srvn075SHZI7vGrJTsrqX8wjeW5f
	iyDQ4w
X-Google-Smtp-Source: AGHT+IHE/ZhhpOUp654Vl0uJU1EZCp+Bl+n2ETyi8uiu6mYfIp0dLCPR9vqM1wRPqy/HolVjG6ndTA==
X-Received: by 2002:a05:600c:a58a:b0:471:ea1:a460 with SMTP id 5b1f17b1804b1-47754c49547mr11770405e9.11.1762245848220;
        Tue, 04 Nov 2025 00:44:08 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:b03:96aa:b9b4:f746:b8e9:7f4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773d81cb03sm193379035e9.13.2025.11.04.00.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:44:07 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 04 Nov 2025 09:43:57 +0100
Subject: [PATCH v2 2/5] reftable/stack: add function to check if
 optimization is required
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-2-303462a9e4ed@gmail.com>
References: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
In-Reply-To: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3577; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=6GUSFgO+7hucAShpBwoDV6vnUjGpwii8vmEzjFLwdSE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkJvNSoMzqKtm06I44ZfYFkxJfVCHOpdq9pD
 rLjqH3P9s+wJokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpCbzUAAoJED7VnySO
 Rox/EEkMAJGeMo7IzIGK7hpks9J5M8Q3Iz3VB/9OjOoTD/6yeAjWOcJKK1R2Iw6mbJmrgCcb1bY
 zY7bs0c31Yvb3qKs0oLi5SdPF99xIl3dFdKBourtAx/vqX2aCZaSnFIaJ2rRQ8JsQmI4jkkz4Pz
 isgKD7vdDVWHbxTfJOczvRkxy3wrpFSvjDsjcIzTfCBxc5I6sq7IWw4bqnR78QgkJ0IwHUP+N/3
 2jclw4gGVozKdCpp+HekUSsWE0iARnCORJtLopCbgyiIZnm/ZzeYv0FDKzcy+c5vABe2MQDwdri
 adB6dwPjnRDXnn0+Qv8tFLFj2s8moGc7Q8tsbMy+caCz4sWhpEcadCgmRZU/0eTc/RfXFfi752O
 OnjZlGKYaPZSjlTjkDe0wwyuT9zASxUzJkD9E8ap85tajiQcSDs/TDlpAq43Y/elK6xGHB13CVF
 hXKKkMt38UDtkEW2LsfFGptEihv3nbBRIvZ8NVMQGjepyLmCAe6MzTOiUJYkIHltpd67uSBR5e6
 WU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reftable backend performs auto-compaction as part of its regular
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
 reftable/reftable-stack.h       | 11 +++++++++++
 reftable/stack.c                | 25 +++++++++++++++++++++++++
 t/unit-tests/u-reftable-stack.c | 12 ++++++++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index d70fcb705d..c2415cbc6e 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -123,6 +123,17 @@ struct reftable_log_expiry_config {
 int reftable_stack_compact_all(struct reftable_stack *st,
 			       struct reftable_log_expiry_config *config);
 
+/*
+ * Check if compaction is required.
+ *
+ * When `use_heuristics` is false, check if all tables can be compacted to a
+ * single table. If true, use heuristics to determine if the tables need to be
+ * compacted to maintain geometric progression.
+ */
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

