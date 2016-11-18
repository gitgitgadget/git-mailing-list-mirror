Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3A21FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 22:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbcKRW6n (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 17:58:43 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35988 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbcKRW6m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 17:58:42 -0500
Received: by mail-pg0-f54.google.com with SMTP id f188so107034619pgc.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 14:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=friD6kUB+CrcGtcfCPnJrS0CIeJpxoyIPCrDFLZRuKY=;
        b=VN44pfSZ+5CJSicLh7pw5S7QPfuLz+ulOp/FOduo/ZSHhqP45gjmcO/Ax+21wGBCeG
         dEv6tjKJiRGULc4GpNyrqiOEbNjz/GrLdoxfMMjPkFPwOdzI9QrPQPb9kwnWFlj+0HP4
         PP9cXDoavjCGjt7+RpHF/Z6xzO8YUrCN1hXzyc0nhQw0OZIIbrUmW4SzI6oGVjw6bw6a
         glgRPfRTuQiq4160W0nVNG8GBj0AwPu8x9HIxEW+IAC1ftYRR+t36Kk0+l+tA2araKoo
         EK7BnuLUBHGofliYuMOG7AiacfVgpLgC8N/184yxiLI9m85YVlCdFFY4hkjrQxR5yR96
         5cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=friD6kUB+CrcGtcfCPnJrS0CIeJpxoyIPCrDFLZRuKY=;
        b=K18dXAl0SM1c4HLHe8L/HcQZA1fiscWA+YJHoE5hCQO8YCtHqZzeftgfk2kHEajk5e
         7L6W0q2AosmgxA3RV1+8CjEBQp2yAbyPFOPwO4BunaU3j5BS0Ry152mNCFbjvhW2Akad
         VYTxC523dYUsb9KTfWeUxhSPhV7G02RzLaibrDa9MONV8GJgarj+7Q/2WSKpJNQh+O3R
         rlF0KfuUZCFaEXkGY79SFQ1fve3Ir1dNQ67X/ufAe0Ll0Ax1YahxfLHppwzbu4ugEyde
         i7gbDjqFEWRzBs73MIeu+oSxIYZ+IVEai5jatfjiA8/cBLNyEBPdCZbUlmagZb0OXIjz
         8K6Q==
X-Gm-Message-State: AKaTC03ywxF70xjCOEG79zsOhUebRBukPVQxAsnxxJiMxRiFwYN8INEIGBLm9dwnfFtRkj1m
X-Received: by 10.98.219.5 with SMTP id f5mr2691622pfg.131.1479509921966;
        Fri, 18 Nov 2016 14:58:41 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:dc40:d740:d9f4:37a3])
        by smtp.gmail.com with ESMTPSA id n25sm20289780pfi.33.2016.11.18.14.58.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Nov 2016 14:58:41 -0800 (PST)
Date:   Fri, 18 Nov 2016 14:58:40 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 4/6] grep: optionally recurse into submodules
Message-ID: <20161118225840.GC76630@google.com>
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1479499135-64269-1-git-send-email-bmwill@google.com>
 <1479499135-64269-5-git-send-email-bmwill@google.com>
 <xmqqlgwgl9ke.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgwgl9ke.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
> > +		      int cached)
> >  {
> >  	int hit = 0;
> >  	int nr;
> > +	struct strbuf name = STRBUF_INIT;
> > +	int name_base_len = 0;
> > +	if (super_prefix) {
> > +		name_base_len = strlen(super_prefix);
> > +		strbuf_addstr(&name, super_prefix);
> > +	}
> > +
> >  	read_cache();
> >  
> >  	for (nr = 0; nr < active_nr; nr++) {
> >  		const struct cache_entry *ce = active_cache[nr];
> > -		if (!S_ISREG(ce->ce_mode))
> > -			continue;
> > -		if (!ce_path_match(ce, pathspec, NULL))
> > -			continue;
> > -		/*
> > -		 * If CE_VALID is on, we assume worktree file and its cache entry
> > -		 * are identical, even if worktree file has been modified, so use
> > -		 * cache version instead
> > -		 */
> > -		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
> > -			if (ce_stage(ce) || ce_intent_to_add(ce))
> > -				continue;
> > -			hit |= grep_sha1(opt, ce->oid.hash, ce->name, 0,
> > -					 ce->name);
> > +		strbuf_setlen(&name, name_base_len);
> > +		strbuf_addstr(&name, ce->name);
> > +
> > +		if (S_ISREG(ce->ce_mode) &&
> > +		    match_pathspec(pathspec, name.buf, name.len, 0, NULL,
> > +				   S_ISDIR(ce->ce_mode) ||
> > +				   S_ISGITLINK(ce->ce_mode))) {
> > +			/*
> > +			 * If CE_VALID is on, we assume worktree file and its
> > +			 * cache entry are identical, even if worktree file has
> > +			 * been modified, so use cache version instead
> > +			 */
> > +			if (cached || (ce->ce_flags & CE_VALID) ||
> > +			    ce_skip_worktree(ce)) {
> > +				if (ce_stage(ce) || ce_intent_to_add(ce))
> > +					continue;
> > +				hit |= grep_sha1(opt, ce->oid.hash, ce->name,
> > +						 0, ce->name);
> > +			} else {
> > +				hit |= grep_file(opt, ce->name);
> > +			}
> > +		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
> > +			   submodule_path_match(pathspec, name.buf, NULL)) {
> > +			hit |= grep_submodule(opt, NULL, ce->name, ce->name);
> >  		}
> > -		else
> > -			hit |= grep_file(opt, ce->name);
> 
> We used to reject anything other than S_ISREG() upfront in the loop,
> and then either did grep_sha1() from the cache or from grep_file()
> from the working tree.
> 
> Now, the guard upfront is removed, and we do the same in the first
> part of this if/elseif.  The elseif part deals with a submodule that
> could match the pathspec.
> 
> Don't we need a final else clause that would skip the remainder of
> this loop?  What would happen to a S_ISREG() path that does *NOT*
> match the given pathspec?  We used to just "continue", but it seems
> to me that such a path will fall through the above if/elseif in the
> new code.  Would that be a problem?

It may be (Though I didn't see any issues when running tests).  It would
be easy enough to add an 'else continue;' at the end though.

-- 
Brandon Williams
