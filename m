Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB14C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 16:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356590AbhKYQNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356418AbhKYQMp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 11:12:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00DEC061398
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s13so12670423wrb.3
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e6+WnkX6yxU+fTCEoT1Ezugcrp1CvRrsB10irWdpGMI=;
        b=SPTWA+UZZta4jhwxqaJa+r28BqOu+5UhO7fFtYatRGpzdzKhYk5rLRv7iG3MGZX6rU
         rL1xvFtbVeA9OWEMksf4DsFVENZwuxEZWexCVWHaFU1qjRwrXkIzWp0GZsXQr7W42CFo
         4RX7lM5N9qyubf2hqqeQKkPbouZAQJpqQUE3QjUMaKaDRLf1wcI0vAMQQc9NTf7fefTP
         4HGjjP87UEhDj6Ihjy3tpUstoWXHwbVp/uVCUYdjSYpIlws7B7KatO69HS/yOntObBGf
         Km1WRdUmrTBtThxIUtpA3h5hWUnbgshjM/h0+acTSvmOSue6JYBFVTBxfbNA7wM+pQXV
         LtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e6+WnkX6yxU+fTCEoT1Ezugcrp1CvRrsB10irWdpGMI=;
        b=NoSnnqbbtzJNZkLDJjiig1MoxN2JJZb/0/QppMyqMwNfPVZWWdtWzQh0chrHn9Eyf1
         EujNMqNhuuptnVXySZOKYeMZIbo4CJpPO4wDjZTlr5KEl+E2lkFXQMKO7zCSlqZKD8I1
         a5HEoLIXNVIwA0X7BsQV34wKVKdhT03LHh+WFjEeCoNmoQDgnaCwjMfPWbB2TP1Oc+mK
         971hvDEZyA+2F5DzTvnBcDqf/iI17Y6dv4uBatwOb+Cv2kDDGWFcQ4ZOZxQt+D/jwCUm
         Pbu1EqGc4QjKQ5NXzf+mHqehm+RPZKLwdfII0b4ScBvYc53H+4qIqnSQqCnIwLFLKU8o
         lyDg==
X-Gm-Message-State: AOAM531xuiBa5fo8q+qG5m/ObDgu9s5cfkcdC3op0zUN4GW00ICJXJAI
        vJzL/G11bPFYZrGiEE2EpFrPW9QVT6I=
X-Google-Smtp-Source: ABdhPJwNFEelFyg9bVo3talGERdFCqHyaBpodYlMPPUAHWECdmj3YkSDMCJiSWcX/bOvDZOF8qUzoA==
X-Received: by 2002:adf:d0d0:: with SMTP id z16mr7837228wrh.601.1637855875190;
        Thu, 25 Nov 2021 07:57:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6sm3275730wrn.53.2021.11.25.07.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 07:57:54 -0800 (PST)
Message-Id: <4a86d21258918ea8124caef1cd2e435b465f67c5.1637855872.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 15:57:49 +0000
Subject: [PATCH v2 2/5] test-ref-store: don't add newline to reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The files backend produces a newline for messages automatically, so before we
would print blank lines between entries.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c      | 5 ++---
 t/t1405-main-ref-store.sh      | 5 ++---
 t/t1406-submodule-ref-store.sh | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45b..ef244aa6b27 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -151,9 +151,8 @@ static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
 		       const char *committer, timestamp_t timestamp,
 		       int tz, const char *msg, void *cb_data)
 {
-	printf("%s %s %s %"PRItime" %d %s\n",
-	       oid_to_hex(old_oid), oid_to_hex(new_oid),
-	       committer, timestamp, tz, msg);
+	printf("%s %s %s %" PRItime " %d %s", oid_to_hex(old_oid),
+	       oid_to_hex(new_oid), committer, timestamp, tz, msg);
 	return 0;
 }
 
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 49718b7ea7f..a600bedf2cd 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -89,13 +89,12 @@ test_expect_success 'for_each_reflog()' '
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep one &&
-	tail -n2 actual | head -n1 | grep recreate-main
+	tail -n1 actual | grep recreate-main
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
-	head -n1 actual | grep recreate-main &&
-	tail -n2 actual | head -n1 | grep one
+	tail -n1 actual | grep one
 '
 
 test_expect_success 'reflog_exists(HEAD)' '
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 0a87058971e..b0365c1fee0 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -74,13 +74,13 @@ test_expect_success 'for_each_reflog()' '
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep first &&
-	tail -n2 actual | head -n1 | grep main.to.new
+	tail -n1 actual | grep main.to.new
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
 	head -n1 actual | grep main.to.new &&
-	tail -n2 actual | head -n1 | grep first
+	tail -n1 actual | grep first
 '
 
 test_expect_success 'reflog_exists(HEAD)' '
-- 
gitgitgadget

