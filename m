Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4981F404
	for <e@80x24.org>; Tue, 10 Apr 2018 05:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbeDJFU5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 01:20:57 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:62350 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeDJFU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 01:20:56 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 40KwVt37HMz5tlS;
        Tue, 10 Apr 2018 07:20:54 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 39CC7101;
        Tue, 10 Apr 2018 07:20:53 +0200 (CEST)
Subject: Re: Windows > git.exe > the result of "git branch" does not always
 highlight the current branch
To:     Hari Lubovac <hlubovac@gmail.com>
References: <CAFLu24=o0nQveRpMJV-6dhvft0H9PgdBahisBi4EEg=G0BwhpQ@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4de8574c-1b64-408c-ca7e-c6e3de2dfa4a@kdbg.org>
Date:   Tue, 10 Apr 2018 07:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFLu24=o0nQveRpMJV-6dhvft0H9PgdBahisBi4EEg=G0BwhpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.04.2018 um 21:26 schrieb Hari Lubovac:
> It appears to be just a reporting issue. Probably not a big deal, but
> I thought I should report this, if it hasn't been noticed: when a
> branch is switched to by being named with non-original
> character-casing, then it's not clear which branch is current.
> 
> Example:
> 
> C:\repo>git branch
> * bar
>    foo
> 
> C:\repo>git checkout Bar
> Switched to branch 'Bar'
> 
> C:\repo>git branch
>    bar
>    foo

The bug is not that the branch is not marked, but that you are permitted 
to check out a branch that does not exist. This is a side-effect of the 
fact that branch names are sometimes stored using file names, and, as we 
know, file names are case-insensitive on Windows. I don't know of any 
efforts to fix that (I assume that it is not just a simple fix). In the 
meantime, I can only recommend: if it hurts, don't do it.

If you call `git gc` before the checkout command, I would expect that 
you would not be able to check out branch 'Bar', because branches are 
represented unambiguously after 'gc' (not as file names).

-- Hannes
