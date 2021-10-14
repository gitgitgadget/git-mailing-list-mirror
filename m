Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A3C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00BCD6101D
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 16:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhJNQ4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhJNQ4H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 12:56:07 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE31C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 09:54:01 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id r15so6033835qkp.8
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a2JKZ3EaiWnBGsQ2cXinfvC1CCcAgluJ9SKhL/3+YrU=;
        b=PeQVey82j95JvckgeV2upFgtYmEUW+nu8JZisRlTwP5sp2m25Vs7gq9hpiV7Ho8Zzi
         gz7vcjQJ9uEhOV6iNBeKOKiXDb2wTl9nRClhLeUu6FmPm0xJAzlQnuOq06+rwtHibSE4
         CwpjwafNe1Q663QYKCeh+v644v/KzgfzKlyx+zFeo/I7aJY6Vi/dMsZjM6rSTOd/XIN7
         yAv/JLK2sdKgQeMdZki76QHysuARZjgjor8rxhjgG2liHLV+mULlim/N0HYeEo6xPgQj
         Lo2WTsUahlymIaXWw2Utmg0Wwc3rF6t7t5r35FCE1U/qt24p3g9DzjGOaQu91rJtZvbu
         IrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a2JKZ3EaiWnBGsQ2cXinfvC1CCcAgluJ9SKhL/3+YrU=;
        b=wuzHOSIcJjP08AfT8D17JSezye0dE+MBmUVuA/tSpeBQJUajScFt/VqZQtEjLs48oM
         l7syZeG8dRF5/lmFDAzzvv2dyPb1URIhuodQf4JkgCQWH8KZgisNmM8n5XCRoYr+OWHm
         6c2c5KYg68b8eo3e6BSMmz1tYV9qHFFdUc71wKEo0R1HJZqTAnIit9NjA/xgqSlbaOkF
         5rU29wZjOpEV15w9842a28+XjT+G1Y9SN8KbBljVunttp5vf+BbkajmGDCLWyPHPlK2R
         7qGw1xtSyi4E7HCiIS+xDxoRk7g1Kkrp3fvMEqkOI/g5d5CrmsnyzP81FebLFWu+5oPR
         hNsA==
X-Gm-Message-State: AOAM532mlGmrfg16Nf5pCae+uCQPNzMWSM0x/d/dHh3tP0xC+62mZSEE
        uw43yKgZqge4h4YyJ3fw/6A=
X-Google-Smtp-Source: ABdhPJyUWPnonHx9tEept/QzjMz5uL/zKz3wSNtA7NM7IaG5FKUCTPLfHCRZyYmQMF92ZtBX7f5lQg==
X-Received: by 2002:a37:61c8:: with SMTP id v191mr5561164qkb.379.1634230440926;
        Thu, 14 Oct 2021 09:54:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:254d:795e:811:9a2c? ([2600:1700:e72:80a0:254d:795e:811:9a2c])
        by smtp.gmail.com with ESMTPSA id x10sm1611478qtm.19.2021.10.14.09.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 09:54:00 -0700 (PDT)
Message-ID: <d553054f-a484-ba34-ef3b-1e6778211a47@gmail.com>
Date:   Thu, 14 Oct 2021 12:53:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 0/3] Use default values from settings instead of config
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <20211005001931.13932-1-chooglen@google.com>
 <20211012174208.95161-1-chooglen@google.com>
 <87wnmihswp.fsf@evledraar.gmail.com>
 <02947b5e-7ce3-4760-0d27-621c7362f839@gmail.com>
 <87pms8hq4s.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <87pms8hq4s.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2021 11:57 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 13 2021, Derrick Stolee wrote:
> 
>> On 10/12/2021 4:34 PM, Ævar Arnfjörð Bjarmason wrote:...
>>> If I comment yout your addition of GIT_TEST_COMMIT_GRAPH=0 in that file
>>> I see that we fail N number of tests, but all of them are actually
>>> fallout of just this test:
>>>
>>>         git replace $head_parent $head && 
>>>         git replace -f $tree $blob 
>>>
>>> I.e. we've created a replacement object replacing a tree with a blob, as
>>> part of tests I added to test how mktag handles those sorts of weird
>>> edge cases.
>>>
>>> This then causes the graph verify code to throw a hissy fit with:
>>>
>>>     root tree OID for commit 0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 in
>>>     commit-graph is da5497437fd67ca928333aab79c4b4b55036ea66 !=
>>>     0fbca9850869684085d654f9e1380c9780802570
>>>
>>> I.e. when we wrote the graph we somehow didn't notice that the root tree
>>> node we wrote is to an object that's not actually a tree? Isn't this a
>>> bug where some part of the commit graph writing should be doing its own
>>> extended OID lookup that's replacement-object aware, it didn't, and we
>>> wrote a corrupt graph as a result?
>>>
>>> If there is a legitimate reason why we're not just hiding a bug we've
>>> turned up with these fixes let's disable that one test, not the entire
>>> test file.
>>
>> The commit-graph should be disabled if replace-objects are enabled. If
>> there is a bug being introduced here it is because the commit-graph is
>> being checked during fsck even though it would never be read when the
>> replace-objects exist.
>>
>> Thanks,
>> -Stolee
> 
> Thanks, isn't the obvious fix for this to extend your d6538246d3d
> (commit-graph: not compatible with replace objects, 2018-08-20) to do
> "read_replace_refs = 0;" in graph_verify()? That works for me on this
> case.

Ignoring the replace refs while verifying will allow you to verify the
on-disk commit-graph file without issue.
 
> I.e. if we ignore replace refs when writing the graph, and we don't use
> it if there are any due to commit_graph_compatible(), why would we
> consider them when verifying it?

I generally consider any interaction with the commit-graph while
replace refs are enabled to be the bug. We don't read the commit-graph
when replace refs are on, so why are we verifying it?

But, I understand the desire to check the on-disk content even though
it is not being used, so disabling replace refs to do the verify should
be sufficient.

Thanks,
-Stolee

