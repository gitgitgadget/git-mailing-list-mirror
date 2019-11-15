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
	by dcvr.yhbt.net (Postfix) with ESMTP id D2CF01F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfKOBA4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:00:56 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38427 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKOBA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:00:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id w8so3486954plq.5
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSmpX/yfEXtwy3Xz4dMR7V8zySn4Hd4nOhQ9KaFJTW8=;
        b=JYHtPauQlBhrlKWWp8CpUj7tjC0BWz1hoVocsPFIPCOjYMFsesEYpltA4vkO57o8tF
         w+33H/Z0WEMAyt/buFBo9HQBrS/LTwjMIegiawPE7QTNDqBvE1OhoRZlnWzjUvBTA2g4
         5MgRkRMKjXcVr5Fj8q47nshXJqkD9xtNu3aAJOBEwBaj7Gvye6SJYnY7fcV5tl8HFEQY
         Rz31jQhkONv+igg1ykdpjff1zM8DGUIK0Axff5GsDN9vUXiko7JGQoN2Z3ALMqUuyYmj
         3RYeEmORvyz0VOVDK6xEDIMU/+uSLRzyjUOrMlRZZuptx1psjKynvAxMXNox1ZcpuHFW
         66yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSmpX/yfEXtwy3Xz4dMR7V8zySn4Hd4nOhQ9KaFJTW8=;
        b=LRIdhoe2VXJzApVad4OBEFlZhvTReQOdOh1LUAuUL7SX8Dbs9HNUxIv5zwXkgxXoyp
         JjMEeXhzWwoThI8THtXjPzTJScSnSk/bxdk+5xXEi0Nj8p1/ZuDpO98KCKhiECfn+vfs
         x2fGQQkxJAi+4aePSaWfJMLzXqdxl3BAqX7TrlKDeSBbw65To7b3ZShYQq+/ArIaI+Wa
         hIL8PDbIvqVoY091maKM8E9RrdXn3xAmboPQ7P6dQ/ynKk5nfOxDgbLR0WTQwiZxsr1x
         byWhVnabwzXIcoXG32+WeJrGbJ1jSEnQktMs+k4bT25S9nWq9XebzF2M7N7IHblO5Geu
         7B1A==
X-Gm-Message-State: APjAAAUsHbRZLz7jvMw2HPTo2pQwiTgZtCvw/mJM3LiKekTHCl5grc97
        HVXwl1iejYoWMtAwSZ7Ze4du2gMD
X-Google-Smtp-Source: APXvYqyCrHYOKodw92Hu96UqNmg2KVXZfNCf7AawD2K0JfhclpT+Hip8O7ZPKbroGOvtftcvzoV0HA==
X-Received: by 2002:a17:902:ac84:: with SMTP id h4mr12719937plr.328.1573779654921;
        Thu, 14 Nov 2019 17:00:54 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id x2sm8184525pge.76.2019.11.14.17.00.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:00:54 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:53 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 09/27] t4015: use test_write_lines()
Message-ID: <d27bc8bad35aaecaa1f73045f8247c9e5fe053aa.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of rolling our own method to write out some lines into a file,
use the existing test_write_lines().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4015-diff-whitespace.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 7fb83c8eff..4c540b1d70 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -771,9 +771,9 @@ test_expect_success 'checkdiff detects new trailing blank lines (1)' '
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (2)' '
-	{ echo a; echo b; echo; echo; } >x &&
+	test_write_lines a b "" "" >x &&
 	git add x &&
-	{ echo a; echo; echo; echo; echo; } >x &&
+	test_write_lines a "" "" "" "" >x &&
 	test_must_fail git diff --check >check &&
 	grep "new blank line" check
 '
-- 
2.24.0.399.gf8350c9437

