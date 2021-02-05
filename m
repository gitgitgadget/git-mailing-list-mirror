Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C60C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 06:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F42164F58
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 06:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhBEGYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 01:24:15 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:46724 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBEGYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 01:24:15 -0500
Received: by mail-ej1-f52.google.com with SMTP id w2so9890062ejk.13
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 22:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/1zZSDFPin7gWqLyeVn8bYrQsXcsM5qMH7w8O9poqU=;
        b=hL4SU1ZWsiHKiFhvpQ4wUyXXOoG8+0mReYi+//qMN+J+JpP7+usQGz8EXOCoZwgjaJ
         3s9zd2DUEWyM0cPDzqjMMftAmtVztBQHhRCmYS6XljcceJ4JbpvbA9SvOho0VsgZfjnj
         q/e8RxpRt+tz+e09UnGhevnLKI7zyK6IEtKmJFdaybq3hGE6lCofEemrSlMpS16UGLS7
         muGanor7jE0jZNyQUb49vL1tFnNXRr/CDnQOnWQNotrHHUvZsCXEUwiDaYzU9O3WcKl9
         uSt+up3vi0CmZRb3Q9ih7kYhv+FZsaWHKrjKscisHlNHdu5Qb4gWLfZWAi6N5OkLu2o8
         slmg==
X-Gm-Message-State: AOAM533V5K6F7/2ztCso3NqOxFqojN3m5UIo83b/rbfyivb3F/5p0nIT
        Gt04uM+IUkRlws/I97YNdB0q7o/c9AsLUX0u9Sg=
X-Google-Smtp-Source: ABdhPJyKFSOlwa54VRZJWsEdHx4ie9UyWODjyHP6/G79Cy+5Il6HAy/LAf/k6DVgT4/oqkqQNO7C2YmANmV85YFCiWs=
X-Received: by 2002:a17:907:98c3:: with SMTP id kd3mr2636910ejc.482.1612506213774;
 Thu, 04 Feb 2021 22:23:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.854.git.1612021544723.gitgitgadget@gmail.com>
 <CAPig+cQMn6oc4Jh=gb1jNfArXJBYhPRaSzJJvvbvprit6_OC0g@mail.gmail.com>
 <CACPHW2X2UGAVmNM+cHXs6dwVfZbgLFZ0iUGU89h04H5czAt1Ww@mail.gmail.com>
 <CAPig+cS-hnwp2HjkkFPeJ4aibFHnJ0VZq0DSVgdWB0H_q5=oXw@mail.gmail.com>
 <CACPHW2VBEu=02HFhyrDes=6KceLtHzGDqBJVf2qAnD2s1f8VAg@mail.gmail.com>
 <CAPig+cSSU1P68dBomjRkO4jUqUnu+0ri5-3y0-H228-qONwhyw@mail.gmail.com> <CACPHW2WbY+c914vHV8cjfBC1GstF7PxfQFr-NF=EUhcF0YaCzQ@mail.gmail.com>
In-Reply-To: <CACPHW2WbY+c914vHV8cjfBC1GstF7PxfQFr-NF=EUhcF0YaCzQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 Feb 2021 01:23:22 -0500
Message-ID: <CAPig+cQMeK_vPuS-V3EAQUDHZaJ21VSgPV0m1CB_LZ8=9Bbgzw@mail.gmail.com>
Subject: Re: [PATCH] status: learn --color for piping colored output
To:     Lance Ward <ljward10@gmail.com>
Cc:     Lance Ward via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 4:08 PM Lance Ward <ljward10@gmail.com> wrote:
> I made all the changes you suggested and split it into two
> independent changes:
>
> This patch handles the --color option:
> https://github.com/git/git/pull/955
>
> This patch fixes the coloring inconsistency:
> https://github.com/git/git/pull/954

Thanks for being responsive and indulging this reviewer. The two-patch
approach turned out to be concise and easy to digest. The bug fix --
which effectively turned out to be a one-liner -- is an especially
nice improvement over the earlier version, and the implementation of
the new --color option boiled down very nicely to a really minimal
amount of straightforward code.
