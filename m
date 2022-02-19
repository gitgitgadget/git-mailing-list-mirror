Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F028C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 11:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiBSLaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 06:30:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238166AbiBSLaL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 06:30:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94F719FACE
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 03:29:52 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d27so18722293wrc.6
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 03:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xr5cUOOop8mkApvxYgbKosQT5yy1LRTRWCI28T/PzHc=;
        b=FjS+Rq/ZhFRveapqMmgNzr3cJmL7inVu7PSCBQAXsiZeYu2z8RLQqZCJd+1gNCnqzU
         +Egfg/fEepOY9IrCZdq5r93SPBmND5QmOerF9yx1QNefNwhWtGFpfnAzpT1G4OtryRSJ
         2FTGRPRq5N+1YMyhmyhfrfOVzJMF2RiWlYe+/Vocv8tufOw//nA7oUdH3+uclp4nHj4u
         3Pj6SYCXmFWEJa0g80/cJJdCi6b21xlhydG+mLvbMf3GtaI4uzt/IZqjtARw76sJHEqL
         tdAbN+rAhosPbA1D2fadFL4zlXCxFyQMg2pi4T8PeMjnqjiVXHY1EsI/fB1zD6JWGKxT
         dWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xr5cUOOop8mkApvxYgbKosQT5yy1LRTRWCI28T/PzHc=;
        b=oUQJG2DkE2I02KjW+d5d5W91F/zy1Ql7Y0GHkmYQw/0AHbf7eUsHst0PdhzA0I5SEm
         liY6KT9Ku3fbxk16+b0inWgSMB9F9WiwqRA6+jMtXPorL6XVTE9ZLTNQTh/pJv/Wv0Kv
         /PuyT4VaN5vZROxfGwzMmwJ2VdQeUyPqWtbk3suMChJ/snoRcdOpw8KWfrUvuUHaxNn2
         kewcSDLfxrAldI3GgHGwD3bBbio+Oo21IVGcH+EgTT5pPUY5vqHgwhV6O7jXN8jAa01W
         VID+MYBKYvDZgIUJ89Wy+o+sgH1FQFIku9K9Q4qaojGqKREI3rUGZdFOapQlpaVQwqJp
         wYzg==
X-Gm-Message-State: AOAM533YUn2CVUgQUr/jS2KgiVnAt/kkChmdtam+c9wn8laSpTZehceH
        Oma4U8XVgYiOGsUhoUoBE9IQuzvIDqR+QQ==
X-Google-Smtp-Source: ABdhPJy/nYiDJ+mpHMIOvgO3RKJEE9DuTyP4Y4pqY3GZO1QieVTeOnQnP8LHK9ZEDW5wGEUNUP98DQ==
X-Received: by 2002:adf:f6c3:0:b0:1e4:9b8f:8f72 with SMTP id y3-20020adff6c3000000b001e49b8f8f72mr9111446wrp.287.1645270191239;
        Sat, 19 Feb 2022 03:29:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12sm29464695wrw.32.2022.02.19.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:29:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] test-lib: make $GIT_BUILD_DIR an absolute path
Date:   Sat, 19 Feb 2022 12:29:42 +0100
Message-Id: <patch-v2-3.4-229654027b8-20220219T112653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1130.g7c6dd716f26
In-Reply-To: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
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
index 8fa7379e128..80944035f2c 100644
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
 # problems. The GIT_XSAN_OPTIONS variable can be used to set common
 # defaults shared between [AL]SAN_OPTIONS.
 prepend_var GIT_XSAN_OPTIONS : abort_on_error=1
+prepend_var GIT_XSAN_OPTIONS : strip_path_prefix=\"$GIT_BUILD_DIR/\"
 
 # If we were built with ASAN, it may complain about leaks
 # of program-lifetime variables. Disable it by default to lower
-- 
2.35.1.1130.g7c6dd716f26

