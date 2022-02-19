Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D4EC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 11:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbiBSLaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 06:30:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiBSLaK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 06:30:10 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DC51A02AE
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 03:29:51 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so8174160wmb.0
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 03:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ueff2Pq3FW2KU6iRzhdf2X/rkE2dXkoqozgMf7IjS+U=;
        b=PG2MDxew9cOvg4kJgizptPfeBAaKf2OioKFcV9jpoUp8KM4ug3AZyepX5LcISs7JYb
         5zmB+wMc4tGK62ZD+g+ju/GlhpPBwzGa5BCV2cQ7MHR9DccIhjFiViYNzwqb24oY3E37
         dRJp4oL+Yzd6m5jQBJsskj8CZKwQ+zzYacjRfdyixrEzHVjWkTvSr5S/OZ87YJifwaea
         25Q+Y7X1LCne9gFlkWfmAIjlNwbPyDvdRPlqs8CLHlhPorBR9YtWmzCyAqoEubF2qau4
         dUVKIedR5bZfbGfhA8sOf+fph06UrieKJWCi0ERPVJBt3mT/L7Hv8nZAUXPAG2dp4Ar+
         YPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ueff2Pq3FW2KU6iRzhdf2X/rkE2dXkoqozgMf7IjS+U=;
        b=mL5cNPV51GpRfzrakxCh0Mk1ulQPvBG8ZYWY9F5uZuMSW9WixTIRfjub77x+BZViMk
         TrxxXz7ulA6uy4nlHqJsbIC008v0eAV6l9OXId84L8HospEZArJtWpreLGFQRuTBnXKI
         +Ng2QskTJRL+T6sL7mmO23c1nQ5+TTEjx1gqvIYPvXIV1j5heDhRub9KeI2snuWElaL6
         sZ8/xOm3PxFd+j8tTBLOjdg2dD7WI4KMKG0uaBxjPyULvuNo3IHTobpTj/Vv8wuYgAdx
         RAxEBFc1MiLYWi03YmPIjUqm3Tq5fRuRkYTTbf1FPDrEREcJpAIOrQTnOh4N5LLA7y5E
         p6MQ==
X-Gm-Message-State: AOAM531VXiC4YsVpFF2E/Qwfw/PuGGPy/QWqkqVH4EViquXfmvVrAejz
        X1GxoLXXToN4QpHP9zufqlaZgBjefMaxuw==
X-Google-Smtp-Source: ABdhPJxNQ/1zxmhVYBEKYOAGXgsV/qJRfiITV8MpjfvKPKkS/cynHlWWr8R+Kzq35rT4XHDMnoIwRA==
X-Received: by 2002:a05:600c:646:b0:37b:b738:f52c with SMTP id p6-20020a05600c064600b0037bb738f52cmr14377981wmm.30.1645270189977;
        Sat, 19 Feb 2022 03:29:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12sm29464695wrw.32.2022.02.19.03.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:29:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] test-lib: correct commentary on TEST_DIRECTORY overriding
Date:   Sat, 19 Feb 2022 12:29:41 +0100
Message-Id: <patch-v2-2.4-0c2867e30dc-20220219T112653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1130.g7c6dd716f26
In-Reply-To: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
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
index 7e6978d1817..8fa7379e128 100644
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
2.35.1.1130.g7c6dd716f26

