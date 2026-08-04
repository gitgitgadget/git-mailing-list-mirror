Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11394562A2
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852039; cv=none; b=SfOu1dZxZMKYEgrPQi0OchdUmBJfiy+One4rmT1x53/ffMZZiGcU58gnSb8rcfIlzGjcImhDCnr4pbLvPoQjbQJGhCWXCKGL4pQRDNv6yCLYfvEOp87MqFqD3dITbvlaLymBWEomj7Oz+sIX6+2S+2XmL8NwbVEEea5DX6R1CEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852039; c=relaxed/simple;
	bh=QZE7xtm4FoaorxV4fwIcQjFfPAWGimgxa9fXsUURgfo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=hTtFxD9JAjoGqoTA46XXALI2Yx25wlppDlb+rLtewxdWJk3PNTyO2shrhRZZj+pl00UK3lML+4OKr3WqCKJRJQyLPIv9bWrMSwrXh3TRSpS2Hj0Y7bahLky9YvpIpCnZJuMXSXnQWJIMIDuWm5K9MqG5Iu/p8u3iOR997uqhndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwK1PhxU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwK1PhxU"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1082851b3a.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785852037; x=1786456837; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5hI2jRcrCRdm+ZVABtO2RQKaOoK67cjDGqCoX4568uc=;
        b=KwK1PhxUSTO6tFlJNb6+/HdGBbas8aM9lIrne2P1KUQVPpkXioDL5wMfTy9MfzvEhf
         W8VxX+nirevTRAFWq2ykd0Zk0AwI5uA664O/i6bOMlneoE6Rvgdtg3rgn1MRFRJBZ0eY
         wzr6t1ARsY7OUfXwBQtedzPOGzl8Yd6kMnfIx/9GPZI2sy/TxH38EpYJiQ0JsG6sL+lG
         n6/Wf0lbUGRee2NA2QQLRHDFyaXeeUaDG2eNfZemb+zxITpwoZSGzAFPzX/e+ukM3xbC
         uDMalSaXuNJYWSUKbnwRb8EttTpRDB94syg51fUunKdwf9/4rcd1WqiDmKH5pbWj35TU
         kn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852037; x=1786456837;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5hI2jRcrCRdm+ZVABtO2RQKaOoK67cjDGqCoX4568uc=;
        b=SwUwfr10ww7Gvtm8gSAFB0E80qECIHQqENmPV4iLYa/C5VPit9JngBd5BERtCukfSi
         fES9hsvMzmj2FhP/D+YS1TSZkrs0KOSLFflHDo/41jTkcC5RTlAwGGifcWb3U4ftWZnK
         6krOPI55aFRpfVpFub6YE57NtHhdAleOW5Hjgo0LSSJebBXBvHBzkvrtFa5ZW2xtYwOJ
         WKneT9BU0o6Ze3Xs71wfD9HFl4szQA0CyKfzUwz1UMCe4oxKCNnFfHGh5kpyi7PQfzVD
         VEI65ieLrwI5ZT7GRSy4MfBrcdC9izVm7crfPuL5I4xhlHU5rwcVGUJclZ4sHeAB09jH
         F65A==
X-Gm-Message-State: AOJu0Yzkmd+yLeNttBIpCYs1t3QUWSrLaMoB2O1wux1Cb3FIVc4CHI/V
	N9ALKgA0p6sqZ/awW1UmCkMvUg/V7jhhsAza6fBmGKLh0tQUcg2gBm/l9y9RAw==
X-Gm-Gg: AR+sD10U/vz3rPtSJ5Pl5hfbXCN/I959CECbT5aqMAf1BzmD7sluTUzDB9sguVL6eNY
	u7Uo0IquLBfOU9/Dc/qREF91F//BZP90lQbM+6YcaFv+61PboB/bF0pqTK/0X2Wt+UpepJkkuFS
	6lWH16+wQBz5lLD/HF9fr9VWiivLjE6WvaFClcY0CGqEY8pqadf//7hmxE/l0kkhc/vZfKCTWov
	LGlfXlotsKZ8a8EQLRyCm3DPInZjGmM7tAq8JkbA7+6hBJ0atYhgcBJRIoi8+jT5m+2zWawHujg
	e/qiPzpd03sWnnrs/uAjAUjDdE00oWcIqcR0noxCFI1m1ekCaFoXZQBYmzrHCEByNlYiMuOoydp
	2eHjgUrmph7rqKKH26AaKoyo8pP28eRx579caJvvGbRXRen1B6zLpqnd6L9XLWR6w88zt2fOHMq
	liqvOfAoXb3qi/iXhYKCxHdukE1bwJx7jrC48mRIvqL2xagu7HcroY0Q2+CkSG7w==
X-Received: by 2002:a05:6a21:4cc2:b0:3c3:a195:518c with SMTP id adf61e73a8af0-3cb6c9c0ea1mr4269861637.21.1785852035761;
        Tue, 04 Aug 2026 07:00:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.228.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe64a58ce4sm1344596a12.31.2026.08.04.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 07:00:33 -0700 (PDT)
Message-Id: <pull.2192.git.1785852032626.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 04 Aug 2026 14:00:31 +0000
Subject: [PATCH] worktree add: shouldn't dwim if -b or -B is given
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
Cc: Jacob Abel <jacobabel@nullpo.dev>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

'git worktree add <path> <branch>' DWIMs <branch> to a
remote-tracking branch when neither -b, -B, nor --detach
is given.

However, 'git worktree add -b <new-branch> <path> <branch>' can
still DWIM <branch>, causing <new-branch> to be ignored.

This is a regression introduced in v2.42.0
(128e5496b325640f0a09cc1d5b1e346c069b410f).

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree add: shouldn't dwim if -b or -B is given

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2192%2Fyoichi%2Fworktree-add-should-not-dwim-with-b-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2192/yoichi/worktree-add-should-not-dwim-with-b-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2192

 builtin/worktree.c      |  2 +-
 t/t2400-worktree-add.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..3204afdb12 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -897,7 +897,7 @@ static int add(int ac, const char **av, const char *prefix,
 
 		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
-	} else if (ac == 2) {
+	} else if (ac == 2 && !new_branch) {
 		struct object_id oid;
 		struct commit *commit;
 		char *remote;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..9cbf84861d 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -621,6 +621,16 @@ test_expect_success '"add" <path> <branch> dwims' '
 	)
 '
 
+test_expect_success '"add" <path> <branch> does not dwim with -b' '
+	test_when_finished rm -rf repo_upstream repo_dwim foo &&
+	setup_remote_repo repo_upstream repo_dwim &&
+	git init repo_dwim &&
+	(
+		cd repo_dwim &&
+		test_must_fail git worktree add -b branch ../foo foo
+	)
+'
+
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&

base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
-- 
gitgitgadget
