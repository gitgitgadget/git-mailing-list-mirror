Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4338207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 19:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425091AbdDUT1x (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 15:27:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:37908 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425057AbdDUT1u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 15:27:50 -0400
Received: (qmail 8121 invoked by uid 109); 21 Apr 2017 17:09:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 17:09:45 +0000
Received: (qmail 17677 invoked by uid 111); 21 Apr 2017 17:10:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 13:10:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 13:09:43 -0400
Date:   Fri, 21 Apr 2017 13:09:43 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
Message-ID: <20170421170943.tj5jcstj3yy27sev@sigill.intra.peff.net>
References: <20170420205214.GB4989@hank>
 <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
 <20170420212436.GC4989@hank>
 <CAP8UFD25tJgQD=bREOG-_q0jCLw-nxhO6pYbOaaYMuAH4VxN3Q@mail.gmail.com>
 <CACsJy8DotVErJjbUBmt9bxu90CSKEsqAT_nYTNXwstEk3YhN2g@mail.gmail.com>
 <CAP8UFD2v-X3KfsvFSQrFvgTWRB7P684qN=DowNK2GunJys1i=Q@mail.gmail.com>
 <CAP8UFD3MJYR6pH2=7pKjBdLY6oUswNdG7eDNp6PdCFz336Y2FQ@mail.gmail.com>
 <CACsJy8ATvRgOZPpy9_SznvFXm5imJNbcqMSAYSw4H633rqRjEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8ATvRgOZPpy9_SznvFXm5imJNbcqMSAYSw4H633rqRjEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 07:25:21PM +0700, Duy Nguyen wrote:

> >> Yeah, you are right.
> >> It looks like we have GIT_TEST_OPTS to pass options like --debug,
> >> --valgrind, --verbose, but we don't have an environment variable to
> >> set config options.
> >
> > Or maybe GIT_CONFIG_PARAMETERS works for this purpose?
> 
> It has to be set inside test-lib.sh, not from outside because
> environment variables from outside are filtered if I remember
> correctly and only a few specials plus those GIT_TEST_ can survive.
> Some tests override GIT_CONFIG_PARAMETERS themselves to pass config
> vars to certain command (I know because I just did a couple days ago
> ;).which loses core.splitIndex.

It does seem reasonable to have a GIT_TEST_REPO_CONFIG that sets some
variables by default in the trash repository created by
test_create_repo.

That doesn't quite catch everything, because a few tests make their own
sub-repos. But those cases are usually testing something very specific
anyway.

-Peff
