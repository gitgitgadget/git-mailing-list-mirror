Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 405561F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbeGaToV (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:44:21 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:39583 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeGaToV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:44:21 -0400
Received: by mail-ua0-f202.google.com with SMTP id t14-v6so4270154uao.6
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0wjT88LLp15wyP4iv1YCIVARY0/aAJvIfgVOsDGvkMA=;
        b=fLrvfGZ48cukd8a250axa31FSrqleWo06xuHIY4D5Rty9d0MNlNV7WMeusAGa1gfWE
         nOIzFHcSNwXOl17GbMoZScD4VlvqRrvMzj3gwcikJyw+RRKSmfxEMObJiBHg9gBpOcxn
         g3lmYh9sjAm9JhlbanPMrbtarKyNZiumxFJ+rqsEQuzzXp4BGyuX5G3jWriSsHjn8Fu3
         YudAZRSAAtkZda3WxV7D2WvPLWi+vZkLN3Q9dxfU0ZsGqVi2Z3f2vRFLAI2ZYIF05MFb
         6wR6cmP2Asft01KPactWoljcWwJ9lpg1SL9qGLhs9OtkqBVfJxOYOGcOKRZqEXCcfsHS
         BAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0wjT88LLp15wyP4iv1YCIVARY0/aAJvIfgVOsDGvkMA=;
        b=snjqtpu9z8j9eMo6MtBuf9NpfNBTn/ktqWtEtOxVG0W966GUO+3UNHojgEnsYeTUWp
         oT6YOCefWddIVwr2f+QnE42IB1QvbwDqRM4nr1RauumvUMSxo9l9XxF1XPmUwLYw7WWk
         XVrWuJcoLbkhJuWULCTCpHBq64/ZWueZ5uyJ6Jsmpohy7iC2sV7PqIWUZ9cQzU96G7rl
         hemXix8E2YUECjMic2yv/oaG5UC4Jls7hWea2TjP9+wtLbv162zk1VjsfXNQVYg0yU7d
         AUDg4VGPjRnLGtWDBIn5q/IdQvCutRdMxiVs4nLf0PehrogajykTCWnkGf/AOHq0wkZn
         5/GQ==
X-Gm-Message-State: AOUpUlHEoRodLr0V3egI5/l6ejn18qhdsusUV8Xpm24UcZOLVf24hnrh
        Eeeq8dyZqz/hIKlmRzDMaXQIdgvQFbh1MciLZzZ6
X-Google-Smtp-Source: AAOMgpdBUHTFWlvLzsEXMCPfEiJM8LXCnsUspcKQ8jNaXla+aZG4Colv1oUT7GXPYvBo6KqQ2BfjAn5kf/SJ5FmowNaB
X-Received: by 2002:ab0:51b5:: with SMTP id g50-v6mr10730551uaa.55.1533060172569;
 Tue, 31 Jul 2018 11:02:52 -0700 (PDT)
Date:   Tue, 31 Jul 2018 11:02:48 -0700
In-Reply-To: <87r2jjtpmb.fsf@evledraar.gmail.com>
Message-Id: <20180731180248.42787-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87r2jjtpmb.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.18.0.322.g81f971752d
Subject: Re: [PATCH] negotiator/skipping: skip commits during fetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +fetch.negotiationAlgorithm::
> > +	Control how information about the commits in the local repository is
> > +	sent when negotiating the contents of the packfile to be sent by the
> > +	server. Set to "skipping" to use an algorithm that skips commits in an
> > +	effort to converge faster, but may result in a larger-than-necessary
> > +	packfile; any other value instructs Git to use the default algorithm
> > +	that never skips commits (unless the server has acknowledged it or one
> > +	of its descendants).
> > +
> 
> ...let's instead document that there's just the values "skipping" and
> "default", and say "default" is provided by default, and perhaps change
> the code to warn about anything that isn't those two.
> 
> Then we're not painting ourselves into a corner by needing to break a
> promise in the docs ("any other value instructs Git to use the default")
> if we add a new one of these, and aren't silently falling back on the
> default if we add new-fancy-algo the user's version doesn't know about.

My intention was to allow future versions of Git to introduce more
algorithms, but have older versions of Git still work even if a
repository is configured to use a newer algorithm. But your suggestion
is reasonable too.

> Now, running that "git fetch --all" takes ages, and I know why. It's
> because the in the negotiation for "git fetch some/small-repo" I'm
> emitting hundreds of thousands of "have" lines for SHA1s found in other
> unrelated repos, only to get a NAK for all of them.
> 
> One way to fix that with this facility would be to have some way to pass
> in arguments, similar to what we have for merge drivers, so I can say
> "just emit 'have' lines for stuff found in this branch". The most
> pathological cases are when I'm fetching a remote that has one commit,
> and I'm desperately trying to find something in common by asking if the
> remote has hundreds of K of commits it has no chance of having.
> 
> Or there may be some smarter way to do this, what do you think?

Well, there is already a commit in "next" that does this :-)

3390e42adb ("fetch-pack: support negotiation tip whitelist", 2018-07-03)
