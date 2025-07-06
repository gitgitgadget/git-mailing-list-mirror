Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205B1C1F2F
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751836143; cv=none; b=LnaWZFElA8B3SgrxtqV818ZienjP8fuX8ndQG8ZsWtPRir4CvmWI+goIVxhrIKtdUn4SsndoLRUpa5VFJV28ueQkASpMh5gISo7EuyNmqj/ve/1GfBj9Df4uIpMhSsRfYZenlCMVCLLaCz/StXIMQCgWmTylsqxDLBTpJEuxuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751836143; c=relaxed/simple;
	bh=Zb5jTO4z5UneoRxOjzFrEJHHqAeU81PjCphoDz1eArE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DY9HsGR2rbq6Wonxx2iT3UzeKgu9yWNbec1ReQhc+ubBGOnUuj/JzxTCqzGjEkgs5F2lMSn4eZ2A4kT6sZwO4BRPqaYRFpVBmCSBRUmWfJX/cxfpNr/eon6tecWexN2sJDN0x7hZdU0mPNGeoHdaC5CMNodqXdTzlVC2bMcNVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II9sret3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II9sret3"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748feca4a61so1319777b3a.3
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751836142; x=1752440942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvw7Sv/lTGXCHHVNYmRK17aLG+acmaN9qwnSQM/ItTc=;
        b=II9sret3aMCBb//UAMzzfmPf973x0UQ1XVonS9VHkETRIhxk8N/MqYeSvWl6AqrBPL
         hDt081Gw7JQQM2Dh9OyejPdO9ygz4wisSqZPjhYC44suSUdYN6pS7QwYUXQr8DS+rDay
         sfs61cAlpZbTrS+EWWQWu3F89oL5fODCMrtwr0lkJsX0v/rRGkH5fsYWIgKq5gWhyDDn
         FoF4CCCcAoX66pGnBbpYY/Vnl9gVSHW1mv8VPWSvOHPEQ7G1j2t0rr2zkDYH/BqtPMgV
         vIDXaOTsQDVXl4Rt435L2msQ8KSOBcA50BVjDqtDy1sL9b5Cc3a/z/szql22Aw+gSu9n
         +dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751836142; x=1752440942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvw7Sv/lTGXCHHVNYmRK17aLG+acmaN9qwnSQM/ItTc=;
        b=nsoqrWlK/GHRkNazmOZ4K24H6oDBNYn0aluPYIPC3xg44ABubEzbpNEeBnhpRYzh6e
         E/lv5E9K416m7ICPdPNypiQK5GPMDagewm0S+U/C+efL0DDy4IwbFg5hem0WaB1yBVuI
         8pCkdWsqlDWdd91SsmSGJJXmtfr3CtyX3v7m2LuIlv15Icq+L9C0sHv/hPCG3DwtyEZ+
         bRVQpN8o47o6xz/1c0pME+4O3ozOEDJU+B9VJ56Vk2Gr3H5q6mfFxCmRw4bea4Kxn3IH
         7zlsKukLrv7LtMZ0xbng6cbrws8HfTf7+wm1W9em8EaedpdmrSzpUIsCXLix9dBUtU6x
         xr+A==
X-Gm-Message-State: AOJu0Yy/DtQdIHC0c8UqfSQ6yqWJb3DQyp+ueAfbB6dp5bYgyUxSvyfb
	5qgDOnEwnkOmVSnGpJHwwEvNntdTAnoYGvnm8MokqhJmRpH+7ciTAMcmCP3q72U0glE=
X-Gm-Gg: ASbGncsyUV1z4HnDboOv/FMrdJdbS2mTEeCu7lidEQ+EHMCDIfsDv6n/peWyxN//PCJ
	9CJUg7nVwukgYGxz/oWUJIGSHcQ+rKAAMZtOZKKxIsgHAkWT/8YCsJoJhD+lABbxIrT1WuK5hPc
	OEpEznVHNmsx3jSVVFT+SRpj3RaIc5+n8REPHOD7e0TqwzDiJdzWNEONAR7p5B09MqpD6I7THfY
	SeQYAFVpGtWZkKwYE9AoN/ka7kVRVXMkEfIaNB1ei3e3zxDsWJpW/7aYxGcwl2kvKQUBZeLIOkC
	jAmIFOfFHrAoAJDNvFToziIRy4sbfNpVDAK9RiZKs9lUaW0FadUjEzJjq16CNWXoIpUiDYpKE7P
	QJdwUULIIvPg=
X-Google-Smtp-Source: AGHT+IHT+MgJiPZCdaBrz/xqHfK0VQECebYhOa87Ss1wkj5cRLTDN1IZXS4Od16Sxpn24LP1AX0q+w==
X-Received: by 2002:a05:6300:210b:b0:220:245d:a30b with SMTP id adf61e73a8af0-2260bd66d9cmr13247674637.38.1751836141605;
        Sun, 06 Jul 2025 14:09:01 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm7220117b3a.136.2025.07.06.14.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:09:01 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH 6/7] t/t1517: move verify-commit -h test to t1517
Date: Mon,  7 Jul 2025 02:37:24 +0530
Message-ID: <20250706210725.79903-7-usmanakinyemi202@gmail.com>
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

