Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC7AB1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 09:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfBLJgE (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 04:36:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39772 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfBLJgE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 04:36:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id f16so2194913wmh.4
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 01:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uDidofShNCxfoKG2DocDul6zclzGiXRFLxzs/AP9eU0=;
        b=TX0A+0PhRslgBy0Nb7ThKR4Ubw978vXZbgSrDQx1KSxHsKRwiHqJwZzTd1DiHpLbPC
         A0ME7Zf9SYuSnjZyjjeWNbwLN9xKNsB6yOTntBA4CrcjP0ZY4p+tQcFzy4MEhEGwg0tc
         YpO6Uessa+SeWF3kucEaSF6AMc+WIB+O7ZJ2YQhlmZwSHm2lZf6w/IUB2rNyF2vu9rUj
         /xg7e2oZ9ZwoaZUEy7LsvprfxPTVPpzn5dtLf/UTPmQYUvLytoamCpx9GOsv6NiCNXGf
         W4BwJZ9jqI2GmE1sgOaTXESwYj0GoXxPu2yuK/IJKP4kchCDaPZxIMs2mCxldT49+RSH
         p8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=uDidofShNCxfoKG2DocDul6zclzGiXRFLxzs/AP9eU0=;
        b=nyMYYUxWw4c+qyEs2nFqTnNY6Wn+EQTgJgiVr1fpGdQZPoXlu7awtq0+yLHypHCTKt
         BDzK4u4plS/+r9sHnIbiFoPVrUjDbO6VAno2H0pZiYUGrNq9/UwWYxtpShZpqh/Inq1B
         sKBzclWzhDntG3LDvZK5PVhaqPethB1FiJMetFsMatKUegCPoMnnyGsVaAORrGuli9It
         rXmH2ogRplCWFksm7e3B4YlHLdk1Oo+qrFclsEmRyWZTqvvD8PZKfnXvQcnqRoDJSY7X
         6ikqSuX7lRY2alHgY1ipFU7M3vso454fGfXxWxMJYN5UPD4Ckuu1duS+PBVgZNi1mhZm
         r7OA==
X-Gm-Message-State: AHQUAubgwApSxjyozfCh5Wrj7Y9iwOpXbBkRZD2Z3gbgFQqDlmqfBsVR
        EHsJE6JppNgziWeXYUfhVjk=
X-Google-Smtp-Source: AHgI3IYtbjrQM/OT3KO+Jig2k5qbgqiI2VvPnrGOPBiDxRj72evrMF6rTY34LraLKXidisHELRXt/g==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr2295104wmi.135.1549964162531;
        Tue, 12 Feb 2019 01:36:02 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id h1sm1043120wmb.0.2019.02.12.01.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:36:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     luke@diamand.org, christian.couder@gmail.com, git@vger.kernel.org,
        newren@gmail.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees.c: fix writing "link" index ext with null base oid
References: <CAE5ih79JYrcV9cxMBU88Hq=HHQOOyzpkq+kT2zAgDzs=ao+PMg@mail.gmail.com> <20190209112328.26317-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190209112328.26317-1-pclouds@gmail.com>
Date:   Tue, 12 Feb 2019 10:36:01 +0100
Message-ID: <8736otl56m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 09 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

I ran into this bug in the past but wasn't able to reproduce it long
enough to track it down. Thanks for the fix.

It would be nice to have a test for it if it's easily narrowed down,
tricky edge cases we fix are worth testing for...

>  I considered adding a test, but since the problem is a warning, not
>  sure how to catch that. And a test would not be able to verify all
>  changes in this patch anyway.

You'd write the test like this:

    git [...] 2>stderr &&
    test_i18ngrep "could not.*000000000" stderr

Or something like that. We have a lot of tests like this already, some
can be found with:

    git grep -B1 test_i18ngrep.*stderr

So something being a warning shouldn't stop us from testing for it.
