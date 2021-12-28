Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF6BC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 21:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhL1VvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:51:08 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:36707 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhL1VvI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 16:51:08 -0500
Received: by mail-io1-f52.google.com with SMTP id p65so24068501iof.3
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GuLbdRKMiojQosx48JO7Mj3OELnFq+YRNIlJwzI+CI=;
        b=wtNU6yjafocxlu+rDogAvIc3CyLNKRVAPFv2/LqHegsKdgb1RIqo3FAR+pOjJbHhwX
         5yJ4zTBx/4OkvSC0yyuML0xky9ZaM6qO6JgpZdtUEc7OtwRkdLX5zRDggJ88y9B+Z2UF
         UAO7RLFlrV3u4/HP6+KsRZIPH854x7cz7HQtBAlKDEle+yVz8eiw1xV7wYYPI6wAzc23
         PoAVkvxvg0zWYFZnM2BUMc/rL30oC6zIHwkX+zkVvtjDiIQkdTN5LMQb2p4VIXK0FBho
         MQFYB7WKIANZyG1KshD3dfzgz0NU9Ylk1Cgg5wA5HO0SYoP/sqA+V7zs8je//Oc4j6QM
         79hw==
X-Gm-Message-State: AOAM533CpoIvoyH8kurCiF5OmsdO7Ey4OCp6dAfhbwfbqVTstMg1lTbC
        ZDja+bP8hP4zp/XtevihkKsAizjQHrxs8q0r+SyJPaGltK8=
X-Google-Smtp-Source: ABdhPJxKPC4JvIn7lnpOTy31pRIfcIXRHnfefyzHi7BLtB7yuRMl9zAhryIsOP/s0RWfUz+K7/3tlADaqQnuZ/tT8Ho=
X-Received: by 2002:a05:6602:2acc:: with SMTP id m12mr10285319iov.107.1640728267582;
 Tue, 28 Dec 2021 13:51:07 -0800 (PST)
MIME-Version: 1.0
References: <3e1548ab-5e20-9555-bd10-d6cbf2ffbce4@gmail.com>
 <CA+JQ7M-By65FVPnMFnwE8zx3T4O7DV3_5Kf2P6eZhP4Zcemorg@mail.gmail.com> <a8f3246f-2b50-e713-16c3-1d23b80a42a1@gmail.com>
In-Reply-To: <a8f3246f-2b50-e713-16c3-1d23b80a42a1@gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Tue, 28 Dec 2021 22:50:31 +0100
Message-ID: <CA+JQ7M9Ht5vSfDDEuYyK7pBPBvgjzi7L6jEYX8dkP4PMFK-M2Q@mail.gmail.com>
Subject: Re: request: allow passing -X <strategy-option> to git checkout
 <path> to auto-solve merge conflicts
To:     Andrey Butirsky <butirsky@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Dec 28, 2021 at 9:44 PM Andrey Butirsky <butirsky@gmail.com> wrote:
> Thanks Erik, please post your further replies to the mailing list so
> others could see it also.

Mea culpa

> On a topic,
> I'm not familiar with Git code-base so don't know if it even possible in
> it's current architecture..

It looks like
builtin/checkout.c checkout_merged
is responsible and calls
ll-merge.c ll_merge

I think other commands that allow merging strategies may use other
"merge drivers".

From commit a944af1d86e6171d68ed2a3aa67b1d68f00e1fe8
> merge: teach -Xours/-Xtheirs to binary ll-merge driver
>
> The (discouraged) -Xours/-Xtheirs modes of merge are supposed to
> give a quick and dirty way to come up with a random mixture of
> cleanly merged parts and punted conflict resolution to take contents
> from one side in conflicting parts.  These options however were only
> passed down to the low level merge driver for text.

It looks possible.
But perhaps the sentiment is that it's not adviceable?
