Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC43A75BB
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266071; cv=none; b=pNJCDrp4iZ6CdC/Vuzkyeqrl8UxKqxgeBX+5+CE/ICTbhgnEibapqG5ZnDtOb5pPUtUUFWDEympze/YG/Fxo2SUqT42qvmKb6i7OJ23CciWXP0mVT5+NAFfl2pOTCH1pd024pm4s1nPZSW35gYno2L2e4tyJC3wc89ray7bsEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266071; c=relaxed/simple;
	bh=Az1EmpzrTGdgPcCaxCDlwyTjp9E3IbkaWag1J0HmTQc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C7VutIC4WAz4vp21fjifdb2XnsNcmbEtQp/92HS8k8zIjsoWowW9aHWd2AVYERKEJg2KEjMI+8RBSSBiB01z5NrQEr6xTFPr9PpV0z3VXMZlnHBbbQwsvp7kB/CuK1HFOwJsO0jiremTfo6q+TVzxmq/Txz3pvc84/kdlA1xTeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImxX0R9a; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImxX0R9a"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cfc5941028so995824885a.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266069; x=1776870869; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0xpe4rdiGBjb6BuGD+QuyBBDw82WfvfL45Lch7FTAA=;
        b=ImxX0R9ayH4ckWp22F7Y288IvSL/7AEcgSJ5ncHFJh4h/WjJLoaRb//rs/sTN+0kNc
         c8mvsErIewElW6216Fj3kRX/Dp4HNE00DguqsZekbN4OnKX/huF9CEeUOwxuoIjd63iG
         YUbX0bG5Qu8OQemFNoRgqCRUxUUde61d9c5oOsOrJ6t+xmuXyj/3J8TkChc+/SevZYBe
         UNJe9EEhBcsJQF/zi5vNCZwW9Vkzt/GFR8ILSK72LXMiSWPjBvrjogeDCo6we7mrPtcS
         W9QyeFv1+EBjn1Nxm4jnmS+a9/hiGa2L/HWpJr+9jxgymCONZYePW784t+dE0QFGPDaI
         WqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266069; x=1776870869;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0xpe4rdiGBjb6BuGD+QuyBBDw82WfvfL45Lch7FTAA=;
        b=Rn/WBo3Njm+bjD2j5iL24Mg0QJkppdml55XwzWOmVp0y2feeZ56JdkKhg6DwYIvQOu
         D/tFsyG6YlEwCIzjrvW9bFQgIIFj9gYKeEta1kbBTPvR8fRMlsRhBtT0GHbhTfKCkfMx
         wHWfUSSn5KETPGhb5cq4gUEUksiH86jQkUoP/dpZ9D9nwi8di0QVATnlpmxErLhBRdKu
         6DDOBZXvRKcmqJrMnn+XbkXudBt5oZnmYwPWY3F3KlsfpJTzaOIdtVZzbt5p6IIDSIMB
         N8eNJ6OQ2d1h37waahTb1QmiFrevRLwq0FGpJCcFMXCqGUViAYBTMfGMRMwSnluy1NGX
         9o5A==
X-Gm-Message-State: AOJu0Ywxt/FAYBjeo7VVsYRTuqHdsxfujmUtoE1DM9MRoAAm5g0+0MAX
	cvalytjS3K+4/pf/zW2uIhZg2Ja81ssjcV2wzYBKci7Z3YdAwRAvyY+UdUgaEA==
X-Gm-Gg: AeBDiesjkXmoH36HHYrIcg1Og4qQ5MSZoesZW5kOxs5CTxqTE6KuFK1kMPW2OqN4Cjz
	dfxQRYXfxZUK13VSLcCEjXrISkaUezaCDn9yK2NMX6JNgeBiVoyl/9SBrHHvE5u8ZHT2rJfKCHD
	1IqD/sGtnY32w7TgKjHLiPUV/2hqCmcgLEd3n6kHCO+H0ZADE8uXxDsukiMI9nOJkX87+ShI4GB
	42Kfbn+JtjMntlU7Dv2fpgC2B+FnVYfJd3j/xaDm1h4CE90WZq0NKAcq2J9LQsJUm1O59q6Xcx/
	r9x53SPj2+S5VQhGYGcuNBlF2HWLEYEqatDEUEZcgl+imOdacQDEvsBXdEL3T8ZuEmSoxhnrykj
	0CRFEDFDUA1wxwJIJdJnJSDcCeGMic8VBi9WZ5GH2fG3pv54Oz4BONFekkFFuDytjanYkDGGMOP
	ZsS5bUe+4MmVIC/EiUaXB1oUlX
X-Received: by 2002:a05:622a:ca:b0:50d:e69c:fddd with SMTP id d75a77b69052e-50de69d0ab2mr263568701cf.36.1776266068942;
        Wed, 15 Apr 2026 08:14:28 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.13.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9da11sm14800031cf.17.2026.04.15.08.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:14:28 -0700 (PDT)
Message-Id: <466c56abe002ed2ac8cf0da2d6d1d8c288cd232b.1776266066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
	<pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 15:14:20 +0000
Subject: [PATCH v2 1/7] t5516: fix test order flakiness
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'fetch follows tags by default' test sorts using 'sort -k 4', but
for-each-ref output only has 3 columns. This relies on sort treating
records with fewer fields as having an empty fourth field, which may
produce unstable results depending on locale. Use 'sort -k 3' to match
the actual number of columns in the output.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 29e2f17608..ac8447f21e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1349,7 +1349,7 @@ test_expect_success 'fetch follows tags by default' '
 		git for-each-ref >tmp1 &&
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/HEAD|p"  |
-		sort -k 4 >../expect
+		sort -k 3 >../expect
 	) &&
 	test_when_finished "rm -rf dst" &&
 	git init dst &&
-- 
gitgitgadget

