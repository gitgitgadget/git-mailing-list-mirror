Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188C2FAC14
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140414; cv=none; b=RnyBsdkWilv4471QGPmUn1MrU8KopSgfTqfxP/iDG9oeZk9xbOrl+RbRA/GiYClzYyIWbRukBuejhPS5u5H+y6CXv0xRr9hCURDc3d/rnSCPYcZKKXo/RTbRfArMfMFQgillLAM1IaGUVlAH+dgwLvGPcHDt3d2/puKywOYmuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140414; c=relaxed/simple;
	bh=FZ3aKJNnoJCtsUbKksVTMbcxKtdv2bo7JLtxNwpmcFU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DAfMaUd8CcT06h24SuBo+QsDg9pKBGEdPQ0msokp0jyMYL6vaHdLxAqWfNW03+75cp6hjOaakkrt/gFw7Zt1ZSZ4+vJ7F723VRhfyio3KgyJKCbJlPuT/FSZ+GetB1/oAt0JidR4ETycJ6J2bCcKdVRMoRcRbngKddZlmXw/yrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsR36uNi; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsR36uNi"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cfbbf35354so127338185a.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140412; x=1775745212; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hggOdtI0g8ZSbIRj+zy0lLMuGqdlSpGOoFYebO+v6jo=;
        b=QsR36uNi7+ikAMirm60uKdZEqV19g/ReXcrYO1MR5+2fTq7/mMcPIerPVLxFw6Hdvj
         U3JCwCCIort1jVOT8K3HL6YSQkS+ogdsbMZv+AvDyeFyZtJHRJGOR286QzfvTGvjuho8
         URokHoYLI/4DyOWFFd8gW2hlmRT0ahRGNPq6YnwyQ+Z51mVQ78hyZxhpFIvz7GJLgTX/
         YY2oAgF9/shxa40fRPOPdqC0Rek6oUaGf+YR14kZ8FFvQNWoeHl81xDXtztIeoD9Cvoc
         ggq+NV4aKSYGkogWdcTp5yFqgXh1nTfL8TAwa5N7VNiiho1T3sFPL6XaSeBeYASWzrOa
         9j1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140412; x=1775745212;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hggOdtI0g8ZSbIRj+zy0lLMuGqdlSpGOoFYebO+v6jo=;
        b=Ywx8k5RpEbIAdnbz1P3xsgQAicR790op+kh9Fu6Dk3yyGXYPiDDoSqCvtA9fCzOpUv
         Ww/fdSEj2FLr35eGtrz+VoMAnqfwnWPJmDUA0m8AqVZwsA+EVZoV2jY7owSnMAhqadDX
         l5zxLbQLCPly34xk+jHYe3PfpManh2C6l9P1y+mjXA9hyUz5a5XtQ8EW9+XCyM4/crXQ
         iF5tn9yHdrth1ovuGGZ7FCRV0hhiOTeMesk4vxYIOCJhTBKQP3J9i/yYHKzm9hokJ/4Y
         n3rqec7gIebFRc9OtgrHR6hyoxEb2A3McVZAxQ8vA3unhORByyjCcfM89aP00UQfW5YN
         z1vA==
X-Gm-Message-State: AOJu0YwghRDAbBAnqhod/XhTJx9kCtWYx/XiTujZRMn0O99lZlxlY2e+
	jqLnrrzDhDq/DNcwRD1ELs5GhaNkHwygXrBwEME3fxLGXtL/i+GUYRpWRyGP2g==
X-Gm-Gg: AeBDievAKLLdikOLFJ1cpUQ2bvRI0NaoiaySPU1LapLU+LeH9mvyLUpbN0zrRvQ2/qv
	SLaHZdmY+0adJkB1FCuIzyUH/6WhdwNJmjTy7WKlyqknzjcJ8s1szySQhdwiBJgT7tQHDQqjcC8
	Lzw2By14f/KMcEtnTBjFsDrkJxd69dkjRNhLhduPLQ/G+k12l42S5WczQAa22cDGH9MOq78zkAb
	+c/W2hQ1oEpcinBkYpBjLy1w7KD/HANBmsto2c5M4VpvUSWxCybipYdKeVpGhqq3VMKJSj6yHg1
	csX5xBSmpyYcyo++m8aVQeR7W+D5ESfu/OkktGhFf5FNudQQFnwTAh1rWYWMuMtGO47YpazBUSC
	sIFC804TDkHhLtWfhzQlZ3GnQrLLrp5y6JoMmsgZHD8JWRRlqlDdWTBU1Lc8lwPImRj3fv9zT+V
	89Jb8k8FubRRivOhFnXZHy1gd2uD4XcN2OmdGR/g==
X-Received: by 2002:a05:6214:4610:b0:89c:8709:d238 with SMTP id 6a1803df08f44-8a439a92812mr115647236d6.40.1775140411836;
        Thu, 02 Apr 2026 07:33:31 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593cec807sm24694516d6.19.2026.04.02.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:31 -0700 (PDT)
Message-Id: <c38f0a68f10df01ee2c99f05d0f33a0a517ffb50.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:11 +0000
Subject: [PATCH 05/17] t1020: use `--git-dir` instead of subshell for bare
 repo
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Replace an unnecessarily complex subshell pattern with a much simpler
`--git-dir`-based one. The latter is not only simpler, it also no
longer relies on implicit bare repo discovery, which would fail with
`safe.bareRepository=explicit`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1020-subdirectory.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 9fdbb2af80..20d2d306fe 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -177,10 +177,7 @@ test_expect_success 'no file/rev ambiguity check inside a bare repo (explicit GI
 test_expect_success 'no file/rev ambiguity check inside a bare repo' '
 	test_when_finished "rm -fr foo.git" &&
 	git clone -s --bare .git foo.git &&
-	(
-		cd foo.git &&
-		git show -s HEAD
-	)
+	git --git-dir=foo.git show -s HEAD
 '
 
 test_expect_success SYMLINKS 'detection should not be fooled by a symlink' '
-- 
gitgitgadget

