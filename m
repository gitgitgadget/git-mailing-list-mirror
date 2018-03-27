Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461E61F404
	for <e@80x24.org>; Tue, 27 Mar 2018 05:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750932AbeC0Fp1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 01:45:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39488 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeC0Fp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 01:45:26 -0400
Received: by mail-pf0-f194.google.com with SMTP id u5so8478239pfh.6
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 22:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=xlIpK3ZJvQ1DeXnpMV+T5ee9FQAWU0rn6W+xqQJoSK8=;
        b=AClwLl8+JsXSa0Fku5k1wP52eGQZUMML88LTKuVosYSnuJIziNtb+KEDafz47bMp2N
         GOjq9GYUvqH0YJDPphp1aYcCO0EbJX/KZm3ONigp6TToou0dyvFVVroBtKnGbsGVquy1
         o0adcj3tBCv3ZpuMucIbtXfl8tgwJXHM6bThHwSDHRK/WK8OjHkKEdSURKdcC9AAac82
         8J0xGFuC7pnNl8o7nexNx3VHs1yxy2iyO+im5T6q6iqbH/v4xbDQ7Y463+75n1Tn6QPO
         hQIa3TWD++zzDdHIbq+YCp0DrGWVoc8yijNQnWWdBndzNmx1XKdY++LpCMG1eryDxMhe
         gWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xlIpK3ZJvQ1DeXnpMV+T5ee9FQAWU0rn6W+xqQJoSK8=;
        b=GGI54dAzYvMX+5XhsXfis+5ZzBUHjmeeEYDQg1kaUxHNkry9IgGNfvCNL1YXeD4Q/x
         BTHf56KFUnY7ne6vPM9FVwSVHNA/Jw6hSwiwVKvZnpQ1z1tcg1qd2b0u/BIhcn9Tmmjs
         OlP7zexNDZgx4FkCw7FBsGebV6Ed7nEQwbNXM6+kxdL00H7L2Z0P/ItGC5iTW66paERY
         Ex7NUilhUuzps4BuvR8/4FLIKHEUNOzAb4KRHsMwCV/hUoAcbjjQqLdBFP1kY2q6w5vb
         thxUaZg5o1i7Xdent8rrsjw1EyLjOtqpl6rJAuWF+KM30j4h/wWVHJisb4iLo3h49gFZ
         IVwA==
X-Gm-Message-State: AElRT7G6xaBWbrfHzeK/Pe/oXwA0XvWEuHJ2MX2J0W4sThJItClCQTff
        Aa9IN6487cn+tkPhsD2kzQt2Gwk=
X-Google-Smtp-Source: AG47ELsF4D4M9PPH0G7lG0SgrEy8DPI/6mZ/9XHBxoliXi8Gw01WqWMpspjyXTV2z9CVS8/BsMOFxA==
X-Received: by 10.99.96.84 with SMTP id u81mr30504536pgb.231.1522129525616;
        Mon, 26 Mar 2018 22:45:25 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id n8sm898733pff.131.2018.03.26.22.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 22:45:25 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v3 0/5] Convert some stash functionality to a builtin
Date:   Mon, 26 Mar 2018 22:44:27 -0700
Message-Id: <20180327054432.26419-1-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been working on converting all of git stash to be a
builtin, however it's hard to get it all working at once with
limited time, so I've moved around half of it to a new
stash--helper builtin and called these functions from the shell
script. Once this is stabalized, it should be easier to convert
the rest of the commands one at a time without breaking
anything.

I've sent most of this code before, but that was targetting a
full replacement of stash. The code is overall the same, but
with some code review changes and updates for internal api
changes.

Since there seems to be interest from GSOC students who want to
work on converting builtins, I figured I should finish what I
have that works now so they could build on top of it.

Previous threads:
v1: https://public-inbox.org/git/20180325173916.GE10909@hank/T/
v2: https://public-inbox.org/git/20180326011426.19159-1-joel@teichroeb.net/

Changes from v2:
 - Fixed formatting (I keep forgetting to set vim to tabs)
 - Renamed destroy to free
 - Redid my tests to validate more (Thanks Johannes)
 - Deleted more shell code that isn't needed anymore

Joel Teichroeb (5):
  stash: improve option parsing test coverage
  stash: convert apply to builtin
  stash: convert drop and clear to builtin
  stash: convert branch to builtin
  stash: convert pop to builtin

 .gitignore              |   1 +
 Makefile                |   1 +
 builtin.h               |   1 +
 builtin/stash--helper.c | 631 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 136 +----------
 git.c                   |   1 +
 t/t3903-stash.sh        |  16 ++
 7 files changed, 659 insertions(+), 128 deletions(-)
 create mode 100644 builtin/stash--helper.c

-- 
2.16.2

