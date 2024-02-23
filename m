Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736E14EFC5
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731253; cv=none; b=Pc8DP1AyFeKDSZLPbqdagDpCNMI/xzigOGCSu2pGi13ucnr/QgZX3nskJMnwr6M3PM3FFVn/o7bmt6OB3poOqNX0YWsurJWlPRBWkdqxSRwhn2tC/yW66ytGBAYUwNZfDRFe1LKHxX0di+oxFNya9Fp3Q+bAzCYy5ruCDhGTNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731253; c=relaxed/simple;
	bh=f1ffTXZP5UdQksMtO3LZRF/EeihQuS9aNnziH+nzVF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NHi76q5hK71BDwi/wjup6hF1BGXSXUFxs/3GkU5uxlQSaHFTVS/rz236bznIr3YMT7IBoa4VnN0ogAHXXN6Nq6Ik1zp8PPdMHAp4MYQ4b0+ooBBHEopSrZ74VJbbgGLai0tZC/7kRjiMzPqEUxxyPvTZoVCvYlrnAII02hBFw1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D4KfJ2LL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4KfJ2LL"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso2379217276.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 15:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708731251; x=1709336051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K30ED04T/ZQAwsWwVKBues736gTQaJeYTdmH0g3c1rw=;
        b=D4KfJ2LL20YALk4K8sc69za+6mDB3Fuis/36tQ71cNmUbw8yQDiSjRc77YRcStJrtL
         IbmJZmwr5pTucbJl6LXHdmJo7gzPETycgZ/95hw7GN8iWDiBq1w2tihxObt8C4yrmMD4
         CyV8fPVPbTXiDpWpTz8++91ZoWlKuA6VFvpapHtqLiE8wb0FeFW9hUymBZMxSwVlHPMp
         cyy8Gqg1Da3OxmS4irGBwaQq7LB0wIpV9zMblR7tHB63m9PcOtNFR5vwoqXQK5YMhidP
         yaQgIC1ksnxE/Dd3/28DgPBoJuIR3MPVDZGPJJcRpk8RtpvzeD9hgN0EzVIKNv1/cFYA
         STVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708731251; x=1709336051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K30ED04T/ZQAwsWwVKBues736gTQaJeYTdmH0g3c1rw=;
        b=ObxkeK9Qk2WqhE/PGTixU3kRfB5sE9yEBawDdFjElWE3N5sykKgFjDHV9p5K26Mz3p
         DoEDxN0ZhwDya+3YBJQkLB0FUwVpezr8s631WSM/ByqQjIE9NTWk89dLW+cxoCIMibCt
         AWBK/HiecROFdr9+GgrpsbsFL5wDCbsvepFCiR6jTVKiiCgghEXqyrqeXxzea3qo3Ekz
         x/qfGTC0u867jsoinIzY2n4gbBcTOGLdBXrXqElKpJeCFEE09hBBZ/bRTr7Tsu3MvDD8
         tlw+p6SONe+uV304vKQi+He7ng3MiQUq/ZYMra05ml9Nwl7gIp7PvBD2jpQU+tjjaNhd
         CKHw==
X-Gm-Message-State: AOJu0Yyr5dDbqwrKZHOmgYgi2KBu5AJe0JtDzohulK6FlV6uYasK6P4W
	Oey+jodDRo3lITa4fjh/hpyVbWtryVI8/QOwvMT2JUwSgsFywycRHtGgvIULzry1lPZv9vFRWZv
	w7E5rkmdeZ/8uO1T/KiZxKrcAcBoPQheE80EIPLdNrd7IPB6Anuepi94Gpk4UGKdYcuUtHjUwxs
	EE6L+gK5FMF++pr+372eIyLehvz9lX+stsD5Q+tb8=
X-Google-Smtp-Source: AGHT+IEMWaKMclekxZmjG6sY688DdPT5gTHUF2djqJdT7XXa9xf3ySNkwX+18ZS3wMRAmFO9NlvJ70+vsiU3VQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2fd9:97d1:a490:26b8])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1009:b0:dc7:5aad:8965 with SMTP
 id w9-20020a056902100900b00dc75aad8965mr346693ybt.0.1708731251439; Fri, 23
 Feb 2024 15:34:11 -0800 (PST)
Date: Fri, 23 Feb 2024 15:33:56 -0800
In-Reply-To: <cover.1708728717.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1708728717.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <cbf37e0ddc0e96361d9be60fce44fd3d250b1abf.1708728717.git.steadmon@google.com>
Subject: [PATCH v3 7/7] ci: use test-tool as unit test runner on Windows
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com
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
2.44.0.rc0.258.g7320e95886-goog

