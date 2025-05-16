Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346F26F476
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419142; cv=none; b=ly9aXLm2EyhlK75fjn/aaswrO1IR6pKr0YLFWqLnsYQEJ++jsIfkOJA2xt2fmS3l+1Ah52XE1xkqellph41Awkq7PO2HiOMiNA2IueFH26Ke7My0RjzdS8tL9Hiod8D5J7t+ycUwS2X8HXTibHa4yAuSCsTDeu73Q0ZwFek3ldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419142; c=relaxed/simple;
	bh=mZvwzqxehBTjgKnVNA48bkSg2GTdl731IyUXkJ6p1/0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sKCpMmYjjjF1EDHeDImbVvLso/knpKD87cg3IE9wYUlbamW2Q6ztQVUjy/7DX94T6rZUrED4T9ZsUdEU7FFOCqgPKNIySKGuAGTXxIJ/hHtyUw/iGnbuVY6Oans/SuT5DrCSbrpoJsq29cTCkLR76xYRzBWT09Xf0XsMxSsYgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7iRo6wP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7iRo6wP"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0ba0b6b76so2120915f8f.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419138; x=1748023938; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRgo2A5JaSEZp9wcFKNceL3PCHf4E7gz8dmMxTCe9S8=;
        b=E7iRo6wPw9WZazbZF/5TqFoX9mIWEUBQtZwuCuOllCpiSFfRrmWEJ0kY/NKUIrqsLF
         DAGJ5zpTD9aRaC2zOp7e/hQi+sDJxE5fumwp40xxH9/l+grT+iccRBAyNdSqdFu2uXbB
         C1pjBy89CIRu1ba5CokUwLIf8Im7n25AD0B3Rg/EOD82JXTuXvCqpNMxNO8OTSSD8x3J
         0AnmguF6hKsNQOWv6azRQqUrRnmGU/vdiH+OMyN95d3SnNjtXgJ3TWAdbuV3SRAsYmdD
         lwdGQhfrVvY/8jVdBXypBNyj6ys+ekXH/YVXgjXYlhSBuJC7pdtgA9ZIj7DwiFRn/nEM
         U5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419138; x=1748023938;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRgo2A5JaSEZp9wcFKNceL3PCHf4E7gz8dmMxTCe9S8=;
        b=DvZabERxd/KU6NYGNI48Mq983QcxQi6rZLL5O06YEl5fHK0wRzFW61DutcRsbEKKJE
         o0J8vHiZ9VMK73T0b/Hp3sasqesmZ8gLBABORalpSv882QC9ZXkeIOh3L3WqByKOxYFJ
         gKpfa5XPNlz4UXwOUzqUK+DrzEvKquEtQtQBux4QHEx5ujAZn/k4EdlUT7Cc5qcLz2W9
         IAzMcBXKHXQ3MmE27Y4GIGmqYuaCswEP0FZM6cBohrMEPCBgGnpM6nLVLlvNkQXK8da1
         giL1cQuzoQEoR3cp6v8mkgm3B34sCJGQKC0Kv62gEQgzT6e4WOaJjWxm6+3057rQnQvP
         UdLQ==
X-Gm-Message-State: AOJu0YzqLoFb6+0YB0NrYcoM5eOwM0RfQ2CwIsT1Cq+JYOq0ctMqsSuZ
	KA2sypZa5NV+ti5X3nO2vWk5B0k2SsRvqgP2zaoI2s8sf1WFT94r92DF1ZhLOA==
X-Gm-Gg: ASbGncvz++qST+rVCqHOjSIFlhAftrhUBk1MIVg1virr6daXE0P/sDiBYsmOnNNHo4i
	WF8JnazB7yu/FyJsn9+nff4e8IuWAZgPY/ezcuMv9ZTcsJQ8POQM6VKIGGT3KG/6XM8Z+8yvUju
	IfHzAg5PG9H+EmUJaftnlVDyojgIhMlGCj7heNQdwAjtutW3cyNXII4vZEJulT1jyQeByDXNI/+
	bIWo5y1ctnwbWXMzxIeRALQCUIzKkvYPC+hkn+7fFaEzbtWlLLXs/BvDfEtPjbAFGRC9Azfaky4
	Qw3kzV5OmF+JfPlhfQ8hFnCwq3FslF/3zwS1keou6CYtFyofFUnS
X-Google-Smtp-Source: AGHT+IEXlEQWbgXA9+XlP8GFdFf7+SzzwsoF1E3nYs20tssGLoXu4DFE0E49hlOQRKnwbkxDIXkBXA==
X-Received: by 2002:a05:6000:290f:b0:3a3:4bd8:4c6 with SMTP id ffacd0b85a97d-3a3601dc673mr3547635f8f.59.1747419137836;
        Fri, 16 May 2025 11:12:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca888afsm3657131f8f.64.2025.05.16.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:16 -0700 (PDT)
Message-Id: <6d65fce5cc31621b7b4452ce57cc7c002ab0caef.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:11:53 +0000
Subject: [PATCH v3 03/13] pack-objects: update usage to match docs
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The t0450 test script verifies that builtin usage matches the synopsis
in the documentation. Adjust the builtin to match and then remove 'git
pack-objects' from the exception list.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc | 14 +++++++-------
 builtin/pack-objects.c              | 10 ++++++++--
 t/t0450/adoc-help-mismatches        |  1 -
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 3b803d3a7830..b1c5aa27da4d 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -10,13 +10,13 @@ SYNOPSIS
 --------
 [verse]
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
-	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
-	[--local] [--incremental] [--window=<n>] [--depth=<n>]
-	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
-	[--cruft] [--cruft-expiration=<time>]
-	[--stdout [--filter=<filter-spec>] | <base-name>]
-	[--shallow] [--keep-true-parents] [--[no-]sparse]
-	[--name-hash-version=<n>] [--path-walk] < <object-list>
+		   [--no-reuse-delta] [--delta-base-offset] [--non-empty]
+		   [--local] [--incremental] [--window=<n>] [--depth=<n>]
+		   [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
+		   [--cruft] [--cruft-expiration=<time>]
+		   [--stdout [--filter=<filter-spec>] | <base-name>]
+		   [--shallow] [--keep-true-parents] [--[no-]sparse]
+		   [--name-hash-version=<n>] [--path-walk] < <object-list>
 
 
 DESCRIPTION
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index bd0883890376..59d640d9f255 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -187,8 +187,14 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
-	N_("git pack-objects --stdout [<options>] [< <ref-list> | < <object-list>]"),
-	N_("git pack-objects [<options>] <base-name> [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects [-q | --progress | --all-progress] [--all-progress-implied]\n"
+	   "                 [--no-reuse-delta] [--delta-base-offset] [--non-empty]\n"
+	   "                 [--local] [--incremental] [--window=<n>] [--depth=<n>]\n"
+	   "                 [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]\n"
+	   "                 [--cruft] [--cruft-expiration=<time>]\n"
+	   "                 [--stdout [--filter=<filter-spec>] | <base-name>]\n"
+	   "                 [--shallow] [--keep-true-parents] [--[no-]sparse]\n"
+	   "                 [--name-hash-version=<n>] [--path-walk] < <object-list>"),
 	NULL
 };
 
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index c4a15fd0cb88..06b469bdee20 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -38,7 +38,6 @@ merge-one-file
 multi-pack-index
 name-rev
 notes
-pack-objects
 push
 range-diff
 rebase
-- 
gitgitgadget

