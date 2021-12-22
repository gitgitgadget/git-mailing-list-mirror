Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1C2C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 10:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244345AbhLVK7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 05:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244340AbhLVK7u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 05:59:50 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44964C061401
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 02:59:50 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s1so4066515wra.6
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 02:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kbyye6oOYDb03kAxg8U9TW1QQ3JEa1Eciuhp/1BZTSg=;
        b=MoiukF6q3UpI1ClQxk3mISZG7RqgAG4PJL6+bfpNOgcqrKHm0slS0iPF9ET0zjZWB1
         FAJvp8/XF4hBp/ME5VLuMyrth5IV9SAhyoGeoXOMRpBsizSFhn2gqy/UtHVoD3vxKegq
         iwdRS0xX1Zw40wvkVP2Q+ZUWeC7tM/VAN06rnSOXdAze2DEMTJ5Z3GCrN5CU+jFRKDsk
         ZZr/1zTH2+Fq8RP9Jxy+fWiMdafeHEuxeh7sjW2mv9zUwBwn9byVVkyo/6GDm5cQjRnq
         YhPxRbNoHFRjgeBbS+hfhmTrBY5eXH7N9z4BLXzgSWFJueZW8PXn5RqN1sLhkbuDYLc5
         /7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kbyye6oOYDb03kAxg8U9TW1QQ3JEa1Eciuhp/1BZTSg=;
        b=5ax/Z4XV+qBDUmJ248OxYKkrIcdTGR79cIBtN0qleA4Lt6L650E+XhqWLz8XK0HWHF
         /FaDuermJYZRz2DSsOcqW7PNqy72jPvepblWsY0/9sgz8OYd2+BZEFa+8jtpBw9rdR2N
         QaJRR4euiriS2s3cIKo3s3cCViFTbvs5LQpWjljcCYxuj9ES8v9cexFRhgKXjqshbWCH
         iTA+USACM02LOrVLakXllKWISeW+koQJNYMja0meBXBuoJjLjXxFIUUshISgOdy1eDaS
         N1t6eNtpoMPK6iHDi3Zy5MjEyPMvLMeo6to7dc4NJ1mrVsGj3CSB0HstELJcWgu3387E
         Qeog==
X-Gm-Message-State: AOAM533K7ghmLD5/Q2VA7uhU+irVts6pqdBvLbQgAsefbUkUiBc9bGe3
        +ww4NY293XAZ48algzRzLwqAD21F5TQ=
X-Google-Smtp-Source: ABdhPJx4SQA9Z/8okn7p2m9yVUjGBw5qBqqKsAaPxSlLhnt5j1ZR5nreeUIDIPCUhqBLd3ZIZRuCsw==
X-Received: by 2002:adf:cd8a:: with SMTP id q10mr1736831wrj.164.1640170788736;
        Wed, 22 Dec 2021 02:59:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r62sm1421008wmr.35.2021.12.22.02.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 02:59:48 -0800 (PST)
Message-Id: <5d693273e5852ae9b302cb79e8dd986b6ffa10da.1640170784.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
References: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 10:59:44 +0000
Subject: [PATCH 4/4] t7004: use "test-tool ref-store" for reflog inspection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This makes the test work with reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7004-tag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 301d1190482..bc8a221b2c7 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -97,7 +97,7 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	test_when_finished "git tag -d tag_with_reflog1" &&
 	git tag --create-reflog tag_with_reflog1 &&
 	git reflog exists refs/tags/tag_with_reflog1 &&
-	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog1 >actual &&
+	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog1 | sed -e "s/^.*	//" >actual &&
 	test_cmp expected actual
 '
 
@@ -108,7 +108,7 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
 	test_when_finished "git tag -d tag_with_reflog2" &&
 	git tag -m "annotated tag" --create-reflog tag_with_reflog2 &&
 	git reflog exists refs/tags/tag_with_reflog2 &&
-	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog2 >actual &&
+	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog2 | sed -e "s/^.*	//" >actual &&
 	test_cmp expected actual
 '
 
-- 
gitgitgadget
