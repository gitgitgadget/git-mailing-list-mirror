Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D5120562
	for <e@80x24.org>; Mon, 30 Oct 2017 10:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbdJ3KUm (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 06:20:42 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:60360 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbdJ3KUl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 06:20:41 -0400
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id 97BMeoj4rpb8r97BOekR5T; Mon, 30 Oct 2017 10:20:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1509358839; bh=dm+6O8/7Lo3iNINcikUq7bGMvFQgNaTEyehcDKpjDUU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LPWfs2Cmm91d0j0ujwqGzqX/inn2wj1K5xttVqRZly/WazLbajUlf4PTK9nGRqDIu
         seMdfL0zh4EX/hloTQeJuo6RbfhVV1OunmEB5o3PQ64GGjvT/Qz8aXHQFs7ulmint1
         DsQaLaaoQjKCt7uQdA+klw5ZvbqkXGQpeqH7q1pc=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=pGLkceISAAAA:8 a=R23-W3mZs7x22hj-XZYA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: exec leaks GIT_DIR to environment
To:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
References: <20171028000152.2760-1-jacob.e.keller@intel.com>
 <alpine.DEB.2.21.1.1710281740070.6482@virtualbox>
 <4150d979-f653-e79b-563a-1dc43f12468d@talktalk.net>
 <xmqq1sll8j6f.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xrXLcTQpPWgzLwt_yZo=QdfetF36jrc_TtXfqMKR2Hh3w@mail.gmail.com>
 <xmqqo9op71d8.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xo5UgUPQCYU-LaXn+HZZ1qe++KOevTMh2C1sgnzK0SAQA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <7026e5be-bbf0-9d55-8901-f920a775879b@talktalk.net>
Date:   Mon, 30 Oct 2017 10:20:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xo5UgUPQCYU-LaXn+HZZ1qe++KOevTMh2C1sgnzK0SAQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLj7AaG4uev02VjpMQM79w1MNs9JjcXJf+lj/StUjpF9JN4q04X/ENuUK6gURxK3poHOmbmDK5OU+wq18fat0ppsfIR7T09jGXC6XrV8QrflEfDMt+sK
 bdaaOc4EfRbMcrSevCRDbkmtJxjY8IL3Au0U8J8UvIc7ps7Q0z4P2wVBHBgHYwiuTdkWZR58XEENLsrjgLJVP/SZ5CP50HgeA4Jp6B0T7Ue6ojZNXFjnSata
 GHMX797ayJhQy5PmGeDqFvyjami3iPjZSg4zZKG4vx01DkxcwOoqna9ePShI+Dw34ZxNqka61FEHAuQ1zdPu2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/10/17 06:26, Jacob Keller wrote:
> On Sun, Oct 29, 2017 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>> I am pretty confident we can fix it....
>>
>> I am sure we can eventually, but 3 hours is not enough soak time.
>>
>> I am inclined to leave the fix for 2.15.1/2.16.0 instead of delaying
>> the release by 10 more days.
> 
> That's fair. I'm not even sure it was introduced since the last
> release (I tried 2.12, but not 2.13 or 2.14 manually). Thus, it likely
> wasn't noticed for at least a release, meaning it's less important (to
> me at least) that we provide a fix immediately, since it went
> unnoticed this long, likely that means few people will be impacted.

It is in 2.14.3, I haven't bisected but I suspect it was introduced by
311af5266b sequencer (rebase -i): implement the 'exec' command

Running
git rebase -x'perl -e '\''$,=$\="\n"; print  grep { /^GIT_/ } sort keys
%ENV'\' @
Shows that the rebase--helper version also sets GIT_PREFIX as well as
GIT_DIR, I suspect the difference is coming from differences in the
setup for builtin commands vs external commands. The shell version and
the rebase--helper version set GIT_CHERRY_PICK_HELP, GIT_EDITOR,
GIT_INTERNAL_GETTEXT_SH_SCHEME, GIT_REFLOG_ACTION

Best Wishes

Phillip


