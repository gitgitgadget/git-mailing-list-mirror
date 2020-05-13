Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B539CA90AF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 13:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB9D204EC
	for <git@archiver.kernel.org>; Wed, 13 May 2020 13:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hli5pppl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEMNYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 09:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgEMNYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 09:24:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3541C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 06:24:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z15so1841031pjb.0
        for <git@vger.kernel.org>; Wed, 13 May 2020 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDSlk9WTU+Yme9aU6EUuFUXukvH0Au76MPeXSExayO8=;
        b=hli5ppplBRD1Z4B7hNXyJ63wLT35Bqd+FOwBU6/JRM5i40Wc3MTOFlZDnVmJHQYeO2
         uMmNQDfvOwzUEG1iAeb8gFg3NvXSnTrW8MHCSvtRpVPuc2xPyBs4Dww1mMwEw055SP50
         Dm/W6Ym/DFyDI0W4XQAOuOfOPv56abziIm0KWDdR08C8CL9+IvPCHv/JRYe8wOKqB/28
         oPcko/h9uqgdQD3y3jPKbBjXAaYfNUyMAI1oJZZk39W//e4r191nP/296mQZjF2qCxvI
         lvvM8OOW0oNaljjPfnJRhvBRyfj3JL+DuMZVC2yK8uDOjx4ZCmwITYGXxN7rkUknVgr4
         Ut2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDSlk9WTU+Yme9aU6EUuFUXukvH0Au76MPeXSExayO8=;
        b=pNaVbKfZ5ABF1p5P1D2Q/P7gIeCjP+5L2InSoW1ei8w3AtCDJGGLgfQ46daQ+ulfkL
         /DscFN6dMJfa4+w6pGpVN1AcvtQp7wWIAKxv5ChXDogPIRCSs1VL2enZqVBa42g3FYqU
         v0bLo4Y356O4RZFqz5aJxaUiM/fMEdVMZJ42Ufh4a1RzWBcUCOBTQqy0IqfE6FhKmtAn
         WIn1MQsU9T6RlDOeEyAZCv13cijUEV4T3tiOOKk9/RmmV4TtCg8WrpVBSlKX5jt9wyqN
         SmTk8pNbkIML8FuLSX8uTb07k+Pz3BgOJ8Z8bWf2TZNyMsy7cI9mhR9A61XjMaChQ1z+
         LH5g==
X-Gm-Message-State: AOAM531P0MUA+5CFg2TRwWQ692jAjolWIrxvcETLo3P8NFL6loqjPOra
        64Aa9wECX/2wU4HejNlNRotm4qod
X-Google-Smtp-Source: ABdhPJzmR/1+PWtmjoEw5IvgUBCr3VfRfYl21iAG7rLnQ+HZ/dpx/fC0PzgOJmxq7l9JqfqfN5Vv+w==
X-Received: by 2002:a17:90b:1045:: with SMTP id gq5mr1300278pjb.105.1589376249060;
        Wed, 13 May 2020 06:24:09 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id g10sm14918530pfk.103.2020.05.13.06.24.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 06:24:08 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/2] CI: enable t1509 in Travis and GitHub Actions
Date:   Wed, 13 May 2020 20:23:07 +0700
Message-Id: <fa2e1f7b44262eac1fa26161fc5d3f3b9b6bdb47.1589375923.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
In-Reply-To: <cover.1589375923.git.congdanhqx@gmail.com>
References: <cover.1589375923.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh              | 13 +++++++++++++
 ci/run-docker-build.sh |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index dac36886e3..e9c22ae718 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -113,6 +113,7 @@ then
 	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --immediate"
 	MAKEFLAGS="$MAKEFLAGS --jobs=2"
+	t1509_allowed=YES
 elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
 then
 	CI_TYPE=azure-pipelines
@@ -162,6 +163,7 @@ then
 	echo "::add-matcher::ci/git-problem-matcher.json"
 	test linux-musl = "$jobname" ||
 	MAKEFLAGS="$MAKEFLAGS TEST_SHELL_PATH=/bin/sh"
+	t1509_allowed=YES
 else
 	echo "Could not identify CI type" >&2
 	env >&2
@@ -184,6 +186,17 @@ export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
 
+if test "$t1509_allowed" = YES
+then
+	case "$jobname" in
+	osx-*) ;;
+	*)
+		chmod a+w / || sudo chmod a+w / || true
+		export IKNOWWHATIAMDOING=YES
+		;;
+	esac
+fi
+
 case "$jobname" in
 linux-clang|linux-gcc)
 	if [ "$jobname" = linux-gcc ]
diff --git a/ci/run-docker-build.sh b/ci/run-docker-build.sh
index 8d47a5fda3..026afe275a 100755
--- a/ci/run-docker-build.sh
+++ b/ci/run-docker-build.sh
@@ -58,6 +58,8 @@ else
 	test -n "$cache_dir" && chown -R $HOST_UID:$HOST_UID "$cache_dir"
 fi
 
+chmod a+w /
+
 # Build and test
 command $switch_cmd su -m -l $CI_USER -c "
 	set -ex
@@ -68,6 +70,7 @@ command $switch_cmd su -m -l $CI_USER -c "
 	export GIT_TEST_CLONE_2GB='$GIT_TEST_CLONE_2GB'
 	export MAKEFLAGS='$MAKEFLAGS'
 	export cache_dir='$cache_dir'
+	export IKNOWWHATIAMDOING=YES
 	cd /usr/src/git
 	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
 	make
-- 
2.26.2.672.g232c24e857

