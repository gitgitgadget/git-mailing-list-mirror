Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B40C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 22:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhLNW1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 17:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhLNW1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 17:27:35 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D8FC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 14:27:34 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i12so19011555pfd.6
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 14:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xIcMl/Bwf8I392ar6il2/dhGenXplzM4JDgnTjIPFVc=;
        b=kVjxjL8k9nTGAl2zqg2/IxXUfxIFNvg3XodtNneR6VWiyltzsFZdOG1w697OmpsHbi
         z0SpJyUg9MAUIaDRda6EJjgZQVe+FXZ57rA28EEAt7QvMPvdLZRH04ZcGNOjc0XiuDDb
         L+MFbPSZrdoKGSRnvV6sbLu2GfBjprQCS02oxZkt278xsRWnzuaMaTZvw5oT3oxFMtWW
         Wbd/UqmMlfdW0JVnmo1YmpgYPjjTDLNmFUtSu3CJOABpxL0D4kLryTIv4OsgUoKtnPhi
         lJb8F+A+Rz/CSJ+ODXzA7GykHuqsIEEpErISx25A4zCsU76O+3GWq/Ti9MjQsuHFHsDV
         dCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=xIcMl/Bwf8I392ar6il2/dhGenXplzM4JDgnTjIPFVc=;
        b=Nhowcot3y0WLJb8dAgJ9BKtyunqX+rip7sBPLZKf4MN1rtjwfHR+3YXuVx0W9KJ1M6
         XBtDx9l8EkK8KsTMiQLBeKD6K2oZ0iuqYhz5vpsX+XWWlHYaHPnSxOSfl6IWJpz6WpcC
         Ixgvu7md24N+h/Ys4taruB+kC2JfXzGmFgxqf2tRHeWwrjl8Hlmdby1KMZHG+taevcNC
         EDUF2DsHw+2GOruwt6sDv1/bV/uvgf8giSSY7EA7xwl7m/q4whgOM571GSt4kNpKSbc1
         PG2wCQa08c/neA9+L8JGjMv4g1vmRqOETURs4aiUgvN2gQdlh2j/L/aqhqADxfDo+JEQ
         kllA==
X-Gm-Message-State: AOAM533yFzUhJN1jDqOzOwdcVqlW2A9CI4y2FMDdhjSgpWg4ltOLd4hj
        sEOicmLy2zsnv2Ajf6owMo3Xuw==
X-Google-Smtp-Source: ABdhPJzDnErAb7T6w9muY+efqFHNjXYjpQwZIxbLInTv1pXCG5WlVnGh8TsxhngX+ofHLor7hJHsCw==
X-Received: by 2002:a63:81c8:: with SMTP id t191mr5528755pgd.598.1639520853947;
        Tue, 14 Dec 2021 14:27:33 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b37:fbed:ef52:5dca])
        by smtp.gmail.com with ESMTPSA id m15sm49695pgd.44.2021.12.14.14.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:27:33 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:27:27 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, chooglen@google.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v5 2/2] branch: add flags and config to inherit tracking
Message-ID: <YbkaT2Aexerzc6sD@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, chooglen@google.com,
        emilyshaffer@google.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <c7e4af9a365cc61e682c3c73045fb1ee4b79cfbf.1638859949.git.steadmon@google.com>
 <211207.86ilw0pydg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211207.86ilw0pydg.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.07 10:08, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 06 2021, Josh Steadmon wrote:
> 
> > It can be helpful when creating a new branch to use the existing
> > tracking configuration from the branch point. However, there is
> > currently not a method to automatically do so.
> >
> > Teach git-{branch,checkout,switch} an "inherit" argument to the
> > "--track" option. When this is set, creating a new branch will cause the
> > tracking configuration to default to the configuration of the branch
> > point, if set.
> >
> > For example, if branch "main" tracks "origin/main", and we run
> > `git checkout --track=inherit -b feature main`, then branch "feature"
> > will track "origin/main". Thus, `git status` will show us how far
> > ahead/behind we are from origin, and `git pull` will pull from origin.
> >
> > This is particularly useful when creating branches across many
> > submodules, such as with `git submodule foreach ...` (or if running with
> > a patch such as [1], which we use at $job), as it avoids having to
> > manually set tracking info for each submodule.
> >
> > Since we've added an argument to "--track", also add "--track=direct" as
> > another way to explicitly get the original "--track" behavior ("--track"
> > without an argument still works as well).
> > @@ -10,7 +10,8 @@ enum branch_track {
> >  	BRANCH_TRACK_REMOTE,
> >  	BRANCH_TRACK_ALWAYS,
> >  	BRANCH_TRACK_EXPLICIT,
> > -	BRANCH_TRACK_OVERRIDE
> > +	BRANCH_TRACK_OVERRIDE,
> > +	BRANCH_TRACK_INHERIT
> >  };
> 
> So we've got 5 items in this enum...
> 
> >  
> >  extern enum branch_track git_branch_track;
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > index b23b1d1752..ebde5023c3 100644
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -632,8 +632,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
> >  		OPT__VERBOSE(&filter.verbose,
> >  			N_("show hash and subject, give twice for upstream branch")),
> >  		OPT__QUIET(&quiet, N_("suppress informational messages")),
> > -		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
> > -			BRANCH_TRACK_EXPLICIT),
> > +		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
> > +			N_("set branch tracking configuration"),
> > +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
> > +			parse_opt_tracking_mode),
> >  		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
> >  			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
> 
> But map --track, --track=direct --track=inherit to 3/5 of them. Will it
> ever make sense to do the oher 2/5 (I really haven't checked)....
> 
> >  		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index b5d477919a..45dab414ea 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -1532,8 +1532,10 @@ static struct option *add_common_switch_branch_options(
> >  {
> >  	struct option options[] = {
> >  		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
> > -		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
> > -			BRANCH_TRACK_EXPLICIT),
> > +		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",
> > +			N_("set up tracking mode (see git-pull(1))"),
> > +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
> > +			parse_opt_tracking_mode),
> >  		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
> >  			   PARSE_OPT_NOCOMPLETE),
> >  		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
> 
> I wonder if this interface wouldn't be a lot simpler as:
> 
>     --track
>     --track-explicit --track-direct --track-inherit
> 
> Both because it'll work better for auto-complete, and we can (and
> presumably some will want) just make --track mean whatever configured
> --track-THING you want.

If I understand you correctly, I disagree here. I think you're saying
that if you always (or usually) want a specific tracking mode, you have
to both set the config appropriately and remember to pass `--track` on
the command line? Seems simpler to just let the config take precedence
in the absence of a flag. But I think I may have misunderstood you.

> in any case, isn't there a NONEG missing here, or is --no-track-direct
> etc. handled by OPT_CALLBACK_F() (I forget...).

Yeah, --no-track is correctly handled. It sets BRANCH_TRACK_NEVER, so
that you can override a branch.autosetupmerge=always config if
necessary.


> >  	if (!strcmp(var, "branch.autosetupmerge")) {
> > -		if (value && !strcasecmp(value, "always")) {
> > +		if (value && !strcmp(value, "always")) {
> 
> ...This probably makes sense, but it seems like the behavior change of
> "let's not take this case-insensitive" should be split up into its own
> change...

Done in V6.


> > +	test_must_fail git rev-parse --verify HEAD^ &&
> > +	git checkout main &&
> > +	git config branch.autosetupmerge inherit &&
> > +	git checkout --orphan eta &&
> > +	test -z "$(git config branch.eta.merge)" &&
> > +	test -z "$(git config branch.eta.remote)" &&
> 
> Better with the test_must_be_empty etc. helpers.
> 
> > +	test refs/heads/eta = "$(git symbolic-ref HEAD)" &&
> 
> and this with test_cmp.
> 
> (ditto occurances below)
