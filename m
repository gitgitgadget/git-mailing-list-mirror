Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4940C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 01:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350595AbiASBR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 20:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiASBRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 20:17:25 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3F8C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 17:17:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cx27so3581495edb.1
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 17:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3gRUPnygJINubCJcBG/N2icZK9gS6R9gg6ONoreWmXQ=;
        b=ZBQFaF6C4iwzwEgTeiva6QVeVqL79zO2fliKSZXi4h54AdYYyxv3EdBRzReVNAwX70
         jkakdLFYE8NGwmhg3eMR8U52VsY7aRlOH6Y9JBTPlp2DaWe55jxM8/HrTGQ1pbDkEBuT
         U7OV7j33gn/vo3VoXykB+mZtyBKW9Evc7XyFe6AqZ8eI9UuC51gYpBEg9f8uo8y9XMfC
         ReIE8bSDZ4EHjw/UbW7ZZ6coxM3QBwQpPJKu4JJrThdc2jhr2xMv32zAknf3nUAXm6B8
         MJyk2XxciIPrH4l2FUNjGR3mqNykXNVG/xvhLo/A+CJynGNo3kjFFy6lp2D/NWx4g0u7
         Ys0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3gRUPnygJINubCJcBG/N2icZK9gS6R9gg6ONoreWmXQ=;
        b=Bj8Gdg9kX1+K4cwCNnMnrjGK/dWGzV8q5dYGvA+OUuIcHz1S7Kt6AvmECC7R6SlmtJ
         WWFzkCBxUQIL2pGO+wUj3CKFWSWLnTkkQBiAz0z9V6uwBq+ctYJnN12s7es1Qf2XOYxz
         rD4FLEuAUUf7VVXP7srz6f4ZJ7uce63g88BO55OcVmUWIcpyywQbQgEjN5YKaqPFk2YN
         E7Giv9qODHqC/HmndH959MekT1Vik0Hwb2uRSph+6R5ir1QFlgeC3jNRFMWkQgiQ+3za
         wWxE/slobWDduEGCWTwFs/awlWlTI6G2BIwMcfkM/rLdPmPovIS3qwlMYYr48LFaVEU5
         6/Ug==
X-Gm-Message-State: AOAM53333OjQ9B6vh9xzEe3r/JUiNprR+zCWaShwPvtSYTPOKc1YpjNI
        +uS671MwBjn6cGAFEz7zNYTVMqGBOEKaAg==
X-Google-Smtp-Source: ABdhPJwJfGmCdl8T8KrgDUV3GZ2MApaTiPiNP2Dl8AD2IZqZgnvHYy6eNH5F/YkV9wP9EquxBAEdVA==
X-Received: by 2002:a17:906:d9b:: with SMTP id m27mr1097605eji.364.1642555043520;
        Tue, 18 Jan 2022 17:17:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d27sm5773865ejd.117.2022.01.18.17.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 17:17:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9zbG-001i1N-EU;
        Wed, 19 Jan 2022 02:17:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v8 09/10] grep: simplify config parsing and option parsing
Date:   Wed, 19 Jan 2022 02:15:53 +0100
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
 <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
 <patch-v8-09.10-c211bb0c69d-20220118T155211Z-avarab@gmail.com>
 <xmqq8rvcr73v.fsf@gitster.g> <220119.86wniwo9mz.gmgdl@evledraar.gmail.com>
 <xmqq35lkpm4q.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq35lkpm4q.fsf@gitster.g>
Message-ID: <220119.86bl08o76l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> If we had a grep IPC call of some sort we'd surely limit it to the
>> "modern" config of grep.patternType, and take the opportunity to
>> deprecate grep.extendedRegexp from that interface.
>
> A process that visits more than one repositories, with different
> configuration, does not have such a choice.  As far as I tell, there
> is not yet a way to undo the static in the code after these patches
> so that such a process can reset between repositories.

Yes, it does assume the current one-shot API users, e.g. "git grep
--recurse-submodules" only reads the config of the one parent repo.

> A member that is necessary only during configuration parsing is not
> a problem as long as the field is marked clearly as such (I wouldn't
> even call that "not a NEW problem", since it is not a problem to
> begin with, and I am sure there are more examples in other
> subsystems).  A static inside a helper function that has subtle
> interactions with second and subsequent invocations makes the code
> much harder to follow, on the other hand.

*nod*, will change it.
