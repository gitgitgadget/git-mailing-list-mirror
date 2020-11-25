Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B94C63798
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5465206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbgKYR27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 12:28:59 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:35019 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731414AbgKYR27 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 12:28:59 -0500
Received: by mail-ej1-f66.google.com with SMTP id f23so4153764ejk.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9k7xgNKcNYrQs1xN1BKjlN/zMln8aCdbzsFL+6XBCY=;
        b=scIXS3/AWRTIja6vr8vsspmb3La6FkF1WBWDuHo12xQa5JzKkP6MxEQCVKhX5EoNp0
         eHZs0SgaUMFiTmNX5AwYQnim2LN/C3bWcU5/oxlTf29pjotMVg/Rj76t/VNkEtKQQ1f0
         sKuzfsMkyH122Hg35EO7p1A3hPZj24M2Wz5TQcT0msK4qaKc5lHelsPyd+4vVVpjlktE
         OgSs1QQ30Q2GCgVfOPHOSb87CGu1Abhfy9J2MFSPVm7Eou3pw9rzmALncGaVwKvOmohN
         CzrbaEWMwUxqZeZduWMumrdidgfLAmjdDdsMo9eRCWuKDlox5vOrTfKUzq7+IGCglbSF
         WChA==
X-Gm-Message-State: AOAM531gK8Dl1lFXTJF05yCfKM2jVEl1dCukoNtR6Q56HoXR77zxPK4Y
        T2EGz46XIh5M5POReq0BO5azo2jwUYW8bOHqeC8=
X-Google-Smtp-Source: ABdhPJyDKMGkqjvrxiRAwdw8Nupw8sj0JNzVRYjGJuttiiRP//p5xsTaUOM1WHjKKzOYlGN/xdH1/PW/nLbu0Kc60RE=
X-Received: by 2002:a17:906:d8a9:: with SMTP id qc9mr2224208ejb.482.1606325337735;
 Wed, 25 Nov 2020 09:28:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com> <0e6a7371ed4696f6cc85df07466fb6c20d58d62e.1606147507.git.gitgitgadget@gmail.com>
 <20201123215122.GD499823@google.com> <xmqqy2irlmq5.fsf@gitster.c.googlers.com>
 <91af356f-d0a0-1149-15dc-32da803ac6d9@gmail.com>
In-Reply-To: <91af356f-d0a0-1149-15dc-32da803ac6d9@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Nov 2020 12:28:46 -0500
Message-ID: <CAPig+cTQMCho=wFHhg-ACrP2oOEQwBHnfmV-Rk1vARpF2Fafng@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] config: add --fixed-value option, un-implemented
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 9:09 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 11/23/2020 5:41 PM, Junio C Hamano wrote:
> > Update the document and help text with s/value_regex/value_pattern/
> > and say "use value_pattern as a fixed string, not an extended regexp",
> > perhaps?
>
> If I go about changing all documentation and error messages to say
> "value_pattern" instead of "value_regex", should I also update the uses
> in the *.po translation files? Or, should I leave them unmodified to
> trigger manual intervention by the translators?

A minor request: If you are going to put in the work to make that
substitution, perhaps change it to "value-pattern" rather than
"value_pattern" since a hyphen is more common in documentation for
this sort of thing than underscore.
