Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E42E36ED
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751836120; cv=none; b=I0ARKehCNok6OD9mIkFTBERkaZF39CpVqROKc/a8VWcHzK/nMvul8vqveJa84sa7ym5G1awOE9o7pkCc+OMqvDYRdcIVt8RUxvWcNmlWjuIDRIprOXlBZT250wPP3qXlFwYrl9INfTKJ/VgBqNkJDBh7YOa9epFdhoTnD9izxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751836120; c=relaxed/simple;
	bh=Wxpfx0SJUKa6J17R3++gOKIZyxEG3mAOZTG+HsmIog4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVmAb152ODBc1ylpZD2eF2XomCghTp41AT6Rw6xPK6YxmJkR15lYeGbu/SnQz/rLNU/M2NHTiGdr0EuQNbep2h6Sj0wms4CXf789Kp01hX9kAMVPYZgCeo3JtSSw6xNxN6uGwK2dMEob78hJbf+gIHjljwC3/qX0zlkNSy0AxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXCaOG0O; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXCaOG0O"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso1830233a12.2
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751836117; x=1752440917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJOI6HgiPGraAU45KBdwd4Xa3NlBPbAtWRCajr1UXSc=;
        b=YXCaOG0OriTGHw9oh0xNX4+5LoknsegJOegwZuIrlK1QfOTzm/rXBk8ZKz2Jskbz51
         jChUrz22SQmrjwxijKqB3MuaHRSurCiJotEPf7SWXTLqjL4RaM99Bmdrbj7fwKMBgo3y
         qtestajKxAaVZxh7DlAbhUpzsFx9JAcVTEDr+wfhCsaH/bjlihVoy8YG2bdy0mwCx4Lx
         K6+wxCJb+DBQjburBKHHO2h+TCxwenuEs0QihfWwUfYHGl6IfdXuVtnN0mciAgPrskNn
         B71C/vZx+garGpIbMxBCyFWPkWGkbAoD55LCVjBo+PXag9ojqBfRxIwPQVIz0LL7Omk1
         7PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751836117; x=1752440917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJOI6HgiPGraAU45KBdwd4Xa3NlBPbAtWRCajr1UXSc=;
        b=d5zPypalTvKUWRH7A/zozIQGT0gMZWGbBGg8vID1g19ltI5zBzLqr69T7aWUznSm38
         R80hXBWBcxxYg93bKFWcWQPj/nMcpdmv44vzrwscgWPCWQP8EbNycWVOvpJ0hmJ94JwA
         GDpAXicq2DHXcAPqqZuTTRRMmPkd6TBu72lPOKjEsOQ6Mtcz4vZ+o1qjMW0vjLOlFfSg
         cT23hGnX1C2pY7UsWueC/QNOWcN8ZCkT930tqSKPAmmULnp2I37BKGCSBufnajXoGPwE
         c1rOnhHvUXec316XPZo8OH8p5RzVEyQria1LnPrUT9AE3/xW4OLNVj0BQi6oz2GzG/Pp
         MJuA==
X-Gm-Message-State: AOJu0Yzu0GeT12E+EhT6ilecpNhBaPTo+tpYPlriElY8/wvCY3Wisajh
	RLPA0M9rB1wItSNKB8cUAerul0yaEnCC6M3NWEk2jvHhjfC0zH8oM21zp73s1SuH0N8=
X-Gm-Gg: ASbGnctQ79Y+zAEMThQ/Lcki+AT8xIiCeKl4zj/e2HaUN8okql413UsKocOLJXpgZk0
	Tmb4G5W+8AFveSK6q4+ahXfWENN43t95vNRnsvcTV2e/JVzHAmVyhREqsHywymh6+XRVf7dBYBk
	hNqBGaKvIdaFhYhkkh2xwScBcXKQBy/SyCgMmb5cx5QM7zu0Pv2xuwHSdC4RSG8RrztzPfg9ToA
	Dc/nlcDd5l17cdNyRpXAK7eFTr6/2m/yPh9rkbyMmQM7Wfy8/+F0nYhCWWE/zLwIc3vKPR/X950
	XS857owgTQLMaB9+MXnNBzBIlt2iN0Mdp8q8T5JkoJYbJGaumr1PIIpgK5P42dn8fG/2zuQyaL2
	JOog0LNmlM3A=
X-Google-Smtp-Source: AGHT+IGSHEh+Ke4MEcNLL16B4h/a2sNe4tVGeAw43KPMhtXEBSuSYPJW2oLl9GEK5iduFZtUQ4Qsjw==
X-Received: by 2002:a05:6a21:a81:b0:220:e7d:8e30 with SMTP id adf61e73a8af0-225b8104ab1mr17952792637.18.1751836116616;
        Sun, 06 Jul 2025 14:08:36 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm7220117b3a.136.2025.07.06.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:08:36 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH 1/7] t/t1517: move checkout-index -h test to t1517
Date: Mon,  7 Jul 2025 02:37:19 +0530
Message-ID: <20250706210725.79903-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706210725.79903-1-usmanakinyemi202@gmail.com>
References: <20250706210725.79903-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'checkout-index does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t2006-checkout-index-basic.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh         | 7 +++++++
 t/t2006-checkout-index-basic.sh | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 6824581317..98a453db58 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -114,4 +114,11 @@ test_expect_success 'update-server-info does not crash with -h' '
 	test_grep "[Uu]sage: git update-server-info " usage
 '
 
+test_expect_success 'checkout-index does not crash with -h' '
+	test_expect_code 129 git checkout-index -h >usage &&Add commentMore actions
+	test_grep "[Uu]sage: git checkout-index " usage &&
+	test_expect_code 129 nongit git checkout-index -h >usage &&
+	test_grep "[Uu]sage: git checkout-index " usage
+'
+
 test_done
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index fedd2cc097..bac231b167 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -21,13 +21,6 @@ test_expect_success 'checkout-index -h in broken repository' '
 	test_grep "[Uu]sage" broken/usage
 '
 
-test_expect_success 'checkout-index does not crash with -h' '
-	test_expect_code 129 git checkout-index -h >usage &&
-	test_grep "[Uu]sage: git checkout-index " usage &&
-	test_expect_code 129 nongit git checkout-index -h >usage &&
-	test_grep "[Uu]sage: git checkout-index " usage
-'
-
 test_expect_success 'checkout-index reports errors (cmdline)' '
 	test_must_fail git checkout-index -- does-not-exist 2>stderr &&
 	test_grep not.in.the.cache stderr
-- 
2.50.0

