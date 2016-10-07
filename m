Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0028820986
	for <e@80x24.org>; Fri,  7 Oct 2016 17:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756654AbcJGRmj (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 13:42:39 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:60671 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751203AbcJGRmi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 13:42:38 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3srH0X1K5Lz5tlH;
        Fri,  7 Oct 2016 19:42:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A1F1D5326;
        Fri,  7 Oct 2016 19:42:35 +0200 (CEST)
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
To:     Duy Nguyen <pclouds@gmail.com>
References: <20161006114124.4966-1-pclouds@gmail.com>
 <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
 <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
Date:   Fri, 7 Oct 2016 19:42:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.2016 um 14:27 schrieb Duy Nguyen:
> On Fri, Oct 7, 2016 at 6:20 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Junio,
>>
>> On Thu, 6 Oct 2016, Junio C Hamano wrote:
>>
>>> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>>>
>>>> Throwing something at the mailing list to see if anybody is
>>>> interested.
>>>>
>>>> Current '!' aliases move cwd to $GIT_WORK_TREE first, which could make
>>>> handling path arguments hard because they are relative to the original
>>>> cwd. We set GIT_PREFIX to work around it, but I still think it's more
>>>> natural to keep cwd where it is.
>>>>
>>>> We have a way to do that now after 441981b (git: simplify environment
>>>> save/restore logic - 2016-01-26). It's just a matter of choosing the
>>>> right syntax. I'm going with '!!'. I'm not very happy with it. But I
>>>> do like this type of alias.
>>>
>>> I do not know why you are not happy with the syntax, but I
>>> personally think it brilliant, both the idea and the preliminary
>>> clean-up that made this possible with a simple patch like this.
>>
>> I guess he is not happy with it because "!!" is quite unintuitive a
>> construct. I know that *I* would have been puzzled by it, asking "What the
>> heck does this do?".
>
> Yep. And I wouldn't want to set a tradition for the next alias type
> '!!!'. There's no good choice to represent a new alias type with a
> leading symbol. This just occurred to me, however, what do you think
> about a new config group for it? With can have something like
> externalAlias.* (or some other name) that lives in parallel with
> alias.*. Then we don't need '!' (or '!!') at all.

Maybe it's time to aim for

   git config alias.d2u.shell \
        'f() { git ls-files "$@" | xargs dos2unix; }; f'
   git config alias.d2u.cdup false
   git d2u *.c   # yada!

-- Hannes

