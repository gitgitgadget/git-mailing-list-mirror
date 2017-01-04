Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00BF520754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965205AbdADSNY (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:13:24 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35716 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934001AbdADSNV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:13:21 -0500
Received: by mail-pf0-f169.google.com with SMTP id i88so83074620pfk.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nzSvtOkvygrqo9OfCmaJgDqCkOIE9pw2UN5zhbITEGc=;
        b=MXNEFBqALbC0jYp+7lQyDHNQ1Yg+Ns23JUKSXiegeQurqKQc+eNXAdk3D3Xwa9LfZD
         nb0w3kMt7I/Jmf1qhrEHp22L5Gak2/R9+7GJZcTpDdVbOyGuy4bH5gJuhsy498uql7hc
         HI2OWvW+F4jQazn9fCjY258DfGaPhEdIZWO4kQ8WYLd3qX4pQWbkwNjA0JLfVqZSy//g
         APF+ByGrIUMTmT2pvOZlM1IAFNzcUeQ33Aiqf4i4rrihLMj4EHClgepMGGobWf4uRX5w
         /V/tzlapyO1stDzEnY6pPnzI7IFjLRxdrkHOgUK/m70kRkkqeelMxZG9wys9V0+6iTk7
         dM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nzSvtOkvygrqo9OfCmaJgDqCkOIE9pw2UN5zhbITEGc=;
        b=cBl9/s8PLywT0Ys/tOijadrU/AjcArdxlU32vG9Hh4mmiFBEf8hJhmnyURPh0VlEoz
         OXQXXCeoz4T8owDV3Rt64RLwYdenOrJEm4jNH8oN0PH/YJWpLodzjLj0a53J7FvwWL4n
         Ivi/7HuMIYi4uBCy3bwuFXOp5qxPhEdQaxP5DXlzF5oq4wRApNFxM+dK7iFSLVbHynLt
         yeK2GXguAKrparnKaRdUFZwsFOwHcXnxPsZrEch2rmpHgfyliGDQRfKIMZxTKHve+2M0
         g58Mg6qMKOww/pEea6kK3vhuPEyyZAfvHekJdjH6Wwv6MTl6W/3oDZ2z8w+x+9C0jRLq
         o8oQ==
X-Gm-Message-State: AIkVDXLSmavIpwWyBa0G8dbFZfbkXT1q+OYylaLdocOlviWZkEaj8JwZUGnv0rXOO7oqpIpN
X-Received: by 10.84.143.1 with SMTP id 1mr147598255ply.86.1483553600751;
        Wed, 04 Jan 2017 10:13:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1930:3cb0:6c91:e070])
        by smtp.gmail.com with ESMTPSA id o126sm149873873pga.34.2017.01.04.10.13.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:13:19 -0800 (PST)
Date:   Wed, 4 Jan 2017 10:13:18 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, sbeller@google.com, jacob.keller@gmail.com,
        gitster@pobox.com, ramsay@ramsayjones.plus.com, j6t@kdbg.org,
        pclouds@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v4 0/5] road to reentrant real_path
Message-ID: <20170104181318.GC69227@google.com>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com>
 <20170104004825.3s27dsircdp5lqte@sigill.intra.peff.net>
 <3f9a530c-402f-f276-4721-fa6a8a6fef41@web.de>
 <20170104070107.huse2a6thz737epv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170104070107.huse2a6thz737epv@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04, Jeff King wrote:
> On Wed, Jan 04, 2017 at 07:56:02AM +0100, Torsten Bögershausen wrote:
> 
> > On 04.01.17 01:48, Jeff King wrote:
> > > On Tue, Jan 03, 2017 at 11:09:18AM -0800, Brandon Williams wrote:
> > > 
> > >> Only change with v4 is in [1/5] renaming the #define MAXSYMLINKS back to
> > >> MAXDEPTH due to a naming conflict brought up by Lars Schneider.
> > > 
> > > Hmm. Isn't MAXSYMLINKS basically what you want here, though? It what's
> > > what all other similar functions will be using.
> > > 
> > > The only problem was that we were redefining the macro. So maybe:
> > > 
> > >   #ifndef MAXSYMLINKS
> > >   #define MAXSYMLINKS 5
> > >   #endif
> > > 
> > > would be a good solution?
> > Why 5  ? (looking at the  20..30 below)
> > And why 5 on one system and e.g. on my Mac OS
> > #define MAXSYMLINKS     32  
> 
> I mentioned "5" because that is the current value of MAXDEPTH. I do
> think it would be reasonable to bump it to something higher.
> 
> > Would the same value value for all Git installations on all platforms make sense?
> > #define GITMAXSYMLINKS 20
> 
> I think it's probably more important to match the rest of the OS, so
> that open("foo") and realpath("foo") behave similarly on the same
> system. Though I think even that isn't always possible, as the limit is
> dynamic on some systems.
> 
> I think the idea of the 20-30 range is that it's small enough to catch
> an infinite loop quickly, and large enough that nobody will ever hit it
> in practice. :)

I agree that we should have similar guarantees as the OS provides,
especially if the OS already has MAXSYMLINKS defined.  What then, should
the fall back value be if the OS doesn't have this defined?  5 like we
have done historically, or something around the 20-30 range as Torsten
suggests?

-- 
Brandon Williams
