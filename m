Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6526C7EE2C
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjFCBO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbjFCBOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:14:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F5B10D9
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:14:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4f89f71b8so3698110e87.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 18:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685754786; x=1688346786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FOh7/vmgY6s+4ZE1u8Sn5yPLc6N6p6AKjFP5LRdnl4=;
        b=MgEJ/Sgwb/Z2UaqpuwArhzqGn1iurimBl1C2DuVxmbxAc2aBNHvSi013TM7b2R5oQl
         eiM0JwYYRl+KRfQiKq65OkvP3/ECLhKYkLxPzwqoH5YDS+OQ/su2mbTma+CgTIiDPhlL
         W5iQ60uTxiPVUnWnUS+lpwxKsu13VjRjBqfyMYaR9gDyg3M1+ytZII9Gpk2H8JaUxxQm
         g8/ptF6x60OmzNCwxdj4J0LJIQzjCK/U0X4sTLzHhR/WbwtH+KDp+wvuzQmd0M5X0PS6
         tcMN1Q6pQxnL96Iu7YG+WIIgJENvxMA3PKbpW13h6CF9DAjSd42KsKvtRv34FCzgJZhW
         Labg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685754786; x=1688346786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FOh7/vmgY6s+4ZE1u8Sn5yPLc6N6p6AKjFP5LRdnl4=;
        b=Sx1z8hztveGzWbnGWAHXi9KCqvXFLG1XcClLikBBO8sa/SrpbTWaFsp9nrixZTjK/0
         TTiImcFAuUSvqr5zDaG25nwAqAWkSI0woWSjgz+7iry6WzvKDvJWG59Lkt3VjlWOZOjV
         mhMzPtlSAJPqOJ/HziVFIlYPovSAqKfXRdJqezcbI/EhaQZtej/4/ew+A+p0dNcuOAMU
         hBBYgiaWjrcnIhq6/Aj8129QeLc8/zqNoqEv61IIXXqB2JsqJQsnFGRZt0wMhX5kgnFx
         zpQNs1pWZwr1eUUJiX0waxVaGmaofjADL7kU4KMSidCzgjZ+gaL9g1jjUeqDdwyiQ8Le
         y3sw==
X-Gm-Message-State: AC+VfDyhQu8i0uX2ZulN9Ue40xV7AMchCbYaI4GUIfMH6V4WYMk+N/YR
        gi8kROz8TJ7PJIEIHIvxN8OrxQ2Npfz+qqKPah5JLtXKOig=
X-Google-Smtp-Source: ACHHUZ4KO0LulKEI/l3b8HLE/qClNQkVL/CKWxY9hnrxSQUxi+v53wvkN6alCsF51DpzxYvhcF80hstNS+91FKBQQYc=
X-Received: by 2002:ac2:5485:0:b0:4f4:a656:246f with SMTP id
 t5-20020ac25485000000b004f4a656246fmr2573040lfk.18.1685754785548; Fri, 02 Jun
 2023 18:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
In-Reply-To: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Jun 2023 18:12:52 -0700
Message-ID: <CABPp-BF9Xjww=BBkL4qQcENo-UCHd8eEj334ho1iO1EMbGxhZw@mail.gmail.com>
Subject: Re: Anyone know why git ls-remote output might be corrupted?
To:     paul@mad-scientist.net
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2023 at 12:27=E2=80=AFPM Paul Smith <paul@mad-scientist.net>=
 wrote:
>
> I have some scripting on my CI/CD servers that invokes git ls-remote
> and parses the output.  The scripting is in Python.  Sometimes, but not
> always, the output of this command is corrupted.  I've enhanced the
> error handling and I see this:
>
> >> git ls-remote --heads origin
> *** INTERNAL: remote branch lookup failed:
> Output:
> -----
> 8431d80571dea5cc8e6d0848f27124f66346dcc4        refs/heads/foo1
> aaec1feb1167cf3fbd39a36cdd7736679a9f4fae        refs/heads/foo2
> 6167c73fbaded389ff54d52a01878975f4a6d5e5        refs/heads/foo3
>    ...
> 3a2e8036a6f6605d4dd14c72bd395298bff9d80e        refs/heads/xxx1
> 3a2e8036a6f6605d4dd14c72bd395298bff9d80e        refs/heads/xxx2
> 795d2ff669041fc91341cf5bf820aibab79dc92bd741e77a7dcf71d94285a6ae494dc0   =
     refs/heads/yyy1
> 1496ea0ddab29ae3935754fced4bd5858cff7940        refs/heads/yyy2
> 1496ea0ddab29ae3935754fced4bd5858cff7940        refs/heads/yyy3
> -----

Can you trigger this problem with just `git ls-remote --heads origin`,
or do you only see it after processing by your python script?

If you can trigger with the former, what does
    GIT_TRACE_PACKET=3D1 git ls-remote --heads origin
report?

If the latter, can you find a way to minimize your python script or
find some equivalent shell commands with the same buggy behavior?

> Also a bunch of the heads are missing.  It's pretty clear that right in
> the middle of printing one of the SHAs we suddenly lost a bunch of
> output, and started printing stuff from later (in the last instance 66
> out of 131 heads were missing).  Breaking down the output above you can
> see:
>
>   3a2e8036a6f6605d4dd14c72bd395298bff9d80e        refs/heads/xxx2
>   795d2ff669041fc91341cf5bf820aibab79dc92bd741e77a7dcf71d94285a6ae494dc0 =
       refs/heads/yyy1
>                                ^
>
> where the "795d2ff669041fc91341cf5bf820a" before the "i" char is a
> valid start of a SHA for a head (not shown), then the "i", then a fully
> valid SHA for heads/yyy1 which is 66 heads later.

Sounds kind of like
https://lore.kernel.org/git/6786526.72e2EbofS7@devpool47/ which also
triggered for some other tooling and then was reduced down to some
shell commands.  Unfortunately, the thread ended without a lot of
resolution other than "don't mix stdout and stderr" and "if we slow
down the network connection somehow, that'll avoid the problem".
