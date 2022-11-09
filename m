Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E28EC4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 23:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiKIXNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIXN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 18:13:29 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1818E05
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 15:13:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n12so714119eja.11
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 15:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nL0YadlWNpdSivT2yXHZZdERs93KbAuF3Wn2G0sSrY8=;
        b=Zi1ADiZeTnfASiAFJ24YMBoEG/52vZ47o5QzYFtoQEzUlJaeQtZWQMgbaq1Bzuc/AW
         3tDr3evUyMuDMDebF8m8NDpk03sa6dusc6jwtUKGU9msSurhIfGpdRbPkG2p5TcU5lwy
         oZyZQuwfmwUKv71aLuiIvIG4U0+Bs/ozW4ow/7Lp8kbTLuuuQeLxM74pp0P7fuKYgbUs
         SIvgRA3GHkTxFEDfGUiZmi3KyTPU6dplhInYRuU1dtvPwUV912Lx7aZx3Kp0cw6QEgSv
         n5ogsBR0X1/tkTfpMZSJIKNOjqbICeW3TG3Dj+hZ6uRU3JiESEFIrepymPuRxhGEX3c3
         Opqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nL0YadlWNpdSivT2yXHZZdERs93KbAuF3Wn2G0sSrY8=;
        b=X006fsJPsRCaMzvhQWTiPGMMU7mpTzpAgGgkX4qDatpSEZH6grrriuYI3ynfhl4GU8
         mNLEZkJpurodsgycrUmRk3esKYsXJzpocQqEwfXuwBjNMSJxwFXptgPDXPMjIWYWoUJb
         AOnUyOdf/jX2Kz16FsBThQIIrQDA3VJpPA33oLm5Svq9Gqj2HMJpSUas7N1oiG9gkvXk
         NqHX+h9OYsoL8BkwBMNakII+/3ufXiUrG7RQODowd0g+RjTMja6xTn4ySRTxPYAtIJ72
         NYy7zbecO+yH+N5jejDzyLANVp7Ok2sxUQiCmRI0UZAMnWW0egi9Hzp8BZ3zCNsi1EdS
         kCzw==
X-Gm-Message-State: ACrzQf3/HcFONE7to4Q9KBK3aAQVTqNU5/FtgWeT8NA0aHRmbfyjyY2A
        6yra/RuVJaYMuHIdqpz6QV0=
X-Google-Smtp-Source: AMsMyM6J9O7YJ22M7UpMv3EVe5AjyII0sLzWM67rFf+84UIWMMZtmC3jWZ6GtS0QGle0oUiyVO4zQA==
X-Received: by 2002:a17:906:1c0e:b0:7ad:c648:a4af with SMTP id k14-20020a1709061c0e00b007adc648a4afmr53551687ejg.277.1668035604034;
        Wed, 09 Nov 2022 15:13:24 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906329500b00782ee6b34f2sm6388829ejw.183.2022.11.09.15.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:13:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osuG3-001B9v-0S;
        Thu, 10 Nov 2022 00:13:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
Date:   Wed, 09 Nov 2022 23:54:10 +0100
References: <20221109004708.97668-1-chooglen@google.com>
 <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <Y2wZw3eYO4ykwtA8@nand.local>
 <221109.86h6z7pzdg.gmgdl@evledraar.gmail.com>
 <Y2wpYQ2x1Ghybqjo@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2wpYQ2x1Ghybqjo@nand.local>
Message-ID: <221110.86cz9vpvqk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 09 2022, Taylor Blau wrote:

> On Wed, Nov 09, 2022 at 10:47:40PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> [...]
>> I figured I was just kicking ideas back & forth with Glen, so I didn't
>> go through my usual sanity checking :)
>
> No worries, I figured. It's helpful to know whether you intended to
> supersede, build on top of, or propose an alternative direction for
> Glen's patch.
>
> For what it's worth, I think it's totally fine to say: "I have this
> alternative approach in a series, and here it is", but it is also
> helpful to add "let's figure out a way to build these together instead
> of queuing this alternative approach as-is".

To be clear: This is a proposed replacement for his, but I'm hoping
he'll also like it :)

I don't think there's any disagreement about where we eventually want to
end up.

I.e. for stuff like "read-tree" we shouldn't be calling a sub-process
recursively, but should instead be able to handle this in-process, ditto
"branch" having to invoke "git submodule" etc.

But getting there is a much longer journey. It doesn't just require
passing a "struct repository *r" around, but also untangling some other
global state & setup.

The "--super-prefix" feature was always something that was at least two
steps removed from that eventual goal. I.e. we didn't even have an easy
way to connect two codepaths within our own built-ins, so we just set an
environment variable at the start, and knew that if we spawned
sub-processes we could carry things forward like that.

Glen's RFC gets us about halfway past that state of affairs. It's not an
environment variable anymore, or a single global, but a split up
per-command global variable.

Whereas what I went for was an "all the way" solution of not having the
global at all. At least for submodule--helper I think 1-6/8 here shows
that that's pretty straightforward. We're usually only 1-3 function
calls away from the point at which we recurse to ourselves, so we can
just pass that state along as a function parameter, or for "foreach",
"sync" etc. via our own callback struct.

The 8/8 (and 7/8 prep test) then does that for "read-tree", which is
arguably a bit more gnarly (we need to ferry the state down two
different structs along the way), but even then it now becomes easy to
follow the full path to where we eventually recurse.

In terms of how this goes forward (and I'll wait for Glen to chime in,
and depending on what he thinks): If we go forward with my version of
this I think probably doing 1-6/8 here as its own topic just for
"submodule--helper" would make sense, as that's really quite
straightforward.

We could then do the somewhat tricker 8/8 separately.
