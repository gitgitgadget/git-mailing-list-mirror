Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E5C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 16:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1F9207EA
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 16:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdnP9Uh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437971AbgJQQCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 12:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437930AbgJQQCh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 12:02:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F6C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 09:02:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so8552212wmj.5
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jNEByZ5cCP0t/Gjli6z8Lu7U0xgbIz7D8yTBYLk1Fz8=;
        b=jdnP9Uh2sleVU/nTDrIGOX6lHKiTCyNgBFW6rWXKaSm1ePBstpArC0XbxIXXx3agYe
         ff1ZCi0XnRxUj3WwPAmtrZckVPBEAtXm1SDSLklsE5r2hlYG5jCyMqFl7zkkpCAu77CT
         aaFYY/lnYqFYmna+s1T6DDadj3I/5U2UvoxJlsWPiz+mr6BGmanyZnbh7YPtHbr0g1p+
         BGvafvbq6sa64GoiqXAk1cUtTD1SVOr+TweoNk3Aokn/Rz6ozWzKZlBfGb3HEm8E2zKr
         tJW8BvmJ/cE7hj/pXJwKV2pZ0St+Ei8PmHxYLy43f4psVPCCu+S6M3vtDHtEYyfKufDm
         MmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jNEByZ5cCP0t/Gjli6z8Lu7U0xgbIz7D8yTBYLk1Fz8=;
        b=uZHrACnFWu5rMelha/xZOgLBZsXkRgN9YNxXTkWto77sxWry8ecZxNRkSoqhjsAQUb
         WsXT0I+XKXPF1LYIdkgIjQaR9fNmNRumy9PXwvwqXFWBBrWpcwEZDWWRo+PHtRZXSoPz
         r9qF+YGuGe3Cs5UBZlNXfuFM+1W/MoYFyzMHHNQXdP1TeZCb2U9edJL9RiOXgeM4FJZD
         npazzOlAzvdJd8FXzaYYvjT1qzgkeWV3larCmGVIgwMHJDRdrtHcsV+S4UHIiho3erRh
         lMKteW+UdYiuSomBzmTSHpiZgiL6pVAQ9Re4pIcbPkV0AeeFVylo9y872y/KlFFWvIW/
         oJJA==
X-Gm-Message-State: AOAM530NAKUxXBs32u7QNFxama+72hVtFEbMjUdMkRUrx3CDfG3Je+YY
        ygGAitH5dexNH+XNvzWfeU/BwqsRiGk=
X-Google-Smtp-Source: ABdhPJwzVanO6a4fCT+P6Fni2WAOXv+ks4Jey8tvjazda1sPu8d2p292sgoRTKazqrPum6KYqH9Atw==
X-Received: by 2002:a1c:449:: with SMTP id 70mr8859606wme.40.1602950555019;
        Sat, 17 Oct 2020 09:02:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5sm8699230wrs.97.2020.10.17.09.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 09:02:34 -0700 (PDT)
Message-Id: <0a1550cb225591a53118bd8f7782d95de5a4df34.1602950552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
References: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
From:   "Amanda  Shafack via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Oct 2020 16:02:32 +0000
Subject: [PATCH 2/2] t2200: modify code syntax
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Amanda Shafack <shafack.likhene@gmail.com>,
        Amanda Shafack <shafack.likhene@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Amanda  Shafack <shafack.likhene@gmail.com>

Using the logical not operator on both the git and grep command is
redundant, since the main check is done at the level of the grep
command.

Apply the logical not operator only to the grep command.

Co-authored-by: Johannes Schindelin <dscho@github.com>
Signed-off-by: Amanda Shafack <shafack.likhene@gmail.com>
---
 t/t2200-add-update.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 2d850bb372..7cb7a70382 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -179,10 +179,8 @@ test_expect_success 'add -u resolves unmerged paths' '
 
 test_expect_success '"add -u non-existent" should fail' '
 	test_must_fail git add -u non-existent &&
-	! (
-		git ls-files >actual &&
-		grep "non-existent" actual
-	)
+	git ls-files >actual &&
+	! grep "non-existent" actual
 '
 
 test_done
-- 
gitgitgadget
