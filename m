Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35692158872
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757002; cv=none; b=e6nVsXlf3lZX4R5qA7tC6QShjwvp01qXH3VKybfquVNCuVeBLzExQotKnUoMW8KOcLV2EoEKLVyT3cLziCQrsL8EdXxFhiu0GGdGFwpH4MNyDhepLu1piqMpVd4XeB9GYNiVMHTRkgnoiN5T6dcqfHkIQotc8xi2l0oPqsEBB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757002; c=relaxed/simple;
	bh=ImeOsnL34aJuDh8axgha4e3hdmEIP4bjuaztPZdaQM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVpqE5rEXnJWoGyerpib9MR9rW88efh2Qf8bETkIWCPI7qdvt8j1EAPH8odvvymCm9wM2fYWW6Ocyqo6W5B2koBndFWiZkfvm8xIQKEVsCjRcXBJqBygkmS1pQBFgsSO7DCHXKOF4J29kvzoq48mNWKTIty5q97cgflPNQJhdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IebbLMA5; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IebbLMA5"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ef98eee195so939930a34.1
        for <git@vger.kernel.org>; Fri, 03 May 2024 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714757000; x=1715361800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFYRrHJnj2Ftb7bcZDOjFcHuHpxB93oQkzwCgChwr+I=;
        b=IebbLMA5ynhSSDTuyc2sRX5OMDE8StPzIR8LYpfgGzRi8tIVn9GYnxoJJlwvEf8Yxi
         5F9CwDhmGtSoMM1U7s2Hs1sVaCn1xu3tT6Q8wj1v7oIm1C9GKs1h/LVSeqhQlBmy3ZoZ
         COmSwjlr576I3Gy4HEm5D9euQjdg8k6knakSX8lukvVnimHCMtjWt0e/k1VnMJkWBwKa
         GNq7JmUl0DAbEulLWFzViZz9T9b8sUP6oCH6MfkhNrmsh7DQD5Ga3jKpNrPu0hH6VkjH
         qI9Vp+BZkmIjNkcUtGubNkunZAgeGsNkuYSZbNlHvnMRAfn7LnXzK2e/gM5OTQjsbuLT
         YgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714757000; x=1715361800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFYRrHJnj2Ftb7bcZDOjFcHuHpxB93oQkzwCgChwr+I=;
        b=ZlwJsb3K07mZ///Otzd/ol90kRzeIx/0ZkHkXbhTtLjrbosb3CmY77gNgJDYoLmd04
         02HNrhVmUNe1RATDDMC7uCAAJ2zDN2rRJSkqz7CBrwuhgkK7uqsW5NArYMAqbjHoFdcA
         D8qIFK0+E4ewHRxdSnh3nsC82PmKHK81rfBd9SHD5ylRTxbcfD/lZAac/pwl/hrNVGgU
         Wfzce6vWxzFD2rlSIAYs3Db57p4RRt/2kTbrOKwWlo3J8kxcgUFw6iAbVK6eZ8LVurHU
         UqnwlC0Qx5MrT6vwvc+q6ABdAd8JUg1ormCaxau2V1QbvlizRtFyKjDPaC4e5y/mSq5n
         hvTg==
X-Gm-Message-State: AOJu0Yy22123urj/dP7bBT/j3jz0yB1MT9Sf3wG+SDVUmfV6Q9o0wWXF
	qb/EGciAiH5l8zNL1gf5mMKQpOK4InPmXPkUWroagrSXrdK/Ks6/8dR2/w==
X-Google-Smtp-Source: AGHT+IGVsCRcZAn22W7nH03QeZyCb9LhSp7gJI+VlRvQrc1pHzAHrxLDPk/K+CLa5KlSSUXkDy46Nw==
X-Received: by 2002:a05:6830:108a:b0:6eb:a637:97aa with SMTP id y10-20020a056830108a00b006eba63797aamr3870140oto.21.1714757000028;
        Fri, 03 May 2024 10:23:20 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id cy14-20020a056830698e00b006eb7b0ee326sm705212otb.65.2024.05.03.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:23:19 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 5/5] gitlab-ci: add whitespace error check
Date: Fri,  3 May 2024 12:21:07 -0500
Message-ID: <20240503172110.181326-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503172110.181326-1-jltobler@gmail.com>
References: <20240502193840.105355-1-jltobler@gmail.com>
 <20240503172110.181326-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GitLab CI does not have a job to check for whitespace errors introduced
by a set of changes. Reuse the existing generic `whitespace-check.sh` to
create the job for GitLab pipelines.

Note that the `$CI_MERGE_REQUEST_TARGET_BRANCH_SHA` variable is only
available in GitLab merge request pipelines and therefore the CI job is
configured to only run as part of those pipelines.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 .gitlab-ci.yml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c0fa2fe90b..619bf729fa 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -102,3 +102,12 @@ static-analysis:
   script:
     - ./ci/run-static-analysis.sh
     - ./ci/check-directional-formatting.bash
+
+check-whitespace:
+  image: ubuntu:latest
+  before_script:
+    - ./ci/install-dependencies.sh
+  script:
+    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+  rules:
+    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
-- 
2.45.0

