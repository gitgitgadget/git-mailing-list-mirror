Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5935D1F461
	for <e@80x24.org>; Fri, 17 May 2019 01:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfEQBCU (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 21:02:20 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:34844 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfEQBCU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 21:02:20 -0400
Received: by mail-wr1-f44.google.com with SMTP id m3so5107645wrv.2
        for <git@vger.kernel.org>; Thu, 16 May 2019 18:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCc6u+sKsjO5IH8ZFd5b+DUYfcUzAvm4uW9j+8leyvI=;
        b=gOAfmcalWqeBB6ASe6otAC5oekcu5z649CQ5WAwMt7Tn8pgBedHdgWuhWHTycbC+KP
         EidX1o5+ZJGoWIaPL70D2bVgpcSEAqj8urfO7i6+0QxWNwwdNLu3UGFPfXy/vEx6ZQpZ
         KL+yBwBJjKFX0zrhXHaxHxQ4hvfR4EW98OzvXCz+mNQG+6vE4KKJ42c0WpqRdGbXCkFu
         cm0o8fsQEHpaOGRsAh1Os5Psc66cYLIToyGaoTqjOoyMOVJD1WoOvYKl/vmTdLXpcfOq
         RNSBgAvvMlx05UekAG0S6lG5zZ3g4g3lCFFatfGJ02QHFXs5UyAzsNyh4V+A9STLb4/G
         rprQ==
X-Gm-Message-State: APjAAAVIK/0IqF1gKzateQ4bUOMlqIJ2cPVIZ6+s2fHq3sBJbZvXWtqm
        XnGD6i6VD4erlzFRfRqnG7JtPnKEXGIPJSrHSR4=
X-Google-Smtp-Source: APXvYqywCD+hwyLAqqtgQ0re28nbYMWom2gwKU7eIjCJL+aQF5GBbyjqUaBIySiskAbtOAmt4MJqu6YZRcFR3H4MVtM=
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr15411628wre.9.1558054938455;
 Thu, 16 May 2019 18:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
 <20190516221702.GA11784@sigill.intra.peff.net> <CAPig+cQQ5svrDKRPenL2+bJHGjddUPnAXCFSsQN+WBHqzGpDow@mail.gmail.com>
 <20190517001926.GA13525@sigill.intra.peff.net>
In-Reply-To: <20190517001926.GA13525@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 May 2019 21:02:06 -0400
Message-ID: <CAPig+cQpmD9+frJWNfcts1+RFBTjrHUHk_eR4Y94GAnGZC=7hQ@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 8:19 PM Jeff King <peff@peff.net> wrote:
> On Thu, May 16, 2019 at 07:16:54PM -0400, Eric Sunshine wrote:
> > Is there
> > any existing code in Git for doing the relative fixups you mention for
> > other Git environment variables?
>
> You can assign local_repo_env to child_process.env (or push it
> individually to env_array if you have to mix with other variables). See
> git_connect() for an example.

I wasn't aware of 'local_repo_env', but can see how it could be
helpful as a basis for building machinery to adjust relative paths
contained in those environment variables prior to a chdir(). My
original question was if such machinery already exists, but I'm
guessing from your response that it doesn't.
