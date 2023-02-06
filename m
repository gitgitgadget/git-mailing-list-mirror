Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3784FC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 14:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjBFOrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjBFOrA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 09:47:00 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B702529C
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 06:46:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y1so10611176wru.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHtCgKwASEm3QUPpV2LogvHmVxSOId2e4+K6wvM1clQ=;
        b=g16DbV33D8aX1x0pv7y8qRXYzngV3uKLk9hEcVfzdPrviqfj7og5kEpVNiIA0hzSuN
         YpA3TWgaLQU5iAoCHGluol+FRKXMAjaC75cThUZWVeOGurJH5Usna0TfXJugr9kfUyNc
         o+K8/zpfdCx5MMVh7MvP694QgzurZRqkLZZCOPTad+G2rg0zBQLSxevSDSuiV43jUb1Z
         cQVgCrXP0LMfWtoqK61CQ0EZTtEN7iMMhuQsWYCFokK0JZrio9O00RE8yNpW1yTaQxwk
         5AR0fwRJgUKq/59me9npx5CUBpaP8mFUJvYgn1WrNo6NoMjFh5D9/WvM62fHpt4AjIlR
         eJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHtCgKwASEm3QUPpV2LogvHmVxSOId2e4+K6wvM1clQ=;
        b=r2jZrGV22YPrtyOLqMOlQ4GqlJYDYE2gqe6vYOuwOMvmKL8YZHRwpvBCa427T/huBp
         keKWlK6JYKiN14h8ABeq0obTzxoGEQzJKUoQF8VZtGI/E+Nvse7cDuG8ONHXcqcDXhx3
         OQH+JBvK3RoNqyjI+AYPO853Rxh8XH0KH+8EjFnP9x3KT0ws1YpHj2BuxzunZxoql3Sj
         eDR69el2iyg2j2OksP1Whw8u5eCQ82N6uEK8evNfzKDMBNY5xLaPCE/70EsRTrRX8iFl
         sc/DXw8DisFnx1cywtZ768VHFfGcRHD6NHvpDstgVi+jMrULMsHQFzhVWo8ui+KKz5nZ
         LJsA==
X-Gm-Message-State: AO0yUKVIRjOuEGRHoKWg3xT8xchPY7LvmzUmX4KpONoOFgLMXiMsNHhq
        cYEl5wzPQpTUji+AHqWtBlU=
X-Google-Smtp-Source: AK7set+iii1Ey7O9f/Vh21MuJuJe2X7ObjjCyDtF5EBoUc1QRlCYzPE+O56fqIxFOG/b04PRMig8xw==
X-Received: by 2002:a05:6000:809:b0:2bf:b710:5760 with SMTP id bt9-20020a056000080900b002bfb7105760mr10734077wrb.69.1675694817454;
        Mon, 06 Feb 2023 06:46:57 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id i3-20020a5d5223000000b002bfae1398bbsm9012869wra.42.2023.02.06.06.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:46:57 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <b24fc8ae-a9f8-868f-b281-74c256447084@dunelm.org.uk>
Date:   Mon, 6 Feb 2023 14:46:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/9] git archive: use gzip again by default, document
 output stabilty
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
 <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
 <771a98ca-9540-ad4e-dfba-9d304e1dff09@dunelm.org.uk>
 <230203.86fsbmbzwp.gmgdl@evledraar.gmail.com>
In-Reply-To: <230203.86fsbmbzwp.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02/2023 13:49, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Feb 02 2023, Phillip Wood wrote: >> Reverting the change gives the misleading impression that we're making
>> a commitment to keeping the output stable.
> 
> I don't see how you can conclude that from this series. It explicitly
> states that we make no such promises, what it does is go back to
> allowing the gzip(1) command to make its own promises.

This series would not be happening if we were not reverting a change to 
the compressed output of 'git archive'. The documentation updates are 
very welcome but I think we're undermining the message that the 
compressed output can change by reverting that change.

>> The focus of this thread seems to be the
>> problems relating to github which they have already addressed.
> 
> Which they've addressed by reverting the change, but while they're a
> major user of git they're not the only one. They just happened to use
> "git archive".
> 
> I think it would be a mistake to conclude that everyone who's run into
> this has already done so, or is aware of it.

I've spent some time trying to find reports of problems caused by this 
change and have not seen anything apart from the issue with GitHub. 
Although it takes a while for new versions of git to get into linux 
distributions if there is a widespread problem we normally hear about it 
pretty quickly. This change has been in two releases now. If anyone does 
have a problem there is an easy fix in the form of setting 
tar.<format>.command

>> I think there is general agreement that it is not practical to promise
>> that the compressed output of "git archive" is stable so maybe it is
>> better[...]
> 
> ...better than what? This seems to imply that this series is making new
> promises about the output stability, which it isn't doing.

It's better people realize they cannot rely on the output being stable 
now when they can safely work around the problem while working on a 
proper fix rather than waiting until the change in output is caused by a 
security issue in gzip which means the work around is no longer safe.

Best Wishes

Phillip

>> [...]to make that clear now while users can work around it in the
>> short term with a config setting rather than waiting until we're faced
>> with some security or other issue that forces a change to the output
>> which users cannot work around so easily.
> 
> I think it's always been clear that you can use that setting. For ages
> we've been saying:
> 
> 	The `tar.gz` and `tgz` formats are defined automatically and use the
> 	command `gzip -cn` by default.
> 
> Then v2.38.0 changed it to:
> 
> 	[...]
>          magic command `git archive gzip` by default
> 
> Which IMO was easily missed among other "Performance, Internal
> Implementation, Development Support etc." items in the release notes,
> which said:
> 
>     Teach "git archive" to (optionally and then by default) avoid
>     spawning an external "gzip" process when creating ".tar.gz" (and
>     ".tgz") archives.
> 
> But I agree that all of this is subjective. To me a 2% reduction in CPU
> use (at the cost of ~20% increse in wallclock) & some unclear benefits
> to teaching users that they can't rely on our "gzip" output seems
> unclear or hypothetical.
> 
> Whereas the widespread breakage reported is very real,

where are the reports of widespread berakage outside of GitHub?

> and we should
> consider GitHub as a canary for that, not the the stand & end of its
> potential impact.
> 
> As we didn't have a strong reason to change this in the first place (and
> as my series shows, we can have our cake & eat it too if we don't have a
> "gzip") I think the obvious choice is to go back to using "gzip".
