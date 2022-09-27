Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B05C6FA83
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 13:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiI0N51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiI0N5J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 09:57:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5776142E11
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:57:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z6so15174551wrq.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=WlC4mH82+qETJwt7cFxNUGNvLYc7p3t8aRFyeWV8RWg=;
        b=SZMSxPHvYqMIzEf8s+Jd+04QJ9uT/jFYiwAILAwQ0w6N7L1KE+6JLMTXHJAcqMaqq8
         KavbBa2f4BN/MHAm7JPKGUrhcaU7ji05puCijhXuD2MSseAYckOUbOWo19OrkCEBEqpk
         PROg0bfEdkNz5iMf3vtVQ3c4Ue0bOTrtgkvV/t8x3JUVmEYYZ/aXHr3uNPe+353GA2VS
         S3rXmBzDFDjtnGKXsuXPlvyPeApBKnR3elBvrWwLBd2PToo48y3Q3Hia244lIJF29c1K
         m7fLDH0GN88OB+wyiQuYvc9CpWDm0fzoyN+wOcHBsJ0z2WXFNfckCTfTF1pcGpXzTcC0
         ZuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WlC4mH82+qETJwt7cFxNUGNvLYc7p3t8aRFyeWV8RWg=;
        b=x6VS+OJMZ3AIIfSv4SHvOuEI1MKS+ymuJfCiHjKu4fifjJfQ3+DLdx5TkSw+fG1qQN
         Mqy8R235cPn7qxNUw18Dz2o8grzBS2h4tO0JXDNzd56YsgkUWEj2/7f87v2orn8SYMHh
         ong0Hi0HH9CPU1l/2RdFLa+Ip5W8FO729wgB7XDe+FpT21bhEH9URUwyM2POaG/Bd7HR
         mLkgqjdFofEsVRN7HYOb1uhC5Dv8dTu1+QBCNjDP8SoFbhH2l28LWscxqW9jPP4Uh+0s
         0cKv6NqCMhpXvvGymHqqTk0Olc31KV3QXB7ScuRgDLcsfxYX7oG3DR0djHkZe7c2mQcg
         zhbQ==
X-Gm-Message-State: ACrzQf1AC0A0oRIiF2zZ6QW0vEIjnhSpQ4ZjsUHbYJDQrMK1fkeoZ9RI
        8WtSqfwch/n0S0jopQlc3wCinRnOmm4=
X-Google-Smtp-Source: AMsMyM5FVBqznYsl/ZOIfaSHRMybDCQwDhNZqeOS7PluMIQIQ+JyT31bKy7O6FmVWRYInc7NqOkLGQ==
X-Received: by 2002:a5d:4fc7:0:b0:22a:dce9:5f0f with SMTP id h7-20020a5d4fc7000000b0022adce95f0fmr17083800wrw.451.1664287026128;
        Tue, 27 Sep 2022 06:57:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003a845621c5bsm1765899wml.34.2022.09.27.06.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:57:05 -0700 (PDT)
Message-Id: <73a262cdca46a45aeeda6f47ea3357aaeb937e7b.1664287021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
References: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
        <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 13:57:01 +0000
Subject: [PATCH v4 4/4] string-list: document iterator behavior on NULL input
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The for_each_string_list_item() macro takes a string_list and
automatically constructs a for loop to iterate over its contents. This
macro will segfault if the list is non-NULL.

We cannot change the macro to be careful around NULL values because
there are many callers that use the address of a local variable, which
will never be NULL and will cause compile errors with -Werror=address.

For now, leave a documentation comment to try to avoid mistakes in the
future where a caller does not check for a NULL list.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 string-list.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/string-list.h b/string-list.h
index d5a744e1438..c7b0d5d0008 100644
--- a/string-list.h
+++ b/string-list.h
@@ -141,7 +141,12 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t func, void *cb_data);
 
-/** Iterate over each item, as a macro. */
+/**
+ * Iterate over each item, as a macro.
+ *
+ * Be sure that 'list' is non-NULL. The macro cannot perform NULL
+ * checks due to -Werror=address errors.
+ */
 #define for_each_string_list_item(item,list)            \
 	for (item = (list)->items;                      \
 	     item && item < (list)->items + (list)->nr; \
-- 
gitgitgadget
