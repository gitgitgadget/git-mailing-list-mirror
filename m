Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBBE26CE18
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491725; cv=none; b=IQA7eQf3DFHdNysosrrwjWcnCoU4w/Sd+tK6Uqfn5mlP8xJY7vJBYY0LYQrXMkNz8FKdZQ3BqOJavxdzBDYiE/dBK3XBOGfEFyCsKLXm6VBKqCzkCyOX4cSsTWDzO/U1gz4OgcFa2j0pSf+GjDMzinHLVhr7ThxipKy7SPgiU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491725; c=relaxed/simple;
	bh=1+EeG2i1Pse7vHixbby4A6VdGB086qur5ySU+hs5lHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEwSnP6R5h+lXJM++s7JQCLsyw8B4crAX4AsBwybwR5HH64dr+JN+IE2gr3WulkemliUAi4l6mhY58LkO8ni9JN/ICqkJ0WdpPO8rSBkkz7ydDWPCe/s3qKUKaE5eIT/t8JbpY2D3vt2EaOvKRkuWWB0zBCePt7wAxGmiz/DByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=ekoppwK6; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="ekoppwK6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751491719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfVohsHJmYHTvY5QaCgbPxsCyjhmucMpGRzOEsN3rYU=;
	b=ekoppwK6aw4LZ8ALbYZJJz518SLMiroptOJcUlCF3uUK8WoLOevqGVON35SOUzQTflXfw7
	mA8Vhbbx3/BQLgQi8z9L09pokjzD5HeK/FtRLr5g4XNnDcJGM202aeMWfsiVSgVn4OYi8d
	pnxR+UBuDKKSI94tCQ92iL+zalUKJk8=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: ray@ameretat.dev
Cc: aclopte@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jason11choca@proton.me,
	kristofferhaugsbakk@fastmail.com,
	rhodges@cisco.com
Subject: [PATCH v2 4/4] apply docs: clarify wording for --intent-to-add
Date: Wed,  2 Jul 2025 17:26:47 -0400
Message-ID: <20250702212814.1923253-5-ray@ameretat.dev>
In-Reply-To: <20250702212814.1923253-1-ray@ameretat.dev>
References: <20250628225819.1294068-2-ray@ameretat.dev>
 <20250702212814.1923253-1-ray@ameretat.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Avoid using a double negative, and keep in mind that --index and
--cached are distinct modes of operation.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
 Documentation/git-apply.adoc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-apply.adoc b/Documentation/git-apply.adoc
index 952518b8af..6c71ee69da 100644
--- a/Documentation/git-apply.adoc
+++ b/Documentation/git-apply.adoc
@@ -75,13 +75,14 @@ OPTIONS
 	tree. If `--check` is in effect, merely check that it would
 	apply cleanly to the index entry.
 
+-N::
 --intent-to-add::
 	When applying the patch only to the working tree, mark new
 	files to be added to the index later (see `--intent-to-add`
-	option in linkgit:git-add[1]). This option is ignored unless
-	running in a Git repository and `--index` is not specified.
-	Note that `--index` could be implied by other options such
-	as `--cached` or `--3way`.
+	option in linkgit:git-add[1]). This option is ignored if
+	`--index` or `--cached` are used, and has no effect outside a Git
+	repository. Note that `--index` could be implied by other options
+	such as `--3way`.
 
 -3::
 --3way::
-- 
2.50.0.201.gfeb04032fb

