Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80F9C1FE4E
	for <e@80x24.org>; Tue, 28 Jun 2016 00:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbcF1AQT (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 20:16:19 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35871 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbcF1AQS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 20:16:18 -0400
Received: by mail-pf0-f177.google.com with SMTP id t190so363669pfb.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 17:16:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CwALqJb8HRcYG6tM7SCygs+3ddP0m8aCVhf0AKqkx7I=;
        b=AAfyC1OoVmA+KBD01CG5QupLXkRFLyz24Owz1HTTSpaOMsDZ186oxmsbE0/TmObt7P
         g7YCuZ/9x9EZxKFYIjrQC6wVwTwSltiR8CNNMOdI29j/+VcDRVEJWR+dxCrS4YOQnZR7
         mBlCDpGF1KaPiHv1JKVvvWzjuT/0xIH2Vv1Ymgjo1kQabYvlARZ4pMXZMevyvAYKhS2Y
         +oSxHhBRPIMFrsyW6pE8Bvu5u7wa3JwYkHoXCdk9/IscYpuG3Afvqj3dnLJQhwSKapzJ
         rEtsfm0uiyMmLhJUWQa7pnwXZcHBD8MPKI30utT4FXcZDIliuBP2z3maR7CTd7/CYuBq
         ymAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CwALqJb8HRcYG6tM7SCygs+3ddP0m8aCVhf0AKqkx7I=;
        b=IVpgY6QMZGuSL7mLVvkNmuAtIhA342NhfluCu1V0+os46q+GToKQIre3rzC0AvmRs+
         T5a4suQd4kbvFKEiV9eyB2/jta606hcyfrHl4hR1KMKpI4ecxu2veJVmdQVfgfvUhNGZ
         UsRtLOKr9jjm9VnpAJjMF2zE0+S8w6UXmYcJjqR46YhN7awTkzTwql4Fp2N+eigVbF06
         M8h5/NofDcaOyfcYgrllIFjv63+HSZXbc9B6wtk/RJNCgH9vJwCgcQNNaeCrXGD20DH9
         ZP65H8BzNC4N4BEXgaL6CmxM/qcxOHB1/rG/Wj23Lx10o58lNqNYrFE4eRaKCQYXR2go
         CtGw==
X-Gm-Message-State: ALyK8tL35wHl9mVQxnn4rzRKrAYyKkZPaelQVbEYqTD6n8XdsiYHtP6KAndFjKAu0rwiFq5h
X-Received: by 10.98.24.148 with SMTP id 142mr127733pfy.52.1467072963937;
        Mon, 27 Jun 2016 17:16:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e518:61c0:3e08:bcb9])
        by smtp.gmail.com with ESMTPSA id w63sm1961699pfi.9.2016.06.27.17.16.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 17:16:03 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	bartbogaerts@gmail.com
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: test moving recursive submodule
Date:	Mon, 27 Jun 2016 17:15:59 -0700
Message-Id: <20160628001559.29204-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.138.g8a4fcb8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
This tries to reproduce the error as pointed out in
http://stackoverflow.com/questions/32782382/git-moving-submodules-recursively-nested-submodules
but the tests pass. This still seems to be missing a detail.

Bart any idea how this setup may be different than what you have?
Instead of applying the patch, you can also checkout 
https://github.com/stefanbeller/git/tree/submodule_recursive_mv_test
which is the patch below applied on top of Junios (the maintainer) master branch.
To look around on the filesystem, you can drop "test_pause &&" in a test and
then run the test with `(cd t && ./t7001-mv.sh -v)` (more info how to run tests
in the Git test suite in t/README, maybe -i -v -x are interested)

Thanks,
Stefan

 t/t7001-mv.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 4a2570e..404e5bd 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -295,6 +295,28 @@ test_expect_success 'setup submodule' '
 	mkdir -p deep/directory/hierachy &&
 	git submodule add ./. deep/directory/hierachy/sub &&
 	git commit -m "added another submodule" &&
+	mkdir inner_sub &&
+	(
+		cd inner_sub &&
+		git init &&
+		test_commit initial
+	) &&
+	mkdir outer_sub &&
+	(
+		cd outer_sub &&
+		git init &&
+		test_commit initial &&
+		git submodule add ../inner_sub &&
+		git commit -a -m "add an inner submodule"
+	) &&
+	git submodule add ./outer_sub ./deep/outer_sub &&
+	git commit -a -m "add outer sub" &&
+	git -C deep ls-tree HEAD |cut -f 2 >actual &&
+	cat >expect <<-EOF &&
+	directory
+	outer_sub
+	EOF
+	test_cmp expect actual &&
 	git branch submodule
 '
 
@@ -488,6 +510,27 @@ test_expect_success 'moving a submodule in nested directories' '
 		git config -f ../.gitmodules submodule.deep/directory/hierachy/sub.path >../actual &&
 		echo "directory/hierachy/sub" >../expect
 	) &&
+	test_cmp actual expect &&
+	git commit -a -m "mv a submodule in nested dir"
+'
+
+test_expect_success 'moving a submodule with a nested submodule' '
+	git mv deep/outer_sub outer_sub_moved &&
+	# git status would fail if the update of linking git dir to
+	# work dir of the submodule failed.
+	git status &&
+	git config -f .gitmodules submodule.deep/outer_sub.path >actual &&
+	echo "outer_sub_moved" >expect &&
+	test_cmp actual expect
+'
+
+test_expect_success 'moving back the submodule with a nested submodule' '
+	git mv outer_sub_moved deep/outer_sub &&
+	# git status would fail if the update of linking git dir to
+	# work dir of the submodule failed.
+	git status &&
+	git config -f .gitmodules submodule.deep/outer_sub.path >actual &&
+	echo "deep/outer_sub" >expect &&
 	test_cmp actual expect
 '
 
-- 
2.9.0.4.g35eb263.dirty

