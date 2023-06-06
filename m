Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FB2C7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 02:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjFFCIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 22:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjFFCIc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 22:08:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C311D
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 19:08:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6094cb2d2so56718915e9.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 19:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686017309; x=1688609309;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjggJblZVc+bqsLtSGFEd1RSSRopMikR44cTGZbcbgc=;
        b=c10bqXFfj/zVshsmoymnCjawA7ovABl5Mjo3vyknuw9U/kKlJTrXGo7P+V7blx/2Bl
         zUTwINONi30gtjs6sdbe1Wc9tWze7CbRKn0alAROIwsYiNhWeKjc7qRSu/+prboolB6H
         WlFqxQ2WNw5Z3MYZiWv2Ffz+YGLRmcpUDxQVVB+rDdWxfwQgMTcRKQ1la1x5SH0WrrjA
         mxM6wz2BAQ1BFbDjttvjkOURPSxNxtlEjdVDq3MEs+0h0+wIY8cg3ltMcFXyZtRz9Jsf
         Ksuoq5Ea+qWMlML8XI/TNKWBi95jJec7yUkiBGOHbwNPD5hneEB06cgxdg+amcq9rC+6
         F2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017309; x=1688609309;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjggJblZVc+bqsLtSGFEd1RSSRopMikR44cTGZbcbgc=;
        b=FV3sRUn2OgEKiCjrY944HdyTM4JRLfUzldv2bW4u2E9oZ+iywBM5dpxriSGho4A0Qs
         7oCAZOZt7VJccdPE6idhp94xLfQJEm8fMaw17MMeJjdjAuhm1OhJ3nOwUbsTYzCxZb8W
         zI3fr05yZJxZxYIcy5qZftMJsQhWWpeTt0sxCRhS25FH8cHXlCTOaB6b1Z6x1gFkNbjU
         CtCjbrHRevV3cyg1oXriFIp/n45nvdGaE7gJuORBd5zid8qov0ID/eBxif3hMZCJa5HA
         o0SKZtxQSDWHZW3qH0korjoSrVI9BPdW1zfodonuYXSwj4mcaSmk1wQRasJL0Jg3DsXv
         Q4KA==
X-Gm-Message-State: AC+VfDwmebPHbOZuFUMvrBlVXoRxNKQHSP36CFfnfgu72JSssCKPzcDx
        4BMHKVhP2ZQK1sqNWHqQywS1L5zzScA=
X-Google-Smtp-Source: ACHHUZ4VYSuNt6q/ZRnFjbfL3cvEyIdSd7/TqNBgK8JLY9BhWrLSKW4FazgD1SzkkQGMSIaber+6SA==
X-Received: by 2002:a05:600c:3783:b0:3f5:fb98:729e with SMTP id o3-20020a05600c378300b003f5fb98729emr721367wmr.22.1686017309726;
        Mon, 05 Jun 2023 19:08:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bc5d8000000b003f17848673fsm12418202wmk.27.2023.06.05.19.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:08:29 -0700 (PDT)
Message-Id: <6aba774489a2a0f4f7a2c52a71cbe1f8d2b6a686.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
        <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 02:08:22 +0000
Subject: [PATCH v3 7/9] doc: trailer.<token>.command: emphasize deprecation
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

This puts the deprecation notice up front, instead of leaving it to the
next paragraph.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index d69851dd367..b034784e1d8 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -237,13 +237,13 @@ trailer.<token>.ifmissing::
 	that option for trailers with the specified <token>.
 
 trailer.<token>.command::
+	Deprecated in favor of 'trailer.<token>.cmd'.
 	This option behaves in the same way as 'trailer.<token>.cmd', except
 	that it doesn't pass anything as argument to the specified command.
 	Instead the first occurrence of substring $ARG is replaced by the
 	<value> that would be passed as argument.
 +
-The 'trailer.<token>.command' option has been deprecated in favor of
-'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
+Note that $ARG in the user's command is
 only replaced once and that the original way of replacing $ARG is not safe.
 +
 When both 'trailer.<token>.cmd' and 'trailer.<token>.command' are given
-- 
gitgitgadget

