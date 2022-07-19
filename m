Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C67CCA47F
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbiGSVGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbiGSVFv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:05:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7547348E9C
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r2so22386925wrs.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YSEn6FXFbQ5rjUltsoOFS0T6mDbH0jNk5ov1/wY/Ak=;
        b=bMqLhKDzigXSITFVNREUi1U3Wu2R1O9Gffl8NoPmaNhv7S6kmOfQH0Q7EfTW13inlA
         jS+RkDaGEQy5RqAwhbFrWbaU9DXXJ0Eo2gNNtbhOEpa1LlFG2YU7771lSf9mXQKZIImj
         KLbb2o4/QGjEXbMw3623w6r3OzlnwtOrJbktJziOK+55e03onjWhr93WIiZ7q8FXdwLF
         Ieza0roLy5c5kYXAlF6xLp+z/LPEVKx22WbXZwc/KIDI/3cQLJ3Ghh/51mZEpZVHs6ak
         SvFsj21NM0S2JLtWmpO8hT+vYX8X6SyMK2HDykEPP3km4XYQ+F0iFMLxpYFxbwTUtCz1
         jldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YSEn6FXFbQ5rjUltsoOFS0T6mDbH0jNk5ov1/wY/Ak=;
        b=u4zshTceMglNka/FwPDH8ZiNbtepcjvjQW3tWJBWAyPh4zfQvNGFs+mhHql2R0o5LN
         iELs6+offaZgs9rPZBKT0RqhBf0Zsi8Glj5q2SmGxjyqxTZiLz+SGs3EsLkrA29WLscd
         egI69hVE9YY4P5MXY3/eMisI/BHd2/5ixQs4b53ZUVee4sm5y51mFdgfkI9E+rqMHGgQ
         62BCUXjGjrsDieZQCUsO766KJEndI0nbv0uJRLR1MUCQ5TyjzvQ/W8ZCOuYVO+2J/Pe7
         hf/ysh6XYv+TFCM8x5bSFCUyaMhYggROyBRcAS/BUGun3LUY05qiNJ388Xufkc6uBZdx
         UAKQ==
X-Gm-Message-State: AJIora+UKZMs9OWCZjSrYjaiGdBHwpjQKecruEt9dJkPbKvTQyJNxwAA
        bDDsvu/KugTPhRug7x+I7sK5xjUeFf6Bmw==
X-Google-Smtp-Source: AGRyM1tmkMT7Ts/39b216eKwk7LLtcpRAe3cweLpny9DDmf/+XxREoLmviGfQ8k4Fua5A/vKjur3bA==
X-Received: by 2002:a05:6000:178e:b0:21d:a21a:ccab with SMTP id e14-20020a056000178e00b0021da21accabmr27631728wrg.559.1658264742755;
        Tue, 19 Jul 2022 14:05:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c461800b003a050a391e8sm75091wmo.38.2022.07.19.14.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:05:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/10] log tests: don't use "exit 1" outside a sub-shell
Date:   Tue, 19 Jul 2022 23:05:24 +0200
Message-Id: <patch-10.10-9cedf0cb0e2-20220719T205710Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1063.gd87c5b8cc23
In-Reply-To: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an "exit 1" added in ac52d9410e5 (t4205: cover `git log
--reflog -z` blindspot, 2019-11-19) to use "return 1" instead, which
curiously was done in an adjacent test case added in the same commit.

Using "exit 1" outside a sub-shell will cause the test framework
itself to exit on failure, which isn't what we want to do here.

This issue was spotted with the new
"GIT_TEST_PASSING_SANITIZE_LEAK=check" mode, i.e. that "git show"
command leaks memory, and we'd thus "exit 1". Another implementation
of "GIT_TEST_PASSING_SANITIZE_LEAK=check" or "--invert-exit-code"
might have intercepted the "exit 1", and thus hidden the underlying
issue here, but we correctly distinguish the two.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e448ef2928a..0404491d6ee 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -156,7 +156,7 @@ test_expect_success 'NUL termination with --reflog --pretty=oneline' '
 	for r in $revs
 	do
 		git show -s --pretty=oneline "$r" >raw &&
-		cat raw | lf_to_nul || exit 1
+		cat raw | lf_to_nul || return 1
 	done >expect &&
 	# the trailing NUL is already produced so we do not need to
 	# output another one
-- 
2.37.1.1062.g385eac7fccf

