Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44408C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 03:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbiBSDGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 22:06:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiBSDGL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 22:06:11 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2D8225D1D
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 19:05:51 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hw13so19047500ejc.9
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 19:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qgXAW8Rl7WSGV2hCpZmTk8htUojmDBMygWtcUSlJbYk=;
        b=fSVdTIGhu53XXL7C0dJKg8gDHIya/QP9N1O/Pj17CAfu3qnlsFlO0YzxELkePK9bbQ
         a40zqY984mnLzrsYMTOFuj5vG+ya80xoRWPSz99+V09f+Mj1m6lAHRk3Pe/Ur216wOey
         kEmbaYihPxaIgUceB0ub5fSXpU8f+UgG8o0WLj0zv7rIAgCwKHAoFyPXc1F7Rr7ILw89
         pioRkwWOEmqM5w7lCSls4T4iD7kQZOf3qwR3IkT2kahxvcbtdVpbSehBNKj1esAfQAvJ
         m3/QWgf9nMcDweumXm/bBsHU1oN58tdrlE7w7ajTRGX56HCaORl2IRSbGBJodKbka9Ib
         tOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qgXAW8Rl7WSGV2hCpZmTk8htUojmDBMygWtcUSlJbYk=;
        b=Wv4G5/ruIitXOILE7qL5G6dQwrPqyAg1N6mGbG5dtK85+zkEZ1c2ywX0z3f7JPlQjD
         SijZ0pnYgK3eSbKPswuLt6qZBsbFhsDF/c2CfmhqRLZtQkhdCwXypTMvtf2IG/FrQ+KD
         gxexqv6PYYxTPIsh9ui0dHl4D9sOVnDFWs1RMsSXnMOJXkdcUN56brcCjIyYexfefKTB
         +guMPwKM5N5kSa670/ZeEvoS6ncf1tcSpUXUR1ZaPoywwi4xm8VgMpY5EHnKitp2hdUq
         CS1Szg0djmNwXeG0Jr52x2KZzYN2bpVn38CzKm7D7BajW7vbyohMt2993mDOXdLYhI4r
         zTlg==
X-Gm-Message-State: AOAM533bE8GtyX0q+mdGKL6lEjaszE+a7kwjWw0xjUmpZycPfZ/mHOHk
        m1DC1vzjKqXxKWVCi9Tbsi4=
X-Google-Smtp-Source: ABdhPJwCCwoDNd8I4v7JITUXbFuOp6mcoEC5pGcG0//3nrrkm3JNHV5JYxmyYeO0BZzlI95L8etLqg==
X-Received: by 2002:a17:906:3ec9:b0:6bb:2eb9:84f with SMTP id d9-20020a1709063ec900b006bb2eb9084fmr8566213ejj.86.1645239950262;
        Fri, 18 Feb 2022 19:05:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r1sm2801002ejh.52.2022.02.18.19.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 19:05:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLG4D-004gAp-6C;
        Sat, 19 Feb 2022 04:05:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] test-lib: add XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
Date:   Sat, 19 Feb 2022 04:02:23 +0100
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
 <patch-1.4-75c8f7a719c-20220218T205753Z-avarab@gmail.com>
 <xmqqley7yd6e.fsf@gitster.g> <YhBY8oD/xJZUQsj9@nand.local>
 <220219.86ley7fu3k.gmgdl@evledraar.gmail.com>
 <YhBclvZUYcsTabye@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YhBclvZUYcsTabye@nand.local>
Message-ID: <220219.86czjjftde.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, Taylor Blau wrote:

> On Sat, Feb 19, 2022 at 03:48:42AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> >> > +}
>> >> > +
>> >> > +# If [AL]SAN is in effect we want to abort so that we notice probl=
ems.
>> >> > +prepend_var XSAN_OPTIONS : abort_on_error=3D1
>> >>
>> >> XSAN_OPTIONS stands for "options that are common to all ?SAN", I
>> >> guess.
>> >
>> > I was also unclear on this. Looking around in the google/sanitizers
>> > repository, I don't see something called "XSAN_OPTIONS" mentioned
>> > anywhere (neither in documentation nor in the actual source code).
>> >
>> > Is this a convenience variable that we use to store options that are
>> > common to both ASAN_OPTIONS and LSAN_OPTIONS? If so, I am not sure the
>> > extra confusion is worth it, since it only contains abort_on_error=3D1.
>> >
>> > I guess it makes it (along with the prepend_var function introduced by
>> > this patch) possible for a caller to write XSAN_OPTIONS=3D... into the=
ir
>> > environment and then run a test script and have their settings feed in=
to
>> > ASAN_OPTIONS and LSAN_OPTIONS. But I don't know that callers would find
>> > this super useful (or, at least not dramatically more convenient than
>> > setting both variables).
>> >
>> > I could be wrong, and I'm obviously biased towards my own usage of the
>> > ASAN/LSAN builds, but to me this patch might be clearer without the
>> > extra variable.
>>
>> Sorry, yes it's just a git.git invention to refer to "common LSAN and
>> ASAN' things. Perhaps GIT_ASAN_AND_ASAN_COMMON or something would be
>> much less confusing & better? Bikeshedding most welcome :)
>
> Yeah, I would be fine with something like GIT_ASAN_AND_LSAN_COMMON if it
> makes things easier. I think it definitely is clearer, and does make it
> easier to add new options to both.
>
> I probably wouldn't ever tweak its value myself, so I don't think I have
> a strong opinion here. If it were me, I'd probably just as soon
> duplicate setting `abort_on_error=3D1` in the ASan- and LSan-specific
> variables. But I don't have strong feelings here, so whatever makes the
> most sense to you is fine with me.

Once you get to tweaking some more advanced options it makes sense to
share a lot for both. One change I have locally on top of this is e.g.:

    prepend_var XSAN_OPTIONS : dedup_token_length=3D9999
    prepend_var XSAN_OPTIONS : log_exe_name=3D1
    prepend_var XSAN_OPTIONS : log_path=3D\"$TEST_RESULTS_XSAN_FILE\"

I.e. for a feature to log machine-readable stacktraces when you run the
test suite with LSAN or ASAN.

    prepend_var XSAN_OPTIONS : dedup_token_length=3D9999
    prepend_var XSAN_OPTIONS : log_exe_name=3D1
    prepend_var XSAN_OPTIONS : log_path=3D\"$TEST_RESULTS_XSAN_FILE\"

Which is how I ended up with XSAN_OPTIONS I think, i.e. I'd test things
with LSAN, switch to ASAN, would have to rename the variable
etc. Changing a single letter was easier ... :)
