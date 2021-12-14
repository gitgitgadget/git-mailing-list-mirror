Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A34C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 22:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhLNWKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 17:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhLNWKv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 17:10:51 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C5C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 14:10:51 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id r130so19027831pfc.1
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 14:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=2+R7RDmXzOdHKX5Zq8W83gUldZUR6sqLdUaRnhWaf5I=;
        b=ST38u4nxVKHFBT+zUALHP7bWZAldWmJIRGVxLmmeRV3B2nm5nq5VCUAJuR8CkM847v
         uEoyfKUBipsfpCipmwIJjXhGZgi/OZlsMYib5aTgfUi/QHjF2yy8mX1d5y6r2TmAYtZB
         iMa1lA8VnPBnzpREns/ZC4HbLwqSXHH0QpTRlK8YNxN5cQnTTuc5hiiQHLgE9Fkd45MO
         GPqz960o3b53ElhBq48EOW51+hmRdcjwEz0Ys2EMjkTs6fP4RCtPQgJgEVwhUNHtR9uK
         Gg8+QEGgUO1OYXDAMVRbNuDjyDGwjPZVhA8VEEyHeEZ6M2trXJvJV/E1o5hPsnePheyc
         FQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2+R7RDmXzOdHKX5Zq8W83gUldZUR6sqLdUaRnhWaf5I=;
        b=HzLUnwQEza/0rxSwWI2yLyx08wAdOelO4UHYIMhAlD/LpVO1o6V7nZyDWzvaUGtBKc
         5Q0I1AQuydMtyevNlFtR554t0TM7JZgSMxUa6IZ+IKt41C4c+VJoMeoIcV21Crz9fNY5
         TMcb5d41FNgM1SsKtJLxdhbukRNdNCG+9237fvTfbx9KcOXjWmT4zFuIMEFnjzxuqXY4
         A67RXeYF7ehLsx2dRWoIRcCIhZYuLAJL323+PTVOnIDp82y+ryn3imqIc1kwRpQbIGEV
         JV413RFkjnAhNvDjzUIXVCv3RDT4Jr3t50ZA55Yw/EfdIkKI0SNERDebu8i/Z41qoowS
         rZUQ==
X-Gm-Message-State: AOAM531Qh1LHZ9S7VzzYavgATXncwG04tSHIQLnOs+1WyPiiCkdh/187
        ujvM3aAA6ip83unRHAcdx+SOVUv/sGBS5w==
X-Google-Smtp-Source: ABdhPJysLybQpUdlMEN+2fMGXDxNX7pRGSmK7Z3wvf0Em7CztbOuvB5M/1zwNcYWUHTaShVJSXHcPA==
X-Received: by 2002:a63:920b:: with SMTP id o11mr5595818pgd.314.1639519850641;
        Tue, 14 Dec 2021 14:10:50 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b37:fbed:ef52:5dca])
        by smtp.gmail.com with ESMTPSA id a9sm39727pgl.26.2021.12.14.14.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:10:49 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:10:43 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v5 2/2] branch: add flags and config to inherit tracking
Message-ID: <YbkWY9cI/fZMMbPa@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        gitster@pobox.com, emilyshaffer@google.com, avarab@gmail.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <c7e4af9a365cc61e682c3c73045fb1ee4b79cfbf.1638859949.git.steadmon@google.com>
 <kl6lfsr3c3j7.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6lfsr3c3j7.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.07 17:02, Glen Choo wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > +static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
> > +{
> > +	const char *bare_ref;
> > +	struct branch *branch;
> > +	int i;
> > +
> > +	bare_ref = orig_ref;
> > +	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
> > +
> > +	branch = branch_get(bare_ref);
> > +	if (!branch->remote_name) {
> > +		warning(_("asked to inherit tracking from '%s', but no remote is set"),
> > +			bare_ref);
> > +		return -1;
> > +	}
> > +
> > +	if (branch->merge_nr < 1 || !branch->merge_name || !branch->merge_name[0]) {
> > +		warning(_("asked to inherit tracking from '%s', but no merge configuration is set"),
> > +			bare_ref);
> > +		return -1;
> > +	}
> > +
> > +	tracking->remote = xstrdup(branch->remote_name);
> > +	for (i = 0; i < branch->merge_nr; i++)
> > +		string_list_append(tracking->srcs, branch->merge_name[i]);
> > +	tracking->matches = 1;
> > +	return 0;
> > +}
> 
> tracking->matches is used to keep track of the number of matched remote
> refs. I believe we set tracking->matches = 1 to fulfill two specific
> conditions in setup_tracking()...
> 
> > +
> >  /*
> >   * This is called when new_ref is branched off of orig_ref, and tries
> >   * to infer the settings for branch.<new_ref>.{remote,merge} from the
> > @@ -189,11 +218,15 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
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
> 
> *extra context*
> 	if (!tracking.matches)
> 		switch (track) {
> 		case BRANCH_TRACK_ALWAYS:
> 		case BRANCH_TRACK_EXPLICIT:
> 		case BRANCH_TRACK_OVERRIDE:
> 			break;
> 		default:
> 			return;
> 		}
> 
> First, tracking.matches > 0, because we want to do work if there are
> branches to track.
> 
> Secondly,
> 
> *extra context*
> 	if (tracking.matches > 1)
> 		die(_("Not tracking: ambiguous information for ref %s"),
> 		    orig_ref);
> 
> tracking.matches <= 1, because we don't want to set up tracking if it's
> not obvious what ref we want to track.
> 
> But as I understand it, BRANCH_TRACK_INHERIT should be unconditional, so
> instead of fudging this behavior by setting the correct value for
> tracking.matches (which is meant for matching remote refs), we can just
> do what the other unconditional BRANCH_TRACK_* options do, which is to
> to break instead of return, i.e.
> 
> 	if (!tracking.matches)
> 		switch (track) {
> 		case BRANCH_TRACK_ALWAYS:
> 		case BRANCH_TRACK_EXPLICIT:
> 		case BRANCH_TRACK_OVERRIDE:
> +   case BRANCH_TRACK_INHERIT:
> 			break;
> 		default:
> 			return;
> 		}
> 
> and BRANCH_TRACK_INHERIT won't have to pretend that tracking.matches is
> meaningful to it.

Done in V6.

> >@@ -210,11 +243,13 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
> > 		die(_("Not tracking: ambiguous information for ref %s"),
> > 		    orig_ref);
> > 
> >-	if (install_branch_config(config_flags, new_ref, tracking.remote,
> >-			      tracking.src ? tracking.src : orig_ref) < 0)
> >+	if (tracking.srcs->nr < 1)
> >+		string_list_append(tracking.srcs, orig_ref);
> >+	if (install_branch_config_multiple_remotes(config_flags, new_ref, tracking.remote,
> >+			      tracking.srcs) < 0)
> > 		exit(-1);
> > 
> >-	free(tracking.src);
> >+	string_list_clear(tracking.srcs, 0);
> > }
> 
> It looks like install_branch_config_multiple_remotes() can just replace
> install_branch_config() in setup_tracking(), nice. This should make it
> pretty easy for me to rebase gc/branch-recurse-submodules onto this.
