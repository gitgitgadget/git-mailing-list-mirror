Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253A4A1E
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098094; cv=none; b=L7+LFzYlnpJuLRViV5RJY7tKGBHj4lPpt5ZzoW0N3VsX5xl6Lbtl09W0Sggiyw9UOwVkjmU445xWQVCoGtpd0RlYrXgBt0n4JWw2aKs0eAZo9urbhuSharf061hW4M1HDk/8Qdnvn1HaBG41ZZuw/mENpYWF5HqGS3SXB0Prcys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098094; c=relaxed/simple;
	bh=R3gaY5CH34p0gEU/aSh5uLKJJxBNtXnVzHkcpZjfErM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CdZYILx4sZsrsnsjBZV0FtBYixaz3TnrFqr569O7YfY+Y6+VBe3xtXdyMvvTsOxzU6nGGvGWcUR6NN1apqIs9vPovN7GbF1q8Nf/oic3VnJvw+tUdy9RyR1tCReSKpmShCPucSICe5yqp/8cpgFSOeW9gb+Iu+0JLn1UBvBG6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LrYb7R7F; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LrYb7R7F"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc491f9b55so5929825ad.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723098092; x=1723702892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sVgpjbbpo1kWK65KIucb3DtehG3wf/e/A1tvL9vOPbs=;
        b=LrYb7R7FtQdC2hQCf1l16H40aKdj3QaQsgMc1DHBlq0rWcHxJ1VdwdUdDt9gQxUMrt
         ds6zfYv3rSJYK+W3IrIcxdfgKCwB6GoYAT3Da9AiImC9A91ulUwRa7cZtv5MtT/rWbfJ
         TAIxyNJWZsIa5Wx8xV0dcbuWc9NfH1pKtxnjrQL7hPwEZK7XfhV/fVy2N1oNcHsxJOyZ
         TFrRy9/qNKK6YwhGXU62ZnwK+B4KMUGlYCSH7W08redhXBUavlG5WcJS9RwEdaHYhCmH
         wxGFn7Ksvmkso82L3a7nII/iz/ncMcEJA7Sy0NOULBohMg42fvpmvXy2ebCJ5wSxhkWa
         BfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723098092; x=1723702892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVgpjbbpo1kWK65KIucb3DtehG3wf/e/A1tvL9vOPbs=;
        b=DM5PLzJiXbuQH5OfZI2J+B99nzuLSN/nO5eByhvcy5ICN0FPbLqQDRBWHqViWCvwgn
         WTVXoi0rwNh+dhxw8LFJD6uCvh+N84NjRf/CkETymOEbu4gMqK6nFzWtt6TiB2t/+dEj
         rqev3ytRGO50/vbU0MfgsxTd0eZBvD7BRdWpI9ooWIAH2mqTiQb9RKXZ4VF+Yx/XYACn
         1OcUiCDF23RU2y7LtPbTny6uFXy2Qu+XOSjct9Bc7K1YwdhJxTx/6M5U+jAYe8LX9FFH
         lwloD+2Wmg56lAhQJCKIZ5ELJN0p3Os61a+PdLmPtRdKruwVXUiMDy1Xl961wP2v1wJm
         ENEA==
X-Gm-Message-State: AOJu0YyFK6+rR0zBovFHgLuCoIwyQpw+5jQY7qqIeadp2/TNLEXS2/uH
	3h0MEh1F1q0bBpktYe07oVCbJmm/+z9v6k0XHKGH98WZ1u7FSSGAQoGK5M7qWx1s7EuFbCDYp3s
	O
X-Google-Smtp-Source: AGHT+IHrHxOBOgKjg6SOm1cXU6zt8IPF6YeARPEqNRzMTdtrGrh6NIEymKstsL1Sh1sqt+a1UQ9X5Q==
X-Received: by 2002:a17:902:d508:b0:1fb:d335:b0bf with SMTP id d9443c01a7336-20095252f2emr10539195ad.25.1723098091615;
        Wed, 07 Aug 2024 23:21:31 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29d37sm117054175ad.48.2024.08.07.23.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 23:21:30 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH] doc: pack-objects: clarify --missing option
Date: Thu,  8 Aug 2024 14:21:20 +0800
Message-ID: <20240808062120.34629-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since ee47243d76 (pack-objects: no fetch when allow-{any,promisor},
2020-08-05), we mention that --missing=allow-any and --missing=allow-promisor
do not fetch missing objects. But this is only true for missing objects
that are discovered during object traversal. We will still fetch
missing objects read from stdin.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
objects read from stdin ignore --missing option, if the repo has
promisor remote, we will try to fetch missing objects. Even if
the missing objects is not "EXPECTED promisor missing objects".
"--missing=allow-promisor" will not raise an error on such cases.

 Documentation/git-pack-objects.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index e32404c6aa..0c1f86dabe 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -313,13 +313,14 @@ attempt to fetch missing objects will be made before declaring them missing.
 This is the default action.
 +
 The form '--missing=allow-any' will allow object traversal to continue
-if a missing object is encountered.  No fetch of a missing object will occur.
-Missing objects will silently be omitted from the results.
+if a missing object is encountered.  No fetch of a missing object will occur
+during object traversal. Missing objects will silently be omitted from the
+results.
 +
 The form '--missing=allow-promisor' is like 'allow-any', but will only
 allow object traversal to continue for EXPECTED promisor missing objects.
-No fetch of a missing object will occur.  An unexpected missing object will
-raise an error.
+No fetch of a missing object will occur during object traversal.
+An unexpected missing object will raise an error.
 
 --exclude-promisor-objects::
 	Omit objects that are known to be in the promisor remote.  (This
-- 
2.45.2

