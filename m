Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D31A209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 10:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbdIFKxj (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 06:53:39 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36340 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbdIFKxg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 06:53:36 -0400
Received: by mail-oi0-f44.google.com with SMTP id x190so23773939oix.3
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 03:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kj+7CxRfGso4BVexF0oRRUaevT37yA+lXY5TteEY6Fw=;
        b=JAJ1ZMBGgKz8ehNMwqOdCm/QCUlj/1oRn78v4URbN3rMjtoB4pEwqEC8cttYECVou1
         o+QBFMuGHnfkHtSAOrIVTPPKQN+CW4nEksyZZbsVTDXGbIL49QQl873LpnUtrAsPCYK1
         27X8fwsuhHLLUNu4L5Md6t0xCNoFD2M2FOU1LvxvLTzaS23y9UoQFGH8jYqoxdQ2k/ds
         0y9HA2+OaYbyOr3mXkZVWTG6iwV1wsS2PCn3VEstwDIrhddQqqceG5EVApBJit/fuQJL
         3w01DTXfcG8uqark8faBKQZuzdCA7e+3gfUUTd6DO7zFwYXt8QSLqb9m3Hbg/03s7Zhq
         13Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kj+7CxRfGso4BVexF0oRRUaevT37yA+lXY5TteEY6Fw=;
        b=mldqVCOS3xgEAthQLYMwU8hExayQ+taZjGioppqvUhP9PM13w1LO+9vXF7EZnLLwXj
         MiH0eVKSLo/Pk21ZzqPHIh1V8TV7X4MrhhVi5qRb4KSdYBbzy05l1ZF335ZMQcZnxQ+7
         gkGbGev43g9YGax6QdRxn8c0g1ziozJ1AbHkrBWuhi+eo40IByCck6URiZBfeqOIFTGk
         LkdP5b5hCER8r8yGAivYWf+mL5rjm0g1hd/q7x1QpNo8rDekjIAuW9XjWFeK/sIs9kUK
         nMNCmAIJRVf1ErnAgl9unswxp3pd2kxVnOqIV0DQzOokiTBSTSmh7nt53txrYmlRmEy0
         IrzQ==
X-Gm-Message-State: AHPjjUhJaXWWLtNHEtib2CkOsGA+mh0UDCfIG/jvbk4GuT+RAUlj9k82
        o/kpxlA2XOK6dQJPWepBQORNskMgpA==
X-Google-Smtp-Source: ADKCNb6PUjbD8JVInGn0wRvirZ0sJyWr8/rfzOX9BHG7EcdB6HvwLC5Xl+9B6ATQDoEXih4iK1WCoPUvYU0os2i14tA=
X-Received: by 10.202.173.11 with SMTP id w11mr1965513oie.239.1504695215959;
 Wed, 06 Sep 2017 03:53:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.176.69 with HTTP; Wed, 6 Sep 2017 03:53:05 -0700 (PDT)
In-Reply-To: <6b67875c-847c-8d5f-14bb-c3fb7004ebdc@grubix.eu>
References: <20170823123704.16518-1-pclouds@gmail.com> <6b67875c-847c-8d5f-14bb-c3fb7004ebdc@grubix.eu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Sep 2017 17:53:05 +0700
Message-ID: <CACsJy8Cd20iPo4uv5+sq0SiuPT3Y6sxEtJqDsox+3tVRsgg9UA@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] Fix git-gc losing objects in multi worktree
To:     Michael J Gruber <git@grubix.eu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 6:21 PM, Michael J Gruber <git@grubix.eu> wrote:
> I suggest we think about the UI exposure a bit when it
> comes to including all heads or naming options, though:
>
> * HEAD is "the current head"
> * refs/heads is where all local branch heads are
>
> * --branches is the rev-list/log option for refs/heads/*
> * --all is the rev-list/log option for refs/* plus HEAD
> * HEAD is the rev-list/log argument for HEAD

It also covers object references from the index file aka --indexed-objects

> * --heads is the show-ref option limiting to refs/heads/*
> * --head is the show-ref option which adds HEAD
>
> * refs/heads is the for-each-ref-pattern for refs/heads/*
> * HEAD is not the for-each-ref-pattern for HEAD
> [I'll suggest a patch to change the latter, shortly.]
>
> I would hope that the result of this series and other efforts will be:
>
> * consistent way to specify "all local branch heads"
> * consistent way to specify "the head" aka HEAD
> * consistent way to specify "all linked worktree heads"
> [* maybe something for submodules...]

Hmm.. I admit that I completely overlooked 'git show-ref'.

> This may require changing the misnamed show-ref option, but also
> thinking twice before changing the meaning of "--all" for the
> rev-list/log family: it's easy to say "--all --linked" or "--all
> --heads" to get everything plus all linked worktree heads when "--all"
> == "--branches --tags HEAD", but it's more cumbersome with a changed
> --all that is "really everything". I gues my suggestion would be:
>
> --all as it is now (refs/* plus HEAD)
>
> --head alternative way to say HEAD (as it is now for show-ref)
>
> --heads HEAD for all linked worktrees (incompatible change for show-ref)
>
> And all of them should work the same for the rev-list/log family as well
> as for-each-ref/show-ref.

How about: show-ref learns a new option to let it list HEAD (and other
per-worktree refs) of one/current worktree, or all worktrees. This is
what the --single-worktree option is for, which is added by this
series (but I need to make sure if's exposed in show-ref as well). For
showing refs as viewed by another worktree, we could have the global
option similar to --git-dir to select that worktree, e.g. "git
--work-tree-id=XXX show-ref ..."?

Since this seems a good thing to do, but not necessary to fix the
"prune" bug, I'll do it separately instead of adding in this series. I
may need to look at "git for-each-ref" too for that matter.

> I thinking that changing show-ref (porcelain, not quite as commonly
> used) should do the least harm compared to all other options.
-- 
Duy
