Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B77C83001
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77A420775
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KemId4DW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgD0Xmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725968AbgD0Xmo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 19:42:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE19C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:42:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s62so22887002ybs.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=p8T28kGftDzJJIwNDodAsUd11p6G0Z4gitCXhEcJ17o=;
        b=KemId4DWMzsyGmqgLwl2gqRDZWqHH1LQgJx12/isOAVFZa1e02SW3XTAtvZbFxA7EF
         Vb7vzgNvFS0B4SEX6voeWeHef2FS1MpjGEcO8+wh5yLbVv9GJI2eQQ241wnuVhXUF9Lc
         fjIMWwBTzH9YHH0/QbN0CkkVYwsGcJSdEAL5sYROSTNImHmbsa+JkgUkBu1Kx2jfFVMT
         OXXMs+fDdt5T7qKM/C9YMmt7j7bRq8MMfDFUnPPFl75g/QHLvgxSTZIrl5O1AoouSx7G
         Is44luRKn7BzfYkCak5uzYORyv5VUyA4Qk5TNFXaFBSym1t63Ye451hhpMANZTpIRnPi
         BmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=p8T28kGftDzJJIwNDodAsUd11p6G0Z4gitCXhEcJ17o=;
        b=l2tFPXcox098MwTFQzjQ0BXsKLbx3kUb7emcIJXWvRJ1gVsOlmo5l0Wa8goaECrQ2L
         EEuo0olwxqmDL5AR1FkvJrhzTDOb63P48Vwq0EfLLV149sI/x527FcUDYGdo4yuFBlAk
         RtzoOsdYWl01ZVyLJHtW1JIIVJJhmIRFyErBpv2PTc88MorasoG5cj7MwbGp/zCO3e6V
         spuVhn3MigSecjO/bAuzvMBlJF6pvGToPTMSckPneBR6F4m7K59Cq3oRkprtHj1Lzgwl
         5nIq0fggUUDXonsnH3fUBeOmvopDCkf5D0t310HlK8PSCAPzUXCoCb330m4SspD57mmR
         hNzw==
X-Gm-Message-State: AGi0PuYF5AHP+ZxstvalrL3P+2g8welBz4ZXWryzNInjM8/T8iP27EW4
        HnB8L+1xnuSF0clqZbEFO6H4JvZ7AufkuYskm97ZGYVhtzzc+faZKIpTsdsUmpgb9UeFAlhmCv9
        Ho3Ka1LkEt7TCzHMBha8hsGgKJh8CTRSgHSOIDoT4BSbgBmJThy+VQDKKIJjiL3ElulKoQsChrA
        ==
X-Google-Smtp-Source: APiQypJps7kfqaD9POwW5G8mLlPnGS2UN9eqgy0fk+pvo5KxTLXuDal8iGnGHj14i6s+DiuzQEYGu5dgxvX2rxNLvFA=
X-Received: by 2002:a25:bd87:: with SMTP id f7mr31405730ybh.390.1588030963770;
 Mon, 27 Apr 2020 16:42:43 -0700 (PDT)
Date:   Mon, 27 Apr 2020 16:42:31 -0700
In-Reply-To: <20200427204859.171084-1-emilyshaffer@google.com>
Message-Id: <20200427234231.194456-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2] bugreport: drop extraneous includes
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the generic parts of the source files, system headers like <time.h>
and <stdio.h> are supposed to be included indirectly bt including
"git-compat-util.h", which manages portability issues.

Drop our explicit inclusions and rely on "cache.h", which includes
"git-compat-util.h".

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bugreport.c b/bugreport.c
index 089b939a87..acacca8fef 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -1,8 +1,6 @@
 #include "cache.h"
 #include "parse-options.h"
-#include "stdio.h"
 #include "strbuf.h"
-#include "time.h"
 #include "help.h"
 #include "compat/compiler.h"
 
-- 
2.26.2.303.gf8c07b1a785-goog

