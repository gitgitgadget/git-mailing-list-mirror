Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F43BC67D
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731396; cv=none; b=SQ/kP2VnD8zyG10q6r4+8EeAgfG/bOhpRQihz1oMDc1H5KXsKXjFekC26SuJVGAuKrsqf0VbRn9lYQSLX6MIiYRt8K28LAwju25fJLDGAH1KmUaL9k99slyOJprWIh3fKIHxkoQOPn35cPsqzOAPPnWV08G6pTmFndzCRwRKako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731396; c=relaxed/simple;
	bh=DOazNov9ikn8++q9UJJnjb2g7CKwEZ7hAhj80BmEXrs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jaKHJW5huR5ElnSoni+vcrFQlMkMRsHuzwpNkVFjCsUY3p8vfGBfVt1sFPDDNKFJftVa6LoQWdw9/bKVjuUPtsr+chv+jH/C4AmisyS9gnHFEqsN/nAj7afIzSsO3GzakK/r0vbgh/l247rNKefikD7lcpixjhMgILTELHjLjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV9t1Sey; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV9t1Sey"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89e8e352dc1so3759966d6.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775731394; x=1776336194; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NutAo/yWoxNR+ASenokL8L1icNXhI29b/7Ka7D+zMcM=;
        b=WV9t1SeyKgNxaA+ZLOCcagbIc9y4hjE4+lJdtfxU/+j3eCTEATTeZT756g5jB1xrTP
         ncnsjPBk0flIOL/Nqc+3X6iB1Hu6fQ9DjywVyt7FiWkNKyoL+X0MfVp0tsnyw7UAGsKd
         rGuu0YLu6zzg1moXvTVEqGKl38BWA8rL6S2xyVwFbcbcIo5qBUarUgfDx/xaVV66C5Nr
         85LnWHrXN+dUVVqY9T9WlnLXtdtDo+3ZeKLHT/qgVCOSMf6J7mVl1vWuogbkjkjtRvG0
         PhcizuxBrmfpblE8YCPP421+eRUJFZesaI7/YDT6kfdfGArCCGLIzB2sA97RY/1MB3zi
         UIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775731394; x=1776336194;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NutAo/yWoxNR+ASenokL8L1icNXhI29b/7Ka7D+zMcM=;
        b=pazcsKKjC054wfx3ydsZXi7P8us74OHQj7l9cLlJdMwMVxaxRi/xHvKTAeFqzvzqzU
         gZ898H73nxVBQ+11tuVzlmdoTZ60/RsQc37A+LZh5DC9YFW/qzI+qawgjAy5/3y0WpHc
         wEGp/ZRbG6sowhGon/5+vZF2LZkgpk6tnmQfuUO3YFgz0cQ16Vxo+cu1pjzCqXZEyo8z
         KhW5ogAQXu+1kGQkYLo2yb7GA46oAD0jkoxW1ebCtDD2LvbH3bupDT8Jd8/aryt3GjJ5
         LZc+FC/zaxtm3yYOFoUaqibuQCYlFNo4OYiCxz+se9XnPURhz0Q3qL+e0NkbZbwP4mKd
         m1ew==
X-Gm-Message-State: AOJu0YzWuJ0j3W5OzuVdo1iEnwZengFiMTGVvRa9NVTB4L2lgORsS8kT
	KI4jVTKMT8vwwKkmgCD7AHsK2XsYZ9I/1rfWm9KM28M4R2ghFlmML1CAPtgcTg==
X-Gm-Gg: AeBDiesYnrtLR1SsCXWXGiwUJPjCCXBXJ9gaNBwmIoTFT41yAojr9KlEnf/SxtC1z0V
	gypB65O4EyOcqsi4k75z8K27TuOfEsTAsGbUq1/gwe2mc4eB4goI11A0vEl8x1ehjn8mN8BKT80
	6+8xD8oZbEscRrun+MbEZFARCipP8jwioivYYUDOw3gisPVX/Z42hB4OAIvM1NwqOVbJK+h8psz
	cam8oj9Mr7mBnKijNDZeyS4g4rKkGtQdxxfupS4OBQ4PN3zrzEOjgwMBXf+ar1/JQBQpXN6IhHA
	8eTSgXsBhPdqLciKFlSxCOq8gTOXYB1rG12EsFQhpZQvnrS6EnevrALtDFwyTC4Ef5Jey+pWf9E
	kZRF/c5Sln0/rV2P+/fNYi67M3DcyHImXsmuO1B69o8dBPCbz/e6UC2Z2tcDHDmsiy7xMFzF2Eu
	h/oagDO32PVMPNpUsvdQt0po94ZQ==
X-Received: by 2002:a05:6214:3186:b0:89c:8516:4771 with SMTP id 6a1803df08f44-8a7024bac55mr413156646d6.3.1775731393650;
        Thu, 09 Apr 2026 03:43:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf4f0fsm196277226d6.16.2026.04.09.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 03:43:13 -0700 (PDT)
Message-Id: <80d1ffde9d3d55d0ff2b28219e2484fb12d543d9.1775731390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.v4.git.git.1775731390.gitgitgadget@gmail.com>
References: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
	<pull.2202.v4.git.git.1775731390.gitgitgadget@gmail.com>
From: "VALERI Yoann via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 10:43:10 +0000
Subject: [PATCH v4 2/2] branch: add 'branch.namePrefix' config param
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
    Junio C Hamano <gitster@pobox.com>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    VALERI Yoann <yoann.valeri@cea.fr>

From: VALERI Yoann <yoann.valeri@cea.fr>

This patch adds a new configuration parameter for the branch creation
feature: 'branch.namePrefix'. It corresponds to the '--name-prefix'
option of 'git branch' made as configuration parameter, and behaves
exactly like it.

Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
---
 Documentation/config/branch.adoc |  6 ++++++
 builtin/branch.c                 |  5 +++++
 t/t3200-branch.sh                | 15 +++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..392228c300 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -35,6 +35,12 @@ This option defaults to `never`.
 	value of this variable will be used as the default.
 	See linkgit:git-for-each-ref[1] field names for valid values.
 
+`branch.namePrefix`::
+	When a new branch is created with `git branch`, use the provided value as
+	prefix for its name. Can be '@{current}' to use the current branch's name
+	as prefix. This value can be overriden by using the '--[no-]name-prefix'
+	option of `git branch`.
+
 `branch.<name>.remote`::
 	When on branch _<name>_, it tells `git fetch` and `git push`
 	which remote to fetch from or push to.  The remote to push to
diff --git a/builtin/branch.c b/builtin/branch.c
index cf7d095f22..2987ac4122 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -726,6 +726,7 @@ int cmd_branch(int argc,
 	struct ref_format format = REF_FORMAT_INIT;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 	char *name_prefix = NULL;
+	char *safekeep_name_prefix;
 	int ret;
 
 	struct option options[] = {
@@ -809,6 +810,9 @@ int cmd_branch(int argc,
 	else if (!skip_prefix(head, "refs/heads/", &head))
 		die(_("HEAD not found below refs/heads!"));
 
+	repo_config_get_string(the_repository, "branch.namePrefix", &name_prefix);
+	safekeep_name_prefix = name_prefix;
+
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
@@ -1029,6 +1033,7 @@ int cmd_branch(int argc,
 	ret = 0;
 
 out:
+	free(safekeep_name_prefix);
 	string_list_clear(&sorting_options, 0);
 	return ret;
 }
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f81d4380a9..e75f886842 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1741,4 +1741,19 @@ test_expect_success 'create branch with --name-prefix' '
 	git branch -D bn-with-no-prefix
 '
 
+test_expect_success 'create branch with config prefix' '
+	test_config branch.autosetupmerge false &&
+	test_config branch.namePrefix blob &&
+	git branch -- -with-prefix &&
+	test_ref_exists refs/heads/blob-with-prefix &&
+	test_must_fail git branch -- -with-prefix &&
+	test_config branch.namePrefix "@{current}" &&
+	git checkout main &&
+	git branch -- -with-prefix &&
+	test_ref_exists refs/heads/main-with-prefix &&
+	git branch --no-name-prefix branch-with-no-prefix &&
+	test_ref_exists refs/heads/branch-with-no-prefix &&
+	git branch -D blob-with-prefix main-with-prefix branch-with-no-prefix
+'
+
 test_done
-- 
gitgitgadget
