Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB9C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63597206B9
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8+LTqZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgD0OWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgD0OWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 10:22:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD14DC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 07:22:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so7504182pjb.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtXBhjs4qdPp2GeR3HzOaMcDeUQRRg1PDZ3PhvkAYR8=;
        b=I8+LTqZ9r0/O42X2gPb4Dxy9jVeDnMcY8ecv3JBRPwIOZ7ZhyYgTx1SQIgcAeHDamN
         s1LWjbEl/1O0zWMKj27SNeCkQLkxGOwAjxro6dE3PPXwWdtwUm4JD73u6ulu0JkvMXdS
         2VBQ4/B3Et2TI1gVB9V5R7G+o58dj0jcQhHka77nQ+y8CwuAWXxx3W1MwLuT+xQKE9nc
         3TkqCZ1DCV59hEBjxp++Nd8PXnjK1HIYgCHBGEIIb3qRcGKVRMMK9DVkmOM27pX2BHSh
         YRKzIESQbYIp2iRZaAxgXhViDFbtiXiXWr5GVRo4aUw49Ye90vDVaD5vnf9H961kISJv
         IAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CtXBhjs4qdPp2GeR3HzOaMcDeUQRRg1PDZ3PhvkAYR8=;
        b=c9zsxZIqxeCQwqyq8cAiZlXFkTMaDOYmmAPQD4nWzK/huxHHpNNfyEO8uPnmXmwe9j
         GY1Pq+wKqslH4teWEna9mJshcNP1ODBqR+Rj5rIoFdNn6H4MrArSo24CQ8o7rWPFR/av
         +WnXgjFOkX/mgW0Bd3ReH7Vjwllvy5sSgaBeyRqVtDgGIPL9QZWMho+kRsjy95Bj9EV1
         fzc8NpA8xXVqwQeB+YvCL27r9OyiI7j7o9zhgvo/sDXskZFhUIUQ4nAYvr+tQLIL1igt
         hNF8rjeCthjAQ+oNLFA7oaI8AwcGWfCPhm3Nwy4goLJjpyVNV/vw30Bw0sg2PB8crVBk
         FxvQ==
X-Gm-Message-State: AGi0Puai+i5bU98YN+ET8qVBVv05ErYkY4vZKazZ0nS5evMX3T/V3cOj
        iFRCjZ6FrkQvZfPy2/f6SfXmPRUc
X-Google-Smtp-Source: APiQypLVm9h3gGTbwCIdrTPZi27nfTQ6vDYvo3h89tdkJkFR1hsfi//RwaFJbkvI1Di2iZO46mkYyA==
X-Received: by 2002:a17:902:6114:: with SMTP id t20mr11878806plj.324.1587997374170;
        Mon, 27 Apr 2020 07:22:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id c1sm12589602pfc.94.2020.04.27.07.22.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 07:22:53 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/4] compat/regex: move stdlib.h up in inclusion chain
Date:   Mon, 27 Apr 2020 21:22:35 +0700
Message-Id: <8d18c53bc813865a652be148afd2292d75e1b635.1587996766.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7
In-Reply-To: <cover.1587996765.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com> <cover.1587996765.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Linux with musl libc, we have this inclusion chain:

compat/regex/regex.c:69
`-> compat/regex/regex_internal.h
   `-> /usr/include/stdlib.h
      `-> /usr/include/features.h
      `-> /usr/include/alloca.h

In that inclusion chain, `<features.h>` claims it's _BSD_SOURCE
compatible when it's NOT asked to be either
{_POSIX,_GNU,_XOPEN,_BSD}_SOURCE, or __STRICT_ANSI__.
And, `<stdlib.h>` will include `<alloca.h>` to be compatible with
software written for GNU and BSD. Thus, redefine `alloca` macro,
which was defined before at compat/regex/regex.c:66.

Considering this is only compat code, we've taken from other project,
it's not our business to decide which source should we adhere to.

Include `<stdlib.h>` early to prevent the redefinition of alloca.
This also remove a potential warning about alloca not defined on:
	#undef alloca

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

Notes:
    There is another warning about un-match declaration and definition of
    re_string_context_at.
    
    It's arguably, a bug in sparse itself.
    Consider that there's a fix for it in their development version already,
    and, we expect they'll fix the zero-ing pattern in 1/? before enable it again.
    
    There're no point to change that pair of declaration/definition.

    This patch is technically Ramsay's work.
    Since <alloca.h> is likely unportable, my patch will be likely unusable.
    I took Ramsay's work and write the commit message instead.

    I would love to see Ramsay's SoB on reply to this patch.

 compat/regex/regex.c          | 1 +
 compat/regex/regex_internal.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index f3e03a9eab..e6f4a5d177 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -60,6 +60,7 @@
    #undefs RE_DUP_MAX and sets it to the right value.  */
 #include <limits.h>
 #include <stdint.h>
+#include <stdlib.h>
 
 #ifdef GAWK
 #undef alloca
diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.h
index 3ee8aae59d..0bad8b841e 100644
--- a/compat/regex/regex_internal.h
+++ b/compat/regex/regex_internal.h
@@ -23,7 +23,6 @@
 #include <assert.h>
 #include <ctype.h>
 #include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 
 #if defined HAVE_LANGINFO_H || defined HAVE_LANGINFO_CODESET || defined _LIBC
-- 
2.26.2.526.g744177e7f7

