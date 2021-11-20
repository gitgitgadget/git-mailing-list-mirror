Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F262AC433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 03:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhKTDb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhKTDbw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 22:31:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA764C061756
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u18so21394726wrg.5
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYuPxjbeRR1VZ4jN5bG/52XRONJjrPVV8dEYTZwDroo=;
        b=IyH6ADPnuzUGWpv2V20uErvOKAKV5pUPnE67evAVsDGDSxjbc+4lYpFYpQyjYeyjV4
         NS0WITVNbXsVj4SlpD5iaqa4oObjKunV2IcAGKc7ssQpHD6bpp0oujuOEjmH1VBIXshu
         3vb/BkUjrvS8jgaBvyBZewhCzqab57NY+RHhOtSpiztBAp4x6LMCIJZb2qQkHl0PW/nQ
         WFwNg5AHUvdsk56NpHmtuJ3nvjTzcx5YaxUowxCTadqXyYtolDUCGqs8quKGwbUB9wlQ
         X1adGYuzGdCpTXxBiCqnajp/0ycXQKtiD1j2vYpvrVhyx2SQ0z7A7Jxg8jx1ZOUi1xNJ
         Bihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYuPxjbeRR1VZ4jN5bG/52XRONJjrPVV8dEYTZwDroo=;
        b=2DThn9HY1YmGSclGHGCln1NHkOjVeIOQkRk92lCRVslI2vq+qRTBihS/v58s0iJbHi
         ydlQe+QKGYOX10g13uR0o3iZwa3vY0SZwjk6yaNFZXmxj24fsCnjX95gp8Q/YnKgKc8m
         s07lEpNf9GxIq3GOEfsDnQgLk/xGFrkGYDZA3zVXmHWDVhvA+6Dk+U+xhkH/NLqD+EdE
         X9htAgzGgqBXXj3litijhR9e5yJAbPcCUpYOxdTfeoDPnTaccpyKB+C5mbHXeBxOwPAa
         sEbPvFpd8rGov506/17WBWaBYo0Z6DoGv6t7KYEDGPZxi5qBL8N/o9OLU3sKc3iEm1md
         F5wg==
X-Gm-Message-State: AOAM532BFDhwXuinMqs5wVL4y4Av8U9yGPLJuIC87MvEtiEH4Q9RtGmW
        1Lcojzfewgmj8JROuu4clXESo4yo2ducqQ==
X-Google-Smtp-Source: ABdhPJx+Mi6aKonmiAoD8uX/TK3L+mqFMLKIv43bvaMZK9Zv2oU0x9hVXR6G8zMZZ2dAoBKtdoZqCA==
X-Received: by 2002:a05:6000:18a7:: with SMTP id b7mr13836992wri.308.1637378928155;
        Fri, 19 Nov 2021 19:28:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12sm1560623wmq.12.2021.11.19.19.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 19:28:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] CI: run "documentation" via run-build-and-test.sh
Date:   Sat, 20 Nov 2021 04:28:36 +0100
Message-Id: <patch-v2-6.6-7c423c8283d-20211120T030848Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we've taught the build and test script to accept arbitrary
"make" targets it becomes easy to split up the "asciidoc" and
"asciidoctor" jobs, and to have the "ci/run-build-and-tests.sh" do the
"make" test of building the documentation. I.e. we'll run both of:

    make check-builtins check-docs
    make check-builtins check-docs USE_ASCIIDOCTOR=Y

As noted in 505ad91304e (travis-ci: check AsciiDoc/AsciiDoctor stderr
output, 2017-04-26) we need to keep checking the stderr that's emitted
by these, so let's add that special-case to
"ci/run-build-and-tests.sh".

The other doc-specific tests added in b98712b9aa9 (travis-ci: build
documentation, 2016-05-04) and 159e6010c2d (travis-ci: build
documentation with AsciiDoc and Asciidoctor, 2017-04-11) should live
in "ci/test-documentation.sh".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 14 +++++++++++---
 ci/install-dependencies.sh |  2 +-
 ci/lib.sh                  |  2 +-
 ci/run-build-and-tests.sh  | 29 ++++++++++++++++++++++------
 ci/test-documentation.sh   | 39 ++++++++++++++++----------------------
 5 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 63fff2744ad..c6aed3d2758 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -337,13 +337,21 @@ jobs:
       run: ci/install-dependencies.sh
     - run: make sparse
   documentation:
-    name: documentation
+    name: ${{matrix.vector.jobname}}
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
+    strategy:
+      fail-fast: false
+      matrix:
+        vector:
+          - jobname: doc-asciidoc
+          - jobname: doc-asciidoctor
+            makeflags: USE_ASCIIDOCTOR=Y
     env:
-      jobname: Documentation
+      jobname: ${{matrix.vector.jobname}}
+      MAKE_TARGETS: check-builtins check-docs doc ${{matrix.vector.makeflags}}
     runs-on: ubuntu-latest
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/test-documentation.sh
+    - run: ci/run-build-and-tests.sh
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index ca1eaa49c14..4a30713645a 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -65,7 +65,7 @@ sparse)
 	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
 		libexpat-dev gettext zlib1g-dev
 	;;
-Documentation)
+doc-*)
 	sudo apt-get -q update
 	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
 
diff --git a/ci/lib.sh b/ci/lib.sh
index cbc2f8f1caa..3afa95333ed 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -83,7 +83,7 @@ check_unignored_build_artifacts ()
 export TERM=${TERM:-dumb}
 
 # Clear MAKEFLAGS that may come from the outside world.
-export MAKEFLAGS=
+export MAKEFLAGS="${MAKEFLAGS:+$MAKEFLAGS }$EXTRA_MAKEFLAGS"
 
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 16840b2065d..a5f782db1f7 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,12 +5,10 @@
 
 . ${0%/*}/lib.sh
 
-case "$CI_OS_NAME" in
-windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
-*) ln -s "$cache_dir/.prove" t/.prove;;
-esac
-
-export MAKE_TARGETS="all test"
+if test -z "$MAKE_TARGETS"
+then
+	export MAKE_TARGETS="all test"
+fi
 
 case "$jobname" in
 linux-gcc)
@@ -46,6 +44,25 @@ linux-gcc-4.8)
 	;;
 esac
 
+case "$MAKE_TARGETS" in
+*test*)
+	case "$CI_OS_NAME" in
+	windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
+	*) ln -s "$cache_dir/.prove" t/.prove;;
+	esac
+	;;
+esac
+
+case "$jobname" in
+doc-*)
+	# This "make" command requireds bash-specific redirection
+	${0%/*}/test-documentation.sh
+	;;
+*)
+	make $MAKE_TARGETS
+	;;
+esac
+
 make $MAKE_TARGETS
 
 check_unignored_build_artifacts
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index de41888430a..898c33e74ba 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -14,32 +14,25 @@ filter_log () {
 	    "$1"
 }
 
-make check-builtins
-make check-docs
-
-# Build docs with AsciiDoc
-make doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
-cat stderr.raw
-filter_log stderr.raw >stderr.log
-test ! -s stderr.log
-test -s Documentation/git.html
-test -s Documentation/git.xml
-test -s Documentation/git.1
-grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
-
-rm -f stdout.log stderr.log stderr.raw
-check_unignored_build_artifacts
-
-# Build docs with AsciiDoctor
-make clean
-make USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
+make $MAKE_TARGETS > >(tee stdout.log) 2> >(tee stderr.raw >&2)
 cat stderr.raw
 filter_log stderr.raw >stderr.log
 test ! -s stderr.log
-test -s Documentation/git.html
-grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
 
 rm -f stdout.log stderr.log stderr.raw
-check_unignored_build_artifacts
 
-save_good_tree
+case $jobname in
+doc-asciidoc)
+	test -s Documentation/git.html
+	test -s Documentation/git.xml
+	test -s Documentation/git.1
+	grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
+	;;
+doc-asciidoctor)
+	test -s Documentation/git.html
+	grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
+	;;
+*)
+	exit 1
+	;;
+esac
-- 
2.34.0.823.gcc3243ae16c

