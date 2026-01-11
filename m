Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8014F70
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142374; cv=none; b=e8NWl/nMeqpFYEptLvrBu/ktTu3fCuXR0p4GfwlIEMpJKLjOna3Ins9cH8YMDLOLrfPwc7Pm1g1jqy8TrLpj9swP/db93RazmALKtnRvl6Wcp2j7cKnXg1/26pZa7xpMQ/3PmQGM777QDJ9o5W7OOR77iIc+m1R2UM6QeDe2Fq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142374; c=relaxed/simple;
	bh=UKKV1LMtSmvG2ZHLG8wTwcNwlkpxQIIEoe9f80H18Z8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bVODjIpE8Xej1Aod7tmCpukwBQO7X1o3OvjsUcFKg9yPoEtEWz6UC2CzD4ymqvsusrZukx2HQbveWzCRLyWI0DZrcDYPySLdf2fJ3fBstR8+FXsVFMuLb2nauij/3ZrdQdaY3eIt6w0OCx1qoZa70DWxrKPOzDvtGxRHkxS3I8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1iNkIxH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1iNkIxH"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f3fcdb556so341350b3a.2
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768142372; x=1768747172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bmAitbsE2MFf+7zr9RlFK9Xcy7EOZAkyYaowurAdJKs=;
        b=N1iNkIxH9Rc1giNgVN4UJDGBB7Bm9zZyHIwdPYJCV14tE53NwiWfcxNd7kN9YcD3Ty
         /xfYpcE7uMeR955oDHDgbhE0vmC9PNQNtP80Uq4bWbCwu62mvTi7LzcSYZiM0QlhvSW4
         u2gOYW1D0ftYNM3oc3TRKfq6ZyTrWSQR4PBHEpRVV2Wah0h6738AaK7KEe54Ls4td/PJ
         +ILmFfPRdNHMn/0a0uOk3eTI2GuqO/ifse52jDEKb/Ign3au/kCsIQgbU6CCsqHS2eQ9
         CtpIVUjisz6hw/y32FLZuVtQx6s17oLx42Y7RH30c4Ly9v2x1CscHXSsAoB2ONN9Hm7g
         MCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142372; x=1768747172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmAitbsE2MFf+7zr9RlFK9Xcy7EOZAkyYaowurAdJKs=;
        b=HPIngrorKOF3/L37zL/mRt79MwA6gpz/3aE0qHPGBbMEtTRrZPb4rt9zMH1cUXENHA
         oYOjKuBWOIEwkEJrevGz3Rw9C45/nS0aTDFyrO4lMyGDum4r0DloZwSVErvzO6RilAxN
         r+0gB+dX1DJ6eu5Ao9jMI3SHAM45S+PFeh3LVUZvxLT9WghImZ32qGqy3F9rGvBKQGN1
         ss780dkOBIlPmHrwFeJUJYR8dsecdQS+vJj3XqrfAc4LTUHbQ2JdsCFBmGFE+9RbRN7S
         oa+dwSWMW1T+Y7iGVjxTmgywvpAgK4soF9E7s9k8a692Esf+v/kj7K4AkVeKzUnzkfaM
         Afbw==
X-Gm-Message-State: AOJu0YxzEcDYb/bEEyQsIT2CmboqBl+8hdYQSyljXRroppfazoCP0wD+
	s6BJmu61WTV3szaWqr9yWr7VYx2A7h9Jr7j0lgzbQgNrBaG3FZXH14BLhwTH0w==
X-Gm-Gg: AY/fxX406KHrjp57qTYEJbsqa5eHoCV2qzVMkGhiRCtQLy95DZ7hXxirHlo9rvdI8nl
	Ny+wolkv2xqaoK7TEp7sRVUrjNcNMiME+C9C9fsFc0f/yTWvrh8u7SBb+BUQiFbY4/mUQ+LIji/
	zmxpfSti+bFyfCAcyLDRXo71axh7DFBIlYwiJ7KC2uh46kcLltZVy2gMxWNhfVCq4ByprH7m9/i
	jy355P0ZU8eaKk5n8VJdlFphzgIqy4et1gZrERr5eB8mqHPKx71XSgi2LT+VB2bG5YGNm1hC29d
	hqaz3OygQazu65XpW2PVRHo3FW5qehBGC64ag76hcfOv9pOmyHptdrKIkoRnII/lQyjFwwNTw66
	tX4jMkUsKaIEL87dCB2YH8AGlczwV5AAO+Pf2j8ZU2SpLBOysIa8xvLydrGbLcn2xwZ6YSpP4nw
	GVdc34gDzSBA10d/u0IdWtuTla3uk58sUL
X-Google-Smtp-Source: AGHT+IE+28Nxjq2Dh2mD3VqbgWHulRcwBkRyM6HPHAv010J1ni5UaH2EM1vCrtgKVYQ11G2k5QZuDw==
X-Received: by 2002:a05:6a20:7f92:b0:34e:1009:4216 with SMTP id adf61e73a8af0-3898f94c941mr14049145637.24.1768142372418;
        Sun, 11 Jan 2026 06:39:32 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fa7820fsm14953671a91.2.2026.01.11.06.39.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 06:39:32 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH] t1420: use test helpers for lost-found checks
Date: Sun, 11 Jan 2026 14:38:33 +0000
Message-ID: <20260111143928.37604-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lost-found test used raw `test -f` and `ls | wc -l` checks.
Replace them with `test_path_is_file` and `test_line_count` to provide
clearer failure diagnostics and keep the test consistent with the
rest of the test suite.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 t/t1420-lost-found.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
index 2fb2f44f02..da1e48d35e 100755
--- a/t/t1420-lost-found.sh
+++ b/t/t1420-lost-found.sh
@@ -28,9 +28,10 @@ test_expect_success 'lost and found something' '
 	test_tick &&
 	git reset --hard HEAD^ &&
 	git fsck --lost-found &&
-	test 2 = $(ls .git/lost-found/*/* | wc -l) &&
-	test -f .git/lost-found/commit/$(cat lost-commit) &&
-	test -f .git/lost-found/other/$(cat lost-other)
+	ls .git/lost-found/*/* >actual &&
+	test_line_count = 2 actual &&
+	test_path_is_file .git/lost-found/commit/$(cat lost-commit) &&
+	test_path_is_file .git/lost-found/other/$(cat lost-other)
 '
 
 test_done
-- 
2.43.0

