Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EDE23774
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770906; cv=none; b=M+RYPQsK2h3waETINqIFg0SjK3NM4/KtHVo0Tq2cruexDMsawEa1kblP0GUkLVwxizPAzSvYsaRrSDFbMDRTiGmcFDpgB07uXaxY1WkqgcixysZMQNkv95AjcE8zRkEkXvQ0qxBKYjUJSabnkNAuOIeKSE6eZYG1TdoEev00JM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770906; c=relaxed/simple;
	bh=ZalYJXi6PyqR/+qf2afr5XHHpxwUCJ2xtWzsxBcx0k4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C3/TqOOuj0bBThg25OqFsrWkVjs5XFv9tAOSwRrraT/onvzHPmAchHQ1UQdCzuXddgtxuCxCpCWxXJ05jossx8Co8+ElTC7TmjNxIDB6J3Vjhgc618Q/RfdZq5D29jDkM6/PQxtXOgyteLiBrGqZbkHYs5AIPOukarHYTzEMy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID9sMvqA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID9sMvqA"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so157936266b.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770902; x=1727375702; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGDyqT+HKcPwso8Y+51Xh1/XWwRs0teRUq8xpwRtrOU=;
        b=ID9sMvqASsTq6t0cg2HycUynwC1N/icx0NaeCiir0pEJxWSEdoAZnqZVM31Dnvn+3x
         3rHukO2AwPsH9vHCgWECMlKOoFXj1U473dyciy168++aHcjtqHb2WXdCDIXLV/SNU32I
         FHSIBI45a1iau4wk3++FbS/kRY1ngOrnOGL+1UrG2o1zVmpko+vYjddAnhzpKPc991Zf
         DQ/lnBcnsLMNEvqPPaCRs3+cWqMSJE0IrV41LnM22AqkKUTZf7KEYpzdNgP2RQTc3p4x
         5mX501WoBWkZnGXN7emLBvS8M/SCfu0qzbxL6SjFjH4LqjVcinSEn9XV820q0NeZUVjP
         PiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770902; x=1727375702;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGDyqT+HKcPwso8Y+51Xh1/XWwRs0teRUq8xpwRtrOU=;
        b=IFQzWbhqFzzTX2mXxWHOL0EF6E27likO7PYVLctXr+Pj13JgQY5xGNCe1nLnHDApxG
         PFnd7ju1nIwtqEZOpXUMBDEJ1q3Ds3wuiPiOVMQedt83W9D2er6so4jsK8VwwTNjEHpk
         kriH3bGGD9YUzYVmdEA0Z/T0IVkLvJl6brAF+cqWAddn4CbFjsNZwUEiXc9YkEiOLk9/
         TbUlRzW/72fqVFhimPp5r7b81FCCw8UAKWUxNOX3ldqcLuFu/eJ7S7U4qYIvCDlsh8++
         a/MaQRTXarFCUeZoJrPI9laX+527StA9e33HVWfyRDvsmCIZ/QnpbgZ5vxZ/vihVM/Pu
         Ik4w==
X-Gm-Message-State: AOJu0YzW/xwHLednC0QBTJ9yuo9WcsBLd+/RLtnxQ/aWJrH488zW2I9e
	14SK5/foqf4Z9SYH/bkJJjfvC4j1tA3w9ecSz4xKuWaQdnAXJGOOIsYggw==
X-Google-Smtp-Source: AGHT+IEhiFxmFpKG08a6MHuG/IckbxyF4jpA2VdId3bpcXT7J7CUUBDavXvV1hJS2UAJLVyHYguW3Q==
X-Received: by 2002:a17:907:1b10:b0:a7a:acae:3415 with SMTP id a640c23a62f3a-a90d4fdf007mr14319466b.10.1726770902100;
        Thu, 19 Sep 2024 11:35:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e1b95sm750486766b.168.2024.09.19.11.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:35:01 -0700 (PDT)
Message-Id: <8095b76e268c4017de3f34ba3d3700281aff8866.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:40 +0000
Subject: [PATCH 20/20] upload-pack: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 upload-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index f03ba3e98be..143bdffa4a8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1802,7 +1802,7 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 			} else {
 				/*
 				 * Request had 'want's but no 'have's so we can
-				 * immedietly go to construct and send a pack.
+				 * immediately go to construct and send a pack.
 				 */
 				state = FETCH_SEND_PACK;
 			}
-- 
gitgitgadget
