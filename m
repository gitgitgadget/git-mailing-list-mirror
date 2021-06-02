Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C519FC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 17:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD50561D69
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 17:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhFBRjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 13:39:44 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:38677 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBRjn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 13:39:43 -0400
Received: by mail-ua1-f54.google.com with SMTP id d13so1054803uav.5
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jordi-vilar-cat.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVKVa7uPy3y3ojowSrJkN36ucEiF8byxGrlqihsOJxw=;
        b=lrytA7kgJkZTyoBPrRX/LBT0t+wgRIvE3hUojwKlME6IZ+7twwykKQlpUh6sMbT/83
         DGq4JNWkgMmIfHQiCpB2lFR+tS92W8LkqQWsmg5Rlg9pMbUzjEcb518+AkDK9w54bpLk
         8Z8OWz8IW+7pDZMbzV2GNdIXT2Hm0SzbIzQKNOwgF9PJWSnzyEeDUWyRk+7T8Zn6HVyq
         dgI3W5cXGAnY0XacP/FLy2vpOTAJwvcEkjjex9eRyFRTPMCPnFxpESQjEFwVW/scr6w8
         o1Y7LWQif4RalI//rCeCSP79vtUgkbsNFK7uxmjkQeQ01L9L4lInU1GGskIl9BJ2OJff
         lMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVKVa7uPy3y3ojowSrJkN36ucEiF8byxGrlqihsOJxw=;
        b=SNXoB7YlcfAGEVrxF88xeOviCzcptRks1Nr+KdtdgWlBbL1sZEEr+sDASt4zjAZ87c
         74PAifodJrSOg0APEAYZbuhSYO4jUe8I4UVBDLJaecINEaGcL19fcwUFxqQRyutjonm7
         om+0PeJAZu4qh9No9rc5pbdh0LAqk4eSLMrOpnIh6KJ9OJxlMbNI2G2U+mmkBmLItR5Y
         zQsGiU769SXcz1tAsnmkH+5TD5BurfulvwJdSy6KF1NESrZVp+mZVjRm6j6ZQC3Cun76
         SDDsnhL10TtT2id8Db2bRFvvljJsw1fht8aUV3wPtu2pcs2DPoQG/vRFUUYGAG2+CKgV
         gFZQ==
X-Gm-Message-State: AOAM533FI5uriCXEoI1T+euk9BpoaZBzme4WT7FrXoP938gXwbccSKnM
        e+hlGTxP5KvOC5IL3dnraLvmxNbpEGOZFBYkZcNRTA==
X-Google-Smtp-Source: ABdhPJwy+k7pGIeFJHN2sdMkOZG9KmT1V/EVqlbinWW3fPZoPAjWB/7X1jBWms3zTPJ+ss6UiDMyBHGXhzeWnsuGPNQ=
X-Received: by 2002:ab0:2312:: with SMTP id a18mr22621155uao.115.1622655403538;
 Wed, 02 Jun 2021 10:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210601113554.52585C06174A@lindbergh.monkeyblade.net>
 <CAE-zgtYTutLZWO63QtqZJztMPqi9eHYQfFu6sda8YDf_bVeE3Q@mail.gmail.com> <nycvar.QRO.7.76.6.2106021259480.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2106021259480.55@tvgsbejvaqbjf.bet>
From:   Jordi Vilar <git.kernel.org@jordi.vilar.cat>
Date:   Wed, 2 Jun 2021 19:36:31 +0200
Message-ID: <CAE-zgtZroyEwG1k9y-XXAx2NKPF=Lav4YG+f7mF227FEeuxDVw@mail.gmail.com>
Subject: Re: proposal for additional search path in config
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thank you for taking the time to read the proposal and reply with your comments!

> That sounds like a Remote Code Execution vulnerability by design in the
> making. But let's read on.

I agree with you that a too simple implementation of this would pose
an unacceptable risk. But I think the details are important in order
to assess the actual issues. Let me develop those details as I reply
to your comments.

> I am really wary about the security implications of this. Most obviously
> with the idea of allowing to _override_ commands. Take for example
> `git-lfs`: the assumption is that it is safe for Git to call `git-lfs`
> after the initial check-out phase, but with this feature, it would be
> possible for Git to clone a malicious repository and _immediately_
> executing code it just cloned, _without_ giving the user a chance to even
> inspect the code.

You are again right. That's why I was suggesting the conservative
approach of not prepending to the default search path, but appending
to it, so there is no chance of overrinding existing tools. Also,
config is not versioned, so, right after cloning you wouldn't have
this option enabled, so you are always safe after cloning. Then you
should have to manually configure it, of course, only for trusted
repositories. But if you configure this search path in the global
settings, you should avoid setting a relative path (or maybe git could
ban it). But in any case, only the user can set this, it is not
automatic upon cloning at all.

> But even if you _append_ that path to the `PATH` variable, unintended
> vulnerabilities could be opened. Take for example `git difftool`, which
> looks for executables in the path until it finds one that is installed. An
> attacker could guess which executables your setup is missing, and squat on
> those, overriding your `git difftool` to execute code you did not intend
> to be executed.

Well, the apparent effect would be like appending to the PATH
variable, but I'm not suggesting to implement it in that way. I didn't
say it explicitly, but what I had in mind is that git searches for
extensions also in this additional path, but without modifying the
environment variable, so it is not inherited by any executable or any
other built-in git functionality.

> So putting a security lens before my eyes, I would be quite worried about
> such a feature.

And I appreciate your critical thinking. I just want to share an idea
I think could be useful, not to open a hole that we could later regret
to have open, so all precautions are good.

> Note that the _use case_ you present is a common one, and what I see
> projects do is to integrate the configuration into their build process
> (carefully vetting any code changes to the build process is _always_ a
> good idea, hence this is a lot safer than having Git configure what is run
> automatically). And of course, this is already possible right now, it just
> delays configuration of those included tools to the time of the first
> build, as opposed to the clone time (as suggested above).

For sure, decoupling sources/resources from tools is optimal. But not
always possible. And having to setup the environment for each worktree
makes working with multiple worktrees at a time from the same shell
session a pain and error prone.

Regards,

Jordi
