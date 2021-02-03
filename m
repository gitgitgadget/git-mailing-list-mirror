Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A70C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5B164F59
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhBCDhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhBCDhO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:37:14 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8899EC06174A
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:36:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i5so3072512edu.10
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=08QJUW6Qp950vr4VO8u4j7t3jEav2KOawfQGEsdcafI=;
        b=Ql1WYQQIipfqsYEdk8kyLoBiMAC4dl2VbMN4mZFJqiy14XkfruWZVQac3ownbd137q
         y/rYWZBR9avyP1aB1/TrBYVq/mK60KnUYk2UYT3OC3+yVZL1PUhWEun3S9vfAYxpPOlu
         WaWobbt8JOxFwI/YBlhY9QRyxWn9RkWkaCTv/HCqUE3Gmi8IwGcjmUUiEQNzDVXz6+98
         lq3pGJgib9xgwLm8sPcs5EDvMDDBfV7bt77IEAgCuDm1NrxB5EAdPBaIhIsh/lhR//2E
         YDr6lo1CTsAyRozb9VhfzfltAjtMY70MNYo410LK0JlaVDLeOCeO0x7tKRFh67259YC+
         qudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=08QJUW6Qp950vr4VO8u4j7t3jEav2KOawfQGEsdcafI=;
        b=Og0lRS+tpiMx5YFdH1D1F4CHA7z6PVK4JtnqI+ufsVAZFw+NLl2nE11Ej5L/DpnpRC
         v/yjFzbMHIhWS0DZ1ATTtx4eIX+cz19ViVpTcvuEQ+e7HDM9x75F0SSs+NGQuhaCrW/P
         /ABKh+n59xzW/bzQZqo2p2r/giYaS+MnxSPs5jN84bCyLbggwMSeKQ6OITEizcGeVg2g
         W0Mc63a1uqrY9V6rYNnxcuC3ifQM6RoZ4sJQHI53YY4k9RQcxHDolOAu2BO/qaH3iJX9
         Z98w2eiZvEEPADLzBAH2KfAF4BX68Pu01ju7d9vdo+tuAYTwoNbT37lsVEIxhh3ERKBp
         Lcow==
X-Gm-Message-State: AOAM532Vbct0DVSP7Ie57A4VZbYBkaeSgh+FSMdVSCCHMts6mtLLX8wj
        peqWmgd+6+ANYqaTdDGR/iEovfYRBWCq+w==
X-Google-Smtp-Source: ABdhPJxYllGAp89qGKBUY9CRcCYsmOyzxUsDbNmmZDlL9qyAdCHYx6cToSudkZmprsyItEq6Bi5LUA==
X-Received: by 2002:aa7:c3d9:: with SMTP id l25mr1150387edr.188.1612323393258;
        Tue, 02 Feb 2021 19:36:33 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id jp6sm350288ejb.17.2021.02.02.19.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:36:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>,
        "Johannes Sixt" <j6t@kdbg.org>
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
        <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
        <87czxjomn8.fsf@evledraar.gmail.com>
        <xmqqtuqvn0i7.fsf@gitster.c.googlers.com>
        <87wnvrefbv.fsf@evledraar.gmail.com>
        <xmqq8s87ld8y.fsf@gitster.c.googlers.com>
        <87tuqvdy1b.fsf@evledraar.gmail.com>
        <xmqqo8h3hybf.fsf@gitster.c.googlers.com>
        <xmqqczxjhwgv.fsf@gitster.c.googlers.com>
        <87r1lxeuoj.fsf@evledraar.gmail.com>
        <xmqq35ydeu94.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqq35ydeu94.fsf@gitster.c.googlers.com>
Date:   Wed, 03 Feb 2021 04:36:31 +0100
Message-ID: <87lfc5esao.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 03 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Getting back to the point, whatever anyone thinks of returning SIGHUP as
>> we do now or not, I think it's bonkers to ignore SIGHUP and *then*
>> return a non-zero *only in the non-atexit case*.
>>
>> That just means that if you do have a broken pager you're going to get
>> flaky exits depending on the state of our flushed buffers, who's going
>> to be helped by such a fickle exit code?
>>
>> So if we're going to change the behavior to not return SIGHUP, and don't
>> want to refactor our entire atexit() handling in #2 to be guaranteed to
>> pass down the pager's exit code, I don't see how anything except the
>> approach of just exit(0) in that case makes sense, which is what Denton
>> Liu's patch initially suggested doing.
>
> Then we are on the same page (assuming that all your HUPs are
> PIPEs)

Yes, sorry, PBCAK :)
