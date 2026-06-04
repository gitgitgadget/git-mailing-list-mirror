Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970E4BCADE
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593326; cv=none; b=DbrEnrqUWywHF9SVHKPYXiykLsQDNT33V7691NLhQ6VHb1sJ8/zmWUAtrllr01e8NuWqaOP5csl4BU0xehns95+NSIuvSrPLSRd8h8Rp8egtam9Ms24EgFAAgLrc8WU0fJh0M3eR15dfBghK/t8zu0WsAaqMtrP79PBz7WvIHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593326; c=relaxed/simple;
	bh=uBAHXvaQWnY2tvxoQPy+wD9xt38qsxILQq5l+fDvyg8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wi2NCL+wrQoSkdidzGBvWilDmE6rlPtxH0ZTjp2dbl0NdQME5bMdwIeBTnTBw1C1CzLGaTyUyojns1KN38nlUhofZ8K+BJ2lO3dqlLt12a3VnSGChxQ8YFiKkR9XeiMtFeL0xDReIDqK0CvB5qqU7EpGZav3l8gCuADTn9f7k4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdHGzsbn; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdHGzsbn"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137eb0d76beso1178816c88.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593323; x=1781198123; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKtOoz5lKx6X414fxd6E6Q64/EfVTO/fcQXPqlycKok=;
        b=rdHGzsbnlxQZ5ghyR+y3K6WNAlEVABmzQmVKmVjqusM3aaRgtWUBq2SyfSPtMc9+5e
         Ubi1ohMIocsbu83pS8SbA3t2NfiGI5ZE0Q5jrDPSHt5ABwvii9mYMsCAi2dUK+1PSHUS
         jjqsVI3koiYoPt4uydWsNZ7mXV7VWvqPVJIPh8LNRNTBZtomCesbaut3tCd26l3/Hi5i
         LCo9WuTmU+z6RUtfzAhqqtf7GQb5Xltou1UWPBQ88N3xJycvHVK9cO9Ds4mEutpjEKJZ
         SCeAlThoCLEcAtBILQ8D9gObbFBlg7wOVk3QF0uQHL75XTThE1sCPZ8OHodOscpGdhwN
         Yk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593323; x=1781198123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tKtOoz5lKx6X414fxd6E6Q64/EfVTO/fcQXPqlycKok=;
        b=IYCRGwsA2z0DT2oWtNQHe8MIwHscF1ORBdNX4ox43nYNMF0OxFEsbq3Fxi0+PFPc9n
         O2+Xe7nEGpeBtBZ5eNzeQs27ddwUj/EZpJvOFwjtZ0r991F2NhGYQbbTDkklfAsw3T0E
         GQMdqKPRV8BSHUuU6X6+wJLvHMOeqtA3SjeJQzf4bUj3hzFg1JqeA0LsJXKyV9lP4WrQ
         lRo8XeYL7vGIJ6zPf2yH++mSrXsg2iKAmHvGtcH7sHV8LdqkK5VGyoU6s2UoVn9KMzhS
         Ma99ElhBAk31YXrboH+qCwe1TABiR4eDhgbRkinkOlh0eQecOqkyYAMCwOGRdG8/VdBl
         75SQ==
X-Gm-Message-State: AOJu0YwsjuZpzSypXh+9quKqnjq2du1jTKA0zN5po8vl0xdGXlDKnVFO
	+c/sNMSZblnk6MW9QOXOAFtgUhuQvubBnNEg0Izj9q3v+8P8TvufVk2wmyC77g==
X-Gm-Gg: Acq92OE2LQohBqFYoiOYjjZezuE+bRDUI5X6lYxkLo0mQ3j+kACwWevwEsYTmpEhpij
	COHwkpfT3A0UtBFr4rIbAi3bXaJw267KzANln7SM3kcMCMlTHPuEhuo3pg2zFeQQvvp458MKhih
	hvcjsCQcGKLnWFFNg4NzTP+K3F86dTSvMWiMNVflGZ3diQQ5LVJumoxqf5x1rS861wdE1BZ+F5M
	dSCBL+U7DY782uBNkg9Ly4W6DBb79oDu390lTXi8frQRNGfgzJHbjJxB8DVBzG205YzUhowIeuH
	p5eMA6DzNAzt/WsEhslEvV15WEy/SP/DHyBCq9y+WARKd4mBig64vi6vjK6I4ntvopWwUwlP7fd
	PiB71rT1iDd51fk0r24BYhbJ36eAodDDxyFQcr/6pgO74fSa8n+K2NoAy91VTzUcdYxuxSfbaWr
	n5LpOkcib/Jaw/n9MRbYvr7rHeRG4DdPC/4duncjW+bAf9qGdQ
X-Received: by 2002:a05:7022:6628:b0:132:133f:63a7 with SMTP id a92af1059eb24-137fdf00953mr2179462c88.8.1780593323313;
        Thu, 04 Jun 2026 10:15:23 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138063de4a5sm52831c88.13.2026.06.04.10.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:15:22 -0700 (PDT)
Message-Id: <8a6beeb16d5275dc457b235bcfd17dfdfe23bf86.1780593313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 17:15:12 +0000
Subject: [PATCH 6/6] hash-object: add a >4GB/LLP64 test case using filtered
 input
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
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

To verify that the `clean` side of the `clean`/`smudge` filter code is
correct with regards to LLP64 (read: to ensure that `size_t` is used
instead of `unsigned long`), here is a test case using a trivial filter,
specifically _not_ writing anything to the object store to limit the
scope of the test case.

As in previous commits, the `big` file from previous test cases is
reused if available, to save setup time, otherwise re-generated.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1007-hash-object.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index f2722380ee..841a6671d1 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -285,4 +285,16 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 	test_cmp expect actual
 '
 
+# This clean filter does nothing, other than excercising the interface.
+# We ensure that cleaning doesn't mangle large files on 64-bit Windows.
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+		'hash filtered files over 4GB correctly' '
+	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	test_oid large5GB >expect &&
+	test_config filter.null-filter.clean "cat" &&
+	echo "big filter=null-filter" >.gitattributes &&
+	git hash-object -- big >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
