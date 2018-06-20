Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804771F403
	for <e@80x24.org>; Wed, 20 Jun 2018 16:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932599AbeFTQjd (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 12:39:33 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35411 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932232AbeFTQjb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 12:39:31 -0400
Received: by mail-qk0-f195.google.com with SMTP id d130-v6so117532qkc.2
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dBmSBTHoc6LDuzFzDSkieQwbagrFbHlP3YpfPF4e0fw=;
        b=uao4sUijXUisMQ6zWHSSTrzqxfZ9Y7DhZmk63WybhmUJl3XiRLfQYdYcBT94AXJD+i
         pWbtKFe6nQxkF0H98ZZQMwsIAGcglH4A40Utq75dv9YA4F+rtWHn+ulG/g6dmcvRJXG+
         blPh7Dt5Bim0H4BAY7qql6mdPuhsWOZYK6LeKmuKazWo8rNsFjSAYe1bl4pvt5XyuJCz
         8O599maAAGFP7f/nDK3IYaXe1XO5AfaB/fiAN4NXeBXfPTpROFhcUElyOpFr69FlR3Wj
         /1jNChZIQzZVvoEGR9nb2LQWGKfM+MBKcx5u5WEK9QC8gA+ClvTP5OSoPXH/Cxqw3s/8
         iM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dBmSBTHoc6LDuzFzDSkieQwbagrFbHlP3YpfPF4e0fw=;
        b=knAiXjXbz1qJksJVW4c6bJmXlppfoswKL99XHzDoCYHLf1ElT8Cl1TEH5KPx3FXrc1
         2mIEKMAPgzGEB0WdlUxOdkL4oysRDSkNUrGM+/dO7jzan8KD1igiFOPY9deSo8vgl6CC
         8uF9JBW/1Uzd3H1N0C1BpKP6BvCY7QsSyQ8fMV9sWN+mOWz7IeQx5hB/a+S4J8vjp0fF
         OmyRUSwQ8dFbYT7TkpKTbnaUv3Ek7HhCeWPVj9ZrYK6xz3gFGp3laZ6CcLGW6JVqGu9p
         mIZUzi+YcRrDQB9ecApGVGdoqTs7mRsCNejWTg4WuDskkQgVcFaGrClkaJPcFGJThRQb
         lXJg==
X-Gm-Message-State: APt69E0MM6fTboa3kXPQiGZSzQ+FwXSoaSxBsQU8Vr8hG7Xtn636/EpF
        h/kS3Ydl0fUDbuCEHPlNB8M=
X-Google-Smtp-Source: ADUXVKL3ntkhtUmDqAFxgW6yPWPscZH+FObApsUC3K8jcYRDx2M8o6VREAGDXkDUL6PUdxvp7CnNzg==
X-Received: by 2002:a37:ab04:: with SMTP id u4-v6mr17520193qke.92.1529512770993;
        Wed, 20 Jun 2018 09:39:30 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:111c:d99:f232:cfaa? ([2001:4898:8010:0:fa51:d99:f232:cfaa])
        by smtp.gmail.com with ESMTPSA id s39-v6sm2202191qts.42.2018.06.20.09.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 09:39:30 -0700 (PDT)
Subject: Re: [PATCH 06/23] midx: struct midxed_git and 'read' subcommand
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-7-dstolee@microsoft.com>
 <CACsJy8DG1-YTSBSFkpM8BPcnKmvC-BjjK0W0+EckkdENPC7Ohg@mail.gmail.com>
 <2906e8e8-ca32-828f-e8d0-35b0dff7db81@gmail.com>
 <CACsJy8B4HBrbuog-38o4YA2dKSQejhd4LOQn4+nswi=Wnod-iQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4baf0a39-36ec-56b1-2cc4-400128324c4a@gmail.com>
Date:   Wed, 20 Jun 2018 12:39:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8B4HBrbuog-38o4YA2dKSQejhd4LOQn4+nswi=Wnod-iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/2018 11:07 AM, Duy Nguyen wrote:
> On Wed, Jun 20, 2018 at 3:33 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 6/7/2018 2:31 PM, Duy Nguyen wrote:
>>> On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
>>>> diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
>>>> index dcaeb1a91b..919283fdd8 100644
>>>> --- a/Documentation/git-midx.txt
>>>> +++ b/Documentation/git-midx.txt
>>>> @@ -23,6 +23,11 @@ OPTIONS
>>>>           <dir>/packs/multi-pack-index for the current MIDX file, and
>>>>           <dir>/packs for the pack-files to index.
>>>>
>>>> +read::
>>>> +       When given as the verb, read the current MIDX file and output
>>>> +       basic information about its contents. Used for debugging
>>>> +       purposes only.
>>> On second thought. If you just need a temporary debugging interface,
>>> adding a program in t/helper may be a better option. In the end we
>>> might still need 'read' to dump a file out, but we should have some
>>> stable output format (and json might be a good choice).
>> My intention with this 'read' pattern in the MIDX (and commit-graph) is
>> two-fold:
>>
>> 1. We can test that we are writing the correct data in our test suite. A
>> test-tool builtin would suffice for this purpose.
>>
>> 2. We can help trouble-shoot users who may be having trouble with their
>> MIDX files. Having the subcommand in a plumbing command allows us to do
>> this in the shipped versions of Git.
>>
>> Maybe this second purpose isn't enough to justify the feature in Git and
>> we should move this to the test-tool, especially with the 'verify' mode
>> coming in a second series. Note that a 'verify' mode doesn't satisfy
>> item (1).
> Yeah I think normally we just have some "fsck" thing to verify when
> things go bad. If you need more than that I think you just ask the
> user to send the .midx to you (with full understanding of potentially
> revealing confidential info and stuff). It'll be faster than
> instructing them to "run this command", "ok, run another command"....
> I thought of suggesting a command to dump the midx file in readable
> form (like json), but I think if fsck fails then chances of that
> command successfully dumping may be very low.
>
> Either way, if the command is meant for troubleshooting, I think it
> should be added at the end when the whole midx file is implemented and
> understood and we see what we need to troubleshoot. Adding small
> pieces of changes from patch to patch makes it really hard to see if
> it helps troubleshooting at all, it just helps the first purpose.

I'll abandon point (2) for the later 'verify' patch series. Adding the 
test helper early allows tests to demonstrate that each patch does the 
right thing, and that we don't miss testing something.

Thanks,
-Stolee
