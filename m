Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40571F404
	for <e@80x24.org>; Mon, 12 Mar 2018 22:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeCLWS6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 18:18:58 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:34503 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLWS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 18:18:57 -0400
Received: by mail-pl0-f47.google.com with SMTP id u13-v6so10162553plq.1
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gbPF8yMkGf+NUEVb1elFmVfSBMMEgo1Wjzj31k9P+8I=;
        b=sj7VHrO9EzBLYdTLYYB9WEbzgB5A62vw+muCHbwTqxSoo9ykYwfvtYfrvfWDbp71oN
         /TqYm4EwYEIBNvManM3txrw+EdW58fTr1mEhNR7aX1URi+/txHNkP8cftPtjRTYCasn4
         4TyB33Cjiu5emEdKdUW17Rya56wqomNzfsJKNStYkuQAIK2VBkMxM1EV77YRVbLYdcKP
         zBEl810rsiJtddRp/luyE87QSCR+d2uzaPh+bQJHR9nJnu2wagFh8/z2xhNg9jmENzuu
         xF4oqg3uw80CK6Wd/FAiKDifbNAuHUO2UebWqOybHEoHLrWqcOTRs+uQm15NUs5S6B2y
         f8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gbPF8yMkGf+NUEVb1elFmVfSBMMEgo1Wjzj31k9P+8I=;
        b=ZYo0l/IMSQGChyh/lAekdvauz08xmybZ9FGla0LhuE5fp3581GjO4Wf3a20ghFhGFs
         6KWdbhoU1+2tT9hRz6Wn5CHrp69lkTR0ja8Anbl67cW8p2mEo4c5N72+cjTGhJgCf1h6
         ypRMw7vcL42UfKT6IYDt9cHotU/fsP9m1mEQo56aj6y+Y4au6PxO24Kt1Vy3vTU6b0Bh
         KvUp+FaXIHCDDYn0z4wx9DpyiZyN/9rwsDkNsje0BzNVdsDkbixDC0Ioj/VU9tnbXUik
         HIn7tfVeEHQNm7MHPlblrrPCBjrTGs9CCx4sTiZ/vNfVYH2lCYhcjMT6OfsixGpjDj1b
         nO4Q==
X-Gm-Message-State: AElRT7HbmuBELV2gvaxzzHd7RMtyBcLitFudWbUe9nNi7euHfj6QIMFN
        s4dgPyVhOIW9VWAMLf4XaE3Ncg==
X-Google-Smtp-Source: AG47ELvmCqrvLDwI1MVTwWqPQc9DMGgA8GO2TdmiLw3VbUr4Jn2YMn87HlEMQUKjyfu2fEd+dOhagw==
X-Received: by 2002:a17:902:5066:: with SMTP id f35-v6mr6482435plh.14.1520893137052;
        Mon, 12 Mar 2018 15:18:57 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id z15sm14604583pgr.68.2018.03.12.15.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 15:18:56 -0700 (PDT)
Date:   Mon, 12 Mar 2018 15:18:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 18/35] fetch: pass ref patterns when fetching
Message-ID: <20180312221855.GC61720@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-19-bmwill@google.com>
 <xmqq4llyazma.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4llyazma.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 850382f55..695fafe06 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -332,11 +332,25 @@ static struct ref *get_ref_map(struct transport *transport,
> >  	struct ref *rm;
> >  	struct ref *ref_map = NULL;
> >  	struct ref **tail = &ref_map;
> > +	struct argv_array ref_patterns = ARGV_ARRAY_INIT;
> >  
> >  	/* opportunistically-updated references: */
> >  	struct ref *orefs = NULL, **oref_tail = &orefs;
> >  
> > -	const struct ref *remote_refs = transport_get_remote_refs(transport, NULL);
> > +	const struct ref *remote_refs;
> > +
> > +	for (i = 0; i < refspec_count; i++) {
> > +		if (!refspecs[i].exact_sha1) {
> > +			if (refspecs[i].pattern)
> > +				argv_array_push(&ref_patterns, refspecs[i].src);
> > +			else
> > +				expand_ref_pattern(&ref_patterns, refspecs[i].src);
> > +		}
> > +	}
> > +
> > +	remote_refs = transport_get_remote_refs(transport, &ref_patterns);
> > +
> > +	argv_array_clear(&ref_patterns);
> 
> Is the idea here, which is shared with 17/35 about ls-remote, that
> we used to grab literally everything they have in remote_refs, but
> we have code in place to filter that set using refspecs given in the
> remote.*.fetch configuration, so it is OK as long as we grab everything
> that would match the remote.*.fetch pattern?  That is, grabbing too
> much is acceptable, but if we populated ref_patterns[] with too few
> patterns and fail to ask refs that would match our refspec it would
> be a bug?

Yes that's the idea.  Right now we're in the state where we ask for
everything (since there is no server side filtering) and the client just
does its own filtering after the fact using the refspec.  So if we end
up not sending enough ref patterns to match what the refspec is, it
would be a bug.

> 
> The reason behind this question is that I am wondering if/how we can
> take advantage of this remote-side pre-filtering while doing "fetch
> --prune".

Hmm maybe, assuming prune then means "get rid of all remote-tracking
branches that don't match the user provided refspec"

> 
> Thanks.
> 
> >  
> >  	if (refspec_count) {
> >  		struct refspec *fetch_refspec;

-- 
Brandon Williams
