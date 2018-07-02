Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35571F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932102AbeGBAZk (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:40 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37223 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeGBAZL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:11 -0400
Received: by mail-it0-f67.google.com with SMTP id p17-v6so9843767itc.2
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=spXL3njpUO7SGzRzrkVbzXAlIEpH2dYTc2Hl7WWiuKY=;
        b=PX8Ar7PGuc28f9mVenK/ZVUyYnKVjngDt8ti7P325A2MH4OCoFk3l0g+Uze0/CCInt
         HpdDCU7FawA8534D+TPx7y9yu439aU7uZ7ea/HpaKrZSAref8mq3WhnHmCpg6W5LB3cl
         QydmbvxzPw7XDIFn4iQcL0VfDrKGPHRVDFJPKDR9gU8I0V2GHVb7NUypLcUXuDGqbYl7
         5S+pySuTOi0lZBWz74XJofW0dojpPoZzLkvjdotpC9O4MUqxVNYxu5jCbTsAKUVYL89a
         xo3C5uXGpL/Q7TEgtHkOBhrG+FQIpcr0UStIDUXpIKmBlFuMpYlzUmcrsOmCeDn6/2zt
         QnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=spXL3njpUO7SGzRzrkVbzXAlIEpH2dYTc2Hl7WWiuKY=;
        b=kV5NNC5CHMiljJ3KZeKPnQ6YW0VRfYVC9M9W9cZYvXYM8HQbQRtMM5/dpk5XytkmKE
         b/k7dEWlxJy0dEguoD2BchLA8iWymiSXUsV+rsNgU3sqMf1hQwEV53VTAn76jomAoKLe
         NG/UcG6ncXZVK/SwhzxYNe/A8MT3LQ5Y7J7ZF95lzPekTBirRJ1LZXlrgXNIaoO3uIbQ
         j+kybLtXAka+0tQNHXrrE99NsPeb1SIxseNah5gMFUtQZF8GEY9fz2HbJm7Y1jrPcRJC
         XeQkbHPffpZOJPqBW/gbgqfDnsxFgClEJS9MBz3n2h2j55DzGEUFerYpKxHNnrftP2E6
         nMEw==
X-Gm-Message-State: APt69E1A9EztN1y3h/e9d+bEwJ1B5iBCMKAcgnwsPA4u9+jOcaHfLB7+
        adOe14TKzBxltBMYiyBqBHLnrw==
X-Google-Smtp-Source: AAOMgpfjjaZYrCom+q71qUEK/bCH3bkG+0J0hRlz2Rbmd0Xo9fvqAklNig/+/MYNZDYcYWB5iUUHkA==
X-Received: by 2002:a24:1dd6:: with SMTP id 205-v6mr8096362itj.132.1530491109789;
        Sun, 01 Jul 2018 17:25:09 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:09 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 21/25] t5000-t5999: fix broken &&-chains
Date:   Sun,  1 Jul 2018 20:24:01 -0400
Message-Id: <20180702002405.3042-22-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t5300-pack-object.sh         |  2 +-
 t/t5302-pack-index.sh          |  2 +-
 t/t5401-update-hooks.sh        |  4 ++--
 t/t5500-fetch-pack.sh          |  2 +-
 t/t5505-remote.sh              |  2 +-
 t/t5512-ls-remote.sh           |  4 ++--
 t/t5516-fetch-push.sh          | 10 +++++-----
 t/t5517-push-mirror.sh         | 10 +++++-----
 t/t5526-fetch-submodules.sh    |  2 +-
 t/t5531-deep-submodule-push.sh |  2 +-
 t/t5543-atomic-push.sh         |  2 +-
 t/t5601-clone.sh               |  2 +-
 t/t5605-clone-local.sh         |  2 +-
 t/t5801-remote-helpers.sh      |  2 +-
 14 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 2336d09dcc..6c620cd540 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -191,7 +191,7 @@ test_expect_success 'survive missing objects/pack directory' '
 		mkdir missing-pack &&
 		cd missing-pack &&
 		git init &&
-		GOP=.git/objects/pack
+		GOP=.git/objects/pack &&
 		rm -fr $GOP &&
 		git index-pack --stdin --keep=test <../test-3-${packname_3}.pack &&
 		test -f $GOP/pack-${packname_3}.pack &&
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index bb9b8bb309..91d51b35f9 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -237,7 +237,7 @@ test_expect_success 'running index-pack in the object store' '
     rm -f .git/objects/pack/* &&
     cp test-1-${pack1}.pack .git/objects/pack/pack-${pack1}.pack &&
     (
-	cd .git/objects/pack
+	cd .git/objects/pack &&
 	git index-pack pack-${pack1}.pack
     ) &&
     test -f .git/objects/pack/pack-${pack1}.idx
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 7f278d8ce9..b5f886a0e2 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -82,13 +82,13 @@ test_expect_success 'hooks ran' '
 '
 
 test_expect_success 'pre-receive hook input' '
-	(echo $commit0 $commit1 refs/heads/master;
+	(echo $commit0 $commit1 refs/heads/master &&
 	 echo $commit1 $commit0 refs/heads/tofail
 	) | test_cmp - victim.git/pre-receive.stdin
 '
 
 test_expect_success 'update hook arguments' '
-	(echo refs/heads/master $commit0 $commit1;
+	(echo refs/heads/master $commit0 $commit1 &&
 	 echo refs/heads/tofail $commit1 $commit0
 	) | test_cmp - victim.git/update.args
 '
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index ea6570e819..ebbbbfe054 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -259,7 +259,7 @@ test_expect_success 'clone shallow object count' '
 test_expect_success 'pull in shallow repo with missing merge base' '
 	(
 		cd shallow &&
-		git fetch --depth 4 .. A
+		git fetch --depth 4 .. A &&
 		test_must_fail git merge --allow-unrelated-histories FETCH_HEAD
 	)
 '
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 3552b51b4c..11e14a1e0f 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -844,7 +844,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)'
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
 		test "$(git config remote.origin.url)" = "quux" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/foom:refs/heads/origin"
+		test "$(git config remote.origin.fetch)" = "refs/heads/foom:refs/heads/origin" &&
 		test "$(git config remote.origin.push)" = "HEAD:refs/heads/foom"
 	)
 '
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 6a949484d0..ea020040e8 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -15,7 +15,7 @@ test_expect_success setup '
 	git tag mark1.10 &&
 	git show-ref --tags -d | sed -e "s/ /	/" >expected.tag &&
 	(
-		echo "$(git rev-parse HEAD)	HEAD"
+		echo "$(git rev-parse HEAD)	HEAD" &&
 		git show-ref -d	| sed -e "s/ /	/"
 	) >expected.all &&
 
@@ -105,7 +105,7 @@ test_expect_success 'use branch.<name>.remote if possible' '
 	git clone . other.git &&
 	(
 		cd other.git &&
-		echo "$(git rev-parse HEAD)	HEAD"
+		echo "$(git rev-parse HEAD)	HEAD" &&
 		git show-ref	| sed -e "s/ /	/"
 	) >exp &&
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index a5077d8b7c..bd8f23e430 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -923,7 +923,7 @@ test_expect_success 'push into aliased refs (consistent)' '
 	(
 		cd child1 &&
 		git branch foo &&
-		git symbolic-ref refs/heads/bar refs/heads/foo
+		git symbolic-ref refs/heads/bar refs/heads/foo &&
 		git config receive.denyCurrentBranch false
 	) &&
 	(
@@ -945,7 +945,7 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	(
 		cd child1 &&
 		git branch foo &&
-		git symbolic-ref refs/heads/bar refs/heads/foo
+		git symbolic-ref refs/heads/bar refs/heads/foo &&
 		git config receive.denyCurrentBranch false
 	) &&
 	(
@@ -1011,7 +1011,7 @@ test_expect_success 'push --porcelain rejected' '
 	mk_empty testrepo &&
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(cd testrepo &&
-		git reset --hard origin/master^
+		git reset --hard origin/master^ &&
 		git config receive.denyCurrentBranch true) &&
 
 	echo >.git/foo  "To testrepo"  &&
@@ -1025,7 +1025,7 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 	mk_empty testrepo &&
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(cd testrepo &&
-		git reset --hard origin/master
+		git reset --hard origin/master &&
 		git config receive.denyCurrentBranch true) &&
 
 	echo >.git/foo  "To testrepo"  &&
@@ -1333,7 +1333,7 @@ test_expect_success 'push --follow-tag only pushes relevant tags' '
 		git commit --allow-empty -m "future commit" &&
 		git tag -m "future" future &&
 		git checkout master &&
-		git for-each-ref refs/heads/master refs/tags/tag >../expect
+		git for-each-ref refs/heads/master refs/tags/tag >../expect &&
 		git push --follow-tag ../dst master
 	) &&
 	(
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index 02f160aae0..c05a661400 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -71,7 +71,7 @@ test_expect_success 'push mirror force updates existing branches' '
 		git push --mirror up &&
 		echo two >foo && git add foo && git commit -m two &&
 		git push --mirror up &&
-		git reset --hard HEAD^
+		git reset --hard HEAD^ &&
 		git push --mirror up
 	) &&
 	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
@@ -88,7 +88,7 @@ test_expect_success 'push mirror removes branches' '
 		echo one >foo && git add foo && git commit -m one &&
 		git branch remove master &&
 		git push --mirror up &&
-		git branch -D remove
+		git branch -D remove &&
 		git push --mirror up
 	) &&
 	(
@@ -170,7 +170,7 @@ test_expect_success 'push mirror force updates existing tags' '
 		echo two >foo && git add foo && git commit -m two &&
 		git tag -f tmaster master &&
 		git push --mirror up &&
-		git reset --hard HEAD^
+		git reset --hard HEAD^ &&
 		git tag -f tmaster master &&
 		git push --mirror up
 	) &&
@@ -188,7 +188,7 @@ test_expect_success 'push mirror removes tags' '
 		echo one >foo && git add foo && git commit -m one &&
 		git tag -f tremove master &&
 		git push --mirror up &&
-		git tag -d tremove
+		git tag -d tremove &&
 		git push --mirror up
 	) &&
 	(
@@ -235,7 +235,7 @@ test_expect_success 'remote.foo.mirror adds and removes branches' '
 		git branch keep master &&
 		git branch remove master &&
 		git push up &&
-		git branch -D remove
+		git branch -D remove &&
 		git push up
 	) &&
 	(
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 359e03ff83..0f730d7781 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -379,7 +379,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 			git config -f .gitmodules submodule.subdir/deepsubmodule.fetchRecursive false
 		) &&
 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err &&
-		git config --unset fetch.recurseSubmodules
+		git config --unset fetch.recurseSubmodules &&
 		(
 			cd submodule &&
 			git config --unset -f .gitmodules submodule.subdir/deepsubmodule.fetchRecursive
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 39cb2c1c34..e2c37fd978 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -354,7 +354,7 @@ test_expect_success 'push succeeds if submodule has no remote and is on the firs
 	git clone a a1 &&
 	(
 		cd a1 &&
-		git init b
+		git init b &&
 		(
 			cd b &&
 			>junk &&
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 3480b33007..7079bcf9a0 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -178,7 +178,7 @@ test_expect_success 'atomic push obeys update hook preventing a branch to be pus
 test_expect_success 'atomic push is not advertised if configured' '
 	mk_repo_pair &&
 	(
-		cd upstream
+		cd upstream &&
 		git config receive.advertiseatomic 0
 	) &&
 	(
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0b62037744..ddaa96ac4f 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -618,7 +618,7 @@ hex2oct () {
 test_expect_success 'clone on case-insensitive fs' '
 	git init icasefs &&
 	(
-		cd icasefs
+		cd icasefs &&
 		o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
 		t=$(printf "100644 X\0${o}100644 x\0${o}" |
 			git hash-object -w -t tree --stdin) &&
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 3c087e907c..af23419ebf 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -94,7 +94,7 @@ test_expect_success 'clone empty repository' '
 	 git config receive.denyCurrentBranch warn) &&
 	git clone empty empty-clone &&
 	test_tick &&
-	(cd empty-clone
+	(cd empty-clone &&
 	 echo "content" >> foo &&
 	 git add foo &&
 	 git commit -m "Initial commit" &&
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 362b1581e0..ee5757966f 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -96,7 +96,7 @@ test_expect_success 'push new branch with old:new refspec' '
 
 test_expect_success 'push new branch with HEAD:new refspec' '
 	(cd local &&
-	 git checkout new-name
+	 git checkout new-name &&
 	 git push origin HEAD:new-refspec-2
 	) &&
 	compare_refs local HEAD server refs/heads/new-refspec-2
-- 
2.18.0.203.gfac676dfb9

