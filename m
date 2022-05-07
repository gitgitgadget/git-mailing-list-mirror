Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC098C433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 16:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386292AbiEGQjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 12:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386283AbiEGQjK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 12:39:10 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BFA204
        for <git@vger.kernel.org>; Sat,  7 May 2022 09:35:20 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c1so8007314qkf.13
        for <git@vger.kernel.org>; Sat, 07 May 2022 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VNUCHSDKmu0kHegV7uFbiYEdrygPAFlkZhGSGB5BOzI=;
        b=G+K4cFgDatTgrZPP+KTF6TT6mFyldW74i2fRHn4p5gYknt5M0KPhU/g9QSPGhpZcRi
         b9HsrGhM2iR78hzCC/9Qkg+bhMFAf2Jtd0i4Yc2iN56e9oTfX9h0KFttI2RejwwKsUQ/
         x16fPJqK7+xl3FW8sSy2CyH/kSOz6cvJ49hU/BAa0QdYYC9ByNgwv6BOmALxwMP1Gtga
         jfb0tTON61MuuN2MZIz5cKpocas4MdRBM/Jgh5j/0px92eC8UD2/36CA1LsiuH/XY5B7
         ELWWK8vUGy1+6SLpweCplePsA75nflTWPjztgcpqGIB0ueUthBBDc8PR1j9lGMnU1o+8
         a/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VNUCHSDKmu0kHegV7uFbiYEdrygPAFlkZhGSGB5BOzI=;
        b=miCmu+e4PHdjNKJibduTCvM8eGvuuZfIfP0zPE7wbxpU+s5nlf+e2kZ7Vf7ICs8SMW
         pvlUnUcP2/lq+HRkGZZPqZ3RwepRLqtPS5KShkpKPkElXOgksH360xURxBchpxtPUdZC
         MzHQB4imWASsN+jEkYxYKdHySjYWplBKb5Wt4srgpEIP5UoZ3FXRMGoYKUDSedpubGBB
         Rn7a76CGJdoIbbbh241IvijoApxHq1yJt/GevKE1NQi+PZP2WFpTDN6Tulnyjk6V/UFg
         kqlBSx5LjC/g5NU7SWh5nb6qU1vz6WyWbomJifmXKVGZUzqSRjiMz68up0MaMfKjXeHF
         YiLg==
X-Gm-Message-State: AOAM533Q4qL9D5WX/wfcyQw9ReJEoXxhWbhp5AHmOiyEymKzEjdtNrd2
        8y8Gtmzvtv14P9HN8a7vCORcQwIHnYY=
X-Google-Smtp-Source: ABdhPJwTJrUuKTfP75ZhUFq3VmcojlIW17NlZeKLbv0cq48sSZg8rxzfLs67KVsK5AW8iOdWi6mVHg==
X-Received: by 2002:a05:620a:4511:b0:6a0:5e0b:1374 with SMTP id t17-20020a05620a451100b006a05e0b1374mr1738656qkp.713.1651941319298;
        Sat, 07 May 2022 09:35:19 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id l15-20020ac848cf000000b002f39b99f6c3sm4244564qtr.93.2022.05.07.09.35.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 May 2022 09:35:19 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH v4 1/3] t: regression git needs safe.directory when using sudo
Date:   Sat,  7 May 2022 09:35:06 -0700
Message-Id: <20220507163508.78459-2-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220507163508.78459-1-carenas@gmail.com>
References: <20220503065442.95699-1-carenas@gmail.com>
 <20220507163508.78459-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally reported after release of v2.35.2 (and other maint branches)
for CVE-2022-24765 and blocking otherwise harmless commands that were
done using sudo in a repository that was owned by the user.

Add a new test script with very basic support to allow running git
commands through sudo, so a reproduction could be implemented and that
uses only `git status` as a proxy of the issue reported.

Note that because of the way sudo interacts with the system, a much
more complete integration with the test framework will require a lot
more work and that was therefore intentionally punted for now.

The current implementation requires the execution of a special cleanup
function which should always be kept as the last "test" or otherwise
the standard cleanup functions will fail because they can't remove
the root owned directories that are used.  This also means that if
failures are found while running, the specifics of the failure might
not be kept for further debugging and if the test was interrupted, it
will be necessary to clean the working directory manually before
restarting by running:

  $ sudo rm -rf trash\ directory.t0034-root-safe-directory/

The test file also uses at least one initial "setup" test that creates
a parallel execution directory, while ignoring the repository created
by the test framework, and special care should be taken when invoking
commands through sudo, since the environment is otherwise independent
from what the test framework expects.  Indeed `git status` was used
as a proxy because it doesn't even require commits in the repository
to work.

A new SUDO prerequisite is provided that does some sanity checking
to make sure the sudo command that will be used allows for passwordless
execution as root without restrictions and doesn't mess with git's
execution path.  This matches what is provided by the macOS agents that
are used as part of GitHub actions and probably nowhere else.

Most of those characteristics make this test mostly suitable only for
CI, but it might be executed locally if special care is taken to provide
for some of them in the local configuration and maybe making use of the
sudo credential cache by first invoking sudo, entering your password if
needed, and then invoking the test with:

  $ GIT_TEST_ALLOW_SUDO=YES ./t0034-root-safe-directory.sh

If it fails to run, then it means your local setup wouldn't work for the
test and things that might help is to comment out sudo's secure_path config
and make sure your account has similar privileges than what the CI
provides (for example an entry in /etc/sudoers for the user marta like)

  marta	ALL=(ALL:ALL) NOPASSWD: ALL

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0034-root-safe-directory.sh | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 t/t0034-root-safe-directory.sh

diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
new file mode 100755
index 0000000000..2e4492a66d
--- /dev/null
+++ b/t/t0034-root-safe-directory.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='verify safe.directory checks while running as root'
+
+. ./test-lib.sh
+
+if [ "$GIT_TEST_ALLOW_SUDO" != "YES" ]
+then
+	skip_all="You must set env var GIT_TEST_ALLOW_SUDO=YES in order to run this test"
+	test_done
+fi
+
+test_lazy_prereq SUDO '
+	sudo -n id -u >u &&
+	id -u root >r &&
+	test_cmp u r &&
+	command -v git >u &&
+	sudo command -v git >r &&
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
+test_expect_failure SUDO 'sudo git status as original owner' '
+	(
+		cd root/r &&
+		git status &&
+		sudo git status
+	)
+'
+
+# this MUST be always the last test
+test_expect_success SUDO 'cleanup' '
+	sudo rm -rf root
+'
+
+test_done
-- 
2.36.1.371.g0fb0ef0c8d

