Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E734751B
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280125; cv=none; b=KYW1UsVopc7HYpK5Jwlqlg8FNQ788ULbETcDfixpMMkrnZXJIKYEpp5AHbGfBRdPPKaNva81hlpqSF+1NLBVI3TKF2oJoZwoFrhvEf6mhVCkCN+n0XPYLl8aq/h3yZC36ezWhRSTG5rbNlDtzsRtI6F+esP1cwdbRXq9wbzFjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280125; c=relaxed/simple;
	bh=YvHSfW22iuuILE7uRkll0AfkLOEgCBgktYTQFh/K2Hw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bhq07Bel7s2p1qYBE7zNj17DqCUfzrTi00YKfmZN7mqtWCOw9O2k1OOZVTWJwLqmf54UQ9kEj36DzSbo+lDurf9BEIa0SEp7ox7d/DkBGtLg+xAQDHLouim5PghoB0K2v+GHaV82G72cDBpjLJECE0p9ySR8VhFXDta2WfyOon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFhaF+Lf; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFhaF+Lf"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664b752eso78657eec.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790280123; x=1790884923; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KRS5SWYMGVvjBrWtqBQdv/BIBtxuDkMCtkx9x7QgPcg=;
        b=UFhaF+Lf30aNg5vImpY4Zhc/t9cvMS7cLWd/0MBEZeOIgr3rUq2lJrQu9QcAFYdM2e
         GI1xXOJRkGaVW19kTizByuJ/qWtps/0ZLCdV4DobZuNQ/Sjg+EUc5oDHX1UIhKoNYSTM
         6M0h/fItkJz9mMzoFGUoghd45Vl4h2CN7SQRu2/2afIZUtGpZXYrpITi8wZ2zeqHRqnB
         24uXLIdShvnXoTvzGoAdoHiRRM/ijcEhyiF7MiSGoDcVdNQ2dh57VZOVRiOFndDpTvqe
         DTIEM9ZPi0c3x7h82pjHc/doubTyNOKW9/uuokyGtBRGxTStqkK7BkIPk1WvDoxcHEUl
         4fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280123; x=1790884923;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KRS5SWYMGVvjBrWtqBQdv/BIBtxuDkMCtkx9x7QgPcg=;
        b=2f4V/ZMvroyz323d9416mfbBWl/5JmxYjoZQQP/qUyvGPk2o86LTn/3qhT72VnEBAi
         aObkl7d4ErgegptARQHIegJpSQYmbL3ctSByv/osKkvqzdi2smG0Gly+SNtgLNsRrX35
         qd4sPf/G1svJuG2lc80q/LD5zSGn2bd+xcubKUa67HTe7oMxFZSasp19TTKzySidkA+9
         fucwQsQJbENqvRCzXi1fYUJQjXBMRd8TYb03gMotMhKwjTvDAAPTs9PyfUc6yK2dRYge
         7iuNEr8RZCOya/kjrIF1mT5D0kj5sTCxOcfCDAnOt3tznNBrgcoG2jwgYih/gb4kT/sI
         z69g==
X-Gm-Message-State: AFuF++kyx1FiQiyi+d5GMU6ZAD/S53ZuLJtgSBt9b8fHvGyXE60cM3NJ
	+zByu9h08Bgtnb4LuBCh7GX/uGulz1WacaJtO7LJqweQeTxzRMluvlhwqapf+EeR
X-Gm-Gg: AYBFou0H207RYIVsrRyeBVHF7e/uDascTJ/y6Fz2PJudi4PMvPyXiqyaGAlSYLjmZJ0
	BH5QlejJjuoZqMm5lrlEyaV0FdFj758MeEO4bAXKiJDX2NtX3AIOxJ+4I5PHGrsiBf8/4i/O+Eh
	VMdtR+n9U5o4rLDxTgZQ8uFY1tbzB6NGOCJrrNOp+nRcJzntOSg+jjp4OG4Ny3HnVOYAZEg/50K
	1lzoIKihCsldfmrbv4/kVs2dJu2gGXKD9co0Pvc3JCyRJQGapj21TYvOptcz6rSOUzRmNIRYPsQ
	fxe4juJ4NhuaqxwGtOOtK9xOwWLXP5emkDiO8Yd3H3Nv4XZpZSxDKatRlWw2ia+69wVPZaIolxQ
	sO/BGhtK/vwxGeveW7YuoEUJ3CzMXWSqV9uUbRLl806c+726vdoi6Imk1TdlQj026FhnIxbgUa8
	upK41+fMQ4WlYdevFqZBCyh9rtemKzW+JKJHeiyO01S5vBAXlJGRlPkjK2TQ8fPiM2hKeyv9jEL
	RutegghUTjypw==
X-Received: by 2002:a05:693c:26c8:b0:328:3cce:4b3b with SMTP id 5a478bee46e88-33ffe743503mr2521628eec.4.1790280122830;
        Thu, 24 Sep 2026 13:02:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3417867c67esm189978eec.30.2026.09.24.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:02:02 -0700 (PDT)
Message-Id: <6703fa0349785a38547ebeab55cd1c5d5b742618.1790280113.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
	<pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 20:01:52 +0000
Subject: [PATCH v2 3/4] ci(gitlab,windows): fix Rust setup for GitLab's MinGW
 build
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
    Karthik Nayak <karthik.188@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

GitLab's MinGW job fails with "cargo: command not found":
https://gitlab.com/git-scm/git/-/jobs/16576450182

86909a94db5d (ci(windows): build with Rust, 2026-09-13) enabled Rust
in the shared CI configuration, but added the necessary setup only
for GitHub Actions.

The build needs Cargo to be reachable after the minimal SDK's login
profile replaces PATH. Installing the toolchain alone is not enough.

Assisted-by: GPT-6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitlab-ci.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index cd6fd4a504..3f24835500 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -133,8 +133,11 @@ build:mingw64:
   before_script:
     - *windows_before_script
     - ./ci/install-sdk.ps1 -directory "git-sdk"
+    - ./ci/install-dependencies.ps1 -Mingw
   script:
-    - git-sdk/usr/bin/bash.exe -l -c 'ci/make-test-artifacts.sh artifacts'
+    # The minimal SDK's profile resets PATH.
+    - git-sdk/usr/bin/bash.exe -l -c
+        'PATH=$PATH:/c/Rust/bin ci/make-test-artifacts.sh artifacts'
   artifacts:
     paths:
       - artifacts
-- 
gitgitgadget

