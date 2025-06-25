Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89A2D9EF3
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869830; cv=none; b=stadDQKXI1NlqQv5OIMxCsXyTljCZ2Kkhx4/12/3c0W2gZEYW6CJBwuzQErsLzKcJY9Geq2ZizxHPdRmQ4Vkr0gqN15wroTwxSKgdki1NyJ8iYuac4qhMDlHNR5dJzSvQFyTjY13KP58SvZfY1cktQyhPg4YRCAuTQMcUAq80I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869830; c=relaxed/simple;
	bh=Vpr5WoPO3M/MxPwIqMvnnQ1IcEiCXJwPanBnVoizRiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iyYP0gks0werFLP3s4jdqqvHJnsj87LIGMGpQZZULpImZWVFVsa2jvFK3nF0xSDcW7QOwoJyr4R4U4pwMr/4W10tZSYV10AogtVDC+nZBDD3g45SUGSLffIL1pKXONer9Vb2ili1mg4j2WwLZGQw9xxMbMxaCfqvcS1FYpNfS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6/nZdLz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6/nZdLz"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so16633a12.2
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750869827; x=1751474627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNkJJQLZapShHWYzzakLNBH+zq/DJ3E+rG+hUd/in/k=;
        b=H6/nZdLz6XcDtnOOtawXyGZgbRFV/rFB6NLmFv/dwD9Om1WmYPIhQue3kPUN8I2yEm
         mtYlSwbiyzWLS8ScQMibfl95b3B01qttD/AnXbWopwFCTHHmc6N9d5rLGDvWrv0y3LFl
         dwLfMeXFnWcI3zvT2TkHoxZO+v41n48JsIPNmTF1v0ac1sfnC7tqbu8uFXG0Yz56/2k6
         0Me4FiNmWPkg03R1aqWv5mgkFqecjbrZnuozmcZGdIO9F6Bm1in9HO0uc6SYjIwiQ3KL
         +PE9wxxjkWnbMmpT0VYzFLgxag+3aW3xTec4Ek01wdnriKJ2amFlKYklzVQxL7Nprq2J
         YpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750869827; x=1751474627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNkJJQLZapShHWYzzakLNBH+zq/DJ3E+rG+hUd/in/k=;
        b=si6ul7oGKF12gnj0xASSSGeQElzIJFX37b+MFtmrEs958PjzxqTBP1NL+FcoV+J3oY
         2UIEQGzbBazSe+qidv4bY8tN7LahapcAe/ZHGq+4dbf0yFVcrDBVSl/CvSVB8qLKR70o
         prWhZGRjFh1eLx0tUQdL2uqNtLbgBIyNBfDJQ1CVVVmjrY11+iQI2NnRwLI6LhlEiOcz
         a7kFxLf0WP100nP2in34+Vysl0zPCmBYO6M+z0zSpUrpbA2bc6n8IQEpHsvd+vsEc/KC
         UrECvKzPixG8h27KkHqlieSbcA0324MrNEVaPOuGzyDXeKZVpNPWSe0ehwT8I7ZYaQHc
         oOcg==
X-Gm-Message-State: AOJu0YyO55o3i23p0KLcK5je+NV61ccn6ZhuVe6XHlDJ+eKjWNugEGt+
	JDAmwXSiMp+hjKVbdnDQl2qcOEXC4Leo/rnmh5JbakuIBoqAdhfPu5sUL7ziCrSj+98=
X-Gm-Gg: ASbGncsdQLBmtcedhA6AN1XjoRvTGLKqqgnvhVZrUhJfMU9ND9jCDFcuyihWyxAcYtF
	V2sPpVCLLcnuMoXvnLCSAsx6yNmKnBeqRXhsT2RvNiqmXK7b3ex5mPQO609H7WvRRywttItTXte
	4m6iKxY/fCXUMu3nvOgvTyCQUGrHePHiifBKa2DlWg9bbFqMVmR1XCfX4BPnW46VbMjQIq13SIf
	WiGzdqkBVzUgfzCvgpogQQUEuTYO2awLeje8QMKzujga4fZOcAK8tmuJXzr18iRZogadmKJNPMo
	KkybcGGVkPh+sGNaHgJhm/ZEBzlyfaCwuTUnXWPh9orEqw==
X-Google-Smtp-Source: AGHT+IFMpheQeapb48sdybxHOTUj+z75GfLb04UKbPo7/xGQ5ixJuRqC+wnWwsSDWmTRkstBl9riRw==
X-Received: by 2002:a05:6402:1eca:b0:606:fef3:7c3e with SMTP id 4fb4d7f45d1cf-60c4d3a4314mr3245424a12.3.1750869826937;
        Wed, 25 Jun 2025 09:43:46 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b5f1:56b2:13d2:a5cf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f1b8e14sm2661774a12.35.2025.06.25.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:43:46 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 25 Jun 2025 18:43:27 +0200
Subject: [PATCH 2/4] clang-format: set 'ColumnLimit' to 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-525-make-clang-format-more-robust-v1-2-67a49ecc2fd5@gmail.com>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
In-Reply-To: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Vpr5WoPO3M/MxPwIqMvnnQ1IcEiCXJwPanBnVoizRiA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhcJ0DsgXNoNGTuLbvzR5Ni3Tu1pVNjff8hM
 rAFi2Uji3o2AIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoXCdAAAoJED7VnySO
 Rox/EJ4MAIbWVt1qaXAP36N0gceJGpiUNZvKSiKTYLPdJKDIsNxnlea38Cpw4G/kN8Z+gQzlZjf
 4X75eUNqdEiYS5NM+7H42fohJaP2llmt6oPJu6vIgL21YiWUdXsgqdVKTg5NaONq6myF80Faiq5
 32UXHnSLe2Rz5gcPpGyRbkPTxKKdspiM9v301HcDr7pI/Srewsf6t3/spj1h7jdxC+WP93ryJJr
 5PNyb6p8I2HZ28ZmCmUIeKOwelCN1UX+MVYbY1FNAJ4QIz8K0rhXclAw9s66mcWNVPxMWd+8JZO
 9mzC6Vm/51KhcMjGdSc2JIg7i5wpQlwx6tSvFeonFoEMzFE9sBY7Rh+e8eL4s9FS858lghS1JV6
 wxVOlrIK1hQYEQTOIBEuyqlqLpPlgT0sVhhxypIoL8tjoB7aoYKcyeFATmcntAhKI0mV6gvRcs+
 im6i+6ygD93LzcmmzajzuI4yU6YRnMZS7JBWqLPGHt0fotHGi4pI5P1rBQT1nFwcvByL7AxC4u7
 Ew=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When clang-format was introduced to the Git project in
6134de6ac1 (clang-format: outline the git project's coding style,
2017-08-14), the 'ColumnLimit' was set to 80. This is inline with our
recommendation in 'Documentation/CodingGuidelines', which states:

  We try to keep to at most 80 characters per line.

However while this is recommended limit, this is not the enforced
limit. In some cases in we do overflow this limit to prioritize
readability. Setting the 'ColumnLimit' also means that shorter lines are
concatenated to simply as the result would still be below 80 characters,
which is undesirable.

In the past, we tried to adjust the penalties around line wrapping, once
in 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29)
and another time in 5e9fa0f9fa (clang-format: re-adjust line break
penalties, 2024-10-18). While these settings help tweak the line break
penalties to be more in-line with the requirements of the Git project,
using 'clang-format' still produces a lot of false positives.

So to make 'clang-format' more usable, set the 'ColumnLimit' to 0. This
means that line-wrapping is no-longer a concern of the formatter and
something that the user needs to take care of. The previous commit also
added a more flexible guideline to the '.editorconfig' setting a
'max_line_length' of 120 characters. This should provide some guidance
to users.

In the future, it would be nice to re-instate this limit with adequate
penalties which would follow our guidelines, but currently, it makes
more sense to have a working formatter which we can rely on and which
doesn't create too many false positives.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/.clang-format b/.clang-format
index 9547fe1b77..19d6cf4200 100644
--- a/.clang-format
+++ b/.clang-format
@@ -12,7 +12,15 @@ UseTab: Always
 TabWidth: 8
 IndentWidth: 8
 ContinuationIndentWidth: 8
-ColumnLimit: 80
+
+# While we do want to enforce a character limit of 80 characters, we often
+# allow lines to overflow that limit to prioritize readability. Setting a
+# character limit here with penalties has been finicky and creates too many
+# false positives.
+#
+# NEEDSWORK: It would be nice if we can find optimal settings to ensure we
+# can re-enable the limit here.
+ColumnLimit: 0
 
 # C Language specifics
 Language: Cpp
@@ -210,16 +218,5 @@ MaxEmptyLinesToKeep: 1
 # No empty line at the start of a block.
 KeepEmptyLinesAtTheStartOfBlocks: false
 
-# Penalties
-# This decides what order things should be done if a line is too long
-PenaltyBreakAssignment: 5
-PenaltyBreakBeforeFirstCallParameter: 5
-PenaltyBreakComment: 5
-PenaltyBreakFirstLessLess: 0
-PenaltyBreakOpenParenthesis: 300
-PenaltyBreakString: 5
-PenaltyExcessCharacter: 10
-PenaltyReturnTypeOnItsOwnLine: 300
-
 # Don't sort #include's
 SortIncludes: false

-- 
2.49.0

