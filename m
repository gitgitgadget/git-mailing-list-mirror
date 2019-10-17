Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8908A1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441768AbfJQXRN (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:17:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40369 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441759AbfJQXRM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:17:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so1876501pll.7
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=78tdwGBH29xMqPEh9T+22n06BVtR/cM8Z4/9MKcDpYk=;
        b=SZ3pbfA216e6MnIvmnhUwMp4yO65lCjtETD987OdKBK7iOdpEdor/TV7/1EM63A3cj
         qkk5/Hzh2BRcXHml68+TZZDXsxrfYCnloO6gHR1F/mZSw3tPMj9bYC3lUZv4SZ91RnoN
         EMTldmDdsp0NQNBzNzLmsrdgESF9dU7cafhBph7o60w8IX2By6a7dRBcx0aNhIp6rcI0
         4+euhrH8QGzc9EZ3+QQPC/e6L2ZX2IeTfXeY3iOIx0dtEDulWbOKkhYcVhDfrmWhTp7b
         AIzSCYew7hvxJwjiTuh7MNdmc0s0Tk4urm7uUObMAzHSliUvK0AgJu8bqd5IMF6gnQaL
         3/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=78tdwGBH29xMqPEh9T+22n06BVtR/cM8Z4/9MKcDpYk=;
        b=rPhzKDHsqJsJDP0d7ZIy8NkAV7pUIbQ37rjC+DEt0MObIWkttb/l0CZOwYORCPSEsx
         6EYhT96iPzi3xj94dBunwrBB3hHOr8X3QU4N+MT3CSQuHa/qJPpuEhtL3SDyIGxf/gg5
         dOhHL1ZDcK5G6sPc7lUUqvmudRIHZXevfCgk6xv7XB8AxsFvWiaLPYaLyIswu5adnjlU
         WNIcMlNHmyZtLrZYAGZAJfWE3gRFO2+HjlNCbQllxTLVxLJrqIoalPRFLj470Djq9P8z
         b75fDc6e6emwO6miFJWa3EKltrtrkc2Q1CfLrJ+caZ+3ms2k3J0/lvD1leWaqKry5bzC
         k7YA==
X-Gm-Message-State: APjAAAUXow4cATxJhqB7j8CKMsDf2nkh7xaKzrIy75CU2UyPJa1scx08
        Qz5LF6LPggwujfqf6aphB5t94cl1
X-Google-Smtp-Source: APXvYqzXsVnVb7+aUrawpK9pPWywN6u6i3owazWrPmnOMgw0U0n76P8t9CSfz5iLuZjX4a/UJ7KXiQ==
X-Received: by 2002:a17:902:9a44:: with SMTP id x4mr6629755plv.127.1571354229611;
        Thu, 17 Oct 2019 16:17:09 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id b9sm3946280pfo.105.2019.10.17.16.17.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:17:09 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:17:07 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 06/12] t5520: use test_line_count where possible
Message-ID: <7ffbbc329f0d49f63cf5fafc211a964e8238650c.1571354136.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571354136.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of rolling our own functionality to test the number of lines a
command outputs, use test_line_count() which provides better debugging
information in the case of a failure.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 68b8822db2..9452779f40 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -699,7 +699,8 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
 	(
 		cd dst &&
 		test_must_fail git pull --rebase &&
-		test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
+		find .git/rebase-apply -name "000*" >patches &&
+		test_line_count = 1 patches
 	)
 '
 
-- 
2.23.0.897.g0a19638b1e

