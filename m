Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCCFC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 16:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC68B2072F
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 16:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591808087;
	bh=8ADtCG54UDaPz6cfLqznytSLdWvv4QJKGhY0aKPnkbE=;
	h=Date:From:To:Subject:List-ID:From;
	b=OgI/1SVVPDf4aq3h2VAkfkjhJWd90Ls1QKn3BGDTouEixKa69+q4NnFTrKns16HPn
	 1Fe7yEl3tKOFNcsulFCH79yUyQl3Z3qLOt9W+ceI0SHhyoQlf8Ycv05vvTD8UsSsKk
	 VbKmBfusXPGv7fRthVbjLk8upiHJvMix1SiDJJgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgFJQyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgFJQyp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 12:54:45 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A298C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 09:54:45 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id e2so1337358qvw.7
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=v7+VKpZlQOyW2y88L6rEAH9GQ289n9bGYM+tzu5TwIw=;
        b=CcknfbQRZndCnwztKFJIZiolm7iI/GM5OhNly9MPzN9MKYxVZr3JWz/ILv1Qe3xhW1
         AKcMcrUq5ZzkxzQ7ZEpFImfbPp9ek8FuuTdeSG3PgYqmfaw1HdmpqoKv2rly70W4LRRy
         E+5BaBIy0bha10S+evFEnn9q05DmvKB+C4Rog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=v7+VKpZlQOyW2y88L6rEAH9GQ289n9bGYM+tzu5TwIw=;
        b=EbQa0oKdSVc/UDVP3mTmAwFd0Vm9pOBGTJaJfRpXQjx3W5uyVXskemTV1LdxgYmjJx
         mhQG/ThohiFf9wj3OW8hPGC+WDPWsjUftU0Ub+53yJplfrt1Y+5xHYh/o6If8MIjXptD
         Ate+dIjo/rAr9/uFwDOccxiYd4vRFpfmIQbMwu9rhm3qN0GII6wCo9ovHFIs7JuD8m/p
         nAoHLYdWX9HIA5mSfhAmnf56sQ7HRRjITOCnzXWhha9ulr9a3U/FhCpmvvKRg+qCO0g/
         5VkZHfYcXHqGD2WCju3cQxJhvyquscTmttwHNLbxOwRx69W0xluE7cC9nPZFwk0w4QCt
         rmoA==
X-Gm-Message-State: AOAM5326V/Nzrb/oEALBXrZ27uqWDcmEfzXyrokfMM6LYqHIsCCjB63L
        hbWV93hI8QViCWfIAW+1AxkRmqa8kGw=
X-Google-Smtp-Source: ABdhPJw4L0rXOEKFs1bnHUXhv/oqqXQ3eiHqYKBY+N5j4Yo8H4P7LtJCriHiWfA2800fn7vzP66e7w==
X-Received: by 2002:a0c:c249:: with SMTP id w9mr3969873qvh.149.1591808084034;
        Wed, 10 Jun 2020 09:54:44 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id v3sm157365qkh.130.2020.06.10.09.54.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:54:43 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Wed, 10 Jun 2020 12:54:41 -0400
Date:   Wed, 10 Jun 2020 12:54:41 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: [PATCH] Use sensible titles in t4014
Message-ID: <20200610165441.iktvzuwz44sbytfg@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch to "test" and "testbranch" in order to avoid using divisive 
language.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 t/t4014-format-patch.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 575e079cc2..e6e7995d90 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -81,16 +81,16 @@ test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
 '
 
 test_expect_success "format-patch doesn't consider merge commits" '
-	git checkout -b slave master &&
+	git checkout -b testbranch master &&
 	echo "Another line" >>file &&
 	test_tick &&
-	git commit -am "Slave change #1" &&
+	git commit -am "Test change #1" &&
 	echo "Yet another line" >>file &&
 	test_tick &&
-	git commit -am "Slave change #2" &&
+	git commit -am "Test change #2" &&
 	git checkout -b merger master &&
 	test_tick &&
-	git merge --no-ff slave &&
+	git merge --no-ff testbranch &&
 	git format-patch -3 --stdout >patch &&
 	grep "^From " patch >from &&
 	test_line_count = 3 from

base-commit: 0313f36c6ebecb3bffe6f15cf25a4883100f0214
-- 
2.25.4

