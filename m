Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ED0C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 15:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiITPuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiITPuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 11:50:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D233ED7A
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:50:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q9so3039895pgq.8
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HBUurL1+ECAtmbY3wKb1F9YiJvOFCI1dWNdIGhSaoNQ=;
        b=gaqsLaWPaLF8Bqht6wvh5zCa28jAJ1toFXEeb+nFQZZrfgA4REtnMtfQSOVYa0StV2
         6FE8+WhakpbC1mhXtnk4XgYXrmffqDg5nmGOEhE7HIb29qccYhoix5ooNjQRdQSEzP8v
         vaqxu+c5mv46OGl32ISzz/gIX+6YVaBKnGFkaNE2lggaVDKFVBmXY4CvV9DnFkgThgI0
         3GpRDmehky0ayXqbqEtsGoNq8Drb9jzKZxSKwypEP8kA5jdt+ZxFC7KtXA8wphhudZJ+
         zL+VC2nl1kPXkycv5Inzh/K1QWMMMFFnvLz/zldubFrfQIjHC2B3tyDvBTy1LkeA0a9G
         Psrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HBUurL1+ECAtmbY3wKb1F9YiJvOFCI1dWNdIGhSaoNQ=;
        b=Syl2QKwBEe0wTwQbP6/16zydP00UET4kpBfw3pSliyzF19Pv6b2ddH8QUMllpr3E31
         fw1nu7HF8vSvddXMTFtVIRWfKpYXRyDU2V1kQVJfFW7IANh1sDg9M8YNdE0RP2EVsosD
         0w2a5/FoHuF5d6TvxuwB+qQ4SkQZQ26bDQNAQfYSb34ehjrfpWyETzTcDbaqA5detb6d
         GSDI8+UCEYjWFUBu3gjOXxlZoj6iWvZMKxfOlobg8cw6WhiHd+E1JxanT/hKzU/sIrte
         vuksh/TMS6KV7KcXbkTEVOgM73+lmDgZS6xMx9EYP59tFBwVFrSSgYkQiEr6ltKindbL
         MXpA==
X-Gm-Message-State: ACrzQf0dM3fqHCFUarMKwIJj9KjeDjoJraYZnpTtSdRHzNuL2PGvXUN8
        wAwO1YXEBRQoi3OsoN2Bse5che5JbNE=
X-Google-Smtp-Source: AMsMyM4Ta6CkaAabrymy9Xl9nkZGV+Vub9chFLxP61WdoQb+woLINAWP5OwtJtKzKFkX3jKtCIbPFw==
X-Received: by 2002:a05:6a00:1596:b0:540:f547:8509 with SMTP id u22-20020a056a00159600b00540f5478509mr25295376pfk.80.1663689001107;
        Tue, 20 Sep 2022 08:50:01 -0700 (PDT)
Received: from localhost.localdomain ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id 67-20020a621946000000b005379c1368e4sm26013pfz.179.2022.09.20.08.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:50:00 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/4] t: remove \{m,n\} from BRE grep usage
Date:   Tue, 20 Sep 2022 22:49:14 +0700
Message-Id: <752b12ef1e27d3b69d6aa3734309895082be7886.1663688697.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0
In-Reply-To: <cover.1663688697.git.congdanhqx@gmail.com>
References: <cover.1663688697.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

\{m,n\} is a GNU extension to BRE, and it's forbidden by our
CodingGuidelines.

Change to fixed strings or ERE.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t3200-branch.sh             | 6 ++++--
 t/t3305-notes-fanout.sh       | 2 +-
 t/t3404-rebase-interactive.sh | 6 +++---
 t/t5550-http-fetch-dumb.sh    | 2 +-
 t/t5702-protocol-v2.sh        | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9723c2827c..f05ac1fe0b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -201,8 +201,10 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
 
 test_expect_success 'git branch -M baz bam should add entries to .git/logs/HEAD' '
 	msg="Branch: renamed refs/heads/baz to refs/heads/bam" &&
-	grep " 0\{40\}.*$msg$" .git/logs/HEAD &&
-	grep "^0\{40\}.*$msg$" .git/logs/HEAD
+	zero="00000000" &&
+	zero="$zero$zero$zero$zero$zero" &&
+	grep " $zero.*$msg$" .git/logs/HEAD &&
+	grep "^$zero.*$msg$" .git/logs/HEAD
 '
 
 test_expect_success 'git branch -M should leave orphaned HEAD alone' '
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 22ffe5bcb9..aa3bb2e308 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -9,7 +9,7 @@ path_has_fanout() {
 	path=$1 &&
 	fanout=$2 &&
 	after_last_slash=$(($(test_oid hexsz) - $fanout * 2)) &&
-	echo $path | grep -q "^\([0-9a-f]\{2\}/\)\{$fanout\}[0-9a-f]\{$after_last_slash\}$"
+	echo $path | grep -q -E "^([0-9a-f][0-9a-f]/){$fanout}[0-9a-f]{$after_last_slash}$"
 }
 
 touched_one_note_with_fanout() {
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 688b01e3eb..4f5abb5ad2 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1244,9 +1244,9 @@ test_expect_success 'short commit ID collide' '
 		test $colliding_id = "$(git rev-parse HEAD | cut -c 1-4)" &&
 		grep "^pick $colliding_id " \
 			.git/rebase-merge/git-rebase-todo.tmp &&
-		grep "^pick [0-9a-f]\{$hexsz\}" \
+		grep -E "^pick [0-9a-f]{$hexsz}" \
 			.git/rebase-merge/git-rebase-todo &&
-		grep "^pick [0-9a-f]\{$hexsz\}" \
+		grep -E "^pick [0-9a-f]{$hexsz}" \
 			.git/rebase-merge/git-rebase-todo.backup &&
 		git rebase --continue
 	) &&
@@ -1261,7 +1261,7 @@ test_expect_success 'respect core.abbrev' '
 		set_cat_todo_editor &&
 		test_must_fail git rebase -i HEAD~4 >todo-list
 	) &&
-	test 4 = $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
+	test 4 = $(grep -c -E "pick [0-9a-f]{12,}" todo-list)
 '
 
 test_expect_success 'todo count' '
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index d7cf85ffea..8f182a3cbf 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -234,7 +234,7 @@ test_expect_success 'http-fetch --packfile' '
 		--index-pack-arg=--keep \
 		"$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
 
-	grep "^keep.[0-9a-f]\{16,\}$" out &&
+	grep -E "^keep.[0-9a-f]{16,}$" out &&
 	cut -c6- out >packhash &&
 
 	# Ensure that the expected files are generated
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5d42a355a8..b33cd4afca 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1001,7 +1001,7 @@ test_expect_success 'part of packfile response provided as URI' '
 	do
 		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
 		{
-			grep "^[0-9a-f]\{16,\} " out || :
+			grep -E "^[0-9a-f]{16,} " out || :
 		} >out.objectlist &&
 		if test_line_count = 1 out.objectlist
 		then
-- 
2.38.0.rc0

