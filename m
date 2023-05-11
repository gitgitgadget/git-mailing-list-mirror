Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C1FC7EE25
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbjEKVTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjEKVTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:19:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26822D74
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f42c865535so36631225e9.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683839978; x=1686431978;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1HMil0jI6NcfQkK4FL1cabxBHvFRvgMOG9McKUDqLA=;
        b=JKiTL9Wpoor74KTy48fDpXeDaQaMs5S0bGA+QLnaIcShC13pgiFBtka2XXyB92RH9S
         0+wVe/vt56BRf8GYg8N7gu16yQW1Rjif99pfbX6n5VOk+DsEC6bRVQXDBbe3TwJg7QXm
         0r1OZnyVib3ojDG0D8esEaMIIc6BTV6na93gYvCClTkvnAuZG0uZWTkQeqQQE4QMLgLn
         LS2Kr8WfLyM/PQFcPnoHfU7S3q8hELseHvVsblDdfjoyfxjkGLk6JL7kFBJ7tkQmzY79
         ocIkn+NMnBiu1sfDGhhHpTIhG9AvwA5J/7uxtTgn4SlD4FojEmRlcPgJfbG9rJLvahmb
         y+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839978; x=1686431978;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1HMil0jI6NcfQkK4FL1cabxBHvFRvgMOG9McKUDqLA=;
        b=hQTghWd/4uu1501QCTtSjo0PfySssk0AtLWAY0dvhf4Ua6aUG3hkOvO6c3OKc5VUO9
         BUgrZHqMVGF5i95qEAXcY1ikEIXX4aZC57SckqaTxH3QJWaSmFfJoR/YMG/jfjToRkT4
         FF5tgabq57klaK1o2auHoeIGyFfDMIt83FZzbedi5D8d9jKpev3tFWQI+ab8YI68xcsO
         d0I0AoLPNacJ0S5oubxLWdTtqxNvbhLjSf/huQZ1vJwjjJ9HUBnb9guaTtdgYsQ33V4A
         +L/MJ3VJdockRxP7RhPOaeVqwo/OyS6o+m8mW+b2WwgS/AbwVS4c+S8soiYXzhqvAyCr
         4UQQ==
X-Gm-Message-State: AC+VfDza7spfosOaaHaY6acCfXZpyTC8UYuKypKnnm8VPkFZ27yloxO3
        l3CVYay2+NH8xS0yu7G6q8RAftYCzoA=
X-Google-Smtp-Source: ACHHUZ7mNLaIsohl4UnxyNIyv3ljxOyBE8dCNTpxoOPhVSO0LKrMNjQPtNzjl53Y+378ydivtpDYrQ==
X-Received: by 2002:a7b:cb58:0:b0:3f0:41b3:9256 with SMTP id v24-20020a7bcb58000000b003f041b39256mr14419149wmj.10.1683839977908;
        Thu, 11 May 2023 14:19:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b003f429d59e37sm9572722wma.34.2023.05.11.14.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:19:37 -0700 (PDT)
Message-Id: <823534718313979920088729bb04b5d2433fa5c6.1683839975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 21:19:28 +0000
Subject: [PATCH v2 2/9] doc: trailer: swap verb order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

This matches the order already used in the NAME section.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 1a1d6288b17..cd4d724a0b7 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Parse or add 'trailer' lines that look similar to RFC 822 e-mail
+Add or parse 'trailer' lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message.
 
-- 
gitgitgadget

