Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B23EC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 16:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiADQQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 11:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiADQQC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 11:16:02 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F2EC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 08:16:02 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id i3so95031108ybh.11
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 08:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPXi3TpGjmR+3mD7o01GZCX7dMi42u9h/sMK3Lt5UUs=;
        b=FfZPScsNTOzPwEzQRxiIpTvSaahpTI6jzfwxVG37orgkgRnZo9/JDfEIZvjSwSgXux
         elXGL9EXHuspFGxnzYQuh/xtBNoj9UAmewSLJwUocI8QEAEOBIkMpf5Llf1afiEtS9SL
         UZkaBy00FLZn3nZUfjNbLjpL3Vq6bS09xBfg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPXi3TpGjmR+3mD7o01GZCX7dMi42u9h/sMK3Lt5UUs=;
        b=fc5NW/YU3AhD/Nk3wTMEAW/DoSN2VKGBuWtzlgFr40+ybHGNaGxdy19UKG1D45mXuz
         zpqz2Bkky74J1yFx7lALqQADRS7IvP6TnyT9O40Kixkev0S2C0SH92LTworkyzyfxi1A
         jliOtAHFbOPq9lJc5nlycdj4zqmnDNyqO6vuV9YzNPO2QQWuxX5uaya4kEZ0dUlcDUPD
         FbWKHtBZOTDQAN2C51MlApRGoPjvJeZJyLMqNBK7FFUGbDt3BVJs+fhk6hDxgFyvr+PG
         yGncDklQA6xofWmmLcS2t8SowECb0LZkkLiEbvDI2rPlY6JzERoGnppRNaDm5UU3UQaz
         AAdQ==
X-Gm-Message-State: AOAM531ePKYbpQBs7rMCpXfMHjoJEJhQuYpo7EV3/+B6AAhzsnInabxP
        ZbpkzBO5jlGx41XpM6i3lMioneNiVzIiwvJLQrBckftrZsZj9g==
X-Google-Smtp-Source: ABdhPJz9hRMb4Dztwn5WR7vqQcjrhuBhkjgB1Oc7zt4tkFYC/2jHsseLNWX2gcvyqhBKIzIwwQDniozlF6ybBMUqw88=
X-Received: by 2002:a25:d690:: with SMTP id n138mr49783728ybg.326.1641312961470;
 Tue, 04 Jan 2022 08:16:01 -0800 (PST)
MIME-Version: 1.0
References: <CA+kUOak9_RLpdr9d4pQiwU=K42taCwhMdg5WkLP4GreQd4yWig@mail.gmail.com>
 <CA+JQ7M_tOu5ahQSPZk5Be10rY_NDOmqLWj9b1On=KW8Rq2mk2w@mail.gmail.com>
In-Reply-To: <CA+JQ7M_tOu5ahQSPZk5Be10rY_NDOmqLWj9b1On=KW8Rq2mk2w@mail.gmail.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Tue, 4 Jan 2022 16:15:25 +0000
Message-ID: <CA+kUOakd0HaPk7PGh+4L6753KnsVaykczy31=5vrG91iJkcOfw@mail.gmail.com>
Subject: Re: Bug using `fetch` with blank `-c` arguments to git
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 4 Jan 2022 at 15:35, Erik Cervin Edin <erik@cervined.in> wrote:
>
> Minor clarifications
>
> On Tue, Jan 4, 2022 at 3:48 PM Adam Dinwoodie <adam@dinwoodie.org> wrote:
> >
> > While investigating some issues with a different project, I discovered
> > the command `git -c config.helper= fetch` was working with the Debian
> > ...
> > I see the same behaviour with `-c config.helper=`, `-c
> typos for "credential.helper" ?

"credential.helper" was certainly what I'd intended, but I see the
same behaviour with both options.

(I'd initially thought this was specifically due to the blank
argument, hence the email subject which I clearly failed to update,
but it looks like the issue occurs when using `-c` to set a config
option regardless of the option being set.)

> > Notably the behaviour does not affect all other git commands; `git -c
> > core.autocrlf= log -1` works as expected.
> You've only seen this with "git fetch"?

I've not tried to do any exhaustive testing, but I see this behaviour
with "git fetch", "git pull", "git bisect" and "git submodule"; I see
things apparently working as expected "git blame", "git commit", "git
push", "git reset", "git switch" and "git log".
