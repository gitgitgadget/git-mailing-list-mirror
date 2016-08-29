Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49DDB1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 18:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754719AbcH2SaV (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 14:30:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:34947 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754207AbcH2SaU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 14:30:20 -0400
Received: (qmail 3122 invoked by uid 109); 29 Aug 2016 18:30:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Aug 2016 18:30:19 +0000
Received: (qmail 22255 invoked by uid 111); 29 Aug 2016 18:30:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Aug 2016 14:30:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2016 14:30:15 -0400
Date:   Mon, 29 Aug 2016 14:30:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] gitk: align the commit summary format to the
 documentation
Message-ID: <20160829183015.2uqnfezekjfa3ott@sigill.intra.peff.net>
References: <1472230741-5161-1-git-send-email-dev+git@drbeat.li>
 <xmqqoa4fgzhv.fsf@gitster.mtv.corp.google.com>
 <a9731f60-5c30-0bc6-f73a-f7ffb7bd4231@kdbg.org>
 <xmqqpoorbftc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpoorbftc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 11:17:19AM -0700, Junio C Hamano wrote:

> > While it may be easier to read due to the extra mark-up, the resulting
> > text where such a quotation appears does not flow well, IMO. A commit
> > message text that references another commit reads more fluently
> > without the quotes around the summary line because the quoted text is
> > not so much a quotation that must be marked, but a parenthetical
> > statement.
> >
> > I absolutely welcome the proposed change to gitk, because I always
> > edit out the double-quotes.
> 
> I think that is highly subjective, and as you very well may know,
> I've been referring to commits without double-quote pair, and have
> an obvious bias for something I am used to ;-)
> 
> I do not see the "" as introducing a quotation.  I just view it as
> very similar to the "" in the following sentence:
> 
>     The commit whose title is "foo bar" did not consider there is
>     also need to consider baz.
> 
> The whole thing is inside () pair, so I agree that with or without
> "" pair, it is possible to see where the title ends.  So I do not
> have a strong opinion either way.

I have an alias which produces similar output, without the double-quotes
(probably because I stole it from you originally).

I have noticed over the years that the output is occasionally ugly when
the commit names have parentheses themselves. E.g.:

  $ git config alias.ll
  !git --no-pager log -1 --pretty='tformat:%h (%s, %ad)' --date=short

  $ git ll 7e97e10
  7e97e10 (die(_("BUG")): avoid translating bug messages, 2016-07-26)

  $ git ll fa90ab4
  fa90ab4 (t3404: fix a grammo (commands are ran -> commands are run), 2016-06-29)

Adding quotes can help with that. OTOH, I think it just introduces the
same problem with a different character. E.g.:

  $ git ll be00b57
  be00b57 (provide an initializer for "struct object_info", 2016-08-11)

  $ git llq be00b57
  be00b57 ("provide an initializer for "struct object_info"", 2016-08-11)

Perhaps one could write a script to find a custom pretty non-conflicting
delimiter for each case, but I don't know if it's worth the effort. :)

-Peff
