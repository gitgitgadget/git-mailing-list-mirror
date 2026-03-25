Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614A3D1CA8
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439542; cv=none; b=qP+dSUXN4DEmiBPgajxw9JHsDKsSoAYJ6UlKt4xfEQDbelKI5hNlfbp4xU2PN+3pumrKKPNKbZPKn0GBS/s3QaWIDwxoHHA9ifFdSWAux7TXBRodkubJdnKrM3fuwIy6fulFO/4nYlZhVCn5W1unZ1bY0uXCi4WO6uy5N3HwduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439542; c=relaxed/simple;
	bh=uZDawHLm4LtpqE4RJF3uDVypf6k0G8glKQ3a+74HmPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrS2BEhwC8FaBocyvBeFjXksT6cG5F2q7qjD2CxuHkJEGbal0qkgSjH9ACcuRMRaykRtM76x0oa8caN6yk38xJkmUjFsHZ9D524tf+hq7utclhZI2m8ITDUsvy/HTAPOJRhBQgAbvbOfXAzNeCoDLbBWeI7/4s59nk+FBlv5tnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrQ4ErTO; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrQ4ErTO"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-486fd27754bso19592275e9.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 04:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774439538; x=1775044338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+7/uMgLktPlCJ4XPhLKuFFts0I2TySpl3FEDqfG4qo=;
        b=TrQ4ErTOTWvVPD3KsZ+SeL7+JzXsOt9TKIAEz0kJQUPvOmBNxXQh3IbYEE6Bs+xGgE
         2jE3BQxlGFpwz1SVJJFHmFR6BasIvBAuJtMJBFKc1lCrknbQmd2Ren4N21TfXgkwKtxr
         TnF5q4Sj3+WeqYaozSRkrI1dCmm3i9FmYn3ouyW9YfdY5vEF9S1NdPZFAI68al7Be6a9
         RQOzMsO9EBHuk+6OEzQz0XtKLAMoxJUGPp9Dcf+siJVORSHMp6D2laShdCbanFPPRR+n
         tafQ0n1kp/oIlGC7BudwZqRoa8CpkJu+uiqzpTxg7kOJWsWGvaLjR2WHkbwbWgM6DqYL
         UU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774439538; x=1775044338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+7/uMgLktPlCJ4XPhLKuFFts0I2TySpl3FEDqfG4qo=;
        b=EP1bHVoZQm9tD/xer2PF/HI2szX8f0tnwIwiHUzWA3o8zvW4jdTRNmOxRybPRZqgbT
         9NiREDZkRZ4D8ZgMeY1CwLsnoAp5Q9QSMCgZye/fB65rMKI8UCNcfUrinRoECLhTrIi9
         6th3cyoNyVJ6AdHOkjkFF08iw1+H0eIBJEstlq7Hj+jdcyoXxv7kmQ6+r+2X5mCzceWN
         uZzRFxfLFqcBXr7/bVR9QtzvG8J7MLySfxU5d6b7JCc9+lISSXW1uzreDT6UUgYPv66H
         H+RIBo4jLmYYS3Yp48BgdUrbsGMKgXszTPXR3kYRm2jgwMmAj6D/1V93EpjeyEViD9+0
         ExzA==
X-Gm-Message-State: AOJu0Yw1sfSOSQg8CfMnyjo7+7g9n614t5ldK37Rke9KkF9f6KJoRhd6
	y4PuGCTCaQRLMhXwGAJv93yZ1MDoVZJuUBBhMzVBkal8niM/np0rK28kuEnGYlDKheQ=
X-Gm-Gg: ATEYQzySoM8eqeZTcmSm99eg1y7eCMGETgYJkwCxSTqPeBA0sSTkafkvnbFyrC8ov7z
	tVPWDeG60c2zHQtzytRmjFG2Rd4U3er+StEeUvc00MFsAYpNgqhjc2z5+Vofwxc8cRHRXqdwBNo
	STl8ZLqoIQg0f0cn15dA2KRx+mZWPX9pxRlLV8DkaViNEgKGiYPeJPBTzh/leO2KhbHg062x8SX
	qBL1fuCt1iqmMBtJbJrnhonTuldZ94jHubbJWBgYUSL/6fF4H6gM7yaCJfZpWEj95x01vxjEeDh
	MIOGGD/yLt3csJDqGY9Pa643DFbo15Hj1J//4scigfOTDc/d/Whbvy73QRf4PEZUCU/uJEnl17Z
	1QHAxn6SvLtof2jmKeT+4tes4oM/xRdlLJX6KHt4oIrNdKQBTREj1SPlsQDmBe3pSvUf4sQw6K3
	M50J1KcznGROQ/kI7J2BY67WPBQQgBMs0tYSNXDLEUHqo+yeNRLGemFY3jSPhfO2Lw2W7yDYu+0
	lILNjpTMuR6foOA
X-Received: by 2002:a05:600c:3b12:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-4871606dc4fmr50346905e9.26.1774439537914;
        Wed, 25 Mar 2026 04:52:17 -0700 (PDT)
Received: from macbook.. ([88.130.184.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116939b8sm192389865e9.3.2026.03.25.04.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 04:52:17 -0700 (PDT)
From: Mahi Kassa <mahlet.takassa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	lucasseikioshiro@gmail.com,
	jltobler@gmail.com,
	stolee@gmail.com,
	Mahi Kassa <mahlet.takassa@gmail.com>
Subject: [PATCH v4 2/2] repo: show subcommand-specific help text
Date: Wed, 25 Mar 2026 12:51:48 +0100
Message-Id: <20260325115148.101867-2-mahlet.takassa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325115148.101867-1-mahlet.takassa@gmail.com>
References: <20260323152937.257406-1-
  mahlet.takassa@gmail.com>
 <20260325115148.101867-1-mahlet.takassa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use subcommand-specific usage arrays for "git repo info" and
"git repo structure" so that each command shows only its own
synopsis in help output.

Add tests to cover the subcommand help behavior.

Signed-off-by: Mahi Kassa <mahlet.takassa@gmail.com>

---
v4:
- split the subcommand-specific help change into a second patch
- keep the behavior change and tests together
 builtin/repo.c            | 14 ++++++++++++--
 t/t1900-repo-info.sh      |  6 ++++++
 t/t1901-repo-structure.sh |  6 ++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index b5146499d0..71a5c1c29c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -33,6 +33,16 @@ static const char *const repo_usage[] = {
 	NULL,
 };
 
+static const char *const repo_info_usage[] = {
+	REPO_INFO_USAGE,
+	NULL,
+};
+
+static const char *const repo_structure_usage[] = {
+	REPO_STRUCTURE_USAGE,
+	NULL,
+};
+
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
 enum output_format {
@@ -220,7 +230,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
 
 	if (show_keys && (all_keys || argc))
 		die(_("--keys cannot be used with a <key> or --all"));
@@ -885,7 +895,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index a9eb07abe8..39bb77dda0 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -149,4 +149,10 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
 	test_cmp expect actual
 '
 
+test_expect_success 'git repo info -h shows only repo info usage' '
+	test_must_fail git repo info -h >actual &&
+	test_grep "git repo info" actual &&
+	test_grep ! "git repo structure" actual
+'
+
 test_done
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 98921ce1cb..10050abd70 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -224,4 +224,10 @@ test_expect_success 'progress meter option' '
 	)
 '
 
+test_expect_success 'git repo structure -h shows only repo structure usage' '
+	test_must_fail git repo structure -h >actual &&
+	test_grep "git repo structure" actual &&
+	test_grep ! "git repo info" actual
+'
+
 test_done
-- 
2.34.1

