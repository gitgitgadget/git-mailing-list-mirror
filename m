Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ACCC41535
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 05:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453894AbiDFFG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 01:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587842AbiDFAKe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 20:10:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50F7C6279
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 15:35:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d29so551591wra.10
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 15:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2F38Oa4d8OKw43i/RePxE8AGUSzTx4W5BJUncoWI7Y4=;
        b=B/Y/CY7M/XtHsKHiW/t2zgNZ3y2GqhJMgR82Eeh6z7Hovmw2jfgzDIy6JCpoT4CZip
         UIb2rthu7arFFfgxoNt7tU9w6l89Jgkc2HZkrs1kL5wqNxZChp+I0l+rDSQWX/3ll252
         R/FBnZrqrhjnJQAuFwapPSiIuoLRVH4hG8AVsT9mh9U6b7gkBZT2HX36/hpDboZFQUlV
         mi0FIgJ7VOU8MVFuDo+RFtGjMqECIbi4zobKiPRvYMBdUC/n3i0cGDWihLWZ7Lv6qFn+
         ptKBkWQkPoSFghlu4Zl5EpNrMHkhj2+9FGjMkDuE16GOP7WinEzX7XqSNxHQgX4/BGDn
         5jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2F38Oa4d8OKw43i/RePxE8AGUSzTx4W5BJUncoWI7Y4=;
        b=O1d423BelAhyKnfOjYfVU2cOm4fJqyWp57I11aJMNy7AFnsPlBph3XKtYwCRWl3385
         od/7p8FWoNCn1tF3TUksBSj7rVWgP31F4iHa51j+05nirOMcV+gks0O7lesnUIOnz1fS
         PAuCtLoLfn/oToyJ4yONIF2zhRhoWtHd8k/AB2UNIa7LIaIoe0/lALEsVr/sPYT8kML7
         SyoJLNmhN67h3Ubn5e5vb3YYv6FEIXovtz/qtWUkDqq4SOKQDRDuLKnhlEyKQDT2M8z+
         FeAHeMbFig085IZBC6hCfAfv0S1Jv7LTpeC67xfefAU42/fWmJR5FypsUCNuC/7wz5qU
         fwmw==
X-Gm-Message-State: AOAM530vrUTb4kA/k773mkhtF4hguniu83KE7OhaV5nB4iSGLclXGAhR
        94mBKCcBRmHd7MwIcoXGA1vSiHJi0TM=
X-Google-Smtp-Source: ABdhPJyNg49zf2arOchGgJPA1RAJuq/vmwV03phm2ublwTEcEelNh7dCgLgcw+AHSsoH/+3rbHXKyQ==
X-Received: by 2002:a05:6000:10c7:b0:206:135e:c84e with SMTP id b7-20020a05600010c700b00206135ec84emr4149394wrx.12.1649198137783;
        Tue, 05 Apr 2022 15:35:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b0038e785baac7sm3206431wme.11.2022.04.05.15.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 15:35:37 -0700 (PDT)
Message-Id: <pull.1205.git.1649198136190.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Apr 2022 22:35:36 +0000
Subject: [PATCH] contrib/scalar: fix 'all' target in Makefile
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add extra ':' to second 'all' target definition to allow 'scalar' to build.
Without this fix, the 'all:' and 'all::' targets together cause a build
failure when 'scalar' build is enabled with 'INCLUDE_SCALAR':

    Makefile:14: *** target file `all' has both : and :: entries.  Stop.

Signed-off-by: Victoria Dye <vdye@github.com>
---
    contrib/scalar: fix 'all' target in Makefile
    
    This patch fixes an issue introduced in a36b575aab (scalar Makefile: use
    "The default target of..." pattern, 2022-03-03) in which an 'all::'
    target was added without converting the existing 'all:' (single-colon)
    target into an 'all::' (double-colon) target. This causes a build error,
    but only when compiling with 'INCLUDE_SCALAR' enabled. As a result, I
    only just found it when building 'scalar' on the 'microsoft/git' fork.
    
    Although 'INCLUDE_SCALAR' isn't enabled by default, we should fix the
    build error for anyone that may intentionally build with it. If
    possible, it would be nice to have this merged before the final v2.36.0
    so that users don't run into the error in the next release.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1205%2Fvdye%2Fbugfix%2Fscalar-all-target-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1205/vdye/bugfix/scalar-all-target-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1205

 contrib/scalar/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index 5e86d78e19b..37f283f35d7 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -11,7 +11,7 @@ include ../../config.mak.uname
 TARGETS = scalar$(X) scalar.o
 GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
 
-all: scalar$(X) ../../bin-wrappers/scalar
+all:: scalar$(X) ../../bin-wrappers/scalar
 
 $(GITLIBS):
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)

base-commit: faa21c10d44184f616d391c158dcbb13b9c72ef3
-- 
gitgitgadget
