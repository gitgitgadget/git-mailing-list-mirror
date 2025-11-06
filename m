Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CDA3009E2
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417361; cv=none; b=fy0gAtNEfIPqs8xHJ2mBlCUkixOcm9/ESp2LWRSgLrYqmxyLlnoZj8G8qT+g/P2v0aD1IqEEhzITqPrUr3EswpZ/cgSNMlOiuzccM7LWhdklE4+ecLJmc1IwaA0ws00QsnJmZ7r//yIexv2BjsoreVdxuA5ASZqo/GNPdV1ZSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417361; c=relaxed/simple;
	bh=mBuIcObFMa5/g0tjuhQgrYMN6PxpIPFwcu+OcrXeJBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sd+z/ANKPGasb9ZSOen9w9YroOC2KB1yK6jhfA/sBEPGmww3q+uPkfzhWZAzKneK2vkzxV8U5S9tnKc1SyqpK8iFyo5BYHKmXtxtkP9q2IZaNHBAHj8rfQAHfYkkOL2zTlvZrXBPQUqvpnawyYajAaoJHjnG5sb+N/7aPiD3Aj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1dyjV7m; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1dyjV7m"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324054so110318966b.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 00:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762417358; x=1763022158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3585tbsF2osb0g8bNYLFxd0LxlN6u0TGNg7hX6RM1M=;
        b=R1dyjV7m9Fv4G3kl5vxiR4lt8iFi2RnsB3qP+yhsbxPJmxhBaB4MhyoIO147gBz0CI
         7AFKSKvnACFgDtghWDDLNzNnFbaU5fSbTVeqne6VEu5mBP7EN8/A0VNgh7eSTQmxrree
         xkboTOVh5z21VsQYqYs04u5j1etbaCPOSkXL9BtcbM80cs0VNLHCrhiNNoyD1JzjYkyT
         +xsQ8nu7d0rjgcPb/r3K3xGASPg1rrgu41OMLr2SA0Gi0Ja/Ktyu4FEmgTwP/QR1wsEr
         i7TTMrPMnaDYMnRvcRcignws6KDM9wfuZU22uzDcmo0CIqLdVd8RlEH7RfVr5ds5neJq
         x/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762417358; x=1763022158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3585tbsF2osb0g8bNYLFxd0LxlN6u0TGNg7hX6RM1M=;
        b=Hiple1A+Xp55I51H+h6iXxyWV4n8U4BP90MlzPQJylIUYZODjD3mub1fhrsNFBDxBa
         QZAEFlF/gr+BoFwe/7KU8xmR2bBk3MlZOMJnd9+5u4CSm9oFneBHCmPnDgv8c0Px5Z37
         nX31nEJ2V96wYqNxPU8C/QcbuN/0xJUAcZ4lD0wLzosoHmqNsXLJ5so/TB48j7ZlFZJR
         y2g8hJ94acc3387GpkRjCErc+Zbt42cOiOf0ZWM9ubBkStrnbI8G28xXRSAx+VYNyKo2
         vnHKAVRs6ch66hwxTKNIzk11oeC8LXIA0VimsXXWYOUTowrHxVH/nbdG2yAj4aqrqRgA
         eEUQ==
X-Gm-Message-State: AOJu0YzCK/PZHUdeUIMNOzWPOm0Slwqa6PRdUa50fVsJKD9VyIqxeGu6
	8KQwaCO2HErev6eBPyD1vSrO3zsDsYBnwqpSZY4sb0DFJCFKkWcGI5FeRyAvlu3S
X-Gm-Gg: ASbGncvVD8ziIxWaiyVbgt+ElbA9AHxxCZGeZGtB64L6g3ICF5CRxfT3GvGBrfEMi/h
	6fuCTu5FBp/RLF9TgP1fqTWMjP7NOH/+CDx81JWUE1Zfrqh04QpVE0s8mvb6BPu2cXYmPigek7n
	jVyj/5U0B2kYAvJuYrxGE+hsNDf5kRbKzSFc17MD+kYyYoCK6THyX81WGbEyAGE0BevqfDWsA/t
	NPKnmaq5XyUkPPiNe8QxY3lHwQPsD4Pc3kSaixHhMUTlwOsmtqYF4W+W4nll6YRykf7SpZwGcFj
	r1scD0PFS+oYqlD5erRLELiFSoWROlk3BrF5yPtR2bS+JQRWSHYq7Z0U/uHHmN0NBkhd38Mr9nV
	UqnYgTYX3dm31Mf1lrBPy+xVrdFRq0bYRH7oNgbquFhVbkhZFVnNm/wg97vU95MBQ5f0UgdXy9L
	BnGeKy
X-Google-Smtp-Source: AGHT+IEymVLp2ThRFRX2pZNBLLUPvaWVMJOltCssmO+x+ZATAP4tdb8gumn5voCLGfMysGh5MkIUrw==
X-Received: by 2002:a17:907:701:b0:b72:6143:60c2 with SMTP id a640c23a62f3a-b726553bc14mr642989566b.51.1762417357661;
        Thu, 06 Nov 2025 00:22:37 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:107:48a1:df96:bd1c:78ca:785c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72893360f6sm160577566b.10.2025.11.06.00.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:22:37 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 06 Nov 2025 09:22:31 +0100
Subject: [PATCH v3 2/5] reftable/stack: add function to check if
 optimization is required
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-2-d611a2a95cf5@gmail.com>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
In-Reply-To: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4487; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=mBuIcObFMa5/g0tjuhQgrYMN6PxpIPFwcu+OcrXeJBk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkMWscEdQMk/VmZrTmRV94aQnJbpvigtW5SC
 +cBgeMjVZuBRokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpDFrHAAoJED7VnySO
 Rox/dx0L/RCPsyNRbo0GTiUhU6HuHiVdCWfwghVqpqL5m+X6BiXqZjC+122TNCpmKsaLJT1FgaU
 SIArZYUNp/0iFUuwDEmrC/RejvaU70N7Dj8zKlueC13tNpCOlUWi4sDMDlLVKnIhDH/QSF7U7ur
 J15O9d5EMTt2Rdd+YX96gXQK3iWWK7mzxH1kC9KVOZh2S42GX9aCTMJlCVvJjcAF9VeOQCaHiry
 mi7nrJB7Pc4xNDLGSgHl/iJOavAfWJziYbYf7C5m3qbLsR5C8W7r10mehYipa3N7LuQTQBXxx2Y
 XHj1QSiFN2VVRCNIqjqI+/4UzFOAZbk7bZkHI5LlF5WG6W6qFmlC+yHoTcoLmOdpVt7Qlo8nDPT
 +fth5W3wjzlQVHKtptHaUMtFR1diN3spEP1FKtFAqtj2EEkDoz7GWzibQ+jwD6cRRj7tiASJpJy
 RQ0aULd9MDfoMTbEi8CRYNFCFpCKKXDfoQ+tidNhWoolx+/nsBQyefH4Dm7logLx+Q4P3cBxi+3
 +o=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reftable backend performs auto-compaction as part of its regular
flow, which is required to keep the number of tables part of a stack at
bay. This allows it to stay optimized.

Compaction can also be triggered voluntarily by the user via the 'git
pack-refs' or the 'git refs optimize' command. However, currently there
is no way for the user to check if optimization is required without
actually performing it.

Extract out the heuristics logic from 'reftable_stack_auto_compact()'
into an internal function 'update_segment_if_compaction_required()'.
Then use this to add and expose `reftable_stack_compaction_required()`
which will allow users to check if the reftable backend can be
optimized.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/reftable-stack.h       | 11 +++++++++++
 reftable/stack.c                | 42 ++++++++++++++++++++++++++++++++++++-----
 t/unit-tests/u-reftable-stack.c | 12 ++++++++++--
 3 files changed, 58 insertions(+), 7 deletions(-)

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
index 49387f9344..826500abed 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1647,19 +1647,51 @@ static int stack_segments_for_compaction(struct reftable_stack *st,
 	return 0;
 }
 
-int reftable_stack_auto_compact(struct reftable_stack *st)
+static int update_segment_if_compaction_required(struct reftable_stack *st,
+						 struct segment *seg,
+						 bool use_heuristics,
+						 bool *required)
 {
-	struct segment seg;
 	int err;
 
-	if (st->merged->tables_len < 2)
+	if (st->merged->tables_len < 2) {
+		*required = false;
+		return 0;
+	}
+
+	if (!use_heuristics) {
+		*required = true;
 		return 0;
+	}
+
+	err = stack_segments_for_compaction(st, seg);
+	if (err)
+		return err;
+
+	*required = segment_size(seg) > 0;
+	return 0;
+}
+
+int reftable_stack_compaction_required(struct reftable_stack *st,
+				       bool use_heuristics,
+				       bool *required)
+{
+	struct segment seg;
+	return update_segment_if_compaction_required(st, &seg, use_heuristics,
+						     required);
+}
+
+int reftable_stack_auto_compact(struct reftable_stack *st)
+{
+	struct segment seg;
+	bool required;
+	int err;
 
-	err = stack_segments_for_compaction(st, &seg);
+	err = update_segment_if_compaction_required(st, &seg, true, &required);
 	if (err)
 		return err;
 
-	if (segment_size(&seg) > 0)
+	if (required)
 		return stack_compact_range(st, seg.start, seg.end - 1,
 					   NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
 
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

