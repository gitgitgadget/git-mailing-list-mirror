Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4F3C25B0F
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbiHLUK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiHLUKg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:10:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D26EE20
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso1002973wmb.2
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=7GCnYaiyaqpfB+KodketEyI+zYP82WFm71eckKhZD9k=;
        b=ObCWl7jCBp5m/scVOeTaT9pFtjASZjMC47B/S+gO98u8jQsYAy0ZQr5gNDGUBkk1BY
         D+5qrXu+3iB0wOlS18+iXyK6h7XJCFfV9Oq9NJEA6WWlVu7UoaARYwhewFmtX1P7z9EO
         av4geDfOzQgQIKmwASHbyi4TPl43N/V1Kwp952d+xJszwp2j3dyam1nwlBv8+5I+DHsH
         v7AqmxdtP+GXrXIN4KGD5VJDPpSSdhPuHxwxMf4js4ac4YOB519WNm4lBYH063ECj3sE
         /6RwS1YcOm4fzZKKNQKFv1K3d8Ty6lpyirPzO0VbdY2extF0RSpKwP/MISzWGGn/uxrV
         Pejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=7GCnYaiyaqpfB+KodketEyI+zYP82WFm71eckKhZD9k=;
        b=jUH7pVpJ1dlSNAOtea1x/H82pdXATQiKe09gW+Wf6mrOq2Msw79ElChfqqUT4kQg9t
         SyLxaHGNJIlzqU5FzjETfr6uZFZ6a4m7abvH3R/4lpMGsw6/sfWrQZl+MY4LTMAg1owJ
         wN9gKG+0DNgDRg/uunB+l9Iv1sG9DiXrBwU4UI97nkMrTXU6aFmhtqMELiRD0nqEmuaR
         Tikdsc4eeG20xVm05OcGsqB2jQPhX+wB98tbKiNitOYb1DxNUjvtqa8X0pUPx4adGL7M
         W2WU7aNTDvxE8yMMM+8e2aYaAWA2547CriLuLUv0mbQCqTV5LLZPXOzWjQIBh7US/4PQ
         TuLg==
X-Gm-Message-State: ACgBeo0AdF/QJPQjgSWHlyUVh+XS1k4MCbRdgNvoxUz+v4JCRFcMHgnX
        YZnuk0WO2stDqqGfw9WRHv/DG9gSyvs=
X-Google-Smtp-Source: AA6agR7xMpn5Wagw0ojJR3h/NHHx2Is5507BAPvMaO+FgFWZ/nFI2Ly3xK90zNXmggxgGaSnkgFrPQ==
X-Received: by 2002:a7b:ce10:0:b0:3a5:3f91:e2fb with SMTP id m16-20020a7bce10000000b003a53f91e2fbmr10104137wmc.138.1660335030951;
        Fri, 12 Aug 2022 13:10:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c384900b003a53731f273sm530488wmr.31.2022.08.12.13.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:10:30 -0700 (PDT)
Message-Id: <94b32eacdd565df665c40bc49929c128b93cc626.1660335019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 20:10:18 +0000
Subject: [PATCH v4 10/11] scalar-diagnose: use 'git diagnose --mode=all'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Replace implementation of 'scalar diagnose' with an internal invocation of
'git diagnose --mode=all'. This simplifies the implementation of
'cmd_diagnose' by making it a direct alias of 'git diagnose' and removes
some code in 'scalar.c' that is duplicated in 'builtin/diagnose.c'. The
simplicity of the alias also sets up a clean deprecation path for 'scalar
diagnose' (in favor of 'git diagnose'), if that is desired in the future.

This introduces one minor change to the output of 'scalar diagnose', which
is that the prefix of the created zip archive is changed from 'scalar_' to
'git-diagnostics-'.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index d538b8b8f14..68571ce195f 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -11,7 +11,6 @@
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
-#include "diagnose.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -510,34 +509,19 @@ static int cmd_diagnose(int argc, const char **argv)
 		N_("scalar diagnose [<enlistment>]"),
 		NULL
 	};
-	struct strbuf zip_path = STRBUF_INIT;
-	time_t now = time(NULL);
-	struct tm tm;
+	struct strbuf diagnostics_root = STRBUF_INIT;
 	int res = 0;
 
 	argc = parse_options(argc, argv, NULL, options,
 			     usage, 0);
 
-	setup_enlistment_directory(argc, argv, usage, options, &zip_path);
-
-	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
-	strbuf_addftime(&zip_path,
-			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
-	strbuf_addstr(&zip_path, ".zip");
-	switch (safe_create_leading_directories(zip_path.buf)) {
-	case SCLD_EXISTS:
-	case SCLD_OK:
-		break;
-	default:
-		error_errno(_("could not create directory for '%s'"),
-			    zip_path.buf);
-		goto diagnose_cleanup;
-	}
+	setup_enlistment_directory(argc, argv, usage, options, &diagnostics_root);
+	strbuf_addstr(&diagnostics_root, "/.scalarDiagnostics");
 
-	res = create_diagnostics_archive(&zip_path, DIAGNOSE_ALL);
+	res = run_git("diagnose", "--mode=all", "-s", "%Y%m%d_%H%M%S",
+		      "-o", diagnostics_root.buf, NULL);
 
-diagnose_cleanup:
-	strbuf_release(&zip_path);
+	strbuf_release(&diagnostics_root);
 	return res;
 }
 
-- 
gitgitgadget

