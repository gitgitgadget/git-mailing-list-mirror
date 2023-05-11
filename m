Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39418C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbjEKVUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbjEKVTp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:19:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE002D62
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3062c1e7df8so6164808f8f.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683839981; x=1686431981;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajl3QhP6/tGo30bAxsGADp0s0Z+beaQMLvv02Yfb8Y8=;
        b=YP95+21unrDrO/MoBR7I4BVSTNM2T1eH+OkT+hQl5rmcMQgtiDPxpqwDEFXxShZON9
         W/KZXJoFzAHp3OcgiTLRMdYRvK4Qj4QR6F7iCgfUzX3CZ3VY6E73BWGiMLgyEz6E4joQ
         2wbGx4VmHBnIY/yFRTaO7ALdVs1jYk8kWfoLZOh2Ehfugn1/L7dPasAZ/c++1Tc4l0xa
         n6d/Vg/LTnbFwxTDplQRWJvsax9VHHIKd6NBxRucKZRvF0bLS/2S6ovoXUAi3y3OR2wJ
         9qYoRnRNmXmkIsv28NgCzz0cONpDBh0R2IuzolTn679qWx0Quq7NUfY29FcWoYI2ttgE
         V/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839981; x=1686431981;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajl3QhP6/tGo30bAxsGADp0s0Z+beaQMLvv02Yfb8Y8=;
        b=Qy+RVqNXQ2qMqblWmip+cIHbQMTJmkeFgWu/Lu7YAAFwlif42hRtph8CW+6XHv9ZJH
         IxO1JLnLfUO1YsQHrocmiykdB42grfDXQaAdak5faD46prwHrwn1n/9PJiyU5paMSSlb
         U/roJ1par0RR9p+sHubjKF6LxQ+gNt6gdFLi3bQlz2PvfyNb8QhIalljy5TxzznNRDLd
         bhWdIehmeulkA9xtMc4tIC7NMOy7gzgZ3U3dMcoo0jTVlMFlJC/jwRw4GpbqLRZJ4uc0
         iwzLiyAb7xOkT6phRWB9aQlHHrTiJlVmE55xKdwBt9IQN3bfwyOyVz6XlqYh9k7i00tn
         cf2A==
X-Gm-Message-State: AC+VfDydrgL0FF+qJgEHgD3VAWCIL7gkCkHkmp6GcE83w9tsteBw9+G5
        FaVmpIDtPMyed5q6z5oZXTQuwuB+FJI=
X-Google-Smtp-Source: ACHHUZ4s1SYV2jfSRMa6OUXbFaR+9uh8HFW89JSpnXHX3p8UYEY/rkfuXadlM75SWM5Q/HTRgx4iRw==
X-Received: by 2002:adf:e9cc:0:b0:306:297b:927f with SMTP id l12-20020adfe9cc000000b00306297b927fmr15028538wrn.25.1683839981374;
        Thu, 11 May 2023 14:19:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a7bc44f000000b003f4e3ed98ffsm4760158wmi.35.2023.05.11.14.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:19:40 -0700 (PDT)
Message-Id: <4e234110ffd2e6030f929b5179e62d722fcacb6d.1683839975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 21:19:33 +0000
Subject: [PATCH v2 7/9] doc: trailer.<token>.command: emphasize deprecation
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
index 576f5987b0d..32a26c59f8a 100644
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

