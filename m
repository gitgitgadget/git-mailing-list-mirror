Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D589C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 05:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhLQFLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 00:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhLQFLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 00:11:05 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C728C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:11:05 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i12so1254984pfd.6
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=a/r3Kb0ZwfCMBfIXx0yR37xO3D2K1tpNfHxHV4OO38s=;
        b=KtmDwvWeRWz8mmtyRsgY4e75ACsUV5ON9ME5fqNVpFGKMpU1ED5e5F3nSnUlPt/067
         qQzXI0VNM35hFJBevPlp6O2GSwDf+cFDpG4lpoTJeaEk3Wwbr8X1k7yK7u/DIwTpborV
         l1Y+zoCSoJdb5MDogYjr7E+x8IYs5rZlifK2lFmy9ZH6qKjcdwHjlf3E7L323jN/gA+b
         qj7L5OE3dr3b6tmqJnfCOTiLHSN1e/eBYj2OKm9JAmBYSQRYI8d575jygNFRzA8wBvMR
         Rqs3DaU0zHT5WOLaRARApk9suvVPOATt+SAKx1y/nFr6rkKLlBFjFqLU/MaQYBeIbk2P
         2sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=a/r3Kb0ZwfCMBfIXx0yR37xO3D2K1tpNfHxHV4OO38s=;
        b=wSF4FHh4mpglTqzHk+07eSAASqrRkTc/4QZrrMS1eQGoVoYF7xwNhhlJjSBnz8cNwL
         7EXJv1eH2Y/XyExVZDuEYt+lcqDwtJUK9T8je8s/v3X2HzbOAt2G34Pf+PvMu9PaPKAc
         FiXNE1UZLt9wBDZZVp4kI2luX/XrtX7Md659u7+kwZuwP7jigvlVZdVbUWJsHkWZgXfM
         xuajjTe3W5bCLCeC5dXvYr7l3zMARdxV0/HCsXnDL0ZnHVbEjVy2tLLRJ2cVdeOq61I6
         3wIhnkus8BMA6rEuEELh/u2Q+Y0tLzEKIzWoSLbAPjG0+JN+Z7ZCov//1AXTgW1EDp4v
         lFvA==
X-Gm-Message-State: AOAM533S/wa5fwi35EegXNSWAnhht7Bg1ThGVKmLx4XfUEBAZdB/of34
        S+aiYre5nprY9Di73KGZ8L/TJw==
X-Google-Smtp-Source: ABdhPJwi2F1IQtAzYORyf5+t8KEKz+gBMYAzLDKWuK+ut0ykHKKs8FqnyAKV0m4YqRrEKMCPOOuQgg==
X-Received: by 2002:aa7:9990:0:b0:4a1:57ff:3369 with SMTP id k16-20020aa79990000000b004a157ff3369mr1390507pfh.31.1639717864016;
        Thu, 16 Dec 2021 21:11:04 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a37:b5e2:96be:e5d5])
        by smtp.gmail.com with ESMTPSA id om8sm10933619pjb.12.2021.12.16.21.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 21:11:03 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:10:57 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 1/3] branch: accept multiple upstream branches for
 tracking
Message-ID: <Ybwb4UkQwAVRcJp5@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639524556.git.steadmon@google.com>
 <43d6f83fedc022c44d6a3be249e7fd8cd2a25007.1639524556.git.steadmon@google.com>
 <kl6lo85g8grj.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6lo85g8grj.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.16 11:57, Glen Choo wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> >  {
> >  	const char *shortname = NULL;
> >  	struct strbuf key = STRBUF_INIT;
> > +	struct string_list_item *item;
> >  	int rebasing = should_setup_rebase(origin);
> >  
> > -	if (skip_prefix(remote, "refs/heads/", &shortname)
> > -	    && !strcmp(local, shortname)
> > -	    && !origin) {
> > -		warning(_("Not setting branch %s as its own upstream."),
> > -			local);
> > -		return 0;
> > -	}
> > +	if (!remotes->nr)
> > +		BUG("must provide at least one remote for branch config");
> > +	if (rebasing && remotes->nr > 1)
> > +		die(_("cannot inherit upstream tracking configuration when rebasing is requested"));
> 
> Nit: if we're being pedantic, we cannot inherit upstream tracking
> configuration when rebasing is requested with multiple upstream
> branches.
> 
> But this message is already very niche and loaded with specifics, so
> adding "...with multiple upstream branches" might just be more
> confusing, so this is a nit.

I think it's worthwhile to be precise. Thanks for pointing this out.
Fixed in V7.


> > @@ -87,29 +112,42 @@ int install_branch_config(int flag, const char *local, const char *origin, const
> >  	strbuf_release(&key);
> >  
> >  	if (flag & BRANCH_CONFIG_VERBOSE) {
> > -		if (shortname) {
> > +		const char *name;
> > +		struct strbuf ref_string = STRBUF_INIT;
> > +
> > +		for_each_string_list_item(item, remotes) {
> > +			name = item->string;
> > +			skip_prefix(name, "refs/heads/", &name);
> > +			strbuf_addf(&ref_string, "  %s\n", name);
> > +		}
> > +
> > +		if (remotes->nr == 1) {
> > +			struct strbuf refname = STRBUF_INIT;
> > +
> >  			if (origin)
> > -				printf_ln(rebasing ?
> > -					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
> > -					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
> > -					  local, shortname, origin);
> > -			else
> > -				printf_ln(rebasing ?
> > -					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
> > -					  _("Branch '%s' set up to track local branch '%s'."),
> > -					  local, shortname);
> > +				strbuf_addf(&refname, "%s/", origin);
> > +			strbuf_addstr(&refname, remotes->items[0].string);
> > +
> > +			/*
> > +			 * Rebasing is only allowed in the case of a single
> > +			 * upstream branch.
> > +			 */
> > +			printf_ln(rebasing ?
> > +				_("branch '%s' set up to track '%s' by rebasing.") :
> > +				_("branch '%s' set up to track '%s'."),
> > +				local, refname.buf);
> > +
> > +			strbuf_release(&refname);
> > +		} else if (origin) {
> > +			printf_ln(_("branch '%s' set up to track from '%s':"),
> > +				local, origin);
> > +			printf("%s", ref_string.buf);
> 
> It's not clear to me why the hint contains the word 'from' when it is a
> remote ref...

Because in the multiple-branch case, we don't prepend the origin to each
ref, so we need to let users know which remote the refs are coming from.


> >  		} else {
> > -			if (origin)
> > -				printf_ln(rebasing ?
> > -					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
> > -					  _("Branch '%s' set up to track remote ref '%s'."),
> > -					  local, remote);
> > -			else
> > -				printf_ln(rebasing ?
> > -					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
> > -					  _("Branch '%s' set up to track local ref '%s'."),
> > -					  local, remote);
> > +			printf_ln(_("branch '%s' set up to track:"), local);
> > +			printf("%s", ref_string.buf);
> 
> but does not have the word 'from' when it is a local ref. As far as I
> can tell, this is the only difference between remote and local refs, and
> adding the word 'from' does not seem like a good enough reason to add an
> 'if' condition. Maybe I missed something here?
> 
> This motivates my answer to the question you asked in [1]:
> 
>   I removed as many distinctions as possible, as most can still be
>   inferred from context. [...] Likewise, we don't need to specify whether
>   refs are remote or local: "some-remote/some-branch" vs.
>   "a-local-branch" should be understandable without us spelling it out.
> 
> I agree that there is adequate context, so I would be ok with the
> simplification if there was corresponding code simplification e.g.
> dropping "if (origin)". But in its current form, I don't think there is
> good enough reason to simplify the message.

I think the proper point of comparison is not the original code, but the
code from V5 where we try to preserve the same level of detail in output
as the original code. If we are committed to both having multiple
remotes and keeping similar styles of output as the original
implementation, then something like the massive conditional in V5 is
unavoidable.

> Of course, IIUC, this is as simple as dropping 'from' in the "if
> (origin)" case.
> 
> > @@ -118,14 +156,33 @@ int install_branch_config(int flag, const char *local, const char *origin, const
> >  	strbuf_release(&key);
> >  	error(_("Unable to write upstream branch configuration"));
> >  
> > -	advise(_(tracking_advice),
> > -	       origin ? origin : "",
> > -	       origin ? "/" : "",
> > -	       shortname ? shortname : remote);
> > +	advise(_("\nAfter fixing the error cause you may try to fix up\n"
> > +		"the remote tracking information by invoking:"));
> > +	if (remotes->nr == 1)
> > +		advise("  git branch --set-upstream-to=%s%s%s",
> > +			origin ? origin : "",
> > +			origin ? "/" : "",
> > +			remotes->items[0].string);
> > +	else
> > +		for_each_string_list_item(item, remotes)
> > +			advise("  git config --add branch.\"%s\".merge %s",
> > +				local, item->string);
> 
> The advice is now correct, nice! Does the user also need to run "git
> config --add branch.%s.remote %s" ?
> 
> [1] https://lore.kernel.org/git/Ybk6QsMdeBl6IweW@google.com

Yes, thank you for the catch. Fixed in V7.
