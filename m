Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1069CECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 15:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiITPuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiITPuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 11:50:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674E53DF1F
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:50:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fv3so3574443pjb.0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XqD2gra4AvDRoF0i95hWhwHmO+HI7tT0NJdGXcs/RQE=;
        b=TgFlPsnN0IPJ0zh5jg7uSADMMVfyyxF8V9K/wKV/n6R/T2z3UZCZMgICTD3e7KGMGR
         MNuLrGqGB/fVyOahozK4/AqoJ9I0/sAM+IaKc2S30STMtCn61bac7So26/C5hFqaOELu
         Kp2b/rhD7G0SNXtA5FKxMg/iCNizK9o+4YW/5EwrU5OczDSc+MnK+xVxj/76ERu9LPFt
         Cztf+LoJOTV+F2I7jbzzdWgXT6d0Izxb/6lVMyxu/WD9AD8WXLxWYtvz3Q3j22b3iGfF
         eiJPuQXuIwz944TR08u6RzHbB3zGwrVs64lyHpyG9sgnOhOn041lLMozdEkEUSdrUMxH
         zPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XqD2gra4AvDRoF0i95hWhwHmO+HI7tT0NJdGXcs/RQE=;
        b=zleZeQfktuazBIazUNMNWBCqLWo6Oy3Am4CXN8TRM7dRtzfMh10gg8i6MKSIKJpjmF
         LJWW1UV9FKBUbp3qgAvY4jXpmygUaMgUsp76kXz+XV2j1pOQMGfx4jdzfMlLNX3D6hK/
         wyJMGp5aUtj1DQPziiEutC8uRoeGSuhjRgrucNMNDm832zeQzmTKWhHIO43Pb6L7LY/1
         UfTN0ReoHcHh4qM7fdiLWdkTBHKVsJIc+nC8epsnER6S6ZJAH+s7Rirz72RY7wUeZUcR
         dHsG4lmWrt/JbvovAZ0zLa9hueDvOsCUe8BbzZfJ/9HcXtX5CifH2g+bKd6S/4+Iw6Ah
         hyVA==
X-Gm-Message-State: ACrzQf29NRjE1bsiP3HfQLEk8POswEOuGWqJYYD3ycSGDrBkZa6J3s1K
        pOjsakeILGxC+Uqh5u6g4Pkicwx5pZ8=
X-Google-Smtp-Source: AMsMyM7MkQHDQr/4D3LyGOQmovD5+axysnKWBx6d2JwsH93+ieL/vJXjzPbX4VLDhPrdv6J1lRLhrA==
X-Received: by 2002:a17:902:ea11:b0:176:b283:9589 with SMTP id s17-20020a170902ea1100b00176b2839589mr322488plg.65.1663689006277;
        Tue, 20 Sep 2022 08:50:06 -0700 (PDT)
Received: from localhost.localdomain ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id 67-20020a621946000000b005379c1368e4sm26013pfz.179.2022.09.20.08.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:50:05 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 4/4] t: convert fgrep usage to "grep -F"
Date:   Tue, 20 Sep 2022 22:49:16 +0700
Message-Id: <213412d2f747de7e3b3504630cb6fcc1b96c46c7.1663688697.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0
In-Reply-To: <cover.1663688697.git.congdanhqx@gmail.com>
References: <cover.1663688697.git.congdanhqx@gmail.com>
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
index e18a218952..a00cdba049 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -49,7 +49,7 @@ test_expect_success 'result is really identical' '
 test_expect_success 'rewrite bare repository identically' '
 	(git config core.bare true && cd .git &&
 	 git filter-branch branch > filter-output 2>&1 &&
-	! fgrep fatal filter-output)
+	! grep -F fatal filter-output)
 '
 git config core.bare false
 test_expect_success 'result is really identical' '
@@ -506,7 +506,7 @@ test_expect_success 'rewrite repository including refs that point at non-commit
 	git tag -a -m "tag to a tree" treetag $new_tree &&
 	git reset --hard HEAD &&
 	git filter-branch -f -- --all >filter-output 2>&1 &&
-	! fgrep fatal filter-output
+	! grep -F fatal filter-output
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
index 4a77eb9f60..21b5d285d5 100755
--- a/t/t9134-git-svn-ignore-paths.sh
+++ b/t/t9134-git-svn-ignore-paths.sh
@@ -43,7 +43,7 @@ test_expect_success 'init+fetch an SVN repository with ignored www directory' '
 test_expect_success 'verify ignore-paths config saved by clone' '
 	(
 	    cd g &&
-	    git config --get svn-remote.svn.ignore-paths | fgrep "www"
+	    git config --get svn-remote.svn.ignore-paths | grep -F "www"
 	)
 '
 
@@ -53,7 +53,7 @@ test_expect_success 'SVN-side change outside of www' '
 		echo b >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change outside of www" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change outside of www"
+		svn_cmd log -v | grep -F "SVN-side change outside of www"
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
+		svn_cmd log -v | grep -F "SVN-side change in and out of ignored www"
 	)
 '
 
diff --git a/t/t9140-git-svn-reset.sh b/t/t9140-git-svn-reset.sh
index e855904629..b3c9425d55 100755
--- a/t/t9140-git-svn-reset.sh
+++ b/t/t9140-git-svn-reset.sh
@@ -43,7 +43,7 @@ test_expect_success 'fetch fails on modified hidden file' '
 	  git svn find-rev refs/remotes/git-svn > ../expect &&
 	  test_must_fail git svn fetch 2> ../errors &&
 	  git svn find-rev refs/remotes/git-svn > ../expect2 ) &&
-	fgrep "not found in commit" errors &&
+	grep -F "not found in commit" errors &&
 	test_cmp expect expect2
 '
 
@@ -59,7 +59,7 @@ test_expect_success 'refetch succeeds not ignoring any files' '
 	( cd g &&
 	  git svn fetch &&
 	  git svn rebase &&
-	  fgrep "mod hidden" hid/hid.txt
+	  grep -F "mod hidden" hid/hid.txt
 	)
 '
 
diff --git a/t/t9147-git-svn-include-paths.sh b/t/t9147-git-svn-include-paths.sh
index 257fc8f2f8..e53bfc02f6 100755
--- a/t/t9147-git-svn-include-paths.sh
+++ b/t/t9147-git-svn-include-paths.sh
@@ -45,7 +45,7 @@ test_expect_success 'init+fetch an SVN repository with included qqq directory' '
 test_expect_success 'verify include-paths config saved by clone' '
 	(
 	    cd g &&
-	    git config --get svn-remote.svn.include-paths | fgrep "qqq"
+	    git config --get svn-remote.svn.include-paths | grep -F "qqq"
 	)
 '
 
@@ -55,7 +55,7 @@ test_expect_success 'SVN-side change outside of www' '
 		echo b >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change outside of www" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change outside of www"
+		svn_cmd log -v | grep -F "SVN-side change outside of www"
 	)
 '
 
@@ -87,7 +87,7 @@ test_expect_success 'SVN-side change inside of ignored www' '
 		echo zaq >> www/test_www.txt &&
 		svn_cmd commit -m "SVN-side change inside of www/test_www.txt" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change inside of www/test_www.txt"
+		svn_cmd log -v | grep -F "SVN-side change inside of www/test_www.txt"
 	)
 '
 
@@ -120,7 +120,7 @@ test_expect_success 'SVN-side change in and out of included qqq' '
 		echo ygg >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
+		svn_cmd log -v | grep -F "SVN-side change in and out of ignored www"
 	)
 '
 
-- 
2.38.0.rc0

