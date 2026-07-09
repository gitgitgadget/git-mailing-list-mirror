Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE49837206E
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573967; cv=none; b=J7byQOcwSdWOfyvTscbzSoomMCIEqxharYnbCh2Gt/nBw7yjwIYyIGZ/AbmyqQ/F0z35NUEolAwHBrZD2FBtdCtjW7sAPZbXOfGbfkoO+L5u3KRTy0YIlQ0wke9TgcRk6dm7Unbjq1nK76UmgybGJNFXviBB2q1KYqzk8kTLaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573967; c=relaxed/simple;
	bh=6fYXnpTsqigK8Jg/mm9XoC2OkTmhJSKMIU5arttHmnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGcZnafhgOKrj2k7kFB0VWyEG+Kv8oVH8czw4YJn4toYpS7e5PeUyIA+wY7Z2vr9OWLDXlKxaal4lsHB+HKEjL8hU0SRVBnlwsTcfiA3iM4+3mMih4cjXeMZdsv5s4Xp0i4q2Bve9IM6iPUUabcuBjpNY+WJZ0bRc5OUw9gDzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIdk+iuQ; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIdk+iuQ"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc2c6e0688so4402345ad.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 22:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783573965; x=1784178765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kADpcc24G1eBT+bapzybUjhis6ckiuRQpVm8IXeuB1Y=;
        b=JIdk+iuQ0XSUOnLrSPSwbMqrR3NezHji6nmv1D7cr1coIdeDFFJj4D9NI/9ZfRWrjW
         i1qc6h0rJTQazN7yHLh3x70a3ve6Ex/VCtcMME9usJ+2NgqpYaGQunyLU6P43psLopJD
         GcQ3XNp8XLz3YfIa32bhQlPglviDpJrpvnlDcsYs0dyByQmwY4x+Tycz0jU0nKzH3Kta
         yWsSI3/CfuSIwpa+rTVrjjm5L8OtVT9YlvHDuy/56OIH93SZjMBk4sS6qgC7/HH5x6UX
         /7IMnW2GrqYGjHr4/dSdeRKFqUyZwQTro6K8RXSZm3qDZb3bg+a9wxKZMvVGGuTIGj8J
         +Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783573965; x=1784178765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kADpcc24G1eBT+bapzybUjhis6ckiuRQpVm8IXeuB1Y=;
        b=TwxOUSN3L2SZVfLLacSxaqtwySB+SuJOtFZdozlJFYBa9AYVAwHOK50Dw0QsIOfwcQ
         NLjrqfNeUVCivaKOLokRljhPzGRXwM0Fxwn/yRXJX6V5Drfuk3mLYN/9avMc5X89rbfn
         tM4R5HqhGwGsTkP1jiy97seSgdIbmjf1p25kEIXixOvqzvn/xSyB6C9iUfIOOBuQgU9J
         s+TOGRfYVXnxVww3zy5+6TN91ZYQtHzqjmqWz02AtthTLnqsiQIkCz2GzYSxGicsNwj7
         NIjl46CoTF+LZD57CO+iIjoKdZe7qjCFCqI0QOeBRXOYCKaZAxQZZYuKQJmB3SL37tx4
         Qszg==
X-Gm-Message-State: AOJu0YyLB/XuzDuVIqK8wvSyaxp586a+682zN1KDY4N/yyapgfsrTkme
	MIfSRZz6cmFlemJm1ivs4NO+XrAyCablgV3gQ2pq5WMBOsy5VUiIwj/Uh96aQgCOknI=
X-Gm-Gg: AfdE7clIzcdd5RR+ka2Xr0nw1nxlhzuEf5Eueq0qyIsHAsRCFtlIqhffJr5B+c66rJS
	JMyBDGTsNYV+MURfNia4xVTRy5jGaYrBR8tmwwcq9GNpIxxlgVWZ0ghAxq8OMBB0165MQIUoF5+
	DHKU0TVyA7PVvakXJ76OvxMOPKzLOTv1X05YWaZ85B/cXOOh1nsZ192JS76WlRzGNXi40CRYZyT
	ePmdTO+NNsic0FeFhzNS9CC42MGxY/uLbP3Ru6KQyAxY+yLKlGQ6o+Y+syUNblst8t8Jwp3trxZ
	m4d3YC1YvT82ioeHg8yqF1pwg8O2h+x4ORDq2PcAxmB/uIQzzmM4mo3d6dw44Mrfh/pUoCcuumU
	HVNVlkTLLp2lc7daiOPsASYDBcZxgtjch0bitrGYxAQ49e5BfAuSuinsXogKCgxu2xWHktCp29x
	Y6j8MKZGjGpbuCKYwn14XOU0PAGWG3LoYk251Qibz1xRP1D/Upfewau89q0g==
X-Received: by 2002:a05:6a21:4e02:b0:3bf:d1f9:b1db with SMTP id adf61e73a8af0-3c0bd158f8fmr6860981637.52.1783573964997;
        Wed, 08 Jul 2026 22:12:44 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659666e7sm32086550c88.7.2026.07.08.22.12.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 22:12:44 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v4] t1410-reflog.sh: avoid suppressing git's exit code in pipelines
Date: Thu,  9 Jul 2026 10:39:35 +0530
Message-ID: <20260709051229.40363-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqv7aprz8a.fsf@gitster.g>
References: <xmqqv7aprz8a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Piping git commands directly to wc -l suppresses the exit code of
git, hiding potential failures from the test suite. Use
test_stdout_line_count instead, which handles exit code preservation
internally while keeping the test logic clean and readable.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---

Changes in v4:
- Restored blank line between test_expect_success blocks that was
  accidentally removed in v2
- Updated commit message to accurately describe the solution

Thank you for the detailed review!

 t/t1410-reflog.sh | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ce71f9a30a..5a40a62ba2 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -244,30 +244,22 @@ test_expect_success 'delete' '
 	test_tick &&
 	git commit -m tiger C &&

-	HEAD_entry_count=$(git reflog | wc -l) &&
-	main_entry_count=$(git reflog show main | wc -l) &&
-
-	test $HEAD_entry_count = 5 &&
-	test $main_entry_count = 5 &&
-
+	test_stdout_line_count = 5 git reflog &&
+	test_stdout_line_count = 5 git reflog show main &&

 	git reflog delete main@{1} &&
+	test_stdout_line_count = 4 git reflog show main &&
+	test_stdout_line_count = 5 git reflog &&
 	git reflog show main > output &&
-	test_line_count = $(($main_entry_count - 1)) output &&
-	test $HEAD_entry_count = $(git reflog | wc -l) &&
 	! grep ox < output &&

-	main_entry_count=$(wc -l < output) &&
-
 	git reflog delete HEAD@{1} &&
-	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
-	test $main_entry_count = $(git reflog show main | wc -l) &&
-
-	HEAD_entry_count=$(git reflog | wc -l) &&
+	test_stdout_line_count = 4 git reflog &&
+	test_stdout_line_count = 4 git reflog show main &&

 	git reflog delete main@{07.04.2005.15:15:00.-0700} &&
+	test_stdout_line_count = 3 git reflog show main &&
 	git reflog show main > output &&
-	test_line_count = $(($main_entry_count - 1)) output &&
 	! grep dragon < output

 '
@@ -321,11 +313,11 @@ test_expect_success 'git reflog expire unknown reference' '
 '

 test_expect_success 'checkout should not delete log for packed ref' '
-	test $(git reflog main | wc -l) = 4 &&
+	test_stdout_line_count = 4 git reflog main &&
 	git branch foo &&
 	git pack-refs --all &&
 	git checkout foo &&
-	test $(git reflog main | wc -l) = 4
+	test_stdout_line_count = 4 git reflog main
 '

 test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
--
2.54.0

