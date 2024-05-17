Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE14387
	for <git@vger.kernel.org>; Fri, 17 May 2024 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715920867; cv=none; b=g/ePtOxQGiGsFLBhlHfnkjAhpbc1Dgesf3PygxOM1rlTH75sdTfDRA27QQ3PZJQZexctNpnFwxqqNkFn623tX/80q9iWo8Rrij4+Zlt1mOvk1VVHnr2bjpMb3lkoal1dCxldqiyYvZRV/t7Ph0XGH/hNCSP6DgxKLCF4IW6AZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715920867; c=relaxed/simple;
	bh=9VFPQI3NVBQ7j3kKBRTvr+Mh0cnFTnsgO/KWm2ll1fc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b16Tt3oW27M/iEQ3uVDyN1zHnvFgo7TUQN+TH4kRicOve9GkEUagHP/KcefxwbBV5FjOQP+5gPV+1zeWm0zL7FWFh2D0D7walkDNKEfHtwVk4IdLl49BM2gxtlkX4diwvSzXhGMTY4rtZ2kZaLCwDXFrxon4dspRIvuPmhzENNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWfApELK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWfApELK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4202c0d316cso7799815e9.1
        for <git@vger.kernel.org>; Thu, 16 May 2024 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715920864; x=1716525664; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPlmyDIT2PzNiu7I5O9SqV0wV/TGxH+A9MjTRG0xeV4=;
        b=XWfApELKyVHUe9tEdttOPgfnVlJhvQVj5uMTd/ukpCQifXrcX8c358REnsON9QFBtI
         /AMJifhVXYGDs/hQqsnrwaS4/a0Q3enIHlxWNqh8b1GxVUK+wzFEnrH6DM3dT8q9YobW
         nyePoV+DWrrUc85192xGWL7nzC0rEjd8f7sqw6MBBPoKNX6ZxBX5ABlxfih4oc9KbXVA
         I+qxEcS+H/qG1Ui2BVyIw+Su+S5IYOLc5gCpmOarYD0uI98Ls+3mTyfBukBWfWiX1fb8
         kvp5aujP8n/t3skLGKEGAYB85/VCTtTUPy6jmSqcUS2bMFfU/TQq+mkbBC26sZTF73VO
         qDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715920864; x=1716525664;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPlmyDIT2PzNiu7I5O9SqV0wV/TGxH+A9MjTRG0xeV4=;
        b=PMH9ujaNmND22MXkFQJA7NpRPaCucEP3L62Al2qEz+CCjfCuExwklyV8IdIU6I5x5Q
         57ZTwa+kD2ti/m/wQn9uNeEBrusM6qJWVPLs8LHEmKZAahr49wK7+xnVFLC2+pPUx4A8
         PyBwMsGzCahFWhrV4V0sGqu0KpMu3EXnzQ4goy6TX/IK666VswZIFDKvDLeO8nXGYw6k
         cHA+bal5qJECgY1puYBDFaSJuYdzJt2IP3KSjBfeTp+6tqC1+JawjJgWyQqok5kxcPqR
         vjGSxjcoCQWOSWl+emEVRhtLp1wiY2oQ0X1D0wLfxK83EuSH7gKWNzZJLi1+iXCuDOvB
         SMuQ==
X-Gm-Message-State: AOJu0Yz2LRsUWWvjd7yQYUJpOV7vSfq2fI11d+CSNpX6dYxBc+53Pi6z
	8W8fZ3tepwd1Kkcnby0htTYtvbk9CLVNeAiNPSNhZr+j31LyGhpaG0IpVQ==
X-Google-Smtp-Source: AGHT+IEDpPCx/hHLsrXnsu9bGULF0dbzSH5Sv4vkHJTFT9C5GCP4WEZx+2wcOlqfret4ZP8AUfXS5A==
X-Received: by 2002:a05:600c:444b:b0:418:bdcd:e59b with SMTP id 5b1f17b1804b1-41fbca38144mr230302935e9.7.1715920863820;
        Thu, 16 May 2024 21:41:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d20488sm325987195e9.25.2024.05.16.21.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 21:41:03 -0700 (PDT)
Message-Id: <pull.1731.v4.git.1715920862420.gitgitgadget@gmail.com>
In-Reply-To: <pull.1731.v3.git.1715917639587.gitgitgadget@gmail.com>
References: <pull.1731.v3.git.1715917639587.gitgitgadget@gmail.com>
From: "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 04:41:02 +0000
Subject: [PATCH v4] merge: avoid write merge state when unable to write index
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
Cc: Kyle Zhao <kylezhao@tencent.com>,
    Kyle Zhao <kylezhao@tencent.com>

From: Kyle Zhao <kylezhao@tencent.com>

When running a merge while the index is locked (presumably by another
process), the merge state is written, the index is not updated, and then
the merge fails. This might cause unexpected results.

i.g. if another running process is "git commit", MERGE_HEAD and other state
files we write on our side will be taken into account by them and cause them
to record a merge, even though they may have been trying to record something
entirely different.

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
    merge: avoid write merge state when unable to write index
    
    In some of our monorepos, code is sometimes lost after merging.
    
    After investigation, we discovered the problem.
    
    This happens if we perform "git pull" or "git merge" when another git
    process is writing to the index, especially in a monorepo (because its
    index will be larger).
    
    How to reproduce:
    
    git init demo
    cd demo
    touch 1.txt && git add . && git commit -m "1"
    git checkout -b source-branch
    touch 2.txt && git add . && git commit -m "2"
    git checkout master
    echo "1" >> 1.txt && git add . && git commit -m "3"
    # another git process runnning
    touch .git/index.lock
    git merge source-branch
    # another git process finished
    rm .git/index.lock
    git commit -m "4"
    
    
    Then the modifications from the source branch are lost.
    
    Regards, Kyle

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1731%2Fkeyu98%2Fkz%2Ffix-merge-when-index-lock-exists-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1731/keyu98/kz/fix-merge-when-index-lock-exists-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1731

Range-diff vs v3:

 1:  138fe0a054d ! 1:  7055dfb82c7 merge: avoid write merge state when unable to write index
     @@ Commit message
      
          When running a merge while the index is locked (presumably by another
          process), the merge state is written, the index is not updated, and then
     -    the merge fails. This can cause unexpected results.
     +    the merge fails. This might cause unexpected results.
      
          i.g. if another running process is "git commit", MERGE_HEAD and other state
          files we write on our side will be taken into account by them and cause them
     @@ t/t7600-merge.sh: test_expect_success 'merge c1 with c2' '
      +test_expect_success 'merge c1 with c2 when index.lock exists' '
      +	test_when_finished rm .git/index.lock &&
      +	git reset --hard c1 &&
     -+	: >.git/index.lock &&
     ++	>.git/index.lock &&
      +	test_must_fail git merge c2 &&
      +	test_path_is_missing .git/MERGE_HEAD &&
      +	test_path_is_missing .git/MERGE_MODE &&


 builtin/merge.c  |  2 +-
 t/t7600-merge.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6a6d3798858..12c1b048fe1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -699,7 +699,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
 					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
 					 NULL) < 0)
-		return error(_("Unable to write index."));
+		die(_("Unable to write index."));
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
 	    !strcmp(strategy, "ort")) {
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e5ff073099a..ef54cff4faa 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -236,6 +236,16 @@ test_expect_success 'merge c1 with c2' '
 	verify_parents $c1 $c2
 '
 
+test_expect_success 'merge c1 with c2 when index.lock exists' '
+	test_when_finished rm .git/index.lock &&
+	git reset --hard c1 &&
+	>.git/index.lock &&
+	test_must_fail git merge c2 &&
+	test_path_is_missing .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_MODE &&
+	test_path_is_missing .git/MERGE_MSG
+'
+
 test_expect_success 'merge --squash c3 with c7' '
 	git reset --hard c3 &&
 	test_must_fail git merge --squash c7 &&

base-commit: 19fe900cfce8096b7645ec9611a0b981f6bbd154
-- 
gitgitgadget
