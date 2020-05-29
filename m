Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E89C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04CD207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ke3w4043"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgE2Wai (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 18:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgE2Wah (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 18:30:37 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21114C08C5C9
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:37 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id x6so4251539qts.3
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g+q9b2cPs+1BdeT4vO5zikuuaRjd4B1f9EEvKXkyJAI=;
        b=Ke3w4043q2Qwh9bBPf/xNyycJGXZFkZ5d1Fe9zFqOWdPJOFft9SlfRds9htCLdjzzy
         fWDt+srXZEoY7999OoOT84mHFnYiy4PPjfcpIEFS4+SFiRJkCif87qns139r/FdByad3
         6lqKtlUWtS7BYyWLfxK9Ym92TAkU+c0GnuNnrwsRRC4GWyD8mSRVzTKnwtUkfGaEMQDN
         8fUoBYPx8e4l3Mb8qvxdnsQh+r8QMwhLBPpsrjeqJSobWDaGqqesX/xRcO26ym3Mhui7
         IyYAezLb82HAhn+sjaHkkIPYnSyfUZVqxiEIuivJRghook48H8db7gr14J9gHb9DlaeB
         iJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g+q9b2cPs+1BdeT4vO5zikuuaRjd4B1f9EEvKXkyJAI=;
        b=GOxc0AsliIpY5uGfd0MTTmdLPkgIbAlkQYQuA3nHb1YSZRb1kprHkJB9w1ElKcj0OZ
         vMM08DT+MQMRtGn9QlSYPHOrSih0OHQBRTnNFLXTCO6O81t+dD9IDOiJ2VP0MUWOoaxb
         0DB5PRn/WXbe5q+oizS+pqyT7146+CCHXNvN1P0cCpFwsyGBLEeRvhml+WSaiZCtIi+w
         Wgx6jv6sY80XPUl2rYn/9BrjqkHdVpUOoGkWSop7YeSkwD7R/L2eIPFO1B2Mqj1Q6FUt
         EbESl6WiCLmAhmokChHmH8hJbl8dhibVnF2ZgMGdmUj7QrKWv7DkGNr8+dT7MNLtKPlY
         qE4A==
X-Gm-Message-State: AOAM533Oju5a2edKCqPViIn4D4yu6EfYny7PxURnS7Pf17jxa47P7jp2
        SsmpPm8b9mOlTN3xGlelZ6VDLt1epJY6KHSTEzuhmo9xHtJWOHgbZiF+0n2cthE3UejdMOGwcD1
        7UqDydUSRW5lhvNvYUNoLTYsXKfmPY8/LaMiaycrWxwV8Rf4vIKf9523duJV585tRyJZwp5CQMC
        k/
X-Google-Smtp-Source: ABdhPJy2UhjLj/RpdkaLNl57HYGLZLtnh5WVC/fXCA3Ih/Vz+B21Q50dRfL17v3JBUc94xh+rbLVw83iOLD1MQlK/rGw
X-Received: by 2002:a0c:fb0e:: with SMTP id c14mr10819819qvp.63.1590791436280;
 Fri, 29 May 2020 15:30:36 -0700 (PDT)
Date:   Fri, 29 May 2020 15:30:16 -0700
In-Reply-To: <cover.1590789428.git.jonathantanmy@google.com>
Message-Id: <7a2e9c3c5994fc155eb6a40f039cf2298957fa6c.1590789428.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 4/8] Documentation: order protocol v2 sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current C Git implementation expects Git servers to follow a
specific order of sections when transmitting protocol v2 responses, but
this is not explicit in the documentation. Make the order explicit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/protocol-v2.txt | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 3996d70891..ef7514a3ee 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -327,11 +327,11 @@ included in the client's request:
 
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
-header.
+header. Most sections are sent only when the packfile is sent.
 
-    output = *section
-    section = (acknowledgments | shallow-info | wanted-refs | packfile)
-	      (flush-pkt | delim-pkt)
+    output = acknowledgements flush-pkt |
+	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
+	     [wanted-refs delim-pkt] packfile flush-pkt
 
     acknowledgments = PKT-LINE("acknowledgments" LF)
 		      (nak | *ack)
@@ -353,9 +353,10 @@ header.
 	       *PKT-LINE(%x01-03 *%x00-ff)
 
     acknowledgments section
-	* If the client determines that it is finished with negotiations
-	  by sending a "done" line, the acknowledgments sections MUST be
-	  omitted from the server's response.
+	* If the client determines that it is finished with negotiations by
+	  sending a "done" line (thus requiring the server to send a packfile),
+	  the acknowledgments sections MUST be omitted from the server's
+	  response.
 
 	* Always begins with the section header "acknowledgments"
 
@@ -406,9 +407,6 @@ header.
 	  which the client has not indicated was shallow as a part of
 	  its request.
 
-	* This section is only included if a packfile section is also
-	  included in the response.
-
     wanted-refs section
 	* This section is only included if the client has requested a
 	  ref using a 'want-ref' line and if a packfile section is also
-- 
2.27.0.rc0.183.gde8f92d652-goog

