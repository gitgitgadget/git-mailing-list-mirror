Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA123F41F
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448211; cv=none; b=gv9tnLgKRpFVqFKDjhnYgIIm6wLCkjb4uEQf1tngy1vftjkyJBKtzfga6vGsIdkS3jYzWUbarU4PvKH5Recg3wgU4+XH1cSopcirb+9wvnSJ4R63kqNKay2/QwHEMz82jNBvM+nogL0/OVD50dHjqeLjy6AOU1tAIZcgRQE0Iig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448211; c=relaxed/simple;
	bh=BeO9WFmMRqhhu/s9N8eXSCUL1EOqkPDqzJwrJeWZ0/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XN4E/InxIeUCodUer1Ps9kjr1hQZsFUgL4zUKxXhcnKNJxfkzD0Eld8+f3P/U3+XwX5liSdQ2Y3UE+TYiuCsBA2gCnR4SKemaARDBBRpwCSzoQZvP+ebSzfSBsxDMvgSo8+5tJ/qD5s6/IU2pWxPqhc1P8nicpYS4JjHvlj0aeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB2tBny6; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB2tBny6"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso11684333a12.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 02:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751448208; x=1752053008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1V22kMtCJCpgUiSd4K7Tfo81CPOoYvdSFZsdAfJT9o=;
        b=XB2tBny6E73XuBdAMhFKGEbOGgaokrMtNVxqV+J2+7ThwTXmvhVtte5cAnK9OYrHef
         17T0YDGB5Q40ncF6WE2eJvNrSJoAqN4UWFvAMJL7F7x/Q1wKxnkPGb17t5SxSDy4JMY5
         9rwIgLqFyOB3AkPdUYCSI7CD6MkMF2Lcg8dIBuXD3m1VfAQlH5FDfvoWCgzFu4TkNGJL
         jemO1w/R+d/Dh2LSMyzMqYrDSy1rR3z4HTC/vC7vI+c2iSr/Rda74TPoiKyRfK43t95r
         NHlPGC9bzIMpJdMRm0T+5Cfoq+13TOTv3ESmmpPbhO57lXQ0FvZ1ixowYbJUj9XocTjm
         Np9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448208; x=1752053008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1V22kMtCJCpgUiSd4K7Tfo81CPOoYvdSFZsdAfJT9o=;
        b=SaKQSMoc+mz2PJ8+GL7zEnwdFV/RoBYFuqvr67W5QPuNmGMwed8X8eu+VOiGebCFPw
         aENCMpz8Tsmol0FIHSiVt5jiu4gxWcb1uxAWcOn4iEPlQ/ZDRKw5I5OMHcUXquVZ6V/P
         hsk/O57ObkgV1VwSYGm8C91ooBEwKWD+u3BdcM0CfC00lgFFCmi0ameUDFsCFD4BVob3
         SV8bOfLO48K4Rz0/EuUlYe2YLrN24W9+XHp9T/MIA80g+faYNinw026Qz8JjMB1ta0Na
         zckfqjJo8Kq2hWoh6Yxe3uaQbUdnhLG740n9bmC2tTiUrDbgcmKOAiXZ577Y4dB65gU0
         jG7g==
X-Gm-Message-State: AOJu0Yz807x2XV+ofd6NA/KcXK7f4v9czzImasP+WsUSZEDkeV5L7dsx
	5/1xSmpBnxfYnpdEhTgZ1E2dfPm+woCuV7LAYjkHf9CaID804bFyygk4
X-Gm-Gg: ASbGncvicgaGPoQDf+Ek8qiA6MoHVgvU5QTYIsA4oIsNOWoCE7XkXvmEWGzuSew0QPO
	Hes9rwMANvxV9xDxl0b0szaVzQIytQNwaYL/ElIoeckesIlaXfjKWrK7Y4s9eUSq0mWhtvKtPrI
	UlM5Lu/mxOoi5p2nCpq2HYEVXaX+ZDwU7STjnBdeolSJgPxKioyTywdQ8Q8i6IPf3dECSw7FkWj
	lyPr1iT2pf1yJ+Bm6NEDlA+aQX9xcoIQx6ZP/E5o/D3zPvHHZ++bdcrI1k+wKJB9W2qfRafvWkX
	Yn1mc2GdTSe/cOlG1WwINQlEexGjMu22BImEnmj9v5lf4Q==
X-Google-Smtp-Source: AGHT+IEbXcp+gMKs+ykbGGcc9ihs9hNLAlz0iiRMEimT9Gq64ymaBOXzrRN16czHNwVXbmcncJ97xg==
X-Received: by 2002:a17:907:94c9:b0:ae3:69a8:8da4 with SMTP id a640c23a62f3a-ae3c2b05968mr166540666b.9.1751448207750;
        Wed, 02 Jul 2025 02:23:27 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:56cd:2345:b424:ce97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b1b9sm1052809066b.12.2025.07.02.02.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:23:27 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 02 Jul 2025 11:23:19 +0200
Subject: [PATCH v3 2/3] clang-format: add 'RemoveBracesLLVM' to the main
 config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-525-make-clang-format-more-robust-v3-2-705344f30580@gmail.com>
References: <20250702-525-make-clang-format-more-robust-v3-0-705344f30580@gmail.com>
In-Reply-To: <20250702-525-make-clang-format-more-robust-v3-0-705344f30580@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, chriscool@tuxfamily.org, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=BeO9WFmMRqhhu/s9N8eXSCUL1EOqkPDqzJwrJeWZ0/M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhk+oz4aCoqgGeevGIQifR309vz70H4b/OAU
 Id1pEoHr5IHqYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoZPqMAAoJED7VnySO
 Rox/7FsL/0tcw7gKmEdGTOu+0jr9DR3Y38HrEdlzNze4KLQi+64RhmzVGg/ZqT7EIWQrS1Q3cEr
 cUgMC0lsB5oFb2nE55ISfeO4id2ouPS9LCTZIdaOGr+tonnMK1jhCdfhzKTgwtcuFh5IyLgHCax
 CN25FjdlsM3zsQtwDLDtcuxLqAQYAdJiucjfa7mE7auncP7SQTZI/ci7e/biphPuJnZqEGzubAC
 WbbdAIqv9++ejVbyAyrC3+lCQdmUKS67Qj1v537OnruEPhu/bqHlgGvQnVDuCY/7oeCBkRDkqFH
 4h24lncRo9NHSmylPNflTEPIyIiqrkBcXBh/jANYjo+IOrf6ldh0+aSsH6fj3rzvOdG7EKd45+N
 9d1r3sm+8u473huCIZJSQwhC3mNQSBb4LO0B7J5mkBR9XCueHaDH0Leu69yXxnB/CVPQPfLJH8G
 dXKQJwTdEaidI3xyDRutbV/TKrOS+o72XJAFsyOzHRmO+JMOamRrMKHJDKycs/JUq7/IpH2p8w6
 Ik=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 1b8f306612 (ci/style-check: add `RemoveBracesLLVM` in CI job,
2024-07-23) we added 'RemoveBracesLLVM' to the CI job of running the
clang formatter.

This rule checks and warns against using braces on simple
single-statement bodies of statements. Since we haven't had any issues
regarding this rule, we can now move it into the main clang-format
config and remove it from being CI exclusive.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format         |  6 ++++++
 ci/run-style-check.sh | 18 +-----------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/.clang-format b/.clang-format
index 19d6cf4200..dcfd0aad60 100644
--- a/.clang-format
+++ b/.clang-format
@@ -220,3 +220,9 @@ KeepEmptyLinesAtTheStartOfBlocks: false
 
 # Don't sort #include's
 SortIncludes: false
+
+# Remove optional braces of control statements (if, else, for, and while)
+# according to the LLVM coding style. This avoids braces on simple
+# single-statement bodies of statements but keeps braces if one side of
+# if/else if/.../else cascade has multi-statement body.
+RemoveBracesLLVM: true
diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
index 6cd4b1d934..0832c19df0 100755
--- a/ci/run-style-check.sh
+++ b/ci/run-style-check.sh
@@ -5,21 +5,5 @@
 
 baseCommit=$1
 
-# Remove optional braces of control statements (if, else, for, and while)
-# according to the LLVM coding style. This avoids braces on simple
-# single-statement bodies of statements but keeps braces if one side of
-# if/else if/.../else cascade has multi-statement body.
-#
-# As this rule comes with a warning [1], we want to experiment with it
-# before adding it in-tree. since the CI job for the style check is allowed
-# to fail, appending the rule here allows us to validate its efficacy.
-# While also ensuring that end-users are not affected directly.
-#
-# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
-{
-	cat .clang-format
-	echo "RemoveBracesLLVM: true"
-} >/tmp/clang-format-rules
-
-git clang-format --style=file:/tmp/clang-format-rules \
+git clang-format --style=file:.clang-format \
 	--diff --extensions c,h "$baseCommit"

-- 
2.49.0

