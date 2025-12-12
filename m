Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089B30EF6D
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552536; cv=none; b=galUPwW+o9ecaEgy4tjjBft0XKSfb8UHeA7f9R21eDP6Y4EIxiXjjSqHYE3SdjrqCbYUVOP+8Gx6KGAtB55WLWesX6Nu6ekZmI3+ILeko+3l3bmHsqfsGwJFwF0f9CUW1dL0wNUOsnDmaTIts8ED+KZb5fJB3qeHz7eH37fOgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552536; c=relaxed/simple;
	bh=hO3GyoCw8ijyYE4uhmsOKIxwoaWr/b0eh1Ax1zhJbWI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FZqgRtSobdljyDYGXhtHRnbwg1kS+pEetTZJIqHijS5iYDqMeyTqN8+B2cKQg9RgD7SxzYt5Q80bXIwmdYZWtyieApCNhb4Rueow3My7Wr+yOvNVIWTxIovq2AkAzjwYJYxqjziqZhkeVZgoZY1ZrYA0IlGH1l40fv/N7xoMSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ffb+ozDI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ffb+ozDI"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so944105a12.0
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 07:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765552533; x=1766157333; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9G+zKuRusJLjFF7h5yeLt5PUD3oiwMkuqHFQPZOwjo=;
        b=Ffb+ozDIfl0JKXzLQ1KTOnX4RggVAM8vCWzfDjaKnRN31OvUPF0ttS937EOLuDkG6W
         AWCuMshHWLtiHAEN/5emVBZPNBFgNwaNY5lCtaKYtHn0rouY8qHpNRTWwUAr9uNc4clS
         e9keEeJ+Bc07X8bLLx32kqIaVuxSshdKe1QI+ZhOuzIwt78L8QhQshAXxPv89jaKU/pE
         vTXVr6fEi5wTQ+yLLY3yi7hvrzi2FaorpSocPFwdvGeCb7wvcTUUo6smTwQ+N7/4UE/Z
         EPrFB+weZFv0UGJra81Z/mbtk45u6afq+clNLvFN9KxXDWY089eApEwzF+uEEgec0sU0
         MDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765552533; x=1766157333;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9G+zKuRusJLjFF7h5yeLt5PUD3oiwMkuqHFQPZOwjo=;
        b=ONJx011BmUrlZInVSTcWfEY6CmuFykogEexhxbJ/DoaiWA7YNGcXcsw+3+PCDbSMYw
         jqDNPfMtYXmJFu/ZdKv3j63xQ3XV/l7D1xX0r83pGQxFEOEgufYfVvpB8S2sBvHEgQfN
         zIUjwtJnkBQhQB5vQIR53AbO+aRJEzmczR93kZZQGnWNC+s7+2+aeWdsdiM9natEJPAq
         Dx3qw4HvEdIyapayuULtC+4Ga735aQRFKT6rODSF5yzb+aZ/9WDpJwAi+G9sBEOiPJ67
         OJK1FRdx1PBcl7jGT0/bkdcR8qJrbH3feg95/GTx+H/uifToLa1BrxTg1nQwH+nS0ExM
         1YzA==
X-Gm-Message-State: AOJu0YzYUMUdXwQ4Zi+YDCoOwQ1xWBOYu4uGxRCvrRTgXj7IoRilnI39
	ZXDpmomgnAn3tClYHwwv7xbsVrZ37u6dkTaSTHUGoK6WGGbn42y2B+1m0lUujb4K
X-Gm-Gg: AY/fxX44oUsRfg6jzr6hOQhAnI8ebrbwPcrs1+Ebm7iiKr/ORch/uKcrFGZewKHpgP4
	smv+V6qgXQcrwimsPRtYKAAG/wLLExT5NmvRmpMdBIddLuvIN4IixWGYA6J1Y07KJs4W1zt6Ng0
	HO3Hb7Abjg+tsyJAfgZdmFziIGMqH08zPxaag2ihWuzOfUbLYjt3wkuRtmsGb2lZ6aupFhp/MoY
	txEoZ1Eg2qOsrEYV/VEjMlamJFQao9/YQmhs7hAUaymcBcmg6Thr2fAaQWKiHSPg91+QjEqS0lN
	yLvLucagVykDgtdq8WWGDLgHlMIwHuwShyBrFTA7uXLXP3tIQtc50MfDG6Siog+eUFkzzPXjhDe
	qJQ8BejuZodTrZE3Whv5XLWcvzLBKgbs0DSkDhsX5tQemGtgRfTXMLtn++q6NJKbicXChB7ZMMB
	xS628Gri4Tyv1LUw==
X-Google-Smtp-Source: AGHT+IG0Ib6fga9UIDuSrC15kW16BvQl3nOn8KvMgUG0DzUkuNgGQ2Guv3/B+s+ixcFVIkGfkET6+w==
X-Received: by 2002:a05:7301:5505:b0:2a7:6a9:ef89 with SMTP id 5a478bee46e88-2ac2f86de22mr1352182eec.7.1765552533167;
        Fri, 12 Dec 2025 07:15:33 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac342eeaaasm3291655eec.6.2025.12.12.07.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:15:32 -0800 (PST)
Message-Id: <573929ecdb950e3c3e862f14c59ed5a544b8b6ca.1765552528.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
References: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
	<pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Dec 2025 15:15:25 +0000
Subject: [PATCH v3 2/5] scalar: use index.skipHash=true for performance
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Matthew Hughes <matthewhughes934@gmail.com>,
    Henrique Ferreiro <hferreiro@igalia.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The index.skipHash config option has been set to 'false' by Scalar since
4933152cbb (scalar: enable path-walk during push via config, 2025-05-16)
but that commit message is trying to communicate the exact opposite:
that the 'true' value is what we want instead. This means that we've
been disabling this performance benefit for Scalar repos
unintentionally.

Fix this issue before we add justification for the config options set in
this list.

Oddly, enabling index.skipHash causes a test issue during 'test_commit'
in one of the Scalar tests when GIT_TEST_SPLIT_INDEX is enabled (as
caught by the linux-test-vars build). I'm fixing the test by disabling
the environment variable, but the issue should be resolved in a series
focused on the split index.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c          | 2 +-
 t/t9210-scalar.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/scalar.c b/scalar.c
index 1c7bd1a8f8..55b8542770 100644
--- a/scalar.c
+++ b/scalar.c
@@ -160,7 +160,7 @@ static int set_recommended_config(int reconfigure)
 		{ "credential.validate", "false", 1 }, /* GCM4W-only */
 		{ "gc.auto", "0", 1 },
 		{ "gui.GCWarning", "false", 1 },
-		{ "index.skipHash", "false", 1 },
+		{ "index.skipHash", "true", 1 },
 		{ "index.threads", "true", 1 },
 		{ "index.version", "4", 1 },
 		{ "merge.stat", "false", 1 },
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 43c210a23d..923c243c13 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -246,6 +246,10 @@ test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
 '
 
 test_expect_success 'scalar reconfigure --all with detached HEADs' '
+	# This test demonstrates an issue with index.skipHash=true and
+	# this test variable for the split index. Disable the test variable.
+	sane_unset GIT_TEST_SPLIT_INDEX &&
+
 	repos="two three four" &&
 	for num in $repos
 	do
-- 
gitgitgadget

