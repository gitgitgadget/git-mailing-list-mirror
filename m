Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6401F404
	for <e@80x24.org>; Tue, 13 Mar 2018 21:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeCMVk1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 17:40:27 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:45008 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeCMVk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 17:40:26 -0400
Received: by mail-pf0-f182.google.com with SMTP id m68so463552pfm.11
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ftil5vRwrldtugOIhS3lGD5eOiTMW5dpTx9SDYHN6Qw=;
        b=K1mvm3WVn7FYxN9plHN01eQqFFlFrO6aeiD6A4m6UHiDDOuwD0VPExcCFkubf8Y9db
         dRNpmkhzGBq+youSPLtPA9VBSkprm/tDYmctc8Pw2uavr2/fbWEZIxZ01AMhzftkxX8W
         x3EzoJgjnuGBySTjtVQixTSO1m6xaTrzMOaS4bC1o5RDqlfZEouSZoMlofsJS/jP3xre
         9IZQGNR7EmfGtc9ljNjlEEGEd51EeQttIDn+37FISVrE5TKbrHN6aQSNJxFu8DzJX5pH
         nFYmrS1L+HHZs0nZLuvFNi77gLH185cI72qvbtnjs836Nk5exSMIfZPSZYzTdEV3xMN1
         t+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ftil5vRwrldtugOIhS3lGD5eOiTMW5dpTx9SDYHN6Qw=;
        b=HBxN/oNnw7ewwsLHdMG3YlPdmuKbILEvm9b4nZYL7Z9UPdVocZExSNRHNlgeom3Gbm
         Y9+l0G5IvpdJvtjJR6NrrlmpTcivb8c/sKDDp9tZh5m76CkGlfA5aP7N2IMGvOdS75Ro
         o/jCo7mDs7QlDAHKcXnT3G5AAkxc770P7NHCDJQk5gqCOuO/c7g2B+Ns9eN29XDe0/Gi
         2gAQi56XHFob7vB76UUNZjaa4pAfr3TwRnXsbOcazgFZCdA1bDLz+w74pdmE27xwhnyq
         JAR/yhEwJ9dNwDeqgFrGAby4aDsZYmaQG3w0aGDElr3jEi7igtCJws/oFPCvIl+y2mhT
         TKKA==
X-Gm-Message-State: AElRT7EnhOfK1rhlFBnQPWjQu413YOkpPIPoQErScPhLNdrGsdKyEnsU
        ZDUKVtIFNWpcWfCj2s9qohmWOA==
X-Google-Smtp-Source: AG47ELvwTX+au8/NlSDqDyCEZgCgtH9W03mPfrOsRjRnAPXRSfMIC2P7yxe9O764xBCJh79bAvwGlw==
X-Received: by 10.101.76.71 with SMTP id l7mr1701131pgr.192.1520977225833;
        Tue, 13 Mar 2018 14:40:25 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p14sm1534295pgu.44.2018.03.13.14.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 14:40:25 -0700 (PDT)
Date:   Tue, 13 Mar 2018 14:40:24 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 12/35] serve: introduce git-serve
Message-ID: <20180313214024.GF7638@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-13-bmwill@google.com>
 <xmqq4llyciq8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4llyciq8.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > + Capabilities
> > +~~~~~~~~~~~~~~
> > +
> > +There are two different types of capabilities: normal capabilities,
> > +which can be used to to convey information or alter the behavior of a
> > +request, and commands, which are the core actions that a client wants to
> > +perform (fetch, push, etc).
> > +
> > +All commands must only last a single round and be stateless from the
> > +perspective of the server side.  All state MUST be retained and managed
> > +by the client process.  This permits simple round-robin load-balancing
> > +on the server side, without needing to worry about state management.
> > +
> > +Clients MUST NOT require state management on the server side in order to
> > +function correctly.
> 
> This somehow feels a bit too HTTP centric worldview that potentially
> may penalize those who do not mind stateful services.

It's meant to be that way so that we don't run into the same issue we
have with the current HTTP transport.  Though I've decided to loosen
this slightly by making protocol v2 stateless by default unless a
capability is advertised and requested by the client indicating that
state can be maintained by the server.  That leaves the door open for
adding state later for transports which have full-duplex connections
while still requiring that stateless is designed first.  I'm kind of
hoping we never need to add state to the protocol because hopefully we
can figure out how to improve negotiation as a whole.

> 
> > + agent
> > +-------
> > +
> > +The server can advertise the `agent` capability with a value `X` (in the
> > +form `agent=X`) to notify the client that the server is running version
> > +`X`.  The client may optionally send its own agent string by including
> > +the `agent` capability with a value `Y` (in the form `agent=Y`) in its
> > +request to the server (but it MUST NOT do so if the server did not
> > +advertise the agent capability).
> 
> Are there different degrees of permissiveness between "The server
> CAN" and "The client MAY" above, or is the above paragraph merely
> being fuzzy?

I don't think so? I believe I ripped this from the existing description
of the agent capability from the current protocol.

-- 
Brandon Williams
