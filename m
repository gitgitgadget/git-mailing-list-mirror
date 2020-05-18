Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9874C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95A820825
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="sb7tkmJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgERKEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgERKEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 06:04:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3357EC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so2333591pgm.0
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CqXlW24KF6Ee6VfFgvPfj3klUr+M3G+4kLiV4Rm+vGM=;
        b=sb7tkmJTRlBCFzPyT/lEoVKjY0fKfD9zq/LnbPzmELP69KjlI1oiMxOwcueZH+xorT
         3WS156AxdUcgfunA1+oHmKxetlhg85BPJFr4AjHjfMCWIx3CUIe2/12Fb8wEKpckJUn2
         DPzHyZotDdqwHreRL3CwQzlPjgCGd/SjXNbYxnMz6KMUuEappRHXfoZBCzUV/hswjws0
         /ICHClGO2lJqsZVJTrqxINWtWLVMujKPOWLiATXXPBQnqtpr0JLwcGPJB6/OPTUXBLK/
         jH2jJfc1mtA+qRY8Xul255eUh7x473zjnNtnVv6bVwmsJ8sn6j8kkxgVEaMJUSo8Xgw1
         /YCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqXlW24KF6Ee6VfFgvPfj3klUr+M3G+4kLiV4Rm+vGM=;
        b=XThbfa8rEpYLX2HmbH2e08qQXy6BaQ+9Rt6ZTaaZAA+OMgHcP3wJHdcW1RW8EU+pFr
         aUzSIckKeuxMFBEBfvpYIlK7P/r0WRg223AK7GUg+Dfn4/hI9gqBzeOr4iKkEVaIGQqp
         HGSQo8xRqhA82dh0SeL0ixBPtn2rj6Ll5puMR/XBPzOdA+78jxFkUynfPs26jKNZW2LY
         YvzDsE/DemvY+agNBcqo29l5ye/fiOafm2ciUpPH7NKkbqOo17aNXKBOE85G6dAyje1+
         JI4Y3yrmW0EPFhGULBCyaOPY46VFqu601vVWUJazaSr0nWPh8ekvxmuIOQJq7tDrsrQJ
         KYlA==
X-Gm-Message-State: AOAM531iwsYCv9vww3zjxCXxJNOrHKZ11oOR6GNVeU7I04mfUvyv+AI6
        /fx7i60fnpMDS8egAg5YsIb4RR57udxXRL8kDb2v7Xpb3LRVYNHudhySyStwueBT+yESJoWaAgM
        zkeW9EOFi5evBnjHStq9IvzAnTYQU91vFzac2eylHU+9ZjR8CPJimb4BJJFqPJrY=
X-Google-Smtp-Source: ABdhPJy3r7j1RYJyGVQch2R43oTXMn5TiBXivZjUzjuGRngKd8ob8sve+oH5X+8ncnFNcoDzjzmCng==
X-Received: by 2002:a05:6a00:1490:: with SMTP id v16mr9268493pfu.173.1589796249336;
        Mon, 18 May 2020 03:04:09 -0700 (PDT)
Received: from fw.dtucker.net (ppp59-167-129-32.static.internode.on.net. [59.167.129.32])
        by smtp.gmail.com with ESMTPSA id cc8sm8094167pjb.11.2020.05.18.03.04.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 03:04:08 -0700 (PDT)
Received: from gate.dtucker.net (2001-44b8-3110-fb01-0000-0000-0000-0001.static.ipv6.internode.on.net [2001:44b8:3110:fb01::1])
        by fw.dtucker.net (OpenSMTPD) with ESMTP id ed0ce908
        for <git@vger.kernel.org>;
        Mon, 18 May 2020 20:04:02 +1000 (AEST)
Received: from gate.dtucker.net (localhost.localdomain [127.0.0.1])
        by gate.dtucker.net (8.15.2/8.15.2) with ESMTP id 04IA41Zb029480;
        Mon, 18 May 2020 20:04:01 +1000
Received: (from dtucker@localhost)
        by gate.dtucker.net (8.15.2/8.15.2/Submit) id 04IA41lE029476;
        Mon, 18 May 2020 20:04:01 +1000
From:   Darren Tucker <dtucker@dtucker.net>
To:     git@vger.kernel.org
Cc:     Darren Tucker <dtucker@dtucker.net>
Subject: [PATCH 5/7] Define LLONG_MAX/MIN etc if not already defined.
Date:   Mon, 18 May 2020 20:03:54 +1000
Message-Id: <20200518100356.29292-5-dtucker@dtucker.net>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518100356.29292-1-dtucker@dtucker.net>
References: <20200518100356.29292-1-dtucker@dtucker.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Darren Tucker <dtucker@dtucker.net>
---
 git-compat-util.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8ba576e81e..aa221eba1b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -127,6 +127,22 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
+#ifndef SIZE_MAX
+#define SIZE_MAX ((size_t)maximum_signed_value_of_type(size_t))
+#endif
+
+#ifndef LLONG_MIN
+#define LLONG_MIN ((long long)minimum_signed_value_of_type(long long))
+#endif
+
+#ifndef LLONG_MAX
+#define LLONG_MAX ((long long)maximum_signed_value_of_type(long long))
+#endif
+
+#ifndef ULLONG_MAX
+#define ULLONG_MAX ((unsigned long long)maximum_unsigned_value_of_type(unsigned long long))
+#endif
+
 #if defined(__sun__)
  /*
   * On Solaris, when _XOPEN_EXTENDED is set, its header file
-- 
2.21.3

