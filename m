Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A18C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 17:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiF3RHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiF3RHN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 13:07:13 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2FA3BBF9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:07:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i15so34948243ybp.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyfKc7aUPttDEu/V/WjkZRdh5hRev1szno0oiizxNQA=;
        b=BHvEzgYqgktCo4xqPXTeeUxDI3XZjI3A9C9HN0wVxEWX0T48pRnEIGkj0BEvhu91gr
         GEerf/dvhA1B9EcJz1jXzw98j29j2eD4Z/tgBugCGhd1Wvtd4LLcusgpeXpXYTn2JDBq
         UoIK7hCmhZsbZddoLxQ1zil9UCpN3Xk17/hjiRanEL7BRCiLMeDvCaGyuvNjPCWHo6nc
         HfsaiKCHKR2HMR0dKdGi1h/m0rc3Fwmj/fIcvxTX4DId6X31r15vBJZeURZRlVxFqD09
         P3Z2A3IJJq0QxxM8Zg24ZhR1GfxvjUTs379HeAFbWp7SutWPPL/anYvNIG7tto53qKha
         boRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyfKc7aUPttDEu/V/WjkZRdh5hRev1szno0oiizxNQA=;
        b=lD7nyxSJ15ntfwCSom4OMHi0PfpHMTMeLaB0LknJ50LhjWjr5FPULS4l3uC2RKTmYZ
         cKEz6ASiXjt5VAsErcmh+MqC4/H3TYB821UmZduqhxG9aL7RmbdQ/S3mJ419ZR2QiVjD
         /OsnhRiL9Wjx31rpNQIISPCnmklOVMMOlf2sNcdPWmvLe24V6zHU3lGEgOr5J3UZZaBk
         kapPYNSTxMWecwxNTesg9fJPyhpU4aeBbPeEZq/av7XzhRTrzuybsIyDqTcrictuG0RS
         4HTVlPZe2vQ5ccv5EYE95So4j6s9FUddNCbY7XTxJwvwkEO7mxKzNLQHA35quDCQ5yYE
         XVPg==
X-Gm-Message-State: AJIora9Oz8ctep6YUyuEOgDn3i5K6jWQTWK4zc5WK2o2ooZJmrmk7GAL
        QczV1svYszIw/geUSneppDTUqLgotaLwRTAKfq0=
X-Google-Smtp-Source: AGRyM1vj+PpW5Mx7j8WpBkjBo+SBG3z2OFer6URKsI1b+10TKoAK47SNGSADjAJTIKVjER1XdKk+tZTgHr8ZQMCQRCE=
X-Received: by 2002:a25:9e82:0:b0:669:b38d:e93e with SMTP id
 p2-20020a259e82000000b00669b38de93emr10438637ybq.242.1656608831889; Thu, 30
 Jun 2022 10:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220630142444.651948-4-siddharthasthana31@gmail.com> <61074b4c-c48f-da89-5d03-b280b9c4fedf@gmail.com>
In-Reply-To: <61074b4c-c48f-da89-5d03-b280b9c4fedf@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 30 Jun 2022 19:07:00 +0200
Message-ID: <CAP8UFD2tYzoKSr7HnQ+LbCE+YWoNqo3qPQrbr7ZWAMnDt+ajCg@mail.gmail.com>
Subject: Re: [PATCH 3/3] cat-file: add mailmap support
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, Jun 30, 2022 at 5:50 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 30/06/2022 15:24, Siddharth Asthana wrote:
> > git cat-file is not a plumbing command anymore, especially as it gained
> > more and more high level features like its `--batch-command` mode.
>
> cat-file is definitely a plumbing command as it is intended to be used
> by scripts. It has a number of features that are used by porcelain
> commands but that does not make cat-file itself porcelain.

Ok, so maybe:

"Even if git cat-file is a plumbing command, it has gained more and
more high level features like its `--batch-command` mode."

> > So
> > tools do use it to get commit and tag contents that are then displayed
> > to users. This content which has author, committer or tagger
> > information, could benefit from passing through the mailmap mechanism,
> > before being sent or displayed.
> >
> > This patch adds --[no-]use-mailmap command line option to the git
> > cat-file command. It also adds --[no-]mailmap option as an alias to
> > --[no-]use-mailmap.
>
> I don't think we need an alias for this option, it'll just end up
> confusing people.

I am not sure if people would be more confused by the alias or by the
fact that the "--[no-]mailmap" alias works for `git log` but not `git
cat-file`.

> > At this time, this patch only adds a command line
> > option, but perhaps a `cat-file.mailmap` config option could be added as
> > well in the same way as for `git log`.
>
> As cat-file is a plumbing command that is used by scripts we should not
> add a config option for this as it would potentially break those scripts.

Yeah, we could either remove this small paragraph or add the
explanation you give.

> I like the idea of adding mailmap support to cat-file and I think this
> patch is definitely going in the right direction.

Thanks!

> > +test_expect_success '--no-use-mailmap disables mailmap in cat-file' '
> > +     test_when_finished "rm .mailmap" &&
> > +     cat >.mailmap <<-EOF &&
> > +     A U Thor <author@example.com> Orig <orig@example.com>
> > +     EOF
> > +     cat >expect <<-EOF &&
> > +     author Orig <orig@example.com>
> > +     EOF
> > +     git cat-file --no-use-mailmap commit HEAD >log &&
> > +     grep author log >actual &&
> > +     sed -e "/^author/q" actual >log &&
>
> This line does not have any effect on the contents of log
>
> > +     sed -e "s/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//" log >actual &&
>
> I think you can simplify this series of commands to do
>         git cat-file ... >log
>         sed -n "/^author /s/\([^>]*>\).*/\1/p" log >actual

Thanks for the suggestion!
