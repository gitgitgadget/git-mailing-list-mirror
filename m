Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3E288B1
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764209771; cv=none; b=fwPQS1Jv3+R1Q/ru08u9RrJ6ypS9bP7ogsSM1hU5212SrTNd/Ak0Q9fqRLU2Ug6qlWv8funan0artC4eFYbBJnZsSO7/NaDTn4tBpmuVJy8fee2F5CtyYdqzU3rW/NcP4wPwvfHB2EL6be7shN45n/hD+BxjsLjf9c1Lrlb5+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764209771; c=relaxed/simple;
	bh=eizYvNzqxPAmzxx9THeUwUIurOclDUMsH/9ZN3VE/cI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EqSwsDcLQDRmcgUogHg1TX8uYIUuFBndRvCYoWShVUO9TMedYVV8rFvMJg7VNzZELM12lDG5lSqRqdlOPDcH+xLh0EKY+ce9UodkPhMbCcbecl1Yg8iXVg27p6zFulHtZ9dJP9E4kVtA9BPl/PlWKahF+vcDadI8Si1MWNZHleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MK4BJJ1s; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK4BJJ1s"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so3158456d6.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 18:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764209769; x=1764814569; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kb4Dpr1syEhkBn8yhFSh6nvkgUuqswtu2BinAQKY3U=;
        b=MK4BJJ1suqkXQfSdx99P85dIPdmJk0NhldLnFWua8jAxzeMCgL6YKmBGNeJnMAkebS
         ehVlVLoH4yOVSVWr7WD1uF/DnhXo7HGRL7ZDMrw1U3E9TwogJxlc28eKuUUSXWFp59at
         J8Ayq+Hs+4VSB9q4g9SpUWP8vFYTcSnUU6hDOkCKDVO7SAid3zRZEKgn/J2oSiLb9rPS
         D0VjLBc+Em55N/fMQUWDsu9XJU3BVWIHSCuaRcyXDtMumUswRJztwknV2ehL0SyH6NQv
         upxZ8u6njcwwTArS/1Acr5sMBoBACXyh3DBG0wXubeBu9GL+mAnUY/wDBDq7WmFXNJRA
         CYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764209769; x=1764814569;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6kb4Dpr1syEhkBn8yhFSh6nvkgUuqswtu2BinAQKY3U=;
        b=Ve5rTELaAzWC5A4TfyvnsPt9Hq3c3t61Xo7GIdIDqNCQp1GXSXbz7warPfYkOv+2mo
         8k66WqB9xJuGG8wiWsx9bDDU6+4EuZTj4/QcwDwu/TiYCOkuwYYAqUaVCT+POay6MYME
         tGvMTxTX797lPPxEgzjN+MCAHAfroDibJWUK7qqjOJyQDjVi7OA468f3+dvptSdoIfl9
         Y1GjQGD8z+0ZqCTtBO7ViiDR6iFFRkTWlVK9pD+MKdinP8F+aAP2AYzWijmuOdtdvoED
         7FKIOtkpO1E7LqVk57eJ+xzPrfHN46onJngdf7H878NFeHfLZI7qwa8+By9QhLjM49Mz
         JFBQ==
X-Gm-Message-State: AOJu0Yyw7Fvf3STP+Q8va9PYP+/xZq64oY/I7evUbJHuT2lDadO+cYub
	UGFEblWGmpW/waNntWJRPq1cYnQKGPUm47/JF3uCLFVSsSZO0ii4SKEK1eff2EB5
X-Gm-Gg: ASbGncuTKodilfBBJ8UZRP3wM87pjK5cpOOSdXRsOZpqIQ7ewJu7pTKi2OF8qu6L2ru
	mKrZ6iWYe0xhojAQjE4xuheEtTaH3E7IbvvIwthtRG+GBEERgvUWpSdwohewDYRA3ePNwSbKqw/
	mqGAMa2p8GeagcTodX2/77I/55DQlL0vkkPf1VTjlV3p9AngG27YTGkgEeq7mPYzfvhDA/jzWjj
	WtV7vmnAsCupvp6mr+65n6NmA9lYhKKXZ86T+rFziV6HMHcu5X0iRUjlScrVHQ2RxBRiBm5RzB5
	evVt34CHU6ZzhgZWlbeEpmjZhTCK3lERT1iJRa5JR+5uUGKcLO/qk8AinoHgk7YQPokjI10jTt/
	LyBeAExzHIny7DLxcf/Wa6GNMk8dJ+yUoTG26XGIDmxPecr0WZUTP8nMzoGiGKtzPQZMN1BtO7M
	yMb+1iFeBg9SMfEQ==
X-Google-Smtp-Source: AGHT+IEhk47o3HW1YlHeHIQ6pYtLPuipc712JnDcOVaX3OtHeRtRdpT8AAUXHAgT7yk1qsnkscM6SQ==
X-Received: by 2002:a05:622a:14cb:b0:4ed:b6aa:ee26 with SMTP id d75a77b69052e-4efbdaef286mr125391141cf.55.1764209768699;
        Wed, 26 Nov 2025 18:16:08 -0800 (PST)
Received: from [127.0.0.1] ([172.172.86.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd2f9a71fsm1772041cf.6.2025.11.26.18.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 18:16:07 -0800 (PST)
Message-Id: <pull.2109.v2.git.git.1764209766305.gitgitgadget@gmail.com>
In-Reply-To: <pull.2109.git.git.1764152756908.gitgitgadget@gmail.com>
References: <pull.2109.git.git.1764152756908.gitgitgadget@gmail.com>
From: "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 02:16:06 +0000
Subject: [PATCH v2] xdiff: optimize patience diff's LCS search
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Yee Cheng Chin <ychin.git@gmail.com>

From: Yee Cheng Chin <ychin.git@gmail.com>

The find_longest_common_sequence() function in patience diff is
inefficient as it calls binary_search() for every unique line it
encounters when deciding where to put it in the sequence. From
instrumentation (using xctrace) on popular repositories, binary_search()
takes up 50-60% of the run time within patience_diff() when performing a
diff.

To optimize this, add a boundary condition check before binary_search()
is called to see if the encountered unique line is located after the
entire currently tracked longest subsequence. If so, skip the
unnecessary binary search and simply append the entry to the end of
sequence. Given that most files compared in a diff are usually quite
similar to each other, this condition is very common, and should be hit
much more frequently than the binary search.

Below are some end-to-end performance results by timing `git log
--shortstat --oneline -500 --patience` on different repositories with
the old and new code. Generally speaking this seems to give at least
8-10% speed up. The "binary search hit %" column describes how often the
algorithm enters the binary search path instead of the new faster path.
Even in the WebKit case we can see that it's quite rare (1.46%).

| Repo     | Speed difference | binary search hit % |
|----------|------------------|---------------------|
| vim      | 1.27x            | 0.01%               |
| pytorch  | 1.16x            | 0.02%               |
| cpython  | 1.14x            | 0.06%               |
| ripgrep  | 1.14x            | 0.03%               |
| git      | 1.13x            | 0.12%               |
| vscode   | 1.09x            | 0.10%               |
| WebKit   | 1.08x            | 1.46%               |

The benchmarks were done using hyperfine, on an Apple M1 Max laptop,
with git compiled with `-O3 -flto`.

Signed-off-by: Yee Cheng Chin <ychin.git@gmail.com>
---
    xdiff: optimize patience diff's LCS search
    
    Changes since v1:
    
     * Fix typo in commit message for "pytortch"

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2109%2Fychin%2Fpatience-optimizations-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2109/ychin/patience-optimizations-v2
Pull-Request: https://github.com/git/git/pull/2109

Range-diff vs v1:

 1:  dc6d509b59 ! 1:  0f8a2dd719 xdiff: optimize patience diff's LCS search
     @@ Commit message
          | Repo     | Speed difference | binary search hit % |
          |----------|------------------|---------------------|
          | vim      | 1.27x            | 0.01%               |
     -    | pytortch | 1.16x            | 0.02%               |
     +    | pytorch  | 1.16x            | 0.02%               |
          | cpython  | 1.14x            | 0.06%               |
          | ripgrep  | 1.14x            | 0.03%               |
          | git      | 1.13x            | 0.12%               |


 xdiff/xpatience.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 669b653580..13ab0d591c 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -211,7 +211,10 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 	for (entry = map->first; entry; entry = entry->next) {
 		if (!entry->line2 || entry->line2 == NON_UNIQUE)
 			continue;
-		i = binary_search(sequence, longest, entry);
+		if (longest == 0 || entry->line2 > sequence[longest - 1]->line2)
+			i = longest - 1;
+		else
+			i = binary_search(sequence, longest, entry);
 		entry->previous = i < 0 ? NULL : sequence[i];
 		++i;
 		if (i <= anchor_i)

base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
-- 
gitgitgadget
