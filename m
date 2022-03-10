Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2FDC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 20:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbiCJU0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 15:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiCJU0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 15:26:36 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3FED94A
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 12:25:33 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id e6so4852118lfc.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 12:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFBMTErsMrEPlrDvS5bNSjFnMvSNfrHGSrKFJBrXLLY=;
        b=NCcl5Sv0/vfrEBjrobkJnGpbjfGrXlOQornbWEtCKcid4ghjPM7b64MYlIRFeQOKNF
         KxjlYC8vLf0kETs7qP4nKAv90HZsed/i21RQGmvNZLCjxzMF41an6FNzUqFCDHzml1Gq
         NZBH/P0Dm0B9hOzqmk+9I2YawI/86HFyfhYcEDraIewyb7tqK/gUQbCx39yNFVTnaFZA
         tUQuf2IY3A46XRnpyYpx7FdhM/0dobPDiMqF/eJ9Ni3gxNA+XXW4KiPvn45WU4Ak6pSw
         iR4R4Fmt48dBnHOonR1D/h1uorJ+pME7xAd39EGk5COnjEM1xWXxAKTi4BNCdszi2TlV
         UjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFBMTErsMrEPlrDvS5bNSjFnMvSNfrHGSrKFJBrXLLY=;
        b=krwvE6W/0ZdZbtOfwFxq/1jvUbmrEnUeCEws5QwX+m7FwiZu9qqZ99oaE6gvgBr7lG
         D6hgJR0HFvIAfS7csq4gCJlEBIIHseXcjpai1CJgRl0vuLhV8knUkYXfwcjnV76M8Lzu
         EQueu7T5li9hpDckravLvy8RqAk7+eEDZ880dhP4qtco9X9hqeN0jAOysUd+YXPAoiip
         iWRKD/FKuJvRf8LXD9r8j3ho1wL8s2aeUY7k/Zd5jINew6gNTPuXLbQcmck1MckRUWzG
         IqBdYPl4yG6O53eetrjJ+ARy3LCq5amDGfAH18iSYGlELwZjVasIL5JFUN6NwBSuliJG
         odcw==
X-Gm-Message-State: AOAM533t15aFeDRLrp2ywX93izGVlDkX2JBfdIo5zuh/fziOmlnt5azN
        wgelAmiLTsPtVoqzwrB5+TSARPJO6Rv7O8E1/38=
X-Google-Smtp-Source: ABdhPJxq16sbSVObERZ7Yv1peCP2zwaOvYuvH1xu7KO8dgPRGlycH97CaygHLOJ6/USjoCB50SiKX+s+tq2r0paPqxk=
X-Received: by 2002:a05:6512:2018:b0:439:6be9:8b82 with SMTP id
 a24-20020a056512201800b004396be98b82mr4048135lfb.120.1646943931843; Thu, 10
 Mar 2022 12:25:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
 <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com> <e31886717b42837f4e1538a13c8954aa07865af5.1646866998.git.gitgitgadget@gmail.com>
 <xmqqo82eirnv.fsf@gitster.g> <CANQDOddU_WXD-6ncDGBrgpsuKT-XDGC=SeaaQTNQFdODFZ7TkQ@mail.gmail.com>
 <xmqqcziugtpw.fsf@gitster.g> <CANQDOdcDbYHyRuJj0hV_LcYPJdkoJjF_EGN4CXpndc4VQ9dVAA@mail.gmail.com>
 <xmqqv8wlejgc.fsf@gitster.g> <xmqqtuc5d1hp.fsf@gitster.g>
In-Reply-To: <xmqqtuc5d1hp.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 10 Mar 2022 12:25:20 -0800
Message-ID: <CANQDOdfvADcZ5Ng876EO=W2w+6ROvkWAm=XaAOtSUnxV5GGAXA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] core.fsync: introduce granular fsync control
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 11:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Neeraj Singh <nksingh85@gmail.com> writes:
> >
> >>> > At the conclusion of this series, I defined 'default' as an aggregate
> >>> > option that includes
> >>> > the platform default.  I'd prefer not to have any statefulness of the
> >>> > core.fsync setting so
> >>> > that there is less confusion about the final fsync configuration.
> >>>
> >>> Then scratch your preference ;-)
> >>
> >> Just to clarify, linguistically, by 'scratch' do you mean that I should drop
> >> my preference
> >
> > Yes.
>
> Let me take this part back.
>
> I do not mind too deeply if this were "each occurrence of core.fsync
> as a whole replaces whatever we saw earlier, i.e. last-one-wins".
>
> But if we were going that route, instead of starting from an empty
> set, I'd prefer to see it begin with the built-in default (i.e. the
> one you defined to mimic the traditional behaviour before core.fsync
> was introduced) and added or deleted by each (possibly '-' prefixed)
> element on the comma-separated list, with an explicit way to clear
> the built-in default.  E.g. "none,refs" would clear the components
> traditionally fsync'ed by default and choose only "refs" component,
> while "-pack-metadata" would mean the default ones minus
> "pack-metadata" component are subject for fsync'ing.  An empty
> string would naturally mean "By having this core.fsync entry, I am
> telling you not to pay any attention to what lower-precedence
> configuration files said.  But I want the built-in default, without
> any additions or subtractions made by this entry, just the default,
> please" in such a scheme, so do not forbid it.
>
> Or, we can inherit from the previous configuration file to allow
> /etc/gitconfig and the ones shipped by Git for Windows to augment
> the built-in default before letting end-user configuration to
> further customize the preference.
>
> Either is fine by me.
>
> Thanks.

Okay, I'll implement this version, since this is close to my preference.

Under this schema, 'default' isn't useful as an aggregate option, so
I'll eliminate
that.
