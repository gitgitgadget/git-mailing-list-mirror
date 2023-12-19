Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960538DF6
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMCqZZ8M"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3365752934bso3939862f8f.2
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 10:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703010647; x=1703615447; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9bwO9f4ZB/EQH0+uYXRhYWOZibfjRHFBez1QImvDBY=;
        b=VMCqZZ8MOcZ7e9TeSMxpOB2Muf6Or8Q7emctu5wTHxfjEI1Ur5eWCMkcUPtQJotps+
         ufVovSFzDPd1WLlSj0oEYqCZcIoLaGmwgbsXgDDZ6Oi1XNbkfe2HHvX6LjH4U+n+TOFH
         ZX2VqEuGjphBABOBRfQnrkFoqFdjmqkRoSPwKOP8UO0WYyrPQ3OTom8z5mbvTicfEe3n
         /xucWpF8lNAbM3Cyln5ydTeCShylFH5NJaYPQzs9d2c3sqY/DH7Ne3OdM5ZWo8OPao/5
         CPod0kZopCTv/8NsLSTRrGMo5wh5ipqzgLOeTurEa6HpVxYKkBHTnT8tifhicmuK+OYT
         S4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703010647; x=1703615447;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9bwO9f4ZB/EQH0+uYXRhYWOZibfjRHFBez1QImvDBY=;
        b=fGgslpUrxEPBi9KazK+nNARNagRXA1DTfW5OFIibIIejbXeyLj62Ting0SZf5kHyqz
         W3CVR+536BUrrJC9bNKHRzPU4S6PNrhW8/LJ/3Qa15TKIOt6R5YSTWU1QfScxTjKRRY+
         QewTV+Q9NQkFkT1qSHHzfZoShjPk9TcE1wtFZG91edfxFnjRIAlcKaIKqdjzx24MucVC
         GAwyyU7VS9CLTfjNuBn2gOZ/a4vGtls+Hfm6avgzy1a67/aF2QWsIzoPloOQP76II7A9
         2Uxa01iJGruEiQhumQQhsS5QezkeD+eHDY3xmwoylWaI7jWcp1KIjw0zJv7oXcJDzXsP
         JezA==
X-Gm-Message-State: AOJu0Yw3u4ksB4aR1AuSLLF7llT6xq6c7LvsxhnOThzbeWpz/GpQGU0O
	cx6zm+FqYC659pLyO5IpsoVyHQgRl0A=
X-Google-Smtp-Source: AGHT+IHBlrLAjZ73LZDm7F8oYUkHVzbJggSSZRt9veG1mjT0TGokpZ98c+fHXe0HRf4nRgvh/UzqJg==
X-Received: by 2002:adf:cd82:0:b0:336:7649:ecee with SMTP id q2-20020adfcd82000000b003367649eceemr508820wrj.132.1703010646901;
        Tue, 19 Dec 2023 10:30:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18-20020adfa2d2000000b003364aa5cc13sm635468wra.1.2023.12.19.10.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:30:46 -0800 (PST)
Message-ID: <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com>
In-Reply-To: <pull.1620.git.1702908568890.gitgitgadget@gmail.com>
References: <pull.1620.git.1702908568890.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Dec 2023 18:30:45 +0000
Subject: [PATCH v2] Teach git apply to respect core.fileMode settings
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
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

When applying a patch that adds an executable file, git apply
ignores the core.fileMode setting (core.fileMode in git config
specifies whether the executable bit on files in the working tree
should be honored or not) resulting in warnings like:

warning: script.sh has type 100644, expected 100755

even when core.fileMode is set to false, which is undesired. This
is extra true for systems like Windows, which don't rely on "lsat()".

Fix this by inferring the correct file mode from the existing
index entry when core.filemode is set to false. The added
test case helps verify the change and prevents future regression.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmail.com>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    apply: make git apply respect core.fileMode settings
    
    Closes issue #1555 on GitHub.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1620%2FChand-ra%2Fdevel-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1620/Chand-ra/devel-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1620

Range-diff vs v1:

 1:  d896351158c ! 1:  29c8c6d120e Teach git apply to respect core.fileMode settings
     @@ Metadata
       ## Commit message ##
          Teach git apply to respect core.fileMode settings
      
     -    CC: Johannes Schindelin <johannes.schindelin@gmail.com>
     +    When applying a patch that adds an executable file, git apply
     +    ignores the core.fileMode setting (core.fileMode in git config
     +    specifies whether the executable bit on files in the working tree
     +    should be honored or not) resulting in warnings like:
     +
     +    warning: script.sh has type 100644, expected 100755
     +
     +    even when core.fileMode is set to false, which is undesired. This
     +    is extra true for systems like Windows, which don't rely on "lsat()".
     +
     +    Fix this by inferring the correct file mode from the existing
     +    index entry when core.filemode is set to false. The added
     +    test case helps verify the change and prevents future regression.
     +
     +    Reviewed-by: Johannes Schindelin <johannes.schindelin@gmail.com>
          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
      
       ## apply.c ##
     @@ apply.c: static int check_preimage(struct apply_state *state,
      -	if (!state->cached && !previous)
      -		st_mode = ce_mode_from_stat(*ce, st->st_mode);
      +	if (!state->cached && !previous) {
     -+		if (!trust_executable_bit && patch->old_mode)
     -+			st_mode = patch->old_mode;
     -+		else st_mode = ce_mode_from_stat(*ce, st->st_mode);
     ++		if (!trust_executable_bit)
     ++			st_mode = *ce ? (*ce)->ce_mode : patch->old_mode;
     ++		else
     ++			st_mode = ce_mode_from_stat(*ce, st->st_mode);
      +	}
       
       	if (patch->is_new < 0)
     @@ t/t4129-apply-samemode.sh: test_expect_success POSIXPERM 'do not use core.shared
       	)
       '
       
     -+test_expect_success FILEMODE 'ensure git apply respects core.fileMode' '
     ++test_expect_success 'ensure git apply respects core.fileMode' '
      +	test_config core.fileMode false &&
      +	echo true >script.sh &&
      +	git add --chmod=+x script.sh &&
     ++	git ls-files -s script.sh | grep "^100755" &&
      +	test_tick && git commit -m "Add script" &&
     ++	git ls-tree -r HEAD script.sh | grep "^100755" &&
      +
      +	echo true >>script.sh &&
      +	test_tick && git commit -m "Modify script" script.sh &&
      +	git format-patch -1 --stdout >patch &&
     ++	grep "index.*100755" patch &&
      +
      +	git switch -c branch HEAD^ &&
     ++	git apply --index patch 2>err &&
     ++	! grep "has type 100644, expected 100755" err &&
     ++	git restore -S script.sh && git restore script.sh &&
     ++
      +	git apply patch 2>err &&
     -+	! test_grep "has type 100644, expected 100755" err
     ++	! grep "has type 100644, expected 100755" err &&
     ++
     ++	git apply --cached patch 2>err &&
     ++	! grep "has type 100644, expected 100755" err
      +'
      +
       test_done


 apply.c                   |  8 ++++++--
 t/t4129-apply-samemode.sh | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

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
index e7a7295f1b6..73fc472b246 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -101,4 +101,29 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
 	)
 '
 
+test_expect_success 'ensure git apply respects core.fileMode' '
+	test_config core.fileMode false &&
+	echo true >script.sh &&
+	git add --chmod=+x script.sh &&
+	git ls-files -s script.sh | grep "^100755" &&
+	test_tick && git commit -m "Add script" &&
+	git ls-tree -r HEAD script.sh | grep "^100755" &&
+
+	echo true >>script.sh &&
+	test_tick && git commit -m "Modify script" script.sh &&
+	git format-patch -1 --stdout >patch &&
+	grep "index.*100755" patch &&
+
+	git switch -c branch HEAD^ &&
+	git apply --index patch 2>err &&
+	! grep "has type 100644, expected 100755" err &&
+	git restore -S script.sh && git restore script.sh &&
+
+	git apply patch 2>err &&
+	! grep "has type 100644, expected 100755" err &&
+
+	git apply --cached patch 2>err &&
+	! grep "has type 100644, expected 100755" err
+'
+
 test_done

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
