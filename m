Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566DFC433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 03:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242389AbiD1DjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 23:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242348AbiD1DjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 23:39:09 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E356FF49
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 20:35:54 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so4010138fac.7
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 20:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ny9w5jfOZLPwfKIp2tL4D7hy36R2IyG1XC4cNbwk+4w=;
        b=d51rjCOklFnczGVS6yTcqGDtw8SBHGu7GmRt2PQyo3kVGNBT/V+1JR7EfGRUOFtRiJ
         qVC27i24w+pjDNsU0GVXAZTji2y6XUA9A8pYFhwQn/CebTgPVLnPYyNm+JTuw1pwMs43
         qwK5Bf7iBmPvxcv5b/79upfV5GohrISPhUI3azYoJxqLZCqSNTbV8oSSLmnyGq1mr415
         wBqS5q7PFCYrLjC8wBkZhJEA2UHUkLKXa1eAXAeirqeMHt+cng7YyDbTbJ/g5XP4+Z6g
         o7Td1XlUompnPpUsycb4TdLdeS90XsUHKHche+zqHGs3Gj0iDzAWIxHhp9aBlYkqcj5A
         2l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ny9w5jfOZLPwfKIp2tL4D7hy36R2IyG1XC4cNbwk+4w=;
        b=PydQsY7fZ1Dzae5w1nZLC6P1ppTiDPo2ahs/SAJXcxk0eszz4BaNkEshG5gdSVJ8GT
         CEMHqw2CzgFTKY6zQmQm1nvGP8DVrd3VXFDbEbaCeqNvIBP1qR88CVEmEduuTTs3TmQP
         V/nTDGj4mG/Z5Lv/OYzejgNTSrTV99PdnrxCCkBqC7JHoHmFlWMNK0e1exHS398NJWqt
         sBspqaGzZolLwrX/Cqyp9xvKjcrhkCG0E+c484tTn7sBypQs7y0rydd1Ibh+XzUwoGCD
         bCV23sFHUjnSnDbkDrWpCK12SInVhHZ3dQdGrziP3bc1YE691LMUzK6pWRpOFkyb4dfV
         Yolg==
X-Gm-Message-State: AOAM530Fv0uRv1RIPjJnSOVG6EYUtA4cIEYpXVbGn2K0onbBTLdx8lsn
        G2S2Qh8KJz2cuTLJcmJQGak8R3SkjCg=
X-Google-Smtp-Source: ABdhPJyxEhZMUPVQaj1G20KshKCs/25FtHESXQTk2paFpWBdGniklZFZMvV8lmp+d+Zp2dN0TG1fsw==
X-Received: by 2002:a05:6870:d607:b0:e9:1fc3:48c6 with SMTP id a7-20020a056870d60700b000e91fc348c6mr9332739oaq.151.1651116954001;
        Wed, 27 Apr 2022 20:35:54 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id x21-20020a4a6215000000b0033993dc1d65sm7432217ooc.8.2022.04.27.20.35.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2022 20:35:53 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/2] t: add tests for safe.directory when running with sudo
Date:   Wed, 27 Apr 2022 20:35:44 -0700
Message-Id: <20220428033544.68188-3-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220428033544.68188-1-carenas@gmail.com>
References: <20220427222649.63516-1-carenas@gmail.com>
 <20220428033544.68188-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a previous commit the functionality for fixing this regression was
implemented, so add a test for it and the relevant infrastructure.

This new test file is meant to be run in CI and checks for a SUDO
prerequisite which requires a passwordless configuration if run
locally, but that is common there.

It could be run locally by first running sudo, so the credentials are
temporarily cached and then running it as :

  $ IKNOWWHATIAMDOING=YES ./t0034-root-safe-directory.sh

It is slightly ackward as it needs to clean up after itself since the
test framework would fail to do its own cleanup otherwise, and for
simplicity creates its own subtree while ignoring the one provided by
the framework, but doing some better integration has been punted.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0034-root-safe-directory.sh | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100755 t/t0034-root-safe-directory.sh

diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
new file mode 100755
index 00000000000..c62bf3777c0
--- /dev/null
+++ b/t/t0034-root-safe-directory.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description='verify safe.directory checks while running as root'
+
+. ./test-lib.sh
+
+if [ "$IKNOWWHATIAMDOING" != "YES" ]; then
+	skip_all="You must set env var IKNOWWHATIAMDOING=YES in order to run thi
+s test"
+	test_done
+fi
+
+if ! test_have_prereq NOT_ROOT
+then
+	skip_all="this test uses sudo to run as root"
+	test_done
+fi
+
+doalarm () {
+	perl -e 'alarm shift; exec @ARGV' -- "$@"
+}
+
+test_lazy_prereq SUDO '
+	doalarm 1 sudo id -u >u &&
+	id -u root >r &&
+	test_cmp u r
+'
+
+test_expect_success SUDO 'setup' '
+	sudo rm -rf root &&
+	mkdir -p root/r &&
+	sudo chown root root &&
+	(
+		cd root/r &&
+		git init
+	)
+'
+
+test_expect_success SUDO 'sudo git status works' '
+	(
+		cd root/r &&
+		git status &&
+		sudo git status
+	)
+'
+
+test_expect_success SUDO 'cleanup' '
+	sudo rm -rf root
+'
+
+test_done
-- 
2.36.0.266.g59f845bde02

