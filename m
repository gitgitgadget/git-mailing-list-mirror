Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34FF92055E
	for <e@80x24.org>; Sun, 29 Oct 2017 03:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdJ2DWl (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 23:22:41 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:53351 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdJ2DWl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 23:22:41 -0400
Received: by mail-qk0-f175.google.com with SMTP id y23so12513365qkb.10
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 20:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YO2fsGNck+cWi+P8htTQe6RbAIQHZ2Y3gCWjn85f2cc=;
        b=GvBBaLT9K7EgyS1KngAft7vg1GcGBWz32RvYQymgAoyNhQTHJpiPHp5cR/d9EXCBVV
         f9JdxM0Az/DaR9s+UGngGucqiezmCNYPASK+L6LzXrvBPYVqpHFA3N1d7XWMfupO4P3e
         2VXbgQxp3d99Hj5zKQCPwqA/05x6nLwyK6HcqPrw56rIKzX/gqd8QZIjMvfkiQ1U2xrR
         gHZM97QpnrcaC4ed0pef8AsUVkpuwxrqz4Z06QpmbdkMpihRWTosqMzsTH7pZCyB0vKy
         cP18k8SCPDdcGiGf/apXLAOFvGqokEZPoRjZY0BxVK7V0YhjT11VyxXfr58yJ07CHZCU
         pLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YO2fsGNck+cWi+P8htTQe6RbAIQHZ2Y3gCWjn85f2cc=;
        b=cdz8hnSgFQ373QY3ssDn1jQBwNV/qcw13pOuwQbMe0YASu6MbBDgDooiskwKsCO2Nm
         mfu6Z3cx7LGXzdaNmnRe905y9jTHB44OVEjbB0zw45fOHcaUPZwIy1hKFQT/iI6HmENx
         4QlBzr86HRPpU6Us0JNxbCQPw80hJ8R8H5p85RTOQQUsEbT8RSOiHmPrI6vDj8FtkFJ+
         DVatdugzolyIfy/YUVxts/4T1JYMccKSVlozfDqgW8Om8k3EiYxUJHDoyW4vR2/WnADf
         a8/BLiBAGQLakkUXE5xEnftl8qiXyUkDjntTtki2iVFlefM3QXvqCVKBg5jhDnvT9HDv
         zLpA==
X-Gm-Message-State: AMCzsaW21zv5xal6O1fv9kfCdeJ/vwFQXhxmJvw+jxuC/MynztuRIIEV
        MeWRiinVEqj84bMuG8BEcMiuZr0hIYjtEAsE9BedUvy3G3M=
X-Google-Smtp-Source: ABhQp+SvLYriCqS81T14JeWPMKbbaw5dO3OmtYnX9JP6+JODHZPJ4qVibGx0nufXMpppehYYKmNx8zIkLAN4b8Pgqlo=
X-Received: by 10.55.33.203 with SMTP id f72mr7716947qki.176.1509247359953;
 Sat, 28 Oct 2017 20:22:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Sat, 28 Oct 2017 20:22:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710281917260.6482@virtualbox>
References: <20171028004419.10139-1-sbeller@google.com> <20171028004506.10253-1-sbeller@google.com>
 <20171028004506.10253-2-sbeller@google.com> <alpine.DEB.2.21.1.1710281917260.6482@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 28 Oct 2017 20:22:39 -0700
Message-ID: <CAGZ79kaVqSzzPebHN4=extkAPpyi=VagmjFU8mh_A_tYoJgU8g@mail.gmail.com>
Subject: Re: [PATCH 2/3] revision.h: introduce blob/tree walking in order of
 the commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 10:20 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Fri, 27 Oct 2017, Stefan Beller wrote:
>
>> This will be useful shortly.
>
> Something tells me that I will hate you in the future when I read this
> commit message and lack the context (e.g. when blaming, where I cannot see
> the child commits let alone the comment in the Merge commit).

Thanks for calling me out.

(Not making excuses, but...) I remembered some other senior members
having such commit messages, so I felt like I had to step up my game.

https://public-inbox.org/git/70fbcd573f5c8a78a19a08ffc255437c36e7f49d.1495014840.git.mhagger@alum.mit.edu/

>
> How about:
>
>         The functionality to list tree objects in the order they were seen
>         while traversing the commits will be used in the next commit,
>         where we teach `git describe` to describe not only commits, but
>         trees and blobs, too.

Sounds good. If only we had git-when-merged[1] as some easy upstream
function, then the original commit message would provoke less hate as
future us would have an easier time finding the next commit.

[1] https://github.com/mhagger/git-when-merged

When writing the patch I wondered if this could be useful for other
use cases as well, i.e. do we want to have a command line argument
to trigger this behavior?

Thanks,
Stefan
