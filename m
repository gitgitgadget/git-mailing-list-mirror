Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16467C2BD0C
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 08:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2D020EDD
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 08:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNR82I5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404372AbgJPIqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 04:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404142AbgJPIqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 04:46:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF3DC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 01:46:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t20so1442373edr.11
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 01:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dO40K4ihkzyFpSBQF5Kx06B7VQfSRIAoggHYa/yZWdQ=;
        b=qNR82I5NUrSF59CGSw7L4dKcV7bC0aJ1ufNdeGzMoKnfy+T9gEmkMreAeV1cxfeUys
         wd1T8Jyi3KEzwufx3KhWQB0IIHOLn0sd5GyBWUhAaDh1bLadpsuONmhpeuWfINCUqr3x
         eU49u6AfkPELEz4qN4bxvxrw6Q/d8Ra24JPyjNB7EuxO+otSzICqipl6Prlr6BCIf4/m
         pTrmq/VrfBz98WV0qsjIlif9ejNe08zOW1FrPnE0o99wz9p2yauexKSkpKCSB6DT0XUN
         L7vckGdlV/P1lgQftgLPfxymAUYXz6Iw8M/D9tZ6OJ4L76P6NT1PCPOw/f+1TLSuuYpa
         tF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dO40K4ihkzyFpSBQF5Kx06B7VQfSRIAoggHYa/yZWdQ=;
        b=EBHNudVLhiQ5wxcnU6veuxsarEBknFf/DjUU3lEf290Xcdy2G9TKpao2W6GWNGYo4P
         kxz0hTbCfDNBRrPQ1x37VQY9AQ+EiWN8BD1CnLWHPZgpMPoVr+HKGIynWuRXFHIOBrPZ
         ZlMvko/Gux5muwjCJq0Vu4S5Gy3nTLgPi1m/nCdMBmo+PqmvwKzZZ2PzmhLCLthmZW9o
         eJ1XBqHPkIAX9qbHaoYOna/NtYGpaCaIw6DTERmLD1I2kCQfrFsJm4BTjlFgdkXi9OpM
         /U79rAqw34uuAC3Osj2AnU7GQHrfxEFimu6uZYLh4nORS2TprUBGVWyh5bJDMQQgnZhK
         ulQg==
X-Gm-Message-State: AOAM532NEoySIlV1a9o3c5pTFu5mFeGAo/d6VR5gYmvkOXf5PEWQ4zl5
        Ker2DgoEeYIDN6nomKtG0X+caLlLJpfVXIL77ZEJFfTjeQm5dw==
X-Google-Smtp-Source: ABdhPJz7lHSn0f9n0RatftURVkIqnFrgNumAZ/KPdg08hZEjziX3oymPBGNh1V78iuRBOa7MnkaQfe15qXzX8B+Xc/A=
X-Received: by 2002:a05:6402:2073:: with SMTP id bd19mr2541792edb.127.1602837974971;
 Fri, 16 Oct 2020 01:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdqGXp07VAUFGTsgvc83V6HgswhpqMnKGAbEaiWXpiEj_Q1rQ@mail.gmail.com>
In-Reply-To: <CAGdqGXp07VAUFGTsgvc83V6HgswhpqMnKGAbEaiWXpiEj_Q1rQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Oct 2020 10:46:03 +0200
Message-ID: <CAP8UFD0pZ_x4ET5Pns0TQO82HzAfRiJPOMzs8d47gh8K8NL_OA@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To:     Zodwa Phakathi <phakathizc@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Zodwa,

On Fri, Oct 16, 2020 at 10:28 AM Zodwa Phakathi <phakathizc@gmail.com> wrote:
>
> Good day,
>
> I hope this email finds you well. My name is Zodwa Phakathi from South Africa.
> I am one of the Outreach applicants.

Thanks for your interest in Git and welcome to the Git mailing list
and the Git project!

> I would like to participate in
> the following project by the title of Rename detection and the
> "range-diff" command in Git. I would like some advice on which
> microproject I can participate in. I am interested in the Modernize a
> test script microproject, Kindly advise if it is still available to
> work on it and how to set up the project.

The "Modernize a test script microproject" is still available but some
people have already started modernizing the t7001, t7101, t7102 and
t7201 test script, so you will need to find a different test script
that needs to be modernized.

If you find such a test script, please let us know before starting to
work on it, so that we can validate that it's worth modernizing and so
that we can avoid someone else possibly working on the same script.

Best,
Christian.
