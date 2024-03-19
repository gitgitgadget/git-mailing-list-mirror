Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5627D3FB
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841950; cv=none; b=RSUyOIOeudcp3iLkwPQO4EiUhXRbuzCCaEFxYL+KRLvBLLSmk57voJfiFLyqqgtpDIyGNQIG+ZtoCgvWNxKXcT6Ye/fQUN7vh8MMC5WJnBb3OrlBrhFvFCd55gLbzt4nh8J0HQzQkVnIhVzA8itdDmXj956MMj6Ia0wRBdPA728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841950; c=relaxed/simple;
	bh=PzOQz5DQeMbTtLnT7oeFFajUlS0pMXxdeptWWvFRnKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLf5BmAPs7yCdSX4YxbarbdpnJajmiAmOLxc18X/MQq/FAAafeEQ442TsO0WyadtMg7hOHHFuNGIOnL0Lth3BIQalaiBWsqJuBUaqb87uRNMfaB9L0inv1hCsgA1Zmh4vpORwvsZ1Fa0s2lIi6waMFhQkiYhL3t2VLBfHZfdGtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QnO3x2EH; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QnO3x2EH"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e152c757a5so3246358a12.2
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710841947; x=1711446747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSVDde6HMW0kVUad+0n1588aVKOpu7EVXKmKqqVYAP0=;
        b=QnO3x2EHfJvCl+ssq3gKoZM4jIlXO4tcSa9WXKMMBl4RLWTzlp+cIrQF7Ycduzjt2j
         bXIrjOjFN87yX+ZdkkYHloK0o8ErCZcPkYc59efHUztr2LXXmbBt+msVMPuhWWRPh7Xr
         tX31tErxhKq+VOHxM+oD4ajgH7SBaB81AH6X86ppb8TEUAWsbbX/kr6m13ucGN1/QauM
         Di+/q5Bd4ivP3nGmuMUj20JdhcXuxW9y4fQBZAzOEFRwS8e+VAR0hOEBICSvbRm7kpL/
         QF2WKGA5fEBx1MdCtw6OqnFeEhk7uwWTebKSS26hqg/GUZKexpLm3MlQ4pR4xDAGYK8M
         wr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841947; x=1711446747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSVDde6HMW0kVUad+0n1588aVKOpu7EVXKmKqqVYAP0=;
        b=eMDjWtnp5ZmJ0OKnUzp1wmDTCTfYy4Hb4A2RUajhr/0f4dqPA6U0BAjpGsjSs4B0tH
         0XoiRFAJYqIT7yUq2sbiGHf8cySZ5jBmxNE4eeKSiGu7+Mr9taQXpFc756alaCvv+XSE
         q8oxv704yjOKlh0RlBlngxSCrCU5euQDJbfDATkfBtzXkP3fIy8BvHV2metABk5v25qA
         EbxmvMPMC0Kz/oZN3h1ei80KAX0fobqGvC1+Yd65R9OWbTjtz0JNCvpQQdQBT1GrGJdv
         LxRxWlq537BDufypIgjxFD79xwfDF+vX6uS707RKlC0aowgD4qWXlTlOW2sNzdexTPSo
         HQcQ==
X-Gm-Message-State: AOJu0Yw0r6MNNdgH5eku1xPrS7Suwd4klZLtdnsD9UFSCZAwC7aJcVpU
	hBB++HWvBtrCc7a2lKARmPzfqB33grSWC49ymuM7dzl+KH469t3iJTyQS3u2W2p24X5yNiDpbfk
	L
X-Google-Smtp-Source: AGHT+IHqmNDPJRNlwN2uyg5R2Uhvxwgbb54U3DrUlAQ5796+iOmilInFRp6GGBCOUN2aFmIRsics1A==
X-Received: by 2002:a17:902:eb8f:b0:1e0:4dfd:c121 with SMTP id q15-20020a170902eb8f00b001e04dfdc121mr665763plg.68.1710841947017;
        Tue, 19 Mar 2024 02:52:27 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.152])
        by smtp.gmail.com with ESMTPSA id kt7-20020a170903088700b001d9b537ad0bsm10958653plb.275.2024.03.19.02.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:52:26 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 1/1] quote: quote space
Date: Tue, 19 Mar 2024 17:52:12 +0800
Message-ID: <20240319095212.42332-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319095212.42332-1-hanyang.tony@bytedance.com>
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git_header_name()` in apply.c uses space as separator between the preimage and postimage pathname, filename with space in them normally won't cause apply to fail because `git_header_name()` isn't using simple split. However, if the pathname has a directory whose name ending with space will lead to `skip_tree_prefix()` mistake the path as an absolute path, and git am fails with

	error: git diff header lacks filename information when removing 1 leading pathname component

The simplest fix to this edge case is to quote every path with space, even if the space is not at directory name end.
---
 quote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/quote.c b/quote.c
index 3c05194496..ecbbaed061 100644
--- a/quote.c
+++ b/quote.c
@@ -222,7 +222,7 @@ static signed char const cq_lookup[256] = {
 	/* 0x00 */   1,   1,   1,   1,   1,   1,   1, 'a',
 	/* 0x08 */ 'b', 't', 'n', 'v', 'f', 'r',   1,   1,
 	/* 0x10 */ X16(1),
-	/* 0x20 */  -1,  -1, '"',  -1,  -1,  -1,  -1,  -1,
+	/* 0x20 */  1,  -1, '"',  -1,  -1,  -1,  -1,  -1,
 	/* 0x28 */ X16(-1), X16(-1), X16(-1),
 	/* 0x58 */  -1,  -1,  -1,  -1,'\\',  -1,  -1,  -1,
 	/* 0x60 */ X16(-1), X8(-1),
-- 
2.44.0

