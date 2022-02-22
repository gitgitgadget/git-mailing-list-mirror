Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168D7C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiBVRLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 12:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiBVRLv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 12:11:51 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52277D1095
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 09:11:25 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p14so44857972ejf.11
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 09:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LBMaU/ae+uOL9zhP0DVQIXJH3tSsXio47Th7rh+sKH4=;
        b=W2GfPdYl0jUBcmBiY8/bMar1bn7FFgowJ3nuystLBnCqxxIt5cwfx6Wv5ZxoG/eC21
         mwAY4Dn7xCjlRjZp1j3vcniT9xjWk1gn+eMrlvZSlD3zwU2rDtBOthUtSajbAZClSDyp
         AI9HvcuN4Xf2lIDpMuX0ZmQdSlT+oJRSXvsxP+dvr22hOkHPpOoxoMeSOdDdbAe8viLm
         ohUNdujwMI2iuVdV5qN7pEI+xHaea+u8+x1rqZJXu9cRVqqn2rOkGkdrhFRb7pPJnVe7
         DcpF+LVpHD3cwFVt294RXxtQTj49WIV3scRPLvVPuwKVnRe3Hf8l9EtopL2qUKakI4vl
         bu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LBMaU/ae+uOL9zhP0DVQIXJH3tSsXio47Th7rh+sKH4=;
        b=pfN2ifRoIYOT6euf9Nyp2QKcdvjs3JYK3BFZPaC9Ege7QMGUli/Qih0HKkpBqsunXv
         wXPxDwJ3L9m4yOaIB3VGybul+NyMpgohZbff7c+q8E2iQ5wtYMQC2hG4Ra5OQ7AtCPVt
         vlK1AGAT2qtyjjIEArzUuxnXXHlEL36gQMCiFf6Nc9/dMgkdoYbUzPf6rySUCsYDIgKX
         luSSlnFKwC7k78aZUpeGFv5wlLg/RtYz4yg5kiVmh/1P5/mJZ4QH4bulAz0pQ4So9bNl
         xkfaeKmwOAVCXhG8AvvyFLH9hWiVkktjwKJlfizjBjQ3de1mGUImgrza6J5sQnrHHNha
         z4OA==
X-Gm-Message-State: AOAM5312GDs+WK5ebi+OE1H5l15iN8oY/l5lUUHsw0F17Fc227bWiPCe
        2MD2GwO9sSpKniQTz3fDr4o5ql/QND46DCq2eYpSKhlHSx8=
X-Google-Smtp-Source: ABdhPJyPapjCms9c4NOv4oyplp5LREDHV5s2vwny6Dbs9htdoYPKecbME7v9xxaGRqpTYD8EyXgB97OoPhY/sZvi+fc=
X-Received: by 2002:a17:906:5c4:b0:6cd:8d9c:3c7d with SMTP id
 t4-20020a17090605c400b006cd8d9c3c7dmr21241895ejt.554.1645549883609; Tue, 22
 Feb 2022 09:11:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com> <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com> <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com> <YhQHYQ9b9bYYv10r@nand.local>
In-Reply-To: <YhQHYQ9b9bYYv10r@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 22 Feb 2022 18:11:11 +0100
Message-ID: <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai <johncai86@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 10:42 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Feb 21, 2022 at 10:10:15PM +0100, Christian Couder wrote:
> > > > Also, to have more protection we can either
> > > >
> > > > 1. add a config value that needs to be set to true for repack to remove
> > > > objects (repack.allowDestroyFilter).
> >
> > I don't think it's of much value. We don't have such config values for
> > other possibly destructive operations.
> >
> > > > 2. --filter is dry-run by default and prints out objects that would have been removed,
> > > > and it has to be combined with another flag --destroy in order for it to actually remove
> > > > objects from the odb.
> >
> > I am not sure it's of much value either compared to naming it
> > --filter-destroy. It's likely to just make things more difficult for
> > users to understand.
>
> On this and the above, I agree with Christian.
>
> > > I share the same concern as Robert and Stolee do. But I think this issue
> > > goes deeper than just naming.
> > >
> > > Even if we called this `git repack --delete-filter` and only ran it with
> > > `--i-know-what-im-doing` flag, we would still be leaving repository
> > > corruption on the table, just making it marginally more difficult to
> > > achieve.
> >
> > My opinion on this is that the promisor object mechanism assumes by
> > design that some objects are outside a repo, and that this repo
> > shouldn't care much about these objects possibly being corrupted.
>
> For what it's worth, I am fine having a mode of repack which allows us
> to remove objects that we know are stored by a promisor remote. But this
> series doesn't do that, so users could easily run `git repack -d
> --filter=...` and find that they have irrecoverably corrupted their
> repository.

In some cases we just know the objects we are removing are stored by a
promisor remote or are replicated on different physical machines or
both, so you should be fine with this.

If you are not fine with this because sometimes a user might use it
without knowing, then why are you ok with commands deleting refs not
checking that there isn't a regular repack removing dangling objects?

Also note that people who want to remove objects using a filter can
already do it by cloning with a filter and then replacing the original
packs with the packs from the clone. So refusing this new feature is
just making things more cumbersome.

> I think that there are some other reasonable directions, though. One
> which Robert and I discussed was making it possible to split a
> repository into two packs, one which holds objects that match some
> `--filter` criteria, and one which holds the objects that don't match
> that filter.

I am ok with someone implementing this feature, but if an option that
actually deletes the filtered objects is rejected then such a feature
will be used with some people just deleting one of the resulting packs
(and they might get it wrong), so I don't think any real safety will
be gained.

> Another option would be to prune the repository according to objects
> that are already made available by a promisor remote.

If the objects have just been properly transferred to the promisor
remote, the check will just waste resources.

> An appealing quality about the above two directions is that the first
> doesn't actually remove any objects, just makes it easier to push a
> whole pack of unwanted objects off to a promsior remote. The second
> prunes the repository according to objects that are already made
> available by the promisor remote. (Yes, there is a TOCTOU race there,
> too, but it's the same prune-while-pushing race that Git already has
> today).
>
> > I am not against a name and some docs that strongly state that users
> > should be very careful when using such a command, but otherwise I
> > think such a command is perfectly ok. We have other commands that by
> > design could lead to some objects or data being lost.
>
> I can think of a handful of ways to remove objects which are unreachable
> from a repository, but I am not sure we have any ways to remove objects
> which are reachable.

Cloning with a filter already does that. It's by design in the
promisor object and partial clone mechanisms that reachable objects
are removed. Having more than one promisor remote, which is an
existing mechanism, means that it's just wasteful to require all the
remotes to have all the reachable objects, so how could people easily
set up such remotes? Why make it unnecessarily hard and forbid a
straightforward way?
