Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C5C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 06:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299A361242
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 06:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhFBGsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 02:48:52 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:14331 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhFBGsu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 02:48:50 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Fw01x3fs9z5tl9;
        Wed,  2 Jun 2021 08:47:01 +0200 (CEST)
Subject: Re: The git spring cleanup challenge
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
 <xmqqzgw9qky5.fsf@gitster.g> <xmqqv96xqjyr.fsf@gitster.g>
 <60b6c642ba65b_4044208ca@natae.notmuch>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <9fb1f823-44f8-8046-adb5-d2c0fdb6b5a0@kdbg.org>
Date:   Wed, 2 Jun 2021 08:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <60b6c642ba65b_4044208ca@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.06.21 um 01:44 schrieb Felipe Contreras:
> Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> David Aguilar <davvid@gmail.com> writes:
> 
>>>> +1 for merge.conflictstyle = diff3, rerere.enabled = true, and
>>>> log.decorate = short from me. I noticed others already mentioned
>>>> these.

Does diff3 conflict style reduce conflicts to their minimum? I don't
think so. Therefore, a strong -1 for this as the default.

>>> As the inventor of rerere, I agree on rerere.enabled.  It was made
>>> opt-in only because I thought it was somewhat risky when the feature
>>> was introduced, but it has been stable and useful, and it is long
>>> overdue to be enabled by default.
>>
>> Just to make sure, rerere.enabled is fine, but as I am not
>> comfortable to recommend rerere.autoupdate to any human users, I
>> would be opposed to turning it on by default.  Giving people a
>> choice is fine, but the default should be a safe one that offers
>> users a chance of final sanity checking before proceeding.
> 
> No commit is made. Doesn't `git diff --staged` offer users such chance?

rerere.autoupdate erases the information which files had conflicts. In
my workflow, the rerere database time and again does hold outdated merge
resolutions. I want to have an opportunity to cross-check the automatic
resolutions, and for that I need to know which files had conflicts.

I'm using a toolset on top of Git and am not paying attention to the
terminal---if and when I'm using it at all---that would list the
conflicted files. So, I'm strongly opposed to enabling it by default.

BTW, a +1 for rerere.enabled=true from me.

-- Hannes
