Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE515B0F5
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025473; cv=none; b=fTgCtBW1rtnM9wn6PnAZUlE4ESSAnUXOh7XitAHS8EcORYW/jDL5fq5GFfWFFEC2Ma9ENYF6ZqdRISiX4+Ksu9+F+yIRwwbQ1bMjWDo0S5/bu9tSBZZFJ+xzTOAP95kyU+Mjs79ZLnYgiS1YTulB0/9x6AU+EVBFGgSrYgK0nz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025473; c=relaxed/simple;
	bh=zetJarc9VvVfP5g8Pf++IhqS7O1bUyM8FX+xZ57IOeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gd2OIwbrU+AJtGW23UeOA9hw9LLj5XOtG+IoKDWcF5G0MzczMRh1vVOUOWZKehUu7F0Ptvp85coZXTFVcCXlXjE0VasMHO8IS2yXX/q8fPUv6cVDD1WYy0kC6KxRucYEs9EOWvqAblnHumHqMnuXC/5dlmGAuzTA3Ay3Rxv9TTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3xFx64xa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3xFx64xa"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61c9e36888bso43630397b3.2
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715025471; x=1715630271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eR9zye7G9mIUUIaJbjHlBf7VEXXzfcREVNaFQjnXpLA=;
        b=3xFx64xaY5+UxUDvaEbIPZsCCjcSv4m3fsnjYYWSvdyIOeEW0h5OPMc3cLw8r1D+aE
         TJ2nP8N6oCKPqZWiFVZgMIxAeVlKLWekZ7JV3mqUJWNLARBiBB2Id6cV0SdUptZzCdB6
         g3/LJ+CyW4u+akHzuwmt5lg2InSmOhYIIhCLOinnyaQE9ZJYzCE8ni0tbWSgF5gCMWnZ
         wN4O19gzkm6X+Runr3woyZz1KWHEpsL3iJfrVwkCOFPsojnc85Q5KRLZE4FO7ZBqhgAn
         4Wfqf1oX6fh3mRKYaG5G0bKtaP66PSZLvrevGxjC4DuufabHnScaWuAZCa35O142JOLR
         DPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025471; x=1715630271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eR9zye7G9mIUUIaJbjHlBf7VEXXzfcREVNaFQjnXpLA=;
        b=W6euwOdo1jK7wvtU17jI2WIlh23epF1VDmqEeYLSyaWUe5hDBZFD1WY3LBDRIQVnM7
         6EEYo/Xp0OnwGT8TmxVsQ54OR7n1+PQpZNwbrAZgjwIGLiWp5nAtMgdn3Q9Is7Qih3ps
         pqxQFoSb27lkVNJ8u5DW1+BsSk7RGrO0nEjKnyvzMTcky1MSA+0BambZK1G2g5pt3LWx
         YMWW8dri+GI6qYNOwrC/00FO6JyFjGim37orMQ5OoEDNaWvpdEwrBLchSVoYRCwQuK+2
         B1vkx4syz16bjxKHFq6QIS2gGXbRh0CTCartWcXl2RZe9c/x/IYOfGqik3KViHaHVb8R
         F9Rg==
X-Gm-Message-State: AOJu0YwmwaHLFZZvTd1q7GJB8hfgtkSwdGY9QHeylw/NSnv8ZcYMnw/q
	fBQkCRulhyYsvbPTO7qUdbcD6g/+zgEEqtHrLBA+Xrh3p1axtwcHuhx0ywYQfDEAdUwmKxf1rB1
	G4uR26dK8Grobu+wAqf1Z2ob0Mvpzo+wTQ5xOW9/NpQMfoJoL8r/INk3z+cfwcDV/7qCDJWI39B
	Bpc+RPF0se4JetZpvcxa6XRsL8ky5IBsF0ol08a/o=
X-Google-Smtp-Source: AGHT+IHfbee9Z+uE/bbh76DLvPKX6Q7YBNmqIJsLuZ80Ei8XDkhc/5M3JlEVVPoFmDq1KXpAncui6ZG1BwZapg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
 (user=steadmon job=sendgmr) by 2002:a0d:d857:0:b0:61b:e524:f91a with SMTP id
 a84-20020a0dd857000000b0061be524f91amr2555432ywe.10.1715025471629; Mon, 06
 May 2024 12:57:51 -0700 (PDT)
Date: Mon,  6 May 2024 12:57:37 -0700
In-Reply-To: <cover.1715024899.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1715024899.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <2f5853a7fae7967ba959ae16c81c90b6be52a536.1715024899.git.steadmon@google.com>
Subject: [PATCH v6 7/7] ci: use test-tool as unit test runner on Windows
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

Although the previous commit changed t/Makefile to run unit tests
alongside shell tests, the Windows CI still needs a separate unit-tests
step due to how the test sharding works.

We want to avoid using `prove` as a test running on Windows due to
performance issues [1], so use the new test-tool runner instead.

[1] https://lore.kernel.org/git/850ea42c-f103-68d5-896b-9120e2628686@gmx.de/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 ci/run-test-slice.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index ae8094382f..e167e646f7 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -17,7 +17,7 @@ handle_failed_tests
 
 # We only have one unit test at the moment, so run it in the first slice
 if [ "$1" == "0" ] ; then
-	group "Run unit tests" make --quiet -C t unit-tests-prove
+	group "Run unit tests" make --quiet -C t unit-tests-test-tool
 fi
 
 check_unignored_build_artifacts
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

