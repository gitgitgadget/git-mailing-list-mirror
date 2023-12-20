Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CDD20B05
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klB4TfQU"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3367f8f8cb0so12920f8f.2
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 02:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703066894; x=1703671694; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNW97VbFgxHtoA9hPCUy5hCn7nLMb/uvdm/hHntqwGw=;
        b=klB4TfQU1UIRNEff3FoURExg0aiAbH+ZJmmQUvLWMMV2SsEarBlvGDjZ4PzS1igQPH
         KQiE+HbZjO+nSuhNXwnZ7CDK/Itj7tp+9Rb6CwyQfoMDI2cQoR4DwbMfLK3nDX4IQyFT
         ONoBewJ78XmVrDc/7kK858O5Y9WzZOt9piAQOQRAwkvmEu6a36vF249q93UjiDsHaNMJ
         dX6SVVm9pOCtlCWTN8lMXACs6svIWAbevsihjslPn/8DEvenoWa85OMLw/+0Edx6RezI
         X2CFtaMzfB9Cj5aNdmMmDOPQH0r4BaUBA/5Wdt7JlbFPOFU9qYmNV96APoyCFr2URvxd
         f48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066894; x=1703671694;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNW97VbFgxHtoA9hPCUy5hCn7nLMb/uvdm/hHntqwGw=;
        b=shhR+EXuNHRfX7ETG4mPsNpPN9Cl4OqyG77fLvQEjl6Le61mXTkNEHiUIvdt+Tw4qr
         BgnoD57izHXHvws2mH65NxzvxcCy1FA2dpeJrSVVEI5Zq6rDEmA9CFJCL3TyibNPcWLi
         QWKTzx8Kj3bOSzh5EC+ZNKFepzDTgBp7le/sSHoXDt0MruRdrkrSavAuo1XH+bC3NosF
         2zlYlNQyx1VdYr7Fsak5SNVqTniF2uHDhfVViMc5mBDYvGTE1RDZu7VD13Ev6Hca264T
         Xm4DXlADfXL7/+upgMly4V/16Qx9pzDKAEEtAn5ri18gMEsUSErdlMl6VN1Gov9RT/x+
         IFDA==
X-Gm-Message-State: AOJu0YyY3vDqMGOWkUb2H4eNpNmPb3wIyl8zmkRTynfouvz7bqAi0qBZ
	6w94IIBZkcGHkdVD9U9XxnmgfZnRZTI=
X-Google-Smtp-Source: AGHT+IGEGD7fBEfxxnpnHQKSzqANMUQYrPMxh0iOLlmyTphDGtCT3t1BuK+d24FCRam7DoRUQkVpQw==
X-Received: by 2002:adf:e80c:0:b0:336:6f8a:2654 with SMTP id o12-20020adfe80c000000b003366f8a2654mr1566429wrm.138.1703066894539;
        Wed, 20 Dec 2023 02:08:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13-20020a056000114d00b00336726bcc8dsm3891043wrx.7.2023.12.20.02.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:08:14 -0800 (PST)
Message-ID: <pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
In-Reply-To: <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com>
References: <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 20 Dec 2023 10:08:13 +0000
Subject: [PATCH v3] Teach git apply to respect core.fileMode settings
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
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

When applying a patch that adds an executable file, git apply
ignores the core.fileMode setting (core.fileMode in git config
specifies whether the executable bit on files in the working tree
should be honored or not) resulting in warnings like:

warning: script.sh has type 100644, expected 100755

even when core.fileMode is set to false, which is undesired. This
is extra true for systems like Windows.

Fix this by inferring the correct file mode from the existing
index entry when core.filemode is set to false. Add a test case
that verifies the change and prevents future regression.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    apply: make git apply respect core.fileMode settings
    
    Regarding this:
    
    > I am wondering if we want to be more strict about hiding error return
    > code from "git ls-files" and "git ls-tree" behind pipes like these.
    > Usually we encourage using a temporary file, e.g., ... git ls-files -s
    > script.sh >ls-files-output && test_grep "^100755" ls-files-output &&
    > ...
    
    I have modified the patch so that the output of git ls-files and git
    ls-tree are stored in a temporary file instead of being directly piped
    to grep but also noticed similar working in other test cases in the same
    test file. For example,
    
    test_expect_success FILEMODE 'same mode (index only)' ' .... .... ....
    git ls-files -s file | grep "^100755"
    
    and
    
    test_expect_success FILEMODE 'mode update (index only)' ' ... ... ...
    git ls-files -s file | grep "^100755"
    
    Would we want to modify these scripts as well so they follow the same
    convention as above or is it okay to let them be as is?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1620%2FChand-ra%2Fdevel-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1620/Chand-ra/devel-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1620

Range-diff vs v2:

 1:  29c8c6d120e ! 1:  9a3623edfd2 Teach git apply to respect core.fileMode settings
     @@ Commit message
          warning: script.sh has type 100644, expected 100755
      
          even when core.fileMode is set to false, which is undesired. This
     -    is extra true for systems like Windows, which don't rely on "lsat()".
     +    is extra true for systems like Windows.
      
          Fix this by inferring the correct file mode from the existing
     -    index entry when core.filemode is set to false. The added
     -    test case helps verify the change and prevents future regression.
     +    index entry when core.filemode is set to false. Add a test case
     +    that verifies the change and prevents future regression.
      
     -    Reviewed-by: Johannes Schindelin <johannes.schindelin@gmail.com>
          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
      
       ## apply.c ##
     @@ t/t4129-apply-samemode.sh: test_expect_success POSIXPERM 'do not use core.shared
       	)
       '
       
     -+test_expect_success 'ensure git apply respects core.fileMode' '
     ++test_expect_success 'git apply respects core.fileMode' '
      +	test_config core.fileMode false &&
      +	echo true >script.sh &&
      +	git add --chmod=+x script.sh &&
     -+	git ls-files -s script.sh | grep "^100755" &&
     ++	git ls-files -s script.sh > ls-files-output &&
     ++	test_grep "^100755" ls-files-output &&
      +	test_tick && git commit -m "Add script" &&
     -+	git ls-tree -r HEAD script.sh | grep "^100755" &&
     ++	git ls-tree -r HEAD script.sh > ls-tree-output &&
     ++	test_grep "^100755" ls-tree-output &&
      +
      +	echo true >>script.sh &&
      +	test_tick && git commit -m "Modify script" script.sh &&
      +	git format-patch -1 --stdout >patch &&
     -+	grep "index.*100755" patch &&
     ++	test_grep "^index.*100755$" patch &&
      +
      +	git switch -c branch HEAD^ &&
      +	git apply --index patch 2>err &&
     -+	! grep "has type 100644, expected 100755" err &&
     -+	git restore -S script.sh && git restore script.sh &&
     ++	test_grep ! "has type 100644, expected 100755" err &&
     ++	git reset --hard &&
      +
      +	git apply patch 2>err &&
     -+	! grep "has type 100644, expected 100755" err &&
     ++	test_grep ! "has type 100644, expected 100755" err &&
      +
      +	git apply --cached patch 2>err &&
     -+	! grep "has type 100644, expected 100755" err
     ++	test_grep ! "has type 100644, expected 100755" err
      +'
      +
       test_done


 apply.c                   |  8 ++++++--
 t/t4129-apply-samemode.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 3d69fec836d..58f26c40413 100644
--- a/apply.c
+++ b/apply.c
@@ -3778,8 +3778,12 @@ static int check_preimage(struct apply_state *state,
 		return error_errno("%s", old_name);
 	}
 
-	if (!state->cached && !previous)
-		st_mode = ce_mode_from_stat(*ce, st->st_mode);
+	if (!state->cached && !previous) {
+		if (!trust_executable_bit)
+			st_mode = *ce ? (*ce)->ce_mode : patch->old_mode;
+		else
+			st_mode = ce_mode_from_stat(*ce, st->st_mode);
+	}
 
 	if (patch->is_new < 0)
 		patch->is_new = 0;
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index e7a7295f1b6..ff0c1602fd5 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -101,4 +101,31 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
 	)
 '
 
+test_expect_success 'git apply respects core.fileMode' '
+	test_config core.fileMode false &&
+	echo true >script.sh &&
+	git add --chmod=+x script.sh &&
+	git ls-files -s script.sh > ls-files-output &&
+	test_grep "^100755" ls-files-output &&
+	test_tick && git commit -m "Add script" &&
+	git ls-tree -r HEAD script.sh > ls-tree-output &&
+	test_grep "^100755" ls-tree-output &&
+
+	echo true >>script.sh &&
+	test_tick && git commit -m "Modify script" script.sh &&
+	git format-patch -1 --stdout >patch &&
+	test_grep "^index.*100755$" patch &&
+
+	git switch -c branch HEAD^ &&
+	git apply --index patch 2>err &&
+	test_grep ! "has type 100644, expected 100755" err &&
+	git reset --hard &&
+
+	git apply patch 2>err &&
+	test_grep ! "has type 100644, expected 100755" err &&
+
+	git apply --cached patch 2>err &&
+	test_grep ! "has type 100644, expected 100755" err
+'
+
 test_done

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
