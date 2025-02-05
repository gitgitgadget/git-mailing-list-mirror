Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AC01FF1DB
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781602; cv=none; b=O10mB0866IlzLLwvtsdyzfCoL3RLVdqIGhDKb4wuic5Ron9gBZs9KwUtohmlYgaeqInK8bLYgGhSzu/y95XcvCPO29QKPzhQS2q5WdJiK4c0CKSFgMIsq8mx014avJW/MHB5RKxZAQzG7EJvbIDDgc64YefZEBTob2nwCYjdGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781602; c=relaxed/simple;
	bh=NgcdHkkLwudzQ35twlRCjU8htQPOSFjEU6KAQMFcIos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvU2q9TcBZLpoTpOsYfQgF02Z9hWNGdHArLSA1wF/NUpyV7lEAu9uBw3EPsHlzknKGHB6ps/VxMKUUERuZVlaly8SXjIGu3v9j+RACilSrm2qufyA6KlYr8ZoppDiF35s1XfzwFixaN1qMNqLHeJgHrVxyktta7D+tjtvUMfU2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjqFoR07; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjqFoR07"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f169e9595so2358995ad.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738781600; x=1739386400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpSXIfdbGTe6dt5KGY2+b6OJCQo7ccZYAQn8TcMKp38=;
        b=GjqFoR07LXRzQ9tHR0XQ0z/8Ko1sFTvC2Opo+8PtJHi+hbiHKVjq0QmH6lkYi/NJ9+
         7bw4lsy80uBykswHq1c185z61FRPhc/t3m/o7XFYEUvYAO/j4tynS5D+CW3VyIU3comJ
         fwuJQ+GjcDCegUnNHLNd/ZcOlaFMsTd0JFzMElXFBp+JHJpcofnJGbuf91MVBDr3JXOR
         y6q4LGBN1Rj/gCCapHKp6Xqd2Fe0rcoo2bDvZZrEyA3G4m2y/EZ1dgL0f8CbKR1364kN
         DZ4vDgQaF6tVuO7OttyrSGKeOS8JA7OxN1+WYfbFRp1Tf6pSTAinaaWgoYaoL3yDNeT+
         /nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738781600; x=1739386400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpSXIfdbGTe6dt5KGY2+b6OJCQo7ccZYAQn8TcMKp38=;
        b=pp4aVjsVJyL42rcaBLHDakM+lVveHC9OKOL3rEhQrUwt6696p5iMpc2O8POJE2FxpE
         LjT1Jvw2NvrRt+mHSJENOUvkb0KZON4UDA5zGKgZLtWrxYZUgbNF91WO2GyzwXxXOHI6
         XOTNq1uTFUULnCPaz2b4mTzayYgrmA2r2H2wwS/ZpjznBa87iN+VvKAcQuiHPphp4mFH
         baa+cBLd0f4xQl/1YeuWnGoZxWFP2vvMOSDuSJ3iHtkCVYDNFLyKLnP8dHEtiRbITCmD
         sGm0M8SJtGZSTdiZGwjxf6fOcjUeThmFY0P0TWHO/UgH2TmFLN0+GvvYxDb4qkCBN7JA
         AG0A==
X-Gm-Message-State: AOJu0Yz5jJfOfo1NwPMWzzrKhBktB4ARc1o1g81cYLub8htQFITpWWfx
	ia3KTPXKLyH/Isdf+uJhy5quzVjOsSCHo0srkF8PwfQ/vQzMVugAfJMEp8FyYaw=
X-Gm-Gg: ASbGncvZXujXQMShvyzRHhiAC3Oj1qm5OdyWo2z8sMcF7SMkv2Y1dsmtOfDEuSEzzQZ
	3wbk+7jGAM3sEq1zpmcr9Gvzl7j9DpkXg1A5JcC4gzWJqoIdJ2sb2keztvnRD0W9Fzs0SoR80c4
	KDTx6dnDLDruvxhE0XWQfn+r6nyLLOrEG27srQ14RozLD8iaT6t95bABY8WTzHD84J9U1dqQ/5+
	VnoPm4UsEeGjezjwlJ2BF2GX6YKiC5MZk1gqFaPwWrI3jCzFaxsDz46lYHLgxwWxzjHc9XI3Zbx
	lTvNUykAOJOIjy6hHHwjkjjPUFNCHBjP5oKjLXVz
X-Google-Smtp-Source: AGHT+IF4t2LzVwHA4WeTOy+RxRHhUCNUaz0fzq2o0S30k9tMgVc3mKpbyqqbz4MRrmnLQeJ/l809Mw==
X-Received: by 2002:a17:902:ecc8:b0:21f:1bd:efd9 with SMTP id d9443c01a7336-21f17e4714emr74957525ad.12.1738781593806;
        Wed, 05 Feb 2025 10:53:13 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f1e9f3ebbsm13754285ad.190.2025.02.05.10.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:53:13 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	=christian.couder@gmail.com
Cc: gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	usmanakinyemi202@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 5/6] t5701: add setup test to remove side-effect dependency
Date: Thu,  6 Feb 2025 00:22:35 +0530
Message-ID: <20250205185246.111447-6-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
 <20250205185246.111447-1-usmanakinyemi202@gmail.com>
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

