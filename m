Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE23C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 15:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjCOPPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 11:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjCOPPk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 11:15:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E10EFAA
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 08:15:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v16so17695804wrn.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678893335;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IbE528xeFF7yNa7gwhVWHzFWnFIZWCT4Se6jK4RPIg4=;
        b=bXBkowDIEe+QzkPSXpxoLbo7yS+jkRZL7PqZ/8ef/2LuOAg5EWfkqcAeGKCcNPemPi
         KtuxG3PRKFjZKnFaTwCairJEyE5Q4qhvvUxAYkfbT6e3VRJ6WKcu+H6qPsIZ1aly0wnz
         RoVyD+PhVrKoSnpc/S1sXNLwXbQob3luEIb+9RzXrWRSt5/OvY9ns7qzLnuBvuBGZBV5
         mTQ+ioQ7ZVTfosrfrTqg9Ka7pFBMhnw6xf4hL2/6JGvDCcnyTJbWuETq0Ne2caDa9Htc
         hQV83vrmU/agFVyQQqGQfENSNA8/ta3EuhGRZgjtq9qbGR+Bn50xkVtbjZ2fcsntzhc3
         gG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893335;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbE528xeFF7yNa7gwhVWHzFWnFIZWCT4Se6jK4RPIg4=;
        b=JWZhL4Rko1UeBdQRpvdGODyGvjz2vBayuX5BH+OH7L0yLHhoSMBFGAJSFyBL8drY0C
         lM8+N3ZVEK7d31uyLzJarQSH9mANbsSzSfj2IyEOHfyWPBNF6z8wCNt4RCj+q+Zwlhr3
         0WdyTtlHkUT3Tfd9FeWwVZzDF5+KH/26/79aSx67S805EWaLv/Nl1sx6qSYgBJ9KHf3l
         IMgIsbiBinPNrr6EGZPtSD/UgY6X+uRZdfwAkFAeont1Lf3uSl+vnewucL/CRdsYqsn+
         HiFqWyNxOup8vqjrniHul+84JXZq6EuuNd8TWlQtgRrvZsPqan6DL4qucUisdahuOGxb
         wgCQ==
X-Gm-Message-State: AO0yUKVO0wGMoo6zUWQc9ntTThvZPl+oUFumstHH/ATaOZ7ri/VPpBEe
        u29ff+90dicMD5xcFgVjMiDH1CbwceU=
X-Google-Smtp-Source: AK7set97GMz4miq1MIp8BnPKyAC2/0BOfSuj0PmQEK08YNuKVD8w5A7+t0NGipi53VrQAZgTWmON4A==
X-Received: by 2002:a5d:63c3:0:b0:2cf:e868:f789 with SMTP id c3-20020a5d63c3000000b002cfe868f789mr2139164wrw.48.1678893335709;
        Wed, 15 Mar 2023 08:15:35 -0700 (PDT)
Received: from localhost.localdomain ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b002c706c754fesm4783191wrv.32.2023.03.15.08.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 08:15:35 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 4/4] rebase: remove a couple of redundant strategy tests
Date:   Wed, 15 Mar 2023 15:14:59 +0000
Message-Id: <3e02eeff78b23711187de47a1a820f9bde683200.1678893298.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The test removed in t3402 has been redundant ever since 80ff47957b
(rebase: remember strategy and strategy options, 2011-02-06) which added
a new test the first part of which (as noted in the commit message)
duplicated the existing test. The test removed in t3418 has been
redundant since the merge backend was removed in 68aa495b59 (rebase:
implement --merge via the interactive machinery, 2018-12-11) as it now
tests the same code paths as the preceding test.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3402-rebase-merge.sh    | 21 ---------------------
 t/t3418-rebase-continue.sh | 32 --------------------------------
 2 files changed, 53 deletions(-)

diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 7e46f4ca85..79b0640c00 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -131,27 +131,6 @@ test_expect_success 'picking rebase' '
 	esac
 '
 
-test_expect_success 'rebase -s funny -Xopt' '
-	test_when_finished "rm -fr test-bin funny.was.run" &&
-	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF &&
-	#!$SHELL_PATH
-	case "\$1" in --opt) ;; *) exit 2 ;; esac
-	shift &&
-	>funny.was.run &&
-	exec git merge-recursive "\$@"
-	EOF
-	chmod +x test-bin/git-merge-funny &&
-	git reset --hard &&
-	git checkout -b test-funny main^ &&
-	test_commit funny &&
-	(
-		PATH=./test-bin:$PATH &&
-		git rebase -s funny -Xopt main
-	) &&
-	test -f funny.was.run
-'
-
 test_expect_success 'rebase --skip works with two conflicts in a row' '
 	git checkout second-side  &&
 	tr "[A-Z]" "[a-z]" <newfile >tmp &&
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 42c3954125..2d0789e554 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -97,38 +97,6 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase -i --continue handles merge strategy and options' '
-	rm -fr .git/rebase-* &&
-	git reset --hard commit-new-file-F2-on-topic-branch &&
-	test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
-	test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
-	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF &&
-	#!$SHELL_PATH
-	echo "\$@" >>funny.args
-	case "\$1" in --opt) ;; *) exit 2 ;; esac
-	case "\$2" in --foo) ;; *) exit 2 ;; esac
-	case "\$4" in --) ;; *) exit 2 ;; esac
-	shift 2 &&
-	>funny.was.run &&
-	exec git merge-recursive "\$@"
-	EOF
-	chmod +x test-bin/git-merge-funny &&
-	(
-		PATH=./test-bin:$PATH &&
-		test_must_fail git rebase -i -s funny -Xopt -Xfoo main topic
-	) &&
-	test -f funny.was.run &&
-	rm funny.was.run &&
-	echo "Resolved" >F2 &&
-	git add F2 &&
-	(
-		PATH=./test-bin:$PATH &&
-		git rebase --continue
-	) &&
-	test -f funny.was.run
-'
-
 test_expect_success 'rebase -r passes merge strategy options correctly' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-- 
2.39.2

