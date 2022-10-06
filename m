Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508AAC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 16:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJFQ2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiJFQ2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 12:28:08 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8106024BCC
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 09:28:04 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 889DECA1264;
        Thu,  6 Oct 2022 12:28:03 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4E2FFCC8326;
        Thu,  6 Oct 2022 12:28:03 -0400 (EDT)
Subject: Re: [PATCH 6/9] trace2: convert ctx.thread_name to flex array
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
 <6492b6d2b989e08bb539fff3ffe5bdf50fa0a195.1664900407.git.gitgitgadget@gmail.com>
 <221005.86y1tus9ps.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0a4e7f45-6697-2b75-005e-676e9ba444ab@jeffhostetler.com>
Date:   Thu, 6 Oct 2022 12:28:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <221005.86y1tus9ps.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/5/22 7:14 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Oct 04 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Convert the `tr2tls_thread_ctx.thread_name` field from a `strbuf`
>> to a "flex array" at the end of the context structure.
>>
>> The `thread_name` field is a constant string that is constructed when
>> the context is created.  Using a (non-const) `strbuf` structure for it
>> caused some confusion in the past because it implied that someone
>> could rename a thread after it was created.
> 
> I think it's been long enough that we could use a reminder about the
> "some confusion", i.e. if it was a bug report or something else.
> 
>> That usage was not intended.  Changing it to a "flex array" will
>> hopefully make the intent more clear.
> 
> I see we had some back & forth back in the original submission, although
> honestly I skimmed this this time around, had forgetten about that, and
> had this pop out at me, and then found my earlier comments.
> 
> I see that exchange didn't end as well as I'd hoped[1], and hopefully we
> can avoid that here. So having looked at this with fresh eyes maybe
> these comments/questions help:

Yeah, those conversations went rather poorly.  And yes, I'd like to
avoid all of that.  There's a lot in your note here and it'll take a
little while to digest and respond.  But I did want to ACK, sooner
rather than later, that we agree on that.

And yes, I could split out the truncation into a separate commit.
And then revisit the storage change.

Thanks
Jeff

