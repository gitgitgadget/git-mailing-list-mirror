Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A21FC433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiFSQKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 12:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFSQKe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 12:10:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF26644C
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 09:10:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so4591896wms.3
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 09:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oDj/znghlF9+1KwWxQfFU33nQLJctDUilpIeJizrQxA=;
        b=ACJUVRh57XQp8AZB+IRd+NphxrM9PjiCBlT1NDY80ZldKnTBkhuoh2jwnesMjgamIk
         dTPZfw5CqSltezop/ykQUmuor2tGi3t7KZ3dqSw4fhYtrJkPOB9mr8+7JxYOeWBKoN7L
         WZHl1PMGDbzKxbeA68JB9COpjJacq9Ol9GuupZVbQvNqT1iQi4sSh3F6dxkoBPWwqG/V
         BgjZ93/c9Kq/njIFN+0/y+Di9OY8poT4pV3omGH9IOQA55j4HkJoc5A+yH1FCyYcBNyl
         gccuSWa/NRB3+8dpex1ywIWrdJbNCEw4yh1Zw1BkFOBanIkjJ2WRICaBJcMwTCimyBQ0
         k/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oDj/znghlF9+1KwWxQfFU33nQLJctDUilpIeJizrQxA=;
        b=u7VnU78W5R5kTkkqJbDXuOKGSv2vMafeA3R2mhYiO4/9IFIzOdAwBwmLu7D9wLELaM
         LsLZtC/rIuEVnlKRDHkfnQirUeKX1mZ+kKZkCaNlGVPpVZDpy/gEuvx479t0oJ6XQqIM
         oYuXtThuirsTOfIhIPhsN7Oj0SG7fc291HqBIXAhQQcnDeOQpMd6rNY+PfxlN48ZZZ4s
         HoAbECW9JDbYsACHEmYHQK1qqX5qN1MFSveqvtNjWZNNt5MOwMrvepLAOuuNKcGRWbzZ
         lKNJiOK3vVLg4VmRexe8vApemW43u+W5K2eosS/uwLQm4tFiBnUgCaA5Y6+TrSNBLRae
         2XNg==
X-Gm-Message-State: AOAM5325pN4sMj5u2Fd8kdiogMImQlpOFopF5Gv6n6Xx1F4IBRe3kcDt
        7vuMUOeQ+4b+MASvNWytAX8sTZOW89TeDw==
X-Google-Smtp-Source: ABdhPJyt5apcR7288j4SyS4zUDqIopaKp2+Ul6aKh38cyDDfTSNdulfYtQpLpIZf0zu551hXfxNBkg==
X-Received: by 2002:a1c:28b:0:b0:39c:48ce:88c8 with SMTP id 133-20020a1c028b000000b0039c48ce88c8mr30305813wmc.7.1655655030808;
        Sun, 19 Jun 2022 09:10:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14-20020a1c4b0e000000b0039c95b31812sm12076937wma.31.2022.06.19.09.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 09:10:29 -0700 (PDT)
Message-Id: <efd3bd4cdda815a1b7dec35de6569cd4ab0817f3.1655655027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
        <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Jun 2022 16:10:24 +0000
Subject: [PATCH v2 1/3] t4141: test "git apply" with core.ignorecase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>,
        Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4141-apply-icase.sh | 128 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100755 t/t4141-apply-icase.sh

diff --git a/t/t4141-apply-icase.sh b/t/t4141-apply-icase.sh
new file mode 100755
index 00000000000..17eb023a437
--- /dev/null
+++ b/t/t4141-apply-icase.sh
@@ -0,0 +1,128 @@
+#!/bin/sh
+
+test_description='git apply with core.ignorecase'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+       # initial commit has file0 only
+       test_commit "initial" file0 "initial commit with file0" initial &&
+
+       # current commit has file1 as well
+       test_commit "current" file1 "initial content of file1" current &&
+       file0blob=$(git rev-parse :file0) &&
+       file1blob=$(git rev-parse :file1) &&
+
+       # prepare sample patches
+       # file0 is modified
+       echo modification to file0 >file0 &&
+       git add file0 &&
+       modifiedfile0blob=$(git rev-parse :file0) &&
+
+       # file1 is removed and then ...
+       git rm --cached file1 &&
+       # ... identical copies are placed at File1 and file2
+       git update-index --add --cacheinfo 100644,$file1blob,file2 &&
+       git update-index --add --cacheinfo 100644,$file1blob,File1 &&
+
+       # then various patches to do basic things
+       git diff HEAD^ HEAD -- file1 >creation-patch &&
+       git diff HEAD HEAD^ -- file1 >deletion-patch &&
+       git diff --cached HEAD -- file1 file2 >rename-file1-to-file2-patch &&
+       git diff --cached HEAD -- file1 File1 >rename-file1-to-File1-patch &&
+       git diff --cached HEAD -- file0 >modify-file0-patch
+'
+
+# Basic creation, deletion, modification and renaming.
+test_expect_success 'creation and deletion' '
+       # start at "initial" with file0 only
+       git reset --hard initial &&
+
+       # add file1
+       git -c core.ignorecase=false apply --cached creation-patch &&
+       test_cmp_rev :file1 "$file1blob" &&
+
+       # remove file1
+       git -c core.ignorecase=false apply --cached deletion-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+
+       # do the same with ignorecase
+       git -c core.ignorecase=true apply --cached creation-patch &&
+       test_cmp_rev :file1 "$file1blob" &&
+       git -c core.ignorecase=true apply --cached deletion-patch &&
+       test_must_fail git rev-parse --verify :file1
+'
+
+test_expect_success 'modificaiton' '
+       # start at "initial" with file0 only
+       git reset --hard initial &&
+
+       # modify file0
+       git -c core.ignorecase=false apply --cached modify-file0-patch &&
+       test_cmp_rev :file0 "$modifiedfile0blob" &&
+       git -c core.ignorecase=false apply --cached -R modify-file0-patch &&
+       test_cmp_rev :file0 "$file0blob" &&
+
+       # do the same with ignorecase
+       git -c core.ignorecase=true apply --cached modify-file0-patch &&
+       test_cmp_rev :file0 "$modifiedfile0blob" &&
+       git -c core.ignorecase=true apply --cached -R modify-file0-patch &&
+       test_cmp_rev :file0 "$file0blob"
+'
+
+test_expect_success 'rename file1 to file2' '
+       # start from file0 and file1
+       git reset --hard current &&
+
+       # rename file1 to file2
+       git -c core.ignorecase=false apply --cached rename-file1-to-file2-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_cmp_rev :file2 "$file1blob" &&
+       git -c core.ignorecase=false apply --cached -R rename-file1-to-file2-patch &&
+       test_must_fail git rev-parse --verify :file2 &&
+       test_cmp_rev :file1 "$file1blob" &&
+
+       # do the same with ignorecase
+       git -c core.ignorecase=true apply --cached rename-file1-to-file2-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_cmp_rev :file2 "$file1blob" &&
+       git -c core.ignorecase=true apply --cached -R rename-file1-to-file2-patch &&
+       test_must_fail git rev-parse --verify :file2 &&
+       test_cmp_rev :file1 "$file1blob"
+'
+
+test_expect_success 'rename file1 to file2' '
+       # start from file0 and file1
+       git reset --hard current &&
+
+       # rename file1 to File1
+       git -c core.ignorecase=false apply --cached rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_cmp_rev :File1 "$file1blob" &&
+       git -c core.ignorecase=false apply --cached -R rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :File1 &&
+       test_cmp_rev :file1 "$file1blob" &&
+
+       # do the same with ignorecase
+       git -c core.ignorecase=true apply --cached rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_cmp_rev :File1 "$file1blob" &&
+       git -c core.ignorecase=true apply --cached -R rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :File1 &&
+       test_cmp_rev :file1 "$file1blob"
+'
+
+# We may want to add tests with working tree here, without "--cached" and
+# with and without "--index" here.  For example, should modify-file0-patch
+# apply cleanly if we have File0 with $file0blob in the index and the working
+# tree if core.icase is set?
+
+test_expect_success CASE_INSENSITIVE_FS 'a test only for icase fs' '
+       : sample
+'
+
+test_expect_success !CASE_INSENSITIVE_FS 'a test only for !icase fs' '
+       : sample
+'
+
+test_done
-- 
gitgitgadget

