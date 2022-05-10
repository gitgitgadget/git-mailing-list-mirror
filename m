Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8EDC433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 17:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbiEJRug (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 13:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348387AbiEJRua (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 13:50:30 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9252B56FB1
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:46:32 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a76so13734799qkg.12
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=couz2yvVijOlpxItzLIoHD0R8RVjhamGn1kW5vMTtj8=;
        b=ffaa/La3A/sfK4zCf5mCqYUGuXY2tKXRHi38qR1MxbEPIpO6Bjsg1Mo4tyk7YV/0KW
         L6fPnubYZQUPwNZPLI5e0ldqvN7F8tL/GwLBi36jEAyDL9S7hJ5ts9oVK9fhwNWOTPxC
         iZX5vdY1rVCtuI43rCM/JjnZ1CNQRFRwdig37nAjPfjMTTZBkCNatJ75SvWK4FvjC3Uh
         wIbXM9H2/0YeGBcqvdbL9FDAWSVI3cqj3HVvtSMjS+bjkyiu4xtFj4oUTpP411P8roF4
         vNYrJWbC+Q0oFog3JztOoLkUMEPR8s77EhZYHxPzoK4vlhUAeFGZ5DFqlZMoZm7rwRaD
         9ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=couz2yvVijOlpxItzLIoHD0R8RVjhamGn1kW5vMTtj8=;
        b=JdsCpKwk7oBap2K85vpoJV57GjIr9UKNPKdbETxpQLnAbkzzYrvyfy3a0G3LTJw03x
         cU8BP/oF4LPs1Xk+BwPteAhLY3W+KgDMjQC+jE/KZN8tboOb7KO6zltolEBdJwZHn+wa
         Si86ZD9dGYkrYdZtnfkidhxldTA6TwlTa+g6p+JQ65U8GiYulUTfGTjIBGG18HwVYSOG
         zMm0UJ1VHv2KugUM1Ojm15B251BiywgoWsSAE7vXniW4dzGnLlqY22s2Mjpw1Ar+yB+N
         CBwaNaI5CP2bbzwTS0yz3dpEp/e2XZ2xad7Aqq3w8fRa2KrzQEIUkgX2hW6AjSCT9dhp
         WgBQ==
X-Gm-Message-State: AOAM532LvqkG30ju3/6uD5vr0MH2zfcOSPAo1G0m1Wlfv8IXL4sH+ioK
        SIQviuZmllGzcbkaQnlNNqJza9PUaiM=
X-Google-Smtp-Source: ABdhPJyQhcrFIhCl2jH2RnR79FgWGic53YEVocHAdp4QehK3+owvxTSseuEW9aXLQZn29o8Dmtu/dg==
X-Received: by 2002:a37:a98c:0:b0:6a0:d9ff:4959 with SMTP id s134-20020a37a98c000000b006a0d9ff4959mr73082qke.336.1652204791510;
        Tue, 10 May 2022 10:46:31 -0700 (PDT)
Received: from localhost.localdomain (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h191-20020a379ec8000000b0069fc347ef5dsm8719280qke.74.2022.05.10.10.46.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2022 10:46:31 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 1/3] t: regression git needs safe.directory when using sudo
Date:   Tue, 10 May 2022 10:46:14 -0700
Message-Id: <20220510174616.18629-2-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220510174616.18629-1-carenas@gmail.com>
References: <20220507163508.78459-1-carenas@gmail.com>
 <20220510174616.18629-1-carenas@gmail.com>
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
by the test framework.

Special care should be taken when invoking commands through sudo, since
the environment is otherwise independent from what the test framework
setup and might have changed the values for HOME, SHELL and dropped
several relevant environment variables for your test.  Indeed `git status`
was used as a proxy because it doesn't even require commits in the
repository to work and usually doesn't require much from the environment
to run, but a future patch will add calls to `git init` and that will
fail to honor the default branch name, unless that setting is NOT
provided through an environment variable (which means even a CI run
could fail that test if enabled incorrectly).

A new SUDO prerequisite is provided that does some sanity checking
to make sure the sudo command that will be used allows for passwordless
execution as root without restrictions and doesn't mess with git's
execution path.  This matches what is provided by the macOS agents that
are used as part of GitHub actions and probably nowhere else.

Most of those characteristics make this test mostly only suitable for
CI, but it might be executed locally if special care is taken to provide
for all of them in the local configuration and maybe making use of the
sudo credential cache by first invoking sudo, entering your password if
needed, and then invoking the test with:

  $ GIT_TEST_ALLOW_SUDO=YES ./t0034-root-safe-directory.sh

If it fails to run, then it means your local setup wouldn't work for the
test because of the configuration sudo has or other system settings, and
things that might help are to comment out sudo's secure_path config, and
make sure that the account you are using has no restrictions on the
commands it can run through sudo, just like is provided for the user in
the CI.

For example (assuming a username of marta for you) something probably
similar to the following entry in your /etc/sudoers (or equivalent) file:

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

