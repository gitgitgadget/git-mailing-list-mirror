Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF7C433F5
	for <git@archiver.kernel.org>; Sun,  6 Mar 2022 19:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiCFTrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Mar 2022 14:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiCFTq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Mar 2022 14:46:59 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EBC205E4
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 11:46:03 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qt6so27733332ejb.11
        for <git@vger.kernel.org>; Sun, 06 Mar 2022 11:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oduu2CMnQ3wiEa6+iUspgH7J1e4/cd9ehyQqvAnms+g=;
        b=XXgurmNOvK+BZobK4PkpNVWwQDAfgzKtwVQzhA+9TNbm4NAg8FAcq5J4a8gIehPNu0
         lJ9betY5Pe3MhMYRikY/UA3qefNY9pa1AaJdtwN0+G4vinnAGDWjkBwGDeCmJkCH7DiN
         aIOS9VRtlIj6a5OcwBM1Z5x0+1AazW6GVB01QBLSCTKxjvIJ5uWbXOK31SrbynOffJ+u
         1M2TYNL/rttmkAxkFvKPQCW0H1Tpk6CDXWRX5bo2inLHoia6wsefYXy6Q4MhbiOPWGiM
         /+xzW3qmkgf8XGX9D2oJv7PyR5EwD0hOJAm7YUKE7PSoPOqjmkv7L5U3oweTLW+4sFaY
         BRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oduu2CMnQ3wiEa6+iUspgH7J1e4/cd9ehyQqvAnms+g=;
        b=wnzAHoS5wN3mEjUKS5dk+uTo//li/qj5tZ3MMgh9ft07NVKSqYCSfIvhmsS6YjH8iS
         fqcQ8Nz7io1Xm/8ptkRNqRJ7JB177+03mFCGmZVTp32YVsT0BgMkK9MKc2UIrb9y5ZSN
         0J/gQ4OaV+Zoxqtu95W0nMhuxZDfD6HFFOmLuCA4P6iV279Hoq69B3KIq2Ifm3AvTtdj
         RLNNtf1i8BNQJyzCHZIPaK9AuZfI8YX/WZSzNNdaZg/LvFuEn9u9kZouruqm49kYQHIK
         U2m8c4+wkgdK7t0rmH4SAt76ymX7z3QNT1iJeBbEFvn5Cav6ChkinkOw6piEZJumKi4p
         m8RQ==
X-Gm-Message-State: AOAM532V6uSfE49oOTHtbiZeQJo+1fNOVMH7cRdPI7nstBwruyEUAqdY
        an1ynSQnZXbNawRDuG4+MUU=
X-Google-Smtp-Source: ABdhPJxu/IXwf6zxY34ROmu0IevIm21UoOrxLFy2sSzzuVslSMS9s3EfDIk26jnt3Zjh0keYYSlk6Q==
X-Received: by 2002:a17:907:720a:b0:6da:e533:6440 with SMTP id dr10-20020a170907720a00b006dae5336440mr6948147ejc.679.1646595961480;
        Sun, 06 Mar 2022 11:46:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u19-20020aa7d893000000b00415a0f25f33sm5145658edq.34.2022.03.06.11.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 11:46:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQwpM-001KTN-3o;
        Sun, 06 Mar 2022 20:46:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: What does it mean to have multiple upstream tracking branches?
Date:   Sun, 06 Mar 2022 20:42:35 +0100
References: <CAPMMpoiTJAuadBEOPWOVa-kguSXMDvAhvD22B63QwYpu=H7xEw@mail.gmail.com>
 <220303.868rtr42mg.gmgdl@evledraar.gmail.com>
 <kl6l4k4ek73o.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <kl6l4k4ek73o.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220306.86lexm3lvr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Mar 03 2022, Tao Klerks wrote:
>>
>>>  Hi,
>>>
>>> In my recent attempt to create a "simple" branch.autosetupmerge
>>> option, I have repeatedly been confused by the enforced rules around
>>> what is and isn't valid for the branch.<name>.merge and
>>> branch.<name>.remote configs.
>>>
>>> Until Josh Steadman's recent work on --track=3Dinherit, the "automatic"
>>> addition of branch.<name>.merge could only ever result in a single
>>> entry.
>>>
>>> Now we support multiple entries being added as a perpetuation of an
>>> existing branch's setup - but what does it *mean*? I could understand
>>> if the idea was to have transparent tracking across multiple remotes
>>> that are supposed to have the same content (eg a single server set up
>>> over multiple protocols), but that does not appear to be possible -
>>> branch.<name>.remote can only have one value.
>>>
>>> Is there any documentation (or could someone provide pointers) as to
>>> when multiple branch.<name>.merge values can make sense and what that
>>> means / what it does?
>>
>> Can you point out some existing tests where we end up with multiple
>> *.merge values? I looked a bit and couldn't find any.
>>
>> Or maybe it's only possible to get into that state with some command we
>> have a test blind spot for?
>
> Based on the discussion on that thread you mentioned, I don't think we
> have any such tests. I think the only way to get into this state is to
> manually modify the config.
>
> The only docs I could find on 'multiple values' are from
> Documentation/config/branch.txt:
>
>   branch.<name>.merge::
>     [...]
>     Specify multiple values to get an octopus merge.
>
> So I'd imagine a use case would be something like:
>
> - I'm preparing a feature on the branch 'topic'
> - It will get merged into 'origin/master'
> - The feature also depends on 'origin/other-topic'
>
> I'd have entries like:
>
> branch.topic.remote =3D origin
> branch.topic.merge =3D master
> branch.topic.merge =3D other-topic
>
> That way, if either 'origin/master' or 'origin/other-topic' changes, I
> can pull updates into 'topic' with "git pull".
>
> Not that I would ever _recommend_ someone to work like this though.
> Junio also wondered whether anyone uses this [1].
>
> [1] https://lore.kernel.org/git/xmqqbl2hw10h.fsf@gitster.g

Sure, maybe we should use it for something, maybe not, and maybe we
should use our (keep using?) default "last config set wins" rule here,
and maybe not.

What I'm asking about is that Tao Klerks notes upthread:

    Now we support multiple entries being added as a perpetuation of an
    existing branch's setup - but what does it *mean*?

As far as I can tell this isn't the case, but I only dug into it a bit
(I instrumented the relevant tests to start dying if there were multiple
"merge" entries).

So I couldn't find what if anything changed here recently, but I'm not
saying it didn't, just asking for a clarification. I.e. I didn't find
how "what should we do with this config, if any" had to do with "Josh
Steadman's[sic] recent work on --track=3Dinherit" (re "[sic]": it's
"Steadmon" :).
