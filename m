Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD3FC77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 13:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjFGNpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 09:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbjFGNox (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 09:44:53 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBE31993
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 06:44:52 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565ee3d14c2so82131617b3.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686145490; x=1688737490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhXmptONXfKQG4/azc/n5esg6bpY2sbIHHxi+gxlcSU=;
        b=T6EZDisfnDBs3i/T/ZeQeGwuFkkU9/neeydzjoadqcTTmCDOWf3DmHoPEGkxWTo81t
         zjRuGabvmSpJDb5HDlai76GdEH+lJY4ulJuzGwj2nABIPaUTU4sZUSG0BCXevJTR453K
         GJK/fFlLk7+wfyxi4JByI1d4v1DhIB2/I1d/V0kWUyxRt12egbz63wAn80UzBWMyp1ER
         XByabGgoh/gDprb8LKGVq9q1C+jSFZM3rz/mE9B7qFvMIej1rDRbVQzfOSodVWv7tqXT
         Q5CgpzayOAcWRMRW4hEYUO2tMC2kLi210QOrziciHjFSeigwLc1LdiEwCTgfXegNkiat
         SF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145490; x=1688737490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhXmptONXfKQG4/azc/n5esg6bpY2sbIHHxi+gxlcSU=;
        b=OYiuH+YnduK3XH1IVI6lFuhyOR2mSzyflu6DunDuLFucNTEL29VD9ohtstU3/kflBt
         zqQFz57oAZIVfCTHFygQ3o+zEO1ueyc7zYmm3v92huljAlEyd2NgrI59ZHEXoCzqOt9Y
         V7nYLwPPKJxfq3Y6y5VQgdUjlrhLbf0wlWrB0BJedkDYLlWFj3dcHu0d+FNNZnAStQru
         IC+CkxMpytHiszg5JGbC4Pb891u5ZC/IhjnzqHtOqkQelq4vpc0SPnbFL1POfJ/fogeH
         l4+TdVa8IHBQGVfdP1r3PnIAJzrsscK3R09YeSAHrNm6q/PpyVXeVFs+XUn1J5r0bDCd
         km1Q==
X-Gm-Message-State: AC+VfDxGGktadf/zumbPhKm3uKf6/Mi1yMwd20GxZrJJpO4WmGav+pud
        Sfl1e27Vh8baodrjsBCS9IHv
X-Google-Smtp-Source: ACHHUZ6F0Jni8hgM4DlUAbC58FM7lsdm/hWEUCaSKmmjcbvvLZdoiSXLEWbwquKOlkvxBy0WtBRAUQ==
X-Received: by 2002:a81:83cb:0:b0:569:f208:a120 with SMTP id t194-20020a8183cb000000b00569f208a120mr7001030ywf.38.1686145490381;
        Wed, 07 Jun 2023 06:44:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ec69:1775:6713:a647? ([2600:1700:e72:80a0:ec69:1775:6713:a647])
        by smtp.gmail.com with ESMTPSA id g185-20020a0df6c2000000b00545a08184fdsm4720626ywf.141.2023.06.07.06.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:44:50 -0700 (PDT)
Message-ID: <281431b8-af40-9de9-f4b4-c596c5dbb3af@github.com>
Date:   Wed, 7 Jun 2023 09:44:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: [Patch v2 2/2] add: test use of brackets when color is disabled
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
 <pull.1541.v2.git.1686061219078.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1541.v2.git.1686061219078.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 02156b81bbb2cafb19d702c55d45714fcf224048 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Wed, 7 Jun 2023 09:39:01 -0400
Subject: [PATCH v2 2/2] add: test use of brackets when color is disabled

The interactive add command, 'git add -i', displays a menu of options
using full words. When color is enabled, the first letter of each word
is changed to a highlight color to signal that the first letter could be
used as a command. Without color, brackets ("[]") are used around these
first letters.

This behavior was not previously tested directly in t3701, so add a test
for it now. Since we use 'git add -i >actual <input' without
'force_color', the color system recognizes that colors are not available
on stdout and will be disabled by default.

This test would reproduce correctly with or without the fix in the
previous commit to make sure that color.ui is respected in 'git add'.

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---

Here is the patch to add this test on top of the previous change.

I've only validated this on my local computer, not through the
GitGitGadget PR. If needed, I could send a v3 via GitGitGadget,
but thought this would be a simple-enough addition here.

Thanks,
-Stolee

 t/t3701-add-interactive.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index a93fe54e2ad..df3e85fc8d6 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -734,6 +734,29 @@ test_expect_success 'colors can be overridden' '
 	test_cmp expect actual
 '
 
+test_expect_success 'brackets appear without color' '
+	git reset --hard &&
+	test_when_finished "git rm -f bracket-test" &&
+	test_write_lines context old more-context >bracket-test &&
+	git add bracket-test &&
+	test_write_lines context new more-context another-one >bracket-test &&
+
+	test_write_lines quit >input &&
+	git add -i >actual <input &&
+
+	sed "s/^|//g" >expect <<-\EOF &&
+	|           staged     unstaged path
+	|  1:        +3/-0        +2/-1 bracket-test
+	|
+	|*** Commands ***
+	|  1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
+	|  5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
+	|What now> Bye.
+	EOF
+
+	test_cmp expect actual
+'
+
 test_expect_success 'colors can be skipped with color.ui=false' '
 	git reset --hard &&
 	test_when_finished "git rm -f color-test" &&
-- 
2.40.1.vfs.0.0

