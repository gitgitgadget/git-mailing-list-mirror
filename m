Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C0309EEB
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405389; cv=none; b=SCcP8KIP3Vj1qyujYT2D4rPY3aI7Wvh5oSPr79Xauc+kUnadC9auN3VJSkJoRW9Sfkr4jNrBKhJCW7VWrrBSgamxbgUpuKqBBauwkJXUge/whBbmTPufncxe6sz20G1a8VsnUZFHUa7TSTnW0GyTElXvCGl7S/vJoLuNZZt0N40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405389; c=relaxed/simple;
	bh=vzyOeqSY4aR3wnzFUnx/pLd7zvOVFg3y+u8X32k2jms=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bERALVKIwsdrhczVwyPdhxztzFxZtm+1XbECwrUWraGNEESDEOqx50Cu3pkdzJ9x0gW7cuMQGD6jL4BAOPtmWNUp6BOOqYp641K7Jwf0syQ0Yh2bWLCIQ4pyq6T0x8d2cW6OlDV0W6Spzhkvp0hGnLn9f/LQMDyOL67dV+J5gjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO750TA0; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO750TA0"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b7381d2d95so1231637eec.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 11:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770405388; x=1771010188; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jr5ip84xwXoPIRjYSzUDEPY7EqA6VkIRpr79Q67wejg=;
        b=nO750TA0X7x4cA9ZyGtNfxdqdRHuumOheXq6/+k5EPB4ta0jaHlJTWzYDif4lUDj1y
         OLaUkIl60Y90HawENXNs1qAfe7JH/3841XuTiFMTHmkprzVwApkJOddh2w4mnw31Vg0o
         9aJYWvqTpa9kw/cb205o6Q6OC5A3/5eJCPJuBF6QdHgtN7yr7eSUQvWQ1SeIQNe2Y9/S
         aXlZmgr5bZy8uae/lhGIoXD8LYvHPaZO5uebsLKHTRgISaCDiu3qRdC6qNaodV7FRofX
         AeFR3iSeAgrXbMt+Zt6lmfsH8RZm6KLouI+NY5ybDJmQC8DDvlqoBThYoltjRRAyamwX
         sd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405388; x=1771010188;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jr5ip84xwXoPIRjYSzUDEPY7EqA6VkIRpr79Q67wejg=;
        b=YR2W8360evC2OcwFQeJJSi6SY2N2mfBkyfU4G+j193MZViqUtduJXf/N1VZy8dITTE
         2ihueb67AcdfOqmkMvnqC+iduyvovBNgaxAWdTE2vQSgCMgUOO5MUl5FWxMfHcXgHEe9
         4EnNQ1Ll8vjVFrx2JYYG6w6Hpu4LbRVAr2B/fCw36s9ZiKFIVBS5EL9xS9KwkXlFn6kM
         ENKPoEBhTzinW5BHlUdWqHA9fkgfcS0/1/HhJyUPy+wgHoXDZNo35EvvcRz1ULALveTs
         WPDPa+Vu0bhMW0wq1btey7edjEp18VqP2qgQzqLB2rXEp3ggugEIethsozfY84738p2i
         FpEQ==
X-Gm-Message-State: AOJu0Yx5I8RpGZoVFWfqqgK4XiCy9/X8Ydz9r5GdAeZSzdUs10PrPLOV
	SIN5VQ7esM1hiMXifydGu0TGmSGyooMMA+q9k5+WIN9DLpP3d8K9D81yKgIxmQ==
X-Gm-Gg: AZuq6aLVAaoVzzqS0RulMGikbL5Vc5BctxLhD9dnL23tiTLvD5/1+m1swFYbjMaeE+E
	0nebFHtXAm61Z5f2DFqpsnuvMR7ZugXfzWDG1rU59ddG6b4qA29Az3wdqHawgY1VlW5DdYeU7fX
	KJ+zh6l2WuErv7CORhC+DK1sqvA5SCKmBjMgTelcZIUAv2MFyf+oxgSxxvcRWuWqrJ04o7r2oFO
	fWoMvq/xdrmTyC/+kczxg5o8kPjWDx9p070Z/u4y8aa+MKZu1aShUeyl3tiErvtn48VPR057Pus
	AxbhIiDzOIhHyFw44heDtbCV30FyS6IlF9Rapdyb8Xh8tjEslraEMESkoYcryUi8yJnB1qYZwlt
	mnpcJzW+13YY6m6ZrDBPeYONQ2Ear08OWi+Iluz3PhcPeglXOIvvqbDFy94n/NW8SFIISp+pUPj
	k9ZIQPMjCMNrprlkhb5vnXMEnW
X-Received: by 2002:a05:7300:dc97:b0:2b7:1e6b:9805 with SMTP id 5a478bee46e88-2b845c6dcbcmr2941684eec.14.1770405387917;
        Fri, 06 Feb 2026 11:16:27 -0800 (PST)
Received: from [127.0.0.1] ([172.182.209.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855ad8da2sm2626271eec.5.2026.02.06.11.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:16:27 -0800 (PST)
Message-Id: <55d39ff778b7156d1a1abba4ccc3ea41ae680d2f.1770405383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2189.v2.git.git.1770405383.gitgitgadget@gmail.com>
References: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
	<pull.2189.v2.git.git.1770405383.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 19:16:23 +0000
Subject: [PATCH v2 2/2] merge-ours: integrate with sparse-index
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
    Sam Bostock <sam@sambostock.ca>,
    Sam Bostock <sam@sambostock.ca>

From: Sam Bostock <sam@sambostock.ca>

The merge-ours built-in opens the index to compare it against HEAD.
The machinery used to do this (i.e. run_diff_index()) is capable of
working with a sparse index, but the start-up sequence of this
command does not take the necessary steps, so we end up expanding the
index fully before doing the comparison.

In order to convince sparse-index.c:is_sparse_index_allowed() to
return true, we need to:

 - Read basic configuration with git_default_config so that global
   variables like core_apply_sparse_checkout are populated.
   merge-ours currently does not read configuration at all.

 - Set command_requires_full_index to 0.

With that, the command can work without expanding the index fully
before doing its work.

Signed-off-by: Sam Bostock <sam@sambostock.ca>
---
 builtin/merge-ours.c                     |  6 ++++++
 t/t1092-sparse-checkout-compatibility.sh | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 2312e58ab3..405b2989f7 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -10,6 +10,8 @@
 
 #include "git-compat-util.h"
 #include "builtin.h"
+#include "config.h"
+#include "environment.h"
 #include "diff.h"
 
 static const char builtin_merge_ours_usage[] =
@@ -22,6 +24,10 @@ int cmd_merge_ours(int argc,
 {
 	show_usage_if_asked(argc, argv, builtin_merge_ours_usage);
 
+	repo_config(repo, git_default_config, NULL);
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
+
 	/*
 	 * The contents of the current index becomes the tree we
 	 * commit.  The index must match HEAD, or this merge cannot go
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index b0f691c151..d98cb4ac11 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2559,4 +2559,18 @@ test_expect_success 'cat-file --batch' '
 	ensure_expanded cat-file --batch <in
 '
 
+test_expect_success 'merge -s ours' '
+	init_repos &&
+
+	test_all_match git rev-parse HEAD^{tree} &&
+	test_all_match git merge -s ours merge-right &&
+	test_all_match git rev-parse HEAD^{tree} &&
+	test_all_match git rev-parse HEAD^2
+'
+
+test_expect_success 'sparse-index is not expanded: merge-ours' '
+	init_repos &&
+	ensure_not_expanded merge -s ours merge-right
+'
+
 test_done
-- 
gitgitgadget
