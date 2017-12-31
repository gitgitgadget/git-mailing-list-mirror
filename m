Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E5B1F406
	for <e@80x24.org>; Sun, 31 Dec 2017 16:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdLaQCf (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 11:02:35 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33695 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdLaQCb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 11:02:31 -0500
Received: by mail-wr0-f193.google.com with SMTP id v21so34490107wrc.0
        for <git@vger.kernel.org>; Sun, 31 Dec 2017 08:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLiLIUqY3Tsal6qO5ZR7AosYw+HVBGjjgMOhiJZXQaU=;
        b=YEZcTneQVA6yc53ooh6Vo6mIjeUOgj/9guQPxIIPyd6u0uyUIIYvyX7X4Gn6/K9X4B
         PjPIartqP7fD1ljj9WeMVgf/wFxhXklNwpfcT6EHfCK4v/sAdENrd41oPBSmoIl/H8M/
         tNH0G5ZZH9ytAohRCoOgV1MQRTw6gbo9KoZcdcakukO5SYVoShd/XZrJ1FhknVVkoY37
         QlUa8MFgdM8THyLgjm2g9Non+8h84hoUC5wsOJ0hvHuST+SabqwVpy76Isyci7j03sjB
         1UPAJdRL1RsPamPIif/wMUEF/QCkhlk2EvSwouslSiRl2XVRUuivaszZc1UdwqZPryL8
         6G3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLiLIUqY3Tsal6qO5ZR7AosYw+HVBGjjgMOhiJZXQaU=;
        b=UWJR3HaMjsUouVBPDN+6wOlGodvoiHUdFGv2514SOnAAlB2hX01/ebd4DSOtJ/h/qP
         i2mmotbr7SXwdiDJmThd/efPr4Ejfs3IGXRIV3uSnblxMKvuzPH+IN3XmldWvw4jix3m
         6ROuUoQ5T14z4LLpyi6KbpRF8tPSq7PxAUnmk8PFC9bp2ACIvKwgG1BKJz59P2GaykNr
         UQNdpYsgfzPy6nLyNPmyKxOPiyYrWdpo0rdFtF9egNb4EneVJTwBvTg8xSOvnriWkEOs
         hPnTWZnuzC1ruvU/T/lC9G/otfl7gn5/gpxDwmIyButyw+pLxw5PxpaZ5MoBmgYYWp2s
         iBrA==
X-Gm-Message-State: AKGB3mImP0ywmYTfcTvM4KYulroyELf7j99GU1cvrCWgvWkc9io0dBro
        4F4Ap6CylR9ph5sYP02Zz+eFlA==
X-Google-Smtp-Source: ACJfBouiInBemel2YM4wCRhP3YJUaOYKVbtP+wNvdatawfOItAAsepRv5SZHv8CmX/VyBrFfLVMJ5A==
X-Received: by 10.223.160.129 with SMTP id m1mr17691763wrm.126.1514736149965;
        Sun, 31 Dec 2017 08:02:29 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id x88sm12906174wrb.4.2017.12.31.08.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Dec 2017 08:02:29 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] travis-ci: check that all build artifacts are .gitignore-d
Date:   Sun, 31 Dec 2017 17:02:06 +0100
Message-Id: <20171231160206.19481-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
In-Reply-To: <20171231160206.19481-1-szeder.dev@gmail.com>
References: <20171231160206.19481-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every once in a while our explicit .gitignore files get out of sync
when our build process learns to create new artifacts, like test
helper executables, but the .gitignore files are not updated
accordingly.

Use Travis CI to help catch such issues earlier: check that there are
no untracked files at the end of any build jobs building Git (i.e. the
64 bit Clang and GCC Linux and OSX build jobs, plus the GETTEXT_POISON
and 32 bit Linux build jobs) or its documentation, and fail the build
job if there are any present.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh       | 10 ++++++++++
 ci/run-linux32-docker.sh |  2 ++
 ci/run-tests.sh          |  2 ++
 ci/test-documentation.sh |  6 ++++++
 4 files changed, 20 insertions(+)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 1543b7959..07f27c727 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -67,6 +67,16 @@ skip_good_tree () {
 	exit 0
 }
 
+check_unignored_build_artifacts ()
+{
+	! git ls-files --other --exclude-standard --error-unmatch \
+		-- ':/*' 2>/dev/null ||
+	{
+		echo "$(tput setaf 1)error: found unignored build artifacts$(tput sgr0)"
+		false
+	}
+}
+
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
 # Set tracing executed commands, primarily setting environment variables
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 870a41246..4f191c5bb 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -23,4 +23,6 @@ docker run \
 	daald/ubuntu32:xenial \
 	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
 
+check_unignored_build_artifacts
+
 save_good_tree
diff --git a/ci/run-tests.sh b/ci/run-tests.sh
index eb5ba4058..22355f009 100755
--- a/ci/run-tests.sh
+++ b/ci/run-tests.sh
@@ -8,4 +8,6 @@
 ln -s $HOME/travis-cache/.prove t/.prove
 make --quiet test
 
+check_unignored_build_artifacts
+
 save_good_tree
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 3d62e6c95..a20de9ca1 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -18,6 +18,9 @@ test -s Documentation/git.xml
 test -s Documentation/git.1
 grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
 
+rm -f stdout.log stderr.log
+check_unignored_build_artifacts
+
 # Build docs with AsciiDoctor
 make clean
 make --jobs=2 USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
@@ -26,4 +29,7 @@ sed '/^GIT_VERSION = / d' stderr.log
 test -s Documentation/git.html
 grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
 
+rm -f stdout.log stderr.log
+check_unignored_build_artifacts
+
 save_good_tree
-- 
2.16.0.rc0.67.g3a46dbca7

