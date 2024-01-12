Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D71AAA3
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM2IxNHq"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so5925395b3a.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 10:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705082530; x=1705687330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/pC8ZrjzvsxdmV5T25mx1y5yFLX99l0Reay6asoxm0=;
        b=XM2IxNHqa4kbrq5Fs/B4Vk4eDRqVaZagIUdw+1+7jEPT3qaEoy38jpId9rCux5cymi
         POqkVr4hkHlBZr5zxGw7orG2xsLAuMBuIx+ogmNkOY4HU5dfGJ0ZUK9KHiutXS6LaxUs
         ubDcIaSS79kx1LPBJcqrhGjlK+LWrqhQd3V+xBjDbyWWl0UrxJUqgDhjjqume47qfIq5
         gKbMTRccSvyceDGgdw8HOf16T+ACD5ecw2gkXeiQ5g9sc7ZvV76WWhEGvuZMH6MQkJ+s
         YRR65SV7hNiS72/PTawYy/57zldZMi7BiXfwrURi8KsCn7SvEgw87DedJMYzFpQs9esb
         GVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705082530; x=1705687330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/pC8ZrjzvsxdmV5T25mx1y5yFLX99l0Reay6asoxm0=;
        b=T+S5iybBt1c+RO3nZl8gvvATYSFf+LTC6rU0froWjLWoQwLIlW6mq8p617C/Y7plMU
         r4MKGavyyk/XHaXqv7tHgtVNKhUGg4+Wph0VC3NngZn/CnQt+n15lrkiVOCMJslfC6+q
         pF3CHrqNhB35WRzy+hNnaqKObV42tKWIYkLO+WYNCdtZrQdpIByyRAdU0CZTWJSLfTdK
         iR5R+j3BQo8sGCTybjAIUhA+SWmVd7/kn0tw0OSBipQaqj8j7P+REz5mBI1G57HlRv3l
         uOuWIEjAz+PxKkC4xMwLJRn5q1IODHixsBO59WsRCHZ/RKji2MRTrpFAIS1PyDdN4yTv
         2svw==
X-Gm-Message-State: AOJu0YxkGjeJTZormnRgIYrvDuDlf2WRyWgapEfvGpIrAmHvghP5XPOv
	dcIWcefrPWQJinn7stD9qcesO9ygUxrSzChBDQo=
X-Google-Smtp-Source: AGHT+IFO6X2SfODWA+8OefVi2yOAvPxLSxzSZUWmwOSIywFiZXNSy6u/5yWl+y2NwbrNuK4ZyIivAg==
X-Received: by 2002:a17:90a:ea01:b0:28e:783:9cd1 with SMTP id w1-20020a17090aea0100b0028e07839cd1mr1168965pjy.40.1705082529714;
        Fri, 12 Jan 2024 10:02:09 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id ph8-20020a17090b3bc800b0028db69af4a4sm4450352pjb.4.2024.01.12.10.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:02:09 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v4 2/2] t7501: add tests for --amend --signoff
Date: Fri, 12 Jan 2024 23:30:17 +0530
Message-ID: <20240112180109.59350-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112180109.59350-1-shyamthakkar001@gmail.com>
References: <20240110163622.51182-2-shyamthakkar001@gmail.com>
 <20240112180109.59350-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add tests for amending the commit to add Signed-off-by trailer. And
also to check if it does not add another trailer if one already exists.

Currently, there are tests for --signoff separately in t7501, however,
they are not tested with --amend.

Therefore, these tests belong with other similar tests of --amend in
t7501-commit-basic-functionality.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index e4633b4af5..33a9895e72 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -3,8 +3,7 @@
 # Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
 #
 
-# FIXME: Test the various index usages, test reflog,
-# signoff
+# FIXME: Test the various index usages, test reflog
 
 test_description='git commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
@@ -466,6 +465,28 @@ test_expect_success 'amend commit to fix date' '
 
 '
 
+test_expect_success 'amend commit to add signoff' '
+
+	test_commit "msg" file content &&
+	git commit --amend --signoff &&
+	test_commit_message HEAD <<-EOF
+	msg
+
+	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+'
+
+test_expect_success 'amend does not add signoff if it already exists' '
+
+	test_commit --signoff "tenor" file newcontent &&
+	git commit --amend --signoff &&
+	test_commit_message HEAD <<-EOF
+	tenor
+
+	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+'
+
 test_expect_success 'commit mentions forced date in output' '
 	git commit --amend --date=2010-01-02T03:04:05 >output &&
 	grep "Date: *Sat Jan 2 03:04:05 2010" output
-- 
2.43.0

