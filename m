Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AEF01F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeHKARm (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:17:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36995 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeHKARm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:17:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so4964533pgq.4
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 14:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+4J5MBdsDSUQsJCYqdGNqMu/O8M/1aj2f1amrOlP48Q=;
        b=uBhhViHqUc4yag18ej1V8wq5LJ7c7QxH9Y3ebmY9N6rByNmqeOVea/apld7u4F5TY8
         b8bS1asFrqp09AMlvTS2rvLyRLfzn1v2z8hIP3fI5u/KzAncnseHLpaG2M5M8rRMTBZz
         mo92Q3IAHN8iFH6BYYyGNF98kQW/iG2sDTIbkIM8i1xPofewD4OfIj0gU0TqSVJ75mou
         Mpoz9jaMrFOLOzl515tSv2p7ou77mLhhawlPYkJw4JJSwxXfscz7dMWKssRpntzfpgJA
         DXp3WBETeTQWPKgbVXJSZSu93X2D/nHSArY2WdsEMS1duCmVlrXjwMVwTVTnuMY4HP0I
         FsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+4J5MBdsDSUQsJCYqdGNqMu/O8M/1aj2f1amrOlP48Q=;
        b=oJ9QMcJD8JHv5dBYYLtFvGuIPDiqEXaHPdTS2ap70bdCDLijjOcZ2A9zz6h4wepKHt
         +4AZ3NYYop+8u6hHiAOT3J3XbK0UhzWGTcykLHowMsFyVpHcSUqfKLfOe1Il7N2ZjcbX
         9c9rMHD/ANbE0C1p+GhkmA6PPa35CAuqMEjrQxYmIgfPj19DQzWM3ISSvucLVo30/eTh
         ib/Di0+U10KuFNPBDvV62RU+4PrkeRBULmeHLpxxyg4XaRNtoyvtSw5Qke5KGwlllcUD
         IGNrhChUlzUKlT+GkYYX2C1ur3tMooB4O2powkSkbHxTt1Sf5j6Od8AHruV5jMuN2Mu4
         ttcQ==
X-Gm-Message-State: AOUpUlHqvBZprY3TwpyKXEAd8GTiRIUh4gFHXtvem0Vu30zoNz6CT6q6
        Xp96MFa595W3GnYCxY1rPGUWcw==
X-Google-Smtp-Source: AA+uWPz64GcMdu2vSvKu/akaKUOge0SmsQyA1C7XFMeEHDzMGAiwQUBewoC3mtXKOJITXQzBeEyO/g==
X-Received: by 2002:a62:c182:: with SMTP id i124-v6mr8626363pfg.248.1533937561726;
        Fri, 10 Aug 2018 14:46:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id l79-v6sm29233048pfb.111.2018.08.10.14.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 14:46:00 -0700 (PDT)
Date:   Fri, 10 Aug 2018 14:45:59 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] submodule: create helper to build paths to submodule
 gitdirs
Message-ID: <20180810214559.GA211322@google.com>
References: <20180807230637.247200-1-bmwill@google.com>
 <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-2-bmwill@google.com>
 <xmqqpnyp7vzv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnyp7vzv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/10, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Introduce a helper function "submodule_name_to_gitdir()" (and the
> > submodule--helper subcommand "gitdir") which constructs a path to a
> > submodule's gitdir, located in the provided repository's "modules"
> > directory.
> >
> > This consolidates the logic needed to build up a path into a
> > repository's "modules" directory, abstracting away the fact that
> > submodule git directories are stored in a repository's common gitdir.
> > This makes it easier to adjust how submodules gitdir are stored in the
> > "modules" directory in a future patch.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> > ...
> > @@ -2018,7 +2039,7 @@ static int connect_gitdir_workingtree(int argc, const char **argv, const char *p
> >  	name = argv[1];
> >  	path = argv[2];
> >  
> > -	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> > +	submodule_name_to_gitdir(&sb, the_repository, name);
> >  	sm_gitdir = absolute_pathdup(sb.buf);
> >  
> >  	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
> 
> This function goes away with 1c866b98 ("submodule--helper: replace
> connect-gitdir-workingtree by ensure-core-worktree", 2018-08-03) in
> sb/submodule-update-in-c topic.  git-submodule.sh has simlar
> conflicts.
> 
> I guess its replacement function does not care as deeply as its
> predecessor used to about where the submodule's $GIT_DIR is, so the
> correct resolution may be just to ignore the change made to this
> caller to the new name-to-gitdir function.

Well that patch still cares about where the gitdir is except it
initializes a "struct repository" for the submodule and then builds a
path to the config using:

    cfg_file = xstrfmt("%s/config", subrepo.gitdir);

hmm...I didn't get a chance to look at that series but that line looks
wrong.  It probably should be more like:

  cfg_file = repo_git_path(&subrepo, "config");

I'll go comment on that series.

> 
> It would have been nicer to see a bit better inter-developer
> coordination, especially between two who sit practically next to
> each other ;-)
> 
> Thanks.

-- 
Brandon Williams
