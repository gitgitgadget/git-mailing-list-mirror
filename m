Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA21D122
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwdFImmR"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c6a71e88cso38514205e9.0
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 06:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702908570; x=1703513370; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jSQOpKa2EVsieMqqYA2z//r2z5RYXT0k+l3Ytpao5s0=;
        b=SwdFImmRxGcV/pIRcjKoMzVTxKdB6LythCy6tdK/SIBpqvQqEF5bq/tPC0kGgnrOQ0
         Oe57SWcoRlrNyZZ414VeWHQQo7GYLUic37FGgZz9BxWcjAjDKIUme8b1dqDPZFR2e/cg
         K4n9OYvn9W5A8/CmLfk6gRsmI5l53jbjMUaOOvK4Legg/WC3YPbU90mvxGev4GDsGQJL
         Nyd11uF83xyQXPtYYpGlBwB8E8XVFOobRwtoR+LtWx3NTY9oUAOiM7a2FRHQnDCsI5hn
         H+eMpNDmp/7IUCHOJvKicYGipqfTJuwzjRr7v7Sf1abZGpq0CtnwTXK6fQqi+olJ+57T
         SdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908570; x=1703513370;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSQOpKa2EVsieMqqYA2z//r2z5RYXT0k+l3Ytpao5s0=;
        b=XcijF2tlwSuVxFHct8SasK2gzj+mvV1TE5vmIL25sBh+LU3icRbk5a2l7x36vicggk
         pMbb50Tvq+ghGG3mSIDrMBGmP4CUA4up3FKLXk4XQGUikJgppgUhNpLpI+k482iNeurk
         TlehcG7M+DAtmqjxTFxulBSIcJdg6hPgz4e9HysrYif86lrz9vJkChBWQcLlrh/ZJquR
         3Rhb1ZjYTRRMTa9qmQXYlqzn5H7iOPR7IRH0hakaV/hVomDzNC2/zp0F6/D7ofOV3hKL
         FWI5zWd3lJw8WUcH+1e6PsncBJgfz0BuVmFzJD2gfUgap2uxTxNeSUJFyPk+8V4IGBkX
         INlA==
X-Gm-Message-State: AOJu0YwqcRMgbLtneIBxYByPSuZ7IPkBE2D0UARNVbFNZwG5KxkI81R0
	I85a0p0TkLLJR25VdSFwrwwMkzDbebc=
X-Google-Smtp-Source: AGHT+IFwN+SgzmfdFO7/0IMTPEnUERCkqHiFlaWeqEMQfHD5i0tSfqyR1OKQHjxUXfH7j8fkMxN4WA==
X-Received: by 2002:a05:600c:3b26:b0:40c:224a:4450 with SMTP id m38-20020a05600c3b2600b0040c224a4450mr8787157wms.37.1702908570196;
        Mon, 18 Dec 2023 06:09:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d4e50000000b0033660fe128fsm5586922wrt.43.2023.12.18.06.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:09:29 -0800 (PST)
Message-ID: <pull.1620.git.1702908568890.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 Dec 2023 14:09:28 +0000
Subject: [PATCH] Teach git apply to respect core.fileMode settings
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

CC: Johannes Schindelin <johannes.schindelin@gmail.com>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    apply: make git apply respect core.fileMode settings
    
    When applying a patch that adds an executable file, git apply ignores
    the core.fileMode setting (core.fileMode in git config specifies whether
    the executable bit on files in the working tree
    should be honored or not) resulting in warnings like:
    
    warning: script.sh has type 100644, expected 100755
    
    even when core.fileMode is set to false, which is undesired. This is
    extra true for systems like Windows which don't rely on lsat().
    
    Fix this by inferring the correct file mode from the existing index
    entry when core.filemode is set to false. The added test case helps
    verify the change and prevents future regression.
    
    Reviewed-by: Johannes Schindelin johannes.schindelin@gmail.com
    Signed-off-by: Chandra Pratap chandrapratap3519@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1620%2FChand-ra%2Fdevel-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1620/Chand-ra/devel-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1620

 apply.c                   |  7 +++++--
 t/t4129-apply-samemode.sh | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 3d69fec836d..56790f515e0 100644
--- a/apply.c
+++ b/apply.c
@@ -3778,8 +3778,11 @@ static int check_preimage(struct apply_state *state,
 		return error_errno("%s", old_name);
 	}
 
-	if (!state->cached && !previous)
-		st_mode = ce_mode_from_stat(*ce, st->st_mode);
+	if (!state->cached && !previous) {
+		if (!trust_executable_bit && patch->old_mode)
+			st_mode = patch->old_mode;
+		else st_mode = ce_mode_from_stat(*ce, st->st_mode);
+	}
 
 	if (patch->is_new < 0)
 		patch->is_new = 0;
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index e7a7295f1b6..95917fee128 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -101,4 +101,19 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
 	)
 '
 
+test_expect_success FILEMODE 'ensure git apply respects core.fileMode' '
+	test_config core.fileMode false &&
+	echo true >script.sh &&
+	git add --chmod=+x script.sh &&
+	test_tick && git commit -m "Add script" &&
+
+	echo true >>script.sh &&
+	test_tick && git commit -m "Modify script" script.sh &&
+	git format-patch -1 --stdout >patch &&
+
+	git switch -c branch HEAD^ &&
+	git apply patch 2>err &&
+	! test_grep "has type 100644, expected 100755" err
+'
+
 test_done

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
-- 
gitgitgadget
