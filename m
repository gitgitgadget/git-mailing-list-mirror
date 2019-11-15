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
	by dcvr.yhbt.net (Postfix) with ESMTP id B38DD1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfKOBBa (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:30 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:45658 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfKOBB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:29 -0500
Received: by mail-pl1-f179.google.com with SMTP id w7so3475896plz.12
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w93ahQ5uHbsYV8T52XPLXv9KtWvrd4ndaT3MCfGhWHI=;
        b=NFZJjJbD9EAg2F3RyOHmj7Ub8ro2/hLISdQgpaDuraqc5v5TMTCeOgHK+E2JFM6Cst
         Y/Q/CsBMm9y+W3hbNVqCwyd2lartqdHFdUKbrVoULHlAVRPi6Z+Dq2NT42vs0+8Pv//0
         GhkzChs/CJkN6W37uo+CWZT7YwNtuheiOTPip24fgFg32IPFKGdQ1WqMDOwtynR8p+fB
         fNB5iK6PV5CYhfZEHAQ0xvCHMJVKdGpCbkI9oWGzkYwTcxh3PqDTRYy47NLz7i2Vqzmu
         jNRzLxyOGBEj/mkj/km/3iO++5iDLgVlaAZH8EdiRN5yFevNLR3PSfwrKr+al/TCKPWj
         2ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w93ahQ5uHbsYV8T52XPLXv9KtWvrd4ndaT3MCfGhWHI=;
        b=NLjJGDRQ9bySnGilcBX9lK9hY3viJhEq0LlLFYuzKZnhd163OmDo6IiHx6KTulbs6h
         NhZZiHqgv3KAP4IHwPBD7Z7G0COK0NJ9uqkauRQ5a+MOV4SIlVZBYZlhQZ+7i2xx8NRt
         7RO0/zY90gEvo8z6VjTqG3y+yNsTuVQOApJjAoEUSwhzdaAkgqa+OD9kXKsQnZ5J+n81
         zxdUJp59svCAhpqjTcP+qFUOxHtUg1WYOF5pJLZMXUPo31zc3Fb+osD4hRGxs/CPr3+H
         FFQaxmSYsvi3B/UhtAtg0rbpy7kzcjP2hOfMviHVtO8BxwZirakiNTYTQJo3QWYkY6HP
         aj0A==
X-Gm-Message-State: APjAAAXwdUB+AQiOMCND5dbLONkkWhp2EOQrUNyg2DwF5tEndA0MRXny
        y12Zj3TIrKFk7b2B9QHfOF2CQWH8
X-Google-Smtp-Source: APXvYqwzJGavNqx2Lz41IQnVTFj1+Z/MVG/Qt0slQnxFXBuceUle3kMyGkLmscv2fHkmY/nZio2yzg==
X-Received: by 2002:a17:902:7c03:: with SMTP id x3mr12234676pll.157.1573779688248;
        Thu, 14 Nov 2019 17:01:28 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id v10sm7521489pfg.11.2019.11.14.17.01.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:27 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:26 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 24/27] t5004: ignore SIGPIPE in zipinfo
Message-ID: <d27ee1e627339f2fc6a8fdf3b1be79435c9a4bc6.1573779466.git.liu.denton@gmail.com>
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

In a future patch, we plan on running tests with `set -o pipefail`.
Since zipinfo is killed by SIGPIPE, it will return an error code which
will propogate as a result of the pipefail.

Mask away the return code of zipinfo so that the failure as a result of
the SIGPIPE does not propogate.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5004-archive-corner-cases.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 3e7b23cb32..4c6d42d474 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -153,7 +153,9 @@ test_expect_success ZIPINFO 'zip archive with many entries' '
 
 	# check the number of entries in the ZIP file directory
 	expr 65536 + 256 >expect &&
-	"$ZIPINFO" many.zip | head -2 | sed -n "2s/.* //p" >actual &&
+	{
+		"$ZIPINFO" many.zip || :
+	} | head -2 | sed -n "2s/.* //p" >actual &&
 	test_cmp expect actual
 '
 
-- 
2.24.0.399.gf8350c9437

