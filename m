Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C06C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiGSVFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGSVFq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:05:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0043E6E
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk26so23396473wrb.11
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7Rg9SpeL11hgJ3A6zJ0dEgsvWACSZlCMRNCw1d6AJw=;
        b=DR7iulZ0rb8Co/VC2ySj0AY7RmECdbUGGLXUKa9Umj0ROclJ10M3yPO3AQCxv13ayl
         5R29QTfODl3oOWWuPgbPLboTefIZdp4DbMbfPQ6tTqsM2huyqnOazw7ooh6wqO4hiqTE
         baeb5jqbCzsS7Ciji6zVguadFTHfjA+Lx9a/u6EF0KnwrXzYMgnKSU0sd+BIgiDsdSBx
         7bbOC5JA/uvY7aI1AxRFd6lE+E23gUONT5bhflOD9rGC3NfUtBKcoZf99wzeuD2bNd9G
         GCG9vdlNxgKdkhcSocGxgwV/c+YlFTum+Hkt5fXxEAOmSySi1aPjeH+M0+eHt38piWhY
         6cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7Rg9SpeL11hgJ3A6zJ0dEgsvWACSZlCMRNCw1d6AJw=;
        b=tSPlxd2LMz03Qgz+NG3MTHaCg+bFKmWfCd7HQa3QMF/lUck1zUV97neWoAbP2jN9ls
         BjCe1RWIKTJiol0PL7NXp1xRoleu2ZdqHQKH0h6jN1iUJ9Kir0lrvROHBJkyncmBcSIu
         Txpo3u34xz8IOXoNfzm3XD09nDtYqanEVytDbieIaSu8z5bM8yBODFNR11WwqmWm+myJ
         6II2TfVBa1Yt7Up30KHjW+SncZ9kuR8LgaK6pSmX1huvEWHf5dEPhWjMHYdIjXJxdyfv
         AFuucrV1ZaI/lsYhSS9/9I/rpH6TANcIz4WBi/7yCltYoTjhKIjUTxlsozY2QJgDQn7Q
         Es1w==
X-Gm-Message-State: AJIora9QSOruMaIRWB1+IGD6nkWz4581Xf1xhmHlXxV9MDSGlR5z+uPH
        YJgUqzCWxkWP6oodG0RG/tNQZjMH9bTadA==
X-Google-Smtp-Source: AGRyM1uZKagZnk676aIiJWm0C+x+pHS4HW0tZb9ydwk8iNwsO+aFYxfCeLQvDYjgYdiqbgPN/UHEdA==
X-Received: by 2002:adf:f412:0:b0:21d:8aa4:e796 with SMTP id g18-20020adff412000000b0021d8aa4e796mr28223925wro.79.1658264739737;
        Tue, 19 Jul 2022 14:05:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c461800b003a050a391e8sm75091wmo.38.2022.07.19.14.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:05:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] test-lib.sh: add a GIT_TEST_PASSING_SANITIZE_LEAK=check mode
Date:   Tue, 19 Jul 2022 23:05:21 +0200
Message-Id: <patch-07.10-0961df2ab6c-20220719T205710Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1063.gd87c5b8cc23
In-Reply-To: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "GIT_TEST_PASSING_SANITIZE_LEAK=check" mode to the
test-lib.sh.

As noted in the updated "t/README" this compliments the existing
"GIT_TEST_PASSING_SANITIZE_LEAK=true" mode added in
956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in CI,
2021-09-23).

It does so by adding the ability to check that there's a 1=1
correspondence between those tests that are marked as passing with
SANITIZE=leak, and those tests that are leak-free. I.e. a test that
passes with SANITIZE=leak but isn't marked as such with
TEST_PASSES_SANITIZE_LEAK=true will error out.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README            | 10 ++++++++++
 t/t9700-perl-git.sh |  6 ++++++
 t/test-lib.sh       | 34 ++++++++++++++++++++++++++--------
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/t/README b/t/README
index c2f996656d3..7b7082386ae 100644
--- a/t/README
+++ b/t/README
@@ -371,6 +371,16 @@ declared themselves as leak-free by setting
 "TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
 test mode is used by the "linux-leaks" CI target.
 
+GIT_TEST_PASSING_SANITIZE_LEAK=check checks that our
+"TEST_PASSES_SANITIZE_LEAK=true" markings are current. The "check" is
+particularly useful with "--immediate", but otherwise acts the same
+for tests that have "TEST_PASSES_SANITIZE_LEAK=true" set. For those
+that don't have it set it runs them, and considers them passing
+without errors a failure (by providing "--invert-exit-code"). Thus the
+"check" mode can be used e.g. with "git rebase --exec" to ensure that
+there's a 1=1 mapping between "TEST_PASSES_SANITIZE_LEAK=true" and
+those tests that pass under "SANITIZE=leak".
+
 GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
 "test-results/$TEST_NAME.leak/trace.*" files. Useful in combination
 with "GIT_TEST_PASSING_SANITIZE_LEAK" to check if we're falsely
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 102c133112c..faba941117d 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -11,6 +11,12 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
+if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" && test_have_prereq SANITIZE_LEAK
+then
+	skip_all='SANITIZE=leak and GIT_TEST_PASSING_SANITIZE_LEAK=check do not combine with test_external'
+	test_done
+fi
+
 perl -MTest::More -e 0 2>/dev/null || {
 	skip_all="Perl Test::More unavailable, skipping test"
 	test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 73600c4d887..747bf6c50e5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1447,17 +1447,34 @@ fi
 # skip non-whitelisted tests when compiled with SANITIZE=leak
 if test -n "$SANITIZE_LEAK"
 then
-	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+	# Normalize with test_bool_env
+	passes_sanitize_leak=
+
+	# We need to see TEST_PASSES_SANITIZE_LEAK in "git
+	# env--helper" (via test_bool_env)
+	export TEST_PASSES_SANITIZE_LEAK
+	if test_bool_env TEST_PASSES_SANITIZE_LEAK false
+	then
+		passes_sanitize_leak=t
+	fi
+
+	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
 	then
-		# We need to see it in "git env--helper" (via
-		# test_bool_env)
-		export TEST_PASSES_SANITIZE_LEAK
+		if test -n "$invert_exit_code"
+		then
+			BAIL_OUT "cannot use --invert-exit-code under GIT_TEST_PASSING_SANITIZE_LEAK=check"
+		fi
 
-		if ! test_bool_env TEST_PASSES_SANITIZE_LEAK false
+		if test -z "$passes_sanitize_leak"
 		then
-			skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
-			test_done
+			say "in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true"
+			invert_exit_code=t
 		fi
+	elif test -z "$passes_sanitize_leak" &&
+	     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+	then
+		skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
+		test_done
 	fi
 
 	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
@@ -1476,7 +1493,8 @@ then
 		prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
 		export LSAN_OPTIONS
 	fi
-elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
+     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 then
 	BAIL_OUT "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
 fi
-- 
2.37.1.1062.g385eac7fccf

