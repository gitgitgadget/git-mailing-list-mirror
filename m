Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC0BC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520396101A
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhIJUVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhIJUVn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:21:43 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE02C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:20:31 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id 109so1931665uag.13
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GRA4It0a3pYf4bgLQNkt/CW94ylJZ8shHyZaOPguFQ=;
        b=VGmRyx+tOJps7fXV520+SDfEbCrR08RTqIbHtkMUuzBX7RTptKB8PyAFaJVs2EFKmN
         cL7gp6dm30lXoUxYloBeq/Y92W6B3HroWQlp/yVs3s0uNNIPbXcBiOsEo6XWCKlmTkEU
         WiaADjisBWJYwlqU/fHPMoJG6VsoStV7QENnKAa6wCpdmkG0pIhBdOZr6y02BbRqln14
         2Anw1j7B4J3R31h+LnbBpuwoDtuYY+cBRxPjt15Uh7Sd6enmfybzCYzuX79+2f7TftOC
         1Wu1FyKkpjUf7+8JM0Z1gEc7/w0iREutLJoxc6LeKyDjabhTEj6IWlaTiNf8lIHZxQAm
         T2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GRA4It0a3pYf4bgLQNkt/CW94ylJZ8shHyZaOPguFQ=;
        b=Yl7ugHn4acpz17ujN3kc0KocTt8ddfSe0W9UTs5EmLROq+Wv9DaNxjtrFIDf0479RG
         /U+6xmoL7B+MpL8fV6yAAuVG/qss14Yv1APw7z7AurDI80e4lQcMIxCq6tXBiiXxkrMp
         nc2dxltGxm6dDv8FoIrD2+AigK6v91lExXAk8ZojnWThOew5cVctTPSYoOdIZUB8gA48
         elfai5YFfmWM0Is4l6VHKOsfO2SAy02k0KnxPIFhFk0RQnpInrcVUYDEqHer59odk0jj
         yl5eQnKJhRpIuWvkDeg1EfI3gzdaazibbAuu/8rhANKJ6+e+7vJpqauC42D4X3J1LYi/
         hwLg==
X-Gm-Message-State: AOAM532a6VJSYDduVtkEaxw+n5zGGxM5lAUAPtw/tOmhhvQIAKc844gD
        7v7bA+muXOq9IOh5FVstLn0eklpYr2+ikG40ZVw=
X-Google-Smtp-Source: ABdhPJzegS/5T8FFU1wF+xO1j7935NUHNc7yRDeWaoL3cIJW3U7svXFcfoJGge3+jfY1FmsPHsNWn6xc93YHP5JqZNw=
X-Received: by 2002:ab0:14a7:: with SMTP id d36mr7415008uae.96.1631305230064;
 Fri, 10 Sep 2021 13:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
 <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com> <xmqqczpv99u4.fsf@gitster.g>
 <9075cdd1-e34d-5dcb-f2b8-69ae4abf587b@gigacodes.de> <xmqq4kawcmqg.fsf@gitster.g>
 <4500892e-9efe-550c-73fa-37a3a69bc737@gigacodes.de> <xmqqsfycs21q.fsf@gitster.g>
 <532d97e7-8c91-df6a-6d90-70668256f513@gigacodes.de>
In-Reply-To: <532d97e7-8c91-df6a-6d90-70668256f513@gigacodes.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 10 Sep 2021 13:20:18 -0700
Message-ID: <CAPUEspgfRtTNXcVkSQ2FOS87m-jOD_Rx60mH0VP4M58_cHaHug@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] ssh signing: Add commit & tag signing/verification
 via SSH keys using ssh-keygen
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ON Fri, Sep 10, 2021 at 12:49 PM Fabian Stelzer <fs@gigacodes.de> wrote:
>
> On 10.09.21 20:44, Junio C Hamano wrote:
>
> > Fabian Stelzer <fs@gigacodes.de> writes:
> >
> >> It it not so much an incompatibility but a hard bug in ssh-keygen of my
> >> own making :/
> >> There is nothing we can do on the git side to fix this since the
> >> find-principal call will always segfault no matter what.
> > So... we cannot do anythying utnil a corrected OpenSSH is made
> > available, but once we can link with a corrected one, do we need to
> > do anything further on the patches in your topic?
>
> OpenSSH will probably release a new version in October.

FWIW the crashing bug is only in master (I found it while testing
OpenBSD 7 beta).
AFAIK, once that is fixed the suite runs cleanly, but still does not
when run against
an OpenSSH 4.7 release (hadn't check why, but AFAIK wasn't the crash from what
I recall)

> I will send a new diff of my patch in a bit after the CI runs are
> through fixing a bug with some buffers that could sometimes lead to
> memory corruption (i war releasing a buffer while still iterating over
> its contents), a small test fix and a minor improvement using
> git_config_pathname instead of string.

notice that since your patches are already in next (and I know it is
late since I saw
your update), you need to send only incremental patches now, instead.

Carlo
