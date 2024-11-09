Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9119F115
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181282; cv=none; b=sQcRFpI7Dd9fgRQEep3XdvCq3HbgF3q4kolrf7/NhtyyYonpq8li7u2wpi1YnER4V0Itbsh8PKDYn+k8M/9qbb3E7FDDhIJy4m0+T5S7N0R5KGg4Ov/lhhbLp/KdCET7/e0gXMckxHiYuTpRKypeFPUMPduVkSTrrTVNAWEMAb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181282; c=relaxed/simple;
	bh=PMdw0FTFVG2iUoZMyeWr7FZupnaMUztTqBtsfXjAVNQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TzKxi5IDQZ/ucU3Pn+OSZ2FGEpzgb/B1OaQu4w5VCKsQthaB0GlKxWNLgjRUGkg/ZOYijjSHIOPKBeqziZjCncvmsVBr5x2P2FZEeOBs4YzhfmdrbFMcubBUTYpSXE3x5iRTXx/W6dUEZfQ65oFDcSU8nNE4iH1hJ1m7lVcvpwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2YWlOJ4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2YWlOJ4"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d808ae924so1982268f8f.0
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 11:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731181277; x=1731786077; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dK2I2TXW5iAu4adBn9RAI0BX8gzXE/7TFrMGsUREmg=;
        b=J2YWlOJ4Pvrk3jkTGT99L4iC1v1ta+vinQ9NJ7aAnMfTciFBm2qTjCfrWXoVwQzjEV
         p8efA+2NKhSPdykwYKfAP4WRfB36a9cb1F6+Oo28LboLoi/2jS9x3KOtE8dT6v3/Bmj3
         k3Im3461VVltneAcNRVGFzQluKQykuwUSumSbbAIuavLOR9rVBU2W+jdWIB27mRep+jb
         OukPk8GxNNbs3V1HxQ1vGRctqnXVz0HOvQUiSKx9MZXkK0i56ymWveqCIlf2DNJWO/xh
         MRfaxkSNZdS88gyLbRbRqpnxmE63KNO9hbV8tEP0zohGtlVIiutqPufI9wVpBss3gkrM
         04VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731181277; x=1731786077;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dK2I2TXW5iAu4adBn9RAI0BX8gzXE/7TFrMGsUREmg=;
        b=eOdoCYUwT37e0a83XWjpGK3+WuiF/1PUMyBprVq0xg1JXACJymJl6D/Ctt5yec79sU
         7+QbhVVLZa4VqK9rrSLUjOPmMFCchjeWX+YhdLdtEKQpoLseJxdTn/YPe3uX93Zgu8MR
         iyGRuPghMVfKsYx1m5s67vFapFy8smlWAo+bKWy+vpvbIHr1V1V49Fw1YpH9UclVJ3Xl
         kkcy0se9GKjd/NA3LU7I+/S2p9yO+lGg6T3OwQYYktT9dCg0vrUt4txaBA7Q+3BXRa6/
         VBomMcwKz4jDZxhvxn41HSLeY9V4jjVDR7MFHzcYZO0czBq/gHGwSm0f4nUsLjZxVViM
         OIsQ==
X-Gm-Message-State: AOJu0YwMOIX+tDvI1C6gBIFPyChxrbWBD8RSn30E1+IvfShHptGHPRMM
	ByLUSBztlfOeaoGCMK0GVOePZlnv0bKuqERcfjOZLxVWt2bArlUVWMmfFw==
X-Google-Smtp-Source: AGHT+IFUmd2tM7afTxwc+fvetV5d/L8JF/P3ZE2koDaAJIGu9QDdc6jcKMDgbEZ5T/PVFC4IS8r2HQ==
X-Received: by 2002:a05:6000:1f8f:b0:37d:52b5:451e with SMTP id ffacd0b85a97d-381f186fc20mr6347171f8f.33.1731181276760;
        Sat, 09 Nov 2024 11:41:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9f8f0asm8723135f8f.79.2024.11.09.11.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 11:41:16 -0800 (PST)
Message-Id: <cf2ed61b324b019f61afb1b66163b1284e675db2.1731181273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
	<pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Nov 2024 19:41:08 +0000
Subject: [PATCH v2 2/6] test-lib-functions: add test_cmp_sorted
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This test helper will be helpful to reduce repeated logic in
t6601-path-walk.sh, but may be helpful elsewhere, too.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/test-lib-functions.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fde9bf54fc3..16b70aebd60 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1267,6 +1267,16 @@ test_cmp () {
 	eval "$GIT_TEST_CMP" '"$@"'
 }
 
+# test_cmp_sorted runs test_cmp on sorted versions of the two
+# input files. Uses "$1.sorted" and "$2.sorted" as temp files.
+
+test_cmp_sorted () {
+	sort <"$1" >"$1.sorted" &&
+	sort <"$2" >"$2.sorted" &&
+	test_cmp "$1.sorted" "$2.sorted" &&
+	rm "$1.sorted" "$2.sorted"
+}
+
 # Check that the given config key has the expected value.
 #
 #    test_cmp_config [-C <dir>] <expected-value>
-- 
gitgitgadget

