Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E5BC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0514523105
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbhAFI0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbhAFI0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 03:26:35 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56247C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 00:25:55 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id z21so1750780pgj.4
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 00:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2UcbdWDAb5aYSPOw4IEqrUoS2MwcOVNArBzFXOkNL+k=;
        b=MRWVwncn3Ij0w8EXvmxKjZjt4YxqFhS4KOxn8dkQhR8DBwZoS8MtoRNxc6l0cDQ9bL
         WVTeeVc/Ht933cU5/OaNc6Mki0qhPj6E0/AT3VOcpn0Ym61mhCrXqRBzXM9816O8tWPQ
         9e76VBOnrWktkBSIwDA8hQD1+PFMHbdFxi1Up1Ne9XXI3SLWau2+zO3gJMQoieyRyhhQ
         9skd/BR7pgIrogvwWHkuX6a0yMbGVxUuKdpntkSDveEBV6mnv0KNyDVvcEGh7fDvYcLa
         I6SuUMqXozqGm47jQ5Wqk7oH54W9lgAeAJWzGWDLElqyKyAlgpJwcCFJvjfnRrVTg9ED
         w5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2UcbdWDAb5aYSPOw4IEqrUoS2MwcOVNArBzFXOkNL+k=;
        b=IG13FK+OoKhrR9bxUr2AerkZjZZ1FQG5mHyyt7RakZFcHDzpnokyw9mroKpMfBgpr4
         8DdvhD1ZBUxEWg0pGUTbREV6CisNs6zifay8RmaJmT1nGzfaN1IS5NTKnFOlpERGh2L5
         M5P3B6y+Iyn2sF6JY6d5A6cL7/QfHfLDwHm/aXo9r9wHUZ9LQUK9fgC1KPKx9ulelMfe
         DbiNMV9hyGbjPWjEJB3mIG/Oc99Zj3Wdwm0k+AFMxXEaUnd8hupNAcQGPnjh0keBsn+h
         pcHkFi+nWpL6MahezqGDF9xvPQK2pFV3Qs8k8xKHtwAoKwSeDRe1mghWcpIXhf3lvnHI
         PRiQ==
X-Gm-Message-State: AOAM5338mrMcT/noDoE+KmQv7KVzq6d+FogqMoQhwtFECZNTV0OzspoY
        2F2opzi9TVdfy67ggh0iaXr80+0vuOs=
X-Google-Smtp-Source: ABdhPJy3wlm4+gWocneVAWD/vID+97T84UOy95zLLhVW+ia10fig4p/DZoL3WNloAbAknJK9Ab9dvA==
X-Received: by 2002:a63:4451:: with SMTP id t17mr3349120pgk.322.1609921553330;
        Wed, 06 Jan 2021 00:25:53 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id a26sm1808778pgd.64.2021.01.06.00.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 00:25:51 -0800 (PST)
Date:   Wed, 6 Jan 2021 00:25:49 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] refs: allow @{n} to work with n-sized reflog
Message-ID: <X/V0DU+CD6mS36dK@generichostname>
References: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
 <xmqqk0sqvcby.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0sqvcby.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Jan 05, 2021 at 09:55:29PM -0800, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > This sequence works
> >
> > 	$ git checkout -b newbranch
> > 	$ git commit --allow-empty -m one
> > 	$ git show -s newbranch@{1}
> >
> > and shows the state that was immediately after the newbranch was
> > created.
> >
> > But then if you do
> >
> > 	$ git reflog expire --expire=now refs/heads/newbranch
> > 	$ git commit --allow=empty -m two
> > 	$ git show -s newbranch@{1}
> >
> > you'd be scolded with
> >
> > 	fatal: log for 'newbranch' only has 1 entries
> >
> > While it is true that it has only 1 entry, we have enough
> > information in that single entry that records the transition between
> > the state in which the tip of the branch was pointing at commit
> > 'one' to the new commit 'two' built on it, so we should be able to
> > answer "what object newbranch was pointing at?". But we refuse to
> > do so.
> 
> Yeah, I am often hit and irritated by this behaviour.

Yep, this was inspired by one of your emails ;)

> > diff --git a/refs.c b/refs.c
> > index 13dc2c3291..c35c61a009 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -887,12 +887,16 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
> >  		const char *message, void *cb_data)
> >  {
> >  	struct read_ref_at_cb *cb = cb_data;
> > +	int at_indexed_ent;
> >  
> >  	cb->reccnt++;
> >  	cb->tz = tz;
> >  	cb->date = timestamp;
> >  
> > -	if (timestamp <= cb->at_time || cb->cnt == 0) {
> > +	if (cb->cnt > 0)
> > +		cb->cnt--;
> > +	at_indexed_ent = cb->cnt == 0 && !is_null_oid(ooid);
> 
> The code treats two cases identically (i.e. the case where cb->cnt
> was originally zero, and one).  Is that intended?

It shouldn't be possible for cb->cnt == 0 on the first iteration
because there's a special-case check at [0]. As a result, it can only be
-1 or >= 1 on the first iteration.

The -1 case happens when we're doing date-based lookup and that's what
this if is intended to handle.

In the case where it's >= 1, we will always enter the if and it will
always pre-decrement. This essentially gets us the n-1 behaviour.

> I thought the code was to special case only <ref>@{0}, but with this
> conditional decrement, cb->cnt==0 would not be usable by the rest
> of the code as the "we must read the new side instead" signal. Is
> that why null-ness of ooid is also tested here?  It is hard to tell
> the intention because "at_indexed_ent" does not quite tell me what
> the code wants to use the variable for.

The null-ness of the ooid is needed because on the last entry of the
reflog, ooid will be null so we should skip that.

"at_indexed_ent" is meant to signal when we are indexing the reflog
numerically (as opposed to by date), we have arrived at the correct
entry. If you have a more fitting name, I'm open to suggestions.

> > +	if (timestamp <= cb->at_time || at_indexed_ent) {
> >  		if (cb->msg)
> >  			*cb->msg = xstrdup(message);
> >  		if (cb->cutoff_time)
> > @@ -905,28 +909,41 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
> >  		 * we have not yet updated cb->[n|o]oid so they still
> >  		 * hold the values for the previous record.
> >  		 */
> > -		if (!is_null_oid(&cb->ooid)) {
> > -			oidcpy(cb->oid, noid);
> > -			if (!oideq(&cb->ooid, noid))
> > -				warning(_("log for ref %s has gap after %s"),
> > +		if (!is_null_oid(&cb->ooid) && !oideq(&cb->ooid, noid))
> > +			warning(_("log for ref %s has gap after %s"),
> >  					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
> > -		}
> > -		else if (cb->date == cb->at_time)
> > +		if (at_indexed_ent)
> > +			oidcpy(cb->oid, ooid);
> > +		else if (!is_null_oid(&cb->ooid) || cb->date == cb->at_time)
> >  			oidcpy(cb->oid, noid);
> >  		else if (!oideq(noid, cb->oid))
> >  			warning(_("log for ref %s unexpectedly ended on %s"),
> >  				cb->refname, show_date(cb->date, cb->tz,
> >  						       DATE_MODE(RFC2822)));
> > -		oidcpy(&cb->ooid, ooid);
> > -		oidcpy(&cb->noid, noid);
> >  		cb->found_it = 1;
> > -		return 1;
> >  	}
> >  	oidcpy(&cb->ooid, ooid);
> >  	oidcpy(&cb->noid, noid);
> > -	if (cb->cnt > 0)
> > -		cb->cnt--;
> > -	return 0;
> > +	return cb->found_it;
> > +}
> > +
> > +static int read_ref_at_ent_newest(struct object_id *ooid, struct object_id *noid,
> > +				  const char *email, timestamp_t timestamp,
> > +				  int tz, const char *message, void *cb_data)
> > +{
> > +	struct read_ref_at_cb *cb = cb_data;
> > +
> > +	if (cb->msg)
> > +		*cb->msg = xstrdup(message);
> > +	if (cb->cutoff_time)
> > +		*cb->cutoff_time = timestamp;
> > +	if (cb->cutoff_tz)
> > +		*cb->cutoff_tz = tz;
> > +	if (cb->cutoff_cnt)
> > +		*cb->cutoff_cnt = cb->reccnt;
> > +	oidcpy(cb->oid, noid);
> > +	/* We just want the first entry */
> > +	return 1;
> >  }
> 
> The similarity of this to read_ref_at_ent_oldest is somehow
> striking.  Do we really need to invent a new callback?

Unfortunately, yes. The alternative is to add a flag into
`struct read_ref_at_cb` and we could conditionally choose whether or not
to copy noid or ooid but this seems like the lesser of two evils.

The duplicated part,

	if (cb->msg)
		*cb->msg = xstrdup(message);
	if (cb->cutoff_time)
		*cb->cutoff_time = timestamp;
	if (cb->cutoff_tz)
		*cb->cutoff_tz = tz;
	if (cb->cutoff_cnt)
		*cb->cutoff_cnt = cb->reccnt;

is actually repeated three times -- once in each of the callbacks. I
considered extracting factoring it out into a function but I was on the
fence because the function would still have some duplication since it'd
still require cb, message, timestamp and tz to all be passed in.

> >  static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
> > @@ -967,6 +984,11 @@ int read_ref_at(struct ref_store *refs, const char *refname,
> >  	cb.cutoff_cnt = cutoff_cnt;
> >  	cb.oid = oid;
> >  
> > +	if (cb.cnt == 0) {
> > +		refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent_newest, &cb);
> > +		return 0;
> > +	}
> > +

[0]

> >  	refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
> >  
> >  	if (!cb.reccnt) {

Thanks,
Denton
