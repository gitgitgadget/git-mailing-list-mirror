Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE9DC47097
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 14:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34585613BA
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 14:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhFCObX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:31:23 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:44846 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhFCObW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 10:31:22 -0400
Received: by mail-wm1-f51.google.com with SMTP id p13-20020a05600c358db029019f44afc845so3818044wmq.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tir52MlPX17xSyX2qj3wnjMpbIlkVplbJi9ZqMS/qjU=;
        b=RK0CktA+YWcYyofCZ00W3d1k7RPg2KnqrkDenmnp76rVf6nBAIu3S8Tp6Qd3/bm7TE
         T3fsrh97YTOufJaIbZwKwa5K6BTU6PTYsUTpiIjmOHDlsMUcAR8HP14E6MDQSAgEwfYo
         lHInFkPQZNgbkMKMhmBzWTINMhQef4e0uGD4hrH01v7EFqMWkxn/prxcq4u7uuCsprFh
         2Ghzgxr/Q2Y3kRRQ3sRizTNmD00+Gc6Pn4t+ZDCj5zTM8hkxhxqCjOCxpBzkZvw3wxfn
         EmgxyL0+7+5XOxfwU1nqCOM9G+nt0mXi+0eeSsH5GjKj+iDqAOuOf2gC4sSiK2Pk4eB9
         6H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Tir52MlPX17xSyX2qj3wnjMpbIlkVplbJi9ZqMS/qjU=;
        b=ioVxlbKu6+DRxHC3qphy2yiz9dM4QVDH9rxA7O6zBni1ufThUmcEUAO7Vw3TX9ucID
         +jVW9NmR547skWOT9ZJmY8i/H8S6SfwTZqtKuOOSIewkNlrYDKdvufZTWdEauPa4SYcX
         4SmGXbQC4n+td1SqpHR/qeSvbTEmLAm+uPZAKFY8VsGxdq74oKpJCAsObBLDCxLNx7Dm
         EypGZpT4M3lTaQPcjkkQCHllLsVQGoOV8fw2g83t8JW+/b5rhLCDBCAqkSFCVcwDpNGM
         Cx0+uXSsZarCNYqDDYmoHBlMhHx9+iqYToI+Z6ZOnfYPyX3sAoknTQC5+fjGrjFUEaV9
         4E4Q==
X-Gm-Message-State: AOAM530CM2G/sSYDxzZPCd6UkFhZqSV5pAwo3+iIV4yOiNrrSxxQgCzO
        7k0DJoKzgzTh4Nm5r4S1L0bSQ3B3KUE=
X-Google-Smtp-Source: ABdhPJxYDI7scX0A6VmCAli0KbYPNUXQmdzuk05feebgdo3duUKNuGZgSJ4V/L2oYtqcLcr8oHROsw==
X-Received: by 2002:a05:600c:4e90:: with SMTP id f16mr33682921wmq.116.1622730517198;
        Thu, 03 Jun 2021 07:28:37 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id l5sm5819625wmi.46.2021.06.03.07.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 07:28:36 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: The git spring cleanup challenge
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87bl8n73om.fsf@evledraar.gmail.com>
 <60b8b882b9dc5_1a0a2d208e9@natae.notmuch>
 <87wnrb5cvl.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <dbbb5a73-12b5-27a1-63d4-eece1e60f57b@gmail.com>
Date:   Thu, 3 Jun 2021 15:28:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <87wnrb5cvl.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 03/06/2021 13:31, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jun 03 2021, Felipe Contreras wrote:
> 
>> Ævar Arnfjörð Bjarmason wrote:
>>> So I skipped the "disable most config", but for what it's worth I think
>>> I'd miss these the most, I couldn't pick just N favorites, sorry:
>>>
>>>   * diff.colorMoved=true: super useful, but I'd be vary of turning it on
>>>     by default in its current form. E.g. on gcc.git's changelog files it
>>>     has really pathological performance characteristics.

Would you be able say a bit more about this so I can try and reproduce 
it please. I'm working on some patches [1] to improve the performance of 
`diff --color-moved` and `diff --color-moved-ws` and it would be good to 
test them on a problematic repo. At the moment I diffing two releases of 
git to test performance on a large diff. I just cloned the last 18 
months of gcc.git and Changelog seems to just be appended to.

>> Very nice! I didn't know about it. I'll pick it for my third day.
> 
> It makes patch review a lot easier, and also integrates nicely with -w.

I find --color-moved-ws=allow-indentation-change helpful as well (it is 
quite a bit slower at the moment but I have some patches to bring it up 
to the speed of the other --color-moved modes.

[1] https://github.com/phillipwood/git/tree/wip/diff-color-moved-tweaks

> [...]
>>>   * commit.verbose=true: so you know what you're looking at in doing in
>>>     "git commit --amend".
>>
>> Aha! My alias had `commit -v` but I would want this on all commit
>> commands.
>>
>> Moreover, I was thinking on suggesting this by default. Who would it
>> hurt?
> 
> E.g. "git rebase -i" with "reword" now becomes a lot more verbose, I
> think it's a feature, but others might disagree.
> 
> It also exposes various edge cases around our parsing of the diff
> v.s. commit message content in our apply.c etc. code, e.g. say you want
> to blindly search-replace "diff" with "difference" in your commit
> messages. You'll now change the "diff --git" line to "difference --git",
> and now "commit" won't detect that it's the patch part anymore, and
> merge that diff into your commit message itself.
> 
> I can't remember if we pick up on "diff --git" exactly, IIRC, but
> anyway, whatever part of the format you need to screw with, the point
> stands. I've run into mistakes like that in the past, one recently made
> it to this ML.

I think the problem occurs if the scissors line gets messed up when 
editing the commit message

>[...] 
>>> I also have a bunch of aliases that would not be useful to a general
>>> audience, but which I find I can't live without, some of the most
>>> commonly used ones:
>>>
>>>      # Log with "less" n/p already going to the next/prev commit
>>>      log-psfd = "!f() { PAGER=\"less -p'^commit'\" git log -p --stat --full-diff $@; }; f"
>>
>> Very neat.
> 
> I think similar to your "git help xyz" patches having coloring, we
> really should consider things like that by default knowing that we're
> invoking "less". I.e. if we got over the notion that our job is just to
> throw data over the wall to "man" or the pager without any further
> tweaking or integration.

Speaking personally it is not that I think that we should just throw 
data over the all to "man" but that if colors are a good idea we should 
be thinking about the whole ecosystem and working with distributions or 
the man authors to ensure all programs and users benefit from it not 
just git.

Best Wishes

Phillip
