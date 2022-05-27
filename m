Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1770FC43219
	for <git@archiver.kernel.org>; Fri, 27 May 2022 12:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349576AbiE0Mm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 08:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344854AbiE0Mms (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 08:42:48 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE85F4B
        for <git@vger.kernel.org>; Fri, 27 May 2022 05:35:06 -0700 (PDT)
Received: from [90.198.244.89] (helo=[192.168.0.6])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nuZBI-000Bcc-BZ;
        Fri, 27 May 2022 13:35:04 +0100
Message-ID: <4ff0622a-9b64-4200-e996-2d1875a52ec8@iee.email>
Date:   Fri, 27 May 2022 13:35:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] rebase.c: state preserve-merges has been removed
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
 <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
 <19baf95d-67d4-d7ed-72a6-96d098171d3a@web.de> <xmqq5ylsxccw.fsf@gitster.g>
 <32e5088b-35a1-4e8c-098e-18c465a0a0bb@web.de>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <32e5088b-35a1-4e8c-098e-18c465a0a0bb@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René

On 26/05/2022 22:27, René Scharfe wrote:
> Am 26.05.22 um 22:33 schrieb Junio C Hamano:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>>>>   		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
>>>>> -			      N_("(DEPRECATED) try to recreate merges instead of "
>>>>> +			      N_("(REMOVED) try to recreate merges instead of "
>>>>>   				 "ignoring them"),
>>>>>   			      1, PARSE_OPT_HIDDEN),
>>>>>   		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
>>> Anyway, the new help text explaining what the option once did is a bit
>>> confusing.  It would be better to focus on what it's doing now (nothing)
>>> and/or why we still have it (for backward compatibility), I think.
>> Do you mean that we should say "this option used to do such and such
>> but it is now a no-op" after "(REMOVED)" label, instead of the above
>> "this option does such and such"?  I think "(REMOVED)" is a strong
>> enough hint that lets us get away without saying "used to" and "but
>> it is now a no-op", so I can accept both.
>>
>> Or do you mean we should say "(REMOVED) for backward compatibility,
>> does nothing but errors out"?  I would be less in faviour, then.
>> Those who are curious enough to ask --help-all would find it more
>> helpful if we said what it used to do.  Otherwise they wouldn't be
>> asking --help-all in the first place, no?
> When I see an option labeled "REMOVED" then I get confused because a
> thing that says it no longer exists is obviously lying

That's a misunderstanding between the response to the command line 
option, and the described operation of the former sub-command/option.
> -- a removed
> option would simply not be listed.  Here the feature is gone and its
> option remains, but only reports an educational message now.

The needed user response is more that educational. In this case (for the 
Series) they are in a Catch-22 situation, stuck in a no-man's land 
between a preserve merges that has been started, and a Git that won't 
proceed. Currently (prior to the series) Git will even refuse to abort..
>
> Perhaps a better option help text would be something like "no longer
> supported, consider using --rebase-merges instead"?
We'll still need to say _what_ is no longer supported, to ensure the 
user has context. I'd agree with the suggestion aspect (Junio had 
commented similarly).

I suspect this problem could be a long, slow burner. We so rarely remove 
capabilities like this, so it's tricky second guessing how users will 
react, or when they discover the problem.

P.
