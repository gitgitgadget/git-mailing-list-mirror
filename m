Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CC2C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 12:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1A064E08
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 12:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhBJMVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 07:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBJMTU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 07:19:20 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D0CC061756
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 04:18:38 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id w1so432603ilm.12
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 04:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hGVc71eIIzP+Um1HrQ/EPkdZS3wemsHVZ5Wm+iz/Ls=;
        b=sISibyBGEATTufyPyZJi/nKyc21w4Pi9HqniKEkcB4bkxIMSj2OKS1/UpTO4FS55Gp
         A3SexFZBVs4luq2GAtiMxWHHJ+Pjla+s4HUzQT4Cy+R0/W6AGqiC6G340hu6mLPbv7Sn
         acMMvCuxKtfO+KOtlZRI5VpXsTF1k2XrBry4A7+/i9vt1XKbV9bbSp3CQ7KFlsmGc6ap
         zbx/LfQHv07nbh88oC2QthhdKcLoUK8bfPO5XRCoOI7h4K9BDqz6P987kVQG6p4/xFO+
         as9co1AFza+F9pELTZtz0/upanRHUlDXXkDe2mIcn6DGPyf6q1u2GPMm6t+q+Xvzthui
         JRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hGVc71eIIzP+Um1HrQ/EPkdZS3wemsHVZ5Wm+iz/Ls=;
        b=Y62QIriy2iTSKJq2q/yJXXzxjTCcRRrsa6U+Esta71QOphVPICf0fDJlMqlHLNHok3
         JDGKy3plJAmk87vK5/bUaaVAxL+aOMws+eT8q7J+G4JL8LrWJ0oyYNXiAiOzVQudJgma
         1SxZImqbdRWzRE8R9SlxihZgQFuPdEyVI0DOLuONIaNrsfZwD0CHkCTZd8nB8hteMtPN
         cpItnvbfUxcxMXfpGUSxGJfENSiWr+xNz0Q0m7Rl3M5aAoSW7KnF8KeGR0HrJ+FdmLQS
         9i9c3N2TBHkWMsibJFKYiA+ga20fuvyCW1ibwKkxnSB6p0bKHCuehvBvG4Ty2sdXiJMO
         cu5w==
X-Gm-Message-State: AOAM5301ICz/hDiaAso3mTfDa1osN5YDKSLoI16u/ydfGbVSiD4yqtVI
        WEAA4szYuyDwW+lSen//xqY0C6nbhJ+/dmiWfbGtvD6WdeXJrA==
X-Google-Smtp-Source: ABdhPJwsUbHuWqN73RSbh3oZ8/VwPdAjMK0xVPzmEDpJLWJQ/g9AqzLP2f8ME7Z8Jwu3FjFedTeRbCEzVZNjMOudfYo=
X-Received: by 2002:a92:c24b:: with SMTP id k11mr796502ilo.276.1612959517388;
 Wed, 10 Feb 2021 04:18:37 -0800 (PST)
MIME-Version: 1.0
References: <CA+2K_KotVrV=rjE6fcd_FfxxS0sewkywvO0EMVZdoHbSiqJTQw@mail.gmail.com>
 <CA+2K_KqH=Gn=Yx-UYzMBO+gZje3G3PJ_3-5HeO81wyZKvVwOSA@mail.gmail.com> <c19b6e23-96cd-fd0a-163d-826b46b51da0@gmail.com>
In-Reply-To: <c19b6e23-96cd-fd0a-163d-826b46b51da0@gmail.com>
From:   Filippo Valsorda <valsorda@google.com>
Date:   Wed, 10 Feb 2021 13:18:11 +0100
Message-ID: <CA+2K_KqEzH7XmrHXd0Vniu+tBQpFwFnYPyzoj-kMhyN2NnoZFQ@mail.gmail.com>
Subject: Re: BUG: commit-reach.c:66: bad generation skip
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 8, 2021 at 3:26 AM Derrick Stolee <stolee@gmail.com> wrote:
> _This_ is interesting. I haven't heard of this problem happening
> in a released version of Git.
>
> I'm CC'ing Jonathan Nieder who recently saw this happening, but that
> was on a newer version than 2.30.0 with a topic that is not part
> of 2.30.0. But maybe the version shipped internally is versioned
> without extra information on top of the latest tag? (I see your
> @google.com email, which makes me think you have an internal version.)

Ah, the issue indeed first showed up as I was using the internal
version. I then installed mainline 2.30.0 to check that it reproduced
on the same local repository before reporting a bug.

> To better understand your situation, could you please run the
> following commands?
>
>         git config --get-regexp graph
>         git config features.experimental
>
> I'm specifically looking for values of fetch.writeCommitGraph and
> gc.writeCommitGraph.

fetch.writecommitgraph is enabled on the internal version.

$ git version
git version 2.30.0.478.g8a0d178c01-goog
$ git config --get-regexp graph
fetch.writecommitgraph true
$ git config features.experimental
$ ~/homebrew/bin/git version
git version 2.30.0
$ ~/homebrew/bin/git config --get-regexp graph
$ ~/homebrew/bin/git config features.experimental

I zipped up the repository and the worktree before running gc, so I can
run other commands for you if you need, but unfortunately I can't share
the archive, as it fetched from a private branch with security fixes.
