Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CD4C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 15:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2240864F5E
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 15:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhCQPuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 11:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhCQPuM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 11:50:12 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2466AC061762
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 08:50:12 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id f2so18052929pjt.7
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oXbZwRI2lAZQkDFLWssimxjTLuBLIYAWFY4L2TT1a50=;
        b=pvxRF765WY0rfDDNSnI2/2alkyc5rb8afgxToG4TW/evaTjgeoKCV88U37ayhKtMRs
         8oixL/T1ZkZ9G71oziG2EnvtTxUFjMf1QsbsJqBSNDEatAC0OCH/YRCs0yH0VliwhHye
         LUitkGivOwACbR9JYQgu3FhCkFFVZceeOkJmpYFIT4/A+zzk6lfvU81K9Ct6KpVZhRmh
         Kyyh6skUlKt0Oko+Qk8TscdxWsj9RdCBd4cOZOIxWB6e2ZH0Z4zIthpZrx+DgMcrUAP5
         3r2THtQFUffepmjqcyRBxNCP8D/Ra2JLO9Twor9wHylRGWKBLcABOXcXMSxN7P2I9RAh
         MYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oXbZwRI2lAZQkDFLWssimxjTLuBLIYAWFY4L2TT1a50=;
        b=Q3zpPbvGdEF4aC+2MsoC0eVsA2BC956/6E9B2oI9kBHq8LCv772TN7aGSFIDY9EtD+
         NkUA4PU7bwIQyNoip1a1C9H22HKsjEtBeB/xG04jV/ANt76AlDn0PEEGezVbx5gCueQr
         FgRzBbx97Y72BU32kZ7DvHtFLn7QtIDwB15fDcZtY/YOJjfeKXcXJ4GtifqWTwDLUKFJ
         bAPX9a4/Era4Q38ul966NKNHqeT4glZqq5hSD6kbtSgUdDZ9xZDC9NtT0V+seb60x9yt
         WHqVTd4n9JadZYx8KK4ULiZbZTWqxvb4YtF0tcDk0n+76GT9v+i64N68UJeD1GNJ2TAx
         UuOg==
X-Gm-Message-State: AOAM533UoSWmKg1BHFsBT/X5tMBlYsmvp4ZqB6QU8l9ff/btJn+A4L/t
        3/ZgQrBD0HCAzWFUJ6hCC7567QOO43W0qUe+6n3LGOD7r2KKfyYv8fHjpIVqcRdpjjZcF76T/Gq
        U0PmWQKqfxQb5DqBDVwj6YGL4wTouV9DjejVdAN36o6pnfykuu41JU7ENsalJmELYnQHf/6F6rE
        wi
X-Google-Smtp-Source: ABdhPJwEkhgaNrF9THI3SHN/JBsQ/D3P0RwIYwuol0vzqFBLNKqnS0Ab4WdKKE8MyPJlY+z/ES9+WkGftB3QXXhk3RUA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7407:b029:e4:9645:fdf6 with
 SMTP id g7-20020a1709027407b02900e49645fdf6mr5279405pll.19.1615995727163;
 Wed, 17 Mar 2021 08:42:07 -0700 (PDT)
Date:   Wed, 17 Mar 2021 08:42:00 -0700
In-Reply-To: <YFIGSo3U5u7zy9fq@C02YX140LVDN.corpad.adbkng.com>
Message-Id: <20210317154200.2656837-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YFIGSo3U5u7zy9fq@C02YX140LVDN.corpad.adbkng.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] t5606: run clone branch name test with protocol v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sluongng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

4f37d45706 ("clone: respect remote unborn HEAD", 2021-02-05) introduces
a new feature (if the remote has an unborn HEAD, e.g. when the remote
repository is empty, use it as the name of the branch) that only works
in protocol v2, but did not ensure that one of its tests always uses
protocol v2, and thus that test would fail if
GIT_TEST_PROTOCOL_VERSION=0 (or 1) is used. Therefore, add "-c
protocol.version=2" to the appropriate test.

(The rest of the tests from that commit have "-c protocol.version=2"
already added.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks, Son Luong, for noticing this. Here's a fix for the
GIT_TEST_PROTOCOL_VERSION part. This was built on 4f37d45706 but also
applies cleanly on master.

 t/t5606-clone-options.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index ca6339a5fb..5e30772735 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -106,7 +106,7 @@ test_expect_success 'chooses correct default initial branch name' '
 	git -c init.defaultBranch=foo init --bare empty &&
 	test_config -C empty lsrefs.unborn advertise &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
-	git -c init.defaultBranch=up clone empty whats-up &&
+	git -c init.defaultBranch=up -c protocol.version=2 clone empty whats-up &&
 	test refs/heads/foo = $(git -C whats-up symbolic-ref HEAD) &&
 	test refs/heads/foo = $(git -C whats-up config branch.foo.merge)
 '
-- 
2.31.0.rc2.261.g7f71774620-goog

