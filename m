Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711F4C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbhLMQCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbhLMQCC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:02:02 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F070BC0617A2
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:02:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c4so27841288wrd.9
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MXMomjRC/fb24dxRgX+qEsh4KebnnV6VgDOcUfwXPBo=;
        b=J+3bdX9KRY5e0QNx8F2P37iuTQeLHetYTYGZGCaVxOCVbAkiLf80WCezHuGFLDHw8M
         0lDebyUC+xc02Fu8jAWR7TaSsmiOE3MdaIptBqmYUV3fF6gaN8YQ+H0010BfQn/Pwzsx
         Ezeukiy+/6+A3Y9Uhhm+5gSk+DCpUZnj/pVgYnhWOPlyXLfXVeNhFn9E7HYeQP92pJ3M
         5eknukJYLpAobiHYM5DQv4f+4GQe4mOYX4WsdPLpEVj0PSFpUvGDE3iwg40HXlTSOCWa
         zXFUhCCbdDWsVbyNLjgqX334EZnJT4iHfsKmzu+dbLJ0e8xK5Jhbv8042g7J6tqVLSLO
         WIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MXMomjRC/fb24dxRgX+qEsh4KebnnV6VgDOcUfwXPBo=;
        b=6UgluZg79LsXzkYjbb9In8Xltpn9guPj9anC1F4rodmlgG2O8v5YJm/zbGLiAMggy+
         gpLl7pKAhIzA/SNk3Dq8kuzfYXIVTXc29JMVNMe9EGGk79ASAt+xiD6UkppTmSc8PL9E
         zJuBuXHz2KYp7HP4Baa9zPlON8Xxd1tZl/XxVBwppwgxkXmepKgzylb98W6/aDM+34CX
         lxBDUQe6KGy86ZFkrF++Tp3gA6aVKzOjVsklx7EWIBmxm9G2/i4F0cO1WwlMavk1buP8
         qhEneRaKKTrIFrWvLy7+zwAAh3uCh38tfxkc5Cp8ne6KjwjmEZSdh0cfmT1mElLTEvsL
         M1Ew==
X-Gm-Message-State: AOAM531WFQ4IdVO9rXWWr+W8MvwO1lQW8PpqpIZ91wlckEBrJ9JdoAJ+
        zl8ScITbdvTBSJocKrJTtuz86mITY+U=
X-Google-Smtp-Source: ABdhPJzsF1pMY+Hr2jRNydnH+9BrJxLkjujx7XifANMapc2Aqmkf0sHVZXp47coAJMlmPNuGXsFdvA==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr33081533wrl.24.1639411319499;
        Mon, 13 Dec 2021 08:01:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm12157697wrd.13.2021.12.13.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:01:59 -0800 (PST)
Message-Id: <9dce18d7349fe2a27859c224068fb5a386f263f1.1639411309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:46 +0000
Subject: [PATCH v3 08/11] reftable: order unittests by complexity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is a more pratical ordering when working on refactorings of the reftable
code.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-reftable.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 26b03d7b789..f08d66df949 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -3,15 +3,16 @@
 
 int cmd__reftable(int argc, const char **argv)
 {
+	// test from simple to complex.
 	basics_test_main(argc, argv);
+	record_test_main(argc, argv);
 	block_test_main(argc, argv);
-	merged_test_main(argc, argv);
+	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
-	record_test_main(argc, argv);
-	refname_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
+	merged_test_main(argc, argv);
 	stack_test_main(argc, argv);
-	tree_test_main(argc, argv);
+	refname_test_main(argc, argv);
 	return 0;
 }
 
-- 
gitgitgadget

