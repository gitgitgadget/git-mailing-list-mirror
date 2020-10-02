Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA747C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 19:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72AE206DD
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 19:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdTOVqHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgJBTra (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 15:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBTra (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 15:47:30 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B71C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 12:47:30 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 60so2552910otw.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 12:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ytKddrESa5PINK63F2heyYrgxkL4pC3XwHUQwJin1mc=;
        b=PdTOVqHOZ0wO7k54cNu4x+oQdTjwAx5CsNpxVzu0di53BXuTARLeHRjupaGnsmzkJM
         r6qf6zTf19oYMNPkI8/Ajx+5via0SVS9xMf+kG2ExTQ2AzuVDVGOUumN3VNRiw21O3Tx
         y3sj4xwv4iexn5okiQma3nyP8tclEqMRpRq7JDnjLf8aopgKTDVCsZVEYCc/s9pgY7k9
         O5KCaGC2MSUs3OxgHOyGX387ULIdSntIcTPZ0fB0s0+wod1mrkrfsWgPTqorEc9VGEwz
         SoFSU6o6+SM3m1x6/P7216hdBP/RCZ1hlQhm2JGdYRS1FqyoNEYW4TBErdI711mfsrum
         wzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ytKddrESa5PINK63F2heyYrgxkL4pC3XwHUQwJin1mc=;
        b=P+D2k0N6hjfX9EObr1G3fJgU6A0stKCufT5LSLsZg/18kAUlBW9am5Gxu/15wa2zuR
         2shtwsijSeQZ9YkTcxNQ03UXZOXLSjEKAyPzZkJjMjrC9d39jCW+B9ayL/663NWVcH3r
         d2S20Q1YRG9q6U/EpJEmnSbiNk1nry84ckVUPVeZwMipMeAuNwganN37EAMAjeSDt4Ee
         5TubYi+14DMieteRtjz7tHIh0LbwUnbwsl92t3A5rIt9KXjCFL1euTITFq8mCwjIqrU5
         65GgmqNILWEamTm9crgsk7vgBFDAc9CvReIbgraXVzutjH3T8lrnzrdiMcj46DfuhjS7
         pcyw==
X-Gm-Message-State: AOAM5313fmiUhtzsRjVLW3IG+D8gsNd8PrxLtHwtSsv7Y6JPNVRttrK/
        yCz+6ZxJKJfZ8RIALdYu4IU=
X-Google-Smtp-Source: ABdhPJwSNc9JoX35yJz7qBZhnMZ/lQwOJDZQdwJ8b9qoQebIFWGRq377USwjpPV2j/mLMRgiTCdN9A==
X-Received: by 2002:a05:6830:2436:: with SMTP id k22mr1360479ots.185.1601668049612;
        Fri, 02 Oct 2020 12:47:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bd7f:7189:ff7:ce98? ([2600:1700:e72:80a0:bd7f:7189:ff7:ce98])
        by smtp.gmail.com with UTF8SMTPSA id l15sm483624oil.24.2020.10.02.12.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 12:47:29 -0700 (PDT)
Subject: Re: [PATCH] commit-reach: fix in_merge_bases_many bug
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.739.git.1601650736489.gitgitgadget@gmail.com>
 <xmqqv9fs8nre.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c6b163dd-d5f4-73a8-43ac-22460d1079ec@gmail.com>
Date:   Fri, 2 Oct 2020 15:47:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9fs8nre.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/2/2020 2:51 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> The fix itself is to swap min_generation with a max_generation in
>> repo_in_merge_bases_many().
>>
>> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Reported-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> 
> The order of these looked iffy so I rearranged them in chrono order,
> Srinidhi's series found it broken, and with Dscho's help, fix was
> produced and you sent it with your sign off.

Sure. I can agree with that chronological order and will keep
that in mind for next time.

>>  commit-reach.c        |  8 ++++----
>>  t/helper/test-reach.c |  2 ++
>>  t/t6600-test-reach.sh | 30 ++++++++++++++++++++++++++++++
>>  3 files changed, 36 insertions(+), 4 deletions(-)
> 
> I've applied this and then rebased Srinidhi's latest on top, with
> the following to re-enable the commit-graph in the codepath.  t5533
> and t6600 passes and when the fix in the message I am responding to
> is reverted, t5533 again fails.
> 
> Thanks.

Thanks for double-checking. I also think that dropping the
"hide the error" patch is prudent.

Thanks,
-Stolee
