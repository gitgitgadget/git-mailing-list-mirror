Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBCA1B263
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711060829; cv=none; b=UyO1H1fuaFMcHffgtCONZ/QOezBVWWXp7vl5CqhqP1znfQBdW21oIPV7gupEU/QKkaah/PdwlHVP5Hipwao+D2uSK8IaBI5ARlmG7imaJ83gVJ98Zm0rP8ihUyEmt9TSu3IPGZT6bVYsjMNyW9DeyBRSKOJ2ldKi+nqHI49PI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711060829; c=relaxed/simple;
	bh=5K7rdZhxRQatpMt/8YgKCqJzOi4S//MK76ZFXfUnIVg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NGZ6qaaEbLKNALt5v/sbxPtXTqWrGDEM91tVw9Mfv4+uMTpG2v6Ka3sC8J8fNGZof0EZ/qahhvXw1BffOSNhfvP70fUrnTJIFKOCjxYAFOiIx4SrV1EHA+H70a01HaWqq8hSJ5j4DM2i25Ix/T3/zQ8be/jIlLWx09nIpoP2Tpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpJm6Dee; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpJm6Dee"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41466e01965so10604585e9.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 15:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711060825; x=1711665625; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCGx3m6W+PqU2mLq08DJM2b1Z+kdmyt/nVt67cN2UyQ=;
        b=GpJm6DeeY121qtm1g4miDFmguEZitk1xMmC7hp7rp6CDWvmRnuv8jt4By4JgYU/w6I
         rzA3xqmGRJtT/gZlKKtuGo68B+106Ox+Hr+NJT8dqp3EeO85IHOnpB/J6lr8qOIH4E3P
         ClecSxe7l0ZFneC9g3+N+Saf1aenmzjp36qPRtObmRbHeORL7tjp2sY1ZJXal2AqIgCx
         SR4wLhhIkot8YdmBsma0qBwCVPoq5gdXRnSZvezCa847u/Od3QKCvakanQTe8+KZFY52
         Ar8MBPOkP7EpU3xNG8q9IcIrq8UAqzUas5dnQWNjQQ7x3UChEEDp2AMA7o3nFGox5clT
         EQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711060825; x=1711665625;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCGx3m6W+PqU2mLq08DJM2b1Z+kdmyt/nVt67cN2UyQ=;
        b=F30rRkpNfRatqC0CNh7t5FLSCuShqoUJm1HIhwg6wetKMx0ZhcTA2tPHNK5B11xr4L
         6p3t/CbHUgfQP+Di277T2Hkj6rBN980+KaY/PeCD4dtUYK6nx6ko9aESADjSkS2RGvOD
         i1O277/aFRRNFSi2ZP3wEMp31XM+xl4SZQ0WOMJCis+kwOfJXpYd8edrjveXPMEAbxC+
         jgy4Rj95MRinzYfL3MXz+UeAuQvQtbLzR19j6lfZQfZLCq9U/EX99k4IJl6CNo97iw8p
         2qNf6qWq/yEpMnTO0E+w0BCPWEoBTWyUd002XLlIf/aG1DtQtoF+rOSUfOjSgLzZ0+02
         MLZw==
X-Gm-Message-State: AOJu0YzvgDiP26sGHj0bcbhFmzGjUXzEZwPdqaT4Oy7aYXuC5kC29cjl
	JC2xMeATXeapfgRBTa8cpX+F6yW4rxkgRbSgDh8MNmBNyQwmfmWhMBVEwZOM
X-Google-Smtp-Source: AGHT+IE+6OoJ/Mi8EvittdUS0EKamusEYsIBLA0TSIDdZLWzAlPfar+HrGn8NdnUdLEhrWL3biR5Kg==
X-Received: by 2002:a05:600c:1d2a:b0:413:e523:eed2 with SMTP id l42-20020a05600c1d2a00b00413e523eed2mr324551wms.33.1711060825199;
        Thu, 21 Mar 2024 15:40:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b004146218fe01sm6884979wmo.22.2024.03.21.15.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:40:24 -0700 (PDT)
Message-ID: <a23e3fc6972ff055f8c55722da1f2691b7004998.1711060820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
	<pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Mar 2024 22:40:19 +0000
Subject: [PATCH v2 3/3] reftable/segment: make segment end inclusive
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
index ef55dc75cde..0c16ae9b12d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1243,7 +1243,7 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n)
 	 */
 	for (i = n - 1; i > 0; i--) {
 		if (sizes[i - 1] < sizes[i] * 2) {
-			seg.end = i + 1;
+			seg.end = i;
 			bytes = sizes[i];
 			break;
 		}
@@ -1292,7 +1292,7 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
 		suggest_compaction_segment(sizes, st->merged->stack_len);
 	reftable_free(sizes);
 	if (segment_size(&seg) > 0)
-		return stack_compact_range_stats(st, seg.start, seg.end - 1,
+		return stack_compact_range_stats(st, seg.start, seg.end,
 						 NULL);
 
 	return 0;
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index e5f6ff5c9e4..85600a9573e 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -727,7 +727,7 @@ static void test_suggest_compaction_segment(void)
 	struct segment min =
 		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
 	EXPECT(min.start == 1);
-	EXPECT(min.end == 10);
+	EXPECT(min.end == 9);
 }
 
 static void test_suggest_compaction_segment_nothing(void)
-- 
gitgitgadget
