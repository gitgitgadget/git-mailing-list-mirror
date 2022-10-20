Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A6C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiJTS2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJTS2T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:28:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBB1F524D
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i9so450611wrv.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yg+qRN/8CZOKtoU9cC0Yaehgw+i7SS3ddOvwOaR7iUQ=;
        b=dhb1TN4ImfwH+3hJtMyOcdYf3icuakHd3Fz2aYeA2vmOywrZFlxafFSqRftG9OezSO
         eOcyeDrxG/FyjYTwxHDA/MrL6NnUh/6gy4cZs/R14uOrw4fCeciSMFdrGbejOJ4YJO85
         VGlEiF54293r17Cj4qXXG6PAx8onijnIuSz5DhKVpilXtZ14FC2QK59euJ9oDx9xaWzv
         ynzTYPIlWclqSgIDlFHU94Kmw/89kyUwDFDJshEjX1VJAEgBiyVnoNZFgXgny312rJto
         4oPF9GFA6Js02FnL4eKMq0eriLbGICEeXtcCnrUHXXbGSeJvXoIk95/HlaxWgp/u+3+L
         8yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yg+qRN/8CZOKtoU9cC0Yaehgw+i7SS3ddOvwOaR7iUQ=;
        b=NW6eLna11C+yQq3EcofEtN2YIzTLit7fyq7Ps4K40BAt1EVSl9JZC6i3b3MqVhSv5B
         dRA6MabNPrVNKH31VzKIDiBjM47aFtV6KcJiLgu0EvH/rB/rEHgUytWqZN1D3Y5RAKU2
         uXKrdkY3uO9UOLxH0cl+Omt1TlJQOUUCoR2bbiwKQ2e8PMf7LrHVBqNyXQWlekBrNaMU
         EJwDa48gk52vAwdUm6wvKjLw7bCPKnu8v9WXJA+rJIuDonN+auxPmON1F9feQhvAY761
         TNdcZ3ztXNAEAoSrNIPZpaQC0yHVbImKQzlD5N9+MVQ1rHPtAbMCZjruTEYPn0bcaR7/
         t1fQ==
X-Gm-Message-State: ACrzQf36rJmSXcN4U/17knZ9MsfnQdDwWmonccaaNTsfG5DxSabNtp3e
        dHL8k1Wo1xMzNOD+/fAe33wu7p326p8=
X-Google-Smtp-Source: AMsMyM7nh4T6Lzwx58qWcjsNSL9Q0IABTBZkfvlmhLi5Rh3TPEe04dtL7+5nF461pv7y/nId9sWr1g==
X-Received: by 2002:a5d:4b11:0:b0:22e:3af9:c754 with SMTP id v17-20020a5d4b11000000b0022e3af9c754mr9281163wrq.206.1666290495745;
        Thu, 20 Oct 2022 11:28:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b003c6bd91caa5sm353436wmb.17.2022.10.20.11.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:28:15 -0700 (PDT)
Message-Id: <8cb206b76323e14d8e07f6cfb5aa482a47eb54c5.1666290489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 18:28:06 +0000
Subject: [PATCH v3 5/8] trace2: improve thread-name documentation in the
 thread-context
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Improve the documentation of the tr2tls_thread_ctx.thread_name field
and its relation to the tr2tls_thread_ctx.thread_id field.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tls.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index d4e725f430b..7d1f03a2ea6 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -25,12 +25,15 @@ struct tr2tls_thread_ctx {
 /*
  * Create thread-local storage for the current thread.
  *
- * We assume the first thread is "main".  Other threads are given
- * non-zero thread-ids to help distinguish messages from concurrent
- * threads.
- *
- * Truncate the thread name if necessary to help with column alignment
- * in printf-style messages.
+ * The first thread in the process will have:
+ *     { .thread_id=0, .thread_name="main" }
+ * Subsequent threads are given a non-zero thread_id and a thread_name
+ * constructed from the id and a thread base name (which is usually just
+ * the name of the thread-proc function).  For example:
+ *     { .thread_id=10, .thread_name="th10fsm-listen" }
+ * This helps to identify and distinguish messages from concurrent threads.
+ * The ctx.thread_name field is truncated if necessary to help with column
+ * alignment in printf-style messages.
  *
  * In this and all following functions the term "self" refers to the
  * current thread.
-- 
gitgitgadget

