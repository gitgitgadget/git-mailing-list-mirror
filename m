Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4CF1758B
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728697807; cv=none; b=CYPtw7L2tSAm6iBS/A4CogtvQVUl4TU2VEFP2ipkLozy2iT2DhkqbKfwGETO/8+7V32LQdPhgatu/QO11Cao9/1Nbnjyq/Ei5Q8D5w186gXguUAuECT6Diq2gvt8bVXZDm5zPPQiyETyvLnU05l06CV7h5v5y4TM4NVVeljHrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728697807; c=relaxed/simple;
	bh=6Rv490zObb9O7tt+3CZ39LH88N4f7Gxd84rnolFsj+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpijSGOIdkn7lGUDHLiqiECytavsnJ31u+MzBXL97xCVw9u38t1o0NMbsmE4NzD6m0JfD36vfm1FWuV7aN1zyh3u2fEmD/Hd2JX3yd3H0jZ7DQnXUh0Bd+y1qG1HecJkvbdao3Wtk2H2aHT4uu4/nYu7gQVl+Ejyet+M8cohENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPlyCgRG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPlyCgRG"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so4140362a12.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728697804; x=1729302604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQiyu6/b8ObIzOn7Qa2T97QA6hjFZVFnL+HM6wELhYk=;
        b=VPlyCgRGuAUeYpSoH70uy9MfG5dfqtGBQujYUFhZV46jfvFEfcDAXfeiyQxkYYT0Tq
         1rBpvTmjM1oVG6TgAYT6pnCDweeq6CgzDiumCsQDkz4NMaQ9abp/g9WSz42LLJIHJC8+
         XsIr3ihlSCUtj0h9ZFg/nTnbPjnIrRhX+9hvxr/y+Of7oiVzWiYSF5eOezL6+StgYOqu
         3uIpcNOvteqelrCZJijS0jt1wBbRNUBlO9tVxtKwFOEeOD+wJYR88bwZ7TWAfmjUM0w0
         EZd6pCwz+nofTbYhXgFaMc8YBYbbAyexc0WkbYGbaurA17etdFkIH0pAffa7NM9jHmJV
         dkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728697804; x=1729302604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQiyu6/b8ObIzOn7Qa2T97QA6hjFZVFnL+HM6wELhYk=;
        b=Oouk5KBjNuf71F5irP8frqG/c8e799En06l+QI8uXW5SLKyVfhvWURXOp/MkZH4VEi
         zvDHQFDzEiBYBdBxEDTnGBSDD3MYkD3N/Y37+Wz0ypFOYH9Vq94fZrK7mD/7nsM6uC36
         tXZbELcNXbVkR0W7pOKpYG+dsjQd4bvQYxMyF19cH/AHGeRWTcqaNO3IrdizBfY4jYvL
         dzNsru1wxXZxGi2YLLeBB+L7PqssvGnmPwn74YqJ11CbIiYYXTiE6SifA8BTV3v4nOdw
         0dSync72iTr9Z+xUhvho/cLd7+aoCuDeHP8sKrW5Xnx02KcHQfJKIBHqV/otHKK0q0Dd
         PqCg==
X-Gm-Message-State: AOJu0YxdHxAsw+Kiia2ehNCa4gW52+C7seGMh7IwPhzhLU9heSmP846l
	r2DbZBcqJMgKFcj670JQUXN7L8L/zbo0nPPJ3r2oP2JxVzOSPER2
X-Google-Smtp-Source: AGHT+IGJHy2HE9S7Lq5JzDYta0HvwAQsU92nrnhroSYg4m1C4WEg/bWDGTwFHG07IQoW3K/R3llwiQ==
X-Received: by 2002:a17:907:d25:b0:a99:63fa:2686 with SMTP id a640c23a62f3a-a99a13aa2femr857315766b.20.1728697804054;
        Fri, 11 Oct 2024 18:50:04 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80bfc5esm273122266b.142.2024.10.11.18.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 18:50:03 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johannes.schindelin@gmx.de,
	spectral@google.com
Subject: [PATCH v3 3/3] clang-format: don't align expressions after linebreaks
Date: Sat, 12 Oct 2024 03:49:53 +0200
Message-ID: <36a53299c1ab1b55a09b7e1d499832e6715ebaba.1728697428.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1728697428.git.karthik.188@gmail.com>
References: <cover.1728697428.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We enforce alignment of expressions after linebreaks. Which means for
code such as

    return a || b;

it will expect:

   return a ||
          b;

we instead want 'b' to be indent with tabs, which is already done by the
'ContinuationIndentWidth' variable. So let's explicitly set
'AlignOperands' to false.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/.clang-format b/.clang-format
index 9547fe1b77..b48e7813e4 100644
--- a/.clang-format
+++ b/.clang-format
@@ -42,10 +42,9 @@ AlignConsecutiveMacros: true
 #   int cccccccc;
 AlignEscapedNewlines: Left
 
-# Align operands of binary and ternary expressions
-# int aaa = bbbbbbbbbbb +
-#           cccccc;
-AlignOperands: true
+# Don't enforce alignment after linebreaks and instead
+# rely on the ContinuationIndentWidth value.
+AlignOperands: false
 
 # Don't align trailing comments
 # int a; // Comment a
-- 
2.47.0

