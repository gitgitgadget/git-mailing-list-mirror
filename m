Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE625D53B
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631740; cv=none; b=oPzNdNi4sFJIuQAy54foaUuWsl5pTKYRSLLnaZ4iNjrQxpivF2Ripr5nEn6KnUk/2sqMmnDIh8U/2drthKxEathfIbZe1OH3ToMyoWxiH4Kko64webNPLsuqhZoJejx5fLScQ+mtMsbnKgFjg/r9FaWY81D29u3K+Zx1ZVsMPqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631740; c=relaxed/simple;
	bh=KEAhbHq5HocF9iR3+oVWwaRGeNy/nsy7KerUg7iafSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJ8OehHz0g+bMvP3E4ixW1A4oZj2O+mCSkdD9hIMOeKgdzqx5TDGy6XxfpgGAatE6gOEGLzC+nbaFJhvYBFea2H6LjIsEeOdF45fkZfMvMqZY8lSKGQjyfzvTqTc737dg6MIDahmfn0W/WfhJkOlMmP0G/ADp2TtS8pYp+68I/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUQZmk6Y; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUQZmk6Y"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43638a33157so1054700f8f.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 02:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770631738; x=1771236538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yR2ewVIW+CRBwTxbiXS/tTmcLcQ9UtjRlyCBqwA4y3c=;
        b=aUQZmk6Yvm91g197pD7cVmXdvr7/1WmuiFtsxzMKGlGclMSTmCZX0EtjFghW1r0qHp
         ZURquZkjzPTBHkiLMcWIGdlDxyNEfM+o8WOuC2Bav2+E7DC5T47FwIHwZzeSN3QbrRq6
         cr37BKSQrL2dBGYyhW+glrD3KOUVZ2gy2+hdAKDyVBriUxGwlRhq4cUa8JEprRit+9vV
         vNrgMi2oELTGZeeQlPH8MGuaRgugAJLBfY2YXrR4PPa9HpXUYDaRwPAecQLIla19iOtP
         ulv+flR/6r9SBCEYfZxDXZtRd7aZMt75EZ5F6XX0G9VtsgxArD79fNHnoYaLOEs/pSS3
         4uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770631738; x=1771236538;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yR2ewVIW+CRBwTxbiXS/tTmcLcQ9UtjRlyCBqwA4y3c=;
        b=mycS6TFe4wCsL/Gb8/G06Sx0n87TgmY+6wz0j7n2Gx2RYCbHoaFy2LTO6RNTex5wMf
         tCX8uHtcIiVjtawTXZvfnXf2nqmz+3V6hz0Pd3DezhyJjfr0gVXlCgNOFmyZ9IaEH8U8
         gLyumFHhVrgUsQUAUyD2k8ubR4gRtHgaZ0F1E6Rnrv6/DvXK/4Xya3dir/hIYmeANddV
         p+WSx2YvI7fSEDNb7G3Y3ti7V51TkdIGrlR45vyqochvZ5ZKuys1fNuPR5QwaxUWgXVH
         hu3hqzhWq+F8x/mfWIl6HQA0IU6YQcvlGbgneNTGd+kd4ROniDDM9NLFuU0LIfV1/khD
         1zGg==
X-Gm-Message-State: AOJu0YxOlnTAHSR5x5ANnEUkVr12hauD3GlYMXsKQXVHPKmYQOhe3Ata
	LlAWIjNakLG1ASqb44di6Ce/7nomujJnBwCr8uc1Q5i8JJ/ope6vu8X5elPV2moJ
X-Gm-Gg: AZuq6aKcdqgjr2n4cf3hLYzFgnvcb6ppsjaBJaNiT44LAq6nDcMfMuGBpj3i99szVmB
	UTLYvRfM2eOXkLvpIO9ZUVNkpZ7IAdGRtsdDCxW3GVcuv4Ra4z49jQ/xMZmmAGS/SmXbUnse/85
	nhMRaIMvdpB81c6PSUyCBTcx5WVp8aSSp2E4xq82dLe6RlnBkrjcp1upWZBxwGC7lTWaXf8emer
	vKA+5u4ujuT/ZnA8iu3O9YFz1g4Yd4s+4tdn+r3eNKRpmV6sAvzqPsr8yT4Vv1cfc0tlKDHJ4fq
	dhG44dZ6i1wnZNdvEIy7A9aDpQhR9G2E3EIdm81R7EsYGZgM+SbbmteRWWmpPhTNMg5fM/Jg8Eb
	GZpV5wLPwR9a4lKOxnFBRqZk2AILSNg1UvPvEfZxnrHpyZ99cWx4UCtbvL5/Lk8J4NVGKmt2ahz
	dwSxw1vOIywZ6v3rk=
X-Received: by 2002:a05:6000:2088:b0:435:9f41:d43 with SMTP id ffacd0b85a97d-4362923766fmr16802676f8f.15.1770631737599;
        Mon, 09 Feb 2026 02:08:57 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436297462a8sm23664396f8f.30.2026.02.09.02.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:08:57 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] meson: fix building mergetool docs
Date: Mon,  9 Feb 2026 10:08:43 +0000
Message-ID: <604c79018992dee019205741934508091cdd1e47.1770631599.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Building the documentation with meson when the build directory is
not an immediate subdirectory of the source directory prints the
following error

[2/1349] Generating Documentation/mer... command (wrapped by meson to set env)
../../Documentation/generate-mergetool-list.sh: line 15: ../git-mergetool--lib.sh: No such file or directory

The build does not fail because the failure is upstream of a pipe. Fix
the error by passing the correct source directory when meson runs
"generate-mergetool-list.sh". As that script sets $MERGE_TOOLS_DIR
we do not need to set it in the environment when running the script.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
We should probably change the script so that error is not ignored
as well. I also wonder if we should use something more exotic than
"build" as the meson build directory in our CI though that wont make
any difference if the script does not fail.

Base-Commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fmeson-fix-mergetool-docs%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/3e0db84c8...604c79018
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/meson-fix-mergetool-docs/v1

 Documentation/meson.build | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index f02dbc20cbc..d0e557c2078 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -353,13 +353,10 @@ foreach mode : [ 'diff', 'merge' ]
     command: [
       shell,
       '@INPUT@',
-      '..',
+      meson.project_source_root(),
       mode,
       '@OUTPUT@'
     ],
-    env: [
-      'MERGE_TOOLS_DIR=' + meson.project_source_root() / 'mergetools',
-    ],
     input: 'generate-mergetool-list.sh',
     output: 'mergetools-' + mode + '.adoc',
   )
-- 
2.52.0.362.g884e03848a9

