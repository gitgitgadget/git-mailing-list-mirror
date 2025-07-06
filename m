Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8841F9F51
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838659; cv=none; b=BGfXicKpksJZjl9XmjiAbadt+QktvIybhM5+Wx33uPqHnaF9xJWrty/zCxEw3bfv5HGZhb8o37G1rc5Fu5n+yIUCX29liuWdNpXgj5V3UBDxRptCgMGhXjOoSHHV6rCdvUnEbY8gFQxWK1LqJ0Ouy82M4TH5eqFe9A7z+T6FhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838659; c=relaxed/simple;
	bh=fj37tRamx0e1x0vv+ekaKGrltfwXc8pcBrk7jSe7pjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XirRiAofAcX4dR/gGbTpdK8itmJ+VzGGws+DakDH7lSLyDGcCmv+FsJEkN8LBnjHR0w6O0m8yk1Pp2L/A7HHroSHZJPR58m7gdrLF0RoEt5eIjB4xZRSpAzfeJna1ZeMI9+YxCjDtPzvjElEz7wCa7DDzW2LbeEkq7/bVC+UA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7AEdG0e; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7AEdG0e"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-236377f00easo31239325ad.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838658; x=1752443458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPjBO+O2gFc0G5JVbq1wDdwIhbV/xaTkzGOd9VIDcGQ=;
        b=m7AEdG0eZzNheBCMzR2KQP5PNx5/OTNUywrFvyEiGZXH2BjgdtL92Ddm/n9ZJ/SSRB
         I78tZq1SpATcjaABSzCIn9AJooLFEfH27w7qlULXsr3F/1YClHns5KQ0v7yLMwEiuvBS
         Ur6iAequGqvLQMZ+q9/AOF3CkTG1+hEUHMxrnBGaMYxWTY4zc/lQ619V+ftDtWACsgav
         kfzJf4hi8F57Tpqct9cfm1jjkf5+qq9A5A2wLtfGm+v2uO5lCLSRCDc4NGNF+C/lSEiO
         xjsDP9g1zi6dTTtJHTAelv55pL8vhCDjcEWLel1ytHNBosDkG2dgNsk0tBUQM2fPEbWV
         3xlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838658; x=1752443458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPjBO+O2gFc0G5JVbq1wDdwIhbV/xaTkzGOd9VIDcGQ=;
        b=EZzj/bxIsICmRh8hMz496gO4KIjrrqpBA6zLagr/C88JcBpwXl7ett5ng3QVITFNeP
         u0Obtidff5s+5ZeyC5jADGz+WIf6X6mYUN/wSbmy+ZkfBSgesEGwlsufiMiuhAUMx48Z
         win4Dy5hR5kPGGtRtQBkTL7SgrdHHRz8DwJL6l9frQFE1bvLqjuFt4XcDsxabQXLO6LH
         gt3e9RkltB/qwNNYTvAXBhwe5SvCwxsas99EacvrqwJ8TZsU6tg82YZ3WCDb12K6ftzy
         3JwRuj4mZqXiyWfN71Tb3bl5MABUoYbEcyiWTLY7TbJEC8HgXTgbuExEzNCeaFrMZiMF
         0oGg==
X-Forwarded-Encrypted: i=1; AJvYcCUG0I6+ppaq5sTM5Jibu3QsIjL0VOE2vaUFg0759SDxP+EfbmreXG2onjl/j7VTC6+5pns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcMYnIKaHyJHwjydshDkYNlw3SDaoxR+/B57RLh6TUoIGxdw3
	282NC0jEjx4E9b4tKBSPsBZ45t1NkDPRzDkU/oqc3hLXVJZxIcK58+TO
X-Gm-Gg: ASbGncsfALD9yueCG84j7aUZmOSsKq3uyLfyFnq97R3Lh4N/fthw/PzPKmm+zCN3Alb
	P7zRlcbJwkZkQ2HeLfs1tYcz9nvKnE3/sBnaf8ZydLXH4WcwV13z3v8oCyivnVxFLG+q+eOZTZL
	zXup1NqqWoku3ByXyXpAUidzA9v6VJXU8nvBHV9nwUq4sn6VIyh7vUcFvWT2P3gSlTegkvMTIFZ
	0K5Kl9xCr+0EOUPgRA2uc4ZAkpUB6ma1JJh9DTYbNwT6xo1Y6SL6iUmCN86pxTxa1WjgED+MV0t
	t9n1lHC/pBlZNFFoO2CmdmUcB6UYtwH/3gOlZx5z6MvW2SapxvtBci9QS/7PmxBuUmhN04l+v47
	ted5bXdwTX+c=
X-Google-Smtp-Source: AGHT+IFN2WCsDM/52fHK9f7n8ZWtBRyhh4+izILF46t67eZHS3s1iFV96fZaSp99zHuXjzZJFILOXQ==
X-Received: by 2002:a17:902:d592:b0:235:799:eca5 with SMTP id d9443c01a7336-23c85eb051dmr174867815ad.44.1751838657704;
        Sun, 06 Jul 2025 14:50:57 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457f308sm72912335ad.149.2025.07.06.14.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:50:57 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH v3 4/7] t/t1517: move pack-refs -h test to t1517
Date: Mon,  7 Jul 2025 03:20:36 +0530
Message-ID: <20250706215039.715732-5-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706215039.715732-1-usmanakinyemi202@gmail.com>
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
 <20250706215039.715732-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'pack-refs does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t0610-reftable-basics.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t0610-reftable-basics.sh | 7 -------
 t/t1517-outside-repo.sh    | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 3ea5d51532..ffd8ecc0ce 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -14,13 +14,6 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 
 INVALID_OID=$(test_oid 001)
 
-test_expect_success 'pack-refs does not crash with -h' '
-	test_expect_code 129 git pack-refs -h >usage &&
-	test_grep "[Uu]sage: git pack-refs " usage &&
-	test_expect_code 129 nongit git pack-refs -h >usage &&
-	test_grep "[Uu]sage: git pack-refs " usage
-'
-
 test_expect_success 'init: creates basic reftable structures' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 206b9e118c..39e7842c9e 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -135,4 +135,11 @@ test_expect_success 'ls-files does not crash with -h' '
 	test_grep "[Uu]sage: git ls-files " usage
 '
 
+test_expect_success 'pack-refs does not crash with -h' '
+	test_expect_code 129 git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage &&
+	test_expect_code 129 nongit git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage
+'
+
 test_done
-- 
2.50.0

