Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD2C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 06:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1975B61151
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 06:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhJFGGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 02:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhJFGGu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 02:06:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD931C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 23:04:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z20so5316462edc.13
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 23:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrUXqmRqG3QSRXt/V6OtF10t4oMeRxe6pekwxlbDJKo=;
        b=nFm3uKUcMboGATYzEpj56qy3XBHh18AoSIvzsMfVPNmuueP4x0qdfT7zfzPNLOryJj
         aYAO70VCRpVtIUd7tfbN0hjlxzWj5ifWO1JZpsomXbWN0ZwY4pgQHAkhvui3ilgdmCSn
         JuOy2QmosdmOy3GI6gKyAm38UdEk0CwTgeEV+YzXZOty4OUFa4cc4vD7A2WSOeV6/Hi7
         aGaD4PT4zVtn9gjI/OQGCDA0xH0SfERe3cz+hEGGz8HQ5Y63RUFPYO9Hm41JApA5llJY
         QwviOK75H/XHYUXoatm+hb/HSfmc/Yyoy4LKwsgPcBJ/1lQOXgsv7hbLZN97aSwDrq5l
         ovxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrUXqmRqG3QSRXt/V6OtF10t4oMeRxe6pekwxlbDJKo=;
        b=KlM+NtldEFhCUpNHAnY9LEY8wyElR0S5TRLFSfblPP3Ix2LHU6Yn9ZQ2m34IsM/iH9
         4FijKt7Rwbfa8HoZhMEZq+bVeKZNVTmV+cStOG4A9+cdKkY1GUEq00i26mHdsGhpaPMx
         2hjhVci5IA1CCQchnTtzCSoWcKGfzwVeYgCM8QFB2mCWDZGeI48HJACVvRkGiCCyWkvI
         ABU6VNyI+Iw/OREvowFgJlZBH3bAn2H6zUC836beaFAr/VjVnwSK/FjTOVwxK2BAJINs
         2pHYCm0+1nCwGzJYbKYmopBU65cW43NCvhi0En9mu0Z36Idm12tIk2H+7nYNQikj3neH
         l3EA==
X-Gm-Message-State: AOAM533PTzEU0ZFj048aHhdeCarOoiBBVJLTF7DBX0j32lEzMj0HB1va
        iGYm1H/Rmm46JU1OqM7dvm1evNGv98xbrOEf74M=
X-Google-Smtp-Source: ABdhPJyGOaH8GI5U9SN4nyKvhAHA+47t9/E8jKHXjRjkxJfVd4EC1ODzPMzQHKjSL4QcpC4LHVmNxTL8IXy+Btb8Y4w=
X-Received: by 2002:a17:906:c205:: with SMTP id d5mr30251626ejz.74.1633500297362;
 Tue, 05 Oct 2021 23:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
 <20211004190050.921109-1-aclopte@gmail.com> <20211004190050.921109-4-aclopte@gmail.com>
 <31f46980-7e40-46c0-87b7-f5ea7034af2b@gmail.com> <20211005194224.qcblxih5rlehzo4d@gmail.com>
 <88adcdf1-7b10-c834-84ad-52fe273c0ced@gmail.com>
In-Reply-To: <88adcdf1-7b10-c834-84ad-52fe273c0ced@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Oct 2021 23:04:46 -0700
Message-ID: <CABPp-BHRw811_9M3hOEKUDVJkcY_BTYViH3ctsu6CDz9h-cCPQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Documentation/git-status: mention how to detect copies
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Johannes Altmanninger <aclopte@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 5, 2021 at 10:05 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 06/10/21 02.42, Johannes Altmanninger wrote:
> > I wasn't sure whether to add backticks to status.renames because we are
> > already inconsistent in this file (search for "config option").
> > Anyway I agree that backticks look better here (makes it bold in the man page).
> >
> > Maybe we should automate this? We can write a test that makes sure that we
> > always use backticks around config keys, at least for new changes.
> >
> > ---
> >
> > I didn't add backticks to "copies" to be consistent with this part before the context
> >
> >       Ignore changes to submodules when looking for changes. <when> can be
> >       either "none", "untracked", "dirty" or "all", which is the default.
> >
>
> I think for consistency, we can go with automated style changes that use
> backticks to monospace:
>      - file name and paths
>      - daemons/services
>      - configuration names and values
>      - file content (use ```...``` block unless inline)
>      - command-line
>      - keyboard keys (dunno?)
>      - any other inline text that needs to be written exactly
>
> I have seen many times articles that say `Run "foo bar" (no quotes)`
> when they mean `Run `foo bar``.
>
> For the exception you mentioned above it can be monospaced as part of
> automated change above.

Doing some cleanup passes on the documentation files would probably be
a good thing, but it'd probably belong in a different series.  Better
to keep this one focused on the fixes being proposed.
