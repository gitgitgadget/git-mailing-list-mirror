Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419B1EE7DF
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743588353; cv=none; b=t6hxZNUYeExkNHHghQ+fzWhgrQl/fDP9y15BR7KOvdZYjZgk4Cu18JjB0/BpLoGNn5R4miCu52tdej/G38lOAKwj/9unzvfk/aqyPFWNeuaaDMEkvF2Gj5yRbMjfBRwqGD0Jhj6h6sEKxfrzxVL+OUJu8yoCMXVkQsme3zT4UhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743588353; c=relaxed/simple;
	bh=7E3wFSvBZCfYvmivV3uIUSaURsMis5gxn2Z+5a82G+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RGi5+3GhENp1QxF1r+6HUWgjI/MoWh0I78i9YEh0drsOC0D46HToHMddJJbkmjIDPqeg9ELH7jE9f3ENL0rl6VfMTc/nQnZCBJvCk9WHcNsRWZSWFXvO5v+njE2cm0e03IrOFCbtvERwM3YFWb1VZUhW7z7yv2Xhy8gaC8vmZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6Ddztmo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6Ddztmo"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2260c915749so91378715ad.3
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 03:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743588351; x=1744193151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a36nl8sHbLg0Suwi477jrhcL6a3tp2o/WIEgbhpMgUY=;
        b=c6DdztmopLcLJbZBHwbI3v1HMpGYBBMUA3SZoRtR3ZL15Ijn8RHp14zQoFtLdBNx+w
         SBLidObDcDxKwOI56MmPnppUa0+FCVSIy6URgNZHcPK3kg8lqVB4PEmjV4PgWtYsRHVL
         v/hZle8Apoj7So30mOsC3chgoHns6XM3tZTairxCAvJZrvr7LWuZEmA24psG6ZmcF/n7
         sMOg+9UvW78ZyWRK9vjKSS200mOXYruU8hT7FGZN4rcPOxqkghrCw4HJaaMAAIvIYsYe
         KQzBdyDEZStBwpTFtjfKhzsCDO4dU4PAHReidnfm4jvEeOVvk1EaQeZXCBwm8HSc6nig
         gwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743588351; x=1744193151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a36nl8sHbLg0Suwi477jrhcL6a3tp2o/WIEgbhpMgUY=;
        b=XOqMKuTgYBfA6DMEpOTA88UMhUyO/YeHZRJWHxC4coT/u4uec3AUra2rNLOx0uNsfz
         +WXtEIgk9yZfsD9CRNoMF9yNaXCmc6Qj0EZo6zqsHbY3CpYve4KBYzl+W2JobDjMQIyN
         FruqJXhn+Gc6txLtxqcD/aEo11kZiKUnVMOMV5UL2moh1euDomxru02N+kaSrs0cJg0o
         tAv8cVjtF4pn6TLPKCFWxkMKaRqny+I8Mgdwboe6N/Qa7OumIy5v5hiAZjedtda4q9e1
         bGpvpy4QYG5d0DsN1K4jpufzSE/ulZCcHd3OUhDlZuI6yEG6SkFH4oykDNFDGMkHLz03
         EjpA==
X-Gm-Message-State: AOJu0YzSED2B1ivHA8PmXWyRzuW6OdgwSh4aC3RsYXTnJRvYWRhuWJOb
	2adCIHlqYI74W6P4UOM+nKk6W9TuMjbwnBe0Jme74ySsYZG8pPFhFz4Y4+nP
X-Gm-Gg: ASbGncsd3jAtemQTU5wyi7cETaEki2/rw+XgoSR4gCJrbShGs+iPgoTM3rLHNoMjP5Y
	AXJXM0lh2Ba+6apqZVQ5Da+NKonzWnyqk0Pv8fof4PiETr+0+MTV38lUv9iVNSqNgR9BCGgNOfd
	10fFk50Obo6T1OAK1GLUbmpb4nc0aHxSiu/3WZtX+rFf0ewC2zN4NIR+VUl26TXrcDeJXvSY43S
	902y5k0vVhiMUTU2of57ikrTrXvAlutZ/DS/gSxKg924+3hLJY/qOIXIUp2Ae2nLx7eRyLWLgqF
	QG6cGXxzMVAuw/WHPOIPokerr4WcACylbFC0gdvIPH9qNRdaLi4D3Zvm3Q6TNQJdOg==
X-Google-Smtp-Source: AGHT+IHTW4au8nt1/FdNfOW9Rc5KfRtG+xH9pMCdfOgI2zEBWfiAUZSppShWjkWJVR6v8Ksloi9/cg==
X-Received: by 2002:a17:903:22d1:b0:227:e74a:a066 with SMTP id d9443c01a7336-2292f97541dmr293441925ad.28.1743588350902;
        Wed, 02 Apr 2025 03:05:50 -0700 (PDT)
Received: from localhost.localdomain ([136.233.152.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eeef8e1sm104969525ad.106.2025.04.02.03.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 03:05:50 -0700 (PDT)
From: zanal <zanalsorathiya8405@gmail.com>
X-Google-Original-From: zanal <zanalsorathiya@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] The second batch
Date: Wed,  2 Apr 2025 10:05:19 +0000
Message-ID: <20250402100519.21679-1-zanalsorathiya@gmail.com>
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

