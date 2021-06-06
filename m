Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E93C47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A0B6124C
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFFM3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 08:29:18 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:44776 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFM3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 08:29:16 -0400
Received: by mail-pg1-f171.google.com with SMTP id y11so3521468pgp.11
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=JjnRgIihpE37cPoqwem+c6wDJFhW9OBx9NjXPN+ykSc=;
        b=B2Yl0H1DKHhsiJsY6ILpQID6TErM0JCN8gJA3yFIpcViAucJt5/YK96L9WH08w4gVK
         O36UCfuT+JzE8ghPFb6Wu3JzbyGKgdi3b89mDHNryGsqwH5Df5c0I1lLuN7KPwrYxV2W
         t3lJDJntP9EV6/ZCPYXvlaMWequd4WreFQwCHLy7A9p+38s46jeOo/cp4ddvyVIRQTcX
         u9Y8mfGL730m3Y6mmFgujLzbyYz5zApDihxAVwfOPxTAMAFGscIrN/O2tsVJumcCZEYy
         eHxeaoFA8GPXqXU6d9szG0V4xKxSi3n33nvnExVLcZE2ltHQmxOf0fFSv3CqO5thyg5/
         8gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=JjnRgIihpE37cPoqwem+c6wDJFhW9OBx9NjXPN+ykSc=;
        b=jv/pnRVSsmtwN4TkdXVrXZPEiKuAaYHLM36pqA8w9kuXKilA6tANiXfOjHBDTlZ+GY
         UFZN6L6ye/9Z4kqLO5QH3nMsT+2zHqhZ4WTCYafmvo4vJfVbfpAEWX+T/5WL2Qi67uB2
         nUDVWsGHaf+7bFx3w2TDljkNE+RfvnIzyZ1OyjLNjh3Uji0dCMz9rqY7ef15HSi+Hgu+
         few09P9hfBnl1uhGSVr+haDeECWhCS7VpAnKrSi2kjYlaHZF28KfA+14z1yc5ZugbuFP
         suMGrQJm4+XPO0kXClqRyOoCSTaOnJsECIeUzYeKVzJQkCHYSks9XUNsjxjx6ny9CBkc
         /w4A==
X-Gm-Message-State: AOAM5303mvkwt5NmXWjXO5NkBTq9NZByn2lvoMYRrr0VvOCYPBIm9Fv/
        voHGyEfzScf6+vJRSu+UvHmk5B1IQQazObCo
X-Google-Smtp-Source: ABdhPJw6ReE375iLcFaGEELybTD5Cj79FOdmDE+PRgZHkFeHrPWbw/TUXgPADy2dNyZaEwPLolR/jQ==
X-Received: by 2002:aa7:8244:0:b029:2ec:968d:c1b4 with SMTP id e4-20020aa782440000b02902ec968dc1b4mr10335334pfn.32.1622982374229;
        Sun, 06 Jun 2021 05:26:14 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id n12sm9463898pjk.48.2021.06.06.05.26.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jun 2021 05:26:13 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: [GSoC] My Git Dev Blog - Week 3
Message-Id: <FC56DF49-CEC5-4C9F-BDE4-B0119558E4B2@gmail.com>
Date:   Sun, 6 Jun 2021 17:56:11 +0530
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is my latest instalment in my weekly Git blog:
http://atharvaraykar.me/gitnotes/week3

(In case you missed week two, here is where you can find it:
http://atharvaraykar.me/gitnotes/week2)

This issue mostly consists of an update on the work I have
done since the last week, as well as the challenges I faced
and overcame.

I'm sure many of you will probably find things that are
quite suboptimal about how I work, so feel free to nitpick
away. I'll definitely learn something from it ;-)

Have a great weekend, and stay safe!

--
Atharva Raykar
