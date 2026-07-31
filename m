Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC883B71CB
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492664; cv=none; b=AbDoHRTQVIx3311tHiJGiYDThbhvXwkekeijSIfKoyfhOhfd5LhAjzCJN9zarsxnLig9f08/+EoHwCcIjk4VR9FzSl9WrLraSyPVdZZlPUbMLUKWtZ1+c/YR0pp/DxebIjPeS6STyCnt8+AVdKzuYo+azYbzA5fOSetyItrg9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492664; c=relaxed/simple;
	bh=g1meq6eSLpKvoWPYiBcQSXFeBF2oCCajcY29hcTnA4s=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=S8RgyjPOvGTOTaQO0iXinQDWR4XK0G98/xsS2G3e+VZiXbFzTYrqu43fIs6Tpqv7MxheNXfPgshZn1X8aZNqobvArntn8HHgD/PBUbv6eqv53QHdKljyG2SrWz5L271k112kaUoL25dGqAiaaKn21S8OwOCx7vpv0tnuGDJpcDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPXqH+B0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPXqH+B0"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ed2a06b9eso7740687b3.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 03:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785492645; x=1786097445; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W0hL/ADqJySTbR8LxAK6dALe5H4y+v2CIInU30VgcuM=;
        b=GPXqH+B0mMCPcxVZD/YF1jDYu1iGtoBEn2cN7YqeltsFk6AiUCJa0FmaJmCLtsvySN
         yoJfoFsGMDbBckZavjkYO5zwV2rNs5MKokVK8R5Hbfjog9vOl0+jgdwn60c1exwcI9qV
         YmJh7mJn/aqkKAGpHezWRtiF2JwIRoWQwm+cLxPBnTM/bPngAb6pdm+xC3Cj+rlRMQfZ
         YpmvkLparCJydU7LHVn9MSMmH9AcGw6BLkh0Lp76+QgsvjszOZfgw0e2Z9nB2iabIaMH
         iQ+wBzfHJtD9uu6CTd7bnD2Kt82TO3YVdy9TVBmHWeeIsRw1Mgt80ap4xOpGfrDtsM2X
         XtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785492645; x=1786097445;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W0hL/ADqJySTbR8LxAK6dALe5H4y+v2CIInU30VgcuM=;
        b=JmRSbgCMtJGEZYG9cJckGVeJJojMcX4cCAjQlfi8g70pNJJo3RbIJ8vhdnUw7sbt4j
         UdCXKb3wRG13W9eTLqlOqLINSNVAPIMvH/uEpKYoFdWy6mKlVFNjnB8U6aly1oBlOhAK
         zdZeMK/gs5MALGzVIOM5iEnudvxuZtrjdk67jtZLNeNvwgJYDhJZgA+chHvwmfpWFEO2
         9zICa4WSjRM6AIy5xC8jUtfti+v6+FssL0mmu+1TRav2l6uniD7O37C1ifVZXxw7xihP
         W+Kn8KJMU6Qx5gxqhmSFjLUGYY7WjosjigFPiv0hebc9Msj9UfPy3+/mnKxZTITsHUt7
         yrIQ==
X-Gm-Message-State: AOJu0YxFjQWg4pMvSVUV4eJKswHN7+bAiouI31p3JSUuP9dAEyyUOAtO
	BYttOkRitQC8cWgHzCladYKJAWvymdgYOKHUzCBOO5dhPrMBFuASU8tWQmBdYQ==
X-Gm-Gg: AR+sD10lmGYiY1xs3c4dokbupE9o/1sV01P4hFFuwMHtMzgCjopKchEhWb4qVvf5yZU
	2yAyZ4N30Ip8sE+em9p9r9Bv1OU4qLV63xxSkYtn2867jDMLLzQu1R4ZA/PWHq2trIXZZQFPHHi
	OIZZjk11JORMocNSk2KbxrZwWWgZFHX4NXKd84rnFq6zh4JjVzdNiHcrREpnOetdBYhJsqlCnmw
	IzmZDXZKcSERqRH7M+2QNmnGDqe7lTggC6a61C0fIswDeg/8+L3NaJz1na4jgufih0KPdxZ7AM2
	G5p+Dv0vVx9ErSZ9V8z0EYIH4+7j07+pct+nHedXEgK6W8Qs6zmMVkMH9/w29ItR++moQbvUst9
	1Sz54pOGD0YYOjHNXpTM2KsBXb9j+6NO4HxX//vtBzJY17hd5cQhmQ3j8bh//KVBNC0RIb6C/CR
	f3nt5OtIrRQF21p135CivILb66Hw1auypCsqZvRS8PpWl5wUqdy47UQrGSDGf8HI4=
X-Received: by 2002:a05:690c:4442:b0:80b:a6a3:937c with SMTP id 00721157ae682-81fcbabacc9mr10468717b3.20.1785492644811;
        Fri, 31 Jul 2026 03:10:44 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.18])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf2e239sm4212667b3.5.2026.07.31.03.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:10:42 -0700 (PDT)
Message-Id: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 31 Jul 2026 10:10:41 +0000
Subject: [PATCH] ci: cancel stale pull request workflow runs
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The CI workflow groups runs by commit hash, so every push to a pull
request starts a separate workflow run. Group pull request runs by pull
request number and cancel runs superseded by a newer push, while keeping
push events grouped by commit hash for the skip-if-redundant behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    ci: cancel stale pull request workflow runs
    
    Group CI workflow runs by pull request and cancel older revisions so
    only the latest push consumes runner capacity.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2369%2FHaraldNordgren%2Fcancel-stale-pr-ci-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2369/HaraldNordgren/cancel-stale-pr-ci-v1
Pull-Request: https://github.com/git/git/pull/2369

 .github/workflows/main.yml | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 85cfedf5b0..1dc4ca121c 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -5,18 +5,20 @@ on: [push, pull_request]
 env:
   DEVELOPER: 1
 
-# If more than one workflow run is triggered for the very same commit hash
-# (which happens when multiple branches pointing to the same commit), only
-# the first one is allowed to run, the second will be kept in the "queued"
-# state. This allows a successful completion of the first run to be reused
-# in the second run via the `skip-if-redundant` logic in the `config` job.
+# For pull requests, only the latest workflow run is allowed to proceed.
+# Older runs are canceled when a new revision is pushed.
 #
-# The only caveat is that if a workflow run is triggered for the same commit
-# hash that another run is already being held, that latter run will be
-# canceled. For more details about the `concurrency` attribute, see:
+# For pushes, if more than one workflow run is triggered for the very same
+# commit hash (which happens when multiple branches point to the same commit),
+# only the first one is allowed to run. This allows a successful completion of
+# the first run to be reused in the second run via the `skip-if-redundant`
+# logic in the `config` job.
+#
+# For more details about the `concurrency` attribute, see:
 # https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency
 concurrency:
-  group: ${{ github.sha }}
+  group: ${{ github.workflow }}-${{ github.event.pull_request.number || github.sha }}
+  cancel-in-progress: ${{ github.event_name == 'pull_request' }}
 
 jobs:
   ci-config:

base-commit: a97fcc37c2bc6340a8d7ce78dedf227aac4e9aa7
-- 
gitgitgadget
