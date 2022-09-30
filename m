Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AD8C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 17:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiI3Re5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 13:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiI3Rey (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 13:34:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BE532AA1
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:34:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y8so6880840edc.10
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=WO2OKf7s96W58pdvuqOCIEeXism2cNLHEjml8XhWwBs=;
        b=lj24wtYsmk6bH6ZqPI7Uy8ftb3B5g2VaJs7GUYg3BjCD/dHynWSM/9qjLucJ434+W5
         jXQmfmSePdyBTf/SnFtEt0CgrCVWpWkT8RBB5+6higSXtzgKFFVAjZTY+/ZGMc0+afeh
         ZSG0OYK2I8H9rrNMmUqLWoT1nHme8rreizsWKuAfcVWAFqQZAkIKWYcHADFvd04myeDf
         Kg/Y+clIrz0YkV4RxtuPwThMBwWKfMIfoungMIax0JX9D4adJ0CGc2A5OaiP+e9pfWpq
         OvKvPTSD3tkQzMe9liDmcurIj/z4/+B1sO9urmH3ATqCmt3gXvx4xRhO7ZxImJVQm12a
         KA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=WO2OKf7s96W58pdvuqOCIEeXism2cNLHEjml8XhWwBs=;
        b=Hl6XIqi7KZDm1RA5eObe4jU8P4cP66Nk+TOtvG4IjIGKbZVbC8HCgx6IMZruNpmvu9
         jFvfMttwq9y0e/qJZPQ4Jp9HcOIoo5IBGTfuu6moZuuQa3ewUJy8fOL/hOd0kby8DRrN
         7c1OeLl6U4KHgpOu3ReeknHk2pGheSIS9onAXfPKZrX+tPKfCBCgDGUTd9h0JNZ77JO9
         hrX3b/EHrCW771gzt9M4PRCAmMr+yLbTfZur9vag0fEQrzoNxwTqqDNoRHdJbDsI3+Kd
         G6+BrH3iaxeXOee2kJx3YQa74w9bwqnFwqHWUQaXUjjVyWqj/IPiPVESDK3LTHj6k/cU
         PFXw==
X-Gm-Message-State: ACrzQf1GT23b1YOwKkHAlJ1gbDk6RhnvZLcmoTKGk3NQXiC9o2RjDy1f
        yzBQPY6eIaqrjAk6dc9scNg=
X-Google-Smtp-Source: AMsMyM6nUe53W3jiDs7EFT/BZCGnB15sTrSbV8J7HbMJmqVSvv/JyTqKPk7JSdcZVY8hJ+Uo/4WVMg==
X-Received: by 2002:a05:6402:909:b0:435:a8b:5232 with SMTP id g9-20020a056402090900b004350a8b5232mr8744502edz.240.1664559290634;
        Fri, 30 Sep 2022 10:34:50 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j18-20020a17090623f200b00783f32d7eaesm1455248ejg.164.2022.09.30.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:34:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oeJuR-001n2t-2h;
        Fri, 30 Sep 2022 19:34:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 01/35] CodingGuidelines: update and clarify
 command-line conventions
Date:   Fri, 30 Sep 2022 19:27:54 +0200
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
 <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
 <patch-v2-01.35-aecd3ff41f2-20220928T082458Z-avarab@gmail.com>
 <xmqqpmffv24a.fsf@gitster.g> <xmqqzgegkcwb.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqzgegkcwb.fsf@gitster.g>
Message-ID: <220930.865yh4vk94.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 30 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>>   Optional parts are enclosed in square brackets:
>>> -   [<extra>]
>>> -   (Zero or one <extra>.)
>>> +   [<file>...]
>>> +   (Zero or more of <file>.)
>>
>> OK.
>>
>>> + Use spacing around "|" token(s), but not immediately after opening or
>>> + before closing a [] or () pair:
>>> +   Do: [-q | --quiet]
>>> +   Don't: [-q|--quiet]
>>> +
>>> + Don't use spacing around "|" tokens when they're used to seperate the
>>> + alternate arguments of an option:
>>> +    Do: --track[=3D(direct|inherit)]
>>> +    Don't: --track[=3D(direct | inherit)]
>>> +
>>
>> Hmph, that sounds inconsistent; I would have expected the same use
>> (or omission) of space around the vertical bar.  But if that is the
>> prevailing style, I won't complain about writing it down.
>
> Perhaps in order to avoid "Huh? isn't that inconsistent?" knee-jerk
> reaction, it may be a good idea to explain the reason why?

I have a prepared v3 I was about to submit soon which points to existing
examples in the commit message, namely:

	git grep -E -o '=3D\([^)]+\|[^)]+\)' -- builtin Documentation/

> I am guessing that the difference between the two has something to
> do with the desire to make it compact when it appears as a "value"
> for something (signalled after a "=3D" sign), but (1) I am not sure if
> you share the reasoning, and more importantly (2) I am failing to
> come up with a concise way to phrase it.

I'm afraid mind reading is not one of my many talents :)

I wasn't seeking to come up with some post-hoc rationalization for
these, but just to fill in the gaps in the CodingGuidelines.

Any such guidelines are ultimately rather arbitrary, but I think most
would agree that whatever arbitrary thing we use we should probably pick
one if we can help it.

Which is what this series is aiming to do, i.e. to make these consistent
with the prevailing style, and homogenize the style of the *.txt and -h
version.

I think that's reason enough, i.e. to just decree "this is how it is".

Looking back at history you seem to have had the first commit with this
syntax, with many other people following shortly thereafter:

	git log --reverse -p -G'--.*=3D\([^)]+\|[^)]+\)' --

So if you want a rationale there your guess is probably better than
mine...
