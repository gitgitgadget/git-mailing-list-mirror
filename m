Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000DCC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C7E2071A
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaWg7TUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFOVii (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFOVii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 17:38:38 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57132C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 14:38:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x202so17304805oix.11
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBUEprItL5WA5UCrjRMdVnNaguvDCTw8G4816k9NDMQ=;
        b=KaWg7TUKE0tp8w4pADN7/M6zVRJnxZ3sKcx8qNp+h0taFfCM7nijqq1j9L6x76PpAA
         pnEm8ri2LEa8KQWd6vhA+iTww/6uQw2aTes2IQjL/FJmoEBJvye+YdtyQQGQ/78gmvdj
         Ga4AVTQbB4YOxuiD6PZieLfXHspAg5A5LuuoTLiziVe2uIysTCZWfonAU4AV48HGfiS2
         vGe/3KC6axkSihkky4TRx20PkNa73I3RgDfkcfoWlabCNhPH+zJw07iKd/it2lMaaX0E
         SDnGq6klXKMV9QlJ7lPSiMh5Nyqlu2w/wHdtmCcRxaScM67r4/RRoLfsTj8VEFX70rwH
         CqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBUEprItL5WA5UCrjRMdVnNaguvDCTw8G4816k9NDMQ=;
        b=I08ehsskhqKALerMXwc9KLqEK3HKntCatOM53iKH6WjV+HdNWkQOyMDA6zDWPboSY1
         O/HN8ewzk2HuGWCptwpcpnvbxRBQI2xKR/T4muhhDFuRoquSxqT11jBqwJ6+hWez6KWT
         kHGMroMq8qR7uZ06v29ZJabvaw0I29DMxBr5fTTEEvZY5qr7kznciOyj3NZAJJp7sfRv
         c9x6Iz+HnQyaHWxMhFIVNF3y/3x7F9M06w/5Tt40eLEUXzZJXvjWCtzdkgtAHdo8Ow3A
         yckjV6E1mBv9FXezbDCjvIzCUrAwkZtu5D2YSWWzGCbTreX4Yvl6sE4BWIobnX6Sj6b/
         LAsw==
X-Gm-Message-State: AOAM5300Yx7EnF7VjTypaY01A7mdzl8XXwuqU31vrAYDmowQ/xpDDIba
        X5rLsebJ4wFx2U2lD2sTmw/oqJEiQ/0WvuXSWGU=
X-Google-Smtp-Source: ABdhPJyoLY6xGtW50H9agnP45YiZC8VnXeZX5FYPYUsAUJKUmEv5jgFGoM3PQ0qGu0AXgLsVwbmbf9HTPlv3QOeewCo=
X-Received: by 2002:aca:6287:: with SMTP id w129mr1136826oib.167.1592257117465;
 Mon, 15 Jun 2020 14:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net> <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
In-Reply-To: <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Jun 2020 14:38:25 -0700
Message-ID: <CABPp-BF8vo_fCbM1ct0MYFhQcVmPwfq7_Q3Fd+SnM0=gVmxkrQ@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Jun 10, 2020 at 2:34 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> I have reached out to Billy Griffin (the PM of GitHub Desktop) to learn
> what might be good candidates for the default branch name, as GitHub
> Desktop changed their repository's main branch name recently. This is what
> he told me:
>
>         [W]e did some research looking at the data at GitHub of the most
>         commonly used default branch names other than `master`. Most of them
>         were things like develop, release, staging, stable, production, etc.
>         that denoted some stage of the software lifecycle. We thought that
>         none of these are good options because a universally applicable
>         default name should allow for teams and projects to work in
>         different ways (and obviously if teams want to change it to reflect
>         their workflows, they're free to do so just like they do today - we
>         use `development` as the default branch in desktop/desktop, for
>         example).
>
>         The three most common names that *weren't* in that category were
>         main, trunk, and source. "Trunk" has roots in SVN so there's some
>         precedent for it, but we've heard feedback that it's not
>         particularly intuitive for non-native English speakers, and "source"
>         in my opinion isn't accurate because it's only a single branch, not
>         the entire source. We've also seen "default" floated and it exists
>         in mercurial, but we've also heard feedback that it's potentially
>         sensitive due to financial default, so we might as well choose
>         something else if there's another good option.
>
>         For that reason, we're thinking that `main` would likely be a good
>         choice because the name corresponds nicely to its purpose as the
>         default branch of a repo. It's also conveniently short to type,
>         and tab complete would continue to *just work* for those concerned
>         about muscle memory because the first two letters are the same as
>         `master`.

Looks like they've done some good research; I'm glad someone has looked into it.

It probably doesn't matter at this point, but can I point out an
additional issue with "default"?  I worry it's quite likely to lead to
confusion: does "default branch" mean the one named "default" or the
one HEAD points to?  For example, at $DAYJOB, hundreds of repos
switched a few years ago to having "develop" be the default branch,
but did not delete "master".  Had the default branch been named
"default", we would have been in a funny situation where "default" was
not the default.

You may just think that's a humorous case, but it's more than that to
me.  Once upon a time in the Gnome community we had a theme called
"default" that many people thought was rather ugly; a new theme was
created with a different name that became the default, but for
backward compatibility the old one had to retain the name "default".
Soon there were lots of themes and almost no one directly used either
of these two, but the release notes were required to use the default
theme for screenshots (that is, the default theme, not the "default"
theme).  Anyway, wires got crossed and there were some massive,
heated, protracted flame wars that engulfed way too many people (see
https://blogs.gnome.org/newren/2005/03/15/poor-eugenia/).  While the
reaction there was blown way out of proportion (the flame wars really
were unnecessary and having a code of conduct in place might have
helped prevent some of that rather poor behavior on both sides --
myself included), there was a nasty problem that arose from a simple
communication disconnect that was real.  It could have all been
avoided if "default theme" wasn't ambiguous and for the same reason, I
don't want "default branch" to be ambiguous.  Although I wasn't
directly on either side of the Gnome fiasco and was just one of many
that got pulled in as the whole project got dragged into the whirlpool
of problems, I really don't want to be involved in a repeat of
problems of the sort "oh! there's another default branch?!?"

Hope that helps,
Elijah
