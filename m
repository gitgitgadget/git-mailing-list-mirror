Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B62F1F51C
	for <e@80x24.org>; Fri, 18 May 2018 22:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeERWvU (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 18:51:20 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44757 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbeERWvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 18:51:19 -0400
Received: by mail-yb0-f196.google.com with SMTP id s8-v6so2010677ybp.11
        for <git@vger.kernel.org>; Fri, 18 May 2018 15:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WPgw7MpOC7yZF+dax1/hyC4SA4wArR+z3NFrFbraAJE=;
        b=ljN4ueE4UZHWpYHHBbvdCEKzD8DAdSU2J+tRZfYm+0Q1ktROsfdm35XKA182nhKCRx
         11RlUM+edXl6fVI9mtdaxebFF0581wFecUF13ymaWhmLtyK9xqKx+pniQJWBQ6XJ6GI8
         3ue4bQAO2xl3jLvK024RAuZrjqptQL5d1KYYWCHfKOimIS+KkdpkNj5tLTL4B0hTgGlC
         UWkAVwB4ysfZ/y4nvbibV/MUsFGn5dqmfM0x9FGW75KvlJnY/uG3rn0mxoQyUTbUgqBM
         yfh7yZ0n1JJdF0vKD67w8kaSy/iZNOHg5MK9iNSPAftVt+Atbn7cubGotu2wNS48nho1
         nleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WPgw7MpOC7yZF+dax1/hyC4SA4wArR+z3NFrFbraAJE=;
        b=pL3rXNI3aIGjxP3pBUOQIF+mmQ3zG90xkn/Y22wPgBqwnqLIeVZs+SJhRn8r9Hk1QT
         59hczuncXd+Y3OEaozb6iy7JVQx6y0U/5J7rzejH1GwfpgGO4s4rRD+V/UyQhHHNGw52
         /y4B7K7957RZoBxN+gX+TDEZ+Gj9Wys2B8vJZewDVHwuwnrLI6qPH/k2gDbkprp03u2z
         uMzDo3XUOByOAqZsmkGpF+vMf7SzGP6WvjlQfjkpwZg7iNks53ItC7r76VePVtA5XjNM
         sK8PfMEWai9DmknLOZnJjr9s/Q09qzBzxqieyEmLOZ8OSzDHK61KOX5ic0cSMwZP5/xt
         AmMA==
X-Gm-Message-State: ALKqPwcbMR9WQmbqN0ZP1G8AnaMuuMrf0kvvjRqrgX3VSTc3WhnkGv8p
        YZZs45Vm7Xbh5KwngOVrBY9Qmeifm1Ekh2xrDYGgLg==
X-Google-Smtp-Source: AB8JxZpkmof0UODK0I3jgAnRll1yGALHS2TbPK2ZxutnwfiPsptpCXnwnZWbYI10vs5meW0hqHbAjFNqzGEFroxBc6o=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr6589016ybc.307.1526683878092;
 Fri, 18 May 2018 15:51:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Fri, 18 May 2018 15:51:17
 -0700 (PDT)
In-Reply-To: <20180518222552.GA9623@sigill.intra.peff.net>
References: <20180518222506.GA9527@sigill.intra.peff.net> <20180518222552.GA9623@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 May 2018 15:51:17 -0700
Message-ID: <CAGZ79kbE5bdeFnQw=EiRw2iTw4mAs5=RefAh9oxYn9+yjy7YRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] get_main_ref_store: BUG() when outside a repository
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 18, 2018 at 3:25 PM, Jeff King <peff@peff.net> wrote:
> If we don't have a repository, then we can't initialize the
> ref store.  Prior to 64a741619d (refs: store the main ref
> store inside the repository struct, 2018-04-11), we'd try to
> access get_git_dir(), and outside a repository that would
> trigger a BUG(). After that commit, though, we directly use
> the_repository->git_dir; if it's NULL we'll just segfault.
>
> Let's catch this case and restore the BUG() behavior.
> Obviously we don't ever want to hit this code, but a BUG()
> is a lot more helpful than a segfault if we do.

That is true and an immediate bandaid; an alternative would
be to do:

  if (!r->gitdir)
    /* not in a git directory ? */
    return NULL;
    /* We signal the caller the absence of a git repo by NULL ness
      of the ref store */

However that we would need to catch at all callers of
get_main_ref_store and error out accordingly.

Then the trade off would be, how many callers to the main ref
store do we have compared to options that rely on a ref store
present? (I assume a patch like the second patch would show
up in more cases now for all BUGs that we discover via this patch.
The tradeoff is just if we want to report all these early by checking
the config and system state, or wait until we get NULL ref store
and then bail)

I think checking early makes sense; I am not so sure about this
patch; for the time being it makes sense, though in the long run,
we rather want to catch this at a higher level:

r->gitdir is supposedly never NULL, so we shall not
produce this state. Maybe we want to set the_repository to NULL
if set_git_dir fails (via repo_set_gitdir in setup_git_env, which both
return void today).

Enough of my rambling, the patches look good!
Stefan
