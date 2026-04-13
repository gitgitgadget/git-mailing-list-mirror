Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CB306B0A
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097462; cv=none; b=IuI3u9S0Ev+078YXVR9Ov5Waj0JZUTS0lDZDWB38jcAqJLzMPL4Pp/QtPTTOG4QH6lCp4zLTxMddVVJwb4ODHxA2+kMw1ae6ZUIuqBBy0byj+B3F0Pty1oV0whE1Sxq/f5zFWUNBloTXmTz1N4YuAQBznFBsnsHrFT95XVVFDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097462; c=relaxed/simple;
	bh=qD7/bB0d/Vb1rwklVvz8LKqB825UbOP0nytPTyAf228=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=s1vqxiQTaHHyieJ9VjPxjZcM5X70dAw2OVfIFm3jtJf1rldOtxOO62r2tS7WAwf4eYA77lKP9Lgw2eNdlW4s18eTOEIXBssqVbd5d2wAHoe1WjRSR9HKs4eoUtc2WgNF3Q4JJyWmKYvQDi/xgSvP7QP4fX8DFEWOBkGniE75vyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkgESUPf; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkgESUPf"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c3d30564eso403828c88.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776097460; x=1776702260; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q5LHcZ2pf5iO/CgiWnRR5bvVKYGggmO42FXAE4W+JI0=;
        b=TkgESUPfEhhQyk3FKIBG92T3wP9VYwAk4rtE/wb5ME80UYQg53g8dMeOBx0urU11t0
         QZC18A15e+QPszLaeWV/FrxJ50Xw307LQKNBNEUScjxIY2eKPZF0sNqCFtTm8Yr/feR9
         GmMa5yIIsBFPUHobZnBUG5Mcy2UgsYyNjwHB054YTFsWu1CeU8NTijvRDAp8/RYJ3L94
         vEVbTCl8vJIJvVNcq9kfol5K3khJYJRvRFJyUwiqhjxAkCpJ/oT12YygKzp0atZ7o+DV
         SaelM3eAbKt787s/eQN0BKLZOjMHAJeQYC7y99xLnzgyTlb7W+d7HK0+KMms1RaVBbQV
         ikwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776097460; x=1776702260;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5LHcZ2pf5iO/CgiWnRR5bvVKYGggmO42FXAE4W+JI0=;
        b=NemW/4zOLaVKaDzOrKdL9ldch3iz63hdgC9OHeka1vI8hS2oBot4VU6FVt53P/bl06
         AtTs2aRc2Bt/gSSIR6ov5AZRgrfnZtHUznPTm7T+WCX21f5GI6QGejujgHoMwnAwFgiN
         sl9x63QVbrLSnxsCuJCFJM/8OVJ34vxmkPNpE3S8aakLGXNrH6QFbU+ZC300CkxJLFeA
         0FXvMOE1XlYAF7OXrPNJP2MEW5kznPZ1ztkZvfdWWTbu9HtmSuXWaN7faKuTFq3QqMY6
         9zFp7B+1GM2ggIuSy/W3J/T0N5/JO0wEIpn4KyIAy4hIhOV55cS3uKxa6VrajSP5sVBD
         Wnbw==
X-Gm-Message-State: AOJu0YxCU97g/aDMqGFxicJKkERD4BpQmShgqBnQq/rk3iOtbkbLICsh
	oDp+InIicOKdx/jCwNMbHKfVAjZEavX8hOYenJvsdnQrjjnEGbzw0aDVTdmx9A==
X-Gm-Gg: AeBDiet6vhdIDmIBBk4BZRnyuC3ZiHvEaArEOifX98kJl6VdcOG++VE3ZbY+x4/98TQ
	1ljOXLdwJYlM6nNz/GjvFtKdEM1vOc/7nJ53VQUWF4EgyhwpeP+8UlqOfOhaGzcGq6Q1i23JcZY
	Dy5InwM0/tfi/WWk+dMHCDhhHpRNJtyyNwwkxqUy8GXYqbqmiN4pSY78JQq7cmsOs26nQ7RDpIt
	M3rstURuUii9Dcwge9R3K0QyF5vO12zfegxnynL/F+jQyTgJaOlaOgOXWpGLN9GTeaRW9vbT/0n
	+eMrJzXOFGYFVpOCEotvMC9jataBK+oPIvV1y1KczzGN0wsuWsG6N+194/VKT/U1BcEbvYuVJu7
	qvZttKZfjpf5W1zNRyZR9F/2VTih/cf/LuKuOQf1tdsdT0kUmBAp2FhEY4HJEkbGSqKIfwY3YZo
	uVJeBQT7x7E8wTm6LTIq5altEK5SE=
X-Received: by 2002:a05:7022:ba3:b0:12a:6c84:6054 with SMTP id a92af1059eb24-12c34f099c4mr8313367c88.35.1776097459952;
        Mon, 13 Apr 2026 09:24:19 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c3459f7ffsm14281880c88.3.2026.04.13.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:24:18 -0700 (PDT)
Message-Id: <pull.2086.git.1776097457136.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Apr 2026 16:24:17 +0000
Subject: [PATCH] codeql: bump actions/cache from 4 to 5
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Bumps [actions/cache](https://github.com/actions/cache) from 4 to 5.
- [Release notes](https://github.com/actions/cache/releases)
- [Changelog](https://github.com/actions/cache/blob/main/RELEASES.md)
- [Commits](https://github.com/actions/cache/compare/v4...v5)

---
    codeql: bump actions/cache from 4 to 5
    
    Just a regular GitHub Actions bump

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2086%2Fgit-for-windows%2Fdependabot%2Fgithub_actions%2Factions%2Fcache-5-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2086/git-for-windows/dependabot/github_actions/actions/cache-5-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2086

updated-dependencies:
- dependency-name: actions/cache
  dependency-version: '5'
  dependency-type: direct:production
  update-type: version-update:semver-major
...

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index cfa17d394a..3435baeca2 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -98,7 +98,7 @@ jobs:
       # A cache miss will add ~30s to create, but a cache hit will save minutes.
       - name: restore the Coverity Build Tool
         id: cache
-        uses: actions/cache/restore@v4
+        uses: actions/cache/restore@v5
         with:
           path: ${{ runner.temp }}/cov-analysis
           key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
@@ -141,7 +141,7 @@ jobs:
           esac
       - name: cache the Coverity Build Tool
         if: steps.cache.outputs.cache-hit != 'true'
-        uses: actions/cache/save@v4
+        uses: actions/cache/save@v5
         with:
           path: ${{ runner.temp }}/cov-analysis
           key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
gitgitgadget
