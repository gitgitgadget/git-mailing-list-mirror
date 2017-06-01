Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B688220D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbdFAVNM (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:13:12 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34153 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAVNL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:13:11 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so37626690pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t+EM7Q/8LpI6ANJCsZHmljzkGzzeqIvnxfe8njxFbb0=;
        b=fl1ej/2gK3nJLMNqpqG8OKnwa5B+fzeVdLYr+Pbl9LkfmurldxqUZPkgtTSUJhOUZI
         VmtQ7t/+2XKn4gKsdHHztIEuPRUkVPOsQR5G2XUQH5oeMhFo9GGwQXo4P0VCiDkDH72C
         REANTDPHhOnxdPSJYqJinGDCb/1pRdLVL1C4UbILnvCYtdHwaJkbiLScx6Mj7d7QfGIX
         XuNBnYRgsPhgE1dR3JbpHp7WH9hoMXWgtPnyPtc/iszFSttVxuxicUDxAfGapAXBRu40
         shwbDDzvCSyN25fU7yqTIiRifwg7pt+Vz6ORMHm4OCq+C6gKxTeQL6WCQRz58XVP5CEr
         BrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t+EM7Q/8LpI6ANJCsZHmljzkGzzeqIvnxfe8njxFbb0=;
        b=rc0FkpZzeewwCoIF6i3y5iLr+Zv8zrhuaNrzgB1szDllBq0p9PXxWKh4o15V0eGVcj
         0nexGG8lT3MXPscahNoR+o5x1RsLjWybIcOIG0CpINh14nlOCkEEV7FVzGs4P5q1ESRU
         +5IVtk9nzrNiylPZ5EB8lg4HxE7/oBvwV82z947Yh/4CxiddHzOQRJYiAXlXmdL8vQ8h
         TyDVgaZu+u0c/A81yv/3eAC5/AM+ExjdQrqkz+gcuYTYSnh4SUB8mGebXuC+j669mpGy
         nKTWfDQ1LKG04/tSrfUht0XYMXTyxLjxOHo1HTS/cF8rNSgx3Z2fL1l0+oXa1j3lvRda
         wN0Q==
X-Gm-Message-State: AODbwcDwImL1Xynyk9KfJOlxPd1YFk9BkHZkA6qep9wLuPhNEHZnR129
        5HNZFKsg+ymfIUsc72WAm6jGt/+l5RRx
X-Received: by 10.98.236.150 with SMTP id e22mr3037058pfm.48.1496351590826;
 Thu, 01 Jun 2017 14:13:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 14:13:10 -0700 (PDT)
In-Reply-To: <020b09ef-6035-285d-c033-8831564d8752@gmail.com>
References: <20170601155105.28356-1-benpeart@microsoft.com>
 <CACBZZX6+V6=gSs0pdN9WU+LPZv5qSAmE5u_f=NFYht2dT-hxEQ@mail.gmail.com> <020b09ef-6035-285d-c033-8831564d8752@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 14:13:10 -0700
Message-ID: <CAGZ79ka1hjTFt9iRDrEy89ie9c3zj=BZ3SnZjPbLt6LGVDzeJQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Fast git status via a file system watcher
To:     Ben Peart <peartben@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
>>      $ git am /tmp/original_msg.txt
>>      Applying: fsmonitor: add documentation for the fsmonitor extension.
>>      error: patch failed: Documentation/githooks.txt:448
>>      error: Documentation/githooks.txt: patch does not apply
>>      Patch failed at 0001 fsmonitor: add documentation for the
>> fsmonitor extension.
>>      The copy of the patch that failed is found in:
>> .git/rebase-apply/patch
>>      When you have resolved this problem, run "git am --continue".
>>      If you prefer to skip this patch, run "git am --skip" instead.
>>      To restore the original branch and stop patching, run "git am
>> --abort".

Try again with -3. (We should make that the default for am, maybe?)
It helped me for most of the conflicts that I saw.
