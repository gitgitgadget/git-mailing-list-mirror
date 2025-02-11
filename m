Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8EE26E637
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303024; cv=none; b=q7bPKvsdePtUd4CkNRW1IR43b/OkQoLAJ4ycu7PqmiVoZZrrW8Emr+QmLHtW3AT5Bt8r47cQ0O+Sq3b5XD/X7Wa5s4XAdvD4dH1ty0iCEV/Eb+5/iV/zlBdfzyphFzs/g5RmCLKcraSy0RZIzLoSdJS/4/pa/HHYKXw5yJ5o+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303024; c=relaxed/simple;
	bh=ujeUk2qYUBZb29BCI5Bj6grS2+F/s+LjehtBMnl2NBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hUZm/DNUYcOdAreO7q3UB+eHo6HapOpI8vbVuRdrcPEx0u6xeifwZTuDvpbL2SB0pLctOg1dvHq02977YeIy/h/suXgia+jRPhTcCAUAtFjjWpi3DJXa8FJQGoydRqXgsEIzohV/zChvjHwXH6VIVnh/f5lqmMqVJKtPny/VWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnzoLSE0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnzoLSE0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f61b01630so1402855ad.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739303022; x=1739907822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ogBTYjqYGflb+tjHncC3cgOcQLFQsBcgIoKkw8rwb18=;
        b=XnzoLSE09hWRTANpauGLvt9HqIlw5V323HcDiCCXgl1Ju8mNdPDDhMZfumjpsHMOla
         E6w1BeLnQeyZInikWy4t9ytsGMhWfpRnV/bvuRux7d6iUiwCD+JvllWaGL5mzLkmPhKa
         xO/oO/EAKMAw18R1qMW5THA/6enCOk9UtRmphuCHFwkexPAOnJ5+px0N+legJzDWJOi8
         ZJFGAJ+Ivl9qdocA9Qa6vV5os4Nc9WqXp+xV8tUy8XIP8p7IurmTgJ1IX86jB0dxcB/1
         ydVsfp4bdHfkLd9U7DOC5UOalUwnLX5MoEuDLO5nBi2tuI0KiLke+l1QVdvcu+uQHM9M
         3Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739303022; x=1739907822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogBTYjqYGflb+tjHncC3cgOcQLFQsBcgIoKkw8rwb18=;
        b=lOf436H/joT17M8EstEB7/isAP6KgVWoggHB0yIxOnr+ufQ6VFFCB7d0PjWiyIrmB6
         yNe0oSg+0qFMPtmqPpZge2jDGKWrOYUULuL9L6QJUVtxozbje1fc/yg6pNxtaRK06WHP
         C9ySXMJ1pDsrnRnWUX3Z1SYJZF60uh96M7W64TWTZiVIUvhE9kLLet2zOeujxaLPwEAd
         8ZznUEco+BCqOJqWGMglg6QsbUe/+H1P8GnOZT5QM5WES/k/Zhf3ocZB3R9a8iL+RPHK
         4rALB9frXPUFSYD8b1tnNs4pk/TDuwj8bPh8l1SU44zY9SNrhKQ+y7r66bUs7MPWSH3q
         5KOw==
X-Gm-Message-State: AOJu0YwkWtWnStOl0qapIupcSPsgNShmt7sKD8NQsCzt3CgC/TNofWel
	2yLcCpRe0wbL38qHE7rV1Pr6/vor+tqqAjgLU4U7QtLtFGiQDuBbmVybVg==
X-Gm-Gg: ASbGncvVQM5XrjB5LwD0OXYODJm+UG8JqXYYo57I4O2ZMWkm93XdTi2JccGUCpeNgP6
	Q8pj6wKJGORqxVYiGZBK7ySinl0fkdHOxd4q1Uq0mp+ZbcAE8UTNHn8YLL2R9AbpYAbgMi1Vzzt
	pz99azrwjLs4KR8vgwOYZE+xsmgnMI3NPfDRV51tbPRSxjQB7OHScFC+beMx11wfz7sClt9TDqb
	uy/QJqtvtiGEYzvN6JcwjSk/sdu/zKXo6BFdP0egUoytaOU0m2wVDsgrNnGKe4Ry/ZtT5iN3zAR
	mCPHrF62A39NHA==
X-Google-Smtp-Source: AGHT+IEJdFd1u7sCWRsbFMvmSn5U7CspT2Pf2t4Q/C7ci5Jg5JSSPkhwv00eLOvIT/QtfxL1Rirgwg==
X-Received: by 2002:a05:6a00:814:b0:730:8e04:862d with SMTP id d2e1a72fcca58-73218d396c9mr7202460b3a.12.1739303021570;
        Tue, 11 Feb 2025 11:43:41 -0800 (PST)
Received: from meet.. ([103.240.170.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732190891efsm1968063b3a.131.2025.02.11.11.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:43:41 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: Meet Soni <meetsoni3017@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [GSoC][PATCH] merge-recursive: optimize string_list construction
Date: Wed, 12 Feb 2025 01:13:34 +0530
Message-Id: <20250211194334.20710-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid O(n^2) complexity when building a sorted `string_list` by
constructing it unsorted and sorting it afterward, reducing the
complexity to O(n log n).

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 merge-recursive.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5dfaf32b2c..c43b79e6ef 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2757,24 +2757,18 @@ static int process_renames(struct merge_options *opt,
 	struct string_list b_by_dst = STRING_LIST_INIT_NODUP;
 	const struct rename *sre;
 
-	/*
-	 * FIXME: As string-list.h notes, it's O(n^2) to build a sorted
-	 * string_list one-by-one, but O(n log n) to build it unsorted and
-	 * then sort it.  Note that as we build the list, we do not need to
-	 * check if the existing destination path is already in the list,
-	 * because the structure of diffcore_rename guarantees we won't
-	 * have duplicates.
-	 */
 	for (i = 0; i < a_renames->nr; i++) {
 		sre = a_renames->items[i].util;
-		string_list_insert(&a_by_dst, sre->pair->two->path)->util
+		string_list_append(&a_by_dst, sre->pair->two->path)->util
 			= (void *)sre;
 	}
 	for (i = 0; i < b_renames->nr; i++) {
 		sre = b_renames->items[i].util;
-		string_list_insert(&b_by_dst, sre->pair->two->path)->util
+		string_list_append(&b_by_dst, sre->pair->two->path)->util
 			= (void *)sre;
 	}
+	string_list_sort(&a_by_dst);
+	string_list_sort(&b_by_dst);
 
 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
 		struct string_list *renames1, *renames2Dst;

base-commit: 9520f7d9985d8879bddd157309928fc0679c8e92
-- 
2.34.1

