Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509583A1BF
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685818; cv=none; b=HLszrIkL7mWy/PKXx+8jP1YN2zGnQD02epCnhCl/E3L/L1mhdwJgaH7EI3BE9n2FIsLWtP7DAkH7AUBlVWgSbE9oF9ghnhG4fRtS+xW2xO/TzHbtZhX5SmnYvFAr7HErLiDyQ709Md7/qlfutsLH4DCkLdQDMCd6HBiaB6AHbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685818; c=relaxed/simple;
	bh=0pOVOelPtclm+dNc95XusV+B7MSHm2ic1SDEX/wB0wU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Rjyt3L69gk2yY8UlYBUNCDBKMTxWGZjov1W4aTyRwaNrmWNykLHY4yJ9ICiw/lhhMEJK7iuFQoLZa33D8KUPU1m6byFQa+m4PTcYVbG1Q8bV27p3Dk+MGomImx98SPO0Akgeyiz5fIbKCXtlHHdHmqcfPp0ONVBxURaFiqmNp0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSKU0eMl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSKU0eMl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41490d05bafso15442765e9.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711685814; x=1712290614; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9PePpOHQQ89ZoQ936tbDhuo5G5d4VeEyEYEEQou95k=;
        b=ZSKU0eMlhk+f6JSsOUCkCjUMZlLUNckKUMlyCdeBVW7IcdqMpE/3PaksP7DGLE+g+K
         Bfjm79/bGTiyBtQ6iKMfK/EIPpexhH4R4BbTtQPVEiHkp84EL/LyYJFMBTnUONNEFm59
         Fx1zYeNGiBguVSbz7n2m1T9EyL+X/+oubZH6Ixvg4hg8r8aSZvZ9VzS//PbJxVop51F8
         Jfb4hHVN2Dg3ikgBIXYZ27LHa+KsNN+ANJBC7yQl5bOt2zDZY1lPn9Q1N+AO5W6b/xzd
         hqIRKTESyq18fgH3y5LrXncWUQ3voi9NMpLzkbT+CkRwVYCooaHJqkXP3nAYgkith7DG
         7Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685814; x=1712290614;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9PePpOHQQ89ZoQ936tbDhuo5G5d4VeEyEYEEQou95k=;
        b=eGuY7HzWqztfCFWaH5Yq7bAatd626kfg8y2CIcIHRvlc6STOkx7KUoikeKAgHej7vn
         OAvuCoVxiQ7P1up3JZWVJ0XfAFv0mPBFFx3Qb8W4U5qS0lQW1AP+iWZkE9LniMRC5gD2
         M+xMk3Y5GotkkapveHLiP5LrJhRK9R++pypD310OowgcynijROXovVFVW6k9knF0UPI6
         /S0368Bn48wd61yBRWeZwBWEBVIzTgrE0MQxEIBy6a1mADK9bjeYj8+M5VOkMm3ro1JE
         mL6MpAseYF6/bmna6JIT2hJuc/vw+53ZqN3jnjDfiC9IcW3l6JGl7agSHQ8kSRL519ON
         yLGA==
X-Gm-Message-State: AOJu0Yxps8PvzNpnnQfy4+j6rBkAD20D6wkBD72nVruTZAdN9FkCrHGZ
	s1vReBSP0DpU3OSQWJ5ZIGOHPnjLUJfqfrvoqMMQYoe1BNgypQTg8mmJcnNB
X-Google-Smtp-Source: AGHT+IGPlBdkNrrAgjeJxoYtP0kyOH1tMT/vmjSLl23XU6d+PG/0AOwKOeM2sw22StH+1uRfJ3GaQQ==
X-Received: by 2002:a05:600c:2155:b0:414:9538:7da7 with SMTP id v21-20020a05600c215500b0041495387da7mr1001481wml.23.1711685813951;
        Thu, 28 Mar 2024 21:16:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jg5-20020a05600ca00500b00414850d567fsm7350951wmb.1.2024.03.28.21.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:16:52 -0700 (PDT)
Message-Id: <9a33914c852a0487dbd90c83f53fa0e36414fda1.1711685809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
References: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
	<pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 04:16:49 +0000
Subject: [PATCH v3 3/3] reftable/stack: make segment end inclusive
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

For a reftable segment, the start of the range is inclusive and the end
is exclusive. In practice we increment the end when creating the
compaction segment only to decrement the segment end when using it.

Simplify by making the segment end inclusive. The corresponding test,
`test_suggest_compaction_segment()`, is updated to show that the segment
end is now inclusive.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 reftable/stack.c      | 4 ++--
 reftable/stack_test.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index e7b9a1de5a4..0973c47dd92 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1237,7 +1237,7 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n)
 	 */
 	for (i = n - 1; i > 0; i--) {
 		if (sizes[i - 1] < sizes[i] * 2) {
-			seg.end = i + 1;
+			seg.end = i;
 			bytes = sizes[i];
 			break;
 		}
@@ -1291,7 +1291,7 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
 		suggest_compaction_segment(sizes, st->merged->stack_len);
 	reftable_free(sizes);
 	if (segment_size(&seg) > 0)
-		return stack_compact_range_stats(st, seg.start, seg.end - 1,
+		return stack_compact_range_stats(st, seg.start, seg.end,
 						 NULL);
 
 	return 0;
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 21541742fe5..4d7305623a0 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -723,7 +723,7 @@ static void test_suggest_compaction_segment(void)
 	struct segment min =
 		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
 	EXPECT(min.start == 1);
-	EXPECT(min.end == 10);
+	EXPECT(min.end == 9);
 }
 
 static void test_suggest_compaction_segment_nothing(void)
-- 
gitgitgadget
