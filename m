Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516FB509EE3
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652406; cv=none; b=GAwkbqe2xb8kpUdjatLZ9YORYj2AJVNNDSM2q5Xulcjk3tuhtHEM/lJRv4Z1HEI25pmijQ6wznM8yG+c7paueQNgRxg824I8Xe3WMMCVUsvea2AmjRQY33CKjd+KFLaNGGS96MRaXmfsyVLEqAaDosj4WcDugDa01ZT743cwQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652406; c=relaxed/simple;
	bh=73q5CwfFPm/V21p8QdFFjelt5Dr2gj1fMnkkFofuc0g=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=AL2FgnAd/HzwdW7w3zq22TZiT1V+yE0uoghTXQ89FcdeZYNFQBbkimhVPXFObBvAF5jwdctOuyoBsrUV/xDmaS78YsUI/qqILxiVEs+u/C0HYQGDUR3AgikyZ2wcUugO382zkCcsxw2LfUpMlqiJtjHmC7YlbzIZBilZRmElUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKKMQ+D2; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKKMQ+D2"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so669939a12.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789652396; x=1790257196; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u0AaGsLstB93g/LzZFxQsFNTYPlrRxZlR+QAOmqGqoM=;
        b=HKKMQ+D2IjxX3Y0q+5BEQ6cYLQULnLpi2pteQ7ZnpCBkigno2eYApymgJztvLdmo2r
         WTeQdzKt7Vk1SzKIOxujOOQwkTOVItC0KicUwNZgp41zIbLKaMwIUDGwt5D2aCtYwhzy
         HQhQ45yFKzkw8TyFmF2lwxKYHFMzWLj5yeUJE4qXXah9HZsZAWdKWpgSsbQAZRBhLaQm
         X3T3VLJZe8PDSmXMUEpfqtMHGj7WYDIbim0yVtVLZOREzA0YwqlUkb+olfsn/dcIABMh
         9xGiEgTmAtnbQ4LW3llkG0fZmAvk1R3jNA5f4CyVixPpuyDu+Z2bu2dPN1lFVxu/F1qZ
         7Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789652396; x=1790257196;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u0AaGsLstB93g/LzZFxQsFNTYPlrRxZlR+QAOmqGqoM=;
        b=iMZZ3yIrWUL3lvYXmCqTaOrgUZPw6YWaX/7KAB8A12A39VpZ2HbIKOcgTPt+N47sy3
         pPMkgcP3xhB8PJYT0Ill0jBMH83bBUdQw/lVDboyGcghcd2nHsEpbKX9redy6qiEBqd5
         VN3vVQCwKcQJrJp02YpJhNl+wjS/2XS3u/+3bWPuj9/jLpT7vMipouTy4lQjXZszH/i1
         /8sMYu5ucbRGS9hZRUmVTRqQjQp9CdrHsagp/SxMtMqDIxOlBomfIYRjucFBQRMfkdr1
         0ng9k/eT1NVRMc4AIIeCQ3MrLvKHbAJbJHmRIr5NF2DAYU6bp4mxhctzNw3rHTdg++t0
         82hg==
X-Gm-Message-State: AFuF++kA0lhGdgaO3g4FXdaYzpOAppfJrJ9DJCHsn8ZkdHOssAD4SC4s
	2K7n0/EP3qoRPC2BX9v58SIgM3elXTVRAVruQZVPXBLu9BXrRki9YYJhXEz7Iw==
X-Gm-Gg: AYBFou3sSm1CLyRNe5P+MWhJXYrwaBhtigDgnbJZIHExnXnFssXSSdVZQaRp67MI6pi
	f55gKk7nW9+PVi57aN5NCkFpZWGhqYjm2QivhCsGabVcXTfW2kGjFltIOC7KIsFy8G3zyg5Zg4Z
	ClHDsfm1G/BfRVzA/cyMKXQO7Kf0iu3/MsYXJIAU7fK5u3aDTJyKPMiptAzkKv912JXrAFebe1t
	F2/WcIQWl4UMLNe4hLnXIhB3OZvtN6whkav+T14T04ou79mg8lUNxZM+BaagFCOKUO5Zk3pV1Pn
	mWoMzKZPhdUXQXd2LpechKLBCdvZmBJu3LJAOmUo4RSbNCu78O9VFWsvZaemuk/kU6LnnPauS+o
	SHBR4QdHE2fMtolWg1VMmfEmTEeCCOdMgQFaSgMexBvaPe/vES55Cp1nHQmgthXG1QUiD2cp1TY
	6mDc/wn2F7dqG4+/CqUZNUy6cUU1cQCdcZQkX6UQnywd7/5hF+L1P1ZykmHoU8273oPUuu1i+8d
	A==
X-Received: by 2002:a17:902:e54b:b0:2d8:d4ce:7e3d with SMTP id d9443c01a7336-2dd8e7454c9mr141412405ad.18.1789652395492;
        Thu, 17 Sep 2026 06:39:55 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.180.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89eb896bsm26777815ad.43.2026.09.17.06.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:39:54 -0700 (PDT)
Message-Id: <pull.2229.git.1789652393696.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 13:39:53 +0000
Subject: [PATCH] mailmap: normalize name for Yoichi NAKAYAMA
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
Cc: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Normalize name formatting and map older formats to the canonical one.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    mailmap: normalize name for Yoichi NAKAYAMA

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2229%2Fyoichi%2Fmailmap-self-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2229/yoichi/mailmap-self-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2229

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e3fab1df9d..29b4890532 100644
--- a/.mailmap
+++ b/.mailmap
@@ -312,6 +312,7 @@ YONETANI Tomokazu <y0n3t4n1@gmail.com> <qhwt+git@les.ath.cx>
 YONETANI Tomokazu <y0n3t4n1@gmail.com> <y0netan1@dragonflybsd.org>
 YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
 Yi-Jyun Pan <pan93412@gmail.com>
+Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
 # the two anonymous contributors are different persons:
 anonymous <linux@horizon.com>
 anonymous <linux@horizon.net>

base-commit: 12cb6293d6288865c1a133cf22accbaf99d13eb6
-- 
gitgitgadget
