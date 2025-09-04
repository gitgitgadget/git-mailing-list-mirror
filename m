Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56CF30277C
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992181; cv=none; b=WTdYT4otuJuMDHO/CM9MOS+cD8pi8hYYlwa0HsEQ4mRtfrJr+2D0YEMPpwQJtQbeD/QAq6BhJ1cCwYYKvkhof/Bi3fMVQhjP8WVwXagPQd2mRpj5HjRh9wJL82ZDBXrQJWCk5wHJMAKSQDi7Jlcp4DnMue9PGLOvqcUmTTFbMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992181; c=relaxed/simple;
	bh=8xj4vgVn0WBUjNqLLVxKnjxt1v9oJCMDChYuh4PMFdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fn9fNgxSlSZhcufNXvyMno7ZpRC9DpVHiVq/5/aDWbogUcajhydCyt2LEULPgvIjiMziGHatyXW+hKC+Cb+Sx0sxGKtzWOg1QUF5g/Lo67KFvSPwynQ2r6L36LRrf/DKeq8YS50bJ75b+D2COMi6S9o25dhXuRl69MMdZcnse84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx9GOlte; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx9GOlte"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3db9641b725so928622f8f.2
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992178; x=1757596978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CMIYo5IkR/pA0zzE76b9UfL1O2+Jhr7KZuGtaXmBQJU=;
        b=Hx9GOlte/FpFo+Tm0gskOowUPyL6xwvjxjnmhWlXMrGAA+JiDsOpZUAr4djvPH42hV
         RuxiEsazxKLteMYE57HQU9dj7b56mFdLjUNRobeGWHjBdOQfYyzSpLzl5u779zzyHcLg
         CY5M8BzDlLUJQqY7TzTsYxSMj6ixT5lVPzOpboq1AnrcZo5+V7ZXOzr2KWcckEHdYEsp
         RJ3T/qGIOu0rrLKNjmCN46vJFg3lDoepT3p6aQmwIUEgu0amkaFWLGAsc9dMbh5uJRZA
         pvqPp2GVjLL0D4fTNQwZfQltMpPYe9bUVJtCstLcErHpCB8Agt79/7YN9041Rysn+ZP+
         EdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992178; x=1757596978;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMIYo5IkR/pA0zzE76b9UfL1O2+Jhr7KZuGtaXmBQJU=;
        b=Rsq/iuwGydD4XwHQyVLvK3G+JGQc+whAgk4jTIApxV9+XQbfyt4K3n9NBtcmgRDU9Y
         wnlXXjq5GGH0f7wQRUG3Ip92LNnw5lBjQYql8hQA30m9/ZiJWv6n2cGcLBw7wSND95mF
         B2wsi5XR28YuGH/XZnK8N/Ms6sQIP6dYyYj6frRw4mz7JhKib3VwcqTiCcnZClxQ7qhz
         s5u6997fUF+5fqhlteQt1ka9bcFp7rnqCsR5zoJNj96d6mqbxD6SvqoTLanMTniXYobI
         jJl+wmnFsy5OBnRBkARmumz3cnrahx1OjBtm627jZRg/Kmx7/jKY07mtcZDx3wRLtti4
         pgCw==
X-Gm-Message-State: AOJu0YyCGhouWx4lvDAL3GrA39XBAVAIQz1cpNqpSfpKdNPb8VmkJzUa
	pf1dVJWjEw/j3UfOPgyOiWNe3LPi1aS5/wEYLT6k4mTx4wZ9TgxvcvB0zf4ytw==
X-Gm-Gg: ASbGncu5zHKepF1ionkGtkkgx3kxnjX+MJZfrt5+HG8nqB5zlrWLXfsaiwzJxOjaBG0
	BFIj8mBgYVve5zRIamEUjDRNTzxHrAeNi/lxWw3/E5BfrWedeaNVfkauybIuVXrVRbPNVRg8dOi
	plUqtlJdq++BP1zXpr2z04dScFqPLBwnsAoQc88genk+CE3JdhRBMZICuUQy45Ts3oc/ttIt58u
	gfaHg2/SZvRZtWoiAxUyNPnD15ZjxnV/Wc80dks/txqEcURIyB6YcV+xBdVOZ+S2PQFk1TVq4EO
	B0vUMDeej5ozgxUUrfxXP5e8Bfgqy6gg8nrFUcHSdmyBFE/HhhTwM3h9U76pKsYsmcoRnvikQe2
	YAjJr16Lq96bmRspWsh6uOBWvtq5STDSRka6xi2PPkyMKmVM=
X-Google-Smtp-Source: AGHT+IEVjzPD5u1grjlLRv4+J97VhVZYnbBncmIOb316LAHbq8iijifGrSjkF5e3EX0E/9mAwNQBvw==
X-Received: by 2002:a05:6000:248a:b0:3e2:164b:dfd2 with SMTP id ffacd0b85a97d-3e2164be832mr1170452f8f.51.1756992177937;
        Thu, 04 Sep 2025 06:22:57 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d643dsm28278985f8f.26.2025.09.04.06.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:22:57 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 4/4] t0613: stop setting default initial branch
Date: Thu,  4 Sep 2025 14:21:32 +0100
Message-ID: <c4d89c3761be77f1539668c8d543bb73fbf0dfee.1756992089.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1756992089.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk> <cover.1756992089.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As the tests are all run in separate repositories, set the branch name
to "master" when creating the repository for the tests where the result
depends on the branch name. This reduceds the number of tests that
depend on the default branch name being "master" and removes the last
instance of a test file using "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=
master".

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t0613-reftable-write-options.sh | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index d77e601111f..6d00432219f 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -11,16 +11,14 @@ export GIT_TEST_REFTABLE_AUTOCOMPACTION
 # Block sizes depend on the hash function, so we force SHA1 here.
 GIT_TEST_DEFAULT_HASH=sha1
 export GIT_TEST_DEFAULT_HASH
-# Block sizes also depend on the actual refs we write, so we force "master" to
-# be the default initial branch name.
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
-export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
 test_expect_success 'default write options' '
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	# Block sizes also depend on the actual refs we write, so we force
+	# "master" to be the default initial branch name.
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -43,7 +41,7 @@ test_expect_success 'default write options' '
 test_expect_success 'disabled reflog writes no log blocks' '
 	test_config_global core.logAllRefUpdates false &&
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -62,7 +60,7 @@ test_expect_success 'disabled reflog writes no log blocks' '
 
 test_expect_success 'many refs results in multiple blocks' '
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -115,7 +113,7 @@ test_expect_success 'tiny block size leads to error' '
 test_expect_success 'small block size leads to multiple ref blocks' '
 	test_config_global core.logAllRefUpdates false &&
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit A &&
@@ -172,7 +170,7 @@ test_expect_success 'block size exceeding maximum supported size' '
 
 test_expect_success 'restart interval at every single record' '
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -212,7 +210,7 @@ test_expect_success 'restart interval exceeding maximum supported interval' '
 test_expect_success 'object index gets written by default with ref index' '
 	test_config_global core.logAllRefUpdates false &&
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -247,7 +245,7 @@ test_expect_success 'object index gets written by default with ref index' '
 test_expect_success 'object index can be disabled' '
 	test_config_global core.logAllRefUpdates false &&
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit initial &&
-- 
2.49.0.897.gfad3eb7d210

