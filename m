Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E1FC47097
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 08:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E56F613DE
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 08:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFCI34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhFCI34 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 04:29:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB412C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 01:28:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s6so6098422edu.10
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bscfj/tIj2ugl3+RDzil7sBXzN57V0frJkWd3qqLuFw=;
        b=JCnHjT9k3rPI1RW1WNXsL8rnIQPVdJKjrRffb6I8kKc0q8Qx1NK+wdzv9Gyre6GYuY
         5rePLOqiqf0I6uB3VAN6e4UuR92fi6k9ghdi2QyT41kvGvdCrT8iHVcle64jRYIhSkRQ
         9LdDnaCSayIgrMOFYBlr2hr3Ipz0A0PBYbo80FonoE8ZwPf5VXHYmZ6FlhaG1MEHBHzi
         w2RJyuIpoVClW8lgXhw9zz42I8JMRHNLP5kZHLJa2U7L6h3xuMT2W18ISqlJXI47H7Y1
         I45wN6B9TcnTyunThsiOAIPUhMQ4KQzRZn22imvILWng7aG5OpJIXDXybnC/sGzq/VQG
         FQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bscfj/tIj2ugl3+RDzil7sBXzN57V0frJkWd3qqLuFw=;
        b=jBhXGQzIbrVbQ5oLTNunQzOTCkgFbI8IjgATdXPeWeD4ST2TepHJ4YTiPQdX22QkMw
         +QlilmvVbi/ZlTyFJTJfvpD39LnGnb3s/ZSNaAX3uL0xH5aquP7yC0ueexVJl5LsZPG6
         lak565MFlrOd76ASWWrl18t/ddVsvLbfiMEX/eq2eays+i1JmYRecoRm+HuIGVyd3B1W
         D5rtmP8zO85WNowXOnry603si0iBbIgt6JTt65Yc3jKj2BgTG2XExV39HkEjSRR5WlZV
         /kbMNg1rgWaivw+2LYC+l7spNKml5wouGQdqrglTRuKq0O9XCv2YqGwhBZEQeNWxFYEo
         sIZA==
X-Gm-Message-State: AOAM530ocV+I2EeuwfrEW7GmXtTKUBvaxwAu7LiK2mYdeeWg2pQ8qyHD
        sYb+w8rQZLyo1JNjhhFYcr0=
X-Google-Smtp-Source: ABdhPJz+uJmdNdhqDJ9YmIIYSCdHfBzTAllqFugART4yKJdquJEczCYUb2icgaqEnOvxOG7WjriOSg==
X-Received: by 2002:a50:ec08:: with SMTP id g8mr22339648edr.376.1622708890386;
        Thu, 03 Jun 2021 01:28:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ot30sm588545ejb.61.2021.06.03.01.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 01:28:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
Date:   Thu, 03 Jun 2021 10:15:48 +0200
References: <60b5d281552d6_e359f20828@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60b5d281552d6_e359f20828@natae.notmuch>
Message-ID: <87bl8n73om.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 01 2021, Felipe Contreras wrote:

>   1. Remove all the configuration that is not essential (just leave
>      user.name and user.email or equivalent)
>   2. Pick 2 configurations you think you can't live without. You are not
>      allowed to change them afterwards.
>   3. Every day you can add 1 additional configuration (and update it the
>      next day).
>   4. The moment you add a 4th configuration you lose.

This proposal is somewhere between picking which 2 of your 4 kids gets
to live and asking an alcoholic to stop drinking for a week just so he
can tell you at the end what his favorite drinks are :)

So I skipped the "disable most config", but for what it's worth I think
I'd miss these the most, I couldn't pick just N favorites, sorry:

 * diff.colorMoved=true: super useful, but I'd be vary of turning it on
   by default in its current form. E.g. on gcc.git's changelog files it
   has really pathological performance characteristics.

 * rebase.rescheduleFailedExec=true: Relatively new, but I'd find it
   hard to live without this now.

 * rerere.*: others have mentioned "should be enabled by default".

   But on that topic I set gc.rerereResolved="1 year ago", with
   managing/merging topics in git.git the default of 60 days is way too
   aggressive.

 * merge.defaultToUpstream: ditto other discussion, should be "true" by
   default.

 * checkout.defaultRemote=origin: I introduced this, so I'm biased, but
   I find it super useful. Usually because I do "git branch -m
   new-branch" on master to create topics, and then "git checkout
   master" to get a master back (or use the existing one).

 * commit.verbose=true: so you know what you're looking at in doing in
   "git commit --amend".

 * grep.patternType=perl: Another personal soap box (but really, BRE
   anywhere sucks).

I also have a bunch of aliases that would not be useful to a general
audience, but which I find I can't live without, some of the most
commonly used ones:

    # Log with "less" n/p already going to the next/prev commit
    log-psfd = "!f() { PAGER=\"less -p'^commit'\" git log -p --stat --full-diff $@; }; f"
    # cutesy commit aliases (I guess "commit" is both "ci" and "c" here, but...)
    cif = commit --fixup
    cis = commit --squash
    ca = commit --amend
    cane = commit --amend --no-edit

Similarly rebase is "r", "--interactive" is "ri", "--abort", and
"--continue" are "ra" and "rc".

If anyone's interested in the rest / full set:
https://github.com/avar/dotfiles/blob/master/.gitconfig
    

