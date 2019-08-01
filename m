Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF5B1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 15:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbfHAPxb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 11:53:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34118 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbfHAPxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 11:53:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so3977535wmd.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZNYpZtAIt98uJsXCqizlgB4MKuOnYXl8BmhUJ3N3Y4=;
        b=pUzH/Z8gw6B3BxRsHl283di370tE5oXnw9tFj6Q3oDiMLjf4SfKf4QwQ4ZYRnJYAku
         v6RxcJzrn08cMtP5M2p+uCQ9lI30bqxtgvOEU9qSiH4GgpMXDl0NgOFfTHKawlWsBxpD
         E7/vKt/mFu2r4DeYEKdFfTjxzwOx63Cr3Xc5VFFSxHXltD4Lom/BYWgLwq/Mj2dU8xrG
         jt4HFA9wWdXeaAFowe1LZCCNsrTi72rTzElO4JdC6WU5+qK8oooSDwP19W51woF4eaeA
         FoVzQ4noptV20JIJGrCwh/VaHn4DJoOvTADtgJ+4f2M2Y2FCT/aW8l0OnZ3sUxbF41cd
         7mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZNYpZtAIt98uJsXCqizlgB4MKuOnYXl8BmhUJ3N3Y4=;
        b=HTWZNsPpnZa+SlEW+Wdb7ogxlmYkzBrsqWyPrStwNzKAXIU6bPhrgqRKWdk7SQ3NIv
         gLOD8R5wVHWUuTvySxLsrxWReC5lgTF9dQJb2wSbLCNUaDHHmYGEHk5PS80yu5Hs+8/o
         wfxjucbVGjjCahrW+QXjCpH+liJ3vegKxxhMf3PdFhkG6IjUfN2sDeu7gRIeX3N/d3yF
         7dHGQlalFF19C6w5+Cwy7nObKWRJYS/Kc60BK4uGFZBdbtregPaPf7Rt1vZ1ayyWScQj
         3X7db4PPNbF9G9Mw+HyZvsVeQ4w19ZrI+FRybeqoXmFtlWk4I/KHhnZqMg+epZf8SCRk
         AwGw==
X-Gm-Message-State: APjAAAWHL9ayCs9Ilev3ZpB567KUOe5+uoer+Uck6JNzO9uZZfC9Wx6e
        WLoKrBO/HsIfXl0Qjx6V0ls=
X-Google-Smtp-Source: APXvYqyFoTp4GTHwwTODFW8m7jfT5hkBhvDB2HJjQ7hSv2A8UseCwnCKtbsXXVLLbyj1UO1b5qWHcQ==
X-Received: by 2002:a1c:2302:: with SMTP id j2mr113269260wmj.174.1564674805861;
        Thu, 01 Aug 2019 08:53:25 -0700 (PDT)
Received: from localhost.localdomain (x4dbd0ed1.dyn.telefonica.de. [77.189.14.209])
        by smtp.gmail.com with ESMTPSA id g17sm55434473wrm.7.2019.08.01.08.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 08:53:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] t5703: run all non-httpd-specific tests before sourcing 'lib-httpd.sh'
Date:   Thu,  1 Aug 2019 17:53:08 +0200
Message-Id: <20190801155309.15276-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.926.g602b9a0287
In-Reply-To: <20190801155309.15276-1-szeder.dev@gmail.com>
References: <20190730214000.GT20404@szeder.dev>
 <20190801155309.15276-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

't5703-upload-pack-ref-in-want.sh' sources 'lib-httpd.sh' near the end
to run a couple of httpd-specific tests, but 'lib-httpd.sh' skips all
the rest of the test script if the dependencies for running httpd
tests are not fulfilled.  However, the last six tests in 't5703' are
not httpd-specific, but they are skipped as well when httpd tests
can't be run.

Move these six tests earlier in the test script, before 'lib-httpd.sh'
is sourced, so they will be run even when httpd tests aren't.  Note
that this is not merely a pure code movement, because the setup test
case for the httpd tests needed an additional 'rm -rf
"$LOCAL_PRISTINE"' to clean up a directory left behind by the moved
non-httpd-specific tests.

Also add a comment at the end of this test script to warn against
adding non-httpd-specific tests at the end, in the hope that it will
help prevent similar issues in the future.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5703-upload-pack-ref-in-want.sh | 204 +++++++++++++++--------------
 1 file changed, 104 insertions(+), 100 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index de4b6106ef..3a2c143c6d 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -157,106 +157,6 @@ test_expect_success 'want-ref with ref we already have commit for' '
 	check_output
 '
 
-. "$TEST_DIRECTORY"/lib-httpd.sh
-start_httpd
-
-REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
-LOCAL_PRISTINE="$(pwd)/local_pristine"
-
-test_expect_success 'setup repos for change-while-negotiating test' '
-	(
-		git init "$REPO" &&
-		cd "$REPO" &&
-		>.git/git-daemon-export-ok &&
-		test_commit m1 &&
-		git tag -d m1 &&
-
-		# Local repo with many commits (so that negotiation will take
-		# more than 1 request/response pair)
-		git clone "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&
-		cd "$LOCAL_PRISTINE" &&
-		git checkout -b side &&
-		test_commit_bulk --id=s 33 &&
-
-		# Add novel commits to upstream
-		git checkout master &&
-		cd "$REPO" &&
-		test_commit m2 &&
-		test_commit m3 &&
-		git tag -d m2 m3
-	) &&
-	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_sed/repo" &&
-	git -C "$LOCAL_PRISTINE" config protocol.version 2
-'
-
-inconsistency () {
-	# Simulate that the server initially reports $2 as the ref
-	# corresponding to $1, and after that, $1 as the ref corresponding to
-	# $1. This corresponds to the real-life situation where the server's
-	# repository appears to change during negotiation, for example, when
-	# different servers in a load-balancing arrangement serve (stateless)
-	# RPCs during a single negotiation.
-	printf "s/%s/%s/" \
-	       $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
-	       $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
-	       >"$HTTPD_ROOT_PATH/one-time-sed"
-}
-
-test_expect_success 'server is initially ahead - no ref in want' '
-	git -C "$REPO" config uploadpack.allowRefInWant false &&
-	rm -rf local &&
-	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master 1234567890123456789012345678901234567890 &&
-	test_must_fail git -C local fetch 2>err &&
-	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
-'
-
-test_expect_success 'server is initially ahead - ref in want' '
-	git -C "$REPO" config uploadpack.allowRefInWant true &&
-	rm -rf local &&
-	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master 1234567890123456789012345678901234567890 &&
-	git -C local fetch &&
-
-	git -C "$REPO" rev-parse --verify master >expected &&
-	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success 'server is initially behind - no ref in want' '
-	git -C "$REPO" config uploadpack.allowRefInWant false &&
-	rm -rf local &&
-	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master "master^" &&
-	git -C local fetch &&
-
-	git -C "$REPO" rev-parse --verify "master^" >expected &&
-	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success 'server is initially behind - ref in want' '
-	git -C "$REPO" config uploadpack.allowRefInWant true &&
-	rm -rf local &&
-	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master "master^" &&
-	git -C local fetch &&
-
-	git -C "$REPO" rev-parse --verify "master" >expected &&
-	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success 'server loses a ref - ref in want' '
-	git -C "$REPO" config uploadpack.allowRefInWant true &&
-	rm -rf local &&
-	cp -r "$LOCAL_PRISTINE" local &&
-	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-sed" &&
-	test_must_fail git -C local fetch 2>err &&
-
-	test_i18ngrep "fatal: remote error: unknown ref refs/heads/raster" err
-'
-
 REPO="$(pwd)/repo"
 LOCAL_PRISTINE="$(pwd)/local_pristine"
 
@@ -372,4 +272,108 @@ test_expect_success 'fetching with wildcard that matches multiple refs' '
 	grep "want-ref refs/heads/o/bar" log
 '
 
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
+LOCAL_PRISTINE="$(pwd)/local_pristine"
+
+test_expect_success 'setup repos for change-while-negotiating test' '
+	(
+		git init "$REPO" &&
+		cd "$REPO" &&
+		>.git/git-daemon-export-ok &&
+		test_commit m1 &&
+		git tag -d m1 &&
+
+		# Local repo with many commits (so that negotiation will take
+		# more than 1 request/response pair)
+		rm -rf "$LOCAL_PRISTINE" &&
+		git clone "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&
+		cd "$LOCAL_PRISTINE" &&
+		git checkout -b side &&
+		test_commit_bulk --id=s 33 &&
+
+		# Add novel commits to upstream
+		git checkout master &&
+		cd "$REPO" &&
+		test_commit m2 &&
+		test_commit m3 &&
+		git tag -d m2 m3
+	) &&
+	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_sed/repo" &&
+	git -C "$LOCAL_PRISTINE" config protocol.version 2
+'
+
+inconsistency () {
+	# Simulate that the server initially reports $2 as the ref
+	# corresponding to $1, and after that, $1 as the ref corresponding to
+	# $1. This corresponds to the real-life situation where the server's
+	# repository appears to change during negotiation, for example, when
+	# different servers in a load-balancing arrangement serve (stateless)
+	# RPCs during a single negotiation.
+	printf "s/%s/%s/" \
+	       $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
+	       $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
+	       >"$HTTPD_ROOT_PATH/one-time-sed"
+}
+
+test_expect_success 'server is initially ahead - no ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant false &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master 1234567890123456789012345678901234567890 &&
+	test_must_fail git -C local fetch 2>err &&
+	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
+'
+
+test_expect_success 'server is initially ahead - ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master 1234567890123456789012345678901234567890 &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify master >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'server is initially behind - no ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant false &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master "master^" &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify "master^" >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'server is initially behind - ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master "master^" &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify "master" >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'server loses a ref - ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-sed" &&
+	test_must_fail git -C local fetch 2>err &&
+
+	test_i18ngrep "fatal: remote error: unknown ref refs/heads/raster" err
+'
+
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
 test_done
-- 
2.22.0.926.g602b9a0287

