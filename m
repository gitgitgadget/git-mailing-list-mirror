Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CBD2E36ED
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751836123; cv=none; b=MADq5dbmD1mQRzS+jUMx8kuGI08XhVoCCzuzUAxA1TpKG4wQHNVKwB1p1vV2QrkCxwki8k0TIp0vEv/QX8ItHyOlR3lwrkJQZkWPtC5tpGzaAU00PNQKCBZ4mUD7+BUsIcgkq/53nZYk5xBM0Sd3iD3oZXm9CaRTXjBJlnTG+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751836123; c=relaxed/simple;
	bh=dy2+NJGSchTWSrEfUVkYakgaTxZXNpF3vmFysG+xB9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKNVp/lgjUC7oTTuacIuMcNh4YLBLVGriAgM9wIHIWjbNmpsijDBaD8IocFVSvGTdUXpyE/I468uCG7oWs0JzJruIogY0261l94LPm4v8tSpxy3/AlojNOGnm1atNeNsVNGFQMwiAZSb+l4A25iTSFXsd4UogoW9q5jlvDl2Q9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3fO3w1U; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3fO3w1U"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so2682547b3a.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751836121; x=1752440921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhSw9iK/XJJzbmXSFpcqY1YVf6vcxjoslpXI9bdxXmA=;
        b=k3fO3w1URGnpnYBjBBTLSKOwSWXao0QxZxQQ+THswFGr32zAlW7p8xUWkG9LZcUXxJ
         1+n5ZGXr8Wm85zrB9D0D0OBiqgx/nKIctHCO8YIiMG2jEI+9ARiANkvGA5mkC8wO8vUp
         AQDemsjSNBuXdNABIAc9pBjJr9FB5fm6EoTO2aAOhSQKUX6wx/AYFlGn1a8I/DVbGa6Y
         NeTL9P5Cs+u635MkC2m6YDSgqYlvhtbG4IP5aGmBacy34Pzv5FJhfYkI0Oe4MOU4oLyS
         h6OEKRwrW+TZXbL4O7pYNAj+M1ndIueFSwkaG+bYc+ozChXxB5doLqm38EDME/56s06T
         YI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751836121; x=1752440921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhSw9iK/XJJzbmXSFpcqY1YVf6vcxjoslpXI9bdxXmA=;
        b=DxkQ7vcijfJdt8kQIB+ICY0vjiG+9CgFMZTFe7OsP/ZIC8yMhIDVsjGnhiGer8lw+x
         vRPAG/EILQPW9hSNvUoIiRoLdgUK3W7tEiotCu14p2pf8cKvdprppxc0EOQjiXslY/1Z
         xmvUSW+vhHLQZYVqgmmDAP7nPsW6/ojb0umMBVQbYltb+OZjuhPf/cc2k8fsMCT00sW7
         QXb+71dC9qpR28TUOlzqHC35oKMnuv6Zgawo9oja/KuhzUUYB7Rtjcs9dXKIBhK41VkR
         zjQc6svlHNhGjy+sAExmJznnx8HXqrrQWayPu+LKsm0b65J5yMDoK6uZqNkwHK9D8bLL
         VCKw==
X-Gm-Message-State: AOJu0YzJrTUXg2IwjnQI3PfvKJ3qSNGOib6iAOwn2QjWBflF1xF43qNP
	XAfdbeKqeQUWLgYvJqYBnj5RoPW8FEppWZRNpNvvKmv5ifugXp7ltYMNppfgcQNbAgY=
X-Gm-Gg: ASbGnctcj0MxBbdBGICICcURKCDdS+i7Py0hDzLuNpNawLF39OX3G4E4V20xnzTwjvL
	4VMtPXsgA1ktQitOCOoi5xM8k/11U3KuvYY7bSaQ31WZLFNVq0dZPKffsSa2RL1FeAIWxIb3BoF
	wKqbTswKLwqoU4E9DH2C8jbWFjBOjyxVY+HiG91LdBiiFKKZzP9pTWKfGldk3Lv45EECU3yBfmd
	q9hlFvwaX29grl/c1PpUp8d50ovis+kCZW0b2oAH01e85N9J5PkLTDAdOMLUKGaJMrDTYwU37pd
	nc9wh7bBl/uR9n8beOU/Mk1Hzod1O+3lAeb4YEvbActIwY5+VjIk5KjU13AE/Yp7Ai261UVZYnp
	6ouZIX+uOGdc=
X-Google-Smtp-Source: AGHT+IGVyG6PoJVa0Gfm14cK38g82QCZS2dvRWT0mNlcqtwV7sy5bTmfqdSGkpGxuMOtV0jzJ0mZ4A==
X-Received: by 2002:a05:6a20:d492:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-225af054ca1mr12648295637.11.1751836120735;
        Sun, 06 Jul 2025 14:08:40 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm7220117b3a.136.2025.07.06.14.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:08:40 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH 2/7] t/t1517: move for-each-ref -h test to t1517
Date: Mon,  7 Jul 2025 02:37:20 +0530
Message-ID: <20250706210725.79903-3-usmanakinyemi202@gmail.com>
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

The test 'for-each-ref does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t6300-for-each-ref.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 7 +++++++
 t/t6300-for-each-ref.sh | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 98a453db58..92ad159b58 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -121,4 +121,11 @@ test_expect_success 'checkout-index does not crash with -h' '
 	test_grep "[Uu]sage: git checkout-index " usage
 '
 
+test_expect_success 'for-each-ref does not crash with -h' '
+	test_expect_code 129 git for-each-ref -h >usage &&
+	test_grep "[Uu]sage: git for-each-ref " usage &&
+	test_expect_code 129 nongit git for-each-ref -h >usage &&
+	test_grep "[Uu]sage: git for-each-ref " usage
+'
+
 test_done
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ce9af79ab1..5db7038c41 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -292,13 +292,6 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
 
-test_expect_success 'for-each-ref does not crash with -h' '
-	test_expect_code 129 git for-each-ref -h >usage &&
-	test_grep "[Uu]sage: git for-each-ref " usage &&
-	test_expect_code 129 nongit git for-each-ref -h >usage &&
-	test_grep "[Uu]sage: git for-each-ref " usage
-'
-
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	git for-each-ref --format="%(authordate)" refs/heads &&
 	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
-- 
2.50.0

