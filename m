Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEDB2BD013
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952472; cv=none; b=jHNsojSoxrU+9XzZwg0bEgM09Ca1SI5eYpFQ+ko6vl3xLfTSnWQiOhL5tmVgM8iZfD2Uwxl/vM9dBYMGcJIshTOG7USPchwZ0QcCnOWEXl05jRs6hQ5KQMP4YrenR3vz83OLlYQBaCIgdovw5qHfcwbQxx0E5W1dBMi3XiVUwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952472; c=relaxed/simple;
	bh=lFl2KtcB3SJg8wnP6TsHSp6qGw2xiaDl0QlFbsSexjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDxdwfOfD9gXNDZebCRzIlcFqDFhC/4KaRXDfVzfCJ3hLi8j013gFXBTgWu4W/mlZgSwNtDAmMPo6+tI9BV01EatGoquc1dllNkVMU6OoT2l0lTwzYngnWEIgR47YsffHcQZrhH/PchVcyb35BF8+QAiMsTAISmeGaH5QWyG00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnpnF6kL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnpnF6kL"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7494999de5cso460038b3a.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753952468; x=1754557268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fbJEeo3NIyMvlrDr61nAJdjqra5U08pCLnGL9rj8tY=;
        b=RnpnF6kL3qVfwHrydE55L9S83rV0hFse9IPIDTmiyvi5hQ2pfaItlwmLO4UaNStUrm
         QCGsjgzJtscghhSi7AAtkM/u1vjfO6E0BUVNRS5IPDetoTFxz5ICgFUZZCpZ3jFqang9
         qpIXPi1f9fIsgfrWQBSy2bjMLSQEmVRa43rw4JNQyWVO+kf8+Z0T+56uc1ho89fID6F9
         3ADNFwu5/hGRHczilhPckavsLQFzb5CXgTCCzbvia4SNkhwpbOSIlDUGz5J2rg/kuQhB
         XWHwADbA/ojO8/NlkdP7hvpfEzIon0oBXdr0iyHgFvhInAm+z3h+5Oy84FkM/wod3kwL
         WJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952468; x=1754557268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fbJEeo3NIyMvlrDr61nAJdjqra5U08pCLnGL9rj8tY=;
        b=TNYqOa5EOfdcqu49jzc9MlvzvYW0n+YDyNylU6nHm5LJ0kwxqnpN0RV1UyIQetZBXx
         uC5wmEsVLT4tmjCgjpnMM1mgcrCOTBPiF5c6QbwW5Lgh5pd43aMQa6CeASwyJ5szh6xd
         zEma3W9PlsRXKxK4k75DAN7jnXxk30vVeeVNZx5KkGWSe5ghrrBtt/ANu5WgD4jZK3C4
         caQ7pCNiy4XRGZOzQjrYjG6SJD2pGHALUHrpgW5y5Xe7T0CIVS8c43ijFW3kBA21KroA
         zyWYEGwPoJmGdPZOpmQ3iuYLMD828EaYQ84yec1KP4BOSJmo+oxUEq2jewGqOX7pinMN
         nlNQ==
X-Gm-Message-State: AOJu0YxO1G7EPg2gHZlpbuC/1nHHlbkOgYXvJQpEYO4uJfwJ4E5Yj1Eo
	gYNtkokhPFqkrmBlGTcNEbtF7Hb4PvAWcXzVZYZHmjV4jGd4JdZEJX7RNlwutw==
X-Gm-Gg: ASbGncu7ytNClmN689HL+7ceeSi4wOPAScff/6JPX7VwjXeb8Bhz7gPQfKVwTc83TEM
	mnRrza6Oa69ESuXeCLKkvIJgIC+/u3wDZUTRk5REwEBWfCwlcGJhAQeOR1ANiV3umDC4BNuWG6A
	V+5uDkJVxhyOw51erYjS93MmPR+FX43soFzTYo9bFsdo2i8d9xXYo2nvu9zaB6dGNsi4jAHiGVE
	0gogAHv9WDcgx8sLBMrb4yQCr8bzdrS2mNcPwcW+3VyvayVFNZ1aBxJXDt6okKSeJPSsqinZ0tH
	l4Y5CNMD15kRdhW6XbVRJvPCjSCZoaRmjDe5jj9p8lmr61fp6nTppSqb2Fwgp5d7pCAsVj1NiYJ
	HccJ4Dyach4rZ4XkLa0Q=
X-Google-Smtp-Source: AGHT+IHh1hfkpfWV30g+QgiaXOkh+8Fox+KrRTQv9rDJwXCeZ8O9UQMcbUU7BYAnZclJ/I3BJPr+aQ==
X-Received: by 2002:a05:6a20:939f:b0:237:b321:1e0 with SMTP id adf61e73a8af0-23dc0d581a1mr9645188637.17.1753952468180;
        Thu, 31 Jul 2025 02:01:08 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd22csm1057745b3a.65.2025.07.31.02.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:01:07 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][RFC PATCH v4 5/5] t: add test for git refs list subcommand
Date: Thu, 31 Jul 2025 14:30:40 +0530
Message-Id: <20250731090040.1625303-6-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731090040.1625303-1-meetsoni3017@gmail.com>
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test script, `t/t1461-refs-list.sh`, for the new `git refs list`
command.

This script acts as a simple driver, leveraging the shared test library
created in the preceding commit. It works by overriding the
`$git_for_each_ref` variable to "git refs list" and then sourcing the
shared library (`t/for-each-ref-tests.sh`).

This approach ensures that `git refs list` is tested against the
entire comprehensive test suite of `git for-each-ref`, verifying
that it acts as a compatible drop-in replacement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build        | 1 +
 t/t1461-refs-list.sh | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100755 t/t1461-refs-list.sh

diff --git a/t/meson.build b/t/meson.build
index 50e89e764a..c959c039d0 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -224,6 +224,7 @@ integration_tests = [
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
+  't1461-refs-list.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1461-refs-list.sh b/t/t1461-refs-list.sh
new file mode 100755
index 0000000000..36e3d81e59
--- /dev/null
+++ b/t/t1461-refs-list.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+test_description='git refs list tests'
+
+. ./test-lib.sh
+
+git_for_each_ref='git refs list'
+. "$TEST_DIRECTORY"/for-each-ref-tests.sh
-- 
2.34.1

