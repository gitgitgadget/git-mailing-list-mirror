Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6124B40
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521165; cv=none; b=HBtigaqbWP1OB229wQ7F2KgKYzqLFGwByssR17JYbwffi/3diNr7NqekzOZBeRL5CVmJ2rGHEX9FEasho2DDtLDmO6PaudmRl8G/ujRph7dq1M9CslQaMaG4Wq80pJ7a6EM7UIJOiiuHO6cdvZJN5CPNk+BnqwIPCLAfdR2cDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521165; c=relaxed/simple;
	bh=1HSOHyQ/l11TKAcuGtDViYeP8tpKwaFCXb6al3axu+g=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=A4SIk/3B38BkXm9D9VKqPyGykPeEFL2QPWQVkwEZOyyuyVNfRaafe4tryVREknsQ6xcaxRET4yYQEYapr/d4Xl1Y5pPfx73XLYR+5FZdlCYjIKK+DmvBxNz7DPLF/+BcBLEnBQd6KdMk9llSAa37pFoGNgY0QBDRRaaSwVhZuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK2JLgHH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK2JLgHH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso38189705e9.0
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521161; x=1706125961; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GdHP0Sc3gqgTyfjFlunSX5dRJ9gdpUAN4uPYSDyH34=;
        b=kK2JLgHHgJIJbbJnf2g2iUKh1m1JnDghRUM6dzZNIKat8GIfwl0f3Rd6jGdxX1iGAf
         JP9Y2w0q5AZ+DxVbbJ8InSnYP/MTRJ2i5L7OyPesMljb2vyrxR0sAX1EqJ4vp9j5Pzgm
         LNlamNu0D29NVc325/FfOcrBZxSFogAdK0aYRrGab5OR8+tuEVRpX/xgjpJ/OQWbYape
         wRkLaFkSBWFtY8W08d6EqrS2/0E6YpPaS4FZRL+3YXW0+d5Yjr+Ai930uxYXEkP8FNf+
         6TbLxCO69gaolQfqlkcFKel4gYlv+CRtBww7BrrPkS0/SOefGju7mHScaqs5ssVao12m
         y5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521161; x=1706125961;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GdHP0Sc3gqgTyfjFlunSX5dRJ9gdpUAN4uPYSDyH34=;
        b=f3ykft4bZR15asiV8sh4tHaw/6e+CswIdYy17KW3KlaMcTT9cgJoGwJfakypcvlMEh
         s7v9/KtLv6qd5D1bhoUHznntdu9iyjiSj69RQkaOi/W1kPqX00myot8Tkfy1EhpbQZ1D
         nW2nUzAJNt5DkdVlk/jiV38CqvTUwkhxRFDSWWmrfyp2eg0fPCCh+6nyrhp9Elky8++l
         /dJtobdcoERT7o0vSJvEgRAqj6RchNMrZTC0brQuz50l1jOStsN8ouQ+GUlvCf3qM0wx
         XCex/ddHXYNtmgVQlGw+ri0F2r8euPUidLMgWP4rHPdif9o196+gLiBV3flqjucbu6Tj
         xkqA==
X-Gm-Message-State: AOJu0YwMaCtWKNHHoNXk7dKNGm2jgNIvdP7L3BLDyMUeEtV3P2/uA3ng
	BoTjiDjFrdq+ClBhCsyvhYn7EtXaZ/U=
X-Google-Smtp-Source: AGHT+IH0zGL5SZVT93cgJINeI2stMFpgXampy4aS8cJdBD5eYpDxbL/3Dd3rgdkjKGxtKVG75B+itQ==
X-Received: by 2002:a05:600c:4d8f:b0:40e:6d7a:f9dd with SMTP id v15-20020a05600c4d8f00b0040e6d7af9ddmr3912657wmp.47.1705521161258;
        Wed, 17 Jan 2024 11:52:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b0040d62f97e3csm27366072wmq.10.2024.01.17.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:40 -0800 (PST)
Message-ID: <69ea950cfeacbd2830f216505cdf0de24b108b19.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:29 +0000
Subject: [PATCH 06/12] t1406: move reffiles specific tests to t0600
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move this test to t0600 with the rest of the tests that are specific to
reffiles. This test reaches into reflog directories manually, and so are
specific to reffiles.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh   | 48 +++++++++++++++++++++++++++++++++++
 t/t1407-worktree-ref-store.sh | 37 ---------------------------
 2 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 53ac4b9b5b8..09fbe312092 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -403,4 +403,52 @@ test_expect_success 'delete fails cleanly if packed-refs.new write fails' '
 	test_cmp unchanged actual
 '
 
+RWT="test-tool ref-store worktree:wt"
+RMAIN="test-tool ref-store worktree:main"
+
+test_expect_success 'setup worktree' '
+	test_commit first &&
+	git worktree add -b wt-main wt &&
+	(
+		cd wt &&
+		test_commit second
+	)
+'
+
+# Some refs (refs/bisect/*, pseudorefs) are kept per worktree, so they should
+# only appear in the for-each-reflog output if it is called from the correct
+# worktree, which is exercised in this test. This test is poorly written for
+# mulitple reasons: 1) it creates invalidly formatted log entres. 2) it uses
+# direct FS access for creating the reflogs. 3) PSEUDO-WT and refs/bisect/random
+# do not create reflogs by default, so it is not testing a realistic scenario.
+test_expect_success 'for_each_reflog()' '
+	echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
+	mkdir -p     .git/logs/refs/bisect &&
+	echo $ZERO_OID > .git/logs/refs/bisect/random &&
+
+	echo $ZERO_OID > .git/worktrees/wt/logs/PSEUDO-WT &&
+	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
+	echo $ZERO_OID > .git/worktrees/wt/logs/refs/bisect/wt-random &&
+
+	$RWT for-each-reflog | cut -d" " -f 2- | sort >actual &&
+	cat >expected <<-\EOF &&
+	HEAD 0x1
+	PSEUDO-WT 0x0
+	refs/bisect/wt-random 0x0
+	refs/heads/main 0x0
+	refs/heads/wt-main 0x0
+	EOF
+	test_cmp expected actual &&
+
+	$RMAIN for-each-reflog | cut -d" " -f 2- | sort >actual &&
+	cat >expected <<-\EOF &&
+	HEAD 0x1
+	PSEUDO-MAIN 0x0
+	refs/bisect/random 0x0
+	refs/heads/main 0x0
+	refs/heads/wt-main 0x0
+	EOF
+	test_cmp expected actual
+'
+
 test_done
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 05b1881c591..48b1c92a414 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -53,41 +53,4 @@ test_expect_success 'create_symref(FOO, refs/heads/main)' '
 	test_cmp expected actual
 '
 
-# Some refs (refs/bisect/*, pseudorefs) are kept per worktree, so they should
-# only appear in the for-each-reflog output if it is called from the correct
-# worktree, which is exercised in this test. This test is poorly written (and
-# therefore marked REFFILES) for mulitple reasons: 1) it creates invalidly
-# formatted log entres. 2) it uses direct FS access for creating the reflogs. 3)
-# PSEUDO-WT and refs/bisect/random do not create reflogs by default, so it is
-# not testing a realistic scenario.
-test_expect_success REFFILES 'for_each_reflog()' '
-	echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
-	mkdir -p     .git/logs/refs/bisect &&
-	echo $ZERO_OID > .git/logs/refs/bisect/random &&
-
-	echo $ZERO_OID > .git/worktrees/wt/logs/PSEUDO-WT &&
-	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
-	echo $ZERO_OID > .git/worktrees/wt/logs/refs/bisect/wt-random &&
-
-	$RWT for-each-reflog | cut -d" " -f 2- | sort >actual &&
-	cat >expected <<-\EOF &&
-	HEAD 0x1
-	PSEUDO-WT 0x0
-	refs/bisect/wt-random 0x0
-	refs/heads/main 0x0
-	refs/heads/wt-main 0x0
-	EOF
-	test_cmp expected actual &&
-
-	$RMAIN for-each-reflog | cut -d" " -f 2- | sort >actual &&
-	cat >expected <<-\EOF &&
-	HEAD 0x1
-	PSEUDO-MAIN 0x0
-	refs/bisect/random 0x0
-	refs/heads/main 0x0
-	refs/heads/wt-main 0x0
-	EOF
-	test_cmp expected actual
-'
-
 test_done
-- 
gitgitgadget

