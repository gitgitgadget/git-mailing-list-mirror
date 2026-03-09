Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5FE2E4247
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079010; cv=none; b=gy54q8qnIyOt6eMhHwOTtMEpx1TYuKjJxd38EAmLnTG/PRjqzmApmVorvOh9JwZELFL+W3FtfflHwlqQlDBWPy+n0Eb5cIj6JdABP0VmZVhosvl5VmVbkjQ8nZkYBiI+x30eOFJpOulT/4+eCKlc+Y+g7H7NxHwyANJo1jTTAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079010; c=relaxed/simple;
	bh=bfWSECTHN0GYtpVHdQneXY0hEO2B9y3Rn1pl0x20hIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CoD3/AFuOEOtE4qTS4jpK7Nwiaa+N81eSDHLxKr8d7uR2TtjfM0ffMTLs5JicSYsFzIR8/QX+JnzjBRmg89Fp+dzbHfQWyTUCNyAc3qeQe10vsoqyTOtV2Hm0kYyF6pikosXb6rDkMcZ7e/VGCCUwpeT/5g1fRDhjWj8+Juru4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWSpGrML; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWSpGrML"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3598df39444so5365232a91.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773079007; x=1773683807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tSSnY5YaK/sCOxPH9US2tlv/h4CJtuPM8BtbrszwJ9I=;
        b=RWSpGrML20TcEa1iEVkJkoJtMdOFn6PEuuTMoIU74BSZiPSpOUR7YoeALnmEpFJo1N
         Vm377Ltdj5j2K40HL4hjNcmgNKEElQDDpyV64l9WHSIqGMnPSUJw0lKK3kfA6uQCzMiq
         L/A2RJQ9TxXn4rGaTqKsBTuHtfyusM+QtBX1WIr8w2GWdEaiUbaRNLtZ0PDqEjebvKww
         DeEq2nO4xY5CU33/pgyH1DF0GVsQfbjbCAH4yRTkgxTzJZ6Upx4W9INOyKthE5n8fCA/
         mi8eqMA+F3tL2dPyWl1dEIvskZKX39JXnVcpeW1PllOsvLjCc6HQyADiFp6mET6WMmsr
         B/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079007; x=1773683807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSSnY5YaK/sCOxPH9US2tlv/h4CJtuPM8BtbrszwJ9I=;
        b=ly1AqMPkwtr2JM3//aE9wNtXRWuXmU07tun3NPk8rnFLHV1XXeiLsrLdaen3wYnM3W
         UtX9OwuIMhHRFqtVT5ADz+1Njl2ZehtR+3DW1oIo6OPzrQfbpFl6DV8MqnbidkFvHHtr
         5ADbP5eGhUSLueHjZagGoNPR7EYbjSctNO6Kkh8YlHWUfKDEvYY7FE68v5l1oZZahIyX
         dqYUieJ5900GT5nfgIJoS65UNXf2Q5Qxs2hKxz4IAttn2iZp0of/lkbeGkc4RtFe/m+v
         4hkLEdqhhGalkEKoAptLYW5UALRMn5+OqU6J/MocaOaToupzrs6S67sdKI3Q4QcdGSS3
         8alw==
X-Gm-Message-State: AOJu0YzOxmzH2Z8GbQp1PqfIa4QP6pTSVk0EJqmuRy4HS00AF8sTeJQV
	AdYMAmJB/1o9REqHtW7sIKDqbGqbuoHHgdFWt0iHrMIsTsOAGjVHU8lTI01JuQ==
X-Gm-Gg: ATEYQzzbQWp/dYqnop0WIUDZufZR+niAzhpJMs/mcqTCfu2SPOsaXHM8oMI5yjlOwOG
	ayhIKdA/SlBzIdH6FkdcT4ybbozk5+tomOPCrC94QB3fMXhO6pO8uygUqDHsydvuU9sHBSttwr4
	7pClimaDUP79UylD3ouZWgFD/+IJ2x4J9S7FUZCSWTJzfnvRNo9iOnZVgG2amzi6Na5TRPa00px
	KwdRbSUgR0qv6992ctitNskUf2X290f3D9EcINHT+0ohV4Ghbs/JZxufzALYL7lCLcnad4/drzt
	4npalM5zqeaA273BjJtKZToSEMwi67s/zuABFxyrbfZ34WdHy0P3C7to94Qy5AVkYHQp+H6M8Hs
	MNvgdZn7He1x+7t2Kqs+PN9928paAGY2mbbQLcV/UkbqM5BGPs7aiSZKH+9lJTEXLKHPPSmIuXh
	U/HTmPI5F0RZdtc5Fn1KbEKEpmPziWmtcZqaYQ8ZtHPIiae0lswkBJepdw0RaE
X-Received: by 2002:a17:90b:2d0d:b0:359:8988:38d3 with SMTP id 98e67ed59e1d1-359be21d4b1mr11563071a91.7.1773079006737;
        Mon, 09 Mar 2026 10:56:46 -0700 (PDT)
Received: from localhost.localdomain ([115.244.141.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc7d7373sm6356328a91.1.2026.03.09.10.56.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Mar 2026 10:56:46 -0700 (PDT)
From: PRASHANT S BISHT <prashantjee2025@gmail.com>
To: git@vger.kernel.org
Cc: PRASHANT S BISHT <prashantjee2025@gmail.com>
Subject: [PATCH] t0004: replace test -e with test_path_exists
Date: Mon,  9 Mar 2026 23:26:21 +0530
Message-ID: <20260309175621.32211-1-prashantjee2025@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace old-style path existence checks with the modern test_path_exists
helper function that provides clearer diagnostic messages on failure.
When test -e fails, the output gives no indication of what went wrong.

These instances were found using:

  git grep "test -[efd]" t/ | grep -v "if test"

as suggested in the microproject ideas.

Signed-off-by: PRASHANT S BISHT <prashantjee2025@gmail.com>
---
 t/t0004-unwritable.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 3bdafbae0f..2a9fc781b6 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -21,7 +21,7 @@ test_expect_success POSIXPERM,SANITY 'write-tree should notice unwritable reposi
 	test_must_fail git write-tree 2>out.write-tree
 '
 
-test_lazy_prereq WRITE_TREE_OUT 'test -e "$TRASH_DIRECTORY"/out.write-tree'
+test_lazy_prereq WRITE_TREE_OUT 'test_path_exists "$TRASH_DIRECTORY/out.write-tree"'
 test_expect_success WRITE_TREE_OUT 'write-tree output on unwritable repository' '
 	cat >expect <<-\EOF &&
 	error: insufficient permission for adding an object to repository database .git/objects
@@ -36,7 +36,7 @@ test_expect_success POSIXPERM,SANITY 'commit should notice unwritable repository
 	test_must_fail git commit -m second 2>out.commit
 '
 
-test_lazy_prereq COMMIT_OUT 'test -e "$TRASH_DIRECTORY"/out.commit'
+test_lazy_prereq COMMIT_OUT 'test_path_exists "$TRASH_DIRECTORY/out.commit"'
 test_expect_success COMMIT_OUT 'commit output on unwritable repository' '
 	cat >expect <<-\EOF &&
 	error: insufficient permission for adding an object to repository database .git/objects
@@ -52,7 +52,7 @@ test_expect_success POSIXPERM,SANITY 'update-index should notice unwritable repo
 	test_must_fail git update-index file 2>out.update-index
 '
 
-test_lazy_prereq UPDATE_INDEX_OUT 'test -e "$TRASH_DIRECTORY"/out.update-index'
+test_lazy_prereq UPDATE_INDEX_OUT 'test_path_exists "$TRASH_DIRECTORY/out.update-index"'
 test_expect_success UPDATE_INDEX_OUT 'update-index output on unwritable repository' '
 	cat >expect <<-\EOF &&
 	error: insufficient permission for adding an object to repository database .git/objects
@@ -69,7 +69,7 @@ test_expect_success POSIXPERM,SANITY 'add should notice unwritable repository' '
 	test_must_fail git add file 2>out.add
 '
 
-test_lazy_prereq ADD_OUT 'test -e "$TRASH_DIRECTORY"/out.add'
+test_lazy_prereq ADD_OUT 'test_path_exists "$TRASH_DIRECTORY/out.add"'
 test_expect_success ADD_OUT 'add output on unwritable repository' '
 	cat >expect <<-\EOF &&
 	error: insufficient permission for adding an object to repository database .git/objects
-- 
2.50.1 (Apple Git-155)

