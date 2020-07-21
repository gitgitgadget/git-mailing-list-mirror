Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0A1C433DF
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 17:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2AE20792
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 17:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX7qYbYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgGURfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbgGURfH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 13:35:07 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A65BC0619DA
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 10:35:06 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 95so15655485otw.10
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Di+kw6e+uFNkZg1sMhfyrSGERbRGhVEjcsELM5mrlOk=;
        b=dX7qYbYNvUsfS3s69vjbBokbxBFrg9ZG4f8fMswam2B3wdEZ5NgpPaLkHytF7hhY9K
         sn0k8NoF8zWKlGZJ6Z44rL3RmGcfSOecuu5D3fKa4QyEBonW5pPxx9NpFyJQ2emIgVUQ
         XJuUBMv5VeJRBFe1RSe/b9+r0t5+rF7bqGFA/rPqw85GirzjR3KJXoeXLV4cXXe5Zs4A
         Ovl1XFgl5zBGmnaaLHEB6QQN7vbV+uvQiy2YY5PLtgZzqaeJLm/uXh4KvjyshmffJ0jH
         S2DD6Q1KFGnqYXFAXrMI9XcVyPW4AMzgLGxv9rYGE05V9TsQ7heF98/8ky6ZhVz6cyWf
         edjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Di+kw6e+uFNkZg1sMhfyrSGERbRGhVEjcsELM5mrlOk=;
        b=XGifJRyI3Qk7JX/UF9+QXY0GPifmV/Bl6Z4MHomeCOiehR4g4k7eK09JN5Lu7+oRkm
         pBcnFVy/mwDuE0+wCHyImik3N9AjpdcriNumJSmlArUu09KubRlhZNI+pTer08DwBL6Q
         lH0fpeFaN+6I5cDriSZk5Ac9TesZkN+Pe11vkSFjidNa99BrwQfXUlGdwtQakLnsy18t
         +czcO8mjaOIL6a8h6Xej2DTZ5Lwg/KhZQVSQbyQANl78X0hjEBZpp2prvvkRQllfppdk
         +vQ21xn+zwC2QVPpMjwSw5j4jTx/QdXplwP9Cx696kaHfTwvP54RbxhocEv9EibBqOHO
         vMcQ==
X-Gm-Message-State: AOAM533PVrPZI3FANsWsC2fKGXrnDuaL8dpRSRH2fTwRe/Pr9YihuxgG
        xuja6bqbCoU9jX5ABIE+a6cKD8pgECiAtQRZxpcdpETv
X-Google-Smtp-Source: ABdhPJztnbCdz3iwOGgpah7TEYbGWoiKnetYphEsgJ5SC/lRfan5P+jNxgNuZGuBSODjQLZT9pWS2tZlK8ldtffhLqs=
X-Received: by 2002:a05:6830:4c6:: with SMTP id s6mr25926325otd.345.1595352905665;
 Tue, 21 Jul 2020 10:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAD9n_qh0y84HC6sX1OxXWWv8dDMMA_tPv9zRknePVivQq_rfww@mail.gmail.com>
 <CABPp-BE2R3eUU7WD1Ovkn_OfVH6fc42DnXs5CuBTkMUcQsnCdQ@mail.gmail.com> <CAD9n_qim=g62TnckSG3-=1yPDCwQc3u0kYouVSU3f_a3C+NtMQ@mail.gmail.com>
In-Reply-To: <CAD9n_qim=g62TnckSG3-=1yPDCwQc3u0kYouVSU3f_a3C+NtMQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Jul 2020 10:34:53 -0700
Message-ID: <CABPp-BHxzZiMhGRbtR4BMeOHZkUBygt6JFeetNgP5=MD_PSCHA@mail.gmail.com>
Subject: Re: Request for adding a "clean" merge strategy for a double-commit
 merge to deal with conflicts separately
To:     Alireza <rezaxm@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 21, 2020 at 10:17 AM Alireza <rezaxm@gmail.com> wrote:
>
> > If there were an option to allow git log for a merge to show the
> > difference between what an automatic merge would do (complete with
> > conflicts) and the end-state that was committed, then the resolution
> > would become very accessible and the rest of your request would be
> > moot.
>
> Happy to see there's already some interest to make this easier.
> However, my main use case is not just to see those changes, ideally it
> should be a separate commit to be easily reviewed in a PR, for
> example, otherwise the reviewer must pull all changes locally, which
> doesn't sound like an improvement, IMO.

Well, perhaps here is where we diverge.  Providing the ability in core
git from the command line to make it easy to review manual user
changes within a merge commit would make it so that various PR-related
tools could add that capability as well.  In fact, gerrit already has
such a capability and has for years, so it's not even necessary for
git to have any changes to get this kind of ability.

In contrast, recording the automatic changes and the manual changes as
separate commits is a short term workaround for a lack of a feature,
but one that has some long term ramifications.  In my opinion this
workaround wrecks history and makes it ugly for the rest of forever.
Yes, I have a strong opinion here, but it's actually a bit worse than
that: if people like broken history, they can already record the merge
as two commits -- so why do we need to add a separate option to
facilitate breaking things?  I don't like the idea of breaking things
just because external tools don't yet have an ability we would like.
I think the external tools should be fixed, and perhaps we could
provide a base capability those tools can use to more easily implement
such a feature.

Just my (strongly worded) $0.02, of course.

Elijah
