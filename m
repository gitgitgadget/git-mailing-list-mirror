Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68D5C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 14:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiLEOeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 09:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLEOeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 09:34:14 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D819026
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 06:34:13 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D9FACCA1255;
        Mon,  5 Dec 2022 09:34:12 -0500 (EST)
Received: from [192.168.1.88] (124.sub-174-216-8.myvzw.com [174.216.8.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1E812CC831F;
        Mon,  5 Dec 2022 09:34:12 -0500 (EST)
Message-ID: <de558eb7-8931-a5b5-d711-459ae3f52216@jeffhostetler.com>
Date:   Mon, 5 Dec 2022 09:34:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
 <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
 <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
 <221202.867cz9fwnf.gmgdl@evledraar.gmail.com>
 <4711d955-02b2-f599-7f89-b442dd0b6215@github.com>
 <221202.86359xfs5c.gmgdl@evledraar.gmail.com>
 <1b090929-f2da-f075-01d4-458804fc0717@github.com>
 <xmqq1qphuwj6.fsf@gitster.g> <xmqqv8mqsm2g.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqv8mqsm2g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/4/22 7:58 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I'd still prefer that our commit messages keep records of the fact
>> that we stopped supporting certain older systems and what kind of
>> due dilligence we did to decide it is a safe thing to do, which all
>> already happened in this thread, thanks to you three discussing the
>> issue.  I would be happier even with "Anything older than 2014 does
>> not matter to Apple, and we follow that stance" than without any ;-)
> 
> I'd propose to have an extra paragraph at the end of the commit log
> message.
> 
> 1:  02a55477b6 ! 1:  df739b6087 fsmonitor: eliminate call to deprecated FSEventStream function
>      @@ Commit message
>           maintains the original blocking model by waiting on a mutex/condition
>           variable pair while the hidden thread does all of the work.
>       
>      +    While the deprecated API used by the original were introduced in
>      +    macOS 10.5 (Oct 2007), the API used by the updated code were
>      +    introduced back in macOS 10.6 (Aug 2009) and has been available
>      +    since then.  So this change _could_ break those who have happily
>      +    been using 10.5 (if there were such people), but these two dates
>      +    both predate the oldest versions of macOS Apple seems to support
>      +    anyway, so we should be safe.
>      +
>           Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
>           Signed-off-by: Junio C Hamano <gitster@pobox.com>
>       

I like this new text.  Let's do this and call it done.

Since I see that you have already added it to the commit message
in the branch, so I won't resubmit it unless there are further
technical review comments to address.

Thanks all,
Jeff
