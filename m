Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4611233DEF9
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201908; cv=none; b=dOy1hGOHRILIM8DaNAm7NpR4tbXrrifqQF5K/54XZpavmYusPaKULBNei+0Qj8n4IkzW/IFHcRssSuGQbaCGWeCotXw5wrb/59pgccj5f4VJvEOgyU5RA5X7ms5vObeep1uB1l6sNQvHE4S/ksQdHDYCIMZvFRH6gmA3mYHHElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201908; c=relaxed/simple;
	bh=44U8TQS3imRqLPeQeMD51BhGHmQ//MM/5hyIlOkzyvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bmph4uHDoJ3wDdjqpizxrYXFj5fUhF6n6dDpK2M/lnEbl3YUaG4iAn9PT+n16mmGqGV4tv/ciMneX6LkprIsWusDwRTwd1Is6qbgckbGaOK8khGC/nSpZxFqVWa/oqBMhl+w37YyDBCoYLSEArz3ld/cJD9mrBiLz2Hb3jE8bt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAspxJmh; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAspxJmh"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so3273781a12.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788201906; x=1788806706; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=weWQlAjV+xqJ+ci9dShjtQ3pv9C0oCOUkvyfS5cTqB0=;
        b=fAspxJmhbPGjChc63iCdlCHtlRSL3cd2rP+gzYgwRMOl/of5H8SAE6LrVmGNDLoJAD
         khk42fUP/VYgd/vy42H45tKulAzjItcYQhKxLnQ4obAeqtRb7Yh8LcUuYsXqOOud64sC
         Typ0x78LYD6KXWBB62+mGmiippR3CDH90szk+tORGgWtw2Thm8dI56EedZ4n5EykX2S2
         DBYYRISKAqzM2Y30hyzPZnHoglkHWqGYEI2M+9o/n0vlgz1FPwXlt0RUKlyiM2eIvGJj
         OMXGKG5OEWnF4uSokG8WSZ9KD14MplnYJRlYbAKYIiItRUPQA9hKjpWi6CtPQQA/JKzx
         T50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788201906; x=1788806706;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=weWQlAjV+xqJ+ci9dShjtQ3pv9C0oCOUkvyfS5cTqB0=;
        b=eKl8ELwyDwx0VRjq762eXBpWGKTN2G7rp0QdD+RCtBHR7hW7ksHTPqS8baUp5eWWVa
         KGE90eUpE+rIlLldd5kw5hPLDE/0ZkSUF4PgT3ZfXIM42mCLqnkKvl+GDjwD+xMdn9xK
         ZyIC+LEmLzhJVwFCkosL7A9gWlZeVe4fmMlvxzjLPszbEVYi9ISS3eyWAIUnoUuxMijn
         LX20wrq3FmzXkzofkqKS7rGqzpT2nJqNJ0t2gKZJpEqHJaNCJndYMqJYcW7sV0j/Smqa
         PjHM9xFKrv7HsxqSqO9QpoDdqSMRENMlTi/noSJNp5u3lEDXIR6mDAXtUNrvjlA8r4MS
         ZpnQ==
X-Gm-Message-State: AFuF++miSHmN557zXV7H9LA9KTrGJ2QV608NYfpnPfoKMv4Wo8SakDjV
	AgvwEMtQ4CSkdJl/IbkK8K2woAVX0Oh0dxeIYqLTU1qrIjDxu8ww7EGKzKNXvw==
X-Gm-Gg: AYBFou2l7ASHANMuwPMXmcuVIzNJRK2EGxko1NRQiIvyXCquJZ8bw7SlnLovg0bMAV0
	j+hcEmEBfwhii8gao3llTu9CMFTVZDusepe0lUypi1MPMv9fV69Mf9fjB1f+wbUPiPZLB/8jpDb
	5hWjDrb11utegvuA2km8JjHEx6xwsErg2QmzCHOlxY2SApmTvS6kO4m8nXy/OU9nthT3lQ0FOlh
	bcoOexvz9vJD4foFbkprXWuyB5sgydOmvWwtdIWoFl1ulmN+BANf6lV4UI7mOA9TW6VNKKeG6Vp
	KFcpiSJXPJ5MFbtbtCJNz1P+3YCNhSP2ysBdUNnB6FEWmyI9jCgvgAsQPKrf5lJkmS3F3eat07K
	N1j65QX1PNiD2Maze6BnFHUHQTR9yufNFWcx79YPRefhwDM53xkIJ1HzIK1FAsdlgeeI2th++iW
	ixBBAUkgS+NGdyeFopVSDjm1qwnq9f/DOAwOdnPRt701T8yCzvIO1s3So85im7wRY=
X-Received: by 2002:a17:90b:3d91:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-396d0f016bcmr46201314a91.8.1788201906324;
        Mon, 31 Aug 2026 11:45:06 -0700 (PDT)
Received: from [100.87.176.22] ([117.213.200.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d38207sm29327763c88.5.2026.08.31.11.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:45:05 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
Date: Tue, 01 Sep 2026 00:15:01 +0530
Subject: [PATCH v2] versioncmp: fix typo in versioncmp.c,
 t/t0022-crlf-rename.sh
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typo-fix-v2-1-6aeafbae6389@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Myw6CMBBFf4XM2jHt+Gjjyv8wLCqMMIlQ0hIiI
 f13R9bu7jm5ORtkTsIZbtUGiRfJEkcFOlTQ9GHsGKVVBjJ0NZ48zusU8SUfdGSfzlnndIDep8S
 q99SjVu4lzzGte3mxP/snsli0SGf2JnjH7eV074Yg72MTB6hLKV96jhyeoAAAAA==
X-Change-ID: 20260828-typo-fix-721b77177721
To: git@vger.kernel.org
Cc: Hardik Kumar <hardikxk@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788201904; l=1396;
 i=hardikxk@gmail.com; s=20260827; h=from:subject:message-id;
 bh=44U8TQS3imRqLPeQeMD51BhGHmQ//MM/5hyIlOkzyvU=;
 b=p1mXzcvZ2Z4DfPUFLhLvyX0BVifnnZQiKFo6DbvqT/B1apViiDbhwCuhWY0sgW8ZjL1SWzwcx
 bXBVJWzqtAoBRNcwQ0+yW75sWtrSFgxZSdWbPET414bUsf6W7mzzaZs
X-Developer-Key: i=hardikxk@gmail.com; a=ed25519;
 pk=56yFuFlLHAdRemUZghoGHVCijEX767atrut3dPD0thQ=

The patch fixes two typos in two places.
versoncmp.c:            "fractionnal" -> "fractional"
t/t0022-crlf-rename.sh: "similiarity" -> "similarity"

No functional changes, only update a comment and a test_description.

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
Changes in v2:
- refactor commit message
- Link to v1: https://lore.kernel.org/r/20260828-typo-fix-v1-1-24e80a87ed53@gmail.com
---
 t/t0022-crlf-rename.sh | 2 +-
 versioncmp.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 9bd863a970..328c6e5903 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='ignore CR in CRLF sequence while computing similiarity'
+test_description='ignore CR in CRLF sequence while computing similarity'
 
 . ./test-lib.sh
 
diff --git a/versioncmp.c b/versioncmp.c
index 3a81b17bc1..f1e451755a 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -15,7 +15,7 @@
 
 /*
  * states: S_N: normal, S_I: comparing integral part, S_F: comparing
- * fractionnal parts, S_Z: idem but with leading Zeroes only
+ * fractional parts, S_Z: idem but with leading Zeroes only
  */
 #define  S_N    0x0
 #define  S_I    0x3

---
base-commit: f78ce2f7b6df702f93d40b85d6bda92a3f65da79
change-id: 20260828-typo-fix-721b77177721

