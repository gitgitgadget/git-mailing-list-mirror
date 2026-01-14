Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E7537F8D5
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405269; cv=none; b=JWTnqsPZGcN9HE+DuYFbRLRoepXnmm0oS1rh7+vlBYi2/uq6uZVAWi2EWj6o/0yso2FpSshiQZL8fyHR7QdjVRQzQmxo21hZY5Lj833BZx4PPXd3T548onT0t5l8tF0dBO6ZknW5YliSvrBk4AyXn2Hh2HXSzTS8LCLzt3PsO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405269; c=relaxed/simple;
	bh=5ZXx03QwCVA2beIWY8mXMTMkRv+tgHteVOy36fYH/qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agt522PnGJ+yd1mpxfk7SOvbFWTX8CC/RoBTA8h03D/oGsjkYNAEU0MB+AvQ1aOvEZ+rRJdsKrxwcjPWoSZmtW6h+Z6Q8oKSTlz/gB/NhOOwDEbuOxZiKOIZidaPBIEXaZS350WMJspQqomixSFemp7Eko9Cx+HNH2qjl7r9ku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arlOtRin; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arlOtRin"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so1527626066b.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405266; x=1769010066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymi2rtlacb+OeWya4hrP1i7wORt5qQvmg7iy3X48jps=;
        b=arlOtRinNaVFC20hfUoLRc+0jvMr9TvjLodPwqqF8WBQtC/hUKvBup6PsFX4PhWj+a
         JH2WFsQlVqBe4HtLdMSGIyNhTnsK86FWMSXfTDMqK1Awuua+VH/rCTGXzzxhcBUA4QQ+
         08cKDScG1hSCnaMOSWTrZPwoqgG3WUm3If/oIgZREvCpZLyWPVD874xqp9HY3tqF72V4
         jfNWjmQCycMc2VIjOpLsMJgstISo39vbaYs1BfTEcmmj/Rc9Pr8GMsRcr/go2Y1yTfUM
         m8kRLFzbuDYTZ7dXCIb9JricdmH4yOJsRy9R5Ox7APKJdVu8OkQOn6ZBoB7+SAa38EUr
         VxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405266; x=1769010066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ymi2rtlacb+OeWya4hrP1i7wORt5qQvmg7iy3X48jps=;
        b=htrkzTcYOato0T6tWaBDY1eBThqCmfuHl9YyhLMiusYCLZA7S7APeANGIs8vUDTAbA
         upnshYaPOHR0qFfnxvFiiEk9vuRCT6lkBQ+km8JGyrvzkbUe2hb26fDlsE8qcd62ceeR
         7TeyR3Mp1lpiDSMTr8mpt3YSE2QEW8PXOo+0kqJkXLBidrTXoZDK6cpypZHHRZls97cv
         KGCDcc4lYQodCEtneS9cbKoSz7W66ZejACN8VoA6zYPH9EWsrjBwr2jSzGKYoiMgxIZq
         HNwVnFJRcomGgJO2E/H9tnSusB53McFRZZrOjKUezKGOHwxK7RQseJmKet20bnWNbtM7
         mN1A==
X-Gm-Message-State: AOJu0Yx11g4+x1jF7SYeNfoYZwE4DnLfe5273a+RYasRuGICrgo34JsH
	hQz/Ea53JgEOURJa4+t4I+FEiYWKzrflklUHGRdDjFG6wakCn8yylblgypP0YA==
X-Gm-Gg: AY/fxX4mJjEPOeX8pFn1utXu81/iWH920PWj33cjhIwrX1spFFv6n0l7BH98kpVCptk
	OswDZpWNVZBwb83dyLdha7DEOFz6vqSU2VqOAfs2QvfCRHn0N1g2kwieXlDi+InMhdtc41QE1XZ
	e8sT6fZgYcMk+gXq1BD5IqqLY9nZ+DG4iaQEW6XJUbMKTRmJ7EJVrWrcFjqQ6CfH/hOVP5SouzI
	fwKdzjlyU6+A+QsDp71b+KRhJjSSsq4FUHTWd6X9bBiK0nWXz3ukUTE2PueAVAoiTddLYn9UAsP
	xNnPm6cFdLL8mRS5URdTx7aXrGkTrAvFz0uK+56NhLmvbNyLJcHmqxgbKnwLe2yXRhXGFvwylb/
	v+X/RJE8+5AmK7LG+aA4CRVEs0rDNA12Jrw5wyKGXpY+FecAzBGNSp/sQS+LjEGbICiP8AklO4H
	QIm4JPOFabG20ALrl4p+Cd3ldGuNQQMw==
X-Received: by 2002:a17:907:842:b0:b80:a31:eb08 with SMTP id a640c23a62f3a-b876140c24emr234454866b.55.1768405266247;
        Wed, 14 Jan 2026 07:41:06 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1b84:297e:182e:6730])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b872642beb3sm804851166b.46.2026.01.14.07.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:41:05 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 14 Jan 2026 16:40:42 +0100
Subject: [PATCH 1/6] refs: remove unused header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-1-f5f8b173c501@gmail.com>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=671; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=5ZXx03QwCVA2beIWY8mXMTMkRv+tgHteVOy36fYH/qQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlnuQ80AernFB3ZSxzNHdFo6PL/rlqGf8YQ4
 4e4gWOL47ottIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpZ7kPAAoJED7VnySO
 Rox/OD4L/1AfWk9BB3msmcUd8Z/nt009QK39MuybLhYfvetHcCT5sWinxUnaC2nFIV5rMGxAwzz
 ktT1IenTnZI+mSaTss/eadHPw7NLXajYkTUarmELExOyTxMGAlqQkuHN4Rwt9VpGwWLt4mxqRA7
 95DLlJjWxVUYgFYTOByjX53f8PC2KAAPD0+2Zxjb8uASR74Ql/DqY99TnbC+YBc5qqcZIKsaURf
 zbNwUqp/2OFOugJoAKw1eUn2wufXhTmhtCEj4JlTJcFqV3nOSR64WUWd6jx7sfDw9PQUe4OkZMH
 C8P+QFaI1altLICbUaKZJAKQE6bmz/dZcQ3iQqBB4hgCUw46ant3KRMoNP6s8ijBAqyeGjvlzoA
 KTHRUEqNIZMsNpLwK7sY+mMwoJFHE+4ClG2WWVnopb0S+0JvBB+8PZgYK4NeofBfDOZoqKwcCUV
 jMUAg28CGmuTyuESf0kRQw12XCJFMJ/omtBnst7R4Z0gGgsuetlc1NKucOYGNwZLUNCwonnKVW3
 90=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Some of the headers in 'refs.c' are no longer required, let's remove
them.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs.c b/refs.c
index e06e0cb072..965b232a06 100644
--- a/refs.c
+++ b/refs.c
@@ -15,7 +15,6 @@
 #include "iterator.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
-#include "run-command.h"
 #include "hook.h"
 #include "object-name.h"
 #include "odb.h"
@@ -26,7 +25,6 @@
 #include "strvec.h"
 #include "repo-settings.h"
 #include "setup.h"
-#include "sigchain.h"
 #include "date.h"
 #include "commit.h"
 #include "wildmatch.h"

-- 
2.51.2

