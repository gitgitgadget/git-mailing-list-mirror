Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09562023D
	for <e@80x24.org>; Wed,  1 Mar 2017 20:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbdCAULO (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 15:11:14 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36139 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdCAUKp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 15:10:45 -0500
Received: by mail-pf0-f170.google.com with SMTP id x66so14111063pfb.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 12:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wM5OrukEaPTZ8FA9IJPMgf5qe/AiEOPjw7bv3C/Lvjw=;
        b=s2YPuBW4x/utS+45yCz1PZQdv5NatNdim6RU45dOIbEy4DoeVPmII7dXu227aG5lT8
         AXFCTm6VHLZTEwsdJhKP1GwgiYvCIBjR9hovt+c7pmOOM/Y2qQ2GCP6uvN8oX9xs1AzN
         l2ENe27JGu2plSGRba1HJJCIMuh5D9L9jIgI+XG/WP1Rv+j2wlqG5aYiTTeSMOZCZx68
         jIid+2ace8siaXXWL6oP5Ja7zKafl02ODU0kpnNyI85dW/y5QFqcyK24lOupx5HYuz6Z
         cp8EaG/qhna3FoOa5kYqxsnE8DNTVNiLcwEvatStNZXxu8d2acSiS+UNiG34mUGa2iY4
         Mr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wM5OrukEaPTZ8FA9IJPMgf5qe/AiEOPjw7bv3C/Lvjw=;
        b=AL6vS6vvmaZXOnnXiQRJ4nzQNRA2bsL+H8M+HIkzhjitP0xr0CDIONjX1iOfa3p2m8
         0194fYLVIkmEpnPK3Gb+gy7cAetJjKMy9KvgKjTKBk2z/XLYMVS4wJ+LAnW5brJ3KTz7
         Zmq2dXnMYdd3stOA82xSRO2ucIybGxh2VoP0n4zwsk/V9jXE8EjOBTOBb9ssCEiab4+g
         1Jd+B5r4ELkKDZmsaU6RTj9eWOl0GktZBuXRZNa4zEs0MJL+b+QZHv8GpEaEwp86ffvj
         XwayhHZUkJn+1qRVoS+fAL4tSOyLvK32rxEHCe6MeSi6rv29Eee65oSCXp89CjBCtoE/
         oNRw==
X-Gm-Message-State: AMke39kVBsrzcqYoqNrq0ZqxUtfAYL1i86Il9IG564sP7HvtOd3PfKiPFtJxTwTEddTMLMOw
X-Received: by 10.84.229.10 with SMTP id b10mr12752510plk.148.1488398552950;
        Wed, 01 Mar 2017 12:02:32 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:e0de:6ae7:be31:6259])
        by smtp.gmail.com with ESMTPSA id y5sm12274517pgy.28.2017.03.01.12.02.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 12:02:31 -0800 (PST)
Date:   Wed, 1 Mar 2017 12:02:30 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 01/10] submodule: decouple url and submodule existence
Message-ID: <20170301200230.GA30622@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170223234728.164111-2-bmwill@google.com>
 <xmqq8tov1ev7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tov1ev7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/24, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Currently the submodule.<name>.url config option is used to determine
> > if a given submodule exists and is interesting to the user.  This
> > however doesn't work very well because the URL is a config option for
> > the scope of a repository, whereas the existence of a submodule is an
> > option scoped to the working tree.
> >
> > In a future with worktree support for submodules, there will be multiple
> > working trees, each of which may only need a subset of the submodules
> > checked out.  The URL (which is where the submodule repository can be
> > obtained) should not differ between different working trees.
> >
> > It may also be convenient for users to more easily specify groups of
> > submodules they are interested in as apposed to running "git submodule
> > init <path>" on each submodule they want checked out in their working
> > tree.
> >
> > To this end, the config option submodule.active is introduced which
> > holds a pathspec that specifies which submodules should exist in the
> > working tree.
> 
> Hmph.  submodule.active in .git/config would be shared the same way
> submodule.<name>.url in .git/config is shared across the worktrees
> that stems from the same primary repository, no?
> 
> Perhaps there are some other uses of this submodule.active idea, but
> I do not see how it is relevant to solving "multiple worktrees"
> issue.  Per-worktree config would solve it with the current
> submodule.<name>.url without submodule.active list, I would think [*1*].

Correct, I should update the language to indicate this allows the URL to
be shared between worktrees, but a per-worktree config must exist before
submodule.active can actually be used to select different groups of
submodules per-worktree.  The idea is that if submodule.active is set
then you no longer look at the URLs to see what is interesting but
rather at the paths.

> Also as a grouping measure, submodule.active that lists submodule
> paths feels hard to use.  When switching between two branches in the
> superproject that have the same submodule bound at two different
> paths, who is responsible for updating submodule.active in
> superproject's config?  If it were a list of submodule names, this
> objection does not apply, though.

I agree that if you are listing every submodule path by hand then this
may not be the best approach and would be difficult to use.  The idea is
that this would allow a user to set a general pathspec to identify a
group of modules they are interested in.  Perhaps once attributes can be
used in pathspecs a user could group submodules by setting a particular
attribute and then submodule.active would have a value like
":(attr:foo)" to indicate I'm interested in all submodules with the
"foo" attribute.

> 
> 
> 
> [Footnote]
> 
> *1* At the conceptual level, I agree that .url that also means "we
>     are interested in this one" feels like somewhat an unclean
>     design, but that is not what you are "fixing", is it?
> 

-- 
Brandon Williams
