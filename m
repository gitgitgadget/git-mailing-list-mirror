Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530F2594B9
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303265; cv=none; b=Fb3HNkDHtyTSm0cruNujnqs59wuMK5oujem4hRgTquKLa9DMVBm+Q2U+CksQucNfsD0D37Q7WdaKTl4q83mUXE/zZ/SfyJiyWZuBsoeENoDK1Wu65RV5GFC7tAtZl7p9eh2ACqq/ZSn5so0K25+em2XmnvaDI5jqB4paRPj54sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303265; c=relaxed/simple;
	bh=zCXLsVl5Y2bWCRQTQ+3ZZLIt81V220sXs1sZBUW/IyQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TT7eZdZ604h0Mltg1SxgGTWdP9HM4t6j7r9FQDNVczdHp47kAigoHXjyI2efDkmwmhscO61k6GVULBFJLSK7enbx/kofskJfkjfYNpxpLhvARt3X197owzs4waSvVi8ZPmtBtfY8W688bY86gSpGePGHnsy4LJwxEqLh82TyKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwsTe/hV; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwsTe/hV"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-915d64fead9so209646485a.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303263; x=1782908063; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY36r/BAPDGaJPCucNnOO6/V+UojS9d4NScDvIdn+vc=;
        b=kwsTe/hVtxx1M9mB94rDezQCc2G50Rtc+JXOfxWsDMqfokhu+4UJHeGcKSBsw8SDM3
         2ta2PM78W/z85rgZBvivPAoaBfWSgmdJF3qoBPxl1XAUoG6bJPsdoYHYkfZpfbZz+cW5
         So6NdzFTDhLAVImCKnNfGdpwggqJGv43pUJDEaUmfgUDZKKEtbmEmuWIXyWdmSc7h1Ni
         PlH9jPOh+dgbpZIBihB/1QJObyWSlGCkulGJYFrm4nPlyQV0VjdOikbhqBytua3t3j4H
         /keluzcYD6CMuQ+1c382pPI6df6cVfw9TnG3t2rAN69yJuiGHvKL23mr2E4lV5Bi4VkF
         96kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303263; x=1782908063;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PY36r/BAPDGaJPCucNnOO6/V+UojS9d4NScDvIdn+vc=;
        b=nNNoKKF/8IcS5deSL6WoFDZBCBuNVEMY9Qy5X8tRwj4Ie8Hxi+Pev909OPzr3bPM7T
         YK9TZLxg5NLwneH1CWjm7v4rn8yeCvQU7s+lV8zJfrBonXnKYBHRX1l/OVAMEihZAGES
         LlNPr1YsJR7bJBY/h3W62sHoendXwHjahbqM//zT0RJRnCvZ/varmBEz/8X/wOVI2aVq
         ZQkawHJvUG+yCwqB0uVu6aeK+orIntCKuw8px0zevkWNoJqZQOHhm5HFXF2iZTEW3MXJ
         FdT8XEuiHMHmcq2uBe3yqJTBoH14uyWz+uLKBkAyAAzJxQT8sqE7AF6iyyqXFogtpgtc
         Y5nQ==
X-Gm-Message-State: AOJu0YwseZLm4zf/ERdUDz/XggEOHDnfmsOl2pXQzAUZ9+8koGrgQj80
	NixWbLHneRU87UfcoRHVrFgub85RozZfQrujykYWazNoaOYg7F0LQ0fheAFhrgeY
X-Gm-Gg: AfdE7cmka5NjXvld39YC5dSEFaqyLgO2XbO/t7YQHg6/wsKdd/ax7Tx2NzXwSMCAl9M
	b5suhS6fiPn7okdab0HEwnHQxehGJ4M0RsrEVkvhP1GKnLxGooJ+hC4lICi3QYpsI7WBpCnfxc+
	Ae8nez6BpfSaD1hFyo6ZDlPBfja2udA9qeV7qEaBTmPz9Tresm9VIqM6CBRE3g7taj860W8Z/72
	wg+CsfUYbhJl5TO1kD/CHUu3LbkgkUsG7Bes6UU22w4piIgqRbARmjcbTP0EnED1BHlU2mh3mVf
	LU30tQvvbd0JZPo2hW3wR/14t9MRYxsInKp+gYijTSfAgSlZR5/GejN8KhwSnLEuyp2vSph+cWF
	/0WFxPixj8puTvWRytMslHbsedQJi2+E+Z2WfAH3j0vJJnDcZD6pUz/ckcusYrfg/u6HVdIYENq
	cRGQ6P1kXhwUezZTc=
X-Received: by 2002:a05:620a:4456:b0:91f:27bd:ded3 with SMTP id af79cd13be357-92601f1b354mr1115736385a.21.1782303263204;
        Wed, 24 Jun 2026 05:14:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.92.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd391075sm536215885a.4.2026.06.24.05.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:14:22 -0700 (PDT)
Message-Id: <6ade4df2ed2a836a3b4c5400ab13e8247e36c029.1782303254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 12:14:10 +0000
Subject: [PATCH v2 4/7] commit-reach: add trace2 instrumentation to
 paint_down_to_common()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add a step counter and trace2_data_intmax() call so that the number
of commits visited during the paint walk is observable via
GIT_TRACE2_PERF. This provides a way to measure the impact of
future optimizations without relying on wall-clock benchmarks alone.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c        |  5 +++++
 t/t6600-test-reach.sh | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index a9483759e0..f6a438550b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -11,6 +11,7 @@
 #include "tag.h"
 #include "commit-reach.h"
 #include "ewah/ewok.h"
+#include "trace2.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
@@ -112,6 +113,7 @@ static int paint_down_to_common(struct repository *r,
 		{ compare_commits_by_gen_then_commit_date }
 	};
 	int i;
+	int steps = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
@@ -135,6 +137,7 @@ static int paint_down_to_common(struct repository *r,
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
+		steps++;
 
 		if (min_generation && generation > last_gen)
 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
@@ -190,6 +193,8 @@ static int paint_down_to_common(struct repository *r,
 	}
 
 	clear_nonstale_queue(&queue);
+	trace2_data_intmax("paint_down_to_common", r,
+			   "steps", steps);
 	commit_list_sort_by_date(result);
 	return 0;
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 4b771b4c58..c1109fb42f 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -319,6 +319,27 @@ test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
 	test_all_modes get_merge_bases_many
 '
 
+test_expect_success 'merge-base --all commit-walk steps' '
+	test_when_finished rm -rf .git/objects/info/commit-graph \
+		.git/objects/info/commit-graphs &&
+	rm -rf .git/objects/info/commit-graph \
+		.git/objects/info/commit-graphs &&
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-none.txt" \
+		git merge-base --all commit-9-9 commit-9-1 >actual &&
+	test_trace2_data paint_down_to_common steps 81 <trace-none.txt &&
+
+	cp commit-graph-full .git/objects/info/commit-graph &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-full.txt" \
+		git merge-base --all commit-9-9 commit-9-1 >actual &&
+	test_trace2_data paint_down_to_common steps 80 <trace-full.txt &&
+
+	cp commit-graph-half .git/objects/info/commit-graph &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-half.txt" \
+		git merge-base --all commit-9-9 commit-9-1 >actual &&
+	test_trace2_data paint_down_to_common steps 81 <trace-half.txt
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

