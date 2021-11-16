Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E74C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162D963214
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbhKPTHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 14:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbhKPTHN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 14:07:13 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0758C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 11:04:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r11so28532227edd.9
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 11:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=z0ffgpBLVrLqBNsefYtWiaYZHnggU9r0y8CKLGtGGCU=;
        b=Sir49Ktm/RXWyuCaQCA2SctgKoapz0RSufuyDyzlQqcOz5GCbueBi0PEJw6pZW8Iv5
         GYd6kTD8GaO7d069cB/GE9LAsE2VGSKD4StkcM2QEWpqYGR7J6tFHdfh7adjbP/CU3VN
         Zx4KjxrdmxEUt0olCX2VX6OuwPxfK2UWR31UutM/jgqX/c9tCg/S+LjpQ3bMi+IyFeis
         /DxJiF0Gro4F7HS80Gd46b+8T7CDS2yz0ezWvK61sqh2eB1tL6y1OKPWAEkblgd50+8s
         K0bxLlZdJEkWrh7RilVu2EAJIQ4RYuz3xE3Mov5ViXvfZVD3w0XGT7PvIsmsu/9xJglY
         uvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=z0ffgpBLVrLqBNsefYtWiaYZHnggU9r0y8CKLGtGGCU=;
        b=V0trojy8UOlvMO/Iv5FWXipRQgzbfh+CA6CN5JyHCuk2HogajDNou5oKQlLourz62c
         ZbU0oukf6g69jZa+zfFyR4cAdqrZb7WMS8/Ddnfe+bihoPRFDD4PDG7P42uDzXwLjUSW
         9Y8M7817IjWopIBeNvQS5yhSCRAJdYebM2SdpsaFyoyK7rfhCJCtq9zL/zKtE1calrey
         rIBDrjtUdk1ZA8yT7Ks8gC0gje7iAYoPA4OBIfVvCa2tXNl5MVxrUS/ga94MGCGlwikF
         9kYLSPyG4waLW8jfs0fLyOEVOCJ8A7pYI8dJyFdnl0t3A4El7yM2qvXqXtzgx98q+H4O
         lWEg==
X-Gm-Message-State: AOAM532k8opy5Y7rLE0iYSHdufc2jivZxRmgufaDAnErhyrfkZff6fC7
        FZOIiV3YvDy3J64BWIxWp+c=
X-Google-Smtp-Source: ABdhPJw26WRwhi2jdntSIkFVH44hbJONpIgdfAtHpgsvvHNdoizORLNXQHiYYrwdPUQshemS97e3NA==
X-Received: by 2002:a50:eb85:: with SMTP id y5mr13539905edr.173.1637089454390;
        Tue, 16 Nov 2021 11:04:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p3sm8829535ejy.94.2021.11.16.11.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 11:04:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mn3kb-001f6M-8k;
        Tue, 16 Nov 2021 20:04:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 00/21] C99: show meaningful <file>:<line> in trace2
 via macros
Date:   Tue, 16 Nov 2021 19:58:01 +0100
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
 <YZP771pJl30ujluT@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZP771pJl30ujluT@nand.local>
Message-ID: <211116.86czmzq5w2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Taylor Blau wrote:

> On Mon, Nov 15, 2021 at 11:18:10PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Since everyone's getting in on the C99 fun.
>>
>> Well, $subject and a bit more. This RFC series has bits and pieces
>> from thing I've submitted before. I'd proposed to make variadic macros
>> a hard dependency before in [1] because I wanted to get to the goal in
>> $subject, perhaps the whole thing will be more convincing.
>>
>> This also includes the die_message() in a recent series of mine[2]
>> that I abandoned.
>>
>> At the end of this series we expose a config variable to have
>> usage/die/warning emit line numbers. I.e. going from:
>>
>>     $ git -c core.usageAddSource=3Dfalse -c core.x=3Dy config --get --bo=
ol core.x
>>     fatal: bad boolean config value 'y' for 'core.x'
>>
>> To:
>>
>>     $ git -c core.usageAddSource=3Dfalse -c core.x=3Dy config --get --bo=
ol core.x
>>     fatal: config.c:1241: bad boolean config value 'y' for 'core.x'
>
> Just picking on this output change in particular. I agree that this is
> easier for folks hacking on Git to trace down errors. But I'm not sure
> that I could say then same about users, who will likely treat this extra
> output as noise.
>
> Now we may find it helpful if they include it in a bug report, but I
> feel reasonably comfortable saying that the value there is pretty
> marginal. I don't find it all that problematic to grep for a specific
> error string, and usually find myself in the right place.

I wouldn't suggest exposing this to users, except perhaps as part of
some "how to submit a bugreport" instructions. It's thoroughly optional.

I thought it was easy enough to do with the preceding steps since all
the data is there, and would help my workflow a lot.

If you've got the file/line number like that you can make it clickable
in your terminal/compile mode, e.g. Emacs's M-x compile. Saves time over
having to grep manually select the string, grep for it etc.

Anyway, I can certainly live with peeling this patch off the end and
just stopping at the trace2 data for now, if you/others feel strongly
about it.

>> I find that to make tracing down errors in the test suite, and 21/21
>> has a GIT_TEST_* mode to turn it on there (which fails a lot now, but
>> I'm hoping I'll eventually get passing).
>>
>> But most importantly we've now got meaningful file/line numbers in
>> trace2 error events. I.e. from all of them being some line in usage.c:
>>
>>     $ GIT_TRACE2_EVENT=3D/dev/stdout ~/g/git/git -c core.usageAddSource=
=3Dfalse -c core.x=3Dy config --get --bool core.x 2>&1 2>/dev/null|grep err=
or | jq -r .
>>     {
>>       "event": "error",
>>       "sid": "20211115T221343.534151Z-Hc2f5b994-P003f3980",
>>       "thread": "main",
>>       "time": "2021-11-15T22:13:43.537981Z",
>>       "file": "usage.c",
>>       "line": 65,
>>       "msg": "bad boolean config value 'y' for 'core.x'",
>>       "fmt": "bad boolean config value '%s' for '%s'"
>>     }
>>
>> To:
>>
>>     $ GIT_TRACE2_EVENT=3D/dev/stdout ~/g/git/git -c core.usageAddSource=
=3Dfalse -c core.x=3Dy config --get --bool core.x 2>&1 2>/dev/null|grep err=
or | jq -r .
>>     {
>>       "event": "error",
>>       "sid": "20211115T221357.083824Z-Hc2f5b994-P003f4a82",
>>       "thread": "main",
>>       "time": "2021-11-15T22:13:57.087596Z",
>>       "file": "config.c",
>>       "line": 1241,
>>       "msg": "bad boolean config value 'y' for 'core.x'",
>>       "fmt": "bad boolean config value '%s' for '%s'"
>>     }
>
> Neat. This is a use-case that has all of the value without putting it in
> front of users all of the time. I like it.
>
>> This is "RFC" mainly because there's a CI failure in 0061.2 with this,
>> I still can't figure out what that's about (or if it's some fluke
>> unrelated to this topic), but that has to be investigated.
>
> Hmm. Putting the CI failures aside for a second, wouldn't we want to
> hold off on something like this until we have flown the C99 weather
> balloon for a while? If we suddenly start introducing C99-isms into the
> code while brian's patch is still young, then we can suddenly no longer
> say, "oh, just drop this #if because there are no other C99-specific
> uses here", and instead compilers that don't support the newer standard
> are out of luck.
>
> That may have been already communicated elsewhere in this message and/or
> throughout your patch series, so if I missed it, I apologize. Just
> felt that it was worth stating the obvious before we go too far down the
> wrong path.

As noted in 02/21 we're hard depending on this particular C99 feature
already fon a few releases now, the only change on that front in this
series is to stop committing to maintaining the non-C99 codepaths.

We've already had hard dependencies on various bits of C99 for years now
without any trouble, and I wouldn't expect any problems on this front
either.

Brian's series and the current weatherbaloon from Junio are a bit
different in trying out new things we either haven't done before, or
have run into some trouble with in the past.

No need at all to apologize, it's a lot of patches, and raising this
sort of thing is what patch review is good for.

Thanks a lot for looking this over.
