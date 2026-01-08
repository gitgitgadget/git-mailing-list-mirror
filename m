Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053F2DAFA1
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894444; cv=none; b=kSN8i/ShJWu9WebXGpU0NqVgdfvwYFHNExdR9LKW1tZMgY2G/ac/gLRrOjxc0GOBh1+xf7kxv42Cxveo0kF5syBVVK4ol2BLfznvovCR7WTy42fPrYtNkiIcjdLoBpMrC7gx9dY6GeJMMxaRHCUsl/2y2h9HoCD4S8YZnb4MBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894444; c=relaxed/simple;
	bh=avQMBo4vBvIhKEOjoEl+Net4CvklL5PA8oQ0ZuNID4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tM5m6dRugtjyPi/vFst1GOGPxipARI87p6X7vhcEu1dKKoH5WsEnls5Q1/lFqdxskJKUvI+PfE7WwImV3tzs+Q5F5zAlRQHrReK0VcFPSMlVmEiXj/PNZWbfNAdDXJ4UmpqhYPpvslHZs/YxQGoDPLuXLszQjA1ZbjttNBzJEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2gWKa5S; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2gWKa5S"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1965254b3a.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767894442; x=1768499242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hL0irnckgFSYrSnv75J6T8BQcNIHhmoMl4IGWhVk9i4=;
        b=j2gWKa5SUPddfTiZgoZkjuXl9Yyu5l1Qe4lrryl4B3ppvnAVsv7j0KmMgLZeNYIlp3
         urMAprpMx5lrt+07k9Qf/WidQMm1le41tgPMifFbTWdNqi9qRiwDz7dqWkIaczpg8xPj
         hEwOMriwth8n3QxK7tsMKmnRHOAYo9Pz+Uzta3r59JMJQQu4ggxsiDvy0UNRG58HNTyA
         sVeNK/1Yb8jKtnUvn5v1iT1i5JFug0Gd6mv/J0YrsxnQGWUOBsFZpVbWy2pmB6cijYWD
         zNFxilPfcSV9av0Nm599v/ZkgPJH5KrV01NO+0sBvDX7LjbVWR9zu8K3zBY+8EJxvDbx
         SkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767894442; x=1768499242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL0irnckgFSYrSnv75J6T8BQcNIHhmoMl4IGWhVk9i4=;
        b=ELdmYU3EKQEu/c1o1g1lgUhKwpAKnCVgk46A0SaM2mTlGyo1AJieuqjm4PsT+BiAym
         F1azPQHMZKZkUNN2/EyOzN5jMi0JLxE69ZHKfbbk53ecZ81qilsAJHNlXa29E2sIqems
         gplkCqHcXjGvFQb+R7RmNKaKsJ+NsO29yDQ/p9I8Jy04AqmGPuZfha6k8tITJf6IcvhB
         DAYoLkioxlrfLJDbxqHgXwd3a4m5BQkk3YWZSlfPiJ6dI7eh3ViV0QuHIgaR6EnxtA3n
         9TxgfeOws4DnCBlotBfKszBg2q/HUztOkZRBG1t9RJS6MRsOpXI4TBPtxzT1Oy3AvAXx
         mc+Q==
X-Gm-Message-State: AOJu0Yy5K1P4BwPj3/tGApzeUrImL9yE5/BeKUvEicpZrbzCLNE6CmVN
	PyH2pk9k7aJjsayhNIics1VO4ABugVCjuGWe3qoQCIYfpw/2rnHAvThwWDrTlC3QK98=
X-Gm-Gg: AY/fxX6B/2YSxJM+EX0yGmD93V/RG7jSc/ADwX50mUcsPXE+qGfz7WlJfFkrOgyPN0T
	OcIt3p5Do2cGM/aP9iqoT4eZJhnhS+Xi6ko8eGMhvn64LJjuBvTwwLzqxSxh9vq8LIdxaSp5tZM
	n6fA/ld3kNNM1m3QgXiFxD5Fw7lTdP2Byz0689uP89a4gkoHl4iH4nowOBFXgwR4MCLUb1DJdjc
	KUOfBv1T1/Xfv95DAOrmMRIJ/q/ewWRThvrGsJCheI5/g5rBGKnerYd+vRVG83Nx3k5RN6X2ny6
	l5yy2JqMUIH3ifnNrnk4vFWH1pDT+0uS8ElGzo9tBWq9KOvSRqTfDSNcbQ8yTZPmKotesIIvry/
	Ib3pNtmcuOjGKUuqXWtyANIk0+xoMrkxYe0HqRpuXkDEupsucVv86LiSGWtbHPvkfCJHZiLoNuA
	IhJw7FDsrg6tPbgipfkTC6CZr4NGcxOyqRG3NtF+dmH1DvwQ==
X-Google-Smtp-Source: AGHT+IH0Sx5DcI7gIVwk2yCunLgEPmD5THk4EZ/qaVYa2QN14kKpZ0O9ejnKoBV+bxVGSTwWmxZAJg==
X-Received: by 2002:a05:6a20:a10e:b0:350:7238:7e2e with SMTP id adf61e73a8af0-3898f9875e2mr6047643637.45.1767894441723;
        Thu, 08 Jan 2026 09:47:21 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:5b8a:d305:6048:24c4:26cd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48d77sm83574165ad.41.2026.01.08.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:47:21 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH] Documentation/MyFirstContribution: add missing dependencies and clarify build steps
Date: Thu,  8 Jan 2026 23:10:49 +0530
Message-ID: <20260108174651.1618874-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues in the MyFirstContribution guide that can lead to
confusion or failiure when following the documented steps.

Add missing header includes in code examples (environment.h and
strbuf.h), correct manpage synopsis formatting to prevent failing
documentation tests, clarify documentation build prerequisites,
including the AsciiDoc and DocBook-XSL stylesheets, specify the use
of parallel test execution with -j$(nproc), noting that it runs
tests using all available CPUs and may be adjusted.

These updates improve accuracy and make the first-time contributor
experience smoother.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index f186dfbc89..38f2a23e77 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -331,7 +331,8 @@ on the command line, including the name of our command. (If `prefix` is empty
 for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
 helpful. So what other context can we get?
 
-Add a line to `#include "config.h"` and `#include "repository.h"`.
+Add a line to `#include "config.h"`, `#include "repository.h"` and
+`#include "environment.h"`.
 Then, add the following bits to the function body:
 function body:
 
@@ -429,6 +430,7 @@ Add the following includes:
 ----
 #include "commit.h"
 #include "pretty.h"
+#include "strbuf.h"
 ----
 
 Then, add the following lines within your implementation of `cmd_psuh()` near
@@ -504,7 +506,7 @@ git-psuh - Delight users' typo with a shy horse
 SYNOPSIS
 --------
 [verse]
-'git-psuh [<arg>...]'
+git psuh [<arg>...]
 
 DESCRIPTION
 -----------
@@ -531,7 +533,7 @@ easier for your user, who can skip to the section they know contains the
 information they need.
 
 NOTE: Before trying to build the docs, make sure you have the package `asciidoc`
-installed.
+and `docbook-xsl` installed. See `INSTALL` for details.
 
 Now that you've written your manpage, you'll need to build it explicitly. We
 convert your AsciiDoc to troff which is man-readable like so:
@@ -726,9 +728,10 @@ $ prove -j$(nproc) --shuffle t[0-9]*.sh
 ----
 
 NOTE: You can also do this with `make test` or use any testing harness which can
-speak TAP. `prove` can run concurrently. `shuffle` randomizes the order the
-tests are run in, which makes them resilient against unwanted inter-test
-dependencies. `prove` also makes the output nicer.
+speak TAP. `prove` can run concurrently. `-j$(nproc)` runs tests using all
+available CPUs in parallel, but the job count can be adjusted as needed.
+`shuffle` randomizes the order the tests are run in, which makes them resilient
+against unwanted inter-test dependencies. `prove` also makes the output nicer.
 
 Go ahead and commit this change, as well.
 
-- 
2.43.0

