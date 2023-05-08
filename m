Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D0AC7EE24
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjEHR2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjEHR2B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:28:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D9C6EA6
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:27:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so15286465e9.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566877; x=1686158877;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3+j9QgxL4P8mKcAXH6CqgBFH+lXHZmyTSbGBSRYlFQ=;
        b=dY42/IlRlZZNyZUAV0QBtH17np6teT3YogABsIAv+lJxdvvIm1UfrvKkFFrj5DsXsV
         6ziJBN0JWS5ggaFH8C8Q03uJnH5SmYl4ubkLrRZHBvI+vUfWTr9ozs/S2rWvbsMgzFi4
         bbY1zVMp4ZtkdcJhNv78lg3UF/qqeG2v7PgohsoR+FDYlUxlOTRV/GeAvZDiiN08Rf/P
         9C5Mw41ANGIMurOoII9d15keWQfv7/4IF1/+ijRm4/wj6MasWdFBikMzdr+xpLi7C8YD
         m3l8uu11TQOwd3G9Ujzo4VWfpk5wbzmoYBbJs6Hv0d66z3aSKSz7DkBWOlvHVJaYNXPN
         miaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566877; x=1686158877;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3+j9QgxL4P8mKcAXH6CqgBFH+lXHZmyTSbGBSRYlFQ=;
        b=Bz8728UM+SIoDOa6Tjxur5aNZMPbMMENXiIRgrGv95J0ZbE2K5l1C7T8gXi/Ljn7To
         JNXYAGbOKBg6Z2AUji0vRCOz1baGsZJZmqhBw9hHamFRUkvPP5OMvAKC8wtpV3x8PePM
         U6vaR+zqRojz8g3YnrbzZyz7xgUE69r1OKjbrcF3O2lCrxRyH4IkVh/2EfApv/SBDTZb
         UETV5970AHjhVoCWPYpo/UnKVZjZKFD7HOBqebn9oeOgwRRW36x/PdNQK3o87w9vWNA1
         t5GTaMSOdc6tn7SGug4+TRYnjrgRM9mhmhpznFordkvK4hGksXv1OQe+rNpw8MK8hfvP
         SG+Q==
X-Gm-Message-State: AC+VfDy+wBSjETazedT/YZguQj83Yyx7kDHz9QOyHUjBHi93Zn9PLwXf
        6pEL/vSeNZmPWZQ5mzrFLT4dIYW5awE=
X-Google-Smtp-Source: ACHHUZ7HcUlqIBKdRBqC9DccwFBRvr0BNi8K+lhuK3abLgEmPDTnF2dAnyZIF1YZZyugyBEPHdqn1Q==
X-Received: by 2002:a1c:f408:0:b0:3f1:7372:f98f with SMTP id z8-20020a1cf408000000b003f17372f98fmr6727254wma.41.1683566877388;
        Mon, 08 May 2023 10:27:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b003f429d59e37sm304184wma.34.2023.05.08.10.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:57 -0700 (PDT)
Message-Id: <5980432179352054955e602cf97b57e97694a28c.1683566870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:47 +0000
Subject: [PATCH 08/11] doc: trailer.<token>.command: refer to existing example
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index ac448fd732e..5ca758e363f 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -234,10 +234,11 @@ trailer.<token>.ifmissing::
 	that option for trailers with the specified <token>.
 
 trailer.<token>.command::
-	This option behaves in the same way as 'trailer.<token>.cmd', except
-	that it doesn't pass anything as argument to the specified command.
-	Instead the first occurrence of substring $ARG is replaced by the
-	value that would be passed as argument.
+	This option behaves in the
+	same way as 'trailer.<token>.cmd', except that it doesn't pass anything as
+	argument to the specified command. Instead the first occurrence of substring
+	$ARG is replaced by the <value> from the trailer. See the
+	'trailer.see.command' trailer example in the "EXAMPLES" section below.
 +
 The 'trailer.<token>.command' option has been deprecated in favor of
 'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
-- 
gitgitgadget

