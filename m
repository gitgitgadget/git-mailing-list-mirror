Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54631C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 03:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhLUD1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 22:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhLUD1s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 22:27:48 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C221FC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 19:27:48 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 196so6897362pfw.10
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 19:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=J19qaElcO7F0p3f4gGzcISd/1LttAx5CriXkz5I9/N8=;
        b=ORlzUnQHD/C+2sGMsSSsa+gqC/AjN32HwmwHQT6EOWHeh/C8eO/cHuyODJOwItulqd
         E7e1fCwHG2qH3jNsPO+zgXhXHbv9MiaUXn3bFaHePC4iQMcZWZJ3Pwu7BW+fQUAAf9oJ
         29OEe9x0TWjQbgbBS5xwVRmWRMFrBef7mSpnMInHOF7wsqv9BSCOvHxlnyPoU+D5PbVG
         QGCzbtGFgVAUdMxE0LF16qzHE19fojv6DUKSaOnq8kLw36N66sd+vic8EFABSlZVeGyx
         CW0cyUI0Tya8Z250b2XflhoDL2aVATXVkhtR+kyRLLZuz0z+Q9OBvJ31nNwH/utWjsVp
         pkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=J19qaElcO7F0p3f4gGzcISd/1LttAx5CriXkz5I9/N8=;
        b=rRvHDgoouJRCwBPw4jPvTKz38FBACA2yUunUd47CSjRvsEEpwKsIudTmAYXfIT5l4/
         zicmcW4qPU5wqa2LMb30oVue30pqu75jbfr1WAwx+OGO0TWU3EGKyM318Q1XCDL+4hEG
         Nbwc/3WxVzMYIKWibCMF23QYRn8G8gohFc47J1h7kVD21GK+DpkUFuVsFbF5Id3mykQu
         4OJqBtpJWANJMVhRMWjDJ4rB20parV5XEmHPMzHOjn58cpaPPoMPOiI1JX1cTS9zcIre
         MHrOBjAFngKS3LFuCCfnpFzxrpYHy28dBoSAMI5Bh+Y5X08sSTOaVFtI5bTbfwjgTlvf
         cdBA==
X-Gm-Message-State: AOAM53147vWeYEbwD1cF3LI15+nDBGEcmaluMIqO9mRybbx5C4kHhgyT
        CngVoRo5GOtK3ytfuQaR9ZhVQg==
X-Google-Smtp-Source: ABdhPJwDT30Jp4Hyw89Sq9UA4Wo4gZy8OJSvLCxCS5DRE44TrloMWlodo2U/g74s4027Da2b2GJPDw==
X-Received: by 2002:a05:6a00:2402:b0:4a8:4557:e96b with SMTP id z2-20020a056a00240200b004a84557e96bmr1157883pfh.76.1640057267939;
        Mon, 20 Dec 2021 19:27:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:e4d8:c4fc:fa70:c18e])
        by smtp.gmail.com with ESMTPSA id u3sm21767010pfk.32.2021.12.20.19.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 19:27:47 -0800 (PST)
Date:   Mon, 20 Dec 2021 19:27:40 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 1/3] branch: accept multiple upstream branches for
 tracking
Message-ID: <YcFJrCBHeCNCyTMF@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639524556.git.steadmon@google.com>
 <43d6f83fedc022c44d6a3be249e7fd8cd2a25007.1639524556.git.steadmon@google.com>
 <kl6lo85g8grj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Ybwb4UkQwAVRcJp5@google.com>
 <kl6lzgovyvt7.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6lzgovyvt7.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.20 10:29, Glen Choo wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> >> > @@ -87,29 +112,42 @@ int install_branch_config(int flag, const char *local, const char *origin, const
> >> >  	strbuf_release(&key);
> >> >  
> >> >  	if (flag & BRANCH_CONFIG_VERBOSE) {
> >> > -		if (shortname) {
> >> > +		const char *name;
> >> > +		struct strbuf ref_string = STRBUF_INIT;
> >> > +
> >> > +		for_each_string_list_item(item, remotes) {
> >> > +			name = item->string;
> >> > +			skip_prefix(name, "refs/heads/", &name);
> >> > +			strbuf_addf(&ref_string, "  %s\n", name);
> >> > +		}
> >> > +
> >> > +		if (remotes->nr == 1) {
> >> > +			struct strbuf refname = STRBUF_INIT;
> >> > +
> >> >  			if (origin)
> >> > -				printf_ln(rebasing ?
> >> > -					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
> >> > -					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
> >> > -					  local, shortname, origin);
> >> > -			else
> >> > -				printf_ln(rebasing ?
> >> > -					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
> >> > -					  _("Branch '%s' set up to track local branch '%s'."),
> >> > -					  local, shortname);
> >> > +				strbuf_addf(&refname, "%s/", origin);
> >> > +			strbuf_addstr(&refname, remotes->items[0].string);
> >> > +
> >> > +			/*
> >> > +			 * Rebasing is only allowed in the case of a single
> >> > +			 * upstream branch.
> >> > +			 */
> >> > +			printf_ln(rebasing ?
> >> > +				_("branch '%s' set up to track '%s' by rebasing.") :
> >> > +				_("branch '%s' set up to track '%s'."),
> >> > +				local, refname.buf);
> >> > +
> >> > +			strbuf_release(&refname);
> >> > +		} else if (origin) {
> >> > +			printf_ln(_("branch '%s' set up to track from '%s':"),
> >> > +				local, origin);
> >> > +			printf("%s", ref_string.buf);
> >> 
> >> It's not clear to me why the hint contains the word 'from' when it is a
> >> remote ref...
> >
> > Because in the multiple-branch case, we don't prepend the origin to each
> > ref, so we need to let users know which remote the refs are coming from.
> 
> I see. So if I'm reading this correctly, the error message in the remote
> case would read something like:
> 
>   branch 'main' set up to track from 'origin':
>     main
>     topic1
>     topic2
> 
> Is there any reason why we couldn't append the origin to the ref to make
> it consistent? I think this could be as simple as:
> 
> 
> 	for_each_string_list_item(item, remotes) {
> 		name = item->string;
> 		skip_prefix(name, "refs/heads/", &name);
> 			if (origin)
> +         strbuf_addf(&ref_string, "%s/", origin);
> 		strbuf_addf(&ref_string, "  %s\n", name);
> 	}
> 
> and the resulting list could look like:
> 
>   branch 'main' set up to track from 'origin':
>     origin/main
>     origin/topic1
>     origin/topic2
> 
> This looks repetitive, but I suggest this because, as I understand it,
> we are omitting the "{local,remote} ref" phrase based on conventions
> around ref names, like "origin/main" is probably a remote ref and not an
> oddly named local ref. However, when we print the list like so,
> 
>   branch 'main' set up to track from 'origin':
>     main
>     topic1
>     topic2
> 
> we now expect the user to understand that 'main', 'topic1' and 'topic2'
> to implicitly have 'origin/' prepended to them. This behavior seems
> inconsistent to me; I'd anticipate most users responding "Wait, I was
> supposed to be tracking 'origin' branches right? Why am I looking at
> local branches?". Some users would be able to recover because they can
> figure out what we mean, but others might just give up.
> 
> Prepending 'origin/' would get rid of this problem altogether, and it
> would let us drop the 'from'.

Yeah, I think that's better. Fixed in V7, thanks.


> >> >  		} else {
> >> > -			if (origin)
> >> > -				printf_ln(rebasing ?
> >> > -					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
> >> > -					  _("Branch '%s' set up to track remote ref '%s'."),
> >> > -					  local, remote);
> >> > -			else
> >> > -				printf_ln(rebasing ?
> >> > -					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
> >> > -					  _("Branch '%s' set up to track local ref '%s'."),
> >> > -					  local, remote);
> >> > +			printf_ln(_("branch '%s' set up to track:"), local);
> >> > +			printf("%s", ref_string.buf);
> >> 
> >> but does not have the word 'from' when it is a local ref. As far as I
> >> can tell, this is the only difference between remote and local refs, and
> >> adding the word 'from' does not seem like a good enough reason to add an
> >> 'if' condition. Maybe I missed something here?
> >> 
> >> This motivates my answer to the question you asked in [1]:
> >> 
> >>   I removed as many distinctions as possible, as most can still be
> >>   inferred from context. [...] Likewise, we don't need to specify whether
> >>   refs are remote or local: "some-remote/some-branch" vs.
> >>   "a-local-branch" should be understandable without us spelling it out.
> >> 
> >> I agree that there is adequate context, so I would be ok with the
> >> simplification if there was corresponding code simplification e.g.
> >> dropping "if (origin)". But in its current form, I don't think there is
> >> good enough reason to simplify the message.
> >
> > I think the proper point of comparison is not the original code, but the
> > code from V5 where we try to preserve the same level of detail in output
> > as the original code. If we are committed to both having multiple
> > remotes and keeping similar styles of output as the original
> > implementation, then something like the massive conditional in V5 is
> > unavoidable.
> 
> I see. So for instance, post-simplification you have:
> 
>   printf_ln(rebasing ?
>     _("branch '%s' set up to track '%s' by rebasing.") :
>     _("branch '%s' set up to track '%s'."),
>     local, refname.buf);
> 
> if you preserve the same amount of detail as before, you'd have to
> distinguish between local/remote, which doubles the number of cases to
> 4, which is why the conditional v5 is so complicated.
> 
> That said, I think that it's already much simpler than v5 because you've
> split the singular and plural cases. I wonder if you have considered
> building the final string purely from format strings, like:
> 
>   char *message_format = _("branch %s set up to track %s%s%s%s");
>   char *ref_type_clause = origin ? " remote ref " : " local ref ";
>   char *rebasing_clause = rebasing ? " by rebasing." : ".";
>   char *branch_names = "<branch names>";
>   printf_ln(message_format, local, ref_type_clause, branch_names, rebasing_clause);
> 
> This sounds potentially unfriendly to i18n, but it would make the
> conditional simpler. What do you think?

Yeah, the translation-unfriendliness is why I avoided this approach.
