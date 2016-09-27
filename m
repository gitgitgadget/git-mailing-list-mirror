Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A60520986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbcI0UkZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:40:25 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34764 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbcI0UkY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:40:24 -0400
Received: by mail-pa0-f41.google.com with SMTP id gp7so8990988pac.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T59PLzAMTvPpqyKR5xUHalW1e4eDhwiAwa4qnTzeGuw=;
        b=NAEKfkegZpb/PdokLFcvbbockrwBhZKil1GjuAGKoDWMEkvZoFwUYB3gFmIGO40gyU
         LEP4dHcuFEShKs3UaoMO8kFEXLq6IiSP4IJdbGfQxY2pu4AxlgAD3M779P7qDK3pBRO9
         WZr6MoteLlhXcVcyp1rl5lUlWsfbkSOKWRz3pX87LBaNiNc5ij9z1iiDwNdcuO0IXj6S
         qwXbVnk2jQtt32lGkFg2mHADOg3BDfoSHu+zy5YYWp0tDK+zc38ogaMDalNL64L0mF4z
         3dXy3lYgzuQnXg2HXGizBp3esTFuWrZsjYJGqcIPZBxkciTicuN2lYLJeftq09cu0svL
         pzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T59PLzAMTvPpqyKR5xUHalW1e4eDhwiAwa4qnTzeGuw=;
        b=J9CS7jdgehrJAWLKTH5hSmhrdWwo6uOSQpNHmJCeDqN9foR/aj/s31VResozdumQJb
         FMavIQZ4XflN8TzKrr/2vOzm2rLvy2pQA47A/Y73OS6+5W1idklt77UBYHAiBkAyeI4q
         /T6tmEzRpjDbgS/CYhMMKFFQBLMQn5ET1sj/1LQ7y5gR5LmWc7URg6NeN6aXpzXLJpud
         gLPaumrKn1SRB7M1+S+pmZeA4I5mVp8WwpVVOHItl/rSRzwLjQO1+ASuIJYzYsgr5Wy5
         YKoXdaEZSDjPiFzHEbEgJW+e8AKCzDBoSy/txYtdqJkqXIvcHL1RSCCnhyoN/WvPGnLf
         ZOkQ==
X-Gm-Message-State: AE9vXwNs50FSZtCdi06+rovh7BDJ//TxfiU8E+Xq331YOw4FOmdrOnQEFvlL881aTiRZv7OH
X-Received: by 10.66.197.197 with SMTP id iw5mr51535556pac.130.1475008822899;
        Tue, 27 Sep 2016 13:40:22 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:3959:5f82:1885:1644])
        by smtp.gmail.com with ESMTPSA id xv9sm6933306pab.36.2016.09.27.13.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 13:40:21 -0700 (PDT)
Date:   Tue, 27 Sep 2016 13:40:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4 v4] ls-files: add pathspec matching for submodules
Message-ID: <20160927204020.GC32565@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1474930003-83750-5-git-send-email-bmwill@google.com>
 <xmqq1t05nmcs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1t05nmcs.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > -	/* Find common prefix for all pathspec's */
> > -	max_prefix = common_prefix(&pathspec);
> > +	/*
> > +	 * Find common prefix for all pathspec's
> > +	 * This is used as a performance optimization which unfortunately cannot
> > +	 * be done when recursing into submodules
> > +	 */
> > +	if (recurse_submodules)
> > +		max_prefix = NULL;
> > +	else
> > +		max_prefix = common_prefix(&pathspec);
> >  	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
> 
> I still wonder if we can do better than this, as this would be a big
> cycle-saver especially in recurse-submodules case.
> 
> When you get max_prefix that is "a/b/c", there are three cases:
> 
>  * a/b/c is a path prefix for an entry in the index, e.g. a/b/c/d;
>    you then can safely use it and you do not have to do any
>    recursive invocation of ls-files outside "a/b/c".  You may match
>    a/b/c/d in the toplevel, or you may recurse a/b/c/e that is a
>    submodule, but you won't have to pay attention to submodules
>    outside.
> 
>  * a leading path of a/b/c, e.g. a/b, is a gitlink or a blob in the
>    index; you can use a/b and you only have to recurse into a/b if
>    that is a submodule; if a/b is a blob, you'd show nothing.
> 
>  * a/b/c itself and no leading path of it appears in the index; you
>    know that nothing will match once you know that you are in this
>    situation.
> 
> Because a gitlink "a/b" sorts at the same location in the index as a
> regular blob "a/b" would, by feeding the max_prefix common_prefix()
> gives you (i.e. "a/b/c") to index_name_pos() to see which one of the
> three situations you are in can be done fairly cheaply, I would
> think.  The index_name_pos() call may find "a/b/c" exactly (case 1),
> or return a location where "a/b/c" would be inserted in the list of
> existing entries.  If there were "a/b" (or "a") in the index, there
> wouldn't be any "a/b/x" (or "a/x") at the same time, so a query for
> "a/b/c" would land you next to (just after) an existing entry that
> is a leading path of it, if such an entry exists, no?  That would
> allow you to tell case 2 above fairly cheaply, I would expect.
> 
> It is a separate issue if adding that support to 4/4 is a good idea;
> I personally think doing it as a separate follow-up patch would make
> more sense, so all of the above is tangent.

I agree that this could be a big cycle saver. At the present I was
working towards getting a working implementation but this should
definitely be addressed in a follow-up patch to introduce the
optimization to the recurse-submodule mode.  It hopefully wouldn't be
too hard to implement seeing as its using string literals.

-- 
Brandon Williams
