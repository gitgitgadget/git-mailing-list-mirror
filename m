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
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3901F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfKLAN6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:13:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43642 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfKLAN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:13:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so10557411pgh.10
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NjpsV5sTCNMPstPli3/7OraoZmrWr/kJKIsP/I7pvug=;
        b=BGO/UZ5gVKNgxmhcjQgSG3L1IO278YAIW51c0cagpcQtJ0kOYs1Y1BDUN77PawtXC5
         jQwF01ViBPZEEc+6jYHPqgVRKPa9q8zWrbGKYl4IFkq+DfpAfGT5qXg+WfemXrNI+cVr
         Rv/sIy/PgS4qVYDLO4vLjre/9PCcM78Dlxl0SEkl1UiDFvBy8V+i+1/5DklIZ4UiiJgY
         X/FyL5hyypYMSHG3N0ITCTSa88sMCFwZu3XLFcBPunB2IS+jetsGo+Ywy5n/2n/P5noL
         yE1LHwpO6NT6tWc4hAOmn0LndlmIqyeWnmSTaUM2Qa9m7z1GGzyzI/xTP6EW1nNtTwQH
         Gw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NjpsV5sTCNMPstPli3/7OraoZmrWr/kJKIsP/I7pvug=;
        b=XqpzH8pSgSqTpA7gd1F8I5RLe8C3JmKPPRZmRbolxGd5jJi677oxkYY/9pymDNFuJ0
         vFJNllgtsgeCTVHPbXRKgDbgpM2b6K5SJboHQVN0BLPbh/8tHM0ukUHVYpYXymkHfqxV
         mGtmXZJyvVGjWHd9KNrmi55owzkPYQlZyfeA6CuIBLKQunm4vvJMrWC09qa48ODH39bM
         S20zijOhz6NKKbjcbJs7bk/LANN2XfKIG43PhluSZIPDe/cw34oPcaI0VY6rew6w/SoP
         VfipDVNxXcB3fQaWdhs705Cdi8RJdzisn9gv7LdfFOF/KnRbUUIw7NEpItrxihY6YM2m
         EmzA==
X-Gm-Message-State: APjAAAWTlrAOJ1cgVyuxR7sFBa+7TkltDq3RtsgzyLWWmzlmfwo/Q39Z
        QvOx1wD1Dlm9SI/QDaECTT4Ydg4t
X-Google-Smtp-Source: APXvYqxpp9ic9aXkkgCmmvbxVwp2De6jnkwRjLlfGtP4qtLfq8wLbw8nXzZvgQ2GkjI7yu6a3Ln9QQ==
X-Received: by 2002:aa7:961d:: with SMTP id q29mr31826937pfg.89.1573517637582;
        Mon, 11 Nov 2019 16:13:57 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id a66sm16585718pfb.166.2019.11.11.16.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:13:57 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:13:55 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 07/14] t5520: use test_line_count where possible
Message-ID: <5106004e95b6fedd0bf04922276744d48c1b2dae.1573517561.git.liu.denton@gmail.com>
References: <cover.1573152598.git.liu.denton@gmail.com>
 <cover.1573517561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573517561.git.liu.denton@gmail.com>
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
2.24.0.300.g722ba42680

