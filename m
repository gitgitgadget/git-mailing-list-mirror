Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A5661F404
	for <e@80x24.org>; Mon, 12 Mar 2018 22:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeCLWUK (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 18:20:10 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36615 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeCLWUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 18:20:09 -0400
Received: by mail-pg0-f41.google.com with SMTP id i14so7120017pgv.3
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LzAz/hWO776lvInD6Z1fEZY7svg5nwjxeLExPjRdpPA=;
        b=hKubj16jNqHkNgjQkHSEPgUmvSgbfBRsVHf7mz3T+X3AXyWlx/MR/IDDxSGZ8gKcof
         oAlU4a7Zzd6kTAdRXhYiX2Yrlay0fg31n+YprlDNn/g3txanzpHWwumCnjouBL8RC12J
         DIBuDkpr/Bo/nvdPK/4SISBqWegM9PsuGltQv2zS8cko0XmDz0JRKD7TOiaU2bYTLdla
         RY2d91wAhpqqfE8nw/X8rMpJ36j0ruvYFhHIdbbh18Gmw+cCjR9DOvxf+yaViBsIgUlv
         nvpJUE7HDN8mYgefY/A4uAWzoKwk1eCGOPgbU94UTjiO+g6SOiW2pl6JV2IVrFowLilG
         Gf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LzAz/hWO776lvInD6Z1fEZY7svg5nwjxeLExPjRdpPA=;
        b=JBKLRqVR8v13fcHq38O4yqVK0YtSy8SvjSI9astIncVwUwSbQEDJit0lf4GnBcwbJN
         FeZD9Cp7t5ZAmAf6n2HfnCg5QOydV5SfK5S6KfkZhFo0RhTZGLO8CLk3FxFlz7yDoUth
         6sZMl73qml6Edp9dAyl6+XWGcKUzOjxlQs2nNqBqIBqR/42D7taYAUh+y7F4JtedvIgW
         mIQVK6V4z8jq5TUDuyS7qNYvlSjWDp1gF9cL5z63UG4Z7pC4wTKGtW9XVCZU3XdRvtsH
         j9wnrFp4BoiPTY7ouL3/zG5cLSnReXgHG3L+BZ0857LuMUbvrgRS04+TiezdAocW5cKR
         CXrA==
X-Gm-Message-State: AElRT7EvtDxx5PpxZO5XVurJJ4nTnTbJadTKOVUcDF+lUSKxxwDglvV1
        lCsBG23mBCVjjpUTcdXpsXllHw==
X-Google-Smtp-Source: AG47ELtS+1zG13+P+w14A6KDqOrGd4rFpRuopnGbP25IuUnUqCDpvVZvo7XAAjIFpkCyCx0eEm2Ing==
X-Received: by 10.99.168.75 with SMTP id i11mr7782205pgp.420.1520893208895;
        Mon, 12 Mar 2018 15:20:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id n7sm15535229pgd.87.2018.03.12.15.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 15:20:08 -0700 (PDT)
Date:   Mon, 12 Mar 2018 15:20:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 19/35] push: pass ref patterns when pushing
Message-ID: <20180312222007.GD61720@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-20-bmwill@google.com>
 <xmqqzi3q9ku6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzi3q9ku6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Construct a list of ref patterns to be passed to 'get_refs_list()' from
> > the refspec to be used during the push.  This list of ref patterns will
> > be used to allow the server to filter the ref advertisement when
> > communicating using protocol v2.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  transport.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> When you are pushing 'master', we no longer hear what the other end
> has at 'next', with this change, no?
> 
> In a project whose 'master' is extended primarily by merging topics
> that have been cooking in 'next', old way of pushing would only have
> transferred the merge commits and resulting trees but not bulk of
> the blob data because they are all available on 'next', would it
> make the object transfer far less efficient, I wonder?
> 
> I guess it is OK only because the push side of the current protocol
> does not do common ancestor discovery exchange ;-)

Yep, though we've been throwing around ideas of adding that in push v2
after we figure out a good way to improve negotiation with fetch.

> 
> >
> > diff --git a/transport.c b/transport.c
> > index dfc603b36..bf7ba6879 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -1026,11 +1026,35 @@ int transport_push(struct transport *transport,
> >  		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
> >  		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
> >  		int push_ret, ret, err;
> > +		struct refspec *tmp_rs;
> > +		struct argv_array ref_patterns = ARGV_ARRAY_INIT;
> > +		int i;
> >  
> >  		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
> >  			return -1;
> >  
> > -		remote_refs = transport->vtable->get_refs_list(transport, 1, NULL);
> > +		tmp_rs = parse_push_refspec(refspec_nr, refspec);
> > +		for (i = 0; i < refspec_nr; i++) {
> > +			const char *pattern = NULL;
> > +
> > +			if (tmp_rs[i].dst)
> > +				pattern = tmp_rs[i].dst;
> > +			else if (tmp_rs[i].src && !tmp_rs[i].exact_sha1)
> > +				pattern = tmp_rs[i].src;
> > +
> > +			if (pattern) {
> > +				if (tmp_rs[i].pattern)
> > +					argv_array_push(&ref_patterns, pattern);
> > +				else
> > +					expand_ref_pattern(&ref_patterns, pattern);
> > +			}
> > +		}
> > +
> > +		remote_refs = transport->vtable->get_refs_list(transport, 1,
> > +							       &ref_patterns);
> > +
> > +		argv_array_clear(&ref_patterns);
> > +		free_refspec(refspec_nr, tmp_rs);
> >  
> >  		if (flags & TRANSPORT_PUSH_ALL)
> >  			match_flags |= MATCH_REFS_ALL;

-- 
Brandon Williams
