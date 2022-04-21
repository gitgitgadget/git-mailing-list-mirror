Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5464FC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391455AbiDUSjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391413AbiDUSjp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:39:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A2496B8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s25so2994810wrb.8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nTKULx3qLP+iBR5t06nUQ8NnkGeWK3jDf+HNlCG9wPc=;
        b=WI5+abl4Sw9GfuKtdxzkWlIOawSJPKf8kqsSKOPjeH5XQO8GpsCSsJ10XZT9M7U6dY
         O6rw+tfjQ1yIDvgwzn5JmDfMUGc+RVPKcveD+fElEN4QQjufDqqhhfYzAvBDVAKpysiw
         lLW05KDlkBPVtOngnNSvwNUpBmFQO/virrN3sTo1umLBpB3zD4i7jhdIRbnI0IkmbQxc
         uALaL5LFvj0QwoagxligksQMv84HE13sMGjOttL8P67NfCTo5l7yeShiQEmh38GLs4+f
         b7wcBza5SZrXDfxc9F9OY1Or6c1y94Z/D4QuF/dd3SwFW8FJ7ObsLYJZfDazgSM9Fa8P
         vR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nTKULx3qLP+iBR5t06nUQ8NnkGeWK3jDf+HNlCG9wPc=;
        b=i9nyKQisiGqLKFaDdfUiYoaNm4eYmbzsKyzHeCQzXYN8H8avGbhdd6434L7r2IRcN7
         HrDhgI5q8UZLp/2qpbGLqQt1M4fFB2S/OCmUaEaIfokq47lV5whQ1iYsskungVYCIl8M
         wG2vf+im7FkDAeHNfvK3qhsgT9ZdjTpyQGsCvCACUx5KMUGMACKUWDbO1FfCTc4BCqLS
         n5IpSJZHD+YkC+N0t4ZTKUkXtEpbvZOT7iMHOjcogA+t7n7h/6MQiqRFtpfXcwVg9Hof
         xKuICXcQ2JZibT+cIuS1yvBW17i4iqw8dctAqq4wGohZ8atzGaWXARg4EVOfz3CBmmHU
         IAMw==
X-Gm-Message-State: AOAM531kswARPfEHbT/zKYR/EdPZzMx9Xx5o5LsaVf+AywRJ+7aSwnh5
        jPM4okODacA/hcygyxN8oTWh8LvfEgxyXw==
X-Google-Smtp-Source: ABdhPJxJVM1GTnvSS3liA4961ES75Hmb2bFkYCQbEPgjeWeC9HAqN5XXiPCfA+cMUsFpSuCn/8Lk7Q==
X-Received: by 2002:adf:d1e2:0:b0:20a:a97b:3ba with SMTP id g2-20020adfd1e2000000b0020aa97b03bamr757874wrd.491.1650566206749;
        Thu, 21 Apr 2022 11:36:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b0038ebf2858cbsm3108624wms.16.2022.04.21.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:36:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v5 09/10] ci: use `--github-workflow-markup` in the GitHub workflow
Date:   Thu, 21 Apr 2022 20:36:33 +0200
Message-Id: <RFC-patch-v5-09.10-877edff3b4d-20220421T183001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
References: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com> <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

[Ævar: due to re-structuring on top of my series the {begin,end}_group
in CI isn't needed at all to get "group" output for the test
suite. This commit includes the now-squashed "ci/run-build-and-tests:
add some structure to the GitHub workflow output":]

The current output of Git's GitHub workflow can be quite confusing,
especially for contributors new to the project.

To make it more helpful, let's introduce some collapsible grouping.
Initially, readers will see the high-level view of what actually
happened (did the build fail, or the test suite?). To drill down, the
respective group can be expanded.

Note: sadly, workflow output currently cannot contain any nested groups
(see https://github.com/actions/runner/issues/802 for details),
therefore we take pains to ensure to end any previous group before
starting a new one.

[Ævar: The above comment isn't true anymore, as that limitation has
been removed by basing this on my patches to run "make" and "make
test" directly from the top-level of main.yml.

Those are now effectively their own "group", effectively giving this
stage another group "level" to use. This means that the equivalent of
"make test" won't be on the same level as an individual test failure.

We no longer take any pains to ensure balanced group output as a
result (which was a caveat the previous ci/lib.sh implementation had
to deal with., We just need to "cat" the generated *.markup]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh                 | 2 +-
 ci/print-test-failures.sh | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 80e89f89b7f..422399b1305 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -189,7 +189,7 @@ MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
 case "$CI_TYPE" in
 github-actions)
 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
-	GIT_TEST_OPTS="--verbose-log -x"
+	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 814c7799b68..2dda16a0d97 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -62,12 +62,13 @@ do
 		if test -n "$github_workflow_markup"
 		then
 			printf "\\e[33m\\e[1m=== Failed test: ${TEST_NAME} ===\\e[m\\n"
+			cat "t/test-results/$TEST_MARKUP"
 		else
 			echo "------------------------------------------------------------------------"
 			echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
 			echo "------------------------------------------------------------------------"
+			cat "t/test-results/${TEST_OUT}"
 		fi
-		cat "t/test-results/${TEST_OUT}"
 
 		trash_dir="trash directory.$TEST_NAME"
 		case "$CI_TYPE" in
-- 
2.36.0.879.g3659959fcca

