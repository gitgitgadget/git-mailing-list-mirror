Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF6542809
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183629; cv=none; b=ijxI7hMa4f5kUsvTgLXPhmMfOjk/3iG8JhY2v0WwY4JIfs+rCPWnTMmorg6eAk1P7XtPecMqYFvGz3e6y5QM8fdK7pheiU06bYYVIPRWG2dljZAMAaIV2tipes1UDWNE2dqtlvgElBtMfhr3XJxjsNjBF4HA6kzua2TIgbU+7yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183629; c=relaxed/simple;
	bh=KitIPCb9uaaZTpUibH4+gkRfNzZMGR44Z89VQhhbiXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T91u9Etv3gHjnOqiQeT+Khpimv5SqR7clNaZuqurmO1U6MgDWeAe7kvmVTTEjp/wmQB9zDCPZ9mc4Rtc4T0k4jvi5LvqOyWi6i7jMUcc9eH2W5XPk5gFKYJ19AUFHRoPcH+Qelh7NVYvjuSPFgo3wP0/i7amrT9joVbjPruMkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lES40yEn; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lES40yEn"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae721872so616195eaf.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790183627; x=1790788427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0cNk///Z+m9sJ4qX9imVkVbai0KAAiCPE0Ye3QSQuco=;
        b=lES40yEnNfa9xZfUqZzU8XE4zBrYP81NRyw1a2iP6ubTQEGSzipdXVw9ZQus2m6tu5
         Ef2e44dEJhLaj/p/Z87N28/V/H355qfvBKnB1kZeMERQJBrF0f1dGhc1m/vN8ky/bNJe
         IkDdYIqN3IgSGOPPO69QHHLsYkilWxSVSu8k9Jf1QYcl+LKFjmNUBkjsRYiSlKfVIlHP
         wtjQ1ms9WzcQ/1x0nWTjzLZWOmOyBRUKr8cehSWBW1xLbNj2ck8aWw5svOtyqvaz4xiN
         ANTJjyjWKKHkbh2LxrEVsY/ayBq5HBwGEHb9Cop+ZSquy1umD1PmL2fpqYO05FL5MM1L
         xU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183627; x=1790788427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0cNk///Z+m9sJ4qX9imVkVbai0KAAiCPE0Ye3QSQuco=;
        b=GEaHlcHFGxka72yPQ9jG17ckYYskjhzM26cdWsVf7GpJiW/ljPy4COaB5ir6t+K0bI
         nrN5PDjVV6XZ6yc6mAyCO9/jxKfQLd68s+JF/MX+P0076hTrUIPF0dIYqtE05ae7T/oe
         vFPtn6CSxKNVeeVqkegSSSJERcu6Vd6tR/4sA55sAaI2/Y1YXZKjSBMoDN74vNhOYke6
         szDe9aJfe4b+cKjXDiln3BJmEVXCEoLYsVRZcHP8j+i2D+vW55ue313LJRkNMSECXKBi
         H87JedZ0ftE5hI/97ngMMHn8L9Hv0X5sTUMAHkn8hpaIl6tyen0go16FJtnhmo4P5SGl
         eOGg==
X-Gm-Message-State: AFuF++ks6xnj071XcMFLiI85+MKeMLk0NTn6DgNIPmWldFLTbEL1uw2J
	iMxjXEHvavQ0rSBeSU4GgAv86cn+IiC3MGJyJFxn6PnQXU1s17y5x+BGZL1mnkS9
X-Gm-Gg: AYBFou0Dnmv1kSw6sTO0m277+syQGK7T1GfNDmO0Hu9/yKPfN46WPtb46dxw63rjZRI
	QkcmdKAI85Y/20BLjxD6u8jYR6GHgd2RtRKK3TclC2Y470/11raehhUAmeG6EISgyZfmMC7AnH5
	ELt+j68FPqfa5b9GLmnoOo6uT0Uk4+cJalBo6nIpd3MHPT1V8kXm4a5F+BcPR24kU0VGlQpqlII
	BaHKbvyhbRypxpapDp0K3NdaXzCJmP3p3R6KmDuJSJeU4xGZf/QNsGr/nBbMOSCAgPQsD0U1Pcy
	i714d+qsyoQBUl2oe4k1VTbDam+9Q3Z345HL6qVAW0fmcoDHaiU45RSMkTIahNldiwH3+NwYM1X
	HVt3SC1AtCgTGVFgrFMEkecUexadaxlaHWsry74XEV/Qxn+GLleKsWQ2ZnpH6d1HSWt+6Svn5Ll
	JQqkyx8vNuijT7iN8YiijLeVxay9CpJpfdwUL7K01KoIw7dxCdzNARSxMzp/M6OEz6RvU558qjO
	sYg0J5EyTzzIH48Fg3ZPx9kwlr4prrHa8Li1l0EvfupJdhfjYh/766MBKMQymvCETi3YOxEki5D
	YvhaqMtr5tKzJ9CPzwaNdAr0/AVvs4Dx1hlIhgk7qUv5Msa69nxVF5y+KKd4s1/USD9ag8eoqfX
	WBEyObE9uCMv/KwDrf7vR0LLdnsGhiRS3hlUey7zKKiG22p33ndSWYIqhYWZdSZj1+uq9Uw==
X-Received: by 2002:a05:6820:220c:b0:6c9:e0d0:2064 with SMTP id 006d021491bc7-6d2d0837af1mr3161193eaf.27.1790183626928;
        Wed, 23 Sep 2026 10:13:46 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2ce763f94sm2972392eaf.8.2026.09.23.10.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:13:46 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Sep 2026 13:13:29 -0400
Subject: [PATCH 2/2] ci: match Linux jobs to available CPUs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-ci-large-test-resources-v1-2-c28416d59475@gmail.com>
References: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
In-Reply-To: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev

GitHub Actions runs ten Make test suites concurrently even on private
Linux runners with two CPUs. Pull request runs enable the long tests.
These runs hit ENOSPC while multiple multi-gigabyte clone and repack
fixtures were active.

Use nproc to choose Make and prove parallelism, as the GitLab CI path
already does. This reduces overlapping fixtures on small Linux runners
while keeping the long tests enabled.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 ci/lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index c6ccbf8c17..0855026dad 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -228,6 +228,10 @@ then
 
 	GIT_TEST_OPTS="--github-workflow-markup"
 	JOBS=10
+	if test linux = "$CI_OS_NAME"
+	then
+		JOBS=$(nproc)
+	fi
 
 	distro=$(echo "$CI_JOB_IMAGE" | tr : -)
 elif test true = "$GITLAB_CI"

-- 
2.56.0.rc0.807.ga0c0929ce1.frankengit

