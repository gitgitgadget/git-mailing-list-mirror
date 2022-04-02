Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C17DC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 19:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbiDBT0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 15:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiDBT0s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 15:26:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A953D6363
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 12:24:55 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g22so6632022edz.2
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SiHlNeY4canW2Gr3zNvacWJWHlkJ8mq5wZBDDIjtHwM=;
        b=KfBQtFWFhKIgt3zVdnzl+y6+KoEUp227G7uVNKFNMiTC6ZQESdZvvC2LZMEOMtDYT0
         zTnGSp1aN/9U4SqkymC1NwcCdzTSZDs+qIEI3wlpV9uo4QRdJsgDkge+bcKT5AR/oV3X
         pSavd+aeT12Aaw5H1JHZwfcgKOxYh6QBJXoYXXyKAibOLst5wadPzR8873cNAGBlZjb3
         bOF0baMDlNNnkD0OvvE1Z7mvemavcgLxqOHosXwcflEN2UKh2JPTJzEo2T+vJXvbn9ko
         fTEYQ/9jObhwIGXIxNoXRhH3sdxwvwpD6Yvg4tpngMdn9hVdrkaEpc0CpG3VAvJxCvsK
         63RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SiHlNeY4canW2Gr3zNvacWJWHlkJ8mq5wZBDDIjtHwM=;
        b=D+AOtvGkZuBDRoZcdBVqk4Ss0qeLJDC2XPkn7QbuJq3JHBi/bvpOZiGzpLHyy7Q1wX
         0TqBp+SnbeZJAlK6xF+Z9q7T9fsl3NTLYpuBHmqygS53Uzn5dyg4eMzOMQAib6o1TOBw
         mblIYdYJoUrS8j6Y9PkB8fo4CnOIS6AvhmftJPiva4uUprxgrR+RY3bfuorL56XbLbOD
         US3zYqqZpL+Vreh3QkxN62RgKihkXyRmuPfd3Ya9T72GFcN6Fe/yYCOfNkCZPp7j7o6r
         hQ9hoBjtNIBhrJFjLpAC76aB0GKgcwJl9hZDP/hJG1SzArG+q8cVHIMIv4wcQAXnsBZa
         +UXg==
X-Gm-Message-State: AOAM533jJWMU7jYC3PsKaHiKpEFJwmjXbTNbGT20bbTkyD4GPK9tTEh7
        PZJicYKbdmOX8N6Jz6X63LI=
X-Google-Smtp-Source: ABdhPJxhh1aNsfqIrbdHK76gdcK69lmcGtzCl02w6iFPIMgS9ycJ2eXWfYfnjFsFvgfM6O1QIYONOw==
X-Received: by 2002:a05:6402:350b:b0:419:1c11:23ed with SMTP id b11-20020a056402350b00b004191c1123edmr26516785edd.8.1648927494092;
        Sat, 02 Apr 2022 12:24:54 -0700 (PDT)
Received: from 4b99411c802f.europe-west4-b.c.codatalab-user-runtimes.internal (167.113.90.34.bc.googleusercontent.com. [34.90.113.167])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b0040f13865fa9sm2777910edt.3.2022.04.02.12.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 12:24:53 -0700 (PDT)
From:   Labnann <khalid.masum.92@gmail.com>
To:     khalid.masum.92@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com
Subject: [PATCH v3 1/1] t3501: remove redundant file check and stop ignoring git <cmd> exit code
Date:   Sat,  2 Apr 2022 19:24:15 +0000
Message-Id: <20220402192415.19023-2-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220402192415.19023-1-khalid.masum.92@gmail.com>
References: <20220331191525.17927-1-khalid.masum.92@gmail.com>
 <20220402192415.19023-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the test 'cherry-pick after renaming branch', stop checking for
the presence of a file (opos) because we are going to "grep" in it in
the same test and the lack of it will be noticed as a failure anyway.

In the test 'revert after renaming branch', instead of allowing any
random contents as long as a known phrase is not there in it, we can
expect the exact outcome---after the successful revert of
"added", the contents of file "spoo" should become identical to
what was in file "oops" in the "initial" commit.

In both tests, we would not notice when "git rev-parse" starts
segfaulting without emitting any output.  The 'test' command would
end up being just "test =", which yields success. Therefore we could
use test_cmp_rev

Signed-off-by: Labnann <khalid.masum.92@gmail.com>

---
 t/t3501-revert-cherry-pick.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 8617efaaf1..ad8f0cae5a 100755
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
 
@@ -77,9 +76,8 @@ test_expect_success 'revert after renaming branch' '
 
 	git checkout rename1 &&
 	git revert added &&
-	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
-	test -f spoo &&
-	! grep "Add extra line at the end" spoo &&
+	test_cmp_rev rename1 HEAD^ &&
+	test_cmp_rev initial:oops HEAD:spoo &&
 	git reflog -1 | grep revert
 
 '
-- 
2.35.1.windows.2

