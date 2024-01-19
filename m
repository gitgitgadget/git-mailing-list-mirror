Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9029557861
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695550; cv=none; b=eQEAPyE9dz6jm3+YqL+4qU9W9adwU0s86PM69jWgs7LtiFKoc9JPvcHIkMTThheGlA7kklH7H2SWsgsiEICLBgB3f828bG9dB6vI394DvCYDpA9O5BlSpRB2Z1wX8zYKYYBGye3VS+L8Rkr0oeGUeZbUGgEHEaxIid6PbT3s1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695550; c=relaxed/simple;
	bh=Nkd1ES8oZVVIlYzuIiljWz/pThveS9EosVP5XK29e6k=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lj2HGoZPFQz4kBGHDVf0UBF9d9dk/nxV+9A2QRufWYSTmh15m6u90NzAxEoD50CBGx952dNqbxZ1VghIbJTQ3m4HfDxZxjUS6B2dNrKE8rvAhjh0y0ukpiiT2vxSU9qSX/v3PjA817MPRotGH7nQpb5xLiKkZH87MzEVgKK9Yx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpaM3jYp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpaM3jYp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso14387805e9.2
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695546; x=1706300346; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chiwQS799jM0HodqtY6YZOZUG9U79aDWKtAJKEW1nQY=;
        b=bpaM3jYpR4UxDqwgJakLxI9IwOUi7n6KutIngTlosmjjdQih6vz6jM8K7tmVvVpNoc
         ZpZLWqi5bea4kv43mpZqY0FY74xD1ctJQ4hhB/n6Z0BM2BloXplQYB2Geb+qvna+k+PY
         5HD+nGjvk+rqLR8MOWwiC6BxvMTPWq7BFY5f402cWCRSMewE0VaX9z7mFd59agCdEXwu
         Q2B4tV6lUXLVGXfhI8YFjesfczGGzigPYPIE58KTSCeWjzTuIEZw7SdJYcGYdzjaMBKP
         OMIRtOsJicI8KrqR/yLeThxPoNkxl+742is/vKgjdTrtTAuz6AcLfxcBwcZ5MKpsslS5
         FduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695546; x=1706300346;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chiwQS799jM0HodqtY6YZOZUG9U79aDWKtAJKEW1nQY=;
        b=NYgNY0mEEabADupy7C1+83xqgAbkB3pveTJfb1lWbmnsWgHrF9GiiE6jHjJpilkQge
         bTbdMsQCJucvvBKSMpDw0V5TxizwzX6HF6XTAw4mT67Y/PUDwt8OE7NtabYTANjfHExM
         FEm+XD3OfyHshJgaZk1EMuai4p7T2X/dc+J+D5OSFkDdKNLIrsNF6Rd46vEY+fuIL0ti
         UTVFlk0FMZp/Ykg6GjkTZBjIX+JJE/t4N0TYfLAjZPLSFeG2YyM71qRhrWFOjdGP5peL
         HDZ770CSm3vhQHxxIdppIpx0sfYM2cgZVuZfMdFGcpaadlKzR7LerA80dof4Wi9RDk+i
         rabg==
X-Gm-Message-State: AOJu0Yx5BSzHiqa4QjLonKW7nQ3MJxLrG4dUr1SJBd3X2knGmNCpLCXc
	YtS1+WwnIWIdIG+HSgZPbtNbO6OLpo54HVegxTXkr8D6y8XgqHztPAft5c0V
X-Google-Smtp-Source: AGHT+IEpXE6IqK8Gce4yH5FckytDUir8O+har8K67E9vo8jQsHEeLHc3FPXxzNyXnAoLxoaf0dx5Vw==
X-Received: by 2002:a05:600c:4d97:b0:40e:3529:b874 with SMTP id v23-20020a05600c4d9700b0040e3529b874mr173453wmp.172.1705695546586;
        Fri, 19 Jan 2024 12:19:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm33819846wmq.44.2024.01.19.12.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:05 -0800 (PST)
Message-ID: <98e40a024b9ae031d72506ff93684ba1e7efb4ae.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:54 +0000
Subject: [PATCH v2 06/12] t1406: move reffiles specific tests to t0600
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

Move this test to t0600 with the rest of the tests that are specific to
reffiles. This test reaches into reflog directories manually, and so are
specific to reffiles.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh   | 48 +++++++++++++++++++++++++++++++++++
 t/t1407-worktree-ref-store.sh | 37 ---------------------------
 2 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 2f910bd76ad..3bd28699d53 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -260,4 +260,52 @@ test_expect_success 'delete fails cleanly if packed-refs.new write fails' '
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

