Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52249C433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 11:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiBSLaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 06:30:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiBSLaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 06:30:09 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DAB19FB27
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 03:29:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m27so6924719wrb.4
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 03:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ngmu4/EJFsKCO0dY9NcciwUJjrcXqNDn4Zl/KFJLwM0=;
        b=bdRHO7qXMHUzYjOjKL3yZZgJZEoEhCSBusk05DualOfXRcQ9im5YzkE/Q1YOg9l/We
         bAqJ6iV7/mBDTvnXnZhSpnmCJVbzcuQzAPcYt/1MiNFIawu1cDYLjGGBwzfDLtXGOy8Y
         JmdfuuTJTrp3/IXaNvUKtLWNLaiUDhtvKr4RhIcZNjVWIyUlkwQTfTVDMhB11BLgB81b
         USe6kPnbgCHzR7Oa1CH3JtPSQeptA94xgCQIQ3CMA3bwB5Z5X5Lw6YE2AYpxADmRsTl0
         ojSuhtMGoHjxmiYg7R/HMRlohQOv/LQifKSacp/U8XmLRr+PZSzocfRqbFKYsvgx+s3b
         tTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ngmu4/EJFsKCO0dY9NcciwUJjrcXqNDn4Zl/KFJLwM0=;
        b=XMmJg0cqXzEapI4i7ErgvOsa2iC4Vgwl+BcWvIXCcvMrJknevNiy0dVwhg9u8NmglH
         0PGsus4X+bQYdHVX41GDAJafuURsPp1s56Lzd+7xaw5O0N7VwGGsWYap3fRXE1kXMhAr
         tnoK3Q8Qs1w3CIfiql6FwQE2rlXf4uFW4dPNTcPdxWNEyRr9xB/IB+KO4qLgkhS2rSsi
         eFfkO1DfAz/n76b7fFmU2TFhV1uBMOgORrbyaNaY8OOcATY9SIfCQW9c5nYl4ay1DNwQ
         TSWoTybB7RVxYhN4VojpnA2l8Sjc7kLOJdpmA0SBdn3qWDHAFwadNqBcZn5w66WDqEkX
         JJRg==
X-Gm-Message-State: AOAM5327LHfj3KNsP9iAYiNfxspiMdL2p/EuschNVsYMx/3GXcsheqx7
        1hikwfqKbVKfv3eXgh0jwV1vaEqddhuHeQ==
X-Google-Smtp-Source: ABdhPJyLjuVqegw50G0v7atUDwsp2FCU04cuD+ybDpg6TIwQ3Aj/L7cSiaE8upqwIwaXrmSvjlqIsQ==
X-Received: by 2002:a5d:634b:0:b0:1e3:3226:8e27 with SMTP id b11-20020a5d634b000000b001e332268e27mr8861723wrw.428.1645270189173;
        Sat, 19 Feb 2022 03:29:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12sm29464695wrw.32.2022.02.19.03.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:29:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] test-lib: add GIT_XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
Date:   Sat, 19 Feb 2022 12:29:40 +0100
Message-Id: <patch-v2-1.4-01e63a72231-20220219T112653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1130.g7c6dd716f26
In-Reply-To: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change our ASAN_OPTIONS and LSAN_OPTIONS to set defaults for those
variables, rather than punting out entirely if we already have them in
the environment.

We do want to take any user-provided settings over our own, but we can
do do that by prepending our defaults to the variable. The
libsanitizer options parsing has "last option wins" semantics.

It's now possible to do e.g.:

    LSAN_OPTIONS=report_objects=1 ./t0006-date.sh

And not have the "report_objects=1" setting overwrite our sensible
default of "abort_on_error=1", but by prepending to the list we ensure
that:

    LSAN_OPTIONS=report_objects=1:abort_on_error=0 ./t0006-date.sh

Will take the desired "abort_on_error=0" over our default.

See b0f4c9087e1 (t: support clang/gcc AddressSanitizer, 2014-12-08)
for the original pattern being altered here, and
85b81b35ff9 (test-lib: set LSAN_OPTIONS to abort by default,
2017-09-05) for when LSAN_OPTIONS was added in addition to the
then-existing ASAN_OPTIONS.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e4716b0b867..7e6978d1817 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -36,17 +36,33 @@ then
 fi
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 
+# Prepend a string to a VAR using an arbitrary ":" delimiter, not
+# adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
+#
+#	VAR=$1${VAR:+${1:+$2}$VAR}
+#
+# Usage (using ":" as the $2 delimiter):
+#
+#	prepend_var VAR : VALUE
+prepend_var () {
+	eval "$1=$3\${$1:+${3:+$2}\$$1}"
+}
+
+# If [AL]SAN is in effect we want to abort so that we notice
+# problems. The GIT_XSAN_OPTIONS variable can be used to set common
+# defaults shared between [AL]SAN_OPTIONS.
+prepend_var GIT_XSAN_OPTIONS : abort_on_error=1
+
 # If we were built with ASAN, it may complain about leaks
 # of program-lifetime variables. Disable it by default to lower
 # the noise level. This needs to happen at the start of the script,
 # before we even do our "did we build git yet" check (since we don't
 # want that one to complain to stderr).
-: ${ASAN_OPTIONS=detect_leaks=0:abort_on_error=1}
+prepend_var ASAN_OPTIONS : $GIT_XSAN_OPTIONS
+prepend_var ASAN_OPTIONS : detect_leaks=0
 export ASAN_OPTIONS
 
-# If LSAN is in effect we _do_ want leak checking, but we still
-# want to abort so that we notice the problems.
-: ${LSAN_OPTIONS=abort_on_error=1}
+prepend_var LSAN_OPTIONS : $GIT_XSAN_OPTIONS
 export LSAN_OPTIONS
 
 if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
-- 
2.35.1.1130.g7c6dd716f26

