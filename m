Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068AF1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 13:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbcJENHR (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 09:07:17 -0400
Received: from port70.net ([81.7.13.123]:43598 "EHLO port70.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbcJENHG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 09:07:06 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Oct 2016 09:07:06 EDT
Received: by port70.net (Postfix, from userid 1002)
        id 8F39BABEC08A; Wed,  5 Oct 2016 15:01:31 +0200 (CEST)
Date:   Wed, 5 Oct 2016 15:01:31 +0200
From:   Szabolcs Nagy <nsz@port70.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Rich Felker <dalias@libc.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, musl@lists.openwall.com
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
Message-ID: <20161005130130.GM1280@port70.net>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rich Felker <dalias@libc.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, musl@lists.openwall.com
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <20161004173926.GA19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610051250080.35196@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610051250080.35196@virtualbox>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Johannes Schindelin <Johannes.Schindelin@gmx.de> [2016-10-05 13:17:49 +0200]:
> I had a brief look at the source code (you use backtracking... hopefully
> nobody uses musl to parse regular expressions from untrusted, or
> inexperienced, sources [*1*]), and it seems that the regex code might

does git use BRE?

a conforming BRE implementation has to use back tracking
if the pattern has back references.

usually ERE implementations may also use back tracking
since they support back references as an extension.

musl does not support this extension (and many others) so
it never uses back tracking for ERE matches, note however
that match complexity and memory usage of a conforming
ERE implementation is still exponential in pattern
length because of repetition counts.
