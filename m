Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20FB264FBD
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838096; cv=none; b=g5AzD3pKsnKH5Y3QaInbAKZZt6D01/KAsQ7Sp8BBQ91TTUYTPNiK9QaPLsDTA8aDfL3jZ2DAwIeaY/4dqlBFzRuC4+1oMQ64b9s5XJko9jd0HhqvCGqSBOuD2N1Z/iM4fpWk8NWXZwtZXTr33WWJ9zYO910uqC5q7ACYAe0PTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838096; c=relaxed/simple;
	bh=Zb5jTO4z5UneoRxOjzFrEJHHqAeU81PjCphoDz1eArE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vdxrc0sJsF7TesElw8m8LifFhuhu1phNvHUhhyRdbxQQPwEV7gZmUxyH4CHey7bnpZe6uUiy3txXQKFkCE+R3pE3rKe6gCgDTZTC4drJUHHf47ePP1a+vIs8SEvo0yh1vtuaSLEbSkIpXc7/OsQt9CZ8X4JaEYZQs0XIvBmLals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO5o89l+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO5o89l+"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b170c99aa49so1628909a12.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838094; x=1752442894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvw7Sv/lTGXCHHVNYmRK17aLG+acmaN9qwnSQM/ItTc=;
        b=SO5o89l+GBpyjcY/LEPZI3oiCCdQ9KxmN08KoDBxfsTgZxnzXCQMU7Ejglsom1hnH6
         3xOm92R4vW054isaCO9rLMo3h8oN+7mwwBhH3fIjxM4lkqmn2M+wMzi3N362Notzgh4c
         a+akUgluye/61OZzQTEjTFa5tS9ZSEClN4F02i2/da8ua3jrzSQj0d6+FTXbZ19TgouB
         IXA3MsYqQ7zaz8E6Zh6z8taYqI9G23cnSLJUNkiN9xoVBwj/VHubjY0/ABRwlEXegqqy
         25sD8jTSlNE8JwqLHsXuIUmEpC/dRBK9jJdXxOtW5RF7RcQObVb3/m6PYNYaYn47wVEz
         LpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838094; x=1752442894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvw7Sv/lTGXCHHVNYmRK17aLG+acmaN9qwnSQM/ItTc=;
        b=JmICZLQw2d3KkgaMUv2Kx3gbUW2V13X9lMNV9UqaHMTGy9TeraV1PGGrW6wB/aNCN9
         vy4jjWDgh6SEAJTUXNfGyt7duLPxor5q98Qnm4YplEw/HHC6A/0n6EbSfApT98nCnlOu
         lisLge1mJC4/Nls5uE4ghnFmbvfE06jZbFuVF9/g0AsiIau/g2FJyBTtsLzIw+enH46C
         BZaH+dvGgQvYC+CrxhjOsNSKhVVLQ7/bwrB7AwznV7MySeLDokz5HYBK7EQmQthlJjVv
         3XcrcFlrYm68SYVyOD/2UY7+PfxJ9op0Kg6n/JWdxgNZ3rAuQU8x2Oejse6ZwvCQBzpY
         nhIw==
X-Gm-Message-State: AOJu0Yz7ByGLjhRooE/pyGZ2Hn/s9EouL36Xc1TOP8xjwREvRfbA5uV5
	v9goBAZoqxAwupHlIEkhLoB1O1Hc/CK+5oz937G1DBNnwJT/mMw+Y7of7tJHu10sxcA=
X-Gm-Gg: ASbGncu1JkfKyJFIT3GjHuiQXCaxvdO2HXkajTcfONT/YX9bnXK848zc1fULmI8MLG4
	5Hi7+YtpfUS1qNNP1SPt9gC0l9q51vH90UHfOjXXWFbbHLj0MC+7xCYlQpXKARBbNlDEq/8Xl8F
	SWGb1jBZnG4qswwGR0Y3FgYcC7+9fX4k0LOUcIgsLlhy/ZCUIClURNEPOeCfhetDSLdu/z8QfHb
	G9Q1sO/+gqqmY+6jE5oq1IHVGJg8U72+qvVhpSGlajqrFhTTuiwHQq6a3jx5e+uB/+HONj/fbK/
	+dFJIw0ar3Kojh4VExeABKKzbpyPe0IpfwslWZD/7Sv7NpovdDboXRGPlAaLr46tOLa39AltCjP
	mvxocRwh7tFk=
X-Google-Smtp-Source: AGHT+IHpg0oqla00Aca7RoqAnGWNVKqHNNyg2E6aNiBBvvfDnLRkWNL+iIhiSBzVPLvFJq9ot0GOrg==
X-Received: by 2002:a17:90b:558e:b0:311:eb85:96df with SMTP id 98e67ed59e1d1-31aba8c6836mr11511286a91.17.1751838093799;
        Sun, 06 Jul 2025 14:41:33 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee60c55csm7363968a12.43.2025.07.06.14.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:33 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH v2 6/7] t/t1517: move verify-commit -h test to t1517
Date: Mon,  7 Jul 2025 03:11:07 +0530
Message-ID: <20250706214108.714499-7-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'verify-commit does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t/t7510-signed-commit.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh  | 7 +++++++
 t/t7510-signed-commit.sh | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index a140b5cc38..42381ef7eb 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -149,4 +149,11 @@ test_expect_success 'send-pack does not crash with -h' '
 	test_grep "[Uu]sage: git send-pack " usage
 '
 
+test_expect_success 'verify-commit does not crash with -h' '
+	test_expect_code 129 git verify-commit -h >usage &&
+	test_grep "[Uu]sage: git verify-commit " usage &&
+	test_expect_code 129 nongit git verify-commit -h >usage &&
+	test_grep "[Uu]sage: git verify-commit " usage
+'
+
 test_done
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 39677e859a..0d2dd29fe6 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -8,13 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-test_expect_success GPG 'verify-commit does not crash with -h' '
-	test_expect_code 129 git verify-commit -h >usage &&
-	test_grep "[Uu]sage: git verify-commit " usage &&
-	test_expect_code 129 nongit git verify-commit -h >usage &&
-	test_grep "[Uu]sage: git verify-commit " usage
-'
-
 test_expect_success GPG 'create signed commits' '
 	test_oid_cache <<-\EOF &&
 	header sha1:gpgsig
-- 
2.50.0

