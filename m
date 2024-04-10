Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A63523A
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712719700; cv=none; b=rPbrSo9pHoeyTDwDy/XynymuHFYRPU2GgQiQtVVzMedY21C2Q214+1/9V/bFRyCa8acU3PAKqsW2Nutsg1jxSUqjMiBARNPxI54Pk6HGRmUPMxOyPxCYfcQu0NI+gt98leDKYMhIgxKUmw0zt071JV6fGcwRH7jilaLNXD/rQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712719700; c=relaxed/simple;
	bh=vF7vo5ZD4EVURfnCEhJwnL/ZCy1Bb4dFn+YQmdc0BOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSba7TCgoN/ZFd3chy9XyTUJnY8g1Az2OkBigm6GFLETek7pN2MOd35pDQCJmXgN1sJov/9MxXYy37f6HnYFJT0mj/bh8YjAg/zp4yMJZ1j2Udc/+A7YCvNmwutPngBVF0ZmLASEouZNwkFzGi/Kj5PyML4/lyVvUZDko6ahfUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJSqdfOe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJSqdfOe"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e2178b2cf2so56618885ad.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712719698; x=1713324498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhPIpXsslQdKd2XfxllCUejE2VWl+YPqFID9TvAhIhA=;
        b=DJSqdfOeTDR2GqArNRlV0iGrEuj2jEHrWo1iAXGNvJX7+2T+m6x0MEhfxShENL1gEg
         Vj/MfdT5/znCWVRABYeJNd1djFDchj68Xh5hrnrVDSZcIw0qwEO5e7kwaMJfel7lX682
         Fk9AWUOhaJOhngAw3UoTwd4Hc6wHkEmPfdCnKRxJLN1x9VNNq6JplrVZSkcsfwaQnRU4
         9lOh/4q2eSytJH5KkcoxkcVACv5qunfXRO2HTK2oqLD1nKS1P1i8CwFzp1YITt2elEh2
         Fz/3/SXk3HAoVGQoXDAWcSpprdFbPgbdoYOua2g8f6C/R/9+SvbwTcYWDNLhVKaZG6YZ
         Vh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712719698; x=1713324498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhPIpXsslQdKd2XfxllCUejE2VWl+YPqFID9TvAhIhA=;
        b=kBw6+y/RDcXAt5swXczCJQhFtq+CyWg9OADBl4RprbsHCVB0RLJdmgn0gExlYNsfbs
         J/aIjszMH/peiA2Y4QpJdCRppMkcy+QW0QiMe2k1uHO+exExliiDYStbN/9/jXa7BPPD
         Pnd7WAJoDsBbg94Y7qyP3joox6tfXf4w2/JQ4lYtzG1/akkTWMeYqJE9f110A1WnL/CI
         njRdi0tds3ciVDjc0FSlt/fxuHP8fC9bAI6l9e1MOnIzEgtsGpWAyTwbZxUBup41l1g3
         XmMP8TGe9WsT9tAw/sZI2vl7ic6YQ6XV5/hu15fXinAjWezKfmcksaiCyng2Ex2GtHzY
         sfPA==
X-Gm-Message-State: AOJu0Yz8KEd02c4l/0v3ZN7qfqqAsYt5LI81Z016HKCbahWcqKo/nhg5
	DFL4FzLCkhqJfPFMKNNJf4ZgvtnjSEzhaJbYzZQuyMSZytUW6p69FWybfaNG
X-Google-Smtp-Source: AGHT+IE81xuBtrvvqNMdEYtFqWOSi03VPAYcnLqul8alxXRkYuTBfjMiEGfEvhDoRALQMACnVZrTWg==
X-Received: by 2002:a17:903:11c3:b0:1e4:9bce:9d75 with SMTP id q3-20020a17090311c300b001e49bce9d75mr1830847plh.65.1712719698374;
        Tue, 09 Apr 2024 20:28:18 -0700 (PDT)
Received: from thubon.lan ([14.191.223.174])
        by smtp.gmail.com with ESMTPSA id jc2-20020a17090325c200b001e28d18bd52sm9727159plb.232.2024.04.09.20.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 20:28:17 -0700 (PDT)
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v2] t9604: Fix test for musl libc and new Debian
Date: Wed, 10 Apr 2024 10:28:12 +0700
Message-ID: <20240410032812.30476-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e9588666f
In-Reply-To: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
References: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CST6CDT and the like are POSIX timezone, with no rule for transition.
And POSIX doesn't enforce how to interpret the rule if it's omited.
Some libc (e.g. glibc) resorted back to IANA (formerly Olson) db rules
for those timezones.  Some libc (e.g. FreeBSD) uses a fixed rule.
Other libc (e.g. musl) interpret that as no transition at all [1].

In addition, distributions (notoriously Debian-derived, which uses IANA
db for CST6CDT and the like) started to split "legacy" timezones
like CST6CDT, EST5EDT into `tzdata-legacy', which will not be installed
by default [2].

In those cases, t9604 will run into failure.

Let's switch to POSIX timezone with rules to change timezone.

1: http://mm.icann.org/pipermail/tz/2024-March/058751.html
2: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1043250

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
Range-diff against v1:
1:  23a4298eababe ! 1:  9494adb39120c t9604: Fix test for musl libc and new Debian
    @@ Commit message
     
         CST6CDT and the like are POSIX timezone, with no rule for transition.
         And POSIX doesn't enforce how to interpret the rule if it's omited.
    -    Some libc resorted back to IANA (formerly Olson) db rules for those
    -    timezones.  Other libc (e.g. musl) interpret that as no transition at
    -    all [1].
    +    Some libc (e.g. glibc) resorted back to IANA (formerly Olson) db rules
    +    for those timezones.  Some libc (e.g. FreeBSD) uses a fixed rule.
    +    Other libc (e.g. musl) interpret that as no transition at all [1].
     
         In addition, distributions (notoriously Debian-derived, which uses IANA
         db for CST6CDT and the like) started to split "legacy" timezones
    @@ Commit message
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## t/t9604-cvsimport-timestamps.sh ##
    -@@ t/t9604-cvsimport-timestamps.sh: test_description='git cvsimport timestamps'
    +@@
    + test_description='git cvsimport timestamps'
    + . ./lib-cvs.sh
      
    ++test_lazy_prereq POSIX_TIMEZONE '
    ++	local tz=XST-1XDT,M3.5.0,M11.1.0
    ++	echo "1711846799 -> 2024-03-31 01:59:59 +0100" >expected &&
    ++	TZ="$tz" test-tool date show:iso-local 1711846799 >actual &&
    ++	test_cmp expected actual &&
    ++	echo "1711846800 -> 2024-03-31 03:00:00 +0200" >expected &&
    ++	TZ="$tz" test-tool date show:iso-local 1711846800 >actual &&
    ++	test_cmp expected actual &&
    ++	echo "1730591999 -> 2024-11-03 01:59:59 +0200" >expected &&
    ++	TZ="$tz" test-tool date show:iso-local 1730591999 >actual &&
    ++	test_cmp expected actual &&
    ++	echo "1730592000 -> 2024-11-03 01:00:00 +0100" >expected &&
    ++	TZ="$tz" test-tool date show:iso-local 1730592000 >actual &&
    ++	test_cmp expected actual
    ++'
    ++
      setup_cvs_test_repository t9604
      
     -test_expect_success PERL 'check timestamps are UTC (TZ=CST6CDT)' '
    -+test_expect_success PERL 'check timestamps are UTC (TZ=America/Chicago)' '
    ++test_expect_success PERL,POSIX_TIMEZONE 'check timestamps are UTC' '
      
     -	TZ=CST6CDT git cvsimport -p"-x" -C module-1 module &&
     +	TZ=CST6CDT,M4.1.0,M10.5.0 \
    @@ t/t9604-cvsimport-timestamps.sh: test_description='git cvsimport timestamps'
      	git cvsimport -p"-x" -C module-1 module &&
      	(
      		cd module-1 &&
    -@@ t/t9604-cvsimport-timestamps.sh: test_expect_success PERL 'check timestamps with author-specific timezones' '
    +@@ t/t9604-cvsimport-timestamps.sh: test_expect_success PERL 'check timestamps are UTC (TZ=CST6CDT)' '
    + 	test_cmp expect-1 actual-1
    + '
    + 
    +-test_expect_success PERL 'check timestamps with author-specific timezones' '
    ++test_expect_success PERL,POSIX_TIMEZONE 'check timestamps with author-specific timezones' '
      
      	cat >cvs-authors <<-EOF &&
      	user1=User One <user1@domain.org>

 t/t9604-cvsimport-timestamps.sh | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
index 2ff4aa932df44..2d03259729b5f 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -3,11 +3,28 @@
 test_description='git cvsimport timestamps'
 . ./lib-cvs.sh
 
+test_lazy_prereq POSIX_TIMEZONE '
+	local tz=XST-1XDT,M3.5.0,M11.1.0
+	echo "1711846799 -> 2024-03-31 01:59:59 +0100" >expected &&
+	TZ="$tz" test-tool date show:iso-local 1711846799 >actual &&
+	test_cmp expected actual &&
+	echo "1711846800 -> 2024-03-31 03:00:00 +0200" >expected &&
+	TZ="$tz" test-tool date show:iso-local 1711846800 >actual &&
+	test_cmp expected actual &&
+	echo "1730591999 -> 2024-11-03 01:59:59 +0200" >expected &&
+	TZ="$tz" test-tool date show:iso-local 1730591999 >actual &&
+	test_cmp expected actual &&
+	echo "1730592000 -> 2024-11-03 01:00:00 +0100" >expected &&
+	TZ="$tz" test-tool date show:iso-local 1730592000 >actual &&
+	test_cmp expected actual
+'
+
 setup_cvs_test_repository t9604
 
-test_expect_success PERL 'check timestamps are UTC (TZ=CST6CDT)' '
+test_expect_success PERL,POSIX_TIMEZONE 'check timestamps are UTC' '
 
-	TZ=CST6CDT git cvsimport -p"-x" -C module-1 module &&
+	TZ=CST6CDT,M4.1.0,M10.5.0 \
+	git cvsimport -p"-x" -C module-1 module &&
 	git cvsimport -p"-x" -C module-1 module &&
 	(
 		cd module-1 &&
@@ -34,13 +51,13 @@ test_expect_success PERL 'check timestamps are UTC (TZ=CST6CDT)' '
 	test_cmp expect-1 actual-1
 '
 
-test_expect_success PERL 'check timestamps with author-specific timezones' '
+test_expect_success PERL,POSIX_TIMEZONE 'check timestamps with author-specific timezones' '
 
 	cat >cvs-authors <<-EOF &&
 	user1=User One <user1@domain.org>
-	user2=User Two <user2@domain.org> CST6CDT
-	user3=User Three <user3@domain.org> EST5EDT
-	user4=User Four <user4@domain.org> MST7MDT
+	user2=User Two <user2@domain.org> CST6CDT,M4.1.0,M10.5.0
+	user3=User Three <user3@domain.org> EST5EDT,M4.1.0,M10.5.0
+	user4=User Four <user4@domain.org> MST7MDT,M4.1.0,M10.5.0
 	EOF
 	git cvsimport -p"-x" -A cvs-authors -C module-2 module &&
 	(
-- 
2.44.0.rc0.258.g7320e9588666f

