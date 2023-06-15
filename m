Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A939EB64DB
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 02:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbjFOCyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242585AbjFOCx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 22:53:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D9726A4
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f7fcdc7f7fso1997745e9.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686797636; x=1689389636;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhzNVszT+Vo/FZZYrTjw3PrSJR7DAlK0zG3KVKzKwJY=;
        b=PqkyIBeUNUDoC3G8LIo0WzsomxAVgQ3SvevXwsybqIcwxdheeBb/JJqmjrDJur9ncc
         UIEeG5aReDb9pmPAVL344FFJokbHjvrgtkwzq+EaqGq63dVxex2VzwWnAdQRsQtCM+LU
         TghzUB+YU5QrSVCLuLLH5lAAZXqZLdmuk3VFUaXRdl4Rvt2hU3CO2othyenIqRsM71rc
         zwq/WFMLejvYFsZc1up/FtOq0bwitUAwlGe2ZqlTkB4CMIw0epd9W9EGXZXA2fhHqMo3
         qXEHJAQQNTIOJ3pSa9BJoY2CAPbPT7r5LxbIZ+uJ4Flcl1Y7UjyqFn9rXbrBbfQkWiRc
         4DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797636; x=1689389636;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhzNVszT+Vo/FZZYrTjw3PrSJR7DAlK0zG3KVKzKwJY=;
        b=MiVwehxPPRwhJZ5yrxhr/L5g1nukoxf0DdJrtQNQfVuG1JRpPtWgf49ElB13fN4p/O
         IuO9I5Mp/LnK7m8aKHlvxIlsjJqSLnjKKj4X51AmtGZuGNuRPpF3/oO6df0yW5z6cM6v
         kdhQf/mx5rgOlYi1x4lu82/hCXEaPOD6tvqlyruhomx47p6e7ZZ0466v0JuwOdpXuUJp
         D1LnZkD9HSSn262LrRieC76JYebcybnzYgLH4FPcWO4spRHfNi2lesxvekWOz2ygjYyB
         NdKPIT8fBOhu1+iFGkCvNkxY23O1DsnRfC24BGzZDrs/b+5Ix/QRtmXPlq+UVyOI074P
         SEZQ==
X-Gm-Message-State: AC+VfDxk5/Ppk9dW58544aJ26RMihf0gxQGRAPerLzdeDATjiu6Dvzs0
        Ppl7xpcsQhWD0/S2RtcZZu76sLGwl/k=
X-Google-Smtp-Source: ACHHUZ6OWUaRbrDsD4RH9Y/cliJUm2W+o8VS3TcbJNiLe4lBr0SlCIH4SS7Kt+O/n4WGU1JWzcJWpg==
X-Received: by 2002:adf:ec43:0:b0:311:ab6:1a8e with SMTP id w3-20020adfec43000000b003110ab61a8emr2630079wrn.9.1686797635898;
        Wed, 14 Jun 2023 19:53:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5-20020adff345000000b0030630120e56sm19814127wrp.57.2023.06.14.19.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:53:55 -0700 (PDT)
Message-Id: <7a96d0705b991bdfc585041877e0eee3811461f2.1686797630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
References: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
        <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 02:53:47 +0000
Subject: [PATCH v4 6/9] doc: trailer: use angle brackets for <token> and
 <value>
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

We already use angle brackets elsewhere, so this makes things more
consistent.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 7516593c470..97dc1c8c95d 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -66,9 +66,9 @@ non-whitespace lines before a line that starts with '---' (followed by a
 space or the end of the line).
 
 When reading trailers, there can be no whitespace before or inside the
-token, but any number of regular space and tab characters are allowed
-between the token and the separator. There can be whitespaces before,
-inside or after the value. The value may be split over multiple lines
+<token>, but any number of regular space and tab characters are allowed
+between the <token> and the separator. There can be whitespaces before,
+inside or after the <value>. The <value> may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
 the "folding" in RFC 822.
 
@@ -241,7 +241,7 @@ trailer.<token>.command::
 	This option behaves in the same way as 'trailer.<token>.cmd', except
 	that it doesn't pass anything as argument to the specified command.
 	Instead the first occurrence of substring $ARG is replaced by the
-	value that would be passed as argument.
+	<value> that would be passed as argument.
 +
 The 'trailer.<token>.command' option has been deprecated in favor of
 'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
-- 
gitgitgadget

