Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272AF201A9
	for <e@80x24.org>; Sun, 19 Feb 2017 09:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdBSJQh (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 04:16:37 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35956 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbdBSJQh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 04:16:37 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so9316263wmd.3
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 01:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eFbmrvdOxrSwbiv4Yt/872VPWZyAWHFgZ3z20lsXtJ8=;
        b=WlPsfEdbk5U1ssEYA9EmTjjJ3cVQ9j0wFvMSKjHoN0Gkj0+DcSPEoK5gyXHsEUgocA
         dd16PiiowPdAKgYbalmKI5Eujysc3qVLbbSk/sMd3bpuezFLxxjxWM7x3EpQfwmRkx+/
         UZ/F0rYRXJKsZ0gpW981MhvPHXqdw87pOC10bQvfzUaIArampf5N73v5ce/l8KhH/w/c
         /DB542GwUOO/AGI7XbQIj7Qw0IDQJxF+XeMnDFO1lwaZEUSJ66b5IlUVz/H3bumboAkR
         Ybhl0jgD1Mau4txc/1mnKBMw9P+TTi/Oa8PcYZbuCPFj6nlr7lmsB1etLO9jtkVgQWLW
         nupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eFbmrvdOxrSwbiv4Yt/872VPWZyAWHFgZ3z20lsXtJ8=;
        b=dnEMP6KC6BwgNANTF05n3emYr5Fgg8uKFHKxnkXEg4lMXIbQafU6J+xenUIphac+We
         bruxua7Hpen/u/cvxs//dBRb1amQ2NgG5oWGYZ+t8Wy56DLlxDLIUCmSJ6hHj+SukfvP
         m5Sg1FsGs7geKnHMecj/pBiuyJ/KIGfwywzxufNCuiFy6GtkBY76/1iM31UXI+V5+ZOJ
         LVwjxL6TQxyVh1gN5uxG/HJh5b/OKaeRMK6yX0YFzg6KDJnyZlnWwVvGamsk4gXwdY/0
         uogRfCOD/IXTrMjJawcoYtHZ2lbVAUYNbmP4Pq1xV8kGUwT+2gq6pmD5vIwDyC/647Fe
         f42w==
X-Gm-Message-State: AMke39nWtzmCR9u65TvvsazRJhyxzNLvr95uiSMwbhTS4Rrgnq9/laO5QwM4F+o6MnDWTw==
X-Received: by 10.28.157.70 with SMTP id g67mr12502623wme.111.1487495795285;
        Sun, 19 Feb 2017 01:16:35 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id i29sm20061815wrc.25.2017.02.19.01.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Feb 2017 01:16:34 -0800 (PST)
Date:   Sun, 19 Feb 2017 09:17:14 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 3/6] stash: refactor stash_create
Message-ID: <20170219091714.GJ652@hank>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170217224141.19183-4-t.gummerer@gmail.com>
 <20170217234805.glvhyfbxab6nwgb7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217234805.glvhyfbxab6nwgb7@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/17, Jeff King wrote:
> On Fri, Feb 17, 2017 at 10:41:38PM +0000, Thomas Gummerer wrote:
> 
> > Refactor the internal stash_create function to use a -m flag for
> > specifying the message and -u flag to indicate whether untracked files
> > should be added to the stash.
> > 
> > This makes it easier to pass a pathspec argument to stash_create in the
> > next patch.
> > 
> > The user interface for git stash create stays the same.
> 
> Sounds good, but...
> 
> > diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> > index 2e9cef06e6..d93c47446a 100644
> > --- a/Documentation/git-stash.txt
> > +++ b/Documentation/git-stash.txt
> > @@ -17,6 +17,7 @@ SYNOPSIS
> >  	     [-u|--include-untracked] [-a|--all] [<message>]]
> >  'git stash' clear
> >  'git stash' create [<message>]
> > +'git stash' create [-m <message>] [-u|--include-untracked <untracked|all>]
> >  'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
> 
> Should this hunk be dropped from the manpage, then?
> 
> I think there is a similar one in the next patch that adds the
> "pathspec" argument, and should be dropped, too.

Argh yes I should have been more careful.  Thanks for catching.

> -Peff
