Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AD20A5FE
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504036; cv=none; b=tfhsc09M5tQg7Fr7qd8YTcZVbVNTlKoVjqEChiq4abHcRk7/kNFdnbengeHa48nF3dL/TZhFDctVEPReTiXpoGvVAfXWD3M7Sl65kt2ZGtBWkOc+yOKV+FyYvqc9E84hwcsHIy1du09icxFRyZJN93g72Fq3k+q5YyhWY/DnsRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504036; c=relaxed/simple;
	bh=7amw9nj9NJ1j/3kBtBdHqY3ID1VPpy7+TJ/UPPWXXRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFrxg5Uw+6F6FJmnFPouK/xedikBG65XjA3+EuD2I+fiEVBZjAISoLH6DIT6fnMMEIqOWUQYg0nIKiVVg5YRJnstw9Qg3UHE0/1fxacuov83vRSLwZlPHRHhJsEbE3JVeUUmkaJ4Ap2qAsKEjJ8sE93CBwyY4QmXpfYbJgSgNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGDME+zZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGDME+zZ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso2575375a91.3
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 02:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736504034; x=1737108834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5FRGKAaH/Ep9wiQvSqtJye4MJ3Cuz+uaxnWS1XrQQaw=;
        b=SGDME+zZ47ZoBnjNfQgY/tM0qEPizovFK0SGP0YCvDZvEqZUzuXMTydo4JZjPr/45X
         h1hsNzL5d82V9YLWf7RMICmh1kvIZcQ31BpxFZRlXD40Q5P1eod+wx5NIuGo5JU2FZGy
         W+XhiOApyBzMuliVdQ8JckRwwF5p5ZKT3lprvWRrm8UTdUCzKhqxx80UydkPUAchRBvv
         qBYcTG0cTv+t+MZGnJedYO+V6MY7nnRMFYok5RctqPSRDs3Zxv5YRqQI/ujnt+U5LtBK
         L2ohUA90kjMk4GgKzIpGVlnRMho3mOZJ8eak+uNO0/A0nRFCAF1FjrbGqWW2RFcnCjZC
         P2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504034; x=1737108834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FRGKAaH/Ep9wiQvSqtJye4MJ3Cuz+uaxnWS1XrQQaw=;
        b=vIX8RFSO7cTac62sZ01AVZae3jSOZUZJG51/5hy/+4F7tCG2MUzmC5vkPOeyUYCbi2
         4ZT9Sv7H8Fu/QSWY/c2q84RktqL5lzm6glH4OLmDpM1FXB7jbGuzscUjrgpMvbNg6eO0
         oYDLW2JWDwvIVBYOrjzIp84ad8nyroW5WPUh4FbqPz9PpOAQ/J8uKxkzJmYiUvVQ7lU+
         8t3XerXMu3ONCRM4koV3NeD4eNUZ5b5VD7Rmul9xQS/TI9gA5tfJgtlVHtDEiSTLVXGu
         AJuvwBRi0rDdD+DIa9q1D57fDCOkSjKWD5QEkLbtBMIkq6KeYKZPlneMIcITI8sYdt9g
         dL8Q==
X-Gm-Message-State: AOJu0YwgHu1JuzNAWkqhpT6W1DRL9VPYnnN49jmOEIl4HFmgff2t0D8t
	ZS6SPcZVlF2jjzEJv/vI/VArtFBrMGZvmGYVSFufcsdHxfJh6zl3yBUa4s+5GeOOvg==
X-Gm-Gg: ASbGncuzfHnK10jBMS7tN57AnSlsVU3gTLGsveBN7tSXKR1G2Dq3mPHpMsrLUcKicok
	dWMSyKRvhL+BEuZKHOT8SY1ElmtD8CvyZuOfYy2QhRxKraavY2JK5JWM3YwoQoy2EvOA8u0H+qo
	5gSGRGx1B4RppGQ7uJG6g4Y3hfHgzgoWCQKiMUdwT0fbD2y/eI/LcuF6xRS/yfgRmkbOa3w5yXu
	wFb/B7Pp/r9kQoU3xAoMNasC7bTkUidCnTJtdSaB/TEl756PJq0F3aBAkSiwh/v
X-Google-Smtp-Source: AGHT+IFtlI4SZcRz2PXc/uvASHO1sTxIGPmnu+IMAkaLLxksUtG1ZwA0FM9AfVm0zVgeQT3MY2lExQ==
X-Received: by 2002:a17:90b:2e0b:b0:2ee:ab29:1a57 with SMTP id 98e67ed59e1d1-2f548e9a5b7mr15518956a91.2.1736504033974;
        Fri, 10 Jan 2025 02:13:53 -0800 (PST)
Received: from localhost.localdomain ([95.174.71.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5593fed9bsm2971849a91.18.2025.01.10.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:13:53 -0800 (PST)
From: Alecs King <alecsk@gmail.com>
To: git@vger.kernel.org
Cc: Arti Zirk <arti.zirk@gmail.com>
Subject: [PATCH] instaweb: fix ip binding for the python http.server
Date: Fri, 10 Jan 2025 18:13:46 +0800
Message-ID: <20250110101346.30416-1-alecsk@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git instaweb -d python` should bind the server to 0.0.0.0
`git instaweb -d python -l` should bind the server to 127.0.0.1

Signed-off-by: Alecs King <alecsk@gmail.com>
---
 git-instaweb.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 5ad50160bb..7b44f70789 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -694,9 +694,9 @@ class GitWebRequestHandler(CGIHTTPRequestHandler):
 		return result
 
 
-bind = "127.0.0.1"
+bind = "0.0.0.0"
 if "$local" == "true":
-	bind = "0.0.0.0"
+	bind = "127.0.0.1"
 
 # Set our http root directory
 # This is a work around for a missing directory argument in older Python versions
-- 
2.47.1

