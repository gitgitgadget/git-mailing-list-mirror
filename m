Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D31803E
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 04:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722571860; cv=none; b=ruyQHoXwUlSFO8/qmFNLkkpWbQ2QLQ5B5qKVzPCgWXMdfF2uv46+E1SZYbFJlh//Gj73ntqhFYkBmk6q/spzoiGE48Z4/ZJtrf/DVPbQSX5lMLo9jnJ+lLYrB8ZAiExVSJlDuvXqb4ogf6eTOcZh8mJPUz2gkJ5LSVmkGhqBkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722571860; c=relaxed/simple;
	bh=Q2smOYn/9nwE/XI4uFvTO23fO5od+fDsa6rANj3VeGM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=vCOqGXBP0yAvUnXRFuUWrKq6Tf0uB2jO79BXFK8nMPyQB5ipGzTsLLfp860EuZxG2LxIbyQRWcVLfOy+Chx4zXLfrDS/j7p9ad++c21t8e8deXzOqfFzYyx1HYpIdb+zKylQlfLxLEBuzhSkLNgGYwLrcxnUPSFEZjmUwN7Fjvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0MzceUg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0MzceUg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4281faefea9so39318915e9.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 21:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722571857; x=1723176657; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPgymNSFqMGy8q4Q/d74fEzd02s89rlrkqP+PWUZPdA=;
        b=d0MzceUg6vWgHh6ucJcdEVzkjYuxCt2DJ0XBi5DJm5Hkt8DL88WpIIXC/KsKXaHVFR
         eyijaZSXxtY+tQ9BnfxQFGzsE/bVo/JDWwMH/SytlErVQ4oRS9Tq/N3U2Jxw4XuJ1Di7
         efMsEXcLd+qscuIsQXH8FcmgOppH5VI2DV7Sh7Z2vgOTQRL5LNzpptBc5MblGJ8fb4fb
         qAbpXhHO/gk8OMfwwZk+bSlkP1j6QzOxIDCZPg2g150dQeBTiMaI1+KCemeX+TtOwXDb
         2gtmsaL+LNiCeNWqxv0iGHhEJvSVqvm1SdSKu03P+6j/sipdHjnvnnzJibUkUVjDHd1x
         sNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722571857; x=1723176657;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPgymNSFqMGy8q4Q/d74fEzd02s89rlrkqP+PWUZPdA=;
        b=WAlOFt2OFHHWYMpMuOIOh0kd1XKrXSI5ldTVnD5f65RxwgUGTiUFnPQ0cWQrsLy7b7
         VfvKPYo6Mq5D8y0tY1j0qjrV/GVJOvBCFyL8x33zvfoyg/RUn3imx+oCuEsp5bpSuq4c
         GrkQ23K5ouVVt/OM2jWxi5XxYLTdKKjzAaKKPDwnGUsMX61JzM7aACY6fHQXNFCmsPDn
         HMLY6ajq4OYVc74rzXC6GZkA/WPiv7uH5fMQ8rJnQIw2s+YotC+uSRRlO0FUDeOoF/U1
         io9KaLAalme//atARK/OYYmrSNapPnqgMr+0+6KOCixC4qDg77e7Ba7AS2thjnm+5VUz
         v6pw==
X-Gm-Message-State: AOJu0YxSyRi2gACnL2479uc93KOfzyid0kcGo5/PXn6JZokQpNjIDIfw
	9YLBuJpXNCNHT9R68Hgvh6bh2WWRO2fnU20Ifwn5j+I4ZzsUePllPQSXHA==
X-Google-Smtp-Source: AGHT+IHq0sXsW8xtpgp1vEq+h7LVuJsYObslkvhh3hdKeVUFBryOCGfvdmkJSWnKLtmwSTh+mtIAag==
X-Received: by 2002:a5d:4844:0:b0:368:7fca:9040 with SMTP id ffacd0b85a97d-36bbc1bcbedmr1143287f8f.39.1722571856974;
        Thu, 01 Aug 2024 21:10:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd26f9c2sm904633f8f.116.2024.08.01.21.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 21:10:56 -0700 (PDT)
Message-Id: <6c08b8ceb2b87671a3e57c09e4e45170eaac37fc.1722571853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 04:10:53 +0000
Subject: [PATCH 3/3] t6421: fix test to work when repo dir contains d0
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
Cc: Kyle Lippincott <spectral@google.com>,
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
 t/t6421-merge-partial-clone.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 711b709e755..0f312ac93dc 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -231,7 +231,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded for single relev
 		test_cmp expect actual &&
 
 		# Check the number of fetch commands exec-ed
-		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
 		test_line_count = 2 fetches &&
 
 		git rev-list --objects --all --missing=print |
@@ -319,7 +319,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded when a directory
 		test_cmp expect actual &&
 
 		# Check the number of fetch commands exec-ed
-		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
 		test_line_count = 1 fetches &&
 
 		git rev-list --objects --all --missing=print |
@@ -423,7 +423,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded with lots of ren
 		test_cmp expect actual &&
 
 		# Check the number of fetch commands exec-ed
-		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
 		test_line_count = 4 fetches &&
 
 		git rev-list --objects --all --missing=print |
-- 
gitgitgadget
