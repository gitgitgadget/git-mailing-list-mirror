Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C2558100
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695552; cv=none; b=WBOaYMIsYuSghSBBu816mFHRggllk0sy3z11juCWtpavCvRM4ejbEVjAy2omaMDnMNkxQaVIJ/bV0/ICBVCs2ghGajty99yW/EN1dR4mudGD71ukSIBVCGehWX4/CoUXTgpk8XvP68BBsqbdV5RJaUi2R81iN0tJy6mDdxNBXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695552; c=relaxed/simple;
	bh=QQtvQWkGfG3/B29JvIlcWEHKml9Gd187QvYOiA4Byfs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QPynYO2AWUY2ssQNvjLeSn0479q7x/YxyfUFHZ6kOgSlMjIICUqxM4WWJRKApG79Ql9R1YCMIOMowAYSXa4RDsjj2E/kEGK4gI4QjyDpni8H02tx1VYafIWgEuee4/dVFK3WB5ddvMbYFq+k/KJZR7Fn88hDZXmcSXctq1dD0A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArSeLgyY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArSeLgyY"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-337d99f9cdfso860095f8f.0
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695548; x=1706300348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBxrCrz0iGHVRBxhanLHfqFpONMEFYr7FfOvbcRa0u4=;
        b=ArSeLgyYkOFbpziVL7rXjDeBU2gzhBEj9lvivHDQtMr/tlssqPpW1B9F2gRTpYYjUF
         fwbA42FjeDixDSbNcGkUfn4AjiDKHtYUjZvx49PgPeaikBJoA63wG1EVvmMJIbHBVqgH
         HXN7M5zykpmeCFpgeOAY15V38xJ95zmlyYGg7v2q6ahaKEex2gs9buNapJf8uRBHgS4C
         6c/GirWxgTpBQ0E00vA4/bYZ3ykVTCtsbUbskthexgEwJgHUa0+dc8xaKjkrtf/oRScS
         UwCMIGa9anuhyZnT9mlhk8GJ848zXTaOGuTMPrHgeWRUwy7+sg8Aq6M5lzk90wcZoLNj
         gP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695548; x=1706300348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBxrCrz0iGHVRBxhanLHfqFpONMEFYr7FfOvbcRa0u4=;
        b=f7Xj944IbnL23xTo24f3RLc6ThMlg2s77F4bT78oNseT7TFiX5g4uXGxmwCZqfur7v
         DsQskN/+jUbVEmZb4S1T+ZyJqw0qymsCbLvXVAHSU74PcvCfa3xSvJko9I5s+rdrAlwm
         3MV1PwXedyPqEVGh0zUd7jM/saxORNjcI2tc1a0siTqEv0yx1HOB7Mmd8dIQ7ooR+xC/
         ipq7f2PYd2tHqDlJaCCiXtsUYWrPjltCVO04mbFLFQrjNTeI6SxVFjLHFqypPUo3ddge
         a/Tr2VNixal0Vxh1ui5i85peAR8cc+/jAMp9q3VfPYOkmxWPap2mbsmFKFpj3hDmIZJo
         nEbg==
X-Gm-Message-State: AOJu0YxEG5k4oa6vMSVWRzAFqBjhzGZGZr4gfbJA+R6eFnM0CC29++Zm
	XbVdW+LhzenlOP5nx9EHcx2FLt15PhwJj7IPSJZOWMWQ8BwgHvRMHXmjh+d1
X-Google-Smtp-Source: AGHT+IGopO8YzhF+BXv1CXv1GTByzTwizExDUOBH6L8DzXdVKekAxEi/DP9Fq/l1nJKuaIUpw9CX8A==
X-Received: by 2002:a5d:6383:0:b0:337:c702:98ef with SMTP id p3-20020a5d6383000000b00337c70298efmr116628wru.13.1705695548516;
        Fri, 19 Jan 2024 12:19:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d4448000000b0033925e94c89sm249393wrr.12.2024.01.19.12.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:07 -0800 (PST)
Message-ID: <8327b12a313b00d1ca392f446e13f9c1018f1d84.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:56 +0000
Subject: [PATCH v2 08/12] t1415: move reffiles specific tests to t0601
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

Move this test into t0601 with other reffiles pack-refs specific tests
since it checks for individua loose refs and thus is specific to the
reffiles backend.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0601-reffiles-pack-refs.sh | 20 ++++++++++++++++++++
 t/t1415-worktree-refs.sh      | 11 -----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index 2e457c4f2df..c2c19befacc 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -308,4 +308,24 @@ test_expect_success SYMLINKS 'pack symlinked packed-refs' '
 	test "$(test_readlink .git/packed-refs)" = "my-deviant-packed-refs"
 '
 
+# The 'packed-refs' file is stored directly in .git/. This means it is global
+# to the repository, and can only contain refs that are shared across all
+# worktrees.
+test_expect_success 'refs/worktree must not be packed' '
+	test_commit initial &&
+	test_commit wt1 &&
+	test_commit wt2 &&
+	git worktree add wt1 wt1 &&
+	git worktree add wt2 wt2 &&
+	git checkout initial &&
+	git update-ref refs/worktree/foo HEAD &&
+	git -C wt1 update-ref refs/worktree/foo HEAD &&
+	git -C wt2 update-ref refs/worktree/foo HEAD &&
+	git pack-refs --all &&
+	test_path_is_missing .git/refs/tags/wt1 &&
+	test_path_is_file .git/refs/worktree/foo &&
+	test_path_is_file .git/worktrees/wt1/refs/worktree/foo &&
+	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
+'
+
 test_done
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index 3b531842dd4..eb4eec8becb 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -17,17 +17,6 @@ test_expect_success 'setup' '
 	git -C wt2 update-ref refs/worktree/foo HEAD
 '
 
-# The 'packed-refs' file is stored directly in .git/. This means it is global
-# to the repository, and can only contain refs that are shared across all
-# worktrees.
-test_expect_success REFFILES 'refs/worktree must not be packed' '
-	git pack-refs --all &&
-	test_path_is_missing .git/refs/tags/wt1 &&
-	test_path_is_file .git/refs/worktree/foo &&
-	test_path_is_file .git/worktrees/wt1/refs/worktree/foo &&
-	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
-'
-
 test_expect_success 'refs/worktree are per-worktree' '
 	test_cmp_rev worktree/foo initial &&
 	( cd wt1 && test_cmp_rev worktree/foo wt1 ) &&
-- 
gitgitgadget

