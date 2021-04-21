Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52FFC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B55613C0
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhDUI0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbhDUI0m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 04:26:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823B0C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:26:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l4so62216320ejc.10
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OqK4SdDrmoQdKW3HZbK2lT4fSt1K2F+zzik5pIakoMc=;
        b=A/Eb5TcJbh+qriGXakQYpE6MYLDFzUriUa/CGN4bcr1E8BxNMb8mx/oxmMODk4VGPf
         9a9pQYB+sGEomMqeYuKAAjNgExkNFyX7M5QhXRIB/RdA9glkCoapbRW7ucjWUH9vs7Ay
         1HUWriYMRUR/FmWS/Zzud2Xsiajs3Wb4QCJj1qroVpQwZGbLbznLEBYSwMW5R2VJ65X8
         5wmH0Rstrb7i74xhvLed/uObeFUyKuc0wQsGxq2AY0j1g3ILwATL/MZSjSeDzw5reSAe
         tQu2c2SnW4Ttv3gHbmiqR61HnN3+jLqrpnFKmcJH1Kn3VrO48we/MvLgnu2X/PvkUXGt
         BPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=OqK4SdDrmoQdKW3HZbK2lT4fSt1K2F+zzik5pIakoMc=;
        b=ibcqGoySDyffXf0grtsa5YyHzsFLH3u4g3JptcP9cFjxz3CbnBZ2YAHIUd9jicm3sr
         zIWiX95n2YUpAtOsfiK8tMStakgL1HSHfUh3ayIk+0v6pCNeXuqmpmDCMQNZPOsV+fne
         2tXSbu1sM9dk9C/5g5Vt3TRGfKPUMP/H21qwJZrn+E3qPBgCIwT08MU/pLde1DiwNRpv
         PBgFK6j2lNdLMtr/ybcrBzZZsCdUNlB7Z2u0ulZYAzL4DaPHNnTTAysec68Gyi/n92mA
         L1AT8FlTyrO9pyhmSQEnBKPv9f9U0SCeJF3NlQavvjqmKl+GlTjSsvgT+AlxsRRXtYDV
         73DQ==
X-Gm-Message-State: AOAM532bj22t1nNftw9SzJIdBKhYMNwrJxwt1HlqK2cUgm8mI04qWjHZ
        TzxfmM3r0JNafVueNezpNFU=
X-Google-Smtp-Source: ABdhPJwzxQnfYzeGccvn1xiqzx4Av96w2S5hmW64O/7GPs/kgIFwf5zRh5yz32XVDlYZVJV/fgeHTA==
X-Received: by 2002:a17:906:8303:: with SMTP id j3mr31689492ejx.85.1618993568158;
        Wed, 21 Apr 2021 01:26:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n11sm2257056edo.15.2021.04.21.01.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 01:26:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2021, #05; Mon, 19)
References: <xmqqtuo17t6t.fsf@gitster.g>
 <87mttt2hcu.fsf@evledraar.gmail.com>
 <YH9gPt410QBRjG59@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YH9gPt410QBRjG59@camp.crustytoothpaste.net>
Date:   Wed, 21 Apr 2021 10:26:06 +0200
Message-ID: <87tuo02gdd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 21 2021, brian m. carlson wrote:

> On 2021-04-20 at 13:52:33, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This has a textual conflict (no longer a semantic one) with the above
>> ab/unexpected-object-type etc.
>>=20
>> As noted in
>> https://lore.kernel.org/git/87mttx121j.fsf@evledraar.gmail.com/ I had
>> questions about the approach in hash-object.c, in particular I have
>> POC/WIP patches that make one of brian's TODO tests pass, by doing the
>> "we are in SHA256 mode" earlier, which is also less code as we won't
>> need to add special handling to a large part of hash-object.c (or, in
>> the future, other such commands).
>
> I'm going to drop those first two patches for now, since I plan to
> implement them in a different way in the future.

Using something like the:

    git --object-format=3Dsha256 <cmd>

Approch I suggsted in
https://lore.kernel.org/git/8735vq2l8a.fsf@evledraar.gmail.com/ ?

In any case having something like the OPT_OBJECT_FORMAT() I added in
that WIP patch would make sense wouldn't it, to reduce the duplication
of current "object-format". It would also save each current caller from
doing the "unknown" and other sanity checks, since they could rely on
parse_options() having died in that case.
