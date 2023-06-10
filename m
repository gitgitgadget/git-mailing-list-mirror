Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02048C7EE2E
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjFJUWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjFJUVl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:41 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E349B3A84
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f78a32266bso29570275e9.3
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428493; x=1689020493;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RknSMSJ6jkl1S2ky9jZa5xqSyZHqjLkO+0dQYVSmL5w=;
        b=Nj70qjYMryEDDfNnkxk0Ta3zTn9b1ebuqM55KHtclRvm6C9AHoaxPoYX61nMA5KHbg
         MyHV9JtFDJLfkp/K8Q+5acLR3J44yVi9h1heHStitqIuTq5yoQGjmHndhsEWIorPFgiD
         kI2YVA5prPaYit7JSzbXS0CbwTkSmkzclrUPdTkGiMYI0TYWLXz9Gf1RcFmziEUIpy8D
         h6IoDbKJHrp8xyZ3WUoZ6fiJAHG/O+QBlyILIj7aujYFO6Kmur5Gfl2MysCMXddh7aXQ
         dyt22N4se4hLq+e6+9WewPjLFtKe1DPuaPZc5kX16YG/CWGp10F+YOelUSgjV12w8nhi
         bIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428493; x=1689020493;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RknSMSJ6jkl1S2ky9jZa5xqSyZHqjLkO+0dQYVSmL5w=;
        b=Kk6K3lcKmu0a09vxkz8Zjdy+FNZXXyo4J61acJS3bYqwO2tkIfiQb7Ccz4Xq6kNUSW
         8xnxuXIiKkP4njkKlo7+B7RGiKCNKRcI87u4MKsIVFHWJ6FyqgkesA5ax0O8vOnAAI+R
         Kd7CPEGI4lEbq4CRtVl6+0PcohTIaOUGp/L8dFMJ2TL4ePJPsJOP4wYskQyzuyk5GHDy
         IHRHmlNIID+Stqyq4svuB2PNd+JuL40+AllalyhAZ7tWKK/gno1S+kYzdkbQoyAQD02o
         as/a3q3ZWLjI+zjwIGhyMzmZ1R+sflStSZUWp4C2xP0vFAd4Ei+ZI8XmDx8hi0PRtyCl
         aMng==
X-Gm-Message-State: AC+VfDzP/98S7eFpGwnJ4FN2UliUYhm5FEFrgomNc9HGttNLqJKfvPZ8
        mSSc//OZJOLHj8/xyptryKMZUjbwBO4=
X-Google-Smtp-Source: ACHHUZ6KB9BAAw/Z21in+ERE4X8XCXq0JFho58IIIRVU4KwjygVDvt/eW8tgCDLdtmuXjA1NQ4+uLQ==
X-Received: by 2002:a05:600c:2310:b0:3f7:4961:52aa with SMTP id 16-20020a05600c231000b003f7496152aamr4121883wmo.15.1686428493130;
        Sat, 10 Jun 2023 13:21:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c021000b003f7f6827ab9sm6541490wmi.31.2023.06.10.13.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:32 -0700 (PDT)
Message-Id: <2503d990e5c7d1fb5bbf06493951204e7c00ea09.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:09 +0000
Subject: [PATCH 10/25] completion: complete --function-context
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0fa86dcde6f..2610a55487b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1746,7 +1746,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--ignore-all-space --ignore-blank-lines --exit-code
 			--quiet --ext-diff --no-ext-diff
 			--no-prefix --src-prefix= --dst-prefix=
-			--inter-hunk-context=
+			--inter-hunk-context= --function-context
 			--patience --histogram --minimal
 			--raw --word-diff --word-diff-regex=
 			--dirstat --dirstat= --dirstat-by-file
-- 
gitgitgadget

