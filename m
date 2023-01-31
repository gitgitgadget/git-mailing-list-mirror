Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3EDC38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 13:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjAaN31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjAaN3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 08:29:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE64860E
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:24 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso910462wmb.0
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYBJOViu+O2gi7DLng7rH3WxdKvyH5pj0JIiJdL8CsQ=;
        b=TpmNnYr+l+LhJurYEE92vTY7YH7DmeDg8LkP2KWp3sbnPXwCWRab5TXfW7rkuwOjGO
         asGqEdxClsViKmlnV6u8+UsxRrhud0FZVnLs/M/AzPcPBdBMqb2jH4LFSG0f/yfKCo5u
         ExFbqv94/Q1rbNpXBE+9NwipkkyILTX6bTkEzigtHjB2jVBQg+oWE+XLQJg1G1c+QaWF
         jIpZvFfv4+nCaH5uxQjloYpjiWljPf4CJ+uFbodLXbOZZPOvMEMdwW9eBAPf1pIZpyL7
         8BuDIKl272grioeQDgSq7ZNZfMwGFXua02NxDncvtgAGEr9O7R6Z9OdeHpzpFTj8rJZp
         q/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYBJOViu+O2gi7DLng7rH3WxdKvyH5pj0JIiJdL8CsQ=;
        b=Lc5+wD1Wbt7vMJ0au3lpeSwC9WOFLjHGJ34d5MSVgm1X+dfnUCsk136AWEMaPnzCoY
         safguJcD8qBWQ9MhjCd+4zLmb6b42lQF6HolofFhOQmPPrmQMQdxgM3qLEZHdZtAfK5C
         KFvMI2cuZ1x3F05IzkBN3hVSr2LUhpYtImBqj8BLgCgd/PcQj263RtV05On92EVnVA6U
         RKQ2kYzTkoN3BGCfkuZDyfc6H31cF8GoFrSU60cCc9pJrnLpvVmOkZSmjfavusMgOGW/
         LszXkfu3Pt2Y5tQBZgAPE9MEUUkpKQFWE7JHM4QHGeyrJXr/IUEicLLZPbTM3qAitloc
         DCsw==
X-Gm-Message-State: AO0yUKXt/BowrirIQpWPWBiu7hWjqGj3UVCF1WEPdcajfzjC+npJr+gD
        mhQVg3KGs3ztKmxtmCHkT0vDye0VJZ4=
X-Google-Smtp-Source: AK7set8z3zGo8sAi20JLTDJOXU41D9fPoOhysCvgffi58jTrKY8VbTwNppifk2OM1xymQ3l4JMZJSw==
X-Received: by 2002:a05:600c:1d2a:b0:3dc:443e:4212 with SMTP id l42-20020a05600c1d2a00b003dc443e4212mr13049409wms.1.1675171762576;
        Tue, 31 Jan 2023 05:29:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c151500b003dc5b59ed7asm5255968wmg.11.2023.01.31.05.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:29:22 -0800 (PST)
Message-Id: <f9b0cc872ac44892fe6b1c973f16b35edfdc5b20.1675171759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 13:29:09 +0000
Subject: [PATCH v3 01/11] bundle: test unbundling with incomplete history
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When verifying a bundle, Git checks first that all prerequisite commits
exist in the object store, then adds an additional check: those
prerequisite commits must be reachable from references in the
repository.

This check is stronger than what is checked for refs being added during
'git fetch', which simply guarantees that the new refs have a complete
history up to the point where it intersects with the current reachable
history.

However, we also do not have any tests that check the behavior under
this condition. Create a test that demonstrates its behavior.

In order to construct a broken history, perform a shallow clone of a
repository with a linear history, but whose default branch ('base') has
a single commit, so dropping the shallow markers leaves a complete
history from that reference. However, the 'tip' reference adds a
shallow commit whose parent is missing in the cloned repository. Trying
to unbundle a bundle with the 'tip' as a prerequisite will succeed past
the object store check and move into the reachability check.

The two errors that are reported are of this form:

  error: Could not read <missing-commit>
  fatal: Failed to traverse parents of commit <present-commit>

These messages are not particularly helpful for the person running the
unbundle command, but they do prevent the command from succeeding.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t6020-bundle-misc.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 3a1cf30b1d7..38dbbf89155 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -566,4 +566,44 @@ test_expect_success 'cloning from filtered bundle has useful error' '
 	grep "cannot clone from filtered bundle" err
 '
 
+test_expect_success 'verify catches unreachable, broken prerequisites' '
+	test_when_finished rm -rf clone-from clone-to &&
+	git init clone-from &&
+	(
+		cd clone-from &&
+		git checkout -b base &&
+		test_commit A &&
+		git checkout -b tip &&
+		git commit --allow-empty -m "will drop by shallow" &&
+		git commit --allow-empty -m "will keep by shallow" &&
+		git commit --allow-empty -m "for bundle, not clone" &&
+		git bundle create tip.bundle tip~1..tip &&
+		git reset --hard HEAD~1 &&
+		git checkout base
+	) &&
+	BAD_OID=$(git -C clone-from rev-parse tip~1) &&
+	TIP_OID=$(git -C clone-from rev-parse tip) &&
+	git clone --depth=1 --no-single-branch \
+		"file://$(pwd)/clone-from" clone-to &&
+	(
+		cd clone-to &&
+
+		# Set up broken history by removing shallow markers
+		git update-ref -d refs/remotes/origin/tip &&
+		rm .git/shallow &&
+
+		# Verify should fail
+		test_must_fail git bundle verify \
+			../clone-from/tip.bundle 2>err &&
+		grep "Could not read $BAD_OID" err &&
+		grep "Failed to traverse parents of commit $TIP_OID" err &&
+
+		# Unbundling should fail
+		test_must_fail git bundle unbundle \
+			../clone-from/tip.bundle 2>err &&
+		grep "Could not read $BAD_OID" err &&
+		grep "Failed to traverse parents of commit $TIP_OID" err
+	)
+'
+
 test_done
-- 
gitgitgadget

