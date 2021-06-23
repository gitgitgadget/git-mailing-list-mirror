Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A1C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 23:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEAC960D07
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 23:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFWX6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 19:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWX6H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 19:58:07 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37316C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 16:55:49 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id j184so9847096qkd.6
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 16:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pthF5qHj9SvsHQl2sqzqv6NYRtvFMRMNmvN5khLqiM0=;
        b=WcgnH4L/fQvw2ab1i2D5EmF5W5cclo3FwVSr6Uf9+cZPjBbB8cGxYPJfKY02uBFnJL
         Qp8uYDqFzRaA5PHloFEJuRjGTs+4gEptzPOZjUAAFaXuq+xbnx6Mk9XImGwULLKLrR1u
         eW2Rrz2PgUEnqZhNjCT4IoBZnhNgzOLOlxn8WpuoeiUzAgkLZvifpTFiBw+kSJVh48Fz
         uNWgWTzVVXybL7u7ZrgKSt+LlGFbnSK7hz1TfDONeuwxI83Z3+dLT02C5w367WjLBP24
         sJVRFvaSJFZZwnSFCPzDhwXcdlMl01txQ6aouXng1mGxUxY9rBhnC/vC5PauCC2vJhA1
         ncpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=pthF5qHj9SvsHQl2sqzqv6NYRtvFMRMNmvN5khLqiM0=;
        b=UsYPChBhcxOtg6objZ61BrVfevfK6pjzoJsmfzOqnzP0Wef2Pnu7oTUxxvFYEsO55n
         lUllmJQfx6WBzBsJfPHiZkjqQ/WsHQLTM7cWFnEuohAnKHWCPam/YVElqXYsmj43bHrp
         aB3Ii0uKmTYXd3NDeVeRVAUbA6/j4rfyq8K0NdgaYt6j9trjTusLBomxOU4NzVhVQRLZ
         BDij5qV2Grp374B+R0xgk+T+SLDBWPzjXMVWUtqQG98cJmcf2rpPdZC+0Ru5uRfN2Vsy
         6Zjqy7PYgbRmaEzRQRLQ9aJPKrjuHnwBT3my020PckplCLhdyUa4UZBBAFe3jxdFYWvJ
         KC7w==
X-Gm-Message-State: AOAM533oDAtg6UPCL79dWIUER2F6sLMtEECFz3CALe12yb2s6ZOogv1j
        /dja9gi3HMZ6sDuSZsrivU1rz6ddLSoo0LMsJCXSfWiUxl4=
X-Google-Smtp-Source: ABdhPJxXuR3z2VsblhWpaAzFdbAcmDYXlzdPewtz/1ABmgYsV9xWH03cjwjFvHrU5ByleI5j0QicN2MC58nmJwtPSmY=
X-Received: by 2002:a05:6902:572:: with SMTP id a18mr1039527ybt.220.1624492548093;
 Wed, 23 Jun 2021 16:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <CADdMKP8y3TjeCyJaxazYFY9zN2QpnMVZyRWnpoTLMcZ0ZPNMzg@mail.gmail.com>
In-Reply-To: <CADdMKP8y3TjeCyJaxazYFY9zN2QpnMVZyRWnpoTLMcZ0ZPNMzg@mail.gmail.com>
From:   Douglas Leonard <dleonard.dev@gmail.com>
Date:   Thu, 24 Jun 2021 08:55:33 +0900
Message-ID: <CADdMKP_J7BSBeEpc6oQTh=BMf4geZJ6PwNM5yqzRQmDyT=1oXw@mail.gmail.com>
Subject: Re: git-alltrees: root trees and subtrees without duplicate commits.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For what it's worth, a demonstration script is included which makes
parallel changes on various local and remote repos and does origin and
subtree push/pull..
In future plans... it's possible to fully reintegrate the subtree
commits into the full branch point file tree locally so that they are
cherry-pickable too, as if all changes were made on complete local
branches.

Regards,
Doug

On Wed, Jun 23, 2021 at 10:27 AM Douglas Leonard <dleonard.dev@gmail.com> w=
rote:
>
>
> Hi all,
>
> For a very quick introduction, I'm a career physicist. I just thought I'd=
 share a detailed method and implementation I developed to improve on short=
comings of subtrees.
>
> This says it all
> https://gitlab.com/douglas.s.leonard/alltrees/-/wikis/home
>
> But to repeat a little...
>
> First, it allows a container "sub" tree, ie syncing only the non "sub" pa=
rts of the tree to a repo.  But maybe more importantly, when it pulls from =
the trees it's able to "remap" or reconstruct old commits back to their ori=
ginals to avoid the duplicate commit issue of subtrees.  This is round-trip=
 reproducible so consistency is kept both ways. It avoids the need for squa=
sh with subtrees. Compare the two images in the wiki to see the difference =
between subtree without squash and alltrees. Non-FF changes made in a tree =
repo show as branched and merged. Traditional advantages of subtrees are ke=
pt, primarily that users/developers of any one repo don't need any awarenes=
s of how to use the subtrees or the other repos.
>
> I have used this some, but not extensively yet.  In my use it has worked.=
  I think it's pretty quick, but I haven't tested on large projects.
>
> Cheers,
> Doug Leonard
>
