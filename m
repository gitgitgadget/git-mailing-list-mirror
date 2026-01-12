Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44A324B33
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247809; cv=none; b=BGDrlDIgRIPXFRHgzbdrfwHr0hj1yjJ63KfDBenfEqMqP0+/SgzNP//mrIG9ovTwAaHNZ8MqXg8GImJllFEUCp2kRxWTs7kBIMmlvIkRzHdG1PvOjyoARQCHUAyEoqQrRrKAFRtZuU4+hIM8Q3GGT89jq9ViiA6LnXa+qnTuHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247809; c=relaxed/simple;
	bh=VTkAkP1jX2PETkg2iAWh7ZG2UpHVen9xvK/swA3K6yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pR0GISZsJw1Kb+62QNawoG5kgbLLTwxMgPNzHNKptyc+B3clcWm7jokQXn94emxsW2z5x3WRb/CKvotaSX4kflt4EQwakZTzw+pHeBupgi0oJzQFrmW/mdNnBGQeo5D8OR5CwCBk8WjNWD+kOIR7Ez0jTmEAGB7nbo5A9O/yUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiksSnWs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiksSnWs"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81f39438187so1008867b3a.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 11:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768247807; x=1768852607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz/Kr92x0NrcIoNiyvMB1CnNnDzMyII6ytF8mMdM/Ro=;
        b=CiksSnWsmApc8lJGg2As0c9iX9TNOcP32bt44x57SNPjiuu4X/vvKBr4HGGxb8p1mj
         6vUrAz4JAbhfzM/nP5u/TsfXHA7mCnans9AQTVqS1DKYRJuMamvdSzUKu/pQKsNRqDPA
         F7cGuG4uszEbGUUdlfKn49S/Cqw70XOgpLT0bpTcpjzLQtMZODoahhMEboLiC7WZMT1g
         R1pWBAfAR/WZX1l+eu8p1NUOKgiR8GzDKWIWaa4/cpUYjK7ZrHcFvZeKoDj4Tai2v06b
         kCS4IBoiYbvAo/B3Pj+XFvUEwi3eDmlbd6vqTaNLoGlJCj8QUDvvXZWiVwy+yeYpGoI0
         sxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768247807; x=1768852607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rz/Kr92x0NrcIoNiyvMB1CnNnDzMyII6ytF8mMdM/Ro=;
        b=Llu8MDNbPvMlXwGPJrfXQUlj+GEGMqrVS39CGnmB3BXiLTLzz25Y/Tx4PafrUxnUHQ
         wRXHJzsz48exVD7fDOiTmmhBzE2+x4RgtaLxO/YCQDmXQkiAlO9d604d/2lr8yDAnIKD
         +kjWN7G9F3JNr+zpnJ3TUnEWaRnAXmjTUzbyDasBhpVDENv6+laqPcAPSsIqd6SMGwvc
         3N1547e/KW74crojdd3I4vQmaftLpliwMUx8/ACwviWXaaB7XreV1b5wcxIa+Rat89VS
         +NK/Pg33PNkyo5vqb8i5aqnVk8a3syaO9GlZz3XkpxVoFiPy2ZvpzjU5uTM4Tu7DNH1v
         pSTw==
X-Gm-Message-State: AOJu0YyrVyb60s/7GkYMEDVRko6rJKtctnB3tgpOyZGZjux9ObnLgMOm
	uEe5GqxQM64Ji6HaQlcLxZG2DLV/FvKPygn2hvyox+WaCBgaG12NjeSc/Vywxg==
X-Gm-Gg: AY/fxX4H78RzdEbf+w+DJTs7Zse6miVybTixaqJQx9NdY1gLqUnvG6Oux17ATNUzCYM
	TC+CpBJwYp+YAbabSrNSLvQu9IK9+ePbwMmTcvD5yd3aJEGoDo6VFdIpAR3cRfD2WoXCwgyM2FQ
	MPnHfYO7QWoJ01tam3eiOwdcN4OZTjRGX95t9OtYWvEjwQ+hAUJKXDxp5f9JYjDJkiNngIPVoz6
	Z12KCMSsut7rU+nd6QIh6U+4xkBShg+mWz09WyQHR/ImgTojFUwXC5Z1cov++OtGT+OxnVS2EMm
	rpvQ4OjKAES0DF9jWiPQPV/ggmx5LhletDCLJtRMU5kLzWNlvL+aSkOLXiPwkL+lh1SaTfKg7PE
	frjQQibbz71gzaRdf5sRXXdvRqEeik1LvmFw5jUP2C3bvZvTl5+yHVBzcHcKkOI3UgS0Co42APH
	neLYFhRaSa7Bj5PExFKkWbIvX4NwNEi2BkxHYXmDLsq//VIA==
X-Google-Smtp-Source: AGHT+IFzymzzNsc1AWChd0U3pisjnytBUADKsWph1d2EFW9UpXCvILqtVRFtdDXPhns6O4+3YiNgaA==
X-Received: by 2002:a05:6a21:a106:b0:38b:d93f:b45a with SMTP id adf61e73a8af0-38bd93fbbbdmr438421637.58.1768247806952;
        Mon, 12 Jan 2026 11:56:46 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:dd74:7b39:2154:bc0f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28f678sm18255731a12.3.2026.01.12.11.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:56:46 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	pushkarkumarsingh1970@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v2] doc: MyFirstContribution: fix missing dependencies and clarify build steps
Date: Tue, 13 Jan 2026 01:23:43 +0530
Message-ID: <20260112195625.391821-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260112191029.376820-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260112191029.376820-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues in the MyFirstContribution guide that can lead to confusion or
test failures when following the documented steps.

* Add missing header includes in code examples (environment.h and strbuf.h).

* Correct manpage synopsis formatting to prevent failing documentation tests.

* Specify the use of parallel test execution with -j$(nproc), noting that it
runs tests using all available CPUs and may be adjusted.

These updates improve documentation accuracy and make the first-time contributor
journey smoother.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index f186dfbc89..7306edab0f 100644
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
@@ -503,8 +505,8 @@ git-psuh - Delight users' typo with a shy horse
 
 SYNOPSIS
 --------
-[verse]
-'git-psuh [<arg>...]'
+[synopsis]
+git psuh [<arg>...]
 
 DESCRIPTION
 -----------
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

