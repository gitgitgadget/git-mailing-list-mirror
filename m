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
	by dcvr.yhbt.net (Postfix) with ESMTP id A50E11F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfJVKUO (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:20:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41881 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKUO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:20:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so9658561pga.8
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a6QSvPox0audVTemUdwMvQrKuSMXve+4jCu/Zwy9rX8=;
        b=ooxl0b+sxtgyJQf+WpFG8I14Rgt/d1yZPmyPRwmy4myYxj0UQlEMKxr21Mvl8MKJav
         Ik7iJKxmPM3/GuQvOeOkgc4zEcLAQGFzBfvgsjoLiaZvy4EQZGsBY3w27n6UhguOwItE
         i8q+kXpIiIHLZiRWjd46BCkV0Lua43L3CZ98kpqbwFZmaqFFs+YoHOxOFgfu34rlZ6Qq
         1GhUuf53At+bQBbGZQX3c026wK+VtNeUdcX+y0vsJwWreCHLUmno6yflZPeZ6L5m5Pgo
         6CFvzv/Qe+M2AyhI19i59QQY4A+VLA7mANTtkKZpYKlU1KaUVn0PcJO9Wqyo6JsLxC8a
         V3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a6QSvPox0audVTemUdwMvQrKuSMXve+4jCu/Zwy9rX8=;
        b=lIDLxfXFl0MBxNe+TgvOFUiKMja7W7Bs5aGMtEeUE3A/SzK2aqJc3g9LBBY8tTsxY9
         MliwntefxjGXXnkreDpw0ZFbfqw2rJPZy9EiF+iOruT5lx2+afHxjRHyMywtULvHsiHF
         f4/HF4FWjWJGLEQyX6OYggX6FGS1/L5ohqaTkOiMDwVE5a/RJVZY+W9tjF47uLr8MBEe
         o9atCvZhzvJwv0lhAU4aLcgiMBj5qiqZ0Nt5LAyqg/nMwwfbNHFOjp8VvmTaq9WsWSVv
         KK5BX7RbF5cY7T8NAI0u6Bkqj8IyS9RnzMXsMgnlSpFENpS6X2h2+STaCJEGjC4ar/xl
         Ojew==
X-Gm-Message-State: APjAAAU+Ig2fmU9gB+B+oShMVK7zkzAMJ8SB2+CLqMJBFUa/bPYzkyqJ
        WbI+ZRDYIKso+V9+P9XpkoFa/pTs
X-Google-Smtp-Source: APXvYqwFR7CSjGRucmL4hLq9qXec5LDxUvZxokGSPBoXoPapTY1vEFuh8ls4OlYhf+el21lLCdLRJg==
X-Received: by 2002:aa7:9907:: with SMTP id z7mr3371772pff.133.1571739613380;
        Tue, 22 Oct 2019 03:20:13 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id f21sm16242949pgh.85.2019.10.22.03.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:20:12 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:20:10 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 07/14] t5520: use test_line_count where possible
Message-ID: <fcfc3226f8015e07ce539645b7f2f72b201b58d3.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
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
index 7bb9031140..0ca4867e96 100755
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
2.24.0.rc0.197.g0926ab8072

