Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21453C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 05:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiGAFUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 01:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiGAFUE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 01:20:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F4140E2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:20:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b26so1540044wrc.2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=ekFya3lz30oEnjeCdHDC/nx3lbM+4hpajSEEEuMCSz0=;
        b=aKybjxG75LKftWXyz7lq1LOBwsIvTap3/p/aVNtgtAq2ILSTu8vDidTsgDhTzWkTnF
         1jHkTk+r9xPwUZlc0wGDuqk4MOujYd4LEx7IvmYuo9WC6/y4wGNSJzExnhP+bMbD/EeU
         W4MOTDO0/rjjYuw/ibH2Cqkjk5yRH887K16XB0fcRCDt0cSXiqnLPfnWEDKEKMZ4wpe+
         f0GHWMUlNQQcUQ0oyhkb1ZZj9FgfifY8Ej/vdoNR06R54QqszzVqrstqIVqG02O831hj
         5001id30nigdPM6sOKpmGwHwTKGpqwr51sfFbnJSFvPPEN2jg/Ni7HDL8kTKPpmdswnQ
         PUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ekFya3lz30oEnjeCdHDC/nx3lbM+4hpajSEEEuMCSz0=;
        b=UOnzworoY22PRG1HZsaI7YzvLyU44YsPxfvLMBqF7C/a6ZQzukEu7HGcwqvEkCjVfS
         GhkmsqWRAhIUiRwODutMypAbVgdAvBAMkNbHltJbvP90bh6pAN020oK8HwvmboHCrPBX
         zUKtU465mpTDGGZ0lAzHQbV3ruVOy3w33r9pwU2W1zz6psZ7nkmVgm+tiIK+e7ZMAn+p
         O6wic+Qv2ZagRp5EmcAyuLyPgc/OzOSZ3n7rqojHySmCQZkib7tcxh3sDdwwMi0FT7mR
         JNlHNEGeok2/M06y2WhkG29NuD63mpidKSg88NifwN3tGwHBcpzN+Vm/EVc8g3AVkEMg
         3IhQ==
X-Gm-Message-State: AJIora+gt9KRXvJBW5PUf3PI/u7XMFtZeIN9K9PraUlD8tkt5V+/teKG
        71/G1fV+V9S68Uk0ynYWhI8vjFQZA7M=
X-Google-Smtp-Source: AGRyM1u1NsQgXwKs5o9BRysAsu3hujCiOPmn9HwGTmx922g7x2yo7NNO2ESza9FqQ7h45W5pGVw7lQ==
X-Received: by 2002:a5d:4cc4:0:b0:21b:8a19:b8a6 with SMTP id c4-20020a5d4cc4000000b0021b8a19b8a6mr11647489wrt.590.1656652801236;
        Thu, 30 Jun 2022 22:20:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b003a04b248896sm4989353wmo.35.2022.06.30.22.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 22:20:00 -0700 (PDT)
Message-Id: <pull.1276.git.1656652799863.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jul 2022 05:19:59 +0000
Subject: [PATCH] t6429: fix use of non-existent function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@palantir.com>,
        Elijah Newren <newren@palantir.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@palantir.com>

This test had a line reading

    ! test_file_is_empty actual

which was meant to be

    ! test_must_be_empty actual

The test worked despite the error, because even though
test_file_is_empty is a non-existent function, the '!' negated the
return value and made it pass.  It'd be better to avoid the negation,
so something like

    test_file_not_empty actual

would be better, but perhaps it makes even more sense to specify the
number of lines of expected output to make the test a bit tighter.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Elijah Newren <newren@palantir.com>
---
    t6429: fix use of non-existent function
    
    This test had a line reading
    
    ! test_file_is_empty actual
    
    
    which was meant to be
    
    ! test_must_be_empty actual
    
    
    The test worked despite the error, because even though
    test_file_is_empty is a non-existent function, the '!' negated the
    return value and made it pass. It'd be better to avoid the negation, so
    something like
    
    test_file_not_empty actual
    
    
    would be better, but perhaps it makes even more sense to specify the
    number of lines of expected output to make the test a bit tighter.
    
    Reported-by: SZEDER Gábor szeder.dev@gmail.com Signed-off-by: Elijah
    Newren newren@palantir.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1276%2Fnewren%2Fmerge-ort-restart-optim-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1276/newren/merge-ort-restart-optim-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1276

 t/t6429-merge-sequence-rename-caching.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index f2bc8a7d2a2..e1ce9199164 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -760,7 +760,7 @@ test_expect_success 'avoid assuming we detected renames' '
 		test_must_fail git -c merge.renameLimit=1 rebase upstream &&
 
 		git ls-files -u >actual &&
-		! test_file_is_empty actual
+		test_line_count = 2 actual
 	)
 '
 

base-commit: e54793a95afeea1e10de1e5ad7eab914e7416250
-- 
gitgitgadget
