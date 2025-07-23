Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4B2E36FF
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264013; cv=none; b=aUVO/twErXvGK01BSLa9mIXafQPFkrVmcFLPMF9mHtcz0YMTTD6DZEklgGOKm+z7HQzvS7VcHEhpOx4z6/1IxrYR1nN7mxRoss5JfTqW7FfHBkMlE0dn8NIweGbLIMKClfxogWv6PvCbP3H67QLg+wvjZEGwnjK/tS5WgRV/Q7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264013; c=relaxed/simple;
	bh=RgrGPOb45SaeUQyZfjryFPhcmZo5n/VbcLGgp48j+MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZGUvHw7Tup0ZS5YI8qfapYjzLx6ZVmaiNiid03beZ2uQxtc63BtoBcOtjJRCJ7hBcglQa6KvjRhTOJgRghWQj2Iif2nxeVN1OMH07aleP0tHGwGlE++lFzyGqGtjudoRlyj87jlmQopDjtLOrS/GQFLaKcXgf//WNhsp39gBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH56Bc6i; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH56Bc6i"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a575a988f9so3878680f8f.0
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753264010; x=1753868810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nljFj2/4+rsdqktFQKqSrO47stUL54HC+ms8Ne6susU=;
        b=UH56Bc6icbnfinNdjthLEmKcN4S3VUG2GTpktOfSI2phzg25EibQqfUjIze6lcQyia
         y3OP+yfTgz3VQPHYvPWzs5N/GFIH2AW/9cbhQg3QfL9+xU7eqXOEVoOjZs6NMoWcM4qw
         6+MUtUWa3LLqiFb2D+RNQANramEBe+IbHvRIFkbd3TJT+4pDQzSIP+q/NbJ3Yxg9mGYh
         y0GiUsHlRbxrYIxuLY5mdmDIS3VyHY08pQnNlm79uvCCO8BDcYZBX40E9IPp3A/g3xne
         yfOniwqFVI+w0Z3bpqfKmA4nzKLzMr0WufeoSG2ew7zRLggsDSQbtHgIyEsH70qDSlJ7
         uM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264010; x=1753868810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nljFj2/4+rsdqktFQKqSrO47stUL54HC+ms8Ne6susU=;
        b=ckzOnJOoDq/aNEAL8xMxoHqfyV1+5h3e3shkr3w9yauv/OPvLeWIJLItc40UkRagYj
         OzboUI2EjiCad4kZoXUs4NIsRXzDtmYQ9HBO722ma9epwTLgiuw0GFVjMc1mLm7yDROA
         0Y0e7wQAebee2CcAuiWkbynKSnXmGAzI/O2o9FNMz1PV2P6cAlQsym+ddzhLfroov4IJ
         hhN+tmkW+Q3JScYaI0h8l00ErquAHZn9+I8cDxPBkNpDjdjeCoyGJHJDkr/ukGNt8+IH
         fT+P9QL2lVxhxUdjDaI8Fomu7fHMzwCz1/u+52Q3X1ULAMHez0H0SA93HbQNGT7kIUfm
         W2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWtIU+49tCVE9qehl6hDCttFKHK/PmJxFKvPK9eqNdlURIPtthPuoJP9eed3DIH/5qVjMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhrMO2e1H2Eezmd6augxgFJo599493sfJyjTzAOXVXcjgjTNMT
	AFTH56WtW8ujmhrh5Pp73UNmwtsvdxJakGx+yfIJ6rOlqREIaUPnZJ/C
X-Gm-Gg: ASbGncvqremcNTKwnkZITsk7taKliz1tdGbmDirTNfc+JxgFvFJ+n2mXV2dHPYe3Adc
	3T6bJqoFbXRD/VYfsJGqjeC7P/R9Fh5u4+6GtoHUwkujKMRc1vLCp7jlqr908BikkEhnzbG9+MM
	MdGbWj23hiWyCTDtWz/rSQv3rmxmMSLQx/VqJcXIQyDIU65uFzN0h4WtSm4ds69xDNHU703eAky
	+ZhxYrMSTC+VD7MPGXkidU1BwJLAcSwto0sH35eGDv9bxX3I9HfbV6pK3UVdLVDEDy/qX2YKrN/
	qq6DjCWFCAgu5ATG+7Wpgvtp4r9p8XloCEcQtdBpxE62zki/qWfhlVeyoyZ0kVJEjHFkaT1CyGR
	eCjJm4+LiDShiu7pgYNTemd2ZyyurvmRXzGLH53Hgij9h
X-Google-Smtp-Source: AGHT+IFMtb0xaNIs7ZOlweriSf3FGSaqxvqDetJ183yzg7RfWXSyjBXU1peKa/2x+dvJzxgZibvwpw==
X-Received: by 2002:a5d:5f4a:0:b0:3b3:a6d1:6b57 with SMTP id ffacd0b85a97d-3b768f2331cmr2050027f8f.44.1753264009526;
        Wed, 23 Jul 2025 02:46:49 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45863a13f23sm35731495e9.1.2025.07.23.02.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:46:48 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: leonmichalak6@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	phillip.wood@dunelm.org.uk,
	sunshine@sunshineco.com
Subject: Re: [PATCH v4 4/4] add-patch: add diff.context command line overrides
Date: Wed, 23 Jul 2025 10:41:51 +0100
Message-ID: <20250723094622.21639-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <CAP9jKjExau58dP+=MJXiKWvCcOaBmhB-yta0x76s7b0XWqBQxw@mail.gmail.com>
References: <CAP9jKjExau58dP+=MJXiKWvCcOaBmhB-yta0x76s7b0XWqBQxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Leon

Here is a fixup commit for the tests which can be squashed into patch 4

Best Wishes

Phillip

---- 8< ----
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] fixup! add-patch: add diff.context command line overrides

Restore the test coverage for diff.context and diff.interHunkContext
added in f08d4ae6e56 (add-patch: respect diff.context configuration,
2025-07-19) and remove the redunant tests in t4055 added by bd6d6ba1321
(add-patch: add diff.context command line overrides, 2025-07-19) which
duplicate the coverage of the tests added to t3071 in the same commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3701-add-interactive.sh | 22 ++++++++++++++++++++++
 t/t4055-diff-context.sh    | 30 ------------------------------
 2 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 7fd9a23c998..04d2a198352 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1230,6 +1230,28 @@ test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -p respects diff.context' '
+	test_write_lines a b c d e f g h i j k l m >file &&
+	git add file &&
+	test_write_lines a b c d e f G h i j k l m >file &&
+	echo y | git -c diff.context=5 add -p >actual &&
+	test_grep "@@ -2,11 +2,11 @@" actual
+'
+
+test_expect_success 'add -p respects diff.interHunkContext' '
+	test_write_lines a b c d e f g h i j k l m n o p q r s >file &&
+	git add file &&
+	test_write_lines a b c d E f g i i j k l m N o p q r s >file &&
+	echo y | git -c diff.interhunkcontext=2 add -p >actual &&
+	test_grep "@@ -2,16 +2,16 @@" actual
+'
+
+test_expect_success 'add -p rejects negative diff.context' '
+	test_config diff.context -1 &&
+	test_must_fail git add -p 2>output &&
+	test_grep "diff.context cannot be negative" output
+'
+
 for cmd in add checkout restore 'commit -m file'
 do
 	test_expect_success "${cmd%% *} accepts -U and --inter-hunk-context" '
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 0158fe6568c..1384a819570 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -58,36 +58,6 @@ test_expect_success 'The -U option overrides diff.context' '
 	test_grep ! "^ firstline" output
 '
 
-test_expect_success 'The -U option overrides diff.context for "add"' '
-	test_config diff.context 8 &&
-	git add -U4 -p >output &&
-	test_grep ! "^ firstline" output
-'
-
-test_expect_success 'The -U option overrides diff.context for "commit"' '
-	test_config diff.context 8 &&
-	! git commit -U4 -p >output &&
-	test_grep ! "^ firstline" output
-'
-
-test_expect_success 'The -U option overrides diff.context for "checkout"' '
-	test_config diff.context 8 &&
-	git checkout -U4 -p >output &&
-	test_grep ! "^ firstline" output
-'
-
-test_expect_success 'The -U option overrides diff.context for "stash"' '
-	test_config diff.context 8 &&
-	! git stash -U4 -p >output &&
-	test_grep ! "^ firstline" output
-'
-
-test_expect_success 'The -U option overrides diff.context for "restore"' '
-	test_config diff.context 8 &&
-	git restore -U4 -p >output &&
-	test_grep ! "^ firstline" output
-'
-
 test_expect_success 'diff.context honored by "diff"' '
 	test_config diff.context 8 &&
 	git diff >output &&
-- 
2.49.0.897.gfad3eb7d210

