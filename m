Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1404C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 18:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93846608FE
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 18:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhFBSPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 14:15:01 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:50549 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhFBSPA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 14:15:00 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4FwHFl4gPtz5tlF;
        Wed,  2 Jun 2021 20:13:14 +0200 (CEST)
Subject: Re: The git spring cleanup challenge
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
 <xmqqzgw9qky5.fsf@gitster.g> <xmqqv96xqjyr.fsf@gitster.g>
 <60b6c642ba65b_4044208ca@natae.notmuch>
 <9fb1f823-44f8-8046-adb5-d2c0fdb6b5a0@kdbg.org> <xmqqo8co7cqe.fsf@gitster.g>
 <YLdvJ0G19LNcbDSD@danh.dev>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f2b0c200-ff4f-da5e-ff49-c440ff0813de@kdbg.org>
Date:   Wed, 2 Jun 2021 20:13:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YLdvJ0G19LNcbDSD@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.06.21 um 13:44 schrieb Đoàn Trần Công Danh:
> On 2021-06-02 20:00:25+0900, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> rerere.autoupdate erases the information which files had conflicts.
>>> ... So, I'm strongly opposed to enabling it by default.
>>
>> Exactly.  "checkout -m" can use resolve-undo information to
>> unresolve the conflicts, but to make effective use of it, you'd want
>> to know which paths had conflicts to begin with.
> 
> I don't know about this one. I had been bitten by rerere.autoupdate
> sometimes. And I need to wipe out the rerere record to start over.
> 
> I guess I should turn it off, then.

You can use

   git rerere forget that/file

to erase the record for the current resolution of that/file. Then you
can recreate the conflict using

   git checkout -m -- that/file

It may be necessary to run

   git rerere

at this point to save the pre-image of the conflict record, but I'm not
sure.

-- Hannes
