Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D19120899
	for <e@80x24.org>; Tue,  8 Aug 2017 23:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbdHHXnQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 19:43:16 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32985 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdHHXnP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 19:43:15 -0400
Received: by mail-pf0-f173.google.com with SMTP id h68so20548568pfk.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 16:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MF8zYY+CwAoZjZ0q3MHWlr7hPbK2jthpa04fYPcqDiY=;
        b=cVgTtWeTrihQynHVIEc56Qe+2IcK5N6J96icqTTwGNusXAbtqHdWv2jh82kQJySxLx
         5urVM0tsbUMHgjH549lsuQL+v/pFapxR5fpEImijAbiSGNROghftFp3x73jpstIQmq32
         oX20rZgYCDtGWhF+u3STtUvvLzVjRV2j4sTU3dPhgdecN9zRevHD+fTiAG51JKMaU04k
         OjnVzDfnZ7NxqbrD9K6CVHTHuv17RpJgQwWCCjjVVYf6kekbIvu6RXadfLBQ9y48k+Zz
         /OvGb/UBQjcDB1uLCpyKdPx2Q1nlld/0DGfEd6Znjjws83GcKM9NsPlo3XExEud9i66c
         fm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MF8zYY+CwAoZjZ0q3MHWlr7hPbK2jthpa04fYPcqDiY=;
        b=f506kb3W3Tjsoe0nD4EekPasQIkVoiz5iZ8QPNF5WpkWvpaKiQiNgs75EUx3EldKTi
         kqFJVriHfFRBgjSx/apB9z0B1dPDtqZMK9AyCcBn3p8t3PlIax9iwytD987R6McmLi//
         4JxzLahavlH+Oe54AzabKJ1Gvn7d4delNWkJW1g0AI86HNJvfqmidMfGyP0iSBnhMdib
         Rc92mxaSZUD4dlK0xi7M8l4JSZ3wgbVgVWz/UJ7mfL92aNGjc2Nx47Q0p8N0aVtXP2w3
         SfuJE8eAYKFJdH4HPZfLlRpzN5FgigXxGj23E0BGS2rQJFXs6HVN2wM+ldriBJ/Suxtx
         lfoA==
X-Gm-Message-State: AHYfb5jaXAWqTtEuIcdDr1RgzorEx2NcprPpL58BpBcGg6Bh3DeM4+72
        NHG5k0odtOsZd2h+
X-Received: by 10.99.44.66 with SMTP id s63mr5615605pgs.396.1502235794291;
        Tue, 08 Aug 2017 16:43:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:dc16:1c13:4286:72f0])
        by smtp.gmail.com with ESMTPSA id t12sm5006191pfg.12.2017.08.08.16.43.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 16:43:12 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] t1200: remove t1200-tutorial.sh
Date:   Tue,  8 Aug 2017 16:43:08 -0700
Message-Id: <20170808234308.25565-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nowadays there are better tutorials out there such as "Git from bottom up"
or others, easily found online. Additionally to that a tutorial in our
test suite is not as easy to discover as e.g. online tutorials.

This test/tutorial was discovered by the patch author in the effort to
migrate our tests in preparation to switch the hashing function.
Transforming this tutorial to be agnostic of the underlying hash function
would hurt its readability, hence being even less useful as a tutorial.

Instead delete this test as
(a) the functionality is tested elsewhere as well and
(b) reducing the test suite to its core improves performance, which
    aids developers in keeping their development velocity.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t1200-tutorial.sh | 268 ----------------------------------------------------
 1 file changed, 268 deletions(-)
 delete mode 100755 t/t1200-tutorial.sh

diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
deleted file mode 100755
index 397ccb6909..0000000000
--- a/t/t1200-tutorial.sh
+++ /dev/null
@@ -1,268 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Johannes Schindelin
-#
-
-test_description='A simple turial in the form of a test case'
-
-. ./test-lib.sh
-
-test_expect_success 'blob'  '
-	echo "Hello World" > hello &&
-	echo "Silly example" > example &&
-
-	git update-index --add hello example &&
-
-	test blob = "$(git cat-file -t 557db03)"
-'
-
-test_expect_success 'blob 557db03' '
-	test "Hello World" = "$(git cat-file blob 557db03)"
-'
-
-echo "It's a new day for git" >>hello
-cat > diff.expect << EOF
-diff --git a/hello b/hello
-index 557db03..263414f 100644
---- a/hello
-+++ b/hello
-@@ -1 +1,2 @@
- Hello World
-+It's a new day for git
-EOF
-
-test_expect_success 'git diff-files -p' '
-	git diff-files -p > diff.output &&
-	test_cmp diff.expect diff.output
-'
-
-test_expect_success 'git diff' '
-	git diff > diff.output &&
-	test_cmp diff.expect diff.output
-'
-
-test_expect_success 'tree' '
-	tree=$(git write-tree 2>/dev/null) &&
-	test 8988da15d077d4829fc51d8544c097def6644dbb = $tree
-'
-
-test_expect_success 'git diff-index -p HEAD' '
-	test_tick &&
-	tree=$(git write-tree) &&
-	commit=$(echo "Initial commit" | git commit-tree $tree) &&
-	git update-ref HEAD $commit &&
-	git diff-index -p HEAD > diff.output &&
-	test_cmp diff.expect diff.output
-'
-
-test_expect_success 'git diff HEAD' '
-	git diff HEAD > diff.output &&
-	test_cmp diff.expect diff.output
-'
-
-cat > whatchanged.expect << EOF
-commit VARIABLE
-Author: VARIABLE
-Date:   VARIABLE
-
-    Initial commit
-
-diff --git a/example b/example
-new file mode 100644
-index 0000000..f24c74a
---- /dev/null
-+++ b/example
-@@ -0,0 +1 @@
-+Silly example
-diff --git a/hello b/hello
-new file mode 100644
-index 0000000..557db03
---- /dev/null
-+++ b/hello
-@@ -0,0 +1 @@
-+Hello World
-EOF
-
-test_expect_success 'git whatchanged -p --root' '
-	git whatchanged -p --root |
-		sed -e "1s/^\(.\{7\}\).\{40\}/\1VARIABLE/" \
-		-e "2,3s/^\(.\{8\}\).*$/\1VARIABLE/" \
-	> whatchanged.output &&
-	test_cmp whatchanged.expect whatchanged.output
-'
-
-test_expect_success 'git tag my-first-tag' '
-	git tag my-first-tag &&
-	test_cmp .git/refs/heads/master .git/refs/tags/my-first-tag
-'
-
-test_expect_success 'git checkout -b mybranch' '
-	git checkout -b mybranch &&
-	test_cmp .git/refs/heads/master .git/refs/heads/mybranch
-'
-
-cat > branch.expect <<EOF
-  master
-* mybranch
-EOF
-
-test_expect_success 'git branch' '
-	git branch > branch.output &&
-	test_cmp branch.expect branch.output
-'
-
-test_expect_success 'git resolve now fails' '
-	git checkout mybranch &&
-	echo "Work, work, work" >>hello &&
-	test_tick &&
-	git commit -m "Some work." -i hello &&
-
-	git checkout master &&
-
-	echo "Play, play, play" >>hello &&
-	echo "Lots of fun" >>example &&
-	test_tick &&
-	git commit -m "Some fun." -i hello example &&
-
-	test_must_fail git merge -m "Merge work in mybranch" mybranch
-'
-
-cat > hello << EOF
-Hello World
-It's a new day for git
-Play, play, play
-Work, work, work
-EOF
-
-cat > show-branch.expect << EOF
-* [master] Merge work in mybranch
- ! [mybranch] Some work.
---
--  [master] Merge work in mybranch
-*+ [mybranch] Some work.
-*  [master^] Some fun.
-EOF
-
-test_expect_success 'git show-branch' '
-	test_tick &&
-	git commit -m "Merge work in mybranch" -i hello &&
-	git show-branch --topo-order --more=1 master mybranch \
-		> show-branch.output &&
-	test_cmp show-branch.expect show-branch.output
-'
-
-cat > resolve.expect << EOF
-Updating VARIABLE..VARIABLE
-FASTFORWARD (no commit created; -m option ignored)
- example | 1 +
- hello   | 1 +
- 2 files changed, 2 insertions(+)
-EOF
-
-test_expect_success 'git resolve' '
-	git checkout mybranch &&
-	git merge -m "Merge upstream changes." master |
-		sed -e "1s/[0-9a-f]\{7\}/VARIABLE/g" \
-		-e "s/^Fast[- ]forward /FASTFORWARD /" >resolve.output
-'
-
-test_expect_success 'git resolve output' '
-	test_i18ncmp resolve.expect resolve.output
-'
-
-cat > show-branch2.expect << EOF
-! [master] Merge work in mybranch
- * [mybranch] Merge work in mybranch
---
--- [master] Merge work in mybranch
-EOF
-
-test_expect_success 'git show-branch (part 2)' '
-	git show-branch --topo-order master mybranch > show-branch2.output &&
-	test_cmp show-branch2.expect show-branch2.output
-'
-
-cat > show-branch3.expect << EOF
-! [master] Merge work in mybranch
- * [mybranch] Merge work in mybranch
---
--- [master] Merge work in mybranch
-+* [master^2] Some work.
-+* [master^] Some fun.
-EOF
-
-test_expect_success 'git show-branch (part 3)' '
-	git show-branch --topo-order --more=2 master mybranch \
-		> show-branch3.output &&
-	test_cmp show-branch3.expect show-branch3.output
-'
-
-test_expect_success 'rewind to "Some fun." and "Some work."' '
-	git checkout mybranch &&
-	git reset --hard master^2 &&
-	git checkout master &&
-	git reset --hard master^
-'
-
-cat > show-branch4.expect << EOF
-* [master] Some fun.
- ! [mybranch] Some work.
---
-*  [master] Some fun.
- + [mybranch] Some work.
-*+ [master^] Initial commit
-EOF
-
-test_expect_success 'git show-branch (part 4)' '
-	git show-branch --topo-order > show-branch4.output &&
-	test_cmp show-branch4.expect show-branch4.output
-'
-
-test_expect_success 'manual merge' '
-	mb=$(git merge-base HEAD mybranch) &&
-	git name-rev --name-only --tags $mb > name-rev.output &&
-	test "my-first-tag" = $(cat name-rev.output) &&
-
-	git read-tree -m -u $mb HEAD mybranch
-'
-
-cat > ls-files.expect << EOF
-100644 7f8b141b65fdcee47321e399a2598a235a032422 0	example
-100644 557db03de997c86a4a028e1ebd3a1ceb225be238 1	hello
-100644 ba42a2a96e3027f3333e13ede4ccf4498c3ae942 2	hello
-100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
-EOF
-
-test_expect_success 'git ls-files --stage' '
-	git ls-files --stage > ls-files.output &&
-	test_cmp ls-files.expect ls-files.output
-'
-
-cat > ls-files-unmerged.expect << EOF
-100644 557db03de997c86a4a028e1ebd3a1ceb225be238 1	hello
-100644 ba42a2a96e3027f3333e13ede4ccf4498c3ae942 2	hello
-100644 cc44c73eb783565da5831b4d820c962954019b69 3	hello
-EOF
-
-test_expect_success 'git ls-files --unmerged' '
-	git ls-files --unmerged > ls-files-unmerged.output &&
-	test_cmp ls-files-unmerged.expect ls-files-unmerged.output
-'
-
-test_expect_success 'git-merge-index' '
-	test_must_fail git merge-index git-merge-one-file hello
-'
-
-test_expect_success 'git ls-files --stage (part 2)' '
-	git ls-files --stage > ls-files.output2 &&
-	test_cmp ls-files.expect ls-files.output2
-'
-
-test_expect_success 'git repack' 'git repack'
-test_expect_success 'git prune-packed' 'git prune-packed'
-test_expect_success '-> only packed objects' '
-	git prune && # Remove conflict marked blobs
-	test $(find .git/objects/[0-9a-f][0-9a-f] -type f -print 2>/dev/null | wc -l) = 0
-'
-
-test_done
-- 
2.14.0.rc0.3.g6c2e499285

