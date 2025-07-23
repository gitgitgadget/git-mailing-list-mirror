Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38726E70E
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253015; cv=none; b=aRLgUIf8QZ9AN6IDFnnkp94xwunphTOdqe37plYHNgT14HX2PT031w9mfSiHBb4/1D3C1nkRyD9iozrANdJVs+60BrHqkhRbnzlMGbZ5gYEU03NyJt1981zyPDVZcV3vbfoL/DZWwKnjSgMQjNQRoLMaX9tLdFVfxk5EnjSYUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253015; c=relaxed/simple;
	bh=lFl2KtcB3SJg8wnP6TsHSp6qGw2xiaDl0QlFbsSexjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRNRBbiYKpZZPu1qMXKNc+8ZeZUuUbJeUWb6/FOqDQ3z6fTdsJElGrxn5u0z624FDzs3HKe9VudfuGBelUavD+ZtbGpACeM6IluULMsvmDj/zkt7drbwkRf6lgAodVpVBvIWWVeHsDhQMEd7YbIuy7fC21K5UvPaS9xKDftNhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwPMb4ot; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwPMb4ot"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b54af901bso4113118b3a.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 23:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753253013; x=1753857813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fbJEeo3NIyMvlrDr61nAJdjqra5U08pCLnGL9rj8tY=;
        b=jwPMb4otloYZJk4IxZlWxPZNI1FPD/wakdF6altPVsjQFM2pOmyC7rA0AtSJOJBj2c
         uAGKGnNsk+WcTezqgXUk3LRXSPaot86zAhkz2SpOm1e65tEHWjJ/m/zwEWr+bhYX1fdV
         fAJHPEzTxph/9MWQFfVp3WqcKeOOGBS0sOy0FooJMSOGli7+U+3wo8Zx73HlJoYM5I5N
         YrbohSvstUTvOxzfBjQ09FiPv9kXpRDKH4yaCKreYQVRd8JpfQMp/FOdAQuKLFRk+Ltm
         Jolx469NDZ4mzn1HQfvV/ZoZzvA5YyCbdP5ywnL57UszzbbJ3NIU+ykUZWk/FBPpVXNS
         /izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753253013; x=1753857813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fbJEeo3NIyMvlrDr61nAJdjqra5U08pCLnGL9rj8tY=;
        b=jo5HtpUV/lN3ebNXlAim3K/pW0izNS+u26WnCt35L3j9w8DXC2k/cbDgxJZpmXXg/Z
         vmceGdwiciOXEOP/hUa+fRSb5XLU9QbZePXILpUXEP6Ej40Uve6mHYrhyKMxNX0w7OcY
         nPZnB+5d1+4Mz+CoSmu0fK1hW3PeaS3riVHqmdjyeD+ufEIFJ41JnUNR8isASEoO3wfa
         F+jEFkZQaqfnSc9DUk7JYff2aKlACCjd0IGyXwcJIf8lGSHYO0D/yjqqnQ3VDUrZIIDO
         GpiFVs9JHsUxdDjCZ6yH/8GEqydapyhuuwJAoc4B2YxJBy0LmmnxFPVV2Z5yDm83o8Gl
         S7FQ==
X-Gm-Message-State: AOJu0Yz6dET6zTtKgKeFRsOqnk2Z9wZnRQ2VW83T3yLKF9BvZATzCB0O
	QKH04cLSaM7x8QBgY7wDxEr3NSzvqtcUpk1ECs0SR8tYIygDPWxK1kNwa5XG4xyI
X-Gm-Gg: ASbGnculK5uMps6RC3D4MpBaXQrFQjjZFfSw3ISyzYDPXnmhVBjNdaUj/d9AEyDMukd
	OPGny0eRnbI0pez1Sl4GXR2dpqoQo3jS6vnOTpyPR6pAeMSzVJJ64MFm6h0U4JJZETim0am3FwO
	Z9eehx40w2b7mDXGU1vG+4XH3tUfNXQR4BaKORPr5/dAG8MO6HUSDY7AFjVBCl40Zl7vnuFPdNE
	/eC6Lut0GpHiQCAidf+WM1qsLeqO++AtsylGBD/fAcVlC1KV61LVB+PfcV5Zb8T2m8B5TUtzeJZ
	SImoeaTJGsagUFaAmUKunmSBLST9BGaZCjI/7n8U+I/Cfr8oCO6iAD7JEh7pWBlKzmC6yrJxHIz
	O5C9lszjtDFIYPosZh02CGJZVbpFLuw==
X-Google-Smtp-Source: AGHT+IGbbQRr0BtKw332lukBIyBkwCF3xEzkGXROca5leG48rhpesDwcB11cs6RVI4NPsY12aH6haQ==
X-Received: by 2002:a05:6a00:1914:b0:75f:8239:5c2b with SMTP id d2e1a72fcca58-76035ff3a9dmr3077143b3a.23.1753253013064;
        Tue, 22 Jul 2025 23:43:33 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2b48sm8996354b3a.19.2025.07.22.23.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 23:43:32 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][RFC PATCH v3 3/3] t: add test for git refs list subcommand
Date: Wed, 23 Jul 2025 12:13:13 +0530
Message-Id: <20250723064313.29866-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064313.29866-1-meetsoni3017@gmail.com>
References: <20250717075009.26262-1-meetsoni3017@gmail.com>
 <20250723064313.29866-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test script, `t/t1461-refs-list.sh`, for the new `git refs list`
command.

This script acts as a simple driver, leveraging the shared test library
created in the preceding commit. It works by overriding the
`$git_for_each_ref` variable to "git refs list" and then sourcing the
shared library (`t/for-each-ref-tests.sh`).

This approach ensures that `git refs list` is tested against the
entire comprehensive test suite of `git for-each-ref`, verifying
that it acts as a compatible drop-in replacement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build        | 1 +
 t/t1461-refs-list.sh | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100755 t/t1461-refs-list.sh

diff --git a/t/meson.build b/t/meson.build
index 50e89e764a..c959c039d0 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -224,6 +224,7 @@ integration_tests = [
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
+  't1461-refs-list.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1461-refs-list.sh b/t/t1461-refs-list.sh
new file mode 100755
index 0000000000..36e3d81e59
--- /dev/null
+++ b/t/t1461-refs-list.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+test_description='git refs list tests'
+
+. ./test-lib.sh
+
+git_for_each_ref='git refs list'
+. "$TEST_DIRECTORY"/for-each-ref-tests.sh
-- 
2.34.1

