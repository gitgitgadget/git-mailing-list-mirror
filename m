Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F921F2BB5
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 04:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751345584; cv=none; b=oxCUt1bC29hZo/hSAQ1smt8Ec1wME3GkN8Cxlais0VqURWgOrInZzuUFtlhbXybKcz4WFh/OHCucCk/3Q91+nw3myvD66LIJUY8/1dfuQHr8ZhHDVLflBzvu1XXLpxuuyymE9+tGrzx9LJ0CNOtkElLKzu5yQDo1oX4yuX/pqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751345584; c=relaxed/simple;
	bh=n0LpbfQdrNAgTLkBsAkV2GPOK02SPrOmNvvX20Py7ac=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=CKZ70EsuOxjL8td2Fc56mEs0plMJ72WWa7Zu/o109U2WAd/W75g9XKOt6g8v8fU37kUI16nf/s8hw+OJcf5hC8H3Vl+ZMyBjVqFRfTtQLXtuG4eQOH5sf7jTn1721I7624XQhdb6p6FSBtZHYDlYWAN1u6iyUbn3ng2NLYzslOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjLTa05h; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjLTa05h"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so2459179f8f.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 21:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751345580; x=1751950380; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xpeyXlwa5v8wGY9QFwEtm/DvtDXRbQO9YD+bA7tR7ic=;
        b=DjLTa05hj7gLU3m6A9DNcaxCmRgO4BwlmjYghGk8kDsjDnXX+IQv95c3j4MjCnooNZ
         M3gWWO8I4w4dLYJI1Ny4zDgpD1u7dPk6nUPFsXBqhrkFfv5oa3lQwz58HEC9nuJYnJmO
         y/XctN26VFHWS1KsLFJ0gfVeWBbG6zvfcHAgcAWMAinyg27aIC7vChgvntOQVhCtGxqn
         mcfbt0CnqDQ9IbnMlUvfqSDozNNrEquM8TM5hTUrmYOw8sn00wA5Pr+YQnHI0PvHlGom
         TOB5D/owlJQZk+VqIbE99/Hv2YIBHjiP/KC+rG44HKJ4KfGoXbEEQFweo0mma8zzVXjE
         ySIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751345580; x=1751950380;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpeyXlwa5v8wGY9QFwEtm/DvtDXRbQO9YD+bA7tR7ic=;
        b=C9CgScSuMmvyZCDf9HNEO4rEt/XA6jGK3p2nB2+cFPBIhYXCLVBDKOyW0PBjFkSX31
         1zD5Fqt+wrf2p8YlrvLXQsI0PdgZjCcc8TTdRUwQIgeYQyP7fhPxSIZvoRxtRzB2OswA
         wT/kY9x5fAMrC52VUwZ+zhnxGecL/ZlALgiY9j0gamZ5fYLv2d86bCNmi2iGTYPqgs/V
         0VOn+uckUB+23W6+SONmj9eEd73hiJzN7u8wn9nrtnMMTycdlkRp/IybMQ8Aw1ptWwYt
         ZRNzvFVDNFNYalrRMY54WmWmVTFSgK+9g/2wEENJ0KU1q5yDb+3/uV3eI6+iMrlwXr5j
         AHdQ==
X-Gm-Message-State: AOJu0YxdNnBTBtyw6JD8B77CGnyFYTWy7a155PJ6mlGK81hwXMhnPUPu
	6rC4bd/70HgN/+65Ue6m5cwUWNL1QECJFZp8dc3xGaikno3RhL8KXDxdEFBTFg==
X-Gm-Gg: ASbGncsLlIejXR0wDDlWZ+15Rh+t2Dl+IMh8AfvZcOaXWwY6KqWc/K3raCviEuKRBnJ
	DtCF1RGpP8XWbtpXAn9pQS8ZlyMmfUMI+hIjFMMGasSGJAqmSMIiVMdyZw6UWDjS6/dJopz0+hx
	UZLzRRlkXfbsRnx/k3VTqBhAzd27yn+AE0iPNjm5uVgac9jcSW3VofITkGABOFJIgQkyBTaaU/K
	vcCXP2+nScoLhkKA7ZvyiILFOhhXacn9cJlIjYvc9V9u0Akj7u/aTXy2Hvb7W/qnearXh6i2zeV
	HCdGRSmRJN8DLBOMrAWlgQDn7sNH9SDkmB98/qRtWEjzHWhN/BJPzkUoWU+pdBE=
X-Google-Smtp-Source: AGHT+IHMOdqKXDUiyNYbjTPiMQIxBWuOyiljZ/f5GagOSECfpDv4KuYZ+wulo6GnFbepNS49Mqz9Kw==
X-Received: by 2002:a5d:584b:0:b0:3a5:3e64:1ac4 with SMTP id ffacd0b85a97d-3a8fee64d08mr15409412f8f.33.1751345580061;
        Mon, 30 Jun 2025 21:53:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e528a9sm12270703f8f.60.2025.06.30.21.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 21:52:59 -0700 (PDT)
Message-Id: <pull.2006.git.git.1751345578742.gitgitgadget@gmail.com>
From: "Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Jul 2025 04:52:58 +0000
Subject: [PATCH] ci: update FreeBSD image to 14.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

FreeBSD 13.4 is no longer supported, and 13.5 will be the last
release from that series, so jump instead to 14.3 which should
be supported for another 10 months and will be at that point
the oldest supported release with the interim release of 15.

While at it, move some variables to the environment and make
sure to skip a git grep test that assumes glibc regex.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
    ci: update FreeBSD image to 14.3

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2006%2Fcarenas%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2006/carenas/master-v1
Pull-Request: https://github.com/git/git/pull/2006

 .cirrus.yml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 1fbdc2652b3..fef04a38402 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -5,11 +5,13 @@ freebsd_task:
   env:
     GIT_PROVE_OPTS: "--timer --jobs 10"
     GIT_TEST_OPTS: "--no-chain-lint --no-bin-wrappers"
-    MAKEFLAGS: "-j4"
+    GIT_SKIP_TESTS: t7815.12
+    MAKEFLAGS: -j4
     DEFAULT_TEST_TARGET: prove
+    DEFAULT_UNIT_TEST_TARGET: unit-tests-prove
     DEVELOPER: 1
   freebsd_instance:
-    image_family: freebsd-13-4
+    image_family: freebsd-14-3
     memory: 2G
   install_script:
     pkg install -y gettext gmake perl5
@@ -19,4 +21,4 @@ freebsd_task:
   build_script:
     - su git -c gmake
   test_script:
-    - su git -c 'gmake DEFAULT_UNIT_TEST_TARGET=unit-tests-prove test unit-tests'
+    - su git -c 'gmake test unit-tests'

base-commit: 83014dc05f6fc9275c0a02886cb428805abaf9e5
-- 
gitgitgadget
