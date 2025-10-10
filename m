Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC52EE5FD
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092042; cv=none; b=QQbWmK48NvzwkvTI3mtXdZJ5B+VE9lkJpqmGp0FV24GxdEiiHMFK0h47eC8ubRAHr1RYevT7frSdGmh5XzmL5qr31g7wqQvtpIuW2gOht8pTSQg/i7ZAdQ+GOm6N2gYjFJM6fpkbv1wVZeMAuIbLFDJig0Tfxx8m/rgsVACycqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092042; c=relaxed/simple;
	bh=AJlCUL9wFjBGs9+JvyfNLi+aJ+DEQEWycPBI43+x2Ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iONBY8rml/oQUc7TCV2PpUo0+ZfUgufJKbsiwRHLbnq/TOQK5H7xYFZ6JpPm3OzG+qtzGzieKdVQm0+1blMpbP3YVmYRMomeBSnmcmUcruHhU2/pVvo9oo4iyCX4FRC3/yn/1hSaRGY2LNO2XgSw2DcFlktNNPxs8DBhQJPAYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfP3A4zn; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfP3A4zn"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso3523083a12.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 03:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760092038; x=1760696838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPSX3uLOz0BlM1qOObr9mgVzPHLzYtGbBXd/J/LQomc=;
        b=NfP3A4znv9bwa255HLsRtug9bgbfLQoYiAw7qGLUFRSGcdJL0vO5RQVckBuMBR3SDP
         jCYvKy8vwbVeJ7Jrk26vq5mpXsOZOz5Nr7rMm18MIC3AgbXx+Y1OCP4fWqzTrGE2DtCF
         xsr2wZRGjxbmIxW0kYeKOZ08PlvxQwKYVH4F8EIkL5y/yEDhf8FpZ4SuaKpbb+sgi1Uu
         fO81Eb996LCe1I1++KuLluw/nUKNUPCBbno8TQ4FILRyLJN3X/0yIY5WFlMI1xJHNVz1
         o35LHceiMBfWE9hOQufzv5pYFIoqL7UZAPK9sfjkPZ8ZMyrbsWo6/cnEFKewSVtZ3ycF
         Agzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760092038; x=1760696838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPSX3uLOz0BlM1qOObr9mgVzPHLzYtGbBXd/J/LQomc=;
        b=A60FH1iYKmtbH1EDJR8nsKxcoMIuRXvmTtjxW8xTZSJGbyBG1GGDClzVzRJlG7naCc
         TXLZi1E3vwDSQ6ZebBrzFGw0TZkfbCjDkg63d6O9PBm/NyNySu9K+Nicvy465v+3lihd
         9YY44pjVTdfCMEWGELoimm+2z0FK13MG3ai7v0mesvGmUZmTSQc7aLVIN5n+Zi2E2TtB
         hkxwZYJX31RzZEYmQSNBSK6ukXJsgF8lNpBmZDnLmSN1c0s1aQZVWdgzZ9nk8wV7t7Bj
         O5GOIPhZL8BXqHkKPiVWwab6WVDitG7xt9SnyZpOQOqfR5FiK3VWqN2m2B+OVWYS3Qm1
         lXJA==
X-Gm-Message-State: AOJu0YyGkKurtZiS30U6iNCKoBVILwej+WaLJanD7E9ocEBkn3OyNskU
	KUUtpKFFi3alTX0svO/i13I3nNW4PrS2y8ligOt/KGhMjQFi8Gy2sb7Yh1OrLsgd
X-Gm-Gg: ASbGncvQ4PW5hu+JPAIrkq7bdQoVGeBqKuQb5ngl2q0M8+aAgHIPiHLOdxeTdXMejXX
	0JtT8KhP+hr2x/17EMORnZ1Ee24HzjYnzktOOxpP1DqsAR85PQz/a6A/oJSzaXxjeRrOFryQQK5
	FmUXOaiu5QjDOiLYAExlMfCfTmAZKnxj+9aKgzSPLR4ND5fkIcaqsZeVXRrADwVDfznFr4+rplc
	wJNp5W3OkS8r1hOHoHNobjzkJIek/a8NSSr8wh+raUARXrrCbzIKElDttsCZONAXtJ1lpZSgTld
	O+XjbvKkTdMKo5cxzTG28eVzCtJY0eVH13TeQuhE3yehFLfggV7kkxHDYXOEVnfxYgFp4YQ0dDg
	XADwlPX2NNDs6TaBMNL8gN/8Rof1csAUIrag9SiDzdW/8O9v9jU6hZeh4b6PH8/u69Sj9
X-Google-Smtp-Source: AGHT+IF5zdtihdVvDChQdsCTZVu9LH56G2Jc+g+Ei4H5ms58B1vHth2Nauozx7Zb5IczM5ULWd2PFw==
X-Received: by 2002:a05:6402:4313:b0:639:eed9:14c7 with SMTP id 4fb4d7f45d1cf-639eed9eae0mr7186978a12.15.1760092038235;
        Fri, 10 Oct 2025 03:27:18 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:70de:2d8a:d550:c37c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm1960729a12.14.2025.10.10.03.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:27:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 10 Oct 2025 12:27:11 +0200
Subject: [PATCH 7/9] reftable/stack: add function to check if optimization
 is required
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-7-c7962be584fa@gmail.com>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3126; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=AJlCUL9wFjBGs9+JvyfNLi+aJ+DEQEWycPBI43+x2Ao=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjo34B9cuX2jbhfbN5G0LkEOrhU+ChU6dpx1
 K0RwX5ANW4Q94kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo6N+AAAoJED7VnySO
 Rox/tSEL+wdbErxrHaGtTSqRNklC+juzp9GX83F2iJPCwR4Qeg8n4J3QbQ/TCQxd6DvrfLRQuzh
 CxiRqj/6F88YvPW9hgGVP3YpUadX6OuZ5KBf/BRG8oTKdYYpnOn2KcukAOuWTr9ox9qmFEcsh+8
 e7Tc8HY3/8NH9/bAELraOwveGKixIiW6Arl0vHs3cpGIwCPGBajzSrMpxDODeIz6szyahGGpI/s
 GfYk718cs/g07Dugl3taH8C7Sm5TZVAlKCPNYX5/I0WkOZfajCDyUi44W4kyVE7wKSRRbxpIi0n
 5pjJNK+v8xWst/WIvuO+whqhYwSYc5p3wAT9QiNFcl235JmMBeN8wNki7aZmMzP0j46mIrY8q0K
 Kf1mEZfZeWc68GtWBL3DMDhkagW0RULUdeqSh/DPkOylE22mMJwD/5YTf+tIV++mRUwp2SzQBez
 zQwA4uwDnzt/htMBkwm+NlUWpt/n59fgoKDbhI4ubVZ3MjioRUDiveHWeSP5oeEUZrIIH+lBF55
 8A=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reftable backend for references, performs auto-compaction as part of
its regular flow. This allows it to stay optimized.

Compaction can also be triggered voluntarily by the user via the 'git
pack-refs' or the 'git refs optimize' command. However, currently there
is no way for the user to check if optimization is required without
actually performing it. Add and expose
`reftable_stack_compaction_required()` which will allow users to check
if the reftable backend can be optimized.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/reftable-stack.h       |  3 +++
 reftable/stack.c                | 18 ++++++++++++++++++
 t/unit-tests/u-reftable-stack.c | 12 ++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index d70fcb705d..754e955206 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -123,6 +123,9 @@ struct reftable_log_expiry_config {
 int reftable_stack_compact_all(struct reftable_stack *st,
 			       struct reftable_log_expiry_config *config);
 
+/* check if heuristic based compaction is required  */
+int reftable_stack_compaction_required(struct reftable_stack *st, bool *required);
+
 /* heuristically compact unbalanced table stack. */
 int reftable_stack_auto_compact(struct reftable_stack *st);
 
diff --git a/reftable/stack.c b/reftable/stack.c
index 9d9326ce0e..732141d46c 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1652,6 +1652,24 @@ static int stack_segments_for_compaction(struct reftable_stack *st,
 	return 0;
 }
 
+int reftable_stack_compaction_required(struct reftable_stack *st, bool *required)
+{
+	struct segment seg;
+	int err = 0;
+
+	if (st->merged->tables_len < 2) {
+		*required = false;
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
index a8b91812e8..80a87a15df 100644
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
+		cl_assert_equal_i(reftable_stack_compaction_required(st, &required), 0);
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

