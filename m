Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FCC7D07D
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632297; cv=none; b=KFFCuiuWmJ3DENxN7kr1EXmK3oEWdbe4tZa4ZoxVvuGu+iHbmSMaINS2MWh9+DQmVCb4+p7VeGEPBiddcXX6atmpWFZOG2eD5syDYo1Qgc3DVjWbzc7ltRpE+gWjwxeZ0vlw8+R2wgmroKuXAqSEBLO7KFZePfbE/TBIoZVBQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632297; c=relaxed/simple;
	bh=cpHQERrBy/e+QlEOrk1xWanbWtQ6/SnI7s2Iub2Ue+Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LESNHeBwGl1be0d9sf0cw64Yl3H+7scEBB3uUHvbAAvMZv7Gp4+Ox3drQK66sIJSz7FeP2S6aESaYaYXMvwlb6FibxwwiTLbc+kPV1HISz81r8vs6K84K/DBYX3KKXA6dRHpFMGv9dn3EYRUvY7JTc7pneHeCjoW08J69+VJiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1HgKrem; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1HgKrem"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f15790b472so29911001fa.0
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722632293; x=1723237093; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HQe48C7retWVgU11VG8KpaLIFiEtdB+eb7jfq+1CxM=;
        b=N1HgKrem9U7ZhJNcu+FruF+peHgMm+9xuHd4izkqygDVqaXokVGN0wjG3QUIjACGd8
         kt2U7F7zbxiRs0noMRt2amyTMS+r3we2MM8syHXb/X1ZrYIZe96Yj62cEh1T/3lx0Wq2
         erC5WRvOijb6LPLkB6f3fvECdXk+drgnSiOes0MfyJWfVkBqjqKo81vj6TQMmeLHSpuC
         wcD0Y/uMhquHUzkdl/bIBdO0sdxb9oCs/pvVQWD3CGABPHeuAGFPaaCZxYNzCPYfVA44
         OepuSKC+lPRKBvTtX3AJ8u9BVjfIqeyE7dYWLd37QerRB4kFa+SvQFkXRq8GTdxe4BGy
         ZIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632293; x=1723237093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HQe48C7retWVgU11VG8KpaLIFiEtdB+eb7jfq+1CxM=;
        b=B8ATEyOukU1tIRKYtq/47TdNML/Bzlkkid/mAIjIHohl7iKOYQtOOZLbr3QVjpcFKt
         r+VUM/HkhJtoppBoMMkjvoz00mhaiyq9cnh4py8v20gR8xLFynmcsjwm7BG2P8JTQgFM
         qJ5aedk578RQjoIeEXdd5BK+gd02ja1BhL63s8lQHERBUqnZYEoJlBqbQrmRoqhx8lGB
         W3W8L2E10CivXsPsh7MDdMEGnopoZ94hWKBj9xNYDfqAypS00I89pGygwhdY/8OPujO9
         22rIVg0wAPmt4QDxuchQupgRgU4nnFk1wnF6sRNuIvyKvO+PEUQ3k4BBzsQsyc9kMksS
         FQxQ==
X-Gm-Message-State: AOJu0YyH7p5gg5MuQay1U9571L23a/YHuOPMR6cOdRA3oBPEgD4TAJ9z
	NW6N+Aj2WzkYcTCtH1BWk67mHX2vTMxD4a2yd2tQyXpyVICOwkbbEFdxWg==
X-Google-Smtp-Source: AGHT+IHSvmEDKDkMfWtNPYSU1YykHzip5iNpFQaXf1+ODcWPXiJrSe6zeLxDiI+H2sNGN5W3KQtOYQ==
X-Received: by 2002:a05:651c:20a:b0:2ef:24e0:633b with SMTP id 38308e7fff4ca-2f15aaacbedmr34243981fa.19.1722632292303;
        Fri, 02 Aug 2024 13:58:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e4073f7bsm67017235e9.18.2024.08.02.13.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 13:58:11 -0700 (PDT)
Message-Id: <818dc9e6b3e8a4d449cb9dbce689bfadb95099ff.1722632287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
	<pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 20:58:07 +0000
Subject: [PATCH v2 3/3] t6421: fix test to work when repo dir contains d0
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
    Kyle Lippincott <spectral@google.com>,
    Kyle Lippincott <spectral@google.com>

From: Kyle Lippincott <spectral@google.com>

The `grep` statement in this test looks for `d0.*<string>`, attempting
to filter to only show lines that had tabular output where the 2nd
column had `d0` and the final column had a substring of
[`git -c `]`fetch.negotiationAlgorithm`. These lines also have
`child_start` in the 4th column, but this isn't part of the condition.

A subsequent line will have `d1` in the 2nd column, `start` in the 4th
column, and `/path/to/git/git -c fetch.negotiationAlgorihm` in the final
column. If `/path/to/git/git` contains the substring `d0`, then this
line is included by `grep` as well as the desired line, leading to an
effective doubling of the number of lines, and test failures.

Tighten the grep expression to require `d0` to be surrounded by spaces,
and to have the `child_start` label.

Signed-off-by: Kyle Lippincott <spectral@google.com>
---
 t/t6421-merge-partial-clone.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 711b709e755..b99f29ef9ba 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -230,8 +230,9 @@ test_expect_merge_algorithm failure success 'Objects downloaded for single relev
 		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
 		test_cmp expect actual &&
 
-		# Check the number of fetch commands exec-ed
-		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		# Check the number of fetch commands exec-ed by filtering trace to
+		# child_start events by the top-level program (2nd field == d0)
+		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
 		test_line_count = 2 fetches &&
 
 		git rev-list --objects --all --missing=print |
@@ -318,8 +319,9 @@ test_expect_merge_algorithm failure success 'Objects downloaded when a directory
 		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
 		test_cmp expect actual &&
 
-		# Check the number of fetch commands exec-ed
-		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		# Check the number of fetch commands exec-ed by filtering trace to
+		# child_start events by the top-level program (2nd field == d0)
+		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
 		test_line_count = 1 fetches &&
 
 		git rev-list --objects --all --missing=print |
@@ -422,8 +424,9 @@ test_expect_merge_algorithm failure success 'Objects downloaded with lots of ren
 		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
 		test_cmp expect actual &&
 
-		# Check the number of fetch commands exec-ed
-		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		# Check the number of fetch commands exec-ed by filtering trace to
+		# child_start events by the top-level program (2nd field == d0)
+		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
 		test_line_count = 4 fetches &&
 
 		git rev-list --objects --all --missing=print |
-- 
gitgitgadget
