Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355FAC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B9322275
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrMh7dUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgKBWbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgKBWbS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C52AC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o135so15681807ybc.16
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=mfxLg1Ne6Nr4HKL7QQys/sRXNZE+vPOcA/vW7FG1dLA=;
        b=XrMh7dUYqr+N2kUqRQBUgXIDMYZRm50IeYx20h2lLVOwTkIYf66qVJkRCrDVlkGIF1
         J3C1GiOcHr8Tk4gPxZgpmHD+mDNMZGtkHkFXT2p1OeKfVWqgwVkBxuwBq+xpjb0O0cJ4
         4bmed/KEcpcYb1esyGO4oneTbfTvyfhMseoqDEB3H7vcCGCNvQxQ33CneCAeMLFLpSK0
         D0ITsuIz/ZiD1pEZospNtlMQoYplc25sr4CZz6Eo4cNVfwwuCX2UzW6qfzTsMst6ivuL
         wsDJPiNQT4iB+My4GYLCGP2Ps7WqIBpfD9YJAwTjlk25NM8tBXt9uHT3vL2BhpWLgUVG
         VsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=mfxLg1Ne6Nr4HKL7QQys/sRXNZE+vPOcA/vW7FG1dLA=;
        b=jj6jMtVU0aJAfAx0u++LQXDN2+BxPIYK5js32rjxJlV4O07ObBhFgJzfsT6oxYj0us
         Wb2wYwIRMVWcc2YGDA9B+GJunpwwy0k11wTS0TEoZ2mJPPwfAYvYQXCWbB3oCxl/j/oI
         xJEVkeWj94rBp5dY8S31ICyaP+FwKf5nYpVYVDHIf42FMGjpKmgwBFqaqDrWIga08xSA
         Con7/NXdszMU8cjtp9dFNnySr+a3j5Io9fe1VVevkXYhogjaeZaMxuiPCyYUN/Dvpoqo
         OIFLLyg2CSxy16omSEWPIwq1OO2eFeZad/DchhkD8BesQElifeMx9VIoQXkOc95ylqhG
         8reA==
X-Gm-Message-State: AOAM530zeY9z/PL7GUZ32uuUIDLdGTnKFU2iJFflsfe7fZLmJOeie6MR
        FXamqnMQ7TXt8WMNncxiqu5z+ClATt5BXyIIv93H5IErSFcykArsMY6rjbFCh9q6pzq/5+rBXY3
        tGskpwrw8hWwuTC370vukVOS5o4NOtKdDmG5Vi2BF+CcYa5U+W+2gllU6tZJk0Dw=
X-Google-Smtp-Source: ABdhPJzdPQcDzmchyH4osi7nt/hRf4JzjWcAj0nvAEkVtUpBaFD51VbEsqgiRuWUM8TLhTTTRJtGS1L6iWC30A==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a5b:888:: with SMTP id
 e8mr23544998ybq.436.1604356277794; Mon, 02 Nov 2020 14:31:17 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:31:01 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com>
Message-Id: <7f42aacd2bbfdfe40b46bb024ec2eed2e61d027a.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 03/11] trace2: add a public function for getting the SID
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a public wrapper, trace2_session_id(), around tr2_sid_get(), which
is intended to be private trace2 implementation.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 trace2.c | 5 +++++
 trace2.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/trace2.c b/trace2.c
index 2c6b570077..256120c7fd 100644
--- a/trace2.c
+++ b/trace2.c
@@ -792,3 +792,8 @@ void trace2_printf(const char *fmt, ...)
 	va_end(ap);
 }
 #endif
+
+const char *trace2_session_id(void)
+{
+	return tr2_sid_get();
+}
diff --git a/trace2.h b/trace2.h
index b18bc5529c..ede18c2e06 100644
--- a/trace2.h
+++ b/trace2.h
@@ -500,4 +500,6 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason);
 	} while (0)
 #endif
 
+const char *trace2_session_id(void);
+
 #endif /* TRACE2_H */
-- 
2.29.1.341.ge80a0c044ae-goog

