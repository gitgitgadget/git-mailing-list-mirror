Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC82F2797A1
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308314; cv=none; b=Rm422wuq6zUMZWEvbObKvXUNIKgqmu/brseXsZNvQiLivqGcspx5YfV68tOW5/WKk/u79JJeFIK+80Os0Rhc6OCEAa+Mt2m92f752w4fMLd0EtXWexvJuT90OgbPoNazTgnArRWXQ0QR6TKqRyFjoNe8lsEj/h0N1Ufwd9evxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308314; c=relaxed/simple;
	bh=TjPzjV28xzYAQiVbdpe0AczixUF6KwqJwNca/zv/s0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPb2mubdqRDu068caVBz3Z/U66lF3gIayIoyWfhgumrdSQACu1XJU0jK5WAi82VT0y9bZkgoKyUTWy8e2s0g8dWkAUGvmMT8v/n3yaXSCvtXHu26JJCO52qqoHctEYczyPFF/gCCEE09aipTl0JMoSm/sUhUfbD8wBy3AhFolwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpcgIHdl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpcgIHdl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b5c12dd87so34255525e9.2
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308311; x=1756913111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kfXsxDnerVQFaVO/udfNUiaunFKLBVa3eJT7mV3ZOME=;
        b=RpcgIHdldC02F/OLkx3yQUW0j0F9JDF36BX6nERcSRrF0AgBkANeG7gHHQ94e6EIzU
         0JrTquJMIJYaJfFp2+jiDjTnzYBrSlHeQL2apfwk4kcBJekBc8xCUvkZF8pUXJtintte
         iK73jHzmYeJ1/0bhPlenUmn3VRF7btQoYQiwbBMqFhzx8+J/1yYPzt90+gt2utMOobYd
         yab+RpfqArRVS4/xID8ENVm/CQkjbUMBZkkT2p/2nClHOLzpTK7KsES2CC6GlJXJuFAR
         GYPTmdymF6vhjENB4XbS95GMqkqSylBNYS1Tcmq7n+ZbOuyw9aIQ2t90q0dnPXG/M4Np
         8/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308311; x=1756913111;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfXsxDnerVQFaVO/udfNUiaunFKLBVa3eJT7mV3ZOME=;
        b=Q8x9Oyy/nh0S5/qwESpAzvB5pQFKb48CBFAN/LgraichrLpWKWWfbvIXGEVWdA5HE4
         Rvvl+htVw/KHG7FFKCUF0hndKrfPqxQ7SXmbOx0Q1DP4FlUUqLV0LU53ckZQfgLhRyOE
         pyeEt6Bk/HbtCdHHru6NcTaD8ggztAbOOg29SgsdhXoX1dORmBqearWiivCoHgaS8DcW
         HYL6qEhcxeVBaYmLctrmFvRQqLbiv9gc5pS9v486kM6j1vfZnoK3dLpq0+1LvvlWHdH4
         SLKYvwH+WX4C5pHF5w/5RALWrqkzBTTH+QdcwospuIP4x1uUBcoLqyCQWavMjb3JMwET
         t9Aw==
X-Gm-Message-State: AOJu0Yw03DLJgYXw+SxEfrW20zy6yyTas/ja1YBsIARnDGJGnBwQlObA
	Xw8RKCVaxP0gGyvZNamxiIsz+1+LoVQMjAAGcWdB4SfyBGFcl7WjyxohqFzWqA==
X-Gm-Gg: ASbGncsEDIY8nIQOhR9WgARAugtbN2Dbjgfdjddf5FdzQuDuLAngTP2+8rMQSEElbQr
	qXljiyEvNZc1liI2BSKSq6YrmpMk+kB9YALmDCgYo6K4mhhD5LZcPz77h2GToN9jw6E9DDqDjTv
	5JHfP8NnArb4Cqa7S9h06SDdHXecW13OjUo5uZV4+lG99qlNZBA6O6C1PM4lw69Hio0KKSYxfFF
	v2YSG9oAY9z2sBzbnebPdlv5HhKjOlCnqyIVoC088nX3ZHQV8VJ3j4IetagvTeAEspOHX88iPD7
	VqCj9WdZW92qZiT8gZ2+E0vYuKwSVm8YZeCVgkjyQ2jrgVzaYWvjICyQqNuVC9qH3aQ1G1OVlNW
	FcK8gbKNTCIXJar5tPydt0kimE4QRjzqWrd/G0dcXf5JWYA==
X-Google-Smtp-Source: AGHT+IH3DEVqo0mNvWvnfPnds1aeqQQhPz5JAsEJ5ELTBwQ8eXShbbd2W/JpIhOvYFgF4mX+hYm4oA==
X-Received: by 2002:a05:600c:1988:b0:458:bd2a:496f with SMTP id 5b1f17b1804b1-45b517cbf19mr154360435e9.21.1756308310884;
        Wed, 27 Aug 2025 08:25:10 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73627bc4sm17894305e9.9.2025.08.27.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:25:10 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 4/6] t0613: stop setting default initial branch
Date: Wed, 27 Aug 2025 16:24:48 +0100
Message-ID: <bbf79dd64fef485b75bf0fbb37322a6cff7df7f8.1756308283.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As the tests are all run in separate repositories, set the branch
name to "master" when creating the repository for the tests where
the result depends on the branch name. This is in preparation for
removing GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in Git 3.0.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t0613-reftable-write-options.sh | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index d77e601111f..b547e12d66d 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -11,16 +11,12 @@ export GIT_TEST_REFTABLE_AUTOCOMPACTION
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
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -43,7 +39,7 @@ test_expect_success 'default write options' '
 test_expect_success 'disabled reflog writes no log blocks' '
 	test_config_global core.logAllRefUpdates false &&
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -62,7 +58,7 @@ test_expect_success 'disabled reflog writes no log blocks' '
 
 test_expect_success 'many refs results in multiple blocks' '
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -115,7 +111,7 @@ test_expect_success 'tiny block size leads to error' '
 test_expect_success 'small block size leads to multiple ref blocks' '
 	test_config_global core.logAllRefUpdates false &&
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit A &&
@@ -172,7 +168,7 @@ test_expect_success 'block size exceeding maximum supported size' '
 
 test_expect_success 'restart interval at every single record' '
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -212,7 +208,7 @@ test_expect_success 'restart interval exceeding maximum supported interval' '
 test_expect_success 'object index gets written by default with ref index' '
 	test_config_global core.logAllRefUpdates false &&
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	git init --initial-branch master repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -247,7 +243,7 @@ test_expect_success 'object index gets written by default with ref index' '
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

