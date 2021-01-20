Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5881DC433E9
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A48F23122
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbhATSBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390607AbhATR76 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 12:59:58 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF5C0613CF
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:59:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j13so2538601edp.2
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6PBBAet1tus0nNl7Xlpn6sxtXZDbDbromASrvKVAFM8=;
        b=TpFQXYsVD5SC/OAghbzFC8OphgidajcY0ROW6WvUU2hdkq2LjHH6nzp+kgMdesGbfK
         R7FnV1WVnnn9KEzvmm+wYI25uzQbaTLT3VdJq/cedN8WMNGooOrXQjIFO2YjjgmX+jzY
         R0ulSpkRnRB0DIeEmAgu9aumIezNDSwLxfJdAW5NT5f4pUv5BggtEvx0B82Kz/m9Ja5b
         2Q9pGS9if3+VyyChQr6AkLZcQy+UOYt4yG2gmb4k4hRKXHWsYFGFgHypxtjXzbGp6bM8
         +fAIMe8Z0CnW4A7a23p7yvVWmgCd22AoqHYy9Gc0O+koUCfPOzRXWTpnZdR2pyp9VRCZ
         JXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6PBBAet1tus0nNl7Xlpn6sxtXZDbDbromASrvKVAFM8=;
        b=oHPmUf7Cn5C20qklcl8amaiVI6HM/URw/aLn0HMpMAEpe9qkYyBnswu5//5ENro9Cp
         FXXbAA72VJY/KRNvH3TQWGwcjtE1n1j/M2mJKSw5TFYPQi++2tfVU45qOQoGXqzdJkVN
         HFANGBRf30W4JzpbIpbLDcpe4FcU6iSXUIZrxL2OqHpW2a9UjGiIoHgG+NgyBtS6TiX8
         JNyywrlU7aSWLz62NM59pqbzR4eCqJbTc072+7zb7g+8LHwMrN6mV5rEK+pag4fKGE/I
         BK+EvueOYticgyguFVM2Xuzrdx1NmYbYzoA7hQYw8wMSHRpEIOHv2SaVySACn9mpXAwk
         6kEg==
X-Gm-Message-State: AOAM5334Z/NRXfjI02ySxnX8w1oIadf07AuHG54xwCplfVxpNAt2QA1L
        OcReDlA+iZG965KJYWYukpGzr30PJB4=
X-Google-Smtp-Source: ABdhPJyRp+9RurZ1BC6c5T6eyEjxiy8sWbV3hW+hTwSfvpuw1H+5o36+GAQ0yAxJLx6Aykq0V0AGMA==
X-Received: by 2002:a05:6402:c92:: with SMTP id cm18mr8721577edb.367.1611165555632;
        Wed, 20 Jan 2021 09:59:15 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id f6sm1439673edv.83.2021.01.20.09.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:59:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/6] ci: remove GETTEXT_POISON jobs
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
 <20210111144740.6092-2-avarab@gmail.com>
 <20210112085051.GV8396@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20210112085051.GV8396@szeder.dev>
Date:   Wed, 20 Jan 2021 18:59:14 +0100
Message-ID: <87a6t38p71.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 12 2021, SZEDER G=C3=A1bor wrote:

> On Mon, Jan 11, 2021 at 03:47:35PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> A subsequent commit will remove GETTEXT_POISON entirely, let's start
>> by removing the CI jobs that enable the option.
>>=20
>> We cannot just remove the job because the CI is implicitly depending
>> on the "poison" job being a sort of "default" job.
>
> I don't understand what you mean here with a "default job" that the CI
> is implicitly depending on.  There is certainly no such default job on
> Travis CI, and I don't think there is one on the GitHub thing.

I'll reword this. I meant that the poison job was using the default
compiler etc., whereas the other ones were setting custom values.

I vaguely remember some list traffic about this in the past, i.e. the
reliance on the poison job not just for that, but also as "the default
OS image" setup.

