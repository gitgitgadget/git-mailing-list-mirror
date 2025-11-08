Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E52882B4
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762638732; cv=none; b=f71fH+wyXIjkV73hLtgr7pDB8DsIKdKUyPFwMOqkx6sDwMZKHxRGGg8DPfR52pLL8zw+cdYoiVtHFUWLRFeG/jJTSI5gROR3zINPpN5Cj4B9B1VfY2JAixXmz5hLRyY2rqhzvoFApTJ+hvRTOGC8xgeDy9cQNELPU9j2iZpUnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762638732; c=relaxed/simple;
	bh=Xz/ULoXHBZDfjQBuKe5MECNCyIWjz7aX/8QybR9TDJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NT2jpk1QkoKVT+tF/N54StaEhWaLIzUJWBsetbaZnDS+kEUUWKXOeMYgDkJOtcL2lIATENn1lcx3yv0TZms+jbKB2RcRzjKmaQ9ozoWxYYNDsxK/qMsC0+1syB+ix/cVouOsq8Kc4m9Pk+4EGJx45tFkH0WEf7ViqLeq6Uwj3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg09Cry3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg09Cry3"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so3454347a12.2
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 13:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762638728; x=1763243528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByZcLP7aht91A6UO9VgLRfA+3/NL3bXNXUWSv6amgxI=;
        b=Mg09Cry3tF6wJaD5SoL7UPeQx1eB6Ars8scfPlJp6z2gzz/omPtz6Rnn2yZDEcXDv7
         zwPQCgFddpP6Rh9nxRqH+XXY3jL3SZw8Fg22EQbqU8LTPfkRhWedu2o6iNWwpEVlAeUZ
         /U9OehjC20q9VwfwLoRCIp/51Fy4TSPrIKKLc3s8AvvTU3WC6VWAFyB4NiPq5zgboPt9
         Aqig5DjyZWzS3m2gF1YGj42zMb2maVox1cQZFgt0Ok3SbnZYVxSX35nX4LrNPnCywtI6
         iARP7J1qj5HPDUx6XL9NPMFR3N+pioOO08gGP9sHVGQT6AWgR4C6YAMCCDzKWMsqVL5X
         SYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762638728; x=1763243528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ByZcLP7aht91A6UO9VgLRfA+3/NL3bXNXUWSv6amgxI=;
        b=TBcEqBdt0Tt2Gh+ZlQPFUHxYdgtHtZmjlVcEyYVsgzArXC60/uFdus7KNjjLtJPNSJ
         HlQGfK9bQy8APs8OUgRxyIfeEuIXno6egacWPfymcy0lNUk4cQahzNWSo06GfBwJWs5u
         gBQaiwj1K59iJMApK9osINkSiUAVp7fjyMarfK1SsYV1j+KXW8RY1oyQ49gCbEp6PEFm
         hIKJlqsp0YI/wTNgkigg4F2MB6l/RLjFGFK7RCgR3jnHYTP6Q0U3vkPgCIWcFVW1fO1D
         ZWhWsugBhQ2G46x8349LkDrRZQmmOJDcAISIo2M7UIaI6oUOopQDbKff7ptr0zkfEZsb
         GlKQ==
X-Gm-Message-State: AOJu0YzmzcL79qnsdo5Rx1OuyJIdDlFEqWO8UJiK1ElnctBc7CmmK5M3
	uysxeNzYbj48BqgLGhCJgfWaNaE1kBk6AJLHIt8vq2hHFI42uwwNM9tl
X-Gm-Gg: ASbGncu5EMsI74r7MLNscU65d6y1HCpLZHJr4Q6pcsobAgCRr6ihHo3KykREV7O3ekw
	OZnK5MaApwodP2hTu5lMwzKNXMMr3NSYalTLJ5O2HBczqDBDcR6wKKlw8hN5L0B9J/W4VgRzwuC
	8aZvnY/cjGKNUJoN7TUBeRJEkvzLe362AUKGeSbkoTulpg+DXJVqSYIhycnwjHo3aXQ4zBXFQQd
	Bz8q4XU35QXh6O0AuuIOdm0o4/vaGoQ4KgjTI/aattR9wgW27tNZ92ZAfi/evTzCbBFLN+yx+TM
	gKEodTeh+1iSglVPHVzm4d7n73V66rrVrS+RfBuQAFsg6Nz6NHdpiplFEoWLnBOc5jh0whUVNXq
	4JD1FN6cyOV28WgQGYpzpVTa5T8kP137zBHbSY0BOSpZReaTalEAIoSf3zomEDUErTFgjzQf7g4
	cRfgRLY4M3x1715fI=
X-Google-Smtp-Source: AGHT+IGNo+VlgWiaPZnoaZnRsfwkdG1ScdrHc6tOG3kDITPujd+yEDhWCvfpsLobYFNsfBJpYxwKwQ==
X-Received: by 2002:a05:6402:2794:b0:639:ff5f:bdfb with SMTP id 4fb4d7f45d1cf-6415e816fe5mr2416483a12.19.1762638728402;
        Sat, 08 Nov 2025 13:52:08 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:102:72e5:c961:8164:6be0:9490])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415b69c366sm3056371a12.23.2025.11.08.13.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 13:52:07 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 08 Nov 2025 22:51:54 +0100
Subject: [PATCH v4 2/5] reftable/stack: add function to check if
 optimization is required
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-2-a90f229b6023@gmail.com>
References: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
In-Reply-To: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4485; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Xz/ULoXHBZDfjQBuKe5MECNCyIWjz7aX/8QybR9TDJw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkPu4EqkYInH+xbKuFAMJNxk/BmtbiuvLlJp
 W0lcRnQch2y5YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpD7uBAAoJED7VnySO
 Rox/5YAL/3x7P8lzoy9oIxCFSjQur8p47jmViTmIRLIErmrDef9WhKj9q9dLMiyqBQ1mPbZ1Ybw
 ock70OVd3NvvaM7aFHV0WWuz69ysz5tdY+f7pMPzHM4RuLJOcX13glfC1pSooxGf6TA7X+xqRu7
 B7JHPPdR7vvM07aoiSSlrFsIuxDeWwMQiXlL8RcgrJvgb0JunnbsaXHcAQoo+uSQPZSHNii0/kk
 k6ClpYJucUOFcN940huTiqrKufu0PJ9ttVsuO1WnDjJHHMz5g4KE0/lj9Tzp9HGLZiBl2j3qKEZ
 RVYlFq7Goi4Q2g5CbsLNTXoDZBBc/u80V67ryfjsS/7V2/twS/IPtNti2EIkyBo9Pj/3WQlwKx4
 4XPGfsSf9sFwksW50W4QoYkcw+aIJmti4Jc+++BcodjhyX9toD9pFDB4XE8Ub0r0Md0MR+gpfaP
 6UNl0Jm2ZoOlSFjXwuUzWoqsSA58/6GClOXUK1h1TLNERSkGs3oLIt3clcJLV6X+KnR9b2Zulm5
 20=
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
index 49387f9344..1c9f21dfe1 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1647,19 +1647,51 @@ static int stack_segments_for_compaction(struct reftable_stack *st,
 	return 0;
 }
 
-int reftable_stack_auto_compact(struct reftable_stack *st)
+static int update_segment_if_compaction_required(struct reftable_stack *st,
+						 struct segment *seg,
+						 bool use_geometric,
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
+	if (!use_geometric) {
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

