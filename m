Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3BB672
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739634719; cv=none; b=tH+omfR75jAQsxVCi7be2LgQ1DZrKrPxTqGR8K02RYIdDNRlqO95L9toLmBCvX3SnUHbsCwfumWmV7VIFCiGI3LtRGyYtAWVHvNpcao62G0FnuBr1aLFjmKmF1lePLWop2SqSTTnCVsP2qXmxqxWz+mNjWRKChE5xLfXaQdpmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739634719; c=relaxed/simple;
	bh=NgcdHkkLwudzQ35twlRCjU8htQPOSFjEU6KAQMFcIos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KslCdagLj7LG61AAxgNxsBH5V8SQRjQDog6m8CUV7XO645uW6tpCILPgf5zW8XbBCo0n/nNRj7alN4SVutQThU3Jh4V11ukKPRiOOUnUgfMp3VaVJIiRI6WlFVBB3IEu/qYfIf+6qaXF7TGfc+XtPaUoy7a6CZBEAYsazXyx4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em01Xz3t; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em01Xz3t"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c4159f87so40875185ad.0
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 07:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739634717; x=1740239517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpSXIfdbGTe6dt5KGY2+b6OJCQo7ccZYAQn8TcMKp38=;
        b=Em01Xz3t0oft0fVyhfKDVXc5fODp+OcipoB8PwNNJAS6aVPybwcNhHfXwkmX1fMpxY
         vr2Rn7vmD3b9U8dfMFmNapnjCG4A/hCS+E9kZhG+9cF0GSFjntyTNeR5JDPofHyy1fWr
         YHAk6/ii5v0rxl7TyC164pOQwp4nvfePLbTsHX848ia70nfqBxvpixGhJjQ6mq75gFwJ
         DgQx3+HOQAFxd89RV8kxlNImxQ82KTMujb6RMnTCtlHl1cEWCWdekDlW7uSYzt3i8iqf
         9DtOhqprmwkWIyK5UyCMHfeD7o9zQbO9x38u3dai0ZseN/zsTg75HFy1E5fzNejndysc
         pLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739634717; x=1740239517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpSXIfdbGTe6dt5KGY2+b6OJCQo7ccZYAQn8TcMKp38=;
        b=ammXhXI1mnoEcDkLXKO6LMvfVLq2m/vBE11Ky1RHyOT9fD9X7EY++ZRNzHucuiiOAo
         BRSwwI0NOiCjb9DpivEmQwv4yV2/L1VmT8X34dPmXpins+VLGZbCFScH1yLbFFJ2/1FV
         MfUACj0CHcbVti5jDJEnOLM1CcqLLo6li6gBOJyfPaoUfJ/zOzWXNu+fAmEVGRIZFw+u
         f6ZcpIKI57aGti1urfRhHL64Ky5aTleeqZk1RuZT+f63iFU/t+GNie/o2AxdhG9LN8ON
         XvupoFPUVVPxN20tlQU24byt1NaJVecC64kf/+boJDirbvuCOogENAmlbuRxOgfbVwbV
         STqA==
X-Forwarded-Encrypted: i=1; AJvYcCUCuQjUK7uAameiW1l06B+6BVMERSZOCuZQnfeZyyxmE/zvQ6DcjVPjV09PrbCdkR023+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6sT327YZLizzeU3L969qhvpHM9SyTxXEaFHb9Dpr60ywRTeMh
	drmc4lWfi/9JaaiD08Zrzd38sthxpzxZOSmT/An3o67xq5IBCooD
X-Gm-Gg: ASbGncshvA6trInTmpLvPFwsT/RnaabuRcpte7mqJeMUSrgONYZKm/upqPZaNBzkYaG
	pwNQidiUx1pG8MqhYXE9i3aHwHxgSL8NbRzX+/EIYrz5axWLNjT2y37xJDddRm8SYodNtX4v6dL
	DyLx64qsGYKKdsCCf0oHHxw/OtTFKJx85fuIONZb23nasM4DwVdPY1ZS0FnI2B+ecGL+EacBwPB
	iZBaQ2YXoRc4JsOJTJd0s/SXkiRUKYeUEHflkuCxmOWka5/dEwm1U/IlDYuZymSfp9ivkbdU9eN
	VQKki099bB2CE5QgXI7nDFyhpOYG/1rUL/SmQQX0
X-Google-Smtp-Source: AGHT+IF4N/Zq3OnnhCiohsi6pRU2bQputA/3K+r+PFXLOAStK7cR+4Ro91kWK24ED3yRE7rlqasT3g==
X-Received: by 2002:a17:902:f68c:b0:220:cd9f:a186 with SMTP id d9443c01a7336-22103c62dc3mr57144455ad.0.1739634716838;
        Sat, 15 Feb 2025 07:51:56 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d559089asm45024285ad.241.2025.02.15.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:51:56 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: christian.couder@gmail.com,
	gitster@pobox.com
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 5/6] t5701: add setup test to remove side-effect dependency
Date: Sat, 15 Feb 2025 21:20:51 +0530
Message-ID: <20250215155130.1756934-6-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215155130.1756934-1-usmanakinyemi202@gmail.com>
References: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
 <20250215155130.1756934-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the "test capability advertisement" test creates some files
with expected content which are used by other tests below it.

To remove that side-effect from this test, let's split up part of
it into a "setup"-type test which creates the files with expected content
which gets reused by multiple tests. This will be useful in a following
commit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t5701-git-serve.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index de904c1655..4c24a188b9 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -7,22 +7,28 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-test_expect_success 'test capability advertisement' '
+test_expect_success 'setup to generate files with expected content' '
+	printf "agent=git/%s\n" "$(git version | cut -d" " -f3)" >agent_capability &&
+
 	test_oid_cache <<-EOF &&
 	wrong_algo sha1:sha256
 	wrong_algo sha256:sha1
 	EOF
+
 	cat >expect.base <<-EOF &&
 	version 2
-	agent=git/$(git version | cut -d" " -f3)
+	$(cat agent_capability)
 	ls-refs=unborn
 	fetch=shallow wait-for-done
 	server-option
 	object-format=$(test_oid algo)
 	EOF
-	cat >expect.trailer <<-EOF &&
+	cat >expect.trailer <<-EOF
 	0000
 	EOF
+'
+
+test_expect_success 'test capability advertisement' '
 	cat expect.base expect.trailer >expect &&
 
 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
-- 
2.48.1

