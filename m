Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955B4C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 03:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C8E2073E
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 03:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="0CWeD9Og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgC3DXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 23:23:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34110 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgC3DXp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 23:23:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10so16287087ljn.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 20:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKmYQqh0HiAtv7okuMQQ6FI9xoCCtnkG0NpYaGoXxTE=;
        b=0CWeD9OgK2wgr3gTHJgcfRMbm6hdr/km8naW41hHmRxFGHQRjuQrM5wzVro5nR+2Gk
         gS1pPmLL/3fYfCFQUwxPLcvZy9n055KHfebXiYk3zNLyVof7sWxLvSiTqCuA7KkaJ691
         8QKgWHSMfxBcQrvzBbA4ELeJkvx3gQ4lOrASdU/0F/Q3RaXez4DLPNHIAe74R7725XPr
         TqcD/4OXJ0JzuuJ1oDdkMvXRkP7gCNk4U9OV25RFcEOm1h5ledN8bNlXUqIXJO7wrzHQ
         RM6lZH7QCiSVAYWtkN00ErbhH2glKWA12vNwgPZeToTCc7bvDzC3MBwdrxxTsspJxXuF
         0B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKmYQqh0HiAtv7okuMQQ6FI9xoCCtnkG0NpYaGoXxTE=;
        b=n0ZlI2Y9O6ZqRH6ENR4QFwx7puWwpZ9BcpsiFYvhRdFpcTQpmfV2StZImUEmi7eATL
         k1M4WHahUgz4IZkay37LgQbpH7P0CRdzunNfX99dadk5D027B4TUXnrQ2WXdFuBkGbUj
         j0gQqD6WtuR41xQUbJNIiVVm5rZM8F3gG7x5yZfmRa9kqLX55auqd4qYoHBnR+0YQyqe
         nzFJPs68r3TIIlWY5SBz2F1M1LlhsrHG9CGgcQMREkLj64seBPu5WRlwR245y8yjB+CQ
         mSiRh+j62syFmYZaDDlv125wNqMNnvy2in1d3/EuD4sHSC4VVPzIKsFqy6GLMw4/68qc
         j/HA==
X-Gm-Message-State: AGi0PuZb3G2nyYXBOE2A8GSYgQFpPIHfb9jZjk6OOufZyvhXczak5mlv
        alnixAG42Yc97NSAhQQo+PwfQ9Mb8ov+QRDA1gATzQ==
X-Google-Smtp-Source: APiQypJOeEstIp3u/5i1nB/tvv0Rwi61VoLI8TAdrvXoJByGADxJ97zW8cRsJTcsMNdwT0xFF4VvVNkHsPi5/Mr+UHw=
X-Received: by 2002:a2e:9655:: with SMTP id z21mr6201889ljh.122.1585538622686;
 Sun, 29 Mar 2020 20:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com> <xmqq7dz938sc.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dz938sc.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 30 Mar 2020 00:23:31 -0300
Message-ID: <CAHd-oW5qq=dtaSmqcSyxoHd3HPipxjfaiCXtdBQwk9yNVe9okA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 3:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Mon, Mar 23, 2020 at 11:13 PM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> >>
> >> In the last commit, git-grep learned to honor sparsity patterns. For
> >> some use cases, however, it may be desirable to search outside the
> >> sparse checkout. So add the '--ignore-sparsity' option, which restores
> >> the old behavior. Also add the grep.ignoreSparsity configuration, to
> >> allow setting this behavior by default.
> >
> > Should `--ignore-sparsity` be a global git option rather than a
> > grep-specific one?  Also, should grep.ignoreSparsity rather be
> > core.ignoreSparsity or core.searchOutsideSparsePaths or something?
>
> Great question.  I think "git diff" with various options would also
> want to optionally be able to be confined within the sparse cone, or
> checking the entire world by lazily fetching outside the sparsity.
[...]
> Regardless of the choice of the default, it would be a good
> idea to make the subcommands consistently offer the same default and
> allow the non-default views with the same UI.

Yeah, it seems like a sensible path. Regarding implementation, there
is the question that Elijah raised, of whether to use a global git
option or separate but consistent options for each subcommand. I don't
have much experience with sparse checkout to argument for one or
another, so I would like to hear what others have to say about it.

A question that comes to my mind regarding the global git option is:
will --ignore-sparsity (or whichever name we choose for it [1]) be
sufficient for all subcommands? Or may some of them require additional
options for command-specific behaviors concerning sparsity patterns?
Also, would it be OK if we just ignored the option in commands that do
not operate differently in sparse checkouts (maybe, fetch, branch and
send-email, for example)? And would it make sense to allow
constructions such as `git --ignore-sparsity checkout` or even `git
--ignore-sparsity sparse-checkout ...`?

[1]: Does anyone have suggestions for the option/config name? The best
I could come up with so far (without being too verbose) is
--no-sparsity-constraints. But I fear this might sound generic. As
Elijah already mentioned, --ignore-sparsity is not good either, as it
introduces double negatives in code...
