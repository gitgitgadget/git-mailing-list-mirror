Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89F620387
	for <e@80x24.org>; Tue, 18 Jul 2017 20:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbdGRUGF (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 16:06:05 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34813 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbdGRUGE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 16:06:04 -0400
Received: by mail-pf0-f177.google.com with SMTP id q85so16349385pfq.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LWs1aGUeVcaU8UyzgY1YqEyiYwIpQggk3HPN6OYY9/0=;
        b=IWvcVX4P/8iPY6DsRHvKO3Eq+vWAhQbGlkbSbBBUzwQrwRriIRe08uRZB5L2xYw9cC
         D1wd+gbxO0wNd0ZEys5yj4eF6/oF7ZQ7B4BRbamY9BLoiWjWu7sHissQDaefooqC1UAw
         jYA7L8mjXQSsLALrYPfaTWVKEhHRfWHwdlmyljUotygWCrxqqajU+mhNHxnnb3NXo928
         if1pFrs2CCMkrKlGv6Xiz2hSnAxQ0/w1c7xmziAgOndVr8fK0la3iZVlryRExmPkQl38
         cCy881L+Q6H4GNGIsmQ9zd6r5ZtKRnET+83wL2zOggH6WDjAoKey0OV4atisWFHs/4Ai
         T+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LWs1aGUeVcaU8UyzgY1YqEyiYwIpQggk3HPN6OYY9/0=;
        b=OKEw8bLeBT22l0rW4G12y2q44FKt+fl+yABfSkSagDFVHgZn7mZ/7BTCVJ5syZf2SU
         0S3w/T/tCyiEnTQeIzFVlQp65RfFYCIFWOXaDB9il5VAUI0w1ZFDA3cJgae8sdYGbw30
         q/cMniRW3OCxCchrMrFyARZgTySmM/0IksXloe8xpnydzjBwS4Vuk275kpbSj6w79/iX
         FhKiLRcpDZvDTGsoHOTuAHp/cw/AppscuYaUslosKUf/ak15gA1lx6IIWdXTdJBi5DKL
         w+g9AnlBuTGL64pTTufY+8YEOeI7JgzpRzgiU5rePJ1ygnN13RW0YzzwJy8ZCfqI96Rc
         4hXw==
X-Gm-Message-State: AIVw110t3Tfccbd9gLugC+48kgGuo0caA48hHpETD2wyQ9uWEZVBVAHs
        UyFBZG/Gayyi+Tta
X-Received: by 10.99.101.132 with SMTP id z126mr3456949pgb.64.1500408364187;
        Tue, 18 Jul 2017 13:06:04 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dcfd:2921:5eb0:198b])
        by smtp.gmail.com with ESMTPSA id 73sm7732475pfp.103.2017.07.18.13.06.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 13:06:03 -0700 (PDT)
Date:   Tue, 18 Jul 2017 13:06:01 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 00/10] Convert grep to recurse in-process
Message-ID: <20170718200601.GB22656@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
 <20170718190527.78049-1-bmwill@google.com>
 <xmqqo9sho7v5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9sho7v5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/18, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Changes in v3:
> >  * Fixes a bug with repo_read_gitmodules() where it was possible to
> >    segfault when a repository didn't have a worktree.  
> >  * In order to fix the above bug repo_read_gitmodules() and gitmodules_config()
> >    were merged so that there won't be any duplicate logic.  In order to merge
> >    these functions the parsing of submodule.fetchjobs and
> >    fetch.recursesubmodules were removed from the submodule-config parsing logic
> >    and instead moved into fetch and update-clone.  This also makes it easier to
> >    ensure that no additonal non-submodule specific configuration like this will
> >    be added to .gitmodules in the future.
> 
> Sounds good.  
> 
> Has this been rebased and if so on top of what?  It seems that I am
> getting "am -3" conflicts at around 05/10---I think I can cope with,
> but it is one unnecessary source of potential bugs, so...

Oh sorry I also forgot to mention that I rebased it on top of current
master.  The changes to remove the fetch.recursesubmodules and
submdoule.fetchjobs from the config parsing had some weird conflicts
with a series from Stefan that recently hit master.

> 
> > Brandon Williams (10):
> >   repo_read_index: don't discard the index
> >   repository: have the_repository use the_index
> >   cache.h: add GITMODULES_FILE macro
> >   config: add config_from_gitmodules
> >   submodule: remove submodule.fetchjobs from submodule-config parsing
> >   submodule: remove fetch.recursesubmodules from submodule-config
> >     parsing
> >   submodule: check for unstaged .gitmodules outside of config parsing
> >   submodule: check for unmerged .gitmodules outside of config parsing
> >   submodule: merge repo_read_gitmodules and gitmodules_config
> >   grep: recurse in-process using 'struct repository'
> >
> >  Documentation/git-grep.txt  |   7 -
> >  builtin/fetch.c             |  26 ++-
> >  builtin/grep.c              | 396 ++++++++++----------------------------------
> >  builtin/mv.c                |   2 +-
> >  builtin/rm.c                |   2 +-
> >  builtin/submodule--helper.c |  17 +-
> >  cache.h                     |   2 +-
> >  config.c                    |  17 ++
> >  config.h                    |  10 ++
> >  git.c                       |   2 +-
> >  grep.c                      |  13 --
> >  grep.h                      |   1 -
> >  repository.c                |   6 +-
> >  repository.h                |   8 +
> >  setup.c                     |  12 +-
> >  submodule-config.c          |   8 +
> >  submodule-config.h          |   1 +
> >  submodule.c                 | 147 +++++++---------
> >  submodule.h                 |   6 +-
> >  19 files changed, 240 insertions(+), 443 deletions(-)

-- 
Brandon Williams
