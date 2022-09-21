Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017B4C32771
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 13:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiIUNDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiIUNDM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 09:03:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF04C915C5
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 06:03:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso5785823pjd.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4pkCEb3o+XAk2213qORRYj50wdwYZOdJwsF8v2cXkZ4=;
        b=XwuA68BSdXD17cVLDXyNVNRqlRdmU+CYpecS0ir/xBVnFA8daDhn9MpLTKTZWHdECU
         eCWybauZ9XgjBp4goN8aNuGBFQL0CY9jdVNDP0F1q+yZ3lsamtpDav1eddNvMwCgzuXZ
         WQMphVJ+nrLMA4UBSNIoLi1f0fQTrc2XOw5Om9fad1vj7HrES+xM7EU0yuNkz6xhEyEZ
         KUQS+PmvvfH6uc2Bv88/sxqc6Tc94J9gD4yN1mhDyZmRdFfUHq2EkvpC0c37dJUEJWyA
         yKoow2RRdCbhOJPoEnH+4OnyHFnGgcyU2qqb3npe2r/lY5ANjSjf1TrXrs0ClcJtUxpm
         Q0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4pkCEb3o+XAk2213qORRYj50wdwYZOdJwsF8v2cXkZ4=;
        b=GNlpo7pmV0F+h9m0ZxDtitzcfwJWHDglEP0R7OMfA9pRSlREJrPGZ3lPgeM+X5acF3
         zJb71DLBoX7sm8p9twT+uSWdLY3x/i+WyUoycV9td9As8ZrDqJqmU3cwtRNwpvVO55oS
         HrCI6s+5Q+nQXWQouwlC8Bf2CLoYpdC1AHAr9mSaWn7OHXylheJ2gmTSPfiS88uZyBT2
         mHp8zAw750jzp9m9zX4v8Sgk93pNIv9XPWxnAPh7Soe+lPwPjeYan/1Lh9kietncstOH
         hIlXeaQUwvpYL7pCjU/9nOjNBcqMlRw+JzuiHXxSlQ9YguBKrrjRH74pQ6hnoOBzj/DE
         F9+A==
X-Gm-Message-State: ACrzQf3CbftKhWQnRmVQCJJBJWdfhDGlqznOrYW6P7RAyBu+pBakvmKe
        f2Wpax4gR8tuMHQNf30zXOjlaR/BVuM=
X-Google-Smtp-Source: AMsMyM7yizMbchH40mSYR/jJ//id4SglzcSUMk4rlfROpSuuWTnsPPahTckh/sxLivDsjYndEdwKHg==
X-Received: by 2002:a17:903:2445:b0:178:38ee:70f with SMTP id l5-20020a170903244500b0017838ee070fmr4647684pls.164.1663765387380;
        Wed, 21 Sep 2022 06:03:07 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:5008:db00:84c8:158c:9494:ee57])
        by smtp.gmail.com with ESMTPSA id i64-20020a625443000000b0053e5daf1a25sm2084332pfb.45.2022.09.21.06.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 06:03:06 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] t: convert fgrep usage to "grep -F"
Date:   Wed, 21 Sep 2022 20:02:32 +0700
Message-Id: <b65a3d7749dbe77bc57c0245b5c0752c923b6714.1663765176.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0
In-Reply-To: <cover.1663765176.git.congdanhqx@gmail.com>
References: <cover.1663765176.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite POSIX states that:

> The old egrep and fgrep commands are likely to be supported for many
> years to come as implementation extensions, allowing historical
> applications to operate unmodified.

GNU grep 3.8 started to warn[1]:

> The egrep and fgrep commands, which have been deprecated since
> release 2.5.3 (2007), now warn that they are obsolescent and should
> be replaced by grep -E and grep -F.

Prepare for their removal in the future.

[1]: https://lists.gnu.org/archive/html/info-gnu/2022-09/msg00001.html

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t3700-add.sh                     | 2 +-
 t/t7003-filter-branch.sh           | 4 ++--
 t/t9133-git-svn-nested-git-repo.sh | 6 +++---
 t/t9134-git-svn-ignore-paths.sh    | 8 ++++----
 t/t9140-git-svn-reset.sh           | 4 ++--
 t/t9147-git-svn-include-paths.sh   | 8 ++++----
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 8689b48589..51afbd7b24 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -291,7 +291,7 @@ test_expect_success BSLASHPSPEC "git add 'fo\\[ou\\]bar' ignores foobar" '
 	git reset --hard &&
 	touch fo\[ou\]bar foobar &&
 	git add '\''fo\[ou\]bar'\'' &&
-	git ls-files fo\[ou\]bar | fgrep fo\[ou\]bar &&
+	git ls-files fo\[ou\]bar | grep -F fo\[ou\]bar &&
 	! ( git ls-files foobar | grep foobar )
 '
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e18a218952..f6aebe92ff 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -49,7 +49,7 @@ test_expect_success 'result is really identical' '
 test_expect_success 'rewrite bare repository identically' '
 	(git config core.bare true && cd .git &&
 	 git filter-branch branch > filter-output 2>&1 &&
-	! fgrep fatal filter-output)
+	! grep fatal filter-output)
 '
 git config core.bare false
 test_expect_success 'result is really identical' '
@@ -506,7 +506,7 @@ test_expect_success 'rewrite repository including refs that point at non-commit
 	git tag -a -m "tag to a tree" treetag $new_tree &&
 	git reset --hard HEAD &&
 	git filter-branch -f -- --all >filter-output 2>&1 &&
-	! fgrep fatal filter-output
+	! grep fatal filter-output
 '
 
 test_expect_success 'filter-branch handles ref deletion' '
diff --git a/t/t9133-git-svn-nested-git-repo.sh b/t/t9133-git-svn-nested-git-repo.sh
index f894860867..d8d536269c 100755
--- a/t/t9133-git-svn-nested-git-repo.sh
+++ b/t/t9133-git-svn-nested-git-repo.sh
@@ -35,7 +35,7 @@ test_expect_success 'SVN-side change outside of .git' '
 		echo b >> a &&
 		svn_cmd commit -m "SVN-side change outside of .git" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change outside of .git"
+		svn_cmd log -v | grep -F "SVN-side change outside of .git"
 	)
 '
 
@@ -59,7 +59,7 @@ test_expect_success 'SVN-side change inside of .git' '
 		svn_cmd add --force .git &&
 		svn_cmd commit -m "SVN-side change inside of .git" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change inside of .git"
+		svn_cmd log -v | grep -F "SVN-side change inside of .git"
 	)
 '
 
@@ -82,7 +82,7 @@ test_expect_success 'SVN-side change in and out of .git' '
 		git commit -m "add a inside an SVN repo" &&
 		svn_cmd commit -m "SVN-side change in and out of .git" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change in and out of .git"
+		svn_cmd log -v | grep -F "SVN-side change in and out of .git"
 	)
 '
 
diff --git a/t/t9134-git-svn-ignore-paths.sh b/t/t9134-git-svn-ignore-paths.sh
index 4a77eb9f60..3188400226 100755
--- a/t/t9134-git-svn-ignore-paths.sh
+++ b/t/t9134-git-svn-ignore-paths.sh
@@ -43,7 +43,7 @@ test_expect_success 'init+fetch an SVN repository with ignored www directory' '
 test_expect_success 'verify ignore-paths config saved by clone' '
 	(
 	    cd g &&
-	    git config --get svn-remote.svn.ignore-paths | fgrep "www"
+	    git config --get svn-remote.svn.ignore-paths | grep www
 	)
 '
 
@@ -53,7 +53,7 @@ test_expect_success 'SVN-side change outside of www' '
 		echo b >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change outside of www" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change outside of www"
+		svn_cmd log -v | grep "SVN-side change outside of www"
 	)
 '
 
@@ -85,7 +85,7 @@ test_expect_success 'SVN-side change inside of ignored www' '
 		echo zaq >> www/test_www.txt &&
 		svn_cmd commit -m "SVN-side change inside of www/test_www.txt" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change inside of www/test_www.txt"
+		svn_cmd log -v | grep -F "SVN-side change inside of www/test_www.txt"
 	)
 '
 
@@ -118,7 +118,7 @@ test_expect_success 'SVN-side change in and out of ignored www' '
 		echo ygg >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
+		svn_cmd log -v | grep "SVN-side change in and out of ignored www"
 	)
 '
 
diff --git a/t/t9140-git-svn-reset.sh b/t/t9140-git-svn-reset.sh
index e855904629..a420b2a87a 100755
--- a/t/t9140-git-svn-reset.sh
+++ b/t/t9140-git-svn-reset.sh
@@ -43,7 +43,7 @@ test_expect_success 'fetch fails on modified hidden file' '
 	  git svn find-rev refs/remotes/git-svn > ../expect &&
 	  test_must_fail git svn fetch 2> ../errors &&
 	  git svn find-rev refs/remotes/git-svn > ../expect2 ) &&
-	fgrep "not found in commit" errors &&
+	grep "not found in commit" errors &&
 	test_cmp expect expect2
 '
 
@@ -59,7 +59,7 @@ test_expect_success 'refetch succeeds not ignoring any files' '
 	( cd g &&
 	  git svn fetch &&
 	  git svn rebase &&
-	  fgrep "mod hidden" hid/hid.txt
+	  grep "mod hidden" hid/hid.txt
 	)
 '
 
diff --git a/t/t9147-git-svn-include-paths.sh b/t/t9147-git-svn-include-paths.sh
index 257fc8f2f8..63fa0b6732 100755
--- a/t/t9147-git-svn-include-paths.sh
+++ b/t/t9147-git-svn-include-paths.sh
@@ -45,7 +45,7 @@ test_expect_success 'init+fetch an SVN repository with included qqq directory' '
 test_expect_success 'verify include-paths config saved by clone' '
 	(
 	    cd g &&
-	    git config --get svn-remote.svn.include-paths | fgrep "qqq"
+	    git config --get svn-remote.svn.include-paths | grep qqq
 	)
 '
 
@@ -55,7 +55,7 @@ test_expect_success 'SVN-side change outside of www' '
 		echo b >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change outside of www" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change outside of www"
+		svn_cmd log -v | grep "SVN-side change outside of www"
 	)
 '
 
@@ -87,7 +87,7 @@ test_expect_success 'SVN-side change inside of ignored www' '
 		echo zaq >> www/test_www.txt &&
 		svn_cmd commit -m "SVN-side change inside of www/test_www.txt" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change inside of www/test_www.txt"
+		svn_cmd log -v | grep "SVN-side change inside of www/test_www.txt"
 	)
 '
 
@@ -120,7 +120,7 @@ test_expect_success 'SVN-side change in and out of included qqq' '
 		echo ygg >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
+		svn_cmd log -v | grep "SVN-side change in and out of ignored www"
 	)
 '
 
-- 
2.38.0.rc0

