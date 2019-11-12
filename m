Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F051F1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKLXIO (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:08:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36689 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfKLXIN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:08:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so179268pfd.3
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8zpUuKjg2q0hXyZUoWPLhadbw7vSSQvxbpGhIb2/bYw=;
        b=r10GB7z5PjG64zU2wpJgeNZUtFCl64pVFNnOXu5AEiCOUAEQjnvTD8K8URpIPAoq4M
         peTiFnJ4OLkjm7WKqRy0SPIwE8QEAPQg7qkWUmOq8zkKRT0RdoanZ6NaICf6Bo5LSHBe
         FHzvRRLmG9e5fE+T9iqM0drrl0NZk4XeQAakpkK963UU9IYvpgL3lRwunUT1Bt3ho49q
         WMI6MvVTnZqopPDbtTq2u9YIrMfWb/SGmX5pE2e+meCzTCjqbnSCeGvw9maMx2etJMOf
         CmRtvcD8ouiny22+faweuAm5fGKNf/luDgW1aZuKfNJ62FfeFONUxhJL+XE9SLEYfH/E
         csdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8zpUuKjg2q0hXyZUoWPLhadbw7vSSQvxbpGhIb2/bYw=;
        b=QuBt+flmBCPrZNtZ9mhl4cBKhi6t7vmhUp7mnKbnO97aKSMFsrnsKKNjNh064Z5ekv
         QtW6v3IghG3ujHaRypbqhslPkI9Xikbkvp1pI5Vkw5a4R5oPMbg+fi3aiiCMCpo63ytc
         PuQ46PxWCU2E48okTXK6wpsDATupNgxjKQXVieIdM4kK5PlPqMWkxYPZiJlMvJtojQ5i
         KuA0zk6JziVYCgzyAkR7YRL1+2HY0IfpIPQG+ls8bvWNWFZ+MIYmQPHgiK4MFCJDzHov
         NUEQ5qVyJkYlnIDGHsgjIs+3Iuh14KTVfsrUJQKTP9lvqCo+7LimzRzrI/TXphIcN53e
         xRKg==
X-Gm-Message-State: APjAAAX0FVAe/MFwuJc4EAhRsoC7y6NCSlD7JjFm985XkQJXGENmDr33
        GQb29ghvCX2vhCCXsCudwBpcFUfW
X-Google-Smtp-Source: APXvYqygOoEz7vPu8CcP4+kqbT5ZIy2naWe8L5HBXcjghHNcIWD+8GkVUsiG2ZpXvFCJsmU/X4V7JQ==
X-Received: by 2002:a62:2fc6:: with SMTP id v189mr515880pfv.188.1573600092081;
        Tue, 12 Nov 2019 15:08:12 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id z10sm21856pfr.139.2019.11.12.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:08:11 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:08:10 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 11/14] t5520: don't put git in upstream of pipe
Message-ID: <463f5c11b9fa0527d0e7b1b38c002b91d386d003.1573595985.git.liu.denton@gmail.com>
References: <cover.1573517561.git.liu.denton@gmail.com>
 <cover.1573595985.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573595985.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, if the invocation of git failed, it would be masked by the pipe
since only the return code of the last element of a pipe is used.
Rewrite the test to put the git command on its own line so its return
code is not masked.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 8b7e7ae55d..8ddf89e550 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -668,7 +668,8 @@ test_expect_success 'pull --rebase fails on corrupt HEAD' '
 	(
 		cd corrupt &&
 		test_commit one &&
-		obj=$(git rev-parse --verify HEAD | sed "s#^..#&/#") &&
+		git rev-parse --verify HEAD >head &&
+		obj=$(sed "s#^..#&/#" head) &&
 		rm -f .git/objects/$obj &&
 		test_must_fail git pull --rebase
 	)
-- 
2.24.0.346.gee0de6d492

