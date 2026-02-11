Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B12F3C3D
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783102; cv=none; b=dn6AzRxGFCzcMZmiaHUT8BqsdtJT9oBar+trIgi2FI7OQwDXTIxRk9RthE6SMpGyUn9EmpLoMEeenWu5gXapaTf15FVPXm0q/+7JumobKDlv17lqSzK+gesi0ylAnHQd037WnACIAENMEWgIBjsv7BwC9yMgLZTf2CIm7kkEGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783102; c=relaxed/simple;
	bh=JOHlrpMAZsff5YHQdPVNCQwanV2KWbNbh5d4DJI7bKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bleiiteUC9XYwdnY3qrZ+edEGoxfbl32nBS3ax8R8jPh/0JMECzd7Exepv202R5ASGNoWY7/vb+/rC53VyvrFyoEt1A5/u7t6nlnm8JiybaSbddNfrTyJ0PVXqoBfb4r8z0e+aFkevh8MYZ2KHULXDEXok4exTs5mXA2MRY4jKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ERc6vtdl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ERc6vtdl"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-352f60d6c2fso3248875a91.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 20:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770783100; x=1771387900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCNH4KCQhax9lVCJCVpGCZaNDF7SIFwwepn4cSXXNeA=;
        b=ERc6vtdlfosKMgAyx83m70dghTkvsO11qMFW4RhxHR/8TJFiVCSYzxt6Cg2n4dZI2k
         cCP/vb+REvHLvKaw852lNsmxIYOxGbrTn7g3xD7iXXiSYMfwZCKxAY+ahrevZZw66b7/
         wivl8j+P0qkCGVREKgZ547Yo1gFH3dUi+wCLZmmA0zuUoltLp2NSJvW4Op7dRev9ED7D
         Z7HTxaOI493cGiPeMpFLy/7RaoGpO83MpiQ/gRK4CEwsoHNcznli4kgZ5EuoDMZfWEoq
         S3FvTgLivAtSgyF3njwjlkONphvOK9hPpe4JbYWqLIePwVvUBQeTixLiieS3EeCrS71w
         zlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770783100; x=1771387900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fCNH4KCQhax9lVCJCVpGCZaNDF7SIFwwepn4cSXXNeA=;
        b=g00qMslduYPHZtJJhZ9fiEn6J6Pqkc/Y/wv4eANPfWo/OEsoaJUNP9n3kq8bIjOP8S
         1kbuhwdxFLGG3pmVTfofkmoRLZ2kTlmngfeB6U2FbuqElLCHOZxKkE+HtnKxS4GxIf61
         ujOJRCSlA0u4yYimaCc0oAFlGKmFYxIzEcl0dBt8oSwoEE7uWxUSN/1PfCJFFaqKScEF
         ljYaq+Mw+919TWY3uSrmOmYnwOhJRC0O4zfAUhc8IM7K9WqfxQY659rovHupTA+sx4Td
         Dq9B4SM9k3phBicB0Phe7E/kmmQQH63QvtRpyCtPTKYv9PjJedJkEiBmz1tsVzrTm+46
         ly4Q==
X-Gm-Message-State: AOJu0YwS8R4tgfwyaZ4DNN5oa82FtQa/vOi+GC/vfLwT7BGeq0b2s0WQ
	YX3Vw14p/UEWQxxblpyKORKZgXaplfSELI6Mws/2qVGn7S3QUFWK4DDllisWf/MauBmvKGSmHyJ
	vc+/j
X-Gm-Gg: AZuq6aJwpuPfIGzJ9u7L/nrvKsGbFFAWtLLC6L/1Kjw+FCxfQfX4xeUSAN3Wcj5xQ3c
	sEXUsp7Y4IJZzUeqpWoqG+4Jj2XU+HJUtgjaP7Hjs8UIthUveq6To2gPscFE5fgDEvmVHYlSbw2
	jCAIzFyhsmi7tjwXM6cf/Jjyq12PEbwZi6Mb0aYm5wV2uTGBnczqxIQYqcgQY0TiMTK16IDIGsg
	tCNN2A7vJRkJ2DPbZCA52kGFQxdH2O485mFlFOafhWHvplLUnc4w38oreRSHAQ45HjD1EhSnao0
	/AYm9XylDH7o7ZfvYkcHlh3dPErzNIdjo8GagnvQcnKjQ4megN0GE+wlYRsVK6SU3FMZe2ZHT9R
	mcPJqyIe3pq6g+NjDFYVly5Y1pyJxbQO6C4E4gNoufrkIBmf9r3xiHFFl3CxdKbVhxJaNb5Ogsv
	L+VcMRMKkNuCuze9nytYnpnADC9I+j9cCnjbyOtRNX8qAWOcIzi3qOwone6L9si1Os+w==
X-Received: by 2002:a17:90b:5146:b0:354:a5eb:a64b with SMTP id 98e67ed59e1d1-3567aff9565mr1620489a91.12.1770783100453;
        Tue, 10 Feb 2026 20:11:40 -0800 (PST)
Received: from LTY2K703JV.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e538d6sm4371513a91.3.2026.02.10.20.11.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Feb 2026 20:11:39 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 1/1] diffcore-break: prevent dangling pointer
Date: Wed, 11 Feb 2026 12:11:28 +0800
Message-ID: <20260211041128.48412-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211041128.48412-1-hanyang.tony@bytedance.com>
References: <20260211041128.48412-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After we have freed the file pair, we should set the queue reference to null.
This prevents us from encountering a dangling pointer later on.
---
 diffcore-break.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diffcore-break.c b/diffcore-break.c
index c4c2173f30..9b11fe2fa0 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -222,6 +222,7 @@ void diffcore_break(struct repository *r, int break_score)
 				free(p); /* not diff_free_filepair(), we are
 					  * reusing one and two here.
 					  */
+				q->queue[i] = NULL;
 				continue;
 			}
 		}
-- 
2.52.0

