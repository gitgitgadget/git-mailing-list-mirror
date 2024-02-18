Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B9EAD5
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708241621; cv=none; b=XGZpmNBWvfgHls5OEzy+oer+6Xd5SMrNjdloXklxNwqNQQmcSpw4RbRXon/Bfp756lkh+yGosYsDE7hQkj6sabFge6B9by8I7MKH4ZT3/wj6yQHvsmzIvqPsNh87gAUtGQAMJgvtxztZQlYKMDKML2ua+Llvdh+Ev1gPdLXvKlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708241621; c=relaxed/simple;
	bh=8ujX+kVsm9jjU572xg5y5/pxb+955Wd1weWAEMPR984=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AISvvCcnrE3Td9CRgJ0vV6Yg+5pP0YErfqCdMQzFP8tems2+W8IW/dg/w16dc/dm8Mz8GSvmvHeoHNyk8WuqwRyyS1rNTKezILtaZS2J94Pf7JUeK0OKIhcM0EThGfVzKl9RzWpbHXNvb1jQoOlDJqRlEP2lYQWN0jTT7ijCoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afuaSwck; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afuaSwck"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4126126f4f4so2389035e9.0
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708241617; x=1708846417; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxjQAef9+qAUjBcvJJcDUwD4MHxGTp3gRvgdxO0dKLE=;
        b=afuaSwck8URc0ANSWb34/J/EjxRz1C78YY8B0B2mwJc9ooWpMIG52Bxw7EAfqmnFRL
         69A+Stvd74607cFHlWSbOVMcxKy36TIulOZwiz/pT3CvygyQLJCQ28SgZK+KLAtw0oT0
         2X+HfKi4TXCz+eGr9WqkO3kG8Uu37J1P5qZOkrom2RsJn87hn8wsG64uQcF9l7zWgCq2
         HNZ6QLby2GYs1lznmhP06ThyTRfv92IZLpv6lR4ooOvR7ih9hCHHA1wHzmVoGKAeTkel
         vtLLtjqUs3GewFdQvbaih9w+dvMq6RU7NX1tfwxN0eTPNEqkTtQeLrh+sYuVkLvW0aci
         oo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708241617; x=1708846417;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxjQAef9+qAUjBcvJJcDUwD4MHxGTp3gRvgdxO0dKLE=;
        b=ETw9iGVjiG4hSvDBVv1XJ/XAPFPQQ7P5Ysql8B/RLIgShkdYiu1464hBnqAmGEMIe5
         hah1ZGLyBK28nAqktUMSpnf7SblRIlUaUO393SLk07Lbu1W0RyhJX0fHZYOzTVkvH4W8
         xTEpNnFfubYswq8gudW1oszqcxMRSGkXIYVWaKRViG2fL2cAh2TpmHXJs4Qs1jnrBNE3
         6jWLamGlp3t2BliX2HrhMNebFwf0r3avb9bhiQH/HB17oX8FzB5AsMYKnCeOl82EajbM
         MYBOXk4UOKMLZL1Jdv19/jZPMmFH3Vgsg/ANO9lXo5uvajRQXXxIJ/p0RPcWMaggzkLC
         ZCSg==
X-Gm-Message-State: AOJu0YwfLGmEhWcgi31c95/FJBi5GZiBht8p3jMTqCkYky3UKoNShcQB
	34HE2hJ4BHKQ3RFFPdwpytIvuMzIrodN1IyyCufzN7krZV36OxRli6sYCH6+
X-Google-Smtp-Source: AGHT+IEVqtpyXPQA16YpKhVmz2caIDacOLPZ/bmFHm70I5XNJqibFOifvo9T6mAsXDp5+LrLFqjU1w==
X-Received: by 2002:a05:600c:4fc3:b0:411:a70e:3d20 with SMTP id o3-20020a05600c4fc300b00411a70e3d20mr6832592wmq.1.1708241617074;
        Sat, 17 Feb 2024 23:33:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d6192000000b0033b6e26f0f9sm6702727wru.42.2024.02.17.23.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:33:36 -0800 (PST)
Message-ID: <2da1b6509d810c76e5ea753a91b6a3a46a73fa6c.1708241613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
References: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Feb 2024 07:33:30 +0000
Subject: [PATCH 3/5] apply: update t4012 test suite
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
    Emily Shaffer <nasamuffin@google.com>,
    Philip Peterson <philip.c.peterson@gmail.com>,
    Philip Peterson <philip.c.peterson@gmail.com>

From: Philip Peterson <philip.c.peterson@gmail.com>

The test suite matched against a regex that expected the entire errored
output to end before the additional context added to `git apply`.

Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>
---
 t/t4012-diff-binary.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index c64d9d2f405..59defaa37b8 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -68,7 +68,7 @@ test_expect_success 'apply detecting corrupt patch correctly' '
 	git diff >output &&
 	sed -e "s/-CIT/xCIT/" <output >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
-	detected=$(cat detected) &&
+	detected=$(head -n 1 detected) &&
 	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
@@ -77,7 +77,7 @@ test_expect_success 'apply detecting corrupt patch correctly' '
 test_expect_success 'apply detecting corrupt patch correctly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
-	detected=$(cat detected) &&
+	detected=$(head -n 1 detected) &&
 	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
-- 
gitgitgadget

