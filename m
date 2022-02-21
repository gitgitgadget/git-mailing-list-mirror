Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92335C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 15:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379780AbiBUP70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 10:59:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379772AbiBUP7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 10:59:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771052981E
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:58:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d28so117596wra.4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXFwM9kiNqOUcDYCHCf1XEO6M6OQmwEXQh1cg5pCg0A=;
        b=YOprWm0M5e+5bh6+FFzzFq0Xt4wd6lZ6YustpYfdsBYoetCVen+DRlui/bWOXGA0FP
         gh1ApGnh7zVY1qaU4799T6oTIWEfL3+8jIP5xgwfA12cwjC9SsSmuQ+sezm5P3dEK7wk
         JMGcoyqMr8ECzfowCS1GeeI3QraeGpUd/vtTP13i+gtm1/+vHyrJ8LTP9AUyZIxtIyAN
         RNMRJ9dd+xn+obyeXWZgFhUAaiM9su7Vcc12/cfS6eZrXru6E6ACF/5BMe7ysD7i8Kv9
         nOO30LTWBWGottOLIZdwgm2LrOYnPXKXn8ASAWGFF0c2GH8pPlcl12gyyXeYkUP9nOpS
         ldWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXFwM9kiNqOUcDYCHCf1XEO6M6OQmwEXQh1cg5pCg0A=;
        b=1Vd6RDvaYIIf35foIwx13qVSC9lW7CQ8mtdyl8QcU+NIgdLmavK+U1J06yIbYIK8fi
         yF31kHAtIvWd0O9hrozgvdp6+C54brNBz4ARMPb8oMSLjw6gUHe8IlzJRGtCgZhqSUyF
         iDhl4V3NKobSKAkd9wiSNCTwQ20N8at213TqDmzh4FMWGP1w+eX4lKd3wV9WfZM7GGwV
         zOHTngKYkbZb1jKCSNvzuYg7k4WiCKn4GK0rqdOYLvDg0WuU7i5tsO6rVYqCnEH2a/BT
         7EbT8tjsP8wQiuMX1MjXL0xuw6LERX/+Y0Ps+4QgHlmj0UiuIf5FP4gt6XKR10RMAoF6
         wRxQ==
X-Gm-Message-State: AOAM532yTgvig8FVdFCBJ/5EbvuKKgx3Z2/f4FMGxE6QiyjPTGtv/cgc
        4XXrXGeBjwun8dJdxLKEZ8to/mKN9H096A==
X-Google-Smtp-Source: ABdhPJx5M7fIZgSih/xHRtxRmGmrNO9i75dKAUjZCuPSVrljPF+p7aU47AEGoWXH9Yj7zbnX8Dn24Q==
X-Received: by 2002:adf:f7cc:0:b0:1e4:b2d4:f432 with SMTP id a12-20020adff7cc000000b001e4b2d4f432mr16661182wrq.430.1645459137807;
        Mon, 21 Feb 2022 07:58:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x10sm7811170wmj.17.2022.02.21.07.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 07:58:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/4] test-lib: correct commentary on TEST_DIRECTORY overriding
Date:   Mon, 21 Feb 2022 16:58:33 +0100
Message-Id: <patch-v3-2.4-33a628e9c3a-20220221T155656Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct a misleading comment added by me in 62f539043c7 (test-lib:
Allow overriding of TEST_DIRECTORY, 2010-08-19).

Between that comment and the later addition of
85176d72513 (test-lib.sh: convert $TEST_DIRECTORY to an absolute path,
2013-11-17) the comments were on the wrong arms of the "if". I.e. the
"allow tests to override this" was on the "test -z" arm.

But more importantly this could be read allowing the "$TEST_DIRECTORY"
to be some path outside of t/. As explained in the updated comment
that's impossible, rather it was meant for *tests* that ran outside of
t/, i.e. the "t0000-basic.sh" tests that use "lib-subtest.sh".

Those tests have a different working directory, but they set the
"TEST_DIRECTORY" to the same path for bootstrapping. The comments now
reflect that, and further comment on why we have a hard dependency on
this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 55f263a02d3..77c3fabd041 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -19,13 +19,20 @@
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"
 then
-	# We allow tests to override this, in case they want to run tests
-	# outside of t/, e.g. for running tests on the test library
-	# itself.
-	TEST_DIRECTORY=$(pwd)
-else
 	# ensure that TEST_DIRECTORY is an absolute path so that it
 	# is valid even if the current working directory is changed
+	TEST_DIRECTORY=$(pwd)
+else
+	# The TEST_DIRECTORY will always be the path to the "t"
+	# directory in the git.git checkout. This is overridden by
+	# e.g. t/lib-subtest.sh, but only because its $(pwd) is
+	# different. Those tests still set "$TEST_DIRECTORY" to the
+	# same path.
+	#
+	# See use of "$GIT_BUILD_DIR" and "$TEST_DIRECTORY" below for
+	# hard assumptions about "$GIT_BUILD_DIR/t" existing and being
+	# the "$TEST_DIRECTORY", and e.g. "$TEST_DIRECTORY/helper"
+	# needing to exist.
 	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
 if test -z "$TEST_OUTPUT_DIRECTORY"
-- 
2.35.1.1132.ga1fe46f8690

