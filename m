Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743ED1F406
	for <e@80x24.org>; Thu, 10 May 2018 13:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757320AbeEJN7d (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 09:59:33 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36784 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757097AbeEJN7c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 09:59:32 -0400
Received: by mail-wr0-f196.google.com with SMTP id p4-v6so2144042wrh.3
        for <git@vger.kernel.org>; Thu, 10 May 2018 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJNMlAjCQN+181+/g6x5fUtpPJBPnpWSqxofLDKTmwI=;
        b=INBUuBIFfsu5TtyvFYnn/kBdL2oc9Vrhyu0ilulq6d9iSQi93+ZG69WGYCLm8/vx3X
         1DEe3zyD+6x/4a9MIzetDsA9cwAPJEACrmlkRqn+dGmUVpMnj4QHKvdsnRMu/rb9/2KF
         S19A7lnjkN5dNDNFaBpil14PhcF5ipQ9ZW/l+0gdFWyVytAtN7T73hTykKaz1VCH9KlJ
         otcKY0XxQrOedmxqhkxrLkLeNJNCy8oVsqdvz0IYysqca4dnFeFGoi1cHCjHxZKOJ6VE
         zThxYvPaqA5zuBXlQUnCRF7CnPbTj6gL/hHoFgIpFVo3terOXSxJzGdvLhS1BgT4jdqc
         7NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJNMlAjCQN+181+/g6x5fUtpPJBPnpWSqxofLDKTmwI=;
        b=AD3TRpxBPpf/wA4PqKoPURBd2Vov0Zej5ypx3seBegphoE2uDbPlXzPDziQJqDMAN3
         VtQ8EKgetJn4xm2P0iAgrHizhBtKMb+RJr719muaezcRkF9Txr8CeDZbdsx+3Mh+7nz5
         AGStbQGQ/pQq8liVCLTB7PLDn7Zm7A16B3r50pb44UQ4AG+yF1DxmapFR2Nvq8cG5eDK
         e4y4VsKGPmFz/xlvw6ea/vHCFfZKqQnKJa3abxJ82NdnBrbkrI53GKP0Ltsie2OaARJP
         bwHm7FocEut1/UeuhAgx2nS7AcoJxtj5vAGt7/zDXZ3PcyuOrTz1AUtDLQaK4686M/WD
         VaSw==
X-Gm-Message-State: ALKqPweCcQA/0F753+jr9knM5PmINAaxjtM5OAeoQxzNWYPiqiaXBWTT
        VOO/TnA+jtdAa171mXWzNo3woQ==
X-Google-Smtp-Source: AB8JxZpVOVOloMKpUvKP4ZQDRH2YtL2pwmB4x9VepcIot5EIn89etwN6ycS4HZ+X6DduGD4UwJ3vmg==
X-Received: by 2002:adf:9162:: with SMTP id j89-v6mr1448669wrj.196.1525960770998;
        Thu, 10 May 2018 06:59:30 -0700 (PDT)
Received: from localhost.localdomain (x590c7c95.dyn.telefonica.de. [89.12.124.149])
        by smtp.gmail.com with ESMTPSA id u20-v6sm1275646wru.33.2018.05.10.06.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 06:59:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t5310-pack-bitmaps: make JGit tests work with GIT_TEST_SPLIT_INDEX
Date:   Thu, 10 May 2018 15:58:52 +0200
Message-Id: <20180510135852.25232-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.756.gcf614c5aff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two JGit tests 'we can read jgit bitmaps' and 'jgit can read our
bitmaps' in 't5310-pack-bitmaps.sh' fail when run with
GIT_TEST_SPLIT_INDEX=YesPlease.  Both tests create a clone of the test
repository to check bitmap interoperability with JGit.  With split
indexes enabled the index in the clone repositories contains the
'link' extension, which JGit doesn't support and, consequently, an
exception aborts it:

  <...>
  org.eclipse.jgit.api.errors.JGitInternalException: DIRC extension 'link' not supported by this version.
          at org.eclipse.jgit.dircache.DirCache.readFrom(DirCache.java:562)
  <...>

Since testing bitmaps doesn't need a worktree in the first place,
let's just create bare clones for the two JGit tests, so the cloned
won't have an index, and these two tests can be executed even with
split index enabled.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5310-pack-bitmaps.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f6d600fd82..423c0a475f 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -264,9 +264,9 @@ test_expect_success 'pack with missing parent' '
 '
 
 test_expect_success JGIT 'we can read jgit bitmaps' '
-	git clone . compat-jgit &&
+	git clone --bare . compat-jgit.git &&
 	(
-		cd compat-jgit &&
+		cd compat-jgit.git &&
 		rm -f .git/objects/pack/*.bitmap &&
 		jgit gc &&
 		git rev-list --test-bitmap HEAD
@@ -274,9 +274,9 @@ test_expect_success JGIT 'we can read jgit bitmaps' '
 '
 
 test_expect_success JGIT 'jgit can read our bitmaps' '
-	git clone . compat-us &&
+	git clone --bare . compat-us.git &&
 	(
-		cd compat-us &&
+		cd compat-us.git &&
 		git repack -adb &&
 		# jgit gc will barf if it does not like our bitmaps
 		jgit gc
-- 
2.17.0.756.gcf614c5aff

