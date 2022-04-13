Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D1CC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbiDMTGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbiDMTGj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:06:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E026FF67
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:04:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b24so3555849edu.10
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OvaDBCWbOGUESJ0zU96pQ0l4TEETWdI3d/kiPdWXiAw=;
        b=HB9FP3mq+KbJrefiQ4OgpSjI8ujI6KIA8OWrQ+KdVvuQSOU2LGhVNj4MUciD3lQxC5
         mZD+xc29cii84WQHRkiqLQg3ZGhtRHfwONRL6kRN/P0XDxfRT/5Y25sBrism21Nno8VF
         svh0cqZJwHMUN1SVaxlT0Lkifx2CrDz74raHMJPwlk/MiVNYGvBDBJXk06cTc0thMYWl
         PvjyHOxK/+Os6aSBtRGa9dK3I2+5ODOYvcQ7JvvGGij555VI7CGiTBMtXKDHRrRWowCR
         Md47fY3siM5vCT2Qdoc53j4jyaJb70JkzRQxdsdsVR6maPqkcooz38baqn3Dksn/XjsA
         uHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OvaDBCWbOGUESJ0zU96pQ0l4TEETWdI3d/kiPdWXiAw=;
        b=i1pAQD1OURlAquN5hkDxcezhM2ghAb8Bi0dqfAITf5/NYNUWqce77dMuGUD1CGAAME
         1IlFHBLj8di4Lzf2WeztkuefI2J6hngW1qYcb/bEYCdYxavAi7CaurRlnQ2RwVG8YzyS
         kYm1fuJdIPro3aoIUoBUV+X5PRmaJL1HENWUDP7eUcuWty9EBF1Lk7Ent8iP07adYrb7
         xYC5daTQFzTo4NRhYzWst09GMc7cG41eHIoyVrNopDVrfvksqcpxrz7aVoLbstPUJoZx
         wMG25ill1kmIsoK5NETr2OFZdMeI+vZa6eBYpZq4qNfUTadIMHEYJb0Yipnb+YTCKQ+s
         LtdQ==
X-Gm-Message-State: AOAM532dnpNQXAJb4dalRNvhMudZFpNFuEqRBfePinzpXDbn4hkdke/q
        CnceZ1vQlXhwJ5DKjHzaYAw=
X-Google-Smtp-Source: ABdhPJzlRui4WnrN9qQD9KlFGhrKGyMnVhSDyZQP/FJxmZD8BrXYmvNNiUSfoy5Kl8SjifG78TZN5g==
X-Received: by 2002:a05:6402:209:b0:416:5211:841f with SMTP id t9-20020a056402020900b004165211841fmr46075429edv.59.1649876653551;
        Wed, 13 Apr 2022 12:04:13 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z16-20020a17090665d000b006e8789e8cedsm255267ejn.204.2022.04.13.12.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:04:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neiHk-0059qo-8u;
        Wed, 13 Apr 2022 21:04:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] [RFC] git-p4: improve encoding handling to support
 inconsistent encodings
Date:   Wed, 13 Apr 2022 20:52:34 +0200
References: <pull.1206.git.1649670174972.gitgitgadget@gmail.com>
 <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com>
 <220413.86zgkpf5g7.gmgdl@evledraar.gmail.com>
 <CAPMMpoj3xZfKnH456AbiHatbBx98yXuj=yWBA8tdHhHdqn_H3Q@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPMMpoj3xZfKnH456AbiHatbBx98yXuj=yWBA8tdHhHdqn_H3Q@mail.gmail.com>
Message-ID: <220413.86sfqgerf7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 13 2022, Tao Klerks wrote:

> On Wed, Apr 13, 2022 at 4:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Wed, Apr 13 2022, Tao Klerks via GitGitGadget wrote:
>>
>> > Under python2, git-p4 "naively" writes the Perforce bytestream into git
>> > metadata (and does not set an "encoding" header on the commits); this
>> > means that any non-utf-8 byte sequences end up creating invalidly-enco=
ded
>> > commit metadata in git.
>>
>> If it doesn't have an "encoding" header isn't any sequence of bytes OK
>> with git, so how does it create invalid metadata in git?
>
> Just because git allows you to shove any sequence of bytes into a
> commit header, doesn't mean the resulting text is "valid" metadata
> text for all or most purposes. The correct way to encode text in git
> commit metadata is utf-8 (OR tell any readers of this data that it's
> something other than utf-8 via the encoding header) - it's just that
> git itself, the official client, is tolerant of bad byte sequences.
> Other clients are less tolerant. "Sublime Merge", for example, will
> fail to display the commit text at all in some contexts if the bytes
> are not valid utf-8 (or noted as being something else).
>
>>
>> Do you mean that something on the Python side gets confused and doesn't
>> correctly encode it in that case, or that it's e.g. valid UTF-8 but
>> we're lacking the metadata?
>
> In git-p4 under python2, the bytes are simply copied from the perforce
> commit metadata into the git commit metadata verbatim; if those bytes
> happen to be valid utf-8, then they will be interpreted as such in git
> and everything is great. If that is *not* the case, eg the bytes are
> actually windows cp1252 (with bytes/characters in the x8a+ range),
> then "git log" for example will output the raw bytes, and anything
> looking at those bytes (a terminal, or a process that called git) will
> get those unexpected bytes, and need to deal accordingly. A terminal
> will probably display "unprintable character" glyphs, python3 will
> blow up by default, python 2 will be perfectly happy by default, etc.
>
> I summarize this "non-utf-8 bytes in a git commit message without a
> qualifying 'encoding' header" situation as "invalidly-encoded commit
> metadata in git", due to the impact on downstream consumers of git
> metadata. Is there a better characterization?

I must admit that all this time I'd been missing the "Lack of this
header implies that the commit log message is encoded in UTF-8." part of
the docs added in 5dc7bcc2453 (Documentation: i18n commit log message
notes., 2006-12-30). I.e. I thought that "encoding"-header-less just
meant/implied "whatever".

But then again there wouldn't be much point in the encoding header if
its value is "utf8", so surely we'd want to use the lack of a header to
disambiguate utf8 v.s. non-utf8.

AFAICT we only allow selecting between encodings, not "no idea what this
is, but here's some raw sequence of bytes", except by omitting the
header.

It seems to me that between legacy/strict/fallback there's a 4th setting
missing here. I.e. a "try-encoding". One where if your data is valid
utf8 (or cp1252 if we want to get fancy and combine it with "fallback")
you get an encoding header, but having tried that we'll just write
whatever raw data we found, but *not* munge it.

I haven't worked with p4, but having done some legacy SCM imports it was
nice to be able to map data 1=3D1 to git in those "odd encoding" cases, or
even cases where there was raw binary in a commit message or whatever...

Anyway, all of this is fine with me as-is, I just had a drive-by
question after some admittedly not very careful reading, sorry.
