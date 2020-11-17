Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF3C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A00520782
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqxJotAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgKQWsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgKQWsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 17:48:09 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7419C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 14:48:08 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 19so376544wmf.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQm5Hj1ZRCBZl56V8Gg6ugzDkhYpFd/TnMmY0CliByE=;
        b=UqxJotAic2svOKrTwHXDtSfCVbjJzBtvQ5f1V89BUG7GKD8MAqsMwIqRsBM7Glx4Wp
         owmyWKeL+/iO84sVLJGPDUvjnGusq33C+bJYMG3ru0/aEM5PYRSwqy5l76mq6mZBDpRq
         m2xr+1uJOWq4DyhwmmaL+vW+qYIe2L+n0MHcBzkcqN4Uj6OhAbTinoJdtkZKOf20h217
         /gJIfL5aAVG8Eq8GsYcHj2X4vVoupss8mwij5lJSLewMAMWSpch8Nj36DbdBMBXJdTz0
         8tS1JgVMRKBrD8uEc8KWoj0Gpe09ses4HFBzdwAuqKe4eJnh++X1EwN9O25mpdN0meea
         FR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQm5Hj1ZRCBZl56V8Gg6ugzDkhYpFd/TnMmY0CliByE=;
        b=bZoIhRFCEpMEFziJ/SQV8prrf8HNgDafnqon09oiTrZkpgKOH+/61amZdRKY5ekDtd
         G3ZDXymu0VJ2C9+Wx3A3jnmt91i9GYf05Xw63vBAdhebQC3PDDpPxiPVxCTw0Luq5icU
         KjU1FQtA8zMUpp2zCYjj5WB68pA8EMCn9lhuQUC50rV7dI0vnWxxkLpVDMr60nLaD7L1
         w6owhe4gCsfIjzdh29npG+35xN6AXEkXelqmN2P38h3ddurf6I1Z5V77h4kz0uH4gWHR
         thS+ZBAXIe1DXezLkUlovRnl4PcanGVvmD4j19RIlcJhkIGoj/pfmY7jbKN2IQxWNYWM
         Dlfw==
X-Gm-Message-State: AOAM533Yhyn43qBdgfTXsC8hOLAwXaQ/Yhp1TEw7CLWyeA4GU7nDDJDT
        qf0WoNHFV0ehp92sBAxI+qzbDNO2i7qHGuEa0F4=
X-Google-Smtp-Source: ABdhPJy+eYlNViyj7u6jcAiOagcBUBFh5Om41+l9p5Y0ZFGiPNxxWuTIBXTqwYmxopa/ksfO0ZVjWOieGqpuxp5Uvz4=
X-Received: by 2002:a1c:7704:: with SMTP id t4mr1303659wmi.48.1605653287466;
 Tue, 17 Nov 2020 14:48:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <87r1oraewl.fsf@x220.int.ebiederm.org>
In-Reply-To: <87r1oraewl.fsf@x220.int.ebiederm.org>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 17 Nov 2020 16:47:56 -0600
Message-ID: <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 3:10 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This is the big one. This changes the default of init.defaultBranch to main,
> > reflecting what many open source projects already did (which was followed by
> > GitHub, Azure Repos and others).
>
> Can we please not simply replace one hard coded branch name with
> another?

I thought precisely the same thing.

This should be easy to do if we make "origin" be a pseudo ref that
points to "origin/HEAD" (and we could introduce "origin/@").

That way there will never be a need to type "origin/master", or having
it as an upstream, you can simply set "origin" as the upstream
tracking "branch".

> I don't look in on the git list very often so perhaps I am missing a
> conversation where all of the details were thought through.  If so
> please point me at that conversation.  Otherwise can we please use this
> opportunity to come up with something that is actually better than
> naming the default branch main, rather than just something just as
> awkward whose only advantage is that people don't think it is
> politically incorrect this week.

This is the thread:

https://lore.kernel.org/git/CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com/

Unfortunately in my opinion the most important topics--like your
suggestion--were not even mentioned. Everyone focused on the wrong
thing (e.g. what would be a better name for "master").

Cheers.

-- 
Felipe Contreras
