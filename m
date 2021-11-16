Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608A1C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 20:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3798461ABD
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 20:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhKPUWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 15:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhKPUWy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 15:22:54 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F406C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 12:19:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r11so242539edd.9
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 12:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4wPAYcrBlOuFw24aav59Z3/VJfBkUiTIXnO4vw0uD7g=;
        b=J2Ljecsjdik7qdyvKhQ39ltxGQukMTcTinICZo+S/rmaABlVPFT2YR81Et+BeUQHfR
         +qMzlnEwNXVGMdS6rOztyg+APTBP7k2R2SUFEUpD/hY2ibOyPpgFErX7SIU666FFfFIA
         vk9wzR0tHqveGA6JGgz8gX3KsDhyiLT8Nk+u7btmqhXTlmpT2YG0H9xvJxyh1Nq0ARaZ
         L6jI8Nk0ckbIJVIXfWXxIPRI8rd8ZQuMVppehSHveNl51K7TgPzxWUl5dow8ynqEyT1y
         DAhoscPFU3tnBACKvsj71EbyDXaQvqOMYWqVtp4dHg/MwDLHMs4uWp+2gxemE2t/5AHT
         s0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4wPAYcrBlOuFw24aav59Z3/VJfBkUiTIXnO4vw0uD7g=;
        b=tKfy3olZFoxvY4f0F/SPCI0OjB8R+XcfXZs+R2/zTlgfWlSSVACaNbjGhZnqZUFphP
         9Ms6ADDDG5aqAmkQlDzL4qivjuML/AkTVKwmm8LtjeqEsk1Jxxb+IsM2pJPTSx/NrAGj
         Q4qEqkzBJPjYS1NHZd37LJPjSz7maTtuhSj1VSYwAuNnY8cbu1qmJycbX9GbGz1iKV3S
         ZEq61M3s1q6pK2002wWFPpSI1xfF1iQJuBodN290wDa9L6Otez44LX/t37Yt4oAVe+T+
         Cy8L6YW+50gfXay16Fi0z47TK70dBhEvbl19DHO74ExJdOuLisVXkteAqX11mPhgIlg5
         R0XQ==
X-Gm-Message-State: AOAM531xIFMVC1kACDQ1dva4TyhQO+OVsnAOUdvUlDWbLENdDLBlX4QA
        p1z69rgiiGIvG2nVxEczMVY=
X-Google-Smtp-Source: ABdhPJzyyYn/eSVeqBtdRbYhM0Wuf8CS82zz5UbJElYfM1G3eDdkIu1fJ+mZn11ehZcQ5eYMFsQGGw==
X-Received: by 2002:a17:906:dc8d:: with SMTP id cs13mr13609017ejc.109.1637093995522;
        Tue, 16 Nov 2021 12:19:55 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z6sm10350084edc.53.2021.11.16.12.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 12:19:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mn4vp-001g2J-Nx;
        Tue, 16 Nov 2021 21:19:53 +0100
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
Date:   Tue, 16 Nov 2021 21:16:28 +0100
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
 <YZP771pJl30ujluT@nand.local>
 <211116.86czmzq5w2.gmgdl@evledraar.gmail.com>
 <YZQITrlvO7eUZyDN@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZQITrlvO7eUZyDN@nand.local>
Message-ID: <211116.868rxnq2dy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Taylor Blau wrote:

> On Tue, Nov 16, 2021 at 07:58:01PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> On Tue, Nov 16 2021, Taylor Blau wrote:
>> >> At the end of this series we expose a config variable to have
>> >> usage/die/warning emit line numbers. I.e. going from:
>> >>
>> >>     $ git -c core.usageAddSource=3Dfalse -c core.x=3Dy config --get -=
-bool core.x
>> >>     fatal: bad boolean config value 'y' for 'core.x'
>> >>
>> >> To:
>> >>
>> >>     $ git -c core.usageAddSource=3Dfalse -c core.x=3Dy config --get -=
-bool core.x
>> >>     fatal: config.c:1241: bad boolean config value 'y' for 'core.x'
>> >
>> > Just picking on this output change in particular. I agree that this is
>> > easier for folks hacking on Git to trace down errors. But I'm not sure
>> > that I could say then same about users, who will likely treat this ext=
ra
>> > output as noise.
>> >
>> > Now we may find it helpful if they include it in a bug report, but I
>> > feel reasonably comfortable saying that the value there is pretty
>> > marginal. I don't find it all that problematic to grep for a specific
>> > error string, and usually find myself in the right place.
>>
>> I wouldn't suggest exposing this to users, except perhaps as part of
>> some "how to submit a bugreport" instructions. It's thoroughly optional.
>>
>> I thought it was easy enough to do with the preceding steps since all
>> the data is there, and would help my workflow a lot.
>>
>> If you've got the file/line number like that you can make it clickable
>> in your terminal/compile mode, e.g. Emacs's M-x compile. Saves time over
>> having to grep manually select the string, grep for it etc.
>>
>> Anyway, I can certainly live with peeling this patch off the end and
>> just stopping at the trace2 data for now, if you/others feel strongly
>> about it.
>
> I don't feel strongly, and I was just noting that it seemed like users
> would treat this extra information more often as noise than anything
> else.
>
> When you talk about making it optional, do you mean through
> configuration / an environment variable, or by including / not including
> the patch? In other words, the latter seems much more like us making a
> decision on whether or not to include line numbers rather than
> presenting a new option to users, though I may be misunderstanding.

Not surprising, since I see that I screwed up the summary in both the CL
and 21/21. I.e. both of these are =3Dfalse (I copy/pasted the error
around, but didn't adjust the command that was invoked):

    $ git -c core.usageAddSource=3Dfalse -c core.x=3Dy config --get --bool =
core.x
    fatal: bad boolean config value 'y' for 'core.x'
    $ git -c core.usageAddSource=3Dfalse -c core.x=3Dy config --get --bool =
core.x
    fatal: config.c:1241: bad boolean config value 'y' for 'core.x'

That second one should be core.usageAddSource=3Dtrue, i.e. as seen in the
21/21 implentation and core.txt docs you only get these line numebers if
you opt-in to them via configuration or the new GIT_TEST_* environment
variable.

>> As noted in 02/21 we're hard depending on this particular C99 feature
>> already fon a few releases now, the only change on that front in this
>> series is to stop committing to maintaining the non-C99 codepaths.
>
>> We've already had hard dependencies on various bits of C99 for years now
>> without any trouble, and I wouldn't expect any problems on this front
>> either.
>
> Interesting; so this and others are likely part of MSVC's kind-of
> support for C99 features? In other words, that MSVC supports some
> features from C99 (and we are depending on a subset of those) but not
> all features so that it could reasonably be called a spec-compliant
> compiler for the C99 standard? If so, makes sense.

Yes, I think this is one of the things that's the same or similar enough
to C++ that MSVC has good support for it. See the "We try to support a
wide range of C compilers[...]" section in the CodingGuidelines for a
list of some other C99 features we've used for years already.
