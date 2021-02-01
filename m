Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080BFC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB0064EC6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBAWRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:17:11 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:8539 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBAWRK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:17:10 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4DV2ND0Zvgz5tlB;
        Mon,  1 Feb 2021 23:16:28 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B06874B9D;
        Mon,  1 Feb 2021 23:16:27 +0100 (CET)
Subject: Re: git fails with a broken pipe when one quits the pager
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Vincent Lefevre <vincent@vinc17.net>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org>
 <87im7cng42.fsf@evledraar.gmail.com> <20210201144857.GB24560@zira.vinc17.org>
 <87a6snokrr.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5772995f-c887-7f13-6b5f-dc44f4477dcb@kdbg.org>
Date:   Mon, 1 Feb 2021 23:16:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87a6snokrr.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.02.21 um 16:44 schrieb Ævar Arnfjörð Bjarmason:
> On Mon, Feb 01 2021, Vincent Lefevre wrote:
>> On 2021-02-01 13:10:21 +0100, Ævar Arnfjörð Bjarmason:
>>> So we've got the SIGPIPE to indicate the output wasn't fully
>>> consumed.
>>
>> But the user doesn't care: he quit the pager because he didn't
>> need more output. So there is no need to signal that the output
>> wasn't fully consumed. The user already knew that before quitting
>> the pager!
> 
> As noted above, this is assuming way too much about the functionality of
> the pager command. We can get a SIGPIPE without the user's intent in
> this way. Consider e.g. piping to some remote system via netcat.

That assumption is warranted, IMO. Aren't _you_ stretching the meaning
of "pager" too far here? A pager is intended for presentation to the
user. If someone plays games with it, they should know what they get.

-- Hannes
