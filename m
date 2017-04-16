Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19AE1FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 02:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755007AbdDPCbM (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 22:31:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55467 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754729AbdDPCbL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 22:31:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E7A9813D4;
        Sat, 15 Apr 2017 22:31:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=YhWk+wUsKrmSN8ViUyzosnAwkkg
        =; b=IjDR6zy73//urKrvohMj8XErQah1eMTILlN6j6t1/DG2h3Z4Rauc4zYHlhc
        yBNXHPBgextbYk9TamwTEA/BzVUoOUx8Qy9q2X6F83iZplJu0PwfeA6Xro6G1Krg
        0uk4jriDG2gRYSvSUmTGMpfQeUX6n6bAomoV9BIw4LQ/1qsE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35522813D3;
        Sat, 15 Apr 2017 22:31:09 -0400 (EDT)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C3CC813D2;
        Sat, 15 Apr 2017 22:31:08 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH] t1400: use consistent style for test_expect_success calls
Date:   Sat, 15 Apr 2017 22:31:02 -0400
Message-Id: <20170416023102.25387-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.12.2
X-Pobox-Relay-ID: BF922176-224C-11E7-8CAF-E680B56B9B0B-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id; s=mesmtp;
 bh=YhWk+wUsKrmSN8ViUyzosnAwkkg=;
 b=o6B20ryPtPDdtMvqVlxLkcoyTdMPq/EnwVI42CpP49M4+v8nYy5IYaRLWW/gIPGpUs/YPd+h8YuQ6pY/yvDeScoG2MA3RSGThypSJIV8euBdy1tQTb7bDiW6da26fK5STUI+ixPCJvfAOLlR6ZmULcH3jP8WbUJfOZY7Zk7igZw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Structure calls as

    test_expect_success 'description' '
    	body
    '

Use double quotes for the description if it requires parameter
expansion or contains a single quote.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
This patch follows up on a recent t1400 series:
https://public-inbox.org/git/xmqq8tnysekm.fsf@gitster.mtv.corp.google.com/

 t/t1400-update-ref.sh | 335 +++++++++++++++++++++++++-------------------------
 1 file changed, 167 insertions(+), 168 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index a23cd7b57..dc98b4bc6 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -35,14 +35,14 @@ test_expect_success setup '
 	cd -
 '
 
-test_expect_success \
-	"create $m" \
-	"git update-ref $m $A &&
-	 test $A"' = $(cat .git/'"$m"')'
-test_expect_success \
-	"create $m with oldvalue verification" \
-	"git update-ref $m $B $A &&
-	 test $B"' = $(cat .git/'"$m"')'
+test_expect_success "create $m" '
+	git update-ref $m $A &&
+	test $A = $(cat .git/$m)
+'
+test_expect_success "create $m with oldvalue verification" '
+	git update-ref $m $B $A &&
+	test $B = $(cat .git/$m)
+'
 test_expect_success "fail to delete $m with stale ref" '
 	test_must_fail git update-ref -d $m $A &&
 	test $B = "$(cat .git/$m)"
@@ -67,14 +67,14 @@ test_expect_success "fail to create $n" '
 	test_must_fail git update-ref $n $A
 '
 
-test_expect_success \
-	"create $m (by HEAD)" \
-	"git update-ref HEAD $A &&
-	 test $A"' = $(cat .git/'"$m"')'
-test_expect_success \
-	"create $m (by HEAD) with oldvalue verification" \
-	"git update-ref HEAD $B $A &&
-	 test $B"' = $(cat .git/'"$m"')'
+test_expect_success "create $m (by HEAD)" '
+	git update-ref HEAD $A &&
+	test $A = $(cat .git/$m)
+'
+test_expect_success "create $m (by HEAD) with oldvalue verification" '
+	git update-ref HEAD $B $A &&
+	test $B = $(cat .git/$m)
+'
 test_expect_success "fail to delete $m (by HEAD) with stale ref" '
 	test_must_fail git update-ref -d HEAD $A &&
 	test $B = $(cat .git/$m)
@@ -176,17 +176,17 @@ test_expect_success '--no-create-reflog overrides core.logAllRefUpdates=always'
 	test_must_fail git reflog exists $outside
 '
 
-test_expect_success \
-	"create $m (by HEAD)" \
-	"git update-ref HEAD $A &&
-	 test $A"' = $(cat .git/'"$m"')'
-test_expect_success \
-	"pack refs" \
-	"git pack-refs --all"
-test_expect_success \
-	"move $m (by HEAD)" \
-	"git update-ref HEAD $B $A &&
-	 test $B"' = $(cat .git/'"$m"')'
+test_expect_success "create $m (by HEAD)" '
+	git update-ref HEAD $A &&
+	test $A = $(cat .git/$m)
+'
+test_expect_success 'pack refs' '
+	git pack-refs --all
+'
+test_expect_success "move $m (by HEAD)" '
+	git update-ref HEAD $B $A &&
+	test $B = $(cat .git/$m)
+'
 test_expect_success "delete $m (by HEAD) should remove both packed and loose $m" '
 	test_when_finished "rm -f .git/$m" &&
 	git update-ref -d HEAD $B &&
@@ -195,13 +195,13 @@ test_expect_success "delete $m (by HEAD) should remove both packed and loose $m"
 '
 
 cp -f .git/HEAD .git/HEAD.orig
-test_expect_success "delete symref without dereference" '
+test_expect_success 'delete symref without dereference' '
 	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
 	git update-ref --no-deref -d HEAD &&
 	test_path_is_missing .git/HEAD
 '
 
-test_expect_success "delete symref without dereference when the referred ref is packed" '
+test_expect_success 'delete symref without dereference when the referred ref is packed' '
 	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
 	echo foo >foo.c &&
 	git add foo.c &&
@@ -239,46 +239,46 @@ test_expect_success 'update-ref --no-deref -d can delete reference to bad ref' '
 	test_path_is_missing .git/refs/heads/ref-to-bad
 '
 
-test_expect_success '(not) create HEAD with old sha1' "
+test_expect_success '(not) create HEAD with old sha1' '
 	test_must_fail git update-ref HEAD $A $B
-"
+'
 test_expect_success "(not) prior created .git/$m" '
 	test_when_finished "rm -f .git/$m" &&
 	test_path_is_missing .git/$m
 '
 
-test_expect_success \
-	"create HEAD" \
-	"git update-ref HEAD $A"
-test_expect_success '(not) change HEAD with wrong SHA1' "
+test_expect_success 'create HEAD' '
+	git update-ref HEAD $A
+'
+test_expect_success '(not) change HEAD with wrong SHA1' '
 	test_must_fail git update-ref HEAD $B $Z
-"
+'
 test_expect_success "(not) changed .git/$m" '
 	test_when_finished "rm -f .git/$m" &&
 	! test $B = $(cat .git/$m)
 '
 
 rm -f .git/logs/refs/heads/master
-test_expect_success \
-	"create $m (logged by touch)" \
-	'test_config core.logAllRefUpdates false &&
-	 GIT_COMMITTER_DATE="2005-05-26 23:30" \
-	 git update-ref --create-reflog HEAD '"$A"' -m "Initial Creation" &&
-	 test '"$A"' = $(cat .git/'"$m"')'
-test_expect_success \
-	"update $m (logged by touch)" \
-	'test_config core.logAllRefUpdates false &&
-	 GIT_COMMITTER_DATE="2005-05-26 23:31" \
-	 git update-ref HEAD'" $B $A "'-m "Switch" &&
-	 test '"$B"' = $(cat .git/'"$m"')'
-test_expect_success \
-	"set $m (logged by touch)" \
-	'test_config core.logAllRefUpdates false &&
-	 GIT_COMMITTER_DATE="2005-05-26 23:41" \
-	 git update-ref HEAD'" $A &&
-	 test $A"' = $(cat .git/'"$m"')'
-
-test_expect_success "empty directory removal" '
+test_expect_success "create $m (logged by touch)" '
+	test_config core.logAllRefUpdates false &&
+	GIT_COMMITTER_DATE="2005-05-26 23:30" \
+	git update-ref --create-reflog HEAD $A -m "Initial Creation" &&
+	test $A = $(cat .git/$m)
+'
+test_expect_success "update $m (logged by touch)" '
+	test_config core.logAllRefUpdates false &&
+	GIT_COMMITTER_DATE="2005-05-26 23:31" \
+	git update-ref HEAD $B $A -m "Switch" &&
+	test $B = $(cat .git/$m)
+'
+test_expect_success "set $m (logged by touch)" '
+	test_config core.logAllRefUpdates false &&
+	GIT_COMMITTER_DATE="2005-05-26 23:41" \
+	git update-ref HEAD $A &&
+	test $A = $(cat .git/$m)
+'
+
+test_expect_success 'empty directory removal' '
 	git branch d1/d2/r1 HEAD &&
 	git branch d1/r2 HEAD &&
 	test_path_is_file .git/refs/heads/d1/d2/r1 &&
@@ -290,7 +290,7 @@ test_expect_success "empty directory removal" '
 	test_path_is_file .git/logs/refs/heads/d1/r2
 '
 
-test_expect_success "symref empty directory removal" '
+test_expect_success 'symref empty directory removal' '
 	git branch e1/e2/r1 HEAD &&
 	git branch e1/r2 HEAD &&
 	git checkout e1/e2/r1 &&
@@ -315,34 +315,34 @@ test_expect_success "verifying $m's log (logged by touch)" '
 	test_cmp expect .git/logs/$m
 '
 
-test_expect_success \
-	"create $m (logged by config)" \
-	'test_config core.logAllRefUpdates true &&
-	 GIT_COMMITTER_DATE="2005-05-26 23:32" \
-	 git update-ref HEAD'" $A "'-m "Initial Creation" &&
-	 test '"$A"' = $(cat .git/'"$m"')'
-test_expect_success \
-	"update $m (logged by config)" \
-	'test_config core.logAllRefUpdates true &&
-	 GIT_COMMITTER_DATE="2005-05-26 23:33" \
-	 git update-ref HEAD'" $B $A "'-m "Switch" &&
-	 test '"$B"' = $(cat .git/'"$m"')'
-test_expect_success \
-	"set $m (logged by config)" \
-	'test_config core.logAllRefUpdates true &&
-	 GIT_COMMITTER_DATE="2005-05-26 23:43" \
-	 git update-ref HEAD '"$A &&
-	 test $A"' = $(cat .git/'"$m"')'
+test_expect_success "create $m (logged by config)" '
+	test_config core.logAllRefUpdates true &&
+	GIT_COMMITTER_DATE="2005-05-26 23:32" \
+	git update-ref HEAD $A -m "Initial Creation" &&
+	test $A = $(cat .git/$m)
+'
+test_expect_success "update $m (logged by config)" '
+	test_config core.logAllRefUpdates true &&
+	GIT_COMMITTER_DATE="2005-05-26 23:33" \
+	git update-ref HEAD'" $B $A "'-m "Switch" &&
+	test $B = $(cat .git/$m)
+'
+test_expect_success "set $m (logged by config)" '
+	test_config core.logAllRefUpdates true &&
+	GIT_COMMITTER_DATE="2005-05-26 23:43" \
+	git update-ref HEAD $A &&
+	test $A = $(cat .git/$m)
+'
 
 cat >expect <<EOF
 $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 +0000	Initial Creation
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
 EOF
-test_expect_success \
-	"verifying $m's log (logged by config)" \
-	'test_when_finished "rm -f .git/$m .git/logs/$m expect" &&
-	 test_cmp expect .git/logs/$m'
+test_expect_success "verifying $m's log (logged by config)" '
+	test_when_finished "rm -f .git/$m .git/logs/$m expect" &&
+	test_cmp expect .git/logs/$m
+'
 
 git update-ref $m $D
 cat >.git/logs/$m <<EOF
@@ -356,86 +356,85 @@ EOF
 ed="Thu, 26 May 2005 18:32:00 -0500"
 gd="Thu, 26 May 2005 18:33:00 -0500"
 ld="Thu, 26 May 2005 18:43:00 -0500"
-test_expect_success \
-	'Query "master@{May 25 2005}" (before history)' \
-	'test_when_finished "rm -f o e" &&
-	 git rev-parse --verify "master@{May 25 2005}" >o 2>e &&
-	 test '"$C"' = $(cat o) &&
-	 test "warning: Log for '\'master\'' only goes back to $ed." = "$(cat e)"'
-test_expect_success \
-	"Query master@{2005-05-25} (before history)" \
-	'test_when_finished "rm -f o e" &&
-	 git rev-parse --verify master@{2005-05-25} >o 2>e &&
-	 test '"$C"' = $(cat o) &&
-	 echo test "warning: Log for '\'master\'' only goes back to $ed." = "$(cat e)"'
-test_expect_success \
-	'Query "master@{May 26 2005 23:31:59}" (1 second before history)' \
-	'test_when_finished "rm -f o e" &&
-	 git rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
-	 test '"$C"' = $(cat o) &&
-	 test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"'
-test_expect_success \
-	'Query "master@{May 26 2005 23:32:00}" (exactly history start)' \
-	'test_when_finished "rm -f o e" &&
-	 git rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
-	 test '"$C"' = $(cat o) &&
-	 test "" = "$(cat e)"'
-test_expect_success \
-	'Query "master@{May 26 2005 23:32:30}" (first non-creation change)' \
-	'test_when_finished "rm -f o e" &&
-	 git rev-parse --verify "master@{May 26 2005 23:32:30}" >o 2>e &&
-	 test '"$A"' = $(cat o) &&
-	 test "" = "$(cat e)"'
-test_expect_success \
-	'Query "master@{2005-05-26 23:33:01}" (middle of history with gap)' \
-	'test_when_finished "rm -f o e" &&
-	 git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
-	 test '"$B"' = $(cat o) &&
-	 test "warning: Log for ref '"$m has gap after $gd"'." = "$(cat e)"'
-test_expect_success \
-	'Query "master@{2005-05-26 23:38:00}" (middle of history)' \
-	'test_when_finished "rm -f o e" &&
-	 git rev-parse --verify "master@{2005-05-26 23:38:00}" >o 2>e &&
-	 test '"$Z"' = $(cat o) &&
-	 test "" = "$(cat e)"'
-test_expect_success \
-	'Query "master@{2005-05-26 23:43:00}" (exact end of history)' \
-	'test_when_finished "rm -f o e" &&
-	 git rev-parse --verify "master@{2005-05-26 23:43:00}" >o 2>e &&
-	 test '"$E"' = $(cat o) &&
-	 test "" = "$(cat e)"'
-test_expect_success \
-	'Query "master@{2005-05-28}" (past end of history)' \
-	'test_when_finished "rm -f o e" &&
-	 git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
-	 test '"$D"' = $(cat o) &&
-	 test "warning: Log for ref '"$m unexpectedly ended on $ld"'." = "$(cat e)"'
-
+test_expect_success 'Query "master@{May 25 2005}" (before history)' '
+	test_when_finished "rm -f o e" &&
+	git rev-parse --verify "master@{May 25 2005}" >o 2>e &&
+	test $C = $(cat o) &&
+	test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"
+'
+test_expect_success 'Query master@{2005-05-25} (before history)' '
+	test_when_finished "rm -f o e" &&
+	git rev-parse --verify master@{2005-05-25} >o 2>e &&
+	test $C = $(cat o) &&
+	echo test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"
+'
+test_expect_success 'Query "master@{May 26 2005 23:31:59}" (1 second before history)' '
+	test_when_finished "rm -f o e" &&
+	git rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
+	test $C = $(cat o) &&
+	test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"
+'
+test_expect_success 'Query "master@{May 26 2005 23:32:00}" (exactly history start)' '
+	test_when_finished "rm -f o e" &&
+	git rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
+	test $C = $(cat o) &&
+	test "" = "$(cat e)"
+'
+test_expect_success 'Query "master@{May 26 2005 23:32:30}" (first non-creation change)' '
+	test_when_finished "rm -f o e" &&
+	git rev-parse --verify "master@{May 26 2005 23:32:30}" >o 2>e &&
+	test $A = $(cat o) &&
+	test "" = "$(cat e)"
+'
+test_expect_success 'Query "master@{2005-05-26 23:33:01}" (middle of history with gap)' '
+	test_when_finished "rm -f o e" &&
+	git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
+	test $B = $(cat o) &&
+	test "warning: Log for ref $m has gap after $gd." = "$(cat e)"
+'
+test_expect_success 'Query "master@{2005-05-26 23:38:00}" (middle of history)' '
+	test_when_finished "rm -f o e" &&
+	git rev-parse --verify "master@{2005-05-26 23:38:00}" >o 2>e &&
+	test $Z = $(cat o) &&
+	test "" = "$(cat e)"
+'
+test_expect_success 'Query "master@{2005-05-26 23:43:00}" (exact end of history)' '
+	test_when_finished "rm -f o e" &&
+	git rev-parse --verify "master@{2005-05-26 23:43:00}" >o 2>e &&
+	test $E = $(cat o) &&
+	test "" = "$(cat e)"
+'
+test_expect_success 'Query "master@{2005-05-28}" (past end of history)' '
+	test_when_finished "rm -f o e" &&
+	git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
+	test $D = $(cat o) &&
+	test "warning: Log for ref $m unexpectedly ended on $ld." = "$(cat e)"
+'
 
 rm -f .git/$m .git/logs/$m expect
 
-test_expect_success \
-    'creating initial files' \
-    'test_when_finished rm -f M &&
-     echo TEST >F &&
-     git add F &&
-	 GIT_AUTHOR_DATE="2005-05-26 23:30" \
-	 GIT_COMMITTER_DATE="2005-05-26 23:30" git commit -m add -a &&
-	 h_TEST=$(git rev-parse --verify HEAD) &&
-	 echo The other day this did not work. >M &&
-	 echo And then Bob told me how to fix it. >>M &&
-	 echo OTHER >F &&
-	 GIT_AUTHOR_DATE="2005-05-26 23:41" \
-	 GIT_COMMITTER_DATE="2005-05-26 23:41" git commit -F M -a &&
-	 h_OTHER=$(git rev-parse --verify HEAD) &&
-	 GIT_AUTHOR_DATE="2005-05-26 23:44" \
-	 GIT_COMMITTER_DATE="2005-05-26 23:44" git commit --amend &&
-	 h_FIXED=$(git rev-parse --verify HEAD) &&
-	 echo Merged initial commit and a later commit. >M &&
-	 echo $h_TEST >.git/MERGE_HEAD &&
-	 GIT_AUTHOR_DATE="2005-05-26 23:45" \
-	 GIT_COMMITTER_DATE="2005-05-26 23:45" git commit -F M &&
-	 h_MERGED=$(git rev-parse --verify HEAD)'
+test_expect_success 'creating initial files' '
+	test_when_finished rm -f M &&
+	echo TEST >F &&
+	git add F &&
+	GIT_AUTHOR_DATE="2005-05-26 23:30" \
+	GIT_COMMITTER_DATE="2005-05-26 23:30" git commit -m add -a &&
+	h_TEST=$(git rev-parse --verify HEAD) &&
+	echo The other day this did not work. >M &&
+	echo And then Bob told me how to fix it. >>M &&
+	echo OTHER >F &&
+	GIT_AUTHOR_DATE="2005-05-26 23:41" \
+	GIT_COMMITTER_DATE="2005-05-26 23:41" git commit -F M -a &&
+	h_OTHER=$(git rev-parse --verify HEAD) &&
+	GIT_AUTHOR_DATE="2005-05-26 23:44" \
+	GIT_COMMITTER_DATE="2005-05-26 23:44" git commit --amend &&
+	h_FIXED=$(git rev-parse --verify HEAD) &&
+	echo Merged initial commit and a later commit. >M &&
+	echo $h_TEST >.git/MERGE_HEAD &&
+	GIT_AUTHOR_DATE="2005-05-26 23:45" \
+	GIT_COMMITTER_DATE="2005-05-26 23:45" git commit -F M &&
+	h_MERGED=$(git rev-parse --verify HEAD)
+'
 
 cat >expect <<EOF
 $Z $h_TEST $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	commit (initial): add
@@ -443,20 +442,20 @@ $h_TEST $h_OTHER $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000	com
 $h_OTHER $h_FIXED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151040 +0000	commit (amend): The other day this did not work.
 $h_FIXED $h_MERGED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151100 +0000	commit (merge): Merged initial commit and a later commit.
 EOF
-test_expect_success \
-	'git commit logged updates' \
-	"test_cmp expect .git/logs/$m"
+test_expect_success 'git commit logged updates' '
+	test_cmp expect .git/logs/$m
+'
 unset h_TEST h_OTHER h_FIXED h_MERGED
 
-test_expect_success \
-	'git cat-file blob master:F (expect OTHER)' \
-	'test OTHER = $(git cat-file blob master:F)'
-test_expect_success \
-	'git cat-file blob master@{2005-05-26 23:30}:F (expect TEST)' \
-	'test TEST = $(git cat-file blob "master@{2005-05-26 23:30}:F")'
-test_expect_success \
-	'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' \
-	'test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")'
+test_expect_success 'git cat-file blob master:F (expect OTHER)' '
+	test OTHER = $(git cat-file blob master:F)
+'
+test_expect_success 'git cat-file blob master@{2005-05-26 23:30}:F (expect TEST)' '
+	test TEST = $(git cat-file blob "master@{2005-05-26 23:30}:F")
+'
+test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' '
+	test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")
+'
 
 a=refs/heads/a
 b=refs/heads/b
-- 
2.12.2

