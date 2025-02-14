Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2733263F47
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536684; cv=none; b=RKFG8fHNpoScS8XaWf1n6WoeW+ONlkCAEasQPByDtQE6Sq6W50mK4tcPHlG53t1KR+UdV93kmU/clYJkthdAZspDVT5XpdLVz3qQ6YvVRRu57NEcl3YKaA91p6zqpbzmVJvnKyZ7a1yVqTQuy2usTgiSim7JJE4TUhkMKur7/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536684; c=relaxed/simple;
	bh=NgcdHkkLwudzQ35twlRCjU8htQPOSFjEU6KAQMFcIos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovc03uVXR7V9Sr2EOpaCQeQjRWYaEl+KDrP+1x0u33FrhtjxxcCarNmyTjMqabbc3nOtgqFePV/fp2cDZy7QlIaXv6Qsmf7FnLztIGY1cMH1QkBbnmU/nZIpatNTD5F5HXO3CBYCqGh5Nk++9y+SwJvojGpAndcZZXrEW4kX1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeqsDwMg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeqsDwMg"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e6028214so25125985ad.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739536682; x=1740141482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpSXIfdbGTe6dt5KGY2+b6OJCQo7ccZYAQn8TcMKp38=;
        b=AeqsDwMgphFT7U9vMYqLvvIhV3LJNjC1Wb+cGhfWhyccBTfkRU4GqIR/ExY8wRvypn
         9WahG5LHqksJ3FjH9vLwuN3ElI0j+XKfg/bCBobGwrKabu/Z8tcBZjGIKxQz/GkdmUMf
         Red49jE/9kPF5Cqaz6yfyhGpeW/brTKD2AOvlaGjU86vCKlk82FSHB7Ru+H4CwL/VbQa
         jYDWGEO7xnYhHbazNxc5gx3TrYHOmumrUzbEbfedgLViKcDYOhdBPMaYPat0/zKThA2q
         22sqqeiRYrf8euNLJfVr4C1zGsJechnfSOeije9V51rP5kSJWMJv/Qbp5lHHTyb9NzHL
         TB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536682; x=1740141482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpSXIfdbGTe6dt5KGY2+b6OJCQo7ccZYAQn8TcMKp38=;
        b=PRrwYXCA9zYUckLgndpT12kUz8ywYI2g9PDB4cq6DhdLXFdvqmOGDGL38VIW67oUW0
         HPi8nc2K/GKQmrpuxfa9EVEGTOUldsO/wk8I/W4ZUFEv/m5PXgMnDG6qioWKwGNEhc/Q
         UWnr1N1yjGENj4A31rXIEkOCEhGRpREvzBqJrAvb+QmEuRN9Mz1cCE2KRcTiL7/xsJxe
         xnE1INoFj4dIyanwzlqQ0PqQk8ZvwJ7S05SS8MDf9ugZN+em7Unn2M5vyVQenHqFQ0qn
         J9FqgynUlb+LkzKCUCBu/B2KFN3DlX+niGuCaHdbWiKC5QnqBQYlRABMBsIJ6lRUMO7k
         Xtpg==
X-Forwarded-Encrypted: i=1; AJvYcCULArktHrkbCpOxgGCJVsz0SX1Zb+N57Nky5zREVosR6aYb4ysFT5d9MPJRyrA9TBxgzl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5GCFmiPOeB1Q5dRB54uee0aQxRm58y1QNxK8ZmdeLGkNNn4x5
	/IB6SgJaZgin0Ve/00mArZPQBWjKjEtL6T6AuVp6HQyo+dJwOu7t
X-Gm-Gg: ASbGnctxUlKvvizlqW+3MgGPhnFCIFUxBe0r0Ke7NQQaq24oI0n0Ewc0DusiJyajO2C
	/7LC35XVjNYrCrRWaczRtHTNaH84JSHrXR5lvDaxpBNBEKdHscKMbkqI8sglE6NOQDxM4D7wokR
	Ig1Rzgqi1pTK3YuHdxOSD7Nh06Pt2rudpdCKlRgd89wFhiButPwZoI2iif/JQgq7empjbnUeLNZ
	i8ZdftKl9jt8o3lqoF8Mqz+Id1SWLnmBOD3GNxcjiCHg7JV+FqHhVw1if0QWj5DQYGkxN3B1/Ms
	BZmDd9apm30SHJTYRERavGNsnZvPT7JTEZRb0MVN
X-Google-Smtp-Source: AGHT+IG1Pcaeiz25Bj6AZxThuTy1+t0HLWuIxg/Y/HGY0D/OmulofHWYMIk+IbU9ESyYGM2cvOxuHw==
X-Received: by 2002:a17:902:ebc2:b0:216:3466:7414 with SMTP id d9443c01a7336-220be0035c3mr199839235ad.44.1739536682110;
        Fri, 14 Feb 2025 04:38:02 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d09esm27814775ad.112.2025.02.14.04.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:38:01 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: christian.couder@gmail.com,
	git@vger.kernel.org
Cc: Johannes.Schindelin@gmx.de,
	gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 5/6] t5701: add setup test to remove side-effect dependency
Date: Fri, 14 Feb 2025 18:06:15 +0530
Message-ID: <20250214123734.1403120-6-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
References: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
 <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the "test capability advertisement" test creates some files
with expected content which are used by other tests below it.

To remove that side-effect from this test, let's split up part of
it into a "setup"-type test which creates the files with expected content
which gets reused by multiple tests. This will be useful in a following
commit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t5701-git-serve.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index de904c1655..4c24a188b9 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -7,22 +7,28 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-test_expect_success 'test capability advertisement' '
+test_expect_success 'setup to generate files with expected content' '
+	printf "agent=git/%s\n" "$(git version | cut -d" " -f3)" >agent_capability &&
+
 	test_oid_cache <<-EOF &&
 	wrong_algo sha1:sha256
 	wrong_algo sha256:sha1
 	EOF
+
 	cat >expect.base <<-EOF &&
 	version 2
-	agent=git/$(git version | cut -d" " -f3)
+	$(cat agent_capability)
 	ls-refs=unborn
 	fetch=shallow wait-for-done
 	server-option
 	object-format=$(test_oid algo)
 	EOF
-	cat >expect.trailer <<-EOF &&
+	cat >expect.trailer <<-EOF
 	0000
 	EOF
+'
+
+test_expect_success 'test capability advertisement' '
 	cat expect.base expect.trailer >expect &&
 
 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
-- 
2.48.1

