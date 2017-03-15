Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDC43202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbdCOVhm (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:37:42 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34648 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbdCOVhl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:37:41 -0400
Received: by mail-pg0-f44.google.com with SMTP id 141so14826413pgd.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zQzEUV4bDR/B6Q0yK0btg3+o5zOsKmJSqG+iwnybPq0=;
        b=bMgRajBGLMDHrf07qsQ67/QrpkRrkjuRbZ0VI8Qq1X+ngxxHA5zjfA/vDMBeZOqFbG
         Ff1ihA4iIuO7KADdE7wFyQawkNOeL8IEe4D4919FsgQ8qNZVlPERaYqCLar6QlQryOsL
         s+zDhf0rBp6kSoFsrV+Gc6btbx4DoHf/Qku1kjvXuYC8IBDGd+Nej2kqoFYKK5ixmb/6
         dJvhL1gQHh69Wx6Uu5gKI1Ye0iiA5QVBwG9rJll0tfW1+mbKQCezSJrIVpMMAPWXQSz9
         gveEooFvruMeerND53yKAZlGq5PV6FQLfbFN1ybZYOWCKLKjLt/uWtWhzi5bRx9mrpmb
         MfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zQzEUV4bDR/B6Q0yK0btg3+o5zOsKmJSqG+iwnybPq0=;
        b=eq10udfpUtWJVxFuD8OYoTXeh5rT04csr4+p3o8Xuk+JuqZ9rqQgd69EM9YAHQZb8d
         bZkUsAyzoyZlFflCDy5iUec3Pk2V0jfc/zWLPcf/GJO8XAEzCsFytBXJo7WdIMfu65y4
         Pj9+qVxCB83EOjIZNGsVii76EtZlVUSmYUvCaVxGCAlXrKpMgjEjBfNf7E3xnYDijwU7
         vg9vsLp7oWYikTHUwGV8H0MbjJfrOcEnXc1Z71DL+ZvPV4cMBFs/sfrgCvTHTU3Sb5ua
         j8fmKgZRZXy5Do4JKwTMhdqxMUNXG6XhIUv+0jM9IGWZPrf2knIwjuOOfocouh7Aye42
         aSUg==
X-Gm-Message-State: AFeK/H39UVTkGz0W3zODFlLoy1/WcMaUg+d137Sv8o7vmu5cjsmeoZXHzald7LJMOIJRpSxS
X-Received: by 10.99.122.78 with SMTP id j14mr251683pgn.52.1489613859867;
        Wed, 15 Mar 2017 14:37:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:e5fd:c660:1f84:47a3])
        by smtp.gmail.com with ESMTPSA id x15sm6120988pgc.16.2017.03.15.14.37.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 14:37:38 -0700 (PDT)
Date:   Wed, 15 Mar 2017 14:37:37 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 05/10] submodule: decouple url and submodule existence
Message-ID: <20170315213737.GC159137@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-6-bmwill@google.com>
 <xmqqzignittf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzignittf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Currently the submodule.<name>.url config option is used to determine
> > if a given submodule exists and is interesting to the user.  This
> > however doesn't work very well because the URL is a config option for
> > the scope of a repository, whereas the existence of a submodule is an
> > option scoped to the working tree.
> 
> A submodule exists if it is exists, whether the user is interested
> in it or not.  If it should be checked out in the working tree is a
> different matter, but that should be a logical AND between "is it of
> interest?" and "is the superproject tree has a gitlink for it in its
> working tree?".  
> 
> So I do not agree with "This however doesn't work" at all.  I'd
> understand it if you said "This is cumbersome if we want to do this
> and that, which are different from what we have done traditionally"
> and explain what this and that are and how they are different.
> 
> > In a future with worktree support for submodules, there will be multiple
> > working trees, each of which may only need a subset of the submodules
> > checked out.  The URL (which is where the submodule repository can be
> > obtained) should not differ between different working trees.
> 
> And this makes the motivation a bit clearer.  When the user wants to
> have multiple worktrees for the same superproject.  In such a
> setting, the same submodule in two worktrees typically want to have
> the same URL.  It may be different from what the upstream suggests
> in the .gitmodules file, but the difference, i.e. the site specific
> customization of the URL, should be the same between the two
> worktrees.  But one worktree may be and the other worktree may not be
> interested in that submodule, and with shared .git/config file, you
> cannot have submodule.<name>.url set to one value and unset at the
> same time.
> 
> This series does not solve the "two worktrees cannot have private
> parts in the configuration namespace" issue, but assuming it will be
> solved by some other series, it anticipates that submodule.<name>.URL 
> would want to be shared between two worktrees most of time (note that
> there will be users who want two separate .URL for the same submodule
> while sharing the object database via worktrees mechanism, and you'll
> need to prepare for them, too), and another "bit" that tells if the
> submodule is of interest would want to be private to each worktree.
> 
> That is the motivation, the reason why you want .URL to stop serving
> the dual purpose of overriding upstream-suggested URL and indicating
> the submodule is interesting to the user.
> 
> > It may also be convenient for users to more easily specify groups of
> > submodules they are interested in as apposed to running "git submodule
> > init <path>" on each submodule they want checked out in their working
> > tree.
> >
> > To this end two config options are introduced, submodule.active and
> > submodule.<name>.active.  The submodule.active config holds a pathspec
> > that specifies which submodules should exist in the working tree.  The
> > submodule.<name>.active config is a boolean flag used to indicate if
> > that particular submodule should exist in the working tree.
> 
> And because two worktrees always share their .git/config, these new
> configuration variables are useless to help workflow with multiple
> worktrees with the current system, until "per-worktree configuration"
> is invented.  But we prepare for that future in this step.
> 
> Also submodule.active that takes pathspec and not name is an oddball
> (use of "name" not "path" is to prepare for a submodule whose
> location in the superproject changes depending on the commit in the
> superproject), and we need to justify with an explanation.  I think
> you envision two cases.  1. we encourage projects to adopt a
> convention that submodules are grouped with leading directory, so
> that pathspec e.g. lib/, would cover _all_ library-ish modules to
> allow those who are interested in library-ish modules to set
> ".active = lib/" just once to say any and all modules in lib/ are
> interesting.  2. another convention the projects can adopt, when
> pathspec-attribute feature is invented, is to label submodules with
> attribute to group them, so that a broad pathspec with attribute
> requirement, e.g. .:(attr:lib), can be used to say any and all
> modules with 'lib' attribute are interesting.
> 
> The above two points (justifications, intended uses and future
> plans) need to be clarified around here (and possibly in the
> documentation), I would think.

I'll overhaul this to better explain the intentions behind the change.
Thanks for pointing out what needs a more detailed explanation.

> 
> > diff --git a/submodule.c b/submodule.c
> > index 0a2831d84..2b33bd70f 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -217,13 +217,41 @@ void gitmodules_config_sha1(const unsigned char *commit_sha1)
> >  int is_submodule_initialized(const char *path)
> >  {
> >  	int ret = 0;
> > -	const struct submodule *module = NULL;
> > +	char *key;
> > +	const struct string_list *sl;
> > +	const struct submodule *module = submodule_from_path(null_sha1, path);
> >  
> > -	module = submodule_from_path(null_sha1, path);
> > +	/* early return if there isn't a path->module mapping */
> > +	if (!module)
> > +		return 0;
> > +
> > +	/* submodule.<name>.active is set */
> > +	key = xstrfmt("submodule.%s.active", module->name);
> > +	if (!git_config_get_bool(key, &ret)) {
> > +		free(key);
> > +		return ret;
> > +	}
> > +	free(key);
> > +
> > +	sl = git_config_get_value_multi("submodule.active");
> >  
> > -	if (module) {
> > -		char *key = xstrfmt("submodule.%s.url", module->name);
> > +	if (sl) {
> > +		struct pathspec ps;
> > +		struct argv_array args = ARGV_ARRAY_INIT;
> > +		const struct string_list_item *item;
> > +
> > +		for_each_string_list_item(item, sl) {
> > +			argv_array_push(&args, item->string);
> > +		}
> > +
> > +		parse_pathspec(&ps, 0, 0, 0, args.argv);
> > +		ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
> > +
> > +		argv_array_clear(&args);
> > +		clear_pathspec(&ps);
> > +	} else {
> >  		char *value = NULL;
> > +		key = xstrfmt("submodule.%s.url", module->name);
> >  
> >  		ret = !git_config_get_string(key, &value);
> 
> It probably is easier to read if you had a final "return ret" in the
> "if (sl) {...}" part, just like you have one for the codepath that
> deals with "submodule.<name>.active", and flatten the else clause.
> That would make it clear that we have three ways with decreasing
> precedence.

Sounds like a good change.  I'm all for making the code more readable.

> 
> At this point, the answer from function is even less about "is it
> initialized?"  but about "is it of interest?" (or "is it to be
> initialized?").  We'd probably want a /* NEEDSWORK */ comment before
> the function to remind us to come up with a better name after the
> dust settles.

Yeah I expect we should rename it to 'is_submodule_active' at some
point, or something along those lines.

> 
> > diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
> > index f18e0c925..c41b899ab 100755
> > --- a/t/t7413-submodule-is-active.sh
> > +++ b/t/t7413-submodule-is-active.sh
> > @@ -28,4 +28,59 @@ test_expect_success 'is-active works with urls' '
> >  	git -C super submodule--helper is-active sub1
> >  '
> >  
> > +test_expect_success 'is-active works with submodule.<name>.active config' '
> > +	git -C super config --bool submodule.sub1.active "false" &&
> > +	test_must_fail git -C super submodule--helper is-active sub1 &&
> > +
> > +	git -C super config --bool submodule.sub1.active "true" &&
> > +	git -C super config --unset submodule.sub1.URL &&
> > +	git -C super submodule--helper is-active sub1 &&
> > +
> > +	git -C super config submodule.sub1.URL ../sub &&
> > +	git -C super config --unset submodule.sub1.active
> > +'
> 
> The last "unset" is done to clean the customization this test did,
> in order to give a predictable beginning state to the next test?  If
> so, use test_when_finished instead of &&-cascading it at the end.

Will do.

> 
> > + ...
> > +test_expect_success 'is-active with submodule.active and submodule.<name>.active' '
> > +	git -C super config --add submodule.active "sub1" &&
> > +	git -C super config --bool submodule.sub1.active "false" &&
> > +	git -C super config --bool submodule.sub2.active "true" &&
> > +
> > +	test_must_fail git -C super submodule--helper is-active sub1 &&
> > +	git -C super submodule--helper is-active sub2 &&
> > +
> > +	git -C super config --unset-all submodule.active &&
> > +	git -C super config --unset submodule.sub1.active &&
> > +	git -C super config --unset submodule.sub2.active
> > +'
> 
> Likewise for all the new tests in this patch.
> 
> Thanks.

-- 
Brandon Williams
