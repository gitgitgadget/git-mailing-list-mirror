Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7314A1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 23:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeCZXd0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 19:33:26 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:36106 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbeCZXdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 19:33:25 -0400
Received: by mail-yb0-f182.google.com with SMTP id o3-v6so4477290ybm.3
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 16:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhUO10816Zdru14bsUn2HazSqDsX4J3MWoiS9tyaGSY=;
        b=YGVicPx9iipDWK0xTOfLSmrlQ4SDECzhCY1FaJ9IEYVSTCrsn/Inxr2dJC5avL1Xgr
         TGH68OrvAk53KozanyIjvthB0bjy0gyCHI/VEeEb8AqEtnp5Qza67JSdmdOfS8j+Vo0m
         wQ4tonTVK7GtxaDjzbvKlrBqzt0ah8oHC5rFrDRo5/StORM94qdf9IRJrMTIwtUszTNP
         0gVclMWqG5Wvb3UJ0h3KP5FCIacK2rGR7JAMO95oK3fPvz7Caim4bWuuQHGmXlG2Nr6p
         qh01/fxN6lg8Q+7cMQwjNM+biUZXDGWISSxD7mhQaSNKecAvn2vUHP5rmdyYMN4iCh+q
         tn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhUO10816Zdru14bsUn2HazSqDsX4J3MWoiS9tyaGSY=;
        b=dWZJP4fY13YtOSqLPQ1ntsiUlmdlYrvruoJGqhFbJZxwFXA/Sfv3eyNGAtuZX2naay
         3XZFY01JEfg5QK+tQlNVAw36vYHVNBW+n2SmS3uKYN/R4292SLVrLx9I8ReLPzZvBzaB
         jSQqMpmBR0jgp8rbUGlWdZmtf3gnGtCfSB8Be1cho3qIoeOxhJNVMDnuIdEW+Y7B7T73
         CZF/044CXhcPnCjjZ3Q7hGMsLPhWOAS/lHnbZAwDufHl8s/re960wXWfsPsKf0n6cLWs
         /9cSluM5SjLYgV/c7wbNJTxv8XkTYC6/ocmLTUOviHi94BlpCuLyFMJbQ4VtqkTQFNqG
         WvtQ==
X-Gm-Message-State: AElRT7GQ3U8VYwauy5VxU7acHRYvDLFFEI7UXGVVQY9BFBRmNkRUP1xJ
        eNttfvBbHB9yhOFEptzFqCb9+jENLsVMh9JsZrrEgg==
X-Google-Smtp-Source: AG47ELsbX4QFyl2hRyAGJYD68cncxwZ2UZrhcoXKNmsYGPjBrzxSVlhUJPmRDj/W2+z6UOQOoo7X9e2rY5GGr3AIkJo=
X-Received: by 2002:a25:9841:: with SMTP id k1-v6mr24869079ybo.352.1522107204411;
 Mon, 26 Mar 2018 16:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180309150719.GA30596@inner.h.apk.li>
In-Reply-To: <20180309150719.GA30596@inner.h.apk.li>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 23:33:13 +0000
Message-ID: <CAGZ79kZ16+ZtcXx45nvcOeT0wSM7TEi8iDoxB6An91d-FanZhg@mail.gmail.com>
Subject: Re: git submodule update - reset instead of checkout?
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 9, 2018 at 7:07 AM Andreas Krey <a.krey@gmx.de> wrote:

> Hi everyone,

> I've been reading up on the current state of git submodules
> (our customer's customers want to use them, causing a slight
> groan from our customer).

> The usability thing I wonder about - with git submodule update,
> is it necessary to detach the head to the current (or upstream)
> head, instead of resetting the current branch to that state?

Try "git checkout --recurse-submodules" or
"git reset --recurse-submodules"  (there is also the
submodule.recurse option in case you don't want to type
the option all the time)


> Primary interest in the question: Seeing 'detached head' scares
> almost everybody. To brainstorm:

I agree on that. That is what we are trying to work out
eventually, too.

One idea is to "reattach the submodule branch if it fits"
another idea would be a submodule ref store that is
(partially) tied to the superproject, such that the HEAD
of the submodule is non-existent for most of the time.
https://public-inbox.org/git/cover.1512168087.git.jonathantanmy@google.com/

> - as we can already use 'submodule update --remote' to update
>    to the remote head of a branch, it would be logical to have
>    that branch checked out locally (and unfortunately, potentially
>    have that branch's name conflict with the remote branch setup).

> - when developers more or less accidentally commit on the detached
>    head, all is not lost yet (I remember this being differently),
>    but if the next 'submodule update' just resets again, the commit
>    just made is still dropped, just as in the detached head state.

> - So, we'd need to have 'submodule update' act closer to the pull or
>    rebase counterparts and refuse to just lose commits (or uncommitted
>    changes).

> Having a checked-out branch in the submodule would have the advantage
> that I can 'just' push local commits. At the moment, doing that requires
> a relatively intricate dance, not at all similar to working in the
> base (parent) module.

> I'm working on hooks that automatically update the submodules after
> a commit change (merge, pull, checkout) in the parent module, but
> with the additional feature of (a) keeping a branch checked out
> and (b) avoid discarding local changes. Probably means I shouldn't
> invoke 'submodule update' at all, and deal with everyting myself.

> Any thoughs/comments/helpful hints?

Our plan is to deprecate "git submodule" just like "git remote" is not
a well known tool any more. (e.g. Instead of git remote update, use
git fetch, that learned about updating the remote tracking branches
on its own)


> (Addional complexity: egit/jgit is in use as well, and the work model
> we will arrive at probabaly needs to work with the current egit.)

That sounds familiar, we also have JGit/Gerrit in the setup.

Stefan
