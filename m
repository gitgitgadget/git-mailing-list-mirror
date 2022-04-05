Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186B5C41535
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383812AbiDEVqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441985AbiDEPgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 11:36:49 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0927CA1449
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 06:50:18 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id kk12so10014351qvb.13
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HzOQf8XX8yHzxzCM6w5S6DFj2cSDoEheA1mueGUqqg4=;
        b=FHVFTsRpDlGaydwZkiPEbZfRsJRqsHEHr02nkUNWHTuM00LLmrvcetItgIQxpR4GnZ
         XOgilJQr6JFHoj2XjV9X7/IIGO2WhvEo4k8y/TcQjlXAH34EGDL454UlZ4Eft3TW6gcC
         JsStCJWIDpffOPZu98u6nOUpetLVHlHigVzw3pP6SHyV/AkNO1Vm9E4psVDwPELpDCyI
         6cWhgHxQhwJn3F3uIHaujLi1xpp6G6tjyVkdH+J1ICJwkQqE9gzby4mXba6d6Yxt5D/N
         UviYqWpR/pNZiYb05kUDaLx6JqgMBR4NpwuSPuEyjJtErj0nOFTugUqVWQLIW9I8e5Z1
         QmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HzOQf8XX8yHzxzCM6w5S6DFj2cSDoEheA1mueGUqqg4=;
        b=t7NA0YrGV9tQ9G134oMKocaf/IRpgwjnQnpAIdqmx05a36RhvkLGYnTEB3JzZ8/Of3
         6MsXXSFA5rpAaIsYsiJW87U18gShlkbCvKaEtQBULGdHmEGEI76XyEYuH6JWAgo5XJGU
         3g1ROnguqAtVmlBaAP+WEjjk4uy2ftOa2YStf+cFinJLO0mWvVynr2j1cMRVj6VZJPnt
         GQBRYuD7EwxQEkpitftMtIDQKpKQmBgX22ceVR3bfbwll3vgS2sFoEAcNG2hvDAza7EJ
         vBE3UOJ+DMgIP6xOad4E/SifF8lAV1ANIjjim/07D4aMDF1m3v2X9dS9cn4+biL28YdF
         IdnA==
X-Gm-Message-State: AOAM533ocItxi612RyQXP3iRpfysAVWj3fwNXQ6zkvM68eX9V7nYcJEw
        kuSXimfiWCmoVPTgPhnOqmyVCQPoNQQ=
X-Google-Smtp-Source: ABdhPJwwoTLROOJyfialav19fQM9QXm3EAjdvNRuEZG1+3YOjmMGz3BKkglUWE61yzLGp/qJI2IKHw==
X-Received: by 2002:a05:6214:da9:b0:441:4d1f:73d9 with SMTP id h9-20020a0562140da900b004414d1f73d9mr2781080qvh.80.1649166615663;
        Tue, 05 Apr 2022 06:50:15 -0700 (PDT)
Received: from e4a2938d721e.us-east4-c.c.codatalab-user-runtimes.internal (42.11.86.34.bc.googleusercontent.com. [34.86.11.42])
        by smtp.gmail.com with ESMTPSA id a16-20020a05622a02d000b002e20e4bf4aesm11330534qtx.23.2022.04.05.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:50:15 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     khalid.masum.92@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com
Subject: [PATCH v4 1/1] t3501: remove test -f and stop ignoring git <cmd> exit code
Date:   Tue,  5 Apr 2022 13:47:42 +0000
Message-Id: <20220405134742.17526-2-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405134742.17526-1-khalid.masum.92@gmail.com>
References: <20220402192415.19023-1-khalid.masum.92@gmail.com>
 <20220405134742.17526-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the test 'cherry-pick after renaming branch', stop checking for
the presence of a file (opos) because we are going to "grep" in it in
the same test and the lack of it will be noticed as a failure anyway.

In the test 'revert after renaming branch', instead of allowing any
random contents as long as a known phrase is not there in it, we can
expect the exact outcome---after the successful revert of "added", the
contents of file "spoo" should become identical to what was in file
"oops" in the "initial" commit. This test also contains 'test -f' that
verifies presence of a file, but we have a helper function to do the same
thing. Replace it with appropriate helper function 'test_path_is_file'
for better readability and better error messages.

In both tests, we will not notice when "git rev-parse" starts segfaulting
without emitting any output.  The 'test' command will end up being just
"test =", which yields success. Use the 'test_cmp_rev' helper to make
sure we will notice such a breakage.

Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 t/t3501-revert-cherry-pick.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 8617efaaf1..9eb19204ac 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -66,8 +66,7 @@ test_expect_success 'cherry-pick after renaming branch' '
 
 	git checkout rename2 &&
 	git cherry-pick added &&
-	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
-	test -f opos &&
+	test_cmp_rev rename2 HEAD^ &&
 	grep "Add extra line at the end" opos &&
 	git reflog -1 | grep cherry-pick
 
@@ -77,9 +76,9 @@ test_expect_success 'revert after renaming branch' '
 
 	git checkout rename1 &&
 	git revert added &&
-	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
-	test -f spoo &&
-	! grep "Add extra line at the end" spoo &&
+	test_cmp_rev rename1 HEAD^ &&
+	test_path_is_file spoo &&
+	test_cmp_rev initial:oops HEAD:spoo &&
 	git reflog -1 | grep revert
 
 '
-- 
2.35.1.windows.2

