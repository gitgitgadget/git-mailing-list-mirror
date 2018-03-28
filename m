Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C101F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753431AbeC1WVm (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:21:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41991 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753311AbeC1WVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:21:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id a16so1791265pfn.9
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=73fgJufxI2LNEj9pHuMduLI3ZGtt8K5r8iAQyBG28s0=;
        b=xVByZkmw7XQGTDN4AJVVClzLqA8ReK3LncGEdJgI4Xe0zUaeYWrPFDcrncxIUHj+nP
         FzCGdm0i9dPO0/jQcafWB9Ek+sw/TvKaZ+L8Kn4G3iHI3eSO6JRU3JsNBUyUePIt1V4B
         lOL/oNSIvKl8xzQydHEwkHvc9AwMBDCBkhuoCIZhBE65ziO2uRdgupSH1tLFr6JfXY/6
         3F0obI12eTlnuqacIYprUKYygqWm9jgV5tv22zl9TOypRzUlc/Aipf5fnyB9ob+f8Rce
         ncnugMR7KnU9elouQ0APZnGsk1+sasyCVjAgLf5BWNEpk0dfDqSbTv1u6FcaPm4RozMz
         0kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=73fgJufxI2LNEj9pHuMduLI3ZGtt8K5r8iAQyBG28s0=;
        b=rxNaE7YGDq2ODUcFAU0j07+dsspCx2S2canaYYNt9Lgivn73aGmBFqOdMcpIlSePEC
         4qXoDApazLfqo5xdcYxzxfqfsf4UqnPte4o+KwbpwJYwuzX1eLO+OYEG9G9FeT661Skv
         CcRmlfJQ8fiIlKYBI6sU+i+eyCm8pf3V9G5hYewWh2CvazSofLrgpHZ7T6MKrWrbMf5f
         dZglVz7rD2FSmzNsbqsLWiK22nMtXrDfoz82mOSlGZrDHlAlmyKyav6ssN0vVQZ/41U2
         m0rnz8nI54OMGvGHtN5peNunhHEtCq6q/FoZm1BLd/TC5UzVNJs1qZ2HXgtCl76/d7xI
         qTDg==
X-Gm-Message-State: AElRT7Ex7MHdAeezffwuuMhs2YGn2BScas2iklGZV+kBEeg/IgFKwksf
        eT/B/gSWJoJhm84VUfauWC6NUbM=
X-Google-Smtp-Source: AIpwx4+VgM8GDtiPBwAmQ2MEbHEH4+1+zBah1Ero47oGYlPSZjL7lZk8rlnFu214wsumfMErNodpkw==
X-Received: by 10.99.117.78 with SMTP id f14mr3735028pgn.382.1522275700462;
        Wed, 28 Mar 2018 15:21:40 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id e23sm8801907pfi.76.2018.03.28.15.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 15:21:39 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v4 0/5] Convert some stash functionality to a builtin
Date:   Wed, 28 Mar 2018 15:21:24 -0700
Message-Id: <20180328222129.22192-1-joel@teichroeb.net>
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

The code is based on next as write_cache_as_tree was changed to
take an object ID. It can easily be rebase on master by changing
the two calls to write_cache_as_tree to use tha hash.

The only comments on v3 were minor, so I feel this should be
ready to go in soon.

Previous threads:
v1: https://public-inbox.org/git/20180325173916.GE10909@hank/T/
v2: https://public-inbox.org/git/20180326011426.19159-1-joel@teichroeb.net/
v3: https://public-inbox.org/git/20180327054432.26419-1-joel@teichroeb.net/

Changes from v3:
 - Fix the Windows build
 - Fix a use after free in the error handling

Joel Teichroeb (5):
  stash: improve option parsing test coverage
  stash: convert apply to builtin
  stash: convert drop and clear to builtin
  stash: convert branch to builtin
  stash: convert pop to builtin

 .gitignore              |   1 +
 Makefile                |   1 +
 builtin.h               |   1 +
 builtin/stash--helper.c | 633 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 136 +----------
 git.c                   |   1 +
 t/t3903-stash.sh        |  16 ++
 7 files changed, 661 insertions(+), 128 deletions(-)
 create mode 100644 builtin/stash--helper.c

-- 
2.16.2

