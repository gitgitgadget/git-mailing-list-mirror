Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D945813B
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695553; cv=none; b=ZsLWCyPGCI0ZoFOxf0/V2PcSstm/tWdNtfdJfbcT3tp1OU21vVDmv2Jb+PWwcfw63MIpawdALpMpHuuYCXX28JD8SBVbCsUuH6UOONpiliQwXFPUnabmctPgCX+mn0Nf48V1DJEr/DJKlTo5CJwfHqGSxS++1jXIgcgtMzOTThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695553; c=relaxed/simple;
	bh=eqPRVhXxl/E6jMHUq2i1l+4r0Gq/CJ/Or14sUkX2W8c=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c/H8QsTMuJP4I/aD3eF0D0xFc1n0nAfAcs2eDKgi9t40/fP03owCSo30VPinaVGL1XLw4WpKatwtCXjJkcj/FuHTzESD495ji4Sy5Fx0m1rnPKJ4Qy1XRMuhL1RuuWC2zNTYSci4Thf+Hkl/2o6LK2KTyyIiouydxh6IyIBGIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDqPEE/X; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDqPEE/X"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-337b8da1f49so1001941f8f.0
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695550; x=1706300350; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLS+oY0aUqEObzsza5nrMyjONs2Eyfec2r8jgsx274Y=;
        b=GDqPEE/XClEMLX+nonmTW5ivkIKnhQdeDhO14wNL+6IMoqhIXQmvGXI0YgPArjDEgV
         Q6AvqOxO4BsuDIa4yJmIiwQnRz2sF63FdWwBSDJd/gvS0gK1BTjW8K5DWkQGCHELwMeA
         OWOT4cHdwtMCuUDi3cUUasJp3BkN9Yey5tk+33JC1vCSlviaC1G+cwVUMj3o178MooOi
         l/G4XxxJAUP9vIV/y6gzn5QCXaX30CSpeeq3+OH1zcKIb7breTTHM9QO0E1u+9yeV+8j
         Tne1fbh9TElFCAoaYrvl4m2YtHUqEpzGc4nF6Y2bVDWbb4/pKUhM1N8LuzzDJccHz0In
         /Kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695550; x=1706300350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLS+oY0aUqEObzsza5nrMyjONs2Eyfec2r8jgsx274Y=;
        b=MK7IDP/ktTznUL6cmWOaWMZeU0IRa3+XZj0+7o2P2vkiMrTGrttAP9z3OtHaBqXgG4
         n4XeQXycJwvDNDM0FtrzaL43037jNnuGSB7hCEz9jg7w4UQdqoJV2PaINEltGFU1swdv
         V2nqrl5wTegIkx0rjCJjie0+ALsl+hDoP+mvVhRUXZBES+1PKN2yOEhOLmoH/fN+cVVW
         W4g/bWYIIJB7o7ceYi0PSIq9TVf8nRp/j1iQHnJv8O2g3vg5W6pmc8jcW7E15PzR+pCY
         UwGJFA7g/nDAFI99M+/Bf/AFXr6GCr0K33sS5Z2yVkFGUyY+wmp0ji/mNKvD4LnBshPr
         lT9w==
X-Gm-Message-State: AOJu0YxotPhGYF1mmgPekkpjd4ToNVhggQDWVg3ZFm+Nzy5ZIAfrb89C
	5vO91dFXE+RYH7dsLE9sJlaDkSPTBUsgKg4FNIMvVA9iUBMQ+Dk9Am9UvuN0
X-Google-Smtp-Source: AGHT+IHoDLLtCWHDxissflGPMDxJ/AuaK6tfj8pRwXRkfJIZQojHjaNiz/Qihdgtt5hSSZJ6RrIEjg==
X-Received: by 2002:adf:f811:0:b0:337:d8a6:f674 with SMTP id s17-20020adff811000000b00337d8a6f674mr102131wrp.190.1705695549686;
        Fri, 19 Jan 2024 12:19:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14-20020adff6ce000000b00337d85a5b0fsm3369154wrp.114.2024.01.19.12.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:08 -0800 (PST)
Message-ID: <891a3d057d28bd4283a51fe6eb60f1fe99252bb7.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:57 +0000
Subject: [PATCH v2 09/12] t1503: move reffiles specific tests to t0600
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
Cc: Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move this test to t0600 with other reffiles specific tests since it
checks for loose refs and is specific to the reffiles backend.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh | 5 +++++
 t/t1503-rev-parse-verify.sh | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 44571033fac..a2ef34eab28 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -359,4 +359,9 @@ test_expect_success 'empty reflog' '
 	test_must_be_empty err
 '
 
+test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
+       ln -s does-not-exist .git/refs/heads/broken &&
+       test_must_fail git rev-parse --verify broken
+'
+
 test_done
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index bc136833c10..79df65ec7f6 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -144,11 +144,6 @@ test_expect_success 'main@{n} for various n' '
 	test_must_fail git rev-parse --verify main@{$Np1}
 '
 
-test_expect_success SYMLINKS,REFFILES 'ref resolution not confused by broken symlinks' '
-	ln -s does-not-exist .git/refs/heads/broken &&
-	test_must_fail git rev-parse --verify broken
-'
-
 test_expect_success 'options can appear after --verify' '
 	git rev-parse --verify HEAD >expect &&
 	git rev-parse --verify -q HEAD >actual &&
-- 
gitgitgadget

