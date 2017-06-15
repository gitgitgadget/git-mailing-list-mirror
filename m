Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E272B20401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbdFOVKv (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:10:51 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:46442 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbdFOVKv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:10:51 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1dLc23-0002TY-0i; Fri, 16 Jun 2017 06:10:23 +0900
Date:   Fri, 16 Jun 2017 06:10:22 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
Message-ID: <20170615211022.vmedlcwmvtdiseqx@glandium.org>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
 <20170306182423.GB183239@google.com>
 <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
 <20170615110518.ordr43idf2jluips@glandium.org>
 <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 09:01:45AM -0400, Jeff King wrote:
> On Thu, Jun 15, 2017 at 08:05:18PM +0900, Mike Hommey wrote:
> 
> > On Thu, Jun 15, 2017 at 12:30:46PM +0200, Johannes Schindelin wrote:
> > > Footnote *1*: SHA-256, as all hash functions whose output is essentially
> > > the entire internal state, are susceptible to a so-called "length
> > > extension attack", where the hash of a secret+message can be used to
> > > generate the hash of secret+message+piggyback without knowing the secret.
> > > This is not the case for Git: only visible data are hashed. The type of
> > > attacks Git has to worry about is very different from the length extension
> > > attacks, and it is highly unlikely that that weakness of SHA-256 leads to,
> > > say, a collision attack.
> > 
> > What do the experts think or SHA512/256, which completely removes the
> > concerns over length extension attack? (which I'd argue is better than
> > sweeping them under the carpet)
> 
> I don't think it's sweeping them under the carpet. Git does not use the
> hash as a MAC, so length extension attacks aren't a thing (and even if
> we later wanted to use the same algorithm as a MAC, the HMAC
> construction is a well-studied technique for dealing with it).

AIUI, length extension does make brute force collision attacks (which,
really Shattered was) cheaper by allowing one to create the collision
with a small message and extend it later.

This might not be a credible thread against git, but if we go by that
standard, post-shattered Sha-1 is still fine for git. As a matter of
fact, MD5 would also be fine: there is still, to this day, no preimage
attack against them.

Mike
