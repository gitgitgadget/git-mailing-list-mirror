Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE18C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 10:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhLTKsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 05:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhLTKsg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 05:48:36 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4745FC061574;
        Mon, 20 Dec 2021 02:48:36 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v203so27396020ybe.6;
        Mon, 20 Dec 2021 02:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7LVVEj814k0rtyDv7QSeuOPMjhiVF3OoHLrvLsuSPY=;
        b=PG9BVO9DD2fMbN7ySXYzjeTbXUr7RwLkq25Euh48MSuAbcQhHdQMXk34br/a4bYI3Z
         8/XyesT+FyAgciSIvN5pa357k28ehjSZ2AKNZkIo29+bxXfOCFqC/N5teF9nynZz+FA5
         f27aYbS5bQUx1LQhaqdj/3R2+mikDMUJ5lCAMDt4XZkwuLxKbaVoLdJn15IqG5t3FM7X
         NsZNYzhaBvMeGzYp54Muj+esifYiKZ+Aa6ojuDJS+Yl7/4BJa6FIO/Znlhqty7MXbX4U
         ISI/H+22p3tQ6fEiU+/AgFUN7Df7bY0OzBZnZZoCMyLTjiFF1L4Xi0Y+EPfq7soc04Wr
         GowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7LVVEj814k0rtyDv7QSeuOPMjhiVF3OoHLrvLsuSPY=;
        b=c40o10jzVrOCqq5uizHb1ZEd1E02sXkzAROjQX2q5FkPMN+9aNTHv1gK8Oz7So/53r
         w1nxUAu6v9XISPJeYaDJsv10hbAs2WS/vvPi9VqglAFoGWolVtewfh7N0CSr5hWIA/a6
         rA0mHa2ba2lLc4FioXd5JZ8N2YdXzH/cQ+XuUfDCkcadxNfgnUlUWjNStlRwEV04d3aH
         lh11ZvGWRBD+Awe1zxL7EXstFxnCqvqhY6FKn0rcd3pf6XcLRjMoyS7IJNOBVQXmgZ7/
         GVwpLMgOLq5qZy9S72tEBvwr7mUxu1+ZmYFg8I/U54VAbniJwTWIMs6Vps99L/Mg+SNd
         bKHA==
X-Gm-Message-State: AOAM531Jw7SS7oUNjR4rAr/5Jhl2zRXqn6CRKdO9LjsfDZSX6NxZjLb7
        i6JujHIF7SVQG+wDbCWnuzeAN8eWe1Ohfst76Jk=
X-Google-Smtp-Source: ABdhPJzgSrIloEcvsUyQa2iy7KIbtFVaIQ8kQ0x5ak6emKhyXCD5DQJmYY3fWg8Y/4gMHJ/7bCG6OJbR8jwcMa6Qyek=
X-Received: by 2002:a25:4dc4:: with SMTP id a187mr21542435ybb.631.1639997315350;
 Mon, 20 Dec 2021 02:48:35 -0800 (PST)
MIME-Version: 1.0
References: <YbvBvch8JcHED+A9@google.com> <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
In-Reply-To: <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Dec 2021 11:48:24 +0100
Message-ID: <CAP8UFD1M7LM630iHXb3EhgiRSoHgKzixTHmKYTA5OU1fEo69DA@mail.gmail.com>
Subject: Re: Review process improvements
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, calvinwan@google.com,
        workflows@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 17, 2021 at 11:00 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Thu, Dec 16, 2021 at 02:46:21PM -0800, Emily Shaffer wrote:
> > Some of those discussions resulted in changes - for example,
> > GitGitGadget was improved and added to git/git, and we enjoy easy,
> > non-noisy CI runs via GitHub Actions. But some things we thought were a
> > good idea never went into practice. In the next few months, the Google
> > Git team is planning to implement some of the following changes,

Thanks for trying to make it easier and more efficient to contribute!

> > and
> > we'd appreciate your thoughts ahead of time as well as your review later
> > on:
>
> I'd like to also mention that I'm hoping to add a few more features to b4 that
> will hopefully improve the patch submission process for folks.

Thanks also for implementing and maintaining tools and sites that help
contributing!

I have added a new "Process related tools and sites" section to
https://git.github.io/Hacking-Git/ with links to GitGitGadget,
lore.kernel.org/git, public-inbox, lore+lei, b4 and git-series. I am
willing to add other tools and sites if someone knows others worth
mentioning.

[...]

> > 1. Draft a MAINTAINERS file
>
> So, I *don't* recommend that you go this route. The biggest problem with the
> MAINTAINERS file as used by the Linux development community is that making
> changes to it is a very high-latency process. It will be less of a problem for
> the much smaller git developer community, but it will still result in folks
> operating from a stale copy of the file for weeks after it is updated
> upstream.

My opinion is that a MAINTAINERS file makes more sense when there are
different mailing lists to send patches to, and trusted
lieutenants/maintainers. I am not sure that we are at that point yet.

About documentation, if some good documentation exists elsewhere, it
might be good enough to just point to it from an existing doc and/or
https://git.github.io/Hacking-Git/. Otherwise adding a new separate
doc might be better than growing an existing doc too much, which could
scare new comers.
