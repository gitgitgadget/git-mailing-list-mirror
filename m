Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49125C636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjBGSMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBGSMl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:12:41 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB03A876
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:12:40 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id ik17-20020a170902ab1100b00198d8abcbcdso7051087plb.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 10:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZOu5tTmADFihvvxrbSwD4f+LPu+PIR1S0mtGI8Km4dM=;
        b=TFoPh1NRzqrFbgNHsSKrT/UWXB6LHppSKDmrPGJWlvjmXr0q1txiPwXc+/8cvBCR+H
         RoSVqIuw0ELZGEwqEwXbE2y+ZDvqJHMgWreBv8x9XaqzXiBx6e4wTUxoTn3vZjvIIgie
         /2dXKkAG3kZ/MIj1oiBczpGXU3RZMc8cOcDkBWwF/JfHd+mVgKnD+3wXURemVNOmFGBH
         yfcXElDRTvnd1Kj1WaiQWKltZuz4XmONEkl0BR5q5yxXxJBa/alCy+GEvTTrv34ooCx+
         iHRfFvwMu1WYXxANJr57zgrZNkfRsiAeOXB90XhcB4RgxC5lulRQczgADjnz6PcTwGtK
         +FFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOu5tTmADFihvvxrbSwD4f+LPu+PIR1S0mtGI8Km4dM=;
        b=ByerL8rlBBS/7+2VRxt/IzR+/oZ2sf/2QxjiLU93DcoiO8Pvs/p4DpWvbfumo33Al0
         dzYrqB2e8ZM1yHoIGdv4pRJSrxuDq/fBUzYi6q9Ugx8GmrFhjSlaANV3Y33ERXxuOLWw
         ueGRpT1ROpUtgkl90M9dUfUSIwPr5uUS5/4gn8rKqFA4Gl2IXL0rI5gOxXOfZ/nP0ldC
         f4XsoUSpFtJYV9utHgNlI67t2/BUsqKblwLdR916R6cldMD30ZmgSz4C8UXFAoF5jKC3
         dL1yW9EJwTCYINBlJBDvbiwP9QjKIHxl4I2l7glpm1awU+KbpSIF+g9WxfK30yL7mRWC
         HZFA==
X-Gm-Message-State: AO0yUKWx/qglAtISqTeDdENSdhlQvKqsGmtXjrVJu7vGaOUbpix7uKjn
        tjGIIyuG/CGQg7oK+t6r+lv5U57hYILn3h8ApQ98kmuqPb+AtXiDA3Ryz4nHqcYUEzGSx/mBdHI
        RObUvfF/2MhKYY/Wioojzg7sf+yy9dSNaiixbw9ResbfkBHTMXFBefOYK7C2Ieqe1Vg==
X-Google-Smtp-Source: AK7set9KH06ZsG8/W9zVx/jQPuJNs0qAYhsnADREEH7NIj50F7LzPuZBHjqDsxmE0Y/qmY0mFQLKaPWcn98hncU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:c111:b0:196:218a:92bf with SMTP
 id 17-20020a170902c11100b00196218a92bfmr1049723pli.8.1675793559727; Tue, 07
 Feb 2023 10:12:39 -0800 (PST)
Date:   Tue,  7 Feb 2023 18:12:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230207181227.361290-1-calvinwan@google.com>
Subject: [PATCH v2] Documentation: clarify multiple pushurls vs urls
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a remote with multiple configured URLs, `git remote -v` shows the
correct url that fetch uses. However, `git config remote.<remote>.url`
returns the last defined url instead. This discrepancy can cause
confusion for users with a remote defined as such, since any url
defined after the first essentially acts as a pushurl.

Add documentation to clarify how fetch interacts with multiple urls
and how push interacts with multiple pushurls and urls.

Add test affirming interaction between fetch and multiple urls.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/urls-remotes.txt | 4 +++-
 t/t5510-fetch.sh               | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 86d0008f94..e410912fe5 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -33,7 +33,9 @@ config file would appear like this:
 ------------
 
 The `<pushurl>` is used for pushes only. It is optional and defaults
-to `<URL>`.
+to `<URL>`. Pushing to a remote affects all defined pushurls or to all
+defined urls if no pushurls are defined. Fetch, however, will only
+fetch from the first defined url if muliple urls are defined.
 
 Named file in `$GIT_DIR/remotes`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index c0b745e33b..34a1261520 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -806,6 +806,14 @@ test_expect_success 'fetch.writeCommitGraph with submodules' '
 	)
 '
 
+# fetches from first configured url
+test_expect_success 'fetch from multiple configured URLs in single remote' '
+	git init url1 &&
+	git remote add multipleurls url1 &&
+	git remote set-url --add multipleurls url2 &&
+	git fetch multipleurls
+'
+
 # configured prune tests
 
 set_config_tristate () {
-- 
2.39.1.519.gcb327c4b5f-goog

