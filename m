Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04AD1C68F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124613; cv=none; b=P0RlEXQosxzgD9sUIQKLwteL9VFDWInSSUbJU5PMwYdwMYP8OQhQ3gEbTixSOWkICrVFMTh2ZKnAQz8ayGA98VK6yvSOTQ7w66R4OFmttO4RmlYbgjqvdPU6kOiZ53kJW2vaq3BjnTpA1PLSSF5G/uU4qyeuh5iGu/Ri27GT1gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124613; c=relaxed/simple;
	bh=2PHPOtFDP0b/1o9z4Cunu7Z0SSNfw2YFEsx78RfldIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJlIQ5ueHk7Y7dEEWjj2gS0WmegkOdheHvgw8Xu8aREHLlkcDSQwvHVsuyjoM8EeGn4Fru3Y1zXg/JY1AviRKWsFKMiZQsIcoAFNBm6KY4j4UlueJZRFS8wywQxxOBKJl8KRsfbGcvBEX6vWtj7FJ9Jj2MAT4COi0GMVqSwRSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=K5RhzMFU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="K5RhzMFU"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79ea87af213so70529937b3.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776124611; x=1776729411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5bZ/yexQaZ/K63ITmwSi1u5wXIBrlmPTwMH00qAOTUc=;
        b=K5RhzMFUuV95TiX+RmPJ6nqrfBqUF+qfJt0otMwb3+cRA8VFBBTauwuHlRv9rFZKfB
         /nD/8newbILv/HsB6o4WflJNarG073t76mP8LR0/aNt+aOC4viFQ4v4Bf7fSMKTsW0GY
         Ook7vrbJkb3Iv7g+w40RrrWfxLfcnNaALaOwAdAcd8wsFlmuMZiKPC/lrqZaHE3rYUJG
         fjlDp7qNTZb04OSLE7hnk29Sdc+vQgaijgzYzotZIGuGL2n3RI2KXT8covuvryuz99Ju
         2RyjjbZ+ePeBP68jH6wgZAGkJY/6Ilfq9l60rzmiqPbYvjqpgIuOyU7E35MJDpHu6zwQ
         LIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776124611; x=1776729411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bZ/yexQaZ/K63ITmwSi1u5wXIBrlmPTwMH00qAOTUc=;
        b=LMypfb/9yDPJH3B544dk702qx0dMPJVYCC9a5gCasFBVIzc3W+xY0Ol41XUPK1ipUR
         Sx2hveTPx8NcMciuoBRzdon85jPHuDlMaMBQZh/1J3cGD22JYBhZbbpFLNekFI9vcc9Q
         eui/6pxRvuCPZmGjjRBaw0ngzI8S6wWSDhk3TCdNBkArn8agXJkjZ41jydbuKw3+ZhC1
         bFZUdTQ0JBEtaTNX9xAABMXklJwmX3B7ayC9zo4ASIrWYoPOeqH4HevTjCGprUPIAB8u
         eisvHbag2Ty9vpNFIlUSakBhf6rrW5Jauk3MfC9x1yeLvdsueNljGZTI2pHAcTV0W6LC
         2XZg==
X-Gm-Message-State: AOJu0YxOAuzAfo8le3ypkWkwf9oUn7mnzzEYEGJQUcAm+0gXvUSVkw3y
	2z/UE3PQwteKbeczE0R2rnGyo1Xr6UafEhPn15H9NUtoVe8TGMy81sT7tn8n5OtfVubsplhgaMt
	wB6qjQAE=
X-Gm-Gg: AeBDiesF7x4wAE7/nPyFfv/IXmbsuJnddfPM5ft3+1FH9z8FpLPPMQjQJQeAHEF5JZY
	Fzy9KxDxvFNlmETi40G1VEYwXuTuBPE6GDyx6v9PnO3fe6PYTPAF7aYH1zSbXNAi9WlpMbuuUeP
	VIh756QlD8jLITWU5NYmtGJE3Z6SeLmvAbpFu9GZgY/mI771TQv7acFAYIAT+4pgpv53o+Vlrae
	o4eE2Dhm+4BPcJwGNSy2HuOeioCMBPvN1EX94ib8wFAQzgpguHhI5ebiHko+5/lNVP/XH4fi1k9
	KCnipu1VyFsl/tS1YFPt6HDoTZEMJ+4BjYUooNsHj8thKxoxhiFBjG42jeq/vYi9eXQnHo/N9X8
	Rt3EuHVEVWz9TWF21Lgpfi4VqBaH/oxbbUoHss1ZIVc75q7V8hUnJoHkrHs2Phh0atWIlzuflqp
	+yZ+sboKpP+KMmVGFKc1r2j1NxDAgbgbIXoWEY2YFXHt5io/ZLU3xLdKXhY4lLoEokwa5hZra1e
	+r0n84KqPT/UP6XeVIjx4oLLoDPlrIjC5++RHiEnNoF+xlS1JOcQTVZstdr3tn0urTw7hwhJFTm
	s/zG3+QbKeM2gCKlMns45ywXLy8=
X-Received: by 2002:a05:690c:86:b0:79a:da8f:d26b with SMTP id 00721157ae682-7adee64043emr178610477b3.18.1776124610649;
        Mon, 13 Apr 2026 16:56:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b2514abf11sm26232377b3.41.2026.04.13.16.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:56:50 -0700 (PDT)
Date: Mon, 13 Apr 2026 19:56:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/8] pack-bitmap: fix inverted binary search in
 `pseudo_merge_at()`
Message-ID: <af9f651269d7898ba18410500c69fb30446940e2.1776124589.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776124588.git.me@ttaylorr.com>

The binary search in `pseudo_merge_at()` has its "lo" and "hi" updates
swapped: when the midpoint's offset is less than the target, it sets `hi
= mi` (searching left) instead of `lo = mi + 1` (searching right), and
vice versa.

This means that lookups for pseudo-merges whose offset is not near the
midpoint of the pseudo-merge table are likely to fail.

In practice, with a single pseudo-merge group this is masked because the
lone entry is always at the midpoint. With multiple groups, the inverted
comparisons cause lookups to search in the wrong direction, potentially
missing entries.

Swap the "lo" and "hi" assignments to search in the correct direction,
making it possible to apply pseudo-merges during fill-in when more than
one pseudo-merge exists in a group.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c                  | 4 ++--
 t/t5333-pseudo-merge-bitmaps.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index ff18b6c3642..fb71c761792 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -559,9 +559,9 @@ static struct pseudo_merge *pseudo_merge_at(const struct pseudo_merge_map *pm,
 		if (got == want)
 			return use_pseudo_merge(pm, &pm->v[mi]);
 		else if (got < want)
-			hi = mi;
-		else
 			lo = mi + 1;
+		else
+			hi = mi;
 	}
 
 	warning(_("could not find pseudo-merge for commit %s at offset %"PRIuMAX),
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index dce43ed8dc6..5bfb5103124 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -496,7 +496,7 @@ test_expect_success 'apply pseudo-merges during fill-in traversal' '
 	)
 '
 
-test_expect_failure 'apply pseudo-merges from multiple groups during fill-in' '
+test_expect_success 'apply pseudo-merges from multiple groups during fill-in' '
 	git init pseudo-merge-fill-in-multi &&
 	test_when_finished "rm -fr pseudo-merge-fill-in-multi" &&
 	(
-- 
2.54.0.rc1.73.g8f4e0170952

