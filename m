Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE217D09D
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290578; cv=none; b=SWnluDOkAeaVWNv378+foxBFYIRGTf9AHw+hhBk4Qe0+e6zfHlncxthJCByeWHK3BsA32u/KkAJSCmAozBhGC4v0b+BFd8AHkw9crV5vv3I5/wVOcx37mpqzWvtFehFRQt5Kx0bnpgAXrj+UEb9/xteW2XmnEb4RgbLJgYjXlOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290578; c=relaxed/simple;
	bh=GihmzoGpXQcJWWVBnIdVZUVKWLXaKUcn40FtEz0KU9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULR/t3kaybanZILDHQTiYP35i8y29nYZXS8tDNJ2BFptOsTQBVy3SwHjDa8QWV1nGyNur/KzJIq13hzKIiQjfjE1kowEbf6ksYUVUa27jNoTYoRp/5W37uhaiA7ErpSnEuUIz7LvwfhPndBEvoJPyJ8fr3iiGy9Xe6hexOfPUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVqm8dVY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVqm8dVY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266edee10cso223855e9.2
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721290575; x=1721895375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdJVQPxnX2ejLWnSEXYE14wHZC6ZGRrq/+9puE7yOEs=;
        b=WVqm8dVY0lpz9KzBJN4/Wt4qmSdiR1uZ4UACtrCKnjHd8nX3lC65c6REdpsOPfYM6m
         9dv8V8mdAyW2QPQSzcr1TIV4aBU2qLAY8Tr7lWVA8Zo+kOtKGP9octBsztXKkVu6kk4k
         5WIpxovtdQQ6ycydP3u2RqZ82lordEFlKT5sR7kyiSwP8MzeEI53XXJs+a6Gaua2wsFG
         eUXnXj3BYzYQFoI3lIEDRheLe4SWE4XlSq01XK50TxObCpI2TXTQFCEKTX/fE6hPEN8z
         v7ZrsRPyMYpmoEXbmmmAQpWqgr6TERpLjrCOVPXTalcCXtYsjT957o4Ga9pJgjss3RrC
         3ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290575; x=1721895375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdJVQPxnX2ejLWnSEXYE14wHZC6ZGRrq/+9puE7yOEs=;
        b=l3BWZk/UD1X4LFMGIJE5g6jCQFMnbA3GXJOesSQsVBJi5QmAF8yIidseMRZ0tfyTEa
         XOnvGqQaoCkpH8SnSxQQWGpgAbogfLaoIax6hF2vuUkNZzWfPTK+py0Qgh9x1zBY9R7m
         yL7EtHA9xn4i4Toz8rcZe7l/gsnVPjeb7cAxsHJvsvTvMH5mPpFALQbX9gHZuxzhmpwB
         KoRwcwWcvyi5CSYg0fSxMIT1ZgoVc2D6jeSd1oc7UjqZhKJyQs52C/lt0m863UZhrRTR
         T1V/CNsE5ZYiBJGgWydRlbrvSzPafLCYyFzHRGmBk7ERYFfihz757aYPInVuswaMaiAK
         HciA==
X-Forwarded-Encrypted: i=1; AJvYcCUJDlKXTXrenij2WbtXW/u5IxLmOlwnPg4WTB10ObtpJilgxHSX9L9Uhg/priHhTlJ2LdNyI1toZxHxx1K3lPKfHFjg
X-Gm-Message-State: AOJu0YzfqB2hbrLdxbU2h4H2/XkBQVGtZY8x4dM/J/nZ++Zcxipqqnw+
	d/0GitbXnd3fqwkSwyHKHtwFXrq1o8ULu/CckL0VnWEhMROGtCxO
X-Google-Smtp-Source: AGHT+IFZBuayHQyEhbWldUA5UH7AEsqhPZlehG68DBICXAsjC4PvzloFvbJ2HM16+zxovkqCU7+wHA==
X-Received: by 2002:a05:600c:1c28:b0:426:6220:cb57 with SMTP id 5b1f17b1804b1-427c2cefe49mr29566205e9.25.1721290574672;
        Thu, 18 Jul 2024 01:16:14 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e75c:3a24:6dbb:5d7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm1714375e9.1.2024.07.18.01.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:16:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v5 6/6] ci/style-check: add `RemoveBracesLLVM` in CI job
Date: Thu, 18 Jul 2024 10:16:05 +0200
Message-ID: <20240718081605.452366-7-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718081605.452366-1-karthik.188@gmail.com>
References: <20240715093047.49321-1-karthik.188@gmail.com>
 <20240718081605.452366-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For 'clang-format', setting 'RemoveBracesLLVM' to 'true', adds a check
to ensure we avoid curly braces for single-statement bodies in
conditional blocks.

However, the option does come with two warnings [1]:

    This option will be renamed and expanded to support other styles.

and

    Setting this option to true could lead to incorrect code formatting
    due to clang-format’s lack of complete semantic information. As
    such, extra care should be taken to review code changes made by
    this option.

The latter seems to be of concern. While we want to experiment with the
rule, adding it to the in-tree '.clang-format' could affect end-users.
Let's only add it to the CI jobs for now. With time, we can evaluate
its efficacy and decide if we want to add it to '.clang-format' or
retract it entirely. We do so, by adding the existing rules in
'.clang-format' and this rule to a temp file outside the working tree,
which is then used by 'git clang-format'. This ensures we don't murk
with files in-tree.

[1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ci/run-style-check.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
index 76dd37d22b..6cd4b1d934 100755
--- a/ci/run-style-check.sh
+++ b/ci/run-style-check.sh
@@ -5,4 +5,21 @@
 
 baseCommit=$1
 
-git clang-format --style file --diff --extensions c,h "$baseCommit"
+# Remove optional braces of control statements (if, else, for, and while)
+# according to the LLVM coding style. This avoids braces on simple
+# single-statement bodies of statements but keeps braces if one side of
+# if/else if/.../else cascade has multi-statement body.
+#
+# As this rule comes with a warning [1], we want to experiment with it
+# before adding it in-tree. since the CI job for the style check is allowed
+# to fail, appending the rule here allows us to validate its efficacy.
+# While also ensuring that end-users are not affected directly.
+#
+# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
+{
+	cat .clang-format
+	echo "RemoveBracesLLVM: true"
+} >/tmp/clang-format-rules
+
+git clang-format --style=file:/tmp/clang-format-rules \
+	--diff --extensions c,h "$baseCommit"
-- 
2.45.2

