Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8AD1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfFSVYO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:24:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:44764 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbfFSVYO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:24:14 -0400
Received: (qmail 12869 invoked by uid 109); 19 Jun 2019 21:20:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 21:20:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10034 invoked by uid 111); 19 Jun 2019 21:25:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 17:25:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 17:24:12 -0400
Date:   Wed, 19 Jun 2019 17:24:12 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] rev-list: teach --oid-only to enable piping
Message-ID: <20190619212411.GB6571@sigill.intra.peff.net>
References: <20190607225900.89299-1-emilyshaffer@google.com>
 <20190613215102.44627-1-emilyshaffer@google.com>
 <20190614160728.GA30083@sigill.intra.peff.net>
 <20190614232946.GF233791@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614232946.GF233791@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 04:29:46PM -0700, Emily Shaffer wrote:

> On Fri, Jun 14, 2019 at 12:07:28PM -0400, Jeff King wrote:
> > On Thu, Jun 13, 2019 at 02:51:03PM -0700, Emily Shaffer wrote:
> 
> > > +test_expect_success 'rev-list --objects --oid-only is usable by cat-file' '
> > > +	git rev-list --objects --oid-only --all >list-output &&
> > > +	git cat-file --batch-check <list-output >cat-output &&
> > > +	! grep missing cat-output
> > > +'
> > 
> > Usually we prefer to look for the expected output, rather than making
> > sure we did not find the unexpected. But I'm not sure if that might be
> > burdensome in this case (i.e., if there's a bunch of cruft coming out of
> > "rev-list" that would be annoying to match, and might even change as
> > people add more tests). So I'm OK with it either way.
> 
> My (newbie) opinion is that in this case, we specifically want to know
> that cat-file didn't choke on objects which we know exist (since they
> came from rev-list). I have the feeling that checking for the exact
> objects returned instead (or a sample of them) would be more brittle and
> would also make the wording of the test less direct.
> 
> So if there's no complaint either way, I'd prefer to leave it the way it
> is.

Yeah, that's fine with me if it seems more clear to use grep here (and I
was on the fence).

> By the way, rev-list-misc.sh has a number of other existing "! grep ..."
> lines.

It never fails that when I complain about a style issue, the surrounding
code is full of the same thing. ;) I'd have to look at each one to
determine if they're sensible or not, and it's probably not worth
anybody's time to do that cleanup at this point in time.

-Peff
