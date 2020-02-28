Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B01C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 21:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1152D2469F
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 21:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIjRUd86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgB1Vx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:53:28 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:36685 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1Vx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 16:53:28 -0500
Received: by mail-lj1-f175.google.com with SMTP id r19so4990714ljg.3
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 13:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KixRGsOwkZSeWqwQBHp0ccH8jIIlkqgvKlBmvwZb6/s=;
        b=lIjRUd86aXW+Xv3/JhooYx1PzS5myBlAk5DpYnThpkpbnvcVkCtj4i6T0eRvy+eIoG
         TMKaOvo5oNaFpWbfh9rx5UCHDpPPx/I2hU1n3ksz4AXiYV+P3z6T24Ow2427zCeHI8+V
         oySinCFHrrPcTIJWCOH58k4i0g9/x5De3n5fcpAa/mh+ger5YLJzEVQA2SKWYXPdd8P5
         Okd3g6k1veg7x5LcHBuE49mVW6Vt+i2KwaHrji01Vas92ML3lc32xtStE2hAopLQUGPG
         lAUqB8VHMwVP0g+NnK1TDnFIK4FStOy9xvcCeiKgOWBvsgctdlzWNdtFjl1So7StuWL6
         DJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KixRGsOwkZSeWqwQBHp0ccH8jIIlkqgvKlBmvwZb6/s=;
        b=N69i5qeDseyzeB1fYBEsrCFOGNggkfC7RxfL09pMr4thhNii1nIa+QkRN52UVGwWOm
         SyWEQLe8IEeArDCqDtRvLQ6V4fwkO5tujKCLivBGpzbbtmzDIL8Z+guih96M+eU80hSx
         CGu7jWhvQdSCkWu4tDzD7XeRA8WngeVPFtVFkih4rc2SWOhY48GiEyLpI8a+a7g0EMPw
         fBnbiMI7SlJ2CPG56xY0tshCKGzw1jNmNe9z9rUnemKZSM6iFymUIM0CHIWi/qB6/7zF
         aIv+Cb2K/Eldjw4UT1tjefh4JghAqDlKJxvZO8+A1QN470axxy4QVZW1dCp32YmwvIwD
         sM6Q==
X-Gm-Message-State: ANhLgQ1lQHAogo8IpynIJhI50Ep9Hc3TAKiIa3BVLfb9LxE5ZqCLPd/Z
        Gd+jF6kEMwQpiVbHzuZ5rRT8Jdz1bnsykS8PRl7tSA==
X-Google-Smtp-Source: ADFU+vuPkEW8Zf9MeuPlQUfRQS79ZzFmJ06XVboTUs86fm7SczPvLWcTjtYzIiqMSL3vazeL8EkpIdK2rZXBtD4miHQ=
X-Received: by 2002:a05:651c:1183:: with SMTP id w3mr4318575ljo.232.1582926805936;
 Fri, 28 Feb 2020 13:53:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHd499DC7pOB3kD7nAG79GrufKrV-8p4vSZ5ZEPQb5gdXrNakg@mail.gmail.com>
 <CABPp-BGrwNf9p6Ayu=A4CF9ydww8tQfvzFqFO1rNm-QG55yG6w@mail.gmail.com>
 <xmqq8skmeabd.fsf@gitster-ct.c.googlers.com> <1320071582924243@iva6-ab1cb434301d.qloud-c.yandex.net>
 <CAHd499B3HbXPo+O3u3qA-SfJ_dV=z2k5v09mVHtbjXGkAaNBvQ@mail.gmail.com>
In-Reply-To: <CAHd499B3HbXPo+O3u3qA-SfJ_dV=z2k5v09mVHtbjXGkAaNBvQ@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 28 Feb 2020 14:53:12 -0700
Message-ID: <CAMMLpeTheUdUx0GZL2pQybewkPM2d-NB1-zvV9qu=VOzrMiddg@mail.gmail.com>
Subject: Re: Why does `pull.rebase` default to `false`?
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Konstantin Tokarev <annulen@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 2:23 PM Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
> So the problem statement is: Prevent newbies from doing a merge commit
> on pull. Whether its a rebase or not is beside the point. I think
> making it --ff-only would solve the issue nicely. It forces them to
> make their intention explicit: Ether do a merge pull, or a rebase
> pull. But you are forcing them to pick (and ultimately get educated).

I actually wrote a patch that prints a warning on `git pull` if the
user has not set pull.rebase in their config file or specified
--rebase, --no-rebase, or --ff-only on the command line, but I haven't
submitted it because I figured that it would start a big argument on
the mailing list. Since that argument has now already started, I
should probably just send the patch.

-Alex
