Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230A3EFFC0
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371048; cv=none; b=iHQsaAypM5AJo9DdI49srTHd1k9BxqORp6E4Ka4DdQR4La4Av34DRCro6akRA8lPqWeSsnqoyY5mFhHEFveq5Kenuc/boaKZrxcCBPflHy0zim3xPfy7FqZCSTgYiGekDUyGhVDTFGxsC15RnfRtTMEWUdRl88Qrmc7aNZL2WzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371048; c=relaxed/simple;
	bh=ayc8hCny0SJ/eL9p/CL364uiqt5rWseCBd77yffnlx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+TOItpA26PLN4aGPey8YOg2a1b4U+TgekqcaXGAy4hRwAvxdGgrTpDeFKgqnJX/SEpFAUVWsB/Sjp4yWEjFkfqUTU07Ol08WRf05gS54uXy0ai1XpBUOSrlc0PEkUk+xMo9+RgiEttmb2FTrXmyGqlH0D+jOrG8hdjqqDEpJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfT3FWUy; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfT3FWUy"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-381a094c43fso470340a91.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783371046; x=1783975846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PbUeh0br+vQhZIPaqt9JtWwDbS3BX8QsddDeqt5h68=;
        b=hfT3FWUyeAO4Jnm/J6cdv1avHR9A+XhXQmRK/Kp6GJ97MGZWcJokeFfHQCXxetdGwm
         ooVNEZGTQiu0jt6r+8HXZcVBejPBYnN1V2j/wekdBmtsRfMJJZlBrIDvltyymQgyNlQV
         MNLDfwbUUyfOKSuiJ9nhMdrIVdDdb+hv4VA68Q5kE0hD3W7F8krxYoT4JrilaGhZeJkG
         MFbgnOf3jIrN9wgPVy1oLZwxNh9SHm73zeW2UZDI3H4VgQZhjwBsI8WofKKQWzX758b5
         pj68vUzK2NQuw0fPMnHuJ1eLKQv5hFL2g/J6nDPPZCwTtmiidpm4FwRsHDGd0TrFQXwu
         vBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371046; x=1783975846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PbUeh0br+vQhZIPaqt9JtWwDbS3BX8QsddDeqt5h68=;
        b=fX/jgvElGmqIAdU3Reg7Am8eIiali7+Ff3tX9JQ4WvY29ALrWDpJr7eGjbHuXoPeRX
         UnYPY+uGEks4K30KtRrLjr7+mAbFJYYLFI13l8hmn9Bjkz2w5jZpjQ6sZQ72DCIVEk3P
         PAQbUaJfP5KBUrOtH0DJQe8C9dzEfbgw/7BPBGV5FRvBBR43KUi+DZsWjR6zvdCtSevY
         JofEI0qZL9ulTZyvkLEebe7xXO3b9tF0nalkg55z6fXpt+GWIHLUEdnzqmM3G6i/naL0
         85dN3YCRIBVtX7HxT4pmXJX4hsiBOa9x5gFH280KzQ74R8NaknBThdS7ZEKH5zGpSWbR
         FAHw==
X-Gm-Message-State: AOJu0YwOIV289DMIaAC6b3SN9MgM4TXl9Wj6KUhqSMgilqarkXUw9zsG
	u0oRkKH1YkrIx2FFUe/t4Rd9C011FQMhcOEyWxJeWwZu1ge0PrE2NFFT4h2fRhrDCH8=
X-Gm-Gg: AfdE7clc38Z5hPlVMX9z59TCY0m3k+rSj6tsCf1dwWm8GSW7nIELa09HT/2EuHsfKT4
	HSHPtxdACtSQZIblhh/UYPFf85FdoVRgC4Cb5QfnCvaan8u2ULY7tJI2kphHuOFFddTCZU235Ug
	uhxKkAWO9Ra+vSboHunaiF1jk5jMgubNOuSMn+Sztz22oWCrRAeHKa7kpX3QnwoOI7g0SjeWW7N
	GSquWfd30cb8EVNJ2N1VgdCI3xSbQdOZU++PqZymKU0GfaRc0gew8RPeFyQV5RAP08/dDsU2Gts
	CINjFAtPB0ogV1YEdd2Fsci5U0c1MRSy9X3437Pj1c6P6N5nXkyn7YOLUNopZhEv2SryS5n/cVG
	Ffy7LqwqbFIyJ4lxMsr4IFB2LnxVMGR5jaOCY2OflU5ZvPCCLFH2hO9cFDW0TIk0IzfFqv0v5Yr
	P8swgxxyGcviBu8iyfwqLSWWU7AxZJjP3RUu8RYnKzkxb5kLrlCnPOu096sQ==
X-Received: by 2002:a17:90b:2e87:b0:387:41de:e8e with SMTP id 98e67ed59e1d1-387575ac00dmr2484627a91.23.1783371046378;
        Mon, 06 Jul 2026 13:50:46 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174892711sm308920eec.13.2026.07.06.13.50.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 13:50:46 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH] t1410-reflog.sh: avoid suppressing git's exit code in pipelines
Date: Tue,  7 Jul 2026 02:20:36 +0530
Message-ID: <20260706205036.3453-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Piping git commands directly to wc -l suppresses the exit code of
git, hiding potential failures from the test suite. Capture the
output to a temporary file first, then count the lines separately
to preserve the exit code.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---
 t/t1410-reflog.sh | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ce71f9a30a..397f94b039 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -244,8 +244,10 @@ test_expect_success 'delete' '
 	test_tick &&
 	git commit -m tiger C &&
 
-	HEAD_entry_count=$(git reflog | wc -l) &&
-	main_entry_count=$(git reflog show main | wc -l) &&
+	git reflog >reflog_output &&
+	HEAD_entry_count=$(wc -l <reflog_output) &&
+	git reflog show main >reflog_main_output &&
+	main_entry_count=$(wc -l <reflog_main_output) &&
 
 	test $HEAD_entry_count = 5 &&
 	test $main_entry_count = 5 &&
@@ -254,16 +256,23 @@ test_expect_success 'delete' '
 	git reflog delete main@{1} &&
 	git reflog show main > output &&
 	test_line_count = $(($main_entry_count - 1)) output &&
-	test $HEAD_entry_count = $(git reflog | wc -l) &&
+	git reflog >reflog_output &&
+	test $HEAD_entry_count = $(wc -l <reflog_output) &&
 	! grep ox < output &&
 
 	main_entry_count=$(wc -l < output) &&
 
 	git reflog delete HEAD@{1} &&
-	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
-	test $main_entry_count = $(git reflog show main | wc -l) &&
+	git reflog >reflog_output &&
+	test $(($HEAD_entry_count -1)) = $(wc -l <reflog_output) &&
+	git reflog show main >reflog_main_output &&
+	test $main_entry_count = $(wc -l <reflog_main_output) &&
+
+
+	git reflog >reflog_output &&
+	HEAD_entry_count=$(wc -l <reflog_output) &&
+
 
-	HEAD_entry_count=$(git reflog | wc -l) &&
 
 	git reflog delete main@{07.04.2005.15:15:00.-0700} &&
 	git reflog show main > output &&
@@ -321,11 +330,15 @@ test_expect_success 'git reflog expire unknown reference' '
 '
 
 test_expect_success 'checkout should not delete log for packed ref' '
-	test $(git reflog main | wc -l) = 4 &&
+	git reflog main >reflog_output &&
+	test $(wc -l <reflog_output) = 4 &&
 	git branch foo &&
 	git pack-refs --all &&
 	git checkout foo &&
-	test $(git reflog main | wc -l) = 4
+	git reflog main >reflog_output &&
+	test $(wc -l <reflog_output) = 4
+
+
 '
 
 test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
-- 
2.54.0

