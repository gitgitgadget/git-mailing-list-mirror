Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD8AC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F353221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5E73gkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHFUJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFUJH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 16:09:07 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6A6C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 13:09:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id t6so40249136ljk.9
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 13:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFC7cPJ9u+dvJEohR9vXv5K9OiPyUvXjvi96cLheFNw=;
        b=r5E73gkZ5NAuJMDWp4VRUHYuOTUlv+PT9jrHJ4QgcVyQZGaIWacfHFT0mvLO8Es4e2
         dx3ZzUUDkaFEKFYXFF2FNXV1OKfydMGdML8JtHREOwl4GiZCcH6eymOSLcDSoYKlwFiv
         h7xNHbQ/bmkYGAHBx76YqB1qKKbvsElLSUCkX0ecDQH8AoGz/fz5ekiywql/zsMBTH8s
         pwJUFhfx0K+51tDVaICAFo5XegEfj22JFzyuwJZr39nQqh5r05rdDnLj6sMyqInYWxBh
         Ni6T+tKZ2xvyhTcsuqYWoTEAVznY3GDAX3oTgKGWFvuWJNLJzH8Dw4Me3uUsBJrIE7SN
         W7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFC7cPJ9u+dvJEohR9vXv5K9OiPyUvXjvi96cLheFNw=;
        b=FW8GRhhoeXo0AneTQNN+64nzy6e+g0YypqcgGInvi/DEpsvTieLuwQz2Z7bOItfGzi
         V0IUun4tchooK/z0Y9vOIfUAIkZ+O42xqKu2rqOc1+AJKG5t7IGpIZDiKCWwbJ4q+CkT
         VQTB+duPBj0By3+Aw+yW7BSPrnI6cEgT/HpUOTA01IvCwqmV1kTXbnGk4s+BY5A4058A
         QS7BqE4eqBwaOhwAkj7ZAYht41tVvtSz+rZrhkwCoTCm5cUm08N+HIHX57sJl9qX1Bha
         QxdiT97G7Ezud8U59FdkIHhSrv8Xq5FCWxPQfuSAYo4WL2MMN0mKbD9hwNCx7G3GKEpD
         +9Ig==
X-Gm-Message-State: AOAM533KeV8gN96w0jXV6WDgJXgX5nUZ4qWpa8PjXxyszigCXEqFCig0
        vOqK/xgH7h8K3yRuiE3Z7W8XZgcq
X-Google-Smtp-Source: ABdhPJwVcvxF/XrbUfLTwmlxPkz2rUmZN5SvoTAQW3hMvgdCBBrC5wnqDpYr53ANhrfEpq4MTAibSg==
X-Received: by 2002:a2e:2d0a:: with SMTP id t10mr4362108ljt.249.1596744544868;
        Thu, 06 Aug 2020 13:09:04 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id k84sm3436130lfd.90.2020.08.06.13.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 13:09:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v2 0/2] t: don't spuriously close and reopen quotes
Date:   Thu,  6 Aug 2020 22:08:52 +0200
Message-Id: <cover.1596742823.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.199.g4234a9100e
In-Reply-To: <20200802143018.5501-1-martin.agren@gmail.com>
References: <20200802143018.5501-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an updated version of the patch I posted inline in [1]. I've
tweaked the end result a bit and pulled out the modifications to t4104
to their own patch. t4104 is also where most of the interdiff is spent.

I've updated the commit message of the main patch based on the
discussion in the earlier thread.

[1] https://lore.kernel.org/git/20200802143018.5501-1-martin.agren@gmail.com/

Martin Ågren (2):
  t: don't spuriously close and reopen quotes
  t4104: modernize and simplify quoting

 t/t1400-update-ref.sh           |  2 +-
 t/t3501-revert-cherry-pick.sh   |  4 +--
 t/t3507-cherry-pick-conflict.sh |  4 +--
 t/t4005-diff-rename-2.sh        |  4 +--
 t/t4034-diff-words.sh           |  2 +-
 t/t4104-apply-boundary.sh       | 57 +++++++++------------------------
 t/t4150-am.sh                   |  8 ++---
 t/t4200-rerere.sh               |  2 +-
 t/t5302-pack-index.sh           |  2 +-
 t/t5510-fetch.sh                |  4 +--
 t/t5553-set-upstream.sh         |  6 ++--
 t/t6026-merge-attr.sh           |  4 +--
 t/t7001-mv.sh                   |  2 +-
 t/t7600-merge.sh                |  6 ++--
 t/t9001-send-email.sh           | 10 +++---
 t/t9100-git-svn-basic.sh        |  6 ++--
 t/t9401-git-cvsserver-crlf.sh   |  8 ++---
 t/t9402-git-cvsserver-refs.sh   |  2 +-
 18 files changed, 53 insertions(+), 80 deletions(-)

Interdiff against v1:
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index 19f08d9ccd..71ef4132d1 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -3,80 +3,55 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-test_description='git apply boundary tests
+test_description='git apply boundary tests'
 
-'
 . ./test-lib.sh
 
 L="c d e f g h i j k l m n o p q r s t u v w x"
 
 test_expect_success setup '
-	for i in b $L y
-	do
-		echo $i
-	done >victim &&
+	test_write_lines b $L y >victim &&
 	cat victim >original &&
 	git update-index --add victim &&
 
 	# add to the head
-	for i in a b $L y
-	do
-		echo $i
-	done >victim &&
+	test_write_lines a b $L y >victim &&
 	cat victim >add-a-expect &&
 	git diff victim >add-a-patch.with &&
 	git diff --unified=0 >add-a-patch.without &&
 
 	# insert at line two
-	for i in b a $L y
-	do
-		echo $i
-	done >victim &&
+	test_write_lines b a $L y >victim &&
 	cat victim >insert-a-expect &&
 	git diff victim >insert-a-patch.with &&
 	git diff --unified=0 >insert-a-patch.without &&
 
 	# modify at the head
-	for i in a $L y
-	do
-		echo $i
-	done >victim &&
+	test_write_lines a $L y >victim &&
 	cat victim >mod-a-expect &&
 	git diff victim >mod-a-patch.with &&
 	git diff --unified=0 >mod-a-patch.without &&
 
 	# remove from the head
-	for i in $L y
-	do
-		echo $i
-	done >victim &&
+	test_write_lines $L y >victim &&
 	cat victim >del-a-expect &&
 	git diff victim >del-a-patch.with &&
 	git diff --unified=0 >del-a-patch.without &&
 
 	# add to the tail
-	for i in b $L y z
-	do
-		echo $i
-	done >victim &&
+	test_write_lines b $L y z >victim &&
 	cat victim >add-z-expect &&
 	git diff victim >add-z-patch.with &&
 	git diff --unified=0 >add-z-patch.without &&
 
 	# modify at the tail
-	for i in b $L z
-	do
-		echo $i
-	done >victim &&
+	test_write_lines b $L z >victim &&
 	cat victim >mod-z-expect &&
 	git diff victim >mod-z-patch.with &&
 	git diff --unified=0 >mod-z-patch.without &&
 
 	# remove from the tail
-	for i in b $L
-	do
-		echo $i
-	done >victim &&
+	test_write_lines b $L >victim &&
 	cat victim >del-z-expect &&
 	git diff victim >del-z-patch.with &&
 	git diff --unified=0 >del-z-patch.without
@@ -88,15 +63,15 @@ for with in with without
 do
 	case "$with" in
 	with) u= ;;
-	without) u='--unidiff-zero ' ;;
+	without) u=--unidiff-zero ;;
 	esac
 	for kind in add-a add-z insert-a mod-a mod-z del-a del-z
 	do
 		test_expect_success "apply $kind-patch $with context" '
 			cat original >victim &&
 			git update-index victim &&
-			git apply --index $u$kind-patch.$with &&
-			test_cmp $kind-expect victim
+			git apply --index $u "$kind-patch.$with" &&
+			test_cmp "$kind-expect" victim
 		'
 	done
 done
@@ -110,13 +85,12 @@ do
 	test_expect_success "apply non-git $kind-patch without context" '
 		cat original >victim &&
 		git update-index victim &&
-		git apply --unidiff-zero --index $kind-ng.without &&
-		test_cmp $kind-expect victim
+		git apply --unidiff-zero --index "$kind-ng.without" &&
+		test_cmp "$kind-expect" victim
 	'
 done
 
 test_expect_success 'two lines' '
-
 	>file &&
 	git add file &&
 	echo aaa >file &&
@@ -125,11 +99,10 @@ test_expect_success 'two lines' '
 	echo bbb >file &&
 	git add file &&
 	test_must_fail git apply --check patch
-
 '
 
 test_expect_success 'apply patch with 3 context lines matching at end' '
-	{ echo a; echo b; echo c; echo d; } >file &&
+	test_write_lines a b c d >file &&
 	git add file &&
 	echo e >>file &&
 	git diff >patch &&
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 1f9d13819f..e9c575c359 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -63,7 +63,7 @@ test_expect_success "$name" '
 
 
 name='detect node change from file to directory #1'
-test_expect_success "$name" "
+test_expect_success "$name" '
 	mkdir dir/new_file &&
 	mv dir/file dir/new_file/file &&
 	mv dir/new_file dir/file &&
@@ -72,7 +72,7 @@ test_expect_success "$name" "
 	git commit -m "$name" &&
 	test_must_fail git svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch
-"
+'
 
 
 name='detect node change from directory to file #1'
-- 
2.28.0.199.g4234a9100e

