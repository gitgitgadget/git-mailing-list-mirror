Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4E5C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbjEKVT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbjEKVTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:19:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CAA2D5A
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3063891d61aso8730237f8f.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683839980; x=1686431980;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRGgCTSjmtIc5QXfDmjjUCqDoAVaLT7Rl9YgVHh+y8Q=;
        b=NJ1+5Rr2rMho0b433GAyzoWPiFIXS1JMNwroxuWfKgQBiggXTHNYD8XVn8l2CLp+DV
         7Dk3uOtcqPHHYnH0OdTQ/s5vX4kJXI/h+Nvi0F7cX9ONVr3kgXbas9lJE4tqRq+0IBGI
         tJihlwL8U5BUDmzN0+tK45lj3HYwdZfFkyRu3u8r7t7iTrDEYwn4NBr3wS+Pd3fjL97Y
         lYGQmZnOfaKWfIQommbABbEqy/N6N1UEclGlhmnE3IFRnDfIc4WuEyub3+IGGcAwurGk
         nzINaOBVdmOwpQxth5Lrxok2G/PSXIcNdMGYxCJwiVlrj1uBmoH0R0tBYx2LXTeXbork
         qoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839980; x=1686431980;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRGgCTSjmtIc5QXfDmjjUCqDoAVaLT7Rl9YgVHh+y8Q=;
        b=Zqnx7XRTKxzeZ6GzjEoVHBP8qcJjjynhrWL3GmUKK4JQtvRwHq8SZ6tkFy/4i/urII
         oNxgMJAVsjAo2gSYtktSEW2WI5ELRS/Z+3UE+Ny9+8TlaKJkStHjInZMujCq/oXyhfZY
         FDxkW+QEpX5BOSs4LA6LGAvlUoOENPzmJGVWAZcCNs5mTqgXFJM75y3QZVfr63Rt9cAz
         5iUGwFh3JHXmo8hKUf+QQBbVL/XV3hO7JKu/MtbvnLvHgoLD2+icNTW6beDZf8Q3Ksiw
         yBaljfnWZXw+8nt+CqB6Xw+r1dOaGMX5eiX4+U7D+lBhMvoNss1SFiS2Mt5BczAkcYJR
         pr/g==
X-Gm-Message-State: AC+VfDwZwtw3Nnhm2ZmVE5/5DMqr5N70/6fK3xRIzFfzQl5afsjPNoqq
        UGaLuQeYWxcdV4VEc+Y1c+YmkXZ4614=
X-Google-Smtp-Source: ACHHUZ6isjIILtdqZVyw2QtBFTS4rh7fLZsbdRLPTOA7ARQVxKFjTlBjQBHimghnbDEyL5IEiy9iHg==
X-Received: by 2002:a5d:6dce:0:b0:306:db7b:bb2d with SMTP id d14-20020a5d6dce000000b00306db7bbb2dmr15198342wrz.38.1683839980645;
        Thu, 11 May 2023 14:19:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w14-20020a5d680e000000b003079693eff2sm13480771wru.41.2023.05.11.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:19:40 -0700 (PDT)
Message-Id: <96cb4ae2965772666457ea84cfc2cfc42e06bbf4.1683839975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 21:19:32 +0000
Subject: [PATCH v2 6/9] doc: trailer: use angle brackets for <token> and
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
index 495d5c9bcf1..576f5987b0d 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -65,9 +65,9 @@ non-whitespace lines before a line that starts with '---' (followed by a
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
 
@@ -240,7 +240,7 @@ trailer.<token>.command::
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

