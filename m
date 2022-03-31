Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB56C433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 10:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiCaKZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiCaKZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 06:25:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508741042B9
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:23:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r13so33043007wrr.9
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3EFQ0HQ7oJbVwvsTxMLy6oOjSn0sGcSirHA0vgwlmlQ=;
        b=WcAPRshYnU3ZuZb4oGxLfwm7Zf8BHqaMSX2DHl3Yt4t4RYrP6vNECAzz7u7FsLuSeE
         gbIHLjabImvbOFnDwTNMR26CdRyafx9HP2eX0xYS+vP/nyMehsV2T8wTN8NyqmVVDiIs
         wMzH/YnirhwQks/TkJHHrGOkrJE+vTcOtB03sBUpihal9Hfrhv2Bw1EdZu3DbeqdztWZ
         MI1mU27BBQJ5eFAOHHh+uBllBne67Ia24Qk3j9Dod5ZGjD7/stVSHaUbshFo7xLvZF05
         w+LH8GXGVU3BJw+HQlc2bpTWWVZgCz461Ye1ATUMR2h3TZonK/SGhJJTWZKpPHzD70tz
         Gkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3EFQ0HQ7oJbVwvsTxMLy6oOjSn0sGcSirHA0vgwlmlQ=;
        b=DRUOkjmxDXSy8CatpkrBFLe6C/1Y1wBbafeGUE427WEQTrinUgwSXdtusuyfQSYuH6
         o1UOr5Otgu7AO5avfC5NKEobhFRH5Drx+XG0c7cZJabuWnU8ZoYuhC+d2d4cID+2Qc+j
         tbAvrGgs5Eyjntj5uACZoR6J8gDT1W8oq4Y5LWz9RsAJlEf6AMMxc0CZUXFHFEwVUhHC
         L0kZICyfaDslD3FH8ia/y/+FEjDTqujRjeNrrSWCk4cYcQHWfOmwLNHLKokOXFrUnZt+
         NggnsswMWwMgga2GOK5vffr7UsxddYWJy9/0sudapsc/QoOOfU2WKMEf0B79OXfD/cQs
         RKBg==
X-Gm-Message-State: AOAM5323XhvmzdSlT2FvABSsMo5OEfk0VnyLlFr81acLnHZ1TwagyAV/
        QkNda0i0VV1uARQMpzn02Rw=
X-Google-Smtp-Source: ABdhPJxpo8O0m07qZz1A6NhkJ7yhVmgqGY81hId7LNU5e3EUrsAfZ19dxidsnk1ylBl+egflujxc3A==
X-Received: by 2002:adf:e181:0:b0:203:f0cc:da0c with SMTP id az1-20020adfe181000000b00203f0ccda0cmr3769823wrb.668.1648722203732;
        Thu, 31 Mar 2022 03:23:23 -0700 (PDT)
Received: from [192.168.1.201] (179.2.7.51.dyn.plus.net. [51.7.2.179])
        by smtp.googlemail.com with ESMTPSA id g10-20020a5d46ca000000b00203fd86e198sm19029885wrs.96.2022.03.31.03.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 03:23:23 -0700 (PDT)
Message-ID: <45c963da-19a5-de51-34d4-5b29f461c9ec@gmail.com>
Date:   Thu, 31 Mar 2022 11:23:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 7/7] git-sh-setup: don't mark trees not used in-tree
 for i18n
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
 <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
 <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
 <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
 <220327.8635j3fx3t.gmgdl@evledraar.gmail.com>
 <63bf6e97-1dca-c2b1-5673-301039e73acf@kdbg.org>
 <220328.86lewudzw3.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220328.86lewudzw3.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 28/03/2022 13:16, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 28 2022, Johannes Sixt wrote:
> 
>> Am 27.03.22 um 13:15 schrieb Ævar Arnfjörð Bjarmason:
>>>
>>> On Sun, Mar 27 2022, Johannes Sixt wrote:
>>>
>>>> Am 26.03.22 um 18:14 schrieb Ævar Arnfjörð Bjarmason:
>>>>> Partially revert d323c6b6410 (i18n: git-sh-setup.sh: mark strings for
>>>>> translation, 2016-06-17).
>>>>>
>>>>> These strings are no longer used in-tree, and we shouldn't be wasting
>>>>> translator time on them for the benefit of a hypothetical out-of-tree
>>>>> user of git-sh-setup.sh.

The out of tree users of git-sh-setup.sh are not hypothetical, they 
exist and objected when you recently tried to remove these functions 
entirely[1].

>>>> There is public documentation for these functions. Hence, you must
>>>> assume that they are used in scripts outside of Git. Castrating their
>>>> functionality like this patch does is unacceptable.
>>>
>>> For require_clean_work_tree() the public documentation for this function
>>> states that it will emit a specific error message in English, and you're
>>> expected to Lego-interpolate a string that we'll concatenate with it:

The documentation does not say whether the message is translated or not, 
probably because it was not updated when the translations were added six 
years ago.

>>> 	[...]It emits an error message of the form `Cannot
>>>          <action>: <reason>. <hint>`, and dies.  Example:

This is not a promising a "specific error message in English"

>>> 	+
>>> 	----------------
>>> 	require_clean_work_tree rebase "Please commit or stash them."

This is an example message you cannot use that to argue that we will 
always show a message in English

>>> So I think that marking it for translation like this as d323c6b6410 was
>>> always broken in that it broke that documented promise.
>>
>> I can buy this argument. But then this must be a separate commit with
>> this justification.
> 
> Sure, I can elaborate on that point & split it up.
> 
>>> But that's just an argument for keeping the require_clean_work_tree()
>>> part of this patch, not require_work_tree_exists().
>>>
>>> For that one and others in git-sh-setup we've never said that we'd
>>> provide these translated (and to the extent we've implied anything about
>>> the rest, have strongly implied the opposite with
>>> require_clean_work_tree()'s docs).
>>>
>>> Nothing will break for out-of-tree users as a result of this
>>> change.

The strings the user sees will change

>>> When we added these functions and their documentation their
>>> output wouldn't be translated,

Where does the documentation say "the output will not be translated"?

>>> then sometimes it was, now it's not
>>> again.
>>
>> This does not sound convincing at all, but rather like "I want the code
>> to be so, and here is some handwaving to justify it". What is wrong with
>> the status quo?
> 
> The larger context for why I was looking at this again is that I'm
> trying to slowly get us to the point where we can remove the
> i18n-in-shellscript entirtely.
> 
> But I thought that was a rather large digression for the commit message,
> and that these being both unused, and not something the "public" API
> affected ever promised it would do was sufficient.

I think if that is what you want to do then you should propose a series 
that does just that and explains why it is desirable, rather than coming 
up with other reasons to justify the changes you want.

>>> We need also need to be mindful of translator time, it's a *lot* of
>>> strings to go through, and e.g. I've commented in the past on patches
>>> that marked stuff in t/helper/ for translation.
>>
>> Translator's time is your concern? No translator sifts through 5000
>> strings on every release. There are tools that show only new strings to
>> translate.
> 
> Yes, I'm the person who added this entire i18n infrastructure to git, I
> know how it works :)
> 
>> A text is translated once and then it lies under the radar
>> until someone changes it. Don't tell me that is time-consuming.
> 
> Yes, individual orphaned strings aren't, but they add up.
> 
> Just like having that "USE_PIC" comment in configure.ac isn't much of a
> big deal, but it makes sense to clean up unused code, just as we're
> adding new code.
> 
> I will say that your implicit proposal of keeping this forever instead
> is assuming that we won't have more translations for git, and every new
> translator will look at this.
> 
> Context is critical for translators, so even if it's one string it's a
> string you'll quickly grep for and find ... no uses for, and then likely
> go hunting around for where it's used only to (hopefully, in that case)
> find this thread. Better not to have it.
> 
>> On the other hand, there is a lot of *reviewer* time that you are
>> spending with changes like this. *That* should be your concern.
> 
> I'd think most of the that time, if any, will be spent on this
> sub-thread you started, so ... :)

This sub-tread exists because you posted this patch to the mailing list. 
Blaming reviewers for asking perfectly reasonable questions is neither 
fair nor helpful.

This patch does not remove dead code as the rest of the series does but 
instead changes user facing messages in code that we recently 
established is part of the public api[2]. Nothing has changed since that 
recent discussion so I'm confused as to why you are proposing to modify 
the api again so soon.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/CAJm9OHfN9iXDt-rzu-wb=67y4PPpmCUgMfmZPy1JMBJkHG256g@mail.gmail.com/
[2] https://lore.kernel.org/git/xmqq5yvik8bc.fsf@gitster.g/

> Which isn't to say it shouldn't have been brought up, but from my
> perspective I was (and still am) making a rather small change that I
> think won't harm anyone in practice, and gives us some incremental
> tidyness & contributes to an eventual large "git rm git-sh-i18n.sh" et
> al.
> 
> But on reflection I don't think it's worth worrying about, and we can
> just do this change.
> 

