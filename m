Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05AAC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 05:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhLQFLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 00:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhLQFLT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 00:11:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8026C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:11:19 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p18so853091pld.13
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pzm9Q2p4GtW/Di+/7TQ+CJToYLjHgpFD8XvdtdJetnU=;
        b=Y0t62LSaz4kfb++KOLqlszZGB1AUEMbkRk/EfLJt0FcPbFZNxhpld8LebBZU++4Pqv
         EvYYxwBe+tTiQpxng36nL0WfDvtQGbYqDjdgZ+XRtPVjgzEc7pfVUOxuDTCxX4aV8hF7
         nd1OtG/dRglJdYVXlYWAPBEqXrGrLMV1IzYDgK68A6kHcKEEupWDjccxWqqAXu5BiQP4
         ZrvoFon1wm1Lki8LPc4nl1rUC0KSGz0+SrwelxihNZBNknJI59w7PNVjwMEJy/W/a8Bq
         C5S+roufCdqTsSuSfrHkoVCmXuSzsVwCTVxT96w/GsL95TeBf/h9nVF2mMzqYM+8DF5K
         vBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Pzm9Q2p4GtW/Di+/7TQ+CJToYLjHgpFD8XvdtdJetnU=;
        b=YT2T2aQAFVEhf4EYNCee4+ZUFjm7pYWU2X7HcRpjlh7E9X3FpKZs9w1sxzTPuuYelu
         3bEWnXzUqjlQxRVx9rrVwDEUSshE28sa48JRyPOWI0vADx68eEb/o5+X51ylZqB7DAo4
         ce+QvbzCGTtmY8R/xDbjyWy2nGo4n/lv0IiGBYcxb43Sx4725ZOZHirwAQj/VEg3WTKh
         qsBNZKQHeMmQ0YxdVhD7LEVANMOLxOt6ruzr2PxEIziBRlG/C8oiMTW75J5rxAgg46ec
         5ZmTM1D9j0OLurjPO8D2iO/WrTmMZKnrjLArcmBgh1ZpIIy2WnH2yvYXTvAi7W24U492
         Z0Zw==
X-Gm-Message-State: AOAM532ucpF5WRDgM20ylO6+0z4ktxmDFibSPJsPgBtSYfTaUHvvAtlf
        SUcPiv05qLZFjzbqGWyELB7ZAw==
X-Google-Smtp-Source: ABdhPJyquBjVVHCBciZLhaZXED02fjCUTXT4io/UiYbqpdgy5dU+obddOJqBq/hdsTMM+/htoakZuA==
X-Received: by 2002:a17:90a:909:: with SMTP id n9mr1859109pjn.1.1639717878967;
        Thu, 16 Dec 2021 21:11:18 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a37:b5e2:96be:e5d5])
        by smtp.gmail.com with ESMTPSA id mv1sm1273325pjb.23.2021.12.16.21.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 21:11:18 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:11:12 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 2/3] branch: add flags and config to inherit tracking
Message-ID: <Ybwb8O2iLERz4Bmu@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639524556.git.steadmon@google.com>
 <57e57e6e6a0735341a86f7b5dc52d477d8789578.1639524556.git.steadmon@google.com>
 <kl6llf0k8ckj.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6llf0k8ckj.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.16 13:27, Glen Choo wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > @@ -192,11 +220,15 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
> >  			   enum branch_track track, int quiet)
> >  {
> >  	struct tracking tracking;
> > +	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
> >  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> >  
> >  	memset(&tracking, 0, sizeof(tracking));
> >  	tracking.spec.dst = (char *)orig_ref;
> > -	if (for_each_remote(find_tracked_branch, &tracking))
> > +	tracking.srcs = &tracking_srcs;
> > +	if (track != BRANCH_TRACK_INHERIT)
> > +		for_each_remote(find_tracked_branch, &tracking);
> > +	else if (inherit_tracking(&tracking, orig_ref))
> >  		return;
> >  
> >  	if (!tracking.matches)
> > @@ -204,6 +236,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
> >  		case BRANCH_TRACK_ALWAYS:
> >  		case BRANCH_TRACK_EXPLICIT:
> >  		case BRANCH_TRACK_OVERRIDE:
> > +		case BRANCH_TRACK_INHERIT:
> >  			break;
> >  		default:
> >  			return;
> > @@ -213,11 +246,13 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
> >  		die(_("Not tracking: ambiguous information for ref %s"),
> >  		    orig_ref);
> >  
> > -	if (install_branch_config(config_flags, new_ref, tracking.remote,
> > -			      tracking.src ? tracking.src : orig_ref) < 0)
> > +	if (tracking.srcs->nr < 1 && track != BRANCH_TRACK_INHERIT)
> > +		string_list_append(tracking.srcs, orig_ref);
> 
> So, in the BRANCH_TRACK_{ALWAYS,EXPLICIT,OVERRIDE} cases, we append
> orig_ref because we expect orig_ref to be a local ref that the caller
> wants to track. This is not the case with BRANCH_TRACK_INHERIT, where we
> want to inherit the configuration and we no longer care about orig_ref.
> 
> This is correct, though it's more unobvious than what I originally
> envisioned when I commented on [1]. As a small nit, it might benefit
> from a clarifying comment, but this is fine as it is :)

Actually, you're right, the `track != BRANCH_TRACK_INHERIT` condition is
superfluous. The only way we could have BRANCH_TRACK_INHERIT and
tracking.srcs->nr < 1 at the same time would be if there were no
"branch.*.merge" entries in the config to inherit, but if that were true
then we would have had returned from this function earlier.

> > diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
> > index 4453741b96..49c7def21c 100755
> > --- a/t/t2027-checkout-track.sh
> > +++ b/t/t2027-checkout-track.sh
> > @@ -24,4 +24,27 @@ test_expect_success 'checkout --track -b rejects an extra path argument' '
> >  	test_i18ngrep "cannot be used with updating paths" err
> >  '
> >  
> > +test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
> > +	# Set up tracking config on main
> > +	test_config branch.main.remote origin &&
> > +	test_config branch.main.merge refs/heads/main &&
> > +	test_config branch.autoSetupMerge inherit &&
> > +	# With --track=inherit, we copy the tracking config from main
> > +	git checkout --track=inherit -b b1 main &&
> > +	test_cmp_config origin branch.b1.remote &&
> > +	test_cmp_config refs/heads/main branch.b1.merge &&
> > +	# With branch.autoSetupMerge=inherit, we do the same
> > +	git checkout -b b2 main &&
> > +	test_cmp_config origin branch.b2.remote &&
> > +	test_cmp_config refs/heads/main branch.b2.merge &&
> > +	# But --track overrides this
> > +	git checkout --track -b b3 main &&
> > +	test_cmp_config . branch.b3.remote &&
> > +	test_cmp_config refs/heads/main branch.b3.merge &&
> > +	# And --track=direct does as well
> > +	git checkout --track=direct -b b4 main &&
> > +	test_cmp_config . branch.b4.remote &&
> > +	test_cmp_config refs/heads/main branch.b4.merge
> 
> Nit: in both cases, the expected result is that branch.b*.merge is
> "refs/heads/main". so the difference between --track=direct and
> --track=inherit would be more obvious if main tracked something other
> than origin/main.

Fixed in V7.


> As an side, the comments in the tests make it really readable :)
> 
> Overall this patch looks good.
> 
> [1] https://lore.kernel.org/git/kl6lfsr3c3j7.fsf@chooglen-macbookpro.roam.corp.google.com
