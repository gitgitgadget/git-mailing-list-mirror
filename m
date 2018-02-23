Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC421F404
	for <e@80x24.org>; Fri, 23 Feb 2018 00:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeBWApS (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 19:45:18 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37919 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeBWApR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 19:45:17 -0500
Received: by mail-pf0-f196.google.com with SMTP id d26so2807087pfn.5
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 16:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hpl4tEezS1TJLvRFhcRMNLAGghLdZq/tKoi7RwQZPp8=;
        b=csBvtc8KCtzHl0iqDu5dB/zZJ5VLuYWhB25p2PxjBtRYCMBCc1VnjTGT8FI5lxGA4T
         kkapK9MRcMxBbiSiFmKrHVxxD55TuIrCuNKt/91PD0l/Hgh/9I7u1krwW9UCjK2vhZQf
         pAKoP+R16mgn631KfyhGRfOBmyYnibLjp+rWgyN2hCarOruytEJkQbiY2IFWGrYHdhRG
         v8oEAt/mjN5pisCR2M6xgj84pAZzORjlCFiWXiJYa47oanNMAc026cgImiO7bqKtKtSG
         IGuSeFOIUzqtGc2cwF2Zro1S2UK9uy5pQBgZukW2BZ6wb9Hx02DQz1ctFVdCWWpD8O/a
         rh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hpl4tEezS1TJLvRFhcRMNLAGghLdZq/tKoi7RwQZPp8=;
        b=LBckuFLG2+LZT27gWu12e+gkbUMYznB5+7b5nKmO1jmucBaAuvSN3EVrOTs1GfiltY
         xT2/wi64h0KJS/H9xm4RX9U+mAYAypNJCKSYs6eAjmkcdNAIhfBZpRRRTSQalOnKS+sa
         ggz8lBqK3aytS4USnesotzkl4lFRm15I514Emh0AbZw9b2qdQcy7ABAKTJ8/SE9z9Iqi
         v5TfLHhI7r/MSeIrOGhV1EogM+3Np1jA6FFyR4VCdaFZq9txYvntHs4T5TcO2dSkd2Cb
         5TABjQnNJkZoq4fllZdkO9HOHcV/F9tt8vM7giGL2ZQlIP4b8F3iTP2hqep4yrbtemJO
         LBHg==
X-Gm-Message-State: APf1xPBsWRV4Lg8sDgY5AMiUiEUiVqhKx+6EX5HlMxM4vPq4jNogUgpw
        YDV7BqCPNpR0cTtU6bJI2Q4X3g==
X-Google-Smtp-Source: AH8x227mKZY+fkrNgu9hfCk7giQ8MGbVet2D743aVba5gadSsPv3HCbNlbeGwYs9Zpbshq0IxWcmYQ==
X-Received: by 10.98.160.90 with SMTP id r87mr8534899pfe.151.1519346716483;
        Thu, 22 Feb 2018 16:45:16 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id f5sm1445737pgo.58.2018.02.22.16.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 16:45:15 -0800 (PST)
Date:   Thu, 22 Feb 2018 16:45:14 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180223004514.GP185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-14-bmwill@google.com>
 <20180222094831.GB12442@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222094831.GB12442@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22, Jeff King wrote:
> On Tue, Feb 06, 2018 at 05:12:50PM -0800, Brandon Williams wrote:
> 
> > +ls-refs takes in the following parameters wrapped in packet-lines:
> > +
> > +    symrefs
> > +	In addition to the object pointed by it, show the underlying ref
> > +	pointed by it when showing a symbolic ref.
> > +    peel
> > +	Show peeled tags.
> > +    ref-pattern <pattern>
> > +	When specified, only references matching the one of the provided
> > +	patterns are displayed.
> 
> How do we match those patterns? That's probably an important thing to
> include in the spec.

Yeah I thought about it when I first wrote it and was hoping that
someone who nudge me in the right direction :)

> 
> Looking at the code, I see:
> 
> > +/*
> > + * Check if one of the patterns matches the tail part of the ref.
> > + * If no patterns were provided, all refs match.
> > + */
> > +static int ref_match(const struct argv_array *patterns, const char *refname)
> 
> This kind of tail matching can't quite implement all of the current
> behavior. Because we actually do the normal dwim_ref() matching, which
> includes stuff like "refs/remotes/%s/HEAD".
> 
> The other problem with tail-matching is that it's inefficient on the
> server. Ideally we could get a request for "master" and only look up
> refs/heads/master, refs/tags/master, etc. And if there are 50,000 refs
> in refs/pull, we wouldn't have to process those at all. Of course this
> is no worse than the current code, which not only looks at each ref but
> actually _sends_ it. But it would be nice if we could fix this.
> 
> There's some more discussion in this old thread:
> 
>   https://public-inbox.org/git/20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net/

Thanks for the pointer.  I was told to be wary a while about about
performance implications on the server but no discussion ensued till now
about it :)

We always have the ability to extend the patterns accepted via a feature
(or capability) to ls-refs, so maybe the best thing to do now would only
support a few patterns with specific semantics.  Something like if you
say "master" only match against refs/heads/ and refs/tags/ and if you
want something else you would need to specify "refs/pull/master"?

That way we could only support globs at the end "master*" where * can
match anything (including slashes)

> 
> > +{
> > +	char *pathbuf;
> > +	int i;
> > +
> > +	if (!patterns->argc)
> > +		return 1; /* no restriction */
> > +
> > +	pathbuf = xstrfmt("/%s", refname);
> > +	for (i = 0; i < patterns->argc; i++) {
> > +		if (!wildmatch(patterns->argv[i], pathbuf, 0)) {
> > +			free(pathbuf);
> > +			return 1;
> > +		}
> > +	}
> > +	free(pathbuf);
> > +	return 0;
> > +}
> 
> Does the client have to be aware that we're using wildmatch? I think
> they'd need "refs/heads/**" to actually implement what we usually
> specify in refspecs as "refs/heads/*". Or does the lack of WM_PATHNAME
> make this work with just "*"?
> 
> Do we anticipate that the client would left-anchor the refspec like
> "/refs/heads/*" so that in theory the server could avoid looking outside
> of /refs/heads/?

Yeah we may want to anchor it by providing the leading '/' instead of
just "refs/<blah>".

> 
> -Peff

I need to read over the discussion you linked to more but what sort of
ref patterns do you believe we should support as part of the initial
release of v2?  It seems like you wanted this at some point in the past
so I assume you have an idea of what sort of filtering would be
beneficial.

-- 
Brandon Williams
