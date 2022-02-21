Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FD9C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 15:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379782AbiBUP71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 10:59:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiBUP7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 10:59:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D222980C
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:59:00 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so13854866wme.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jfCQMduVXvjJ2AVTzh9g/J8jvzCk9kASlQMKD3rn+dY=;
        b=diNMfGwJAfxetiNpFY7Luo549Eg+Ob0n2HvZ4YIgFzziGy+69RYS8AbhkB6UEzq15p
         Rv8Ik4aBIAQS6c7gm5C+kOz6mSAkdpE/ugHEykO3ifEDDElLSDCxrhE8/sASmzKQNIct
         1VrcrM5EYJQsdAF98PTaOfZs+gpE6UHREX9PRdtbyVmEiZzOdLJdTCC/qI7jLRmwD7Wv
         QuaxEPuRtW1dPNS0iFJtfA4vAB/s2Lj6fN2cWBhqLJ89MdbaUtNa9lMSzyzHDdBuRLqM
         /xWdnbG2TkSmJxYcf/oQDpxfsgb+vuYmPjz1AA98WPgYjLLz7bwA/He2tKOAC5YrxWFS
         snaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jfCQMduVXvjJ2AVTzh9g/J8jvzCk9kASlQMKD3rn+dY=;
        b=kq2XCFxKO4l2P0SUn8pxfuB5gWIj7bwwkGJ1NJ/LH+Xe21e+En6WCNZX6zinquGqW2
         3SAEtZlh9EoodUodhS1cCnZ5XQ6MMYe4NJynbmkHvRx/wmW5cmEpZSEWLAezGKjOC+vk
         SGyIdJBg3HWnNLQ8T5J2xD08iwplKGmhhhx5xKlWXwtWRHGHddFbpa7CWXX1CDwgGVde
         AeKTH07tS9pMRd5KGY1B8yyheZx1TwuTll5HOZ8ldLNjER6LN9rP3O+Vf3DeeqJvw7Ii
         uivigCe4EhrsvvgKJDIeCdlyRm7f1obNWvk1ljcQ1cfTSJnwOEI0itQCnURujj6tzOeF
         RV1Q==
X-Gm-Message-State: AOAM533vWBgAlznzUOTCzOUHFsPPTZMIdEQ2HZitIYoulm4pXBmociQA
        Tvoq/+TOzGL8a2h+gOVfwugt0HCvtJEl3Q==
X-Google-Smtp-Source: ABdhPJzAGAXiEiETSLRjnv+otB9nHtXkwAi+iZW7vHhMZ7H4XJUsmEpSv9tTncovK6lCoAsj0+hTEA==
X-Received: by 2002:a7b:ce83:0:b0:37b:f1f1:3a0c with SMTP id q3-20020a7bce83000000b0037bf1f13a0cmr18097755wmj.10.1645459138800;
        Mon, 21 Feb 2022 07:58:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x10sm7811170wmj.17.2022.02.21.07.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 07:58:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/4] test-lib: make $GIT_BUILD_DIR an absolute path
Date:   Mon, 21 Feb 2022 16:58:34 +0100
Message-Id: <patch-v3-3.4-b03ae29fc92-20220221T155656Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the GIT_BUILD_DIR from a path like "/path/to/build/t/.." to
"/path/to/build". The "TEST_DIRECTORY" here is already made an
absolute path a few lines above this.

We could simply do $(cd "$TEST_DIRECTORY"/.." && pwd) here, but as
noted in the preceding commit the "$TEST_DIRECTORY" can't be anything
except the path containing this test-lib.sh file at this point, so we
can more cheaply and equally strip the "/t" off the end.

This change will be helpful to LSAN_OPTIONS which will want to strip
the build directory path from filenames, which we couldn't do if we
had a "/.." in there.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 77c3fabd041..ff13321bfd3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -41,7 +41,7 @@ then
 	# elsewhere
 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
 fi
-GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
 
 # Prepend a string to a VAR using an arbitrary ":" delimiter, not
 # adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
@@ -59,6 +59,7 @@ prepend_var () {
 # problems. The GIT_SAN_OPTIONS variable can be used to set common
 # defaults shared between [AL]SAN_OPTIONS.
 prepend_var GIT_SAN_OPTIONS : abort_on_error=1
+prepend_var GIT_SAN_OPTIONS : strip_path_prefix=\"$GIT_BUILD_DIR/\"
 
 # If we were built with ASAN, it may complain about leaks
 # of program-lifetime variables. Disable it by default to lower
-- 
2.35.1.1132.ga1fe46f8690

