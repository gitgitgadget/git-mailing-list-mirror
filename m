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
	by dcvr.yhbt.net (Postfix) with ESMTP id A191F1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfKGSvh (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39625 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfKGSvh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so3130283pfo.6
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LW8/hCM+7ag1gF3rgUI1vQFMYMeglOWvnRFNyloJvqk=;
        b=rHbBBNYAmyFxIuCWPUW6NXEZHkXxmvCFu6vwvcEr0NrzoZG/Dro3CV/WvxFqy/uMlk
         4Mg6nx4MWSu3j09GQZpb0jVe71yd2LcrsQ5Nenvxtrfvmg4crYx7Wh6LgrswfpTdxj8M
         rSvL/UZCmx5HmFUf7yLHxptpN2Vfb4jDwl5YzfC5g7XC++DY+prRgarw0lEw/Fb6129V
         HpJjFejiAgYU0UJaP5hALYBXIKsL2V0tfkbbVRvcxpdVcmt7uG3lVafPkujZESrz5yUU
         Uqq2+VICqLYe3UzZxNSnG82ICR/xFHSWpVDPl9xNU5nvOoalozDiKbwmTrLS3qr4VIop
         SoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LW8/hCM+7ag1gF3rgUI1vQFMYMeglOWvnRFNyloJvqk=;
        b=e1D7gbEDqI6aG8SI3WpML//BdickyfohIWKMCsJJ7Z67ZwFGUoADHjGcUxriqfmgNg
         ycMJoQ3X1MSG1HGe4Ov3RoH1mzAliNBRu+RuhiF+fV6gPtOxC0+c4wFcKKdqH1fRU7YV
         gquB090/Qq4+kznHcJ2ZPkveB7N687WbFYHvwPXtcgJm6/R3UTViRecQF+C/t2zj3DC4
         hY4+ayz06eXuHfU+ovkEoqKoZzWybi1zf5WrR6gL3LjzG1a/wbE8aO6gf29keq5DnMe5
         oiAzclqjMZtdzHGbg7zLM3bNduiPDbSwVWZ2ulSPDDzFhmQuzYwa/UwzzDHlZ8f/TBvd
         SK9w==
X-Gm-Message-State: APjAAAWulEKy7LczHEv86iq5gNb1wF9mXytgx+92hv+wGty6jWHl0a6i
        GNU7ITYFlTj9U8CfnsA/G7/zPfGf
X-Google-Smtp-Source: APXvYqwxUB6Nlu/v62QOTzaPk6NTW+EtbXncmOQSQLvAHHMVEJSiGw+1eOh3y4WNGh4KBQzI0eEU3A==
X-Received: by 2002:a62:20e:: with SMTP id 14mr5895095pfc.153.1573152696323;
        Thu, 07 Nov 2019 10:51:36 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id k190sm4775322pga.12.2019.11.07.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:35 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:34 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 07/14] t5520: use test_line_count where possible
Message-ID: <1e8ecb80a4c7bc614f39dbf099fc5fe417e48a7c.1573152599.git.liu.denton@gmail.com>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573152598.git.liu.denton@gmail.com>
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
2.24.0.rc2.262.g2d07a97ef5

