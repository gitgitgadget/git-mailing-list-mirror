Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539E01F935
	for <e@80x24.org>; Sat, 24 Sep 2016 22:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965058AbcIXWNK (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 18:13:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34964 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934946AbcIXWNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 18:13:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id 133so8239015wmq.2
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=hgz/QalMFf+U5feUIG+4BL9RjXyyDYsJnA9ro2PU4to=;
        b=0pxNs3P/GUCTrwPUU6IOlhLX1z7kGbjvSYEQgEWRU0tfC2J/QJBZmBde91iO9htBcy
         gttZ76zIeD0sSCxTvy/1VTT5oxYK240WPtyV5MiMziSgiAa9vdXxiopOWo5gU0nbtqCG
         VYyClyOModTSbl7y8d8sQmgs0bopk90SAEWNv2LZ2Reo2t2CC4fMZUayNgcBhf1/T5r7
         NjsPsjLZSf1RQ5HAyGe2EhxupSHeTSwDD+IbFpd8DY6PIMSTjFtjr4e3K6wq7txruhwk
         wcLUjhMuoJrqd+wrEycPydo4ULq8JM4EG08Sa5UmSjlDzEDdeLM06Coi9LBQ8uqJ5yDD
         K21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=hgz/QalMFf+U5feUIG+4BL9RjXyyDYsJnA9ro2PU4to=;
        b=SuQwdrxBrHBIQsbnQYEZ2LrTSAlBQUwpjioJwab/Fu8uSgvkbzI/LxZN3LHy5RHZYF
         R24xJ4udHxBG/XW9mg8SWhoCsGEuiLxNvf2BVZfg3WazTAay1IcC2Xmk5z24cFoo+Ii7
         faBS6HN1SyIxkzDnrQBjUYdMidwK0XtsvxgmnO2YCphArnVjJGejofHhibpPSjF/iHlO
         8Ojt6pM80U6FB0ZSqH8EmMgBRxBZNA+7opTIRoeLd+M29LgDf5vJhwGmHJIfhb5FAxvR
         +jeOwGKVFVvQBG/exUNMBfFgz5d775Aoe7EQZju1vo7bmgzDfQ1Hv7W4oIBwIxQTv8Jw
         qQkA==
X-Gm-Message-State: AE9vXwN1E3zH2tGD/E9TKXymiWy+1ZHDSzac2JLtRPrBL/4uXTrZt2mPiDGULXYdBxjcKQ==
X-Received: by 10.194.61.243 with SMTP id t19mr12016224wjr.60.1474755187831;
        Sat, 24 Sep 2016 15:13:07 -0700 (PDT)
Received: from [192.168.1.26] (dce219.neoplus.adsl.tpnet.pl. [83.23.56.219])
        by smtp.googlemail.com with ESMTPSA id w129sm2976266wmd.9.2016.09.24.15.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 15:13:06 -0700 (PDT)
Subject: Re: [PATCH v8 03/11] run-command: move check_pipe() from write_or_die
 to run_command
To:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-4-larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <854ff387-57a4-4c27-4c27-b834f7797694@gmail.com>
Date:   Sun, 25 Sep 2016 00:12:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-4-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Move check_pipe() to run_command and make it public. This is necessary
> to call the function from pkt-line in a subsequent patch.

All right.

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  run-command.c  | 13 +++++++++++++
>  run-command.h  |  2 ++
>  write_or_die.c | 13 -------------
>  3 files changed, 15 insertions(+), 13 deletions(-)

Diffstat looks correct.

Not to add to your burden, but perhaps somebody could add to his/her
TODO documenting check_pipe() in Documentation/technical/api-run-command.txt
Or is it not worth it?

Best regards,
-- 
Jakub Narębski

