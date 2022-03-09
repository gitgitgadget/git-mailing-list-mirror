Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00E0C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiCITjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbiCITju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:39:50 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A96D7678
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:38:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s10so4296501edd.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=edJGVHDbqPTqp+bIAMZAK44G3Wt9XvFvKyOhDAK6rp0=;
        b=IphP8X3FlMb74BNHTfiAkfdMwCPRNXZSeqpNamJqwePERg+l39k/wwOc/UL5iSVKBX
         HIcURSGB5JSBE6t1zLdZXgKNPrrZc8jAJDA4luj58W3guFJj4Mne5Aur30rcPDZnHNvv
         KrBsZvTpN4rUTOc9DK0yira465q6S1AAr+j7PcZjHaUwFZpjAGpMRiuDGpZuEo6uoLw5
         /gOLiRCFh4lP2ex+wjDjeZaixUGAg1gHXw/eZNJhust0+Q4nQdjWzd1izIrAOF7vvq+l
         drYo354PhgxbamOxMAXwMz76cjFDIBgZcJxQSz44PFzIRQ2fWEMW80VTHduObr7fAJCH
         sJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=edJGVHDbqPTqp+bIAMZAK44G3Wt9XvFvKyOhDAK6rp0=;
        b=7C0ITUJFo9HB9fz5Z+u1nF5QfHegzJMrdalW+wxSGAhskvT7F8NAjOQ+wVSMR06N6h
         9mhMgf0u9BFnEofcpgTWT9Q/XpSEBuj8L5jbQZ3rwqGwuz8IfV3UUcGQ1Xq+bwOgg0/P
         Su0C5otEi+ZWAJDr+j95QkS2lHRJOJUbcI4mFc/oHqgLW7gOiE/KD4e+alUBOmECxXPK
         XV+OFpPx0muJBspT5YyUAwCf+XKvbwq9ZxGkfCfZ/cRBEk3C2s4ibRnBUS6f1BagNdYF
         fZ3RblwqaTtHBeadvAWAtwMO/LJMSykmW9pBwSaJgvu9/ZEQMLXSx2QDzRIr9V6S8Y1y
         QxOQ==
X-Gm-Message-State: AOAM531gdhgW56rlBLCLlbi2jdW13hAQugrMno58Pwye6ijpMPsXjDFS
        x3Wd3Q9dK4loLlxUmG9BVVc=
X-Google-Smtp-Source: ABdhPJxFNsobEg7zpQbhpfPqM1b+f6fdE1GngdcInCw6k7o1iB0vIMMU0hW0S6H01Bv2fqh0lmnXVw==
X-Received: by 2002:a05:6402:51d2:b0:415:c171:346c with SMTP id r18-20020a05640251d200b00415c171346cmr1012182edd.19.1646854729457;
        Wed, 09 Mar 2022 11:38:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bw26-20020a170906c1da00b006c8aeca8febsm1078561ejb.47.2022.03.09.11.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:38:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nS292-000Did-1y;
        Wed, 09 Mar 2022 20:38:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
Date:   Wed, 09 Mar 2022 20:37:32 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
 <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
 <1a060357-3296-81d5-bf23-a55263ef6d10@jeffhostetler.com>
 <xmqqk0d3kl73.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqk0d3kl73.fsf@gitster.g>
Message-ID: <220309.8635jqncfr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Junio C Hamano wrote:

> Jeff Hostetler <git@jeffhostetler.com> writes:
>
>> On 3/7/22 5:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
>>>=20
>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>> [...]
>> [...]
>>
>> =C3=86var sent feedback (thanks!) on 8 commits in the V6 version
>> on March 7.  I started responding to each as I got to them
>> in my inbox yesterday, but I'd like to take a break from
>> responding individually to each of them inside of Part 2.
>>
>> Since most of the feedback is for "general cleanup" and since
>> Part 2 V6 is already in "next", I'd like to revisit these
>> issues with a few "cleanup" commits on top of Part 3 (which
>> is still in active review), rather than re-rolling or
>> appending "fixup" commits onto Part 2.
>
> Sounds good.  Prepending "preliminary clean-up" before part 3 would
> be even cleaner, I would suspect.
>
> In any case, let's consider part 2 "more or less done" unless we see
> a glaring mistake that requires us to revert and redo it from
> scratch.

Sounds good, my comments on v6 today were before I'd noticed that it was
in "next", I think all of those can (well, it would be that way either
way at this point...) be left for some potential follow-up.

Thanks both, especially Jeff for sticking with this fsmonitor topic for
so long & keeping it advancing.
