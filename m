Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1D0C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiF3VT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiF3VTv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72614D163
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so374709wmb.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=MmzucdxnE+bxcFGBDoEmUZB3oC12u7RlBA3TNrXoRR4=;
        b=Ze27xuz7hzmTcvUW1ca3jYXSKeECIvUl386sLovDu0h1qBsRWfLoJTmpR9DTiKH9XP
         tM/pDU69G2ooCBaPr/Y0tTnqNRHWsgQ1vfkwpWXHPIh+6H27/FpIKhUbdWyPu31mb+0D
         5n+xOzs1nmLMpqvtYWvPm+no2e0pJr/TQTKSe7CGQdEwnyQnBREl3MP5omC7+sBTB8v2
         PDyBDyREILA9YjgNqOkZEfwr1pQeTy0oZpaC1AeSBPIcOXAp+qLHy8VJjhqaV2/Ggg1t
         r9OOOldkMoEiYRm/fr5PXFaW61Ahnh35aFoaYvnD0ykBZgosSiIwBsT27hoOYIIvcDQ9
         P/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=MmzucdxnE+bxcFGBDoEmUZB3oC12u7RlBA3TNrXoRR4=;
        b=Jdwv1ZvAds93s2cp9h5vsClH9oZImYwPVtero9KwloQJ4ypPVGhQyNZkaDmB4K2Mwf
         xjozvbzNj8DupCTXu7c4uqCmvWlgUtw/FS2dAKM/CEZk3cP7S59/9AeBnw0YnJdFiygq
         RD7i0TwELuu+CkEiDQ5086tISEZDY6fUVwlfqDb22oXqSfFL+PYOSycTC/DSTEd2doXA
         MTpZYA5PLz3Gg9y+nFKr43IRQoWJ3EwVwgkOpQjror96kOW1fRGU6cpL/LYJjFqC3bRl
         FwAamaaRx8+cUYySoq7miS9V57rFsx4g0T/KXIGR00Bb0D75DZFBzc9xQ6eZoeVM+MMw
         PPBg==
X-Gm-Message-State: AJIora+9DNCOHBX57RUho3cs+adukcP4cZcTABYB6oH0uK6BiISvoRGs
        LJnyXqWhPaBd6kVI5Cn9h921tRZtXYY=
X-Google-Smtp-Source: AGRyM1s6H24xhTzbQsI0BC3gsnUkm3EWkHL0FncEq/Ht0Vctw2JClFnzC8awWFEVavcZ9ns3sIkx1w==
X-Received: by 2002:a05:600c:3b1c:b0:3a1:729a:387a with SMTP id m28-20020a05600c3b1c00b003a1729a387amr10184670wms.183.1656623987102;
        Thu, 30 Jun 2022 14:19:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b0039c99f61e5bsm4391037wmq.5.2022.06.30.14.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:46 -0700 (PDT)
Message-Id: <0d68ee723e54330138450f29e358e5ebe1a47aa0.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:26 +0000
Subject: [PATCH v2 06/18] submodule update: remove "-v" option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

In e84c3cf3dc3 (git-submodule.sh: accept verbose flag in cmd_update to
be non-quiet, 2018-08-14) the "git submodule update" sub-command was
made to understand "-v", but the option was never documented.

The only in-tree user has been this test added in
3ad0401e9e6 (submodule update: silence underlying merge/rebase with
"--quiet", 2020-09-30), it wasn't per-se testing --quiet, but fixing a
bug in e84c3cf3dc3: It used to set "GIT_QUIET=0" instead of unsetting
it on "-v", and thus we'd end up passing "--quiet" to "git
submodule--helper" on "-v", since the "--quiet" option was passed
using the ${parameter:+word} construct.

Furthermore, even if someone had used the "-v" option they'd only be
getting the default output. Our default in both git-submodule.sh and
"git submodule--helper" has been to be "verbose", so the only way this
option could have matter is if it were used as e.g.:

    git submodule --quiet update -v [...]

I.e. to undo the effect of a previous "--quiet" on the command-line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh            | 3 ---
 t/t7406-submodule-update.sh | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5b9683bf766..0df6b0fc974 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,9 +241,6 @@ cmd_update()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
-		-v)
-			unset GIT_QUIET
-			;;
 		--progress)
 			progress=1
 			;;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 43f779d751c..06d804e2131 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1074,7 +1074,7 @@ test_expect_success 'submodule update --quiet passes quietness to merge/rebase'
 	 git submodule update --rebase --quiet >out 2>err &&
 	 test_must_be_empty out &&
 	 test_must_be_empty err &&
-	 git submodule update --rebase -v >out 2>err &&
+	 git submodule update --rebase >out 2>err &&
 	 test_file_not_empty out &&
 	 test_must_be_empty err
 	)
-- 
gitgitgadget

