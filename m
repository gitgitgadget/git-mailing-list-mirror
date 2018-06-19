Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545BE1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 23:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbeFSXOI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 19:14:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34544 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeFSXOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 19:14:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so659319plq.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 16:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F4Y94e7JQ5nreqv372zBQwHprnd7sv5aeFP3A2yhTLU=;
        b=XwVcbJuhqtjLYxQHxix/r7JIrRPNvAI5aKKPqtnkar0S2kVInOuvZzMRpgq+Nv1rWq
         m+eujdcNf9qGvf1kOW0v4XHgjAHrCiAon+1uKXJzMmB1+l+SoBb3e/tGyh34Hs6bkEGg
         cvy6iPxxBgZMf1ldCkQ7tzz2oQ9qh17QpAGCVhuo3CSvddPZHbfjdZrlId+N+P/d3hyR
         KNr/JUB9h2u9AC0CIMSPi6A1ue/alvRf485btrVuxEUHfdtCC9zaoNUhkxRCTLE1JTx3
         rx2Q261VorOMVfCds7D6rCGGhPqxPHbAlVAccC66L/0JW9s0zSmACmTLDVQkfxkrioG7
         tHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F4Y94e7JQ5nreqv372zBQwHprnd7sv5aeFP3A2yhTLU=;
        b=tT88QdDUKrFAiFwlAcapLjxcPeQOZ+Xe4SpKzrMNazgKNdfIw6oatei+TSZb/CpBxw
         34WDS5gEs3f5fzpS+pjwwk4AVqHvI4EwKAh/k/nVl9POoqTDOuEC13wSOXKgspG09Mkb
         KpP1mSqJEOwr+7jaThe2KvbAI5C7UoX4GwnIkpVH0zFibKg0yZtZrTgdKHhYqzqbJ03K
         0QuCwrVMtrMPgM5oCISM4GoqFfLECE8Je7M+6WIhTwQ8dSDRISU0MLVrhLO1mPE92l0j
         j1FFUi2Eykwdc/5WBbB3KRazQoVQm51aNdHbvrqWkVb4+rSqc7U1twxtAhpq/P3mEo7H
         Jelw==
X-Gm-Message-State: APt69E3Yij/Of+cKiDZmcL6Ez+A8tDR0DVMzGH5p4uoWDhcO3ctKQRKm
        DoQsUZoqHi71P0baiqs/V3AUsg==
X-Google-Smtp-Source: ADUXVKKh6G99TE1VGXBMfbvr5H2U6IDjNHj3tYQ7UU4clGKyCdeN86gHyrjAecsrQ/me5mHNB7EQYA==
X-Received: by 2002:a17:902:294a:: with SMTP id g68-v6mr21443770plb.58.1529450046499;
        Tue, 19 Jun 2018 16:14:06 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id g80-v6sm1015169pfd.21.2018.06.19.16.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 16:14:05 -0700 (PDT)
Date:   Tue, 19 Jun 2018 16:14:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 2/8] upload-pack: implement ref-in-want
Message-ID: <20180619231404.GA232723@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
 <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-3-bmwill@google.com>
 <xmqq602jzriy.fsf@gitster-ct.c.googlers.com>
 <20180619185033.GC199585@google.com>
 <xmqqbmc6v7gl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmc6v7gl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/19, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > I also think that we should keep this first implementation of
> > ref-in-want simple and *not* include patterns, even if that's what we
> > may want someday down the road.  Adding a new capability in the future
> > for support of such patterns would be relatively simple and easy.
> 
> I am all for many-small-steps over a single-giant-step approach.
> 
> >  The
> > reason why I don't think we should add pattern support just yet is due
> > to a request for "want-ref refs/tags/*" or a like request resulting in a
> > larger than expected packfile every time "fetch --tags" is run.  The
> > issue being that in a fetch request "refs/tags/*" is too broad of a
> > request and could be requesting 100s of tags when all we really wanted
> > was to get the one or two new tags which are present on the remote
> > (because we already have all the other tags present locally).
> 
> I do not quite get this.  Why does it have to result in a large
> packfile?  Doesn't the requester of refs/tags/* still show what it
> has via "have" exchange?

Sorry Jonathan Tan said it much clearer here:
https://public-inbox.org/git/20180615190458.147775-1-jonathantanmy@google.com/

-- 
Brandon Williams
