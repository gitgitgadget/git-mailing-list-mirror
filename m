Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D47C433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 18:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386941AbiEBSnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 14:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386934AbiEBSnB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 14:43:01 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E28AE71
        for <git@vger.kernel.org>; Mon,  2 May 2022 11:39:30 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id z15-20020a9d65cf000000b00605f064482cso7469716oth.6
        for <git@vger.kernel.org>; Mon, 02 May 2022 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1lbuUls2BK6XImROW8QBFJsTSWHQYIIT4gI3WgoZoKM=;
        b=XDKSCutub972RT8/Dy6li2iXBBf1aFd754x3IL+61BPzyCx4VKp0NO+aXZ13kMn9RP
         NQwFp/is9/ya1RuJQW1BimKH8Ez5FFqmA/iLGAJTNGxWODPhOpSgTSVwGmEjwB8Px1SU
         mGuBTHVXxxB8Ebr/wTBTWsugKNpgQfBy1PC1vdIzyLuAT1qf6nXHuZ9UsYiNav8Ig4In
         8YrNZbK6RDmFqQg4KM+5LaDnxpEyA2LL20iIMIa+3wnefzPUUUii9w+HiySi01ge3Cbv
         kxBfZFdoIn90BRt6Tru5bqlFRU3InD44en32TX6kIoH8Be3qvC6GWxgHbikP8VngxbpX
         /WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1lbuUls2BK6XImROW8QBFJsTSWHQYIIT4gI3WgoZoKM=;
        b=QHp+Wo49j59eTmpLoYMoUNSZWjyNOT8qmyEJdsFz4UYf29s9MLSbfsSXuz7G+/KT7b
         a9XTIhObxfQpJ5NVNEVh385kcXJphw9ylOKc49evffOvw8vBM5v8D6yBgwsj1VImarYy
         u4ZaxFFwVjS80wPZwqrN+kYSJ8ilxK8f5ODsLKBbo5hx/tcbHP5n5fjTnC54DVrC2DA5
         cWDAbJh4UFnQ18wRAqifoNh6v2aW02A75SJ9KcNpGett3dwGA/JmfifeLy8ELJtGg/AL
         ZvhKfhin0a7wvAiuMXBhR+xCcHTmqsACuHzrT6ofhaqLDQ1U/Pk5jDMeIeBhpOdbKpT8
         n4iA==
X-Gm-Message-State: AOAM533e2o0rrcunpFg5nIaruYdC2Yg50t5VoJtGbJ+frq+FLJ7wWVNJ
        ZUVt0Lha/hlZyHq73NnpF06mkYR+gpo=
X-Google-Smtp-Source: ABdhPJxN/CuWGljoVd85hDg1khD1qnBHL/JTyK2AjxMB/KOJrn+VI0yK7LdNUE+vBTkfMdm384zzhw==
X-Received: by 2002:a05:6830:544:b0:605:f506:e91e with SMTP id l4-20020a056830054400b00605f506e91emr4702122otb.104.1651516769221;
        Mon, 02 May 2022 11:39:29 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a12-20020a056808120c00b00325cda1ff8fsm2620952oil.14.2022.05.02.11.39.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 11:39:28 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH v3 1/3] t: document regression git safe.directory when using sudo
Date:   Mon,  2 May 2022 11:39:18 -0700
Message-Id: <20220502183920.88982-2-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220502183920.88982-1-carenas@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220502183920.88982-1-carenas@gmail.com>
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
failures are found while running the specifics of the failure might
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
execution as root and doesn't mess with git execution paths, but
otherwise additional work will be required to ensure additional
commands behave as expected and that will be addressed in a later patch.

Most of those characteristics make this test mostly suitable only for
CI, but it could be executed locally if special care is taken to provide
for some of them in the local configuration and maybe making use of the
sudo credential cache by first invoking sudo, entering your password if
needed, and then invoking the test by doing:

  $ IKNOWWHATIAMDOING=YES ./t0034-root-safe-directory.sh

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0034-root-safe-directory.sh | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 t/t0034-root-safe-directory.sh

diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
new file mode 100755
index 00000000000..bec73fe3c10
--- /dev/null
+++ b/t/t0034-root-safe-directory.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='verify safe.directory checks while running as root'
+
+. ./test-lib.sh
+
+# this prerequisite should be added to all the tests, it not only prevents
+# the test from failing but also warms up any authentication cache sudo
+# might need to avoid asking for a password
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
2.36.0.352.g0cd7feaf86f

