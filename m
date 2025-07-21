Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72A27FB22
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098933; cv=none; b=h8rnXipVnOath4faqtjKX2Ko5iKEGyq+h4PlaC+tRfWiX15rgciSZhM3XgNG2G2u8cO2/x+8yPMeD6CrvtBWOWHg8SIrG57sp8+NYkJE6ApqHg2nIY4P6i6x+nr2bRNYFK3/KzwA4aY/9hVH1wE/xcRpcDTM8hMHkxIGGF4qdbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098933; c=relaxed/simple;
	bh=NLE+xO/YWenZwWIrk1x10nFPoQncFqkHatRJRYw0Qp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTs15Kgh7ajhU0fLLCGo6POhAfs8grizJgUCPXb0oqPveHJcDIJiZk+J2+in2ftQ17OAbVr1P1gEZHblMaAvrmGMeYaUn4Kv3qSFp/bkr61KXXuhuv4eoalcNvMFSVHf9UEeHaQiTLQW1jDoiDJDFfueDzCsUZgvJPBJ9B+Ee8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD8Er5Y0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD8Er5Y0"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3555428b3a.0
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 04:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753098931; x=1753703731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2FsMzTd/ZVm/PiWu3XSBnlIT3/bwlS8peLvAnCYpmc=;
        b=mD8Er5Y0I+Kk0/nJABwJwuw+YUASl0F5hTtE69rwcH1A/OJvPKzIYdgXXb+Vzk0q58
         PJNWqqqaczHkhEXq+2O1zT2y+xLQNi5hGLiQCoAMNBE0qFHNJHXS53kXZTUBJTTe519w
         GRjfJ/M4yn/iZ9+Bq6+kc19YibV4fOkpV5HCs4BwAH/qCaCMGNuDkxnHK+jMBycKhLMl
         bJ5hm6fSHsO/418XDNVti20vur064Il3TWzDH3+8iPMMr+OYSvY7aBZnTKO2znRAgMda
         ch4gz2YCXKjZmLwr5JzB3lCU/PQdlZrxUPC6rlUPEgyZIzsU7nQlGINYF4YvaF5X1HWv
         xOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098931; x=1753703731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2FsMzTd/ZVm/PiWu3XSBnlIT3/bwlS8peLvAnCYpmc=;
        b=clEuPPJC8piuOZD++rZI4w/rGGRIM6PbNm+ESbNFju7pbeiAFU94//kQ92yBZSHW5U
         poDyE2f3F805TioXEukdnYPTNv6TuLqsf8Ur3LD1rUP3Ys9aQzNAdHWwxXgGBgTqMQzf
         UU+IH5sP3LsnlZG1qeaeHdgjZg62qIO0waLWcTgdz3wGyNLdrQUuiKaIvWYsDxk13FRp
         TDKDFDbFkRCC8CQv8QnDzzge6MRwwZho9bCcNZFSsVm8zEWTq57KzvT5zctQR4oSc7Jw
         Q2Rw8sHJl2MCkdeiHPbqypWM/vUW7Ldp/+bX9QJ3p6082bKaCI9Ph+fqmhMXoLoQ3C6L
         qNYg==
X-Gm-Message-State: AOJu0Yx0/g8uzFLW6qHw0+G0eFTYRRx/3rvUsWfLtuqIicj0WycM6+04
	ehD5WDGG7npYqgm/cRGPNbvk8jp1IC6Iyb2RSPHDFFrrQRld5FBbkJks6hdDLLzbUh4=
X-Gm-Gg: ASbGnctTyCxbuOEaE7Fuu5FkQYQ4P0PJaTZegzXRlkc0B48X7L9Rdv3DlcuxH1uNPmU
	8FICOuB5B23iGsYOQ9TBibgCxtFNxhic5E7wsEmXxyJz9nCjqZpY8XDZWubZsvmxlY4tjKgFiIx
	UzJtWBTnrDg5Am/SGXT9xTMvhqR542Iyl/zN28E0e+Zy5CKfv63KFL4TEaLZlxdNF17xD436l8F
	wfrspbn65puE4CNAr+TtwhXoqQmkbujZ/62h9J4K8WieL6jv/1+YGqQMQicX9gg62M6zkVsWiy3
	NG2rdyElFggflfsCWVBpmMTT1C+frUHfXZf1aUOCqHosNlwtYNEU8JP7ZjJcbVG9bp6rfFwykec
	c64Vis4Bni3uymMUo83eMvKIOXDBS7LD0raXtHpKmzpJ05yQ=
X-Google-Smtp-Source: AGHT+IF8fJBPcAc5/cz5PUnHNDoI9y67AbdPdkhu197mDJ42msB8Wp3n/pCCExCBFWMFgRDE1okWpg==
X-Received: by 2002:a05:6a21:998b:b0:237:d013:8a78 with SMTP id adf61e73a8af0-2381484403bmr31960103637.37.1753098931532;
        Mon, 21 Jul 2025 04:55:31 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ffbce6esm5135940a12.72.2025.07.21.04.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:55:31 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	usmanakinyemi202@gmail.com
Subject: [PATCH v4 2/2] t5200: move `update-server-info -h` test from t1517
Date: Mon, 21 Jul 2025 17:25:19 +0530
Message-ID: <20250721115519.140361-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
References: <xmqqcya63cqx.fsf@gitster.g>
 <20250721115519.140361-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t1517 is now focused on testing subcommands outside a repository.
Move the in-repo `-h` test for `update-server-info` to t5200,
which covers this command.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh       | 5 -----
 t/t5200-update-server-info.sh | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 9fcebb7d94..a1c644dffa 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -107,11 +107,6 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 	test_grep "^error: remote-curl" actual
 '
 
-test_expect_success 'update-server-info does not crash with -h' '
-	test_expect_code 129 git update-server-info -h >usage &&
-	test_grep "[Uu]sage: git update-server-info " usage &&
-'
-
 for cmd in $(git --list-cmds=main)
 do
 	cmd=${cmd%.*} # strip .sh, .perl, etc.
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
index 8365907055..a1f129db4e 100755
--- a/t/t5200-update-server-info.sh
+++ b/t/t5200-update-server-info.sh
@@ -46,4 +46,9 @@ test_expect_success 'midx does not create duplicate pack entries' '
 	test_must_be_empty dups
 '
 
+test_expect_success 'update-server-info does not crash with -h' '
+	test_expect_code 129 git update-server-info -h >usage &&
+	test_grep "[Uu]sage: git update-server-info " usage &&
+'
+
 test_done
-- 
2.50.0

