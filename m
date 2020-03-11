Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B604C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374E92073E
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4gG51Lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgCKU3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:29:42 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38935 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgCKU3m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 16:29:42 -0400
Received: by mail-ed1-f49.google.com with SMTP id m13so4548952edb.6
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Jeo+RYUqikbWuVj900MpR53PumUdHJwmNTns/SzeNY=;
        b=S4gG51LvnSE3qJzr39PEYAjjV3ZRQRXp+XvzWoz2J3FcYuXdixJ95UzbUVvKejGl0X
         rXtGrPCFpdfc97mj6Gtoz/VDkOVK6JsFjAHjqPKY7G0IE/qI2DfT7+4YYKmNjoKK1ZsR
         VGhTEfSqcgj65r9Swkyoh1PS8HfhL1tPoj/4MvIJr3l119P3M750HMA37S/MfzW4HCpI
         T3+wit8I8lLnKL2gvoUvU+jZSHzrvyBWyG1KPnY3mTJiyPaz82fNgr/BD5edvbwEfuXm
         Ipu7yFfiazzox2ZkfmYiyR1gYFZ/V3WPJwAKfnkcxqR1wSfYQNfzQOpsFBY0MdT5uTE1
         EUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Jeo+RYUqikbWuVj900MpR53PumUdHJwmNTns/SzeNY=;
        b=fxPMKI0j3U+SiOP1SfQZh9iADwRYO00j6XO2zyLurBOQgPzMq85DX3qVTzAsqPfAPD
         W1Ced9CZK7qwU+rqoXu/hqdmd1ZJ4pXyi/L4Mj4/2K+V3synGnsJy54TBNXryk7tjsWA
         UNq/Ww7n3W1PG+0Uy4iW+yTFC5aDHSBQ6d2N9tHssZz08EnN5/n88JDwASmXvBIyDKZw
         ROOAmjHHlYW9LqILd7kmomwX4OUg2qm26Ba19cSsM9P1AI6apHw/iFgXtG4NMzogBGPL
         JSX+RP44JrgQGw14T5EDn0DPoVpEb1mlAwY8IVQcd/zDgEpV6lKgBS8OYKCfoSzIYdn8
         J3fw==
X-Gm-Message-State: ANhLgQ2X3aGwrlFicmeB99NfBwDjr1dFdSMMYdZKB4WjU5UUckcVb+aT
        nf8vuHFdvdGTSGiyGIQS5A5pmkmFqzxkMYEpkXMZG8ELQLM=
X-Google-Smtp-Source: ADFU+vsBImE/P9583cmwQ8m7gXmwDVYUNLIWJMM9Nmld+zjEB2ty4rZc8wayLGGmdXVRuKMW+usHszdw48Oy50Y7lKs=
X-Received: by 2002:a50:f70c:: with SMTP id g12mr4753439edn.142.1583958580033;
 Wed, 11 Mar 2020 13:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <86mu8o8dsf.fsf@gmail.com>
In-Reply-To: <86mu8o8dsf.fsf@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 11 Mar 2020 21:29:28 +0100
Message-ID: <CAP8UFD31+sK5zyLLgkOvJ4fj=PC3FTa9nXcpPeM-fWm9ByoKjQ@mail.gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 10, 2020 at 3:50 PM Jakub Narebski <jnareb@gmail.com> wrote:
>
> Hello,
>
> Here below is a possible proposal for a more difficult Google Summer of
> Code 2020 project.
>
> A few questions:
> - is it too late to propose a new project idea for GSoC 2020?

I don't think so. Students have until March 16 to submit a proposal,
so they could still submit one based on this even if it's late.

> - is it too difficult of a project for GSoC?

I guess it depends on how much you as a mentor would help the student
getting started.

I think it's interesting and worth adding it anyway. Can you add it to
SoC-2020-Ideas.md?

Thanks for the idea,
Christian.
