Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1453BE
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589409; cv=none; b=i+JGtrd2kLcx74mPQWiUq6ca3dobU77BH6n9W8t/3V4g2ut/hgPHLVEpbuoN56SPcyMEzcnVqhQDxDDaC31kQADZHLAK5Fm/wlgQmdtXDFnB+zV+eAJFtSqxKX9KYskpnIITx+SMeNncMXwkQgqwadUWuyVMgzKFEIgbJiqGCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589409; c=relaxed/simple;
	bh=7E3wFSvBZCfYvmivV3uIUSaURsMis5gxn2Z+5a82G+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nqgNkF3179iCXvL4C8Hrih20vUcEvGEdfNUQ5BOQVMdz5C123j8ETpqU+Vcv8HmFqrhIhCStJWWrj/460Lw9BKX8TbPLZ84Osj2HuK/9hYA8dP/HWiwcBRSNLGV9Qe5VJZhE0733bEzccron/Z7KDl7pu6KeaFoLU4SoZCzHdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOwVbIsQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOwVbIsQ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225477548e1so116995575ad.0
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 03:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743589406; x=1744194206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a36nl8sHbLg0Suwi477jrhcL6a3tp2o/WIEgbhpMgUY=;
        b=aOwVbIsQClvai5OoBJ1MWm2qZiKqqVa1gAgxsP6WDXQUrprEOtg0LGlU6D1o9BwYSu
         tx9EFuLyh7QclfR85rDGegCVEBCDukLHP1n1swrXqMrvbifr8MVKVQPEDPxCZJatt32y
         Mf6whB4CznFPdQg1YKReQoi6JX7KckVlmAw5oqCZ9GvMV15dVp6AtUZyLaU09lRDCCRu
         U2I34Jy/85iK6MT1artcfKYVP3ODh4eixXr4SdEc02F+xm4Ay8tJ4JN6PZwUoQ2n56gb
         ZNIlyUoSPbzZzJx5gk/I6bz+z7E3VJeh51psfA3bvv5UmdyZjE8WjGO5MoHYiMebeOjC
         rnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743589406; x=1744194206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a36nl8sHbLg0Suwi477jrhcL6a3tp2o/WIEgbhpMgUY=;
        b=SW0883un4gdB/JoCdl58uRYicPFt+MsRiYCPGYrrK28d32KBrJal9EXBO0NRI5qS0m
         4ExHPzlVmGc/eBnwYFv6FlrPm78OSgNrQQIQPyPOAxahRzsdK5YT4eEdLzUAfxmfirUY
         469vjGi6lMzLsOIfZ5B7RWfQ7RM9fFwKgvzUCHy53RIfmVParcTl1E6R6d7zM4aN4GtG
         H8MqoqlVeO6Iif6hGMxwSdtVKRI5ssRj7qujJG1XkGrISdsK0DeNkJUwJCKrhD1Rsx85
         ySK+MsoIN7/2tUnQnYdku269kfy8vOVslP+q9/oNKK3QzaWB6Qb+d6UEf1kaFdAGHjyL
         ZiJw==
X-Gm-Message-State: AOJu0YyFZL1taea2nEmTJrshuWQFbMDlSDM5kMqngMXEWHVvlngqQ23p
	WYNSWk2N/Yz0KW3+yWH58JRD7N+jq+cSlOL6X4WsyHlA75lNt/aqiLhSbZTT
X-Gm-Gg: ASbGncsBNTR0kPlOCEqT3vcZe/UTycIlOAPjPtq+UbNDiZG78IL12vasrRSxkIxu4fB
	oYZlNBl4DNAwiZnrHDY4g222jS+DNO6wJhz/m/7cmL7orwTiSJB8QM2wUvFB55dkc+LVjV0gWIO
	yjJemoevqenSnhkQtIw7eId/O5XK8YydnhbHTGOATxd73SuOyQT49MaPrtYxVMJnX9bK202WVLc
	5bu+UxarfYaONBIxAqjR6ENVxIjWgqxhD5frJ94NgIOkGtzmnZK2wEWzmbTsFnSWU2mXAVo29FX
	XAuz027awFTRhNAlis1zzVBkzyteifEKyLUxuoVav87iH3Ob7ULqzplydXVHTzxKoQ==
X-Google-Smtp-Source: AGHT+IGqTWuK6Gx01u/ECk4Bvgw2KDSaukm9ZsycY5TP3jTS3ospt++K/0X5Ewql70NhVjfCBpHhUA==
X-Received: by 2002:a05:6a00:1784:b0:736:a694:1a0c with SMTP id d2e1a72fcca58-739804526f9mr23955767b3a.21.1743589405974;
        Wed, 02 Apr 2025 03:23:25 -0700 (PDT)
Received: from localhost.localdomain ([117.198.141.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397106c06asm10898983b3a.107.2025.04.02.03.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 03:23:25 -0700 (PDT)
From: zanal <zanalsorathiya8405@gmail.com>
X-Google-Original-From: zanal <zanalsorathiya@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] The second batch
Date: Wed,  2 Apr 2025 10:22:57 +0000
Message-ID: <20250402102257.21728-1-zanalsorathiya@gmail.com>
X-Mailer: git-send-email 2.49.0.110.g30eadc9d59
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.50.0.adoc | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/RelNotes/2.50.0.adoc b/Documentation/RelNotes/2.50.0.adoc
index 50e3027984..1905c61e9e 100644
--- a/Documentation/RelNotes/2.50.0.adoc
+++ b/Documentation/RelNotes/2.50.0.adoc
@@ -17,6 +17,26 @@ Performance, Internal Implementation, Development Support etc.
 
  * "git fsck" becomes more careful when checking the refs.
 
+ * "git fast-export | git fast-import" learns to deal with commit and
+   tag objects with embedded signatures a bit better.
+
+ * The code paths to check whether a refname X is available (by seeing
+   if another ref X/Y exists, etc.) have been optimized.
+
+ * First step of deprecating and removing merge-recursive.
+
+ * In protocol v2 where the refs advertisement is constrained, we try
+   to tell the server side not to limit the advertisement when there
+   is no specific need to, which has been the source of confusion and
+   recent bugs.  Revamp the logic to simplify.
+
+ * Update meson based build procedure for breaking changes support.
+
+ * Enable -Wunreachable-code for developer builds.
+
+ * Build update.
+   (merge 7c8cd9c158 es/meson-building-docs-requires-perl later to maint).
+
 
 Fixes since v2.49
 -----------------
@@ -30,5 +50,19 @@ Fixes since v2.49
    when certain renames are involved.
    (merge 3adba40858 en/merge-process-renames-crash-fix later to maint).
 
+ * Certain "cruft" objects would have never been refreshed when there
+   are multiple cruft packs in the repository, which has been
+   corrected.
+   (merge 08f612ba70 tb/multi-cruft-pack-refresh-fix later to maint).
+
+ * The xdiff code on 32-bit platform misbehaved when an insanely large
+   context size is given, which has been corrected.
+   (merge d39e28e68c rs/xdiff-context-length-fix later to maint).
+
  * Other code cleanup, docfix, build fix, etc.
    (merge 227c4f33a0 ja/doc-block-delimiter-markup-fix later to maint).
+   (merge 2bfd3b3685 ab/decorate-code-cleanup later to maint).
+   (merge 5337daddc7 am/dir-dedup-decl-of-repository later to maint).
+   (merge 554051d691 en/diff-rename-follow-fix later to maint).
+   (merge a18c18b470 en/random-cleanups later to maint).
+   (merge 5af21c9acb hj/doc-rev-list-ancestry-fix later to maint).
-- 
2.49.0.110.g30eadc9d59

