Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBE3C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0F4207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g54MWSPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHCS5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:57:53 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CC9C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:57:53 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j11so412592pje.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rV0TJ9XoHq8hx0K6OMeW5qk1OJpKv0mHICf6SdmNyy0=;
        b=g54MWSPErmHsMxyfx+lus5dUIC57E66ko6fIDE/hcU7GPHgk78KXcO3KE4dE1KHjgB
         NfCT5sfysliOAT1fUJSH8JZpkFL1CB+FXEubj3SRYshjhLKahMGkRiM6aCqptFMT/N/Q
         kn63S9lkfTe+nZgAVnl1lihsalJP2HPz7hmV/e2pSqlpcNVQNqG6Ijq48kcuu3oVozRx
         Otv4TjYPDn0m2xj+khZu6XVlfxDbC492/3Imq/ZUXfofaMTMLeaEox5Kd/Zi8zMouv/y
         YTYE2KOh8Dja/J0Qik+YgBKJ9J9s3GNG9zs/UmXN4MJeeQWSnzzLAVy5Co1dnMaZWv6h
         8MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rV0TJ9XoHq8hx0K6OMeW5qk1OJpKv0mHICf6SdmNyy0=;
        b=F1gBxQWgxv9KAK6yR1s8cFNgEqdEGEyhYUbQSEPRn1iyAKqs023sXfbe4N9fQhBCFb
         CNN9wM6Rs5phQXVYiOcHfuPAVPtzVDCnsgL6ANBkPunTcJ+pi/VWcJDwJIch2JGxq8Ri
         +KwnmooIREnr8i6+tdyoGPbyEg8c6aMvqO6GvIEAMV2aMigniTBJYt7zsi8tNDjKNlWz
         WtjrF4M9ymWjfjQNYyHPf5BYK8y/mDVousb5Y8lGSoiX0hukHVO8hf/7kngrlhkuJTtl
         waHjv1ZYgFc2EmVvsh81cTOPLvqqL6I3DVsp3p5qeHtJMg6IPqGC3TOhmAnJLJXNT53h
         wFyQ==
X-Gm-Message-State: AOAM530dCySIwC1S5D2QWQzbqvTDYTdMtAT+2F2+jeYX+MqgtjTMaSeF
        c1hfrQqgL1UIVt2uyPEzbcD34RR8qkFQkYPQyCgPaGkeO2Iwd0ZUpNhkIDdCREPEgTP0OzNTftS
        wsWRzsC8s1bIuh6sN2J4mvo8Kyt0bXqCLrv4/anw1H8pdyNtrpuee4M8bFnK/vL7pH6fhGHR9GQ
        ==
X-Google-Smtp-Source: ABdhPJxC0yToqaqygRLSrE+9R7/ZEFlwRotTjdcQvwlhBIIePGGoX5JxALGtDzfch97R4Vxapjus8j7rs4sTWajdA/Y=
X-Received: by 2002:a63:e617:: with SMTP id g23mr6380760pgh.102.1596481072492;
 Mon, 03 Aug 2020 11:57:52 -0700 (PDT)
Date:   Mon,  3 Aug 2020 11:57:49 -0700
Message-Id: <20200803185749.1441344-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] Revert "contrib: subtree: adjust test to change in fmt-merge-msg"
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=" 
        <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 508fd8e8baf3e18ee40b2cf0b8899188a8506d07.

In 6e6029a8 (fmt-merge-msg: allow merge destination to be omitted again)
we get back the behavior where merges against 'master', by default, do
not include "into 'master'" at the end of the merge message. This test
fix is no longer needed.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

I don't think anybody else sent this yet. Because the default value of
merge.suppressDest suppresses 'master', the commit messages are wrong
again for these tests. Noticed during a release for $DAYJOB. Thanks -
looks like Linus was right that we get to remove lots more instances of
'master' from codebase with that config patch.

 - Emily

 contrib/subtree/t/t7900-subtree.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 53d7accf94..57ff4b25c1 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -196,8 +196,7 @@ test_expect_success 'merge new subproj history into sub dir/ with --prefix' '
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		check_equal "$(last_commit_message)" \
-			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
+		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
 '
 
@@ -274,8 +273,7 @@ test_expect_success 'merge new subproj history into subdir/ with a slash appende
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir/ FETCH_HEAD &&
-		check_equal "$(last_commit_message)" \
-			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
+		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
 	)
 '
 
-- 
2.28.0.163.g6104cc2f0b6-goog

