Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75BEE1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 17:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfIZRxP (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 13:53:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35000 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfIZRxP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 13:53:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id a24so1973506pgj.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7f6N9JMmjy0DNFu74ESMVtya+Mj8iYEms4WES5/pyh8=;
        b=XIexJLw/MnrEdoztI5UriUYkeq1wEmmLe7kDQselHiFnTXzz7BSCgVXr4y1vaD4oWJ
         V4oL1wJO0pziLapIjsUsI7sPXJReixVDAaL5osKfj8AWnlqEN7v0lC/X2I6DFhkaZ92H
         sCvH7w68mNsp/U4nUHnBBz2WzLwucZXdCZiE7VykqYaTLheNR1MiWnkDNtvShbAedK4L
         6iw0qYtJGPXavq6DyyN5VHmkXicQjuG+UrAh99TfQb9/zjHi8hUSr1lWDamvXOpLOzn9
         z5pVwALVAKlipkK2PIl/ir205sw9h1Vq1nTtTcyliMy+8RHnI52AMy9qQDqY/h1KMz5h
         pqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7f6N9JMmjy0DNFu74ESMVtya+Mj8iYEms4WES5/pyh8=;
        b=VMk+pmmjNHWbi8K086iIqiYbyitBsCZno7bk4ZyKAZ4o9+0cuRuHL+nedtwZ7bnNoz
         0PwzpVxyVtE3qobifzcbR7lVwu+GnFoe0ghWMF8lsCcBspytCr9vTsBFki3M7x+cZM/T
         KND8pvdzuJJDun7aZuStavL3w9D+bHQgg6rn3KKuRJzl7/T+GR47OX+/qCfAt7dxTsci
         hcmDVb4dw223j4VHU143y+qZE4/0MIDGlWoE2O9tTsQqZn5aldmPrOudzxBvcSmioF6K
         r76ILRBaixe49h/5+IMu5KKcdRnoACBkH+sowKZB1YM4HyMjoaFp230pwrNLwZdRLuu9
         YDlg==
X-Gm-Message-State: APjAAAWsO6pSdQA4twD15WpwGKEwHPDaY8NKuvh28oeUy7BR1IwQUawR
        IEYIEszbST/vGTXkpfd1XbEeyw==
X-Google-Smtp-Source: APXvYqwit9oWPRLoKO/+OWPhQHpG5iunC433CZY6UDrcNiz1CFQVq5iIxmkXyvNh4kwsJMcNKvX26w==
X-Received: by 2002:a62:2f85:: with SMTP id v127mr4939435pfv.68.1569520394038;
        Thu, 26 Sep 2019 10:53:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id z4sm3966079pfn.45.2019.09.26.10.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:53:13 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:53:08 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] promisor-remote: skip move_to_tail when n=1
Message-ID: <20190926175308.GA223193@google.com>
References: <20190925213718.231231-1-emilyshaffer@google.com>
 <20190926075535.GC20653@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926075535.GC20653@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 03:55:35AM -0400, Jeff King wrote:
> On Wed, Sep 25, 2019 at 02:37:18PM -0700, Emily Shaffer wrote:
> 
> > Previously, when promisor_remote_move_to_tail() is called for a
> > promisor_remote which is currently the *only* element in promisors, a
> > cycle is created in the promisors linked list. This cycle leads to a
> > double free later on in promisor_remote_clear(): promisors is set to
> > promisors->next (a no-op, as promisors->next == promisors); the previous
> > value of promisors is free()'d; then the new value of promisors (which
> > is equal to the previous value of promisors) is also free()'d. This
> > double-free error was unrecoverable for the user without removing the
> > filter or re-cloning the repo and hoping to miss this edge case.
> 
> Nice clear description.
> 
> Is the problem only when the remote is the only element of the list, or
> would it also happen when it's at the end?

It totally does. Nice catch, I wasn't seeing past my specific example.
:)

> 
> I think the problematic lines are:
> 
>   r->next = NULL;
>   *promisors_tail = r;
> 
> If our "r" is already the tail, then promisors_tail points to &r->next,
> and we create a cycle in the linked list.
> 
> I think if you swap those two lines, the problem goes away. That said,
> it's subtle enough that I think covering the noop case at the start of
> the function is much clearer.
> 
> Using that strategy, I think this:
> 
> > +	if (promisors == r && promisors->next == NULL)
> > +		return;
> 
> should probably just see if we're already at the end, which also covers
> the single-element case. Like:
> 
>   if (!r->next)
> 	return; /* we're already at the end */

Hmm, I guess I wasn't familiar enough on the lifetime of a
promisor_remote - I suppose I was expecting
promisor_remote_move_to_tail() could be used for a first-time insert,
too, although it looks like promisor_remote_new() actually does the
insert for us every time.

> 
> or possibly:
> 
>   if (promisors_tail == &r->next)
> 	return; /* we're already at the end */

With the above concern I initially feel a little more comfortable with
this, although now that I'm thinking through the case when 'r' isn't
already in the list, I think it would replace the entire list by taking
the 'else' branch, having a nulled r->next, and therefore replacing the
head pointer 'promisors' with itself.

So, considering that in the former approach incorrect usage (I calloc my
own promisor_remote and call move_to_tail() on it) is a no-op, and in
the latter approach the same incorrect use case is disastrous (we leak
any promisor_remotes already in the list), I'll stick with the former.

Thanks for the suggestions and for pointing out my edge case was wider
than I thought!

> 
> I also can't help but think this would all be a lot simpler using the
> implementation in list.h. Then we don't have to pass this weird
> "previous" pointer around (because it's a doubly-linked list). And
> functions like this one could go away in favor of list_move(). But
> that's obviously a bigger change.

Agreed. I joked to my team that this was the first time I've needed to
understand linked list manipulation outside of an interview setting,
ever ;)

> 
> > This change showed up for us in a user bugreport; I'm actually fairly
> > unfamiliar with the codebase here but given the drastic nature of the
> > failure, I wanted to get a fix up quickly. I'm still working on how to
> > reproduce this exact case in the test suite (and actually would
> > appreciate any pointers). Specifically, it looks like we only really
> > break if we have a single promisor_remote in the linked list, call
> > move_to_tail() on it at least once, and then call clear() on it without
> > adding another promisor_remote first.
> 
> The only call is in promisor_remote_init(), where we try to move
> whatever promisor we get from looking up repository_format_partial_clone.
> That name in turn comes from the extensions.partialclone config.
> 
> The init function also creates elements in the list from any remotes
> marked with remote.XYZ.promisor in the config.
> 
> So this is enough to create the cycle in the linked list:
> 
>   git init
>   git remote add foo /wherever
>   git config remote.foo.promisor true
>   git config extensions.partialclone foo
>   git fetch foo
> 
> but it doesn't trigger the double-free because we don't ever free
> anything. We only call the clear() function during reinit(). And that
> only happens in partial_clone_register(). So if we take the commands
> above, and then try to actually do a partial clone with it (causing it
> to re-register), I get (building with ASan, but vanilla glibc seems to
> detect the double-free too):
> 
>   $ git fetch --filter=blob:none foo
>   ==30356==ERROR: AddressSanitizer: heap-use-after-free on address 0x603000001f90 at pc 0x559adb9a0919 bp 0x7ffeb7a52b30 sp 0x7ffeb7a52b28
>   READ of size 8 at 0x603000001f90 thread T0
>     #0 0x559adb9a0918 in promisor_remote_clear /home/peff/compile/git/promisor-remote.c:173
>     #1 0x559adb9a0918 in promisor_remote_reinit /home/peff/compile/git/promisor-remote.c:183
>     #2 0x559adb5856c0 in fetch_one_setup_partial builtin/fetch.c:1570
>     #3 0x559adb5856c0 in cmd_fetch builtin/fetch.c:1736
>     [...etc...]
> 
> Another way to manifest the error:
> 
>   git remote add bar /does-not-matter
>   git fetch --filter=blob:none bar
> 
> Now we'll try to register "bar". But since it's _not_ already in the
> linked list, our search will go on forever, since the list loops back on
> itself.

I really appreciate your coming up with these cases. I'll test-ify them
and send another patch, plus the modified fix as discussed as above.

 - Emily
