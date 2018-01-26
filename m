Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FFA1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeAZTZs (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:25:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:59188 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752623AbeAZTZf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 14:25:35 -0500
Received: (qmail 19081 invoked by uid 109); 26 Jan 2018 19:25:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jan 2018 19:25:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18082 invoked by uid 111); 26 Jan 2018 19:26:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Jan 2018 14:26:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jan 2018 14:25:33 -0500
Date:   Fri, 26 Jan 2018 14:25:33 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] t: make 'test_i18ngrep' more informative on failure
Message-ID: <20180126192532.GA29438@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180126123708.21722-11-szeder.dev@gmail.com>
 <20180126185007.GG27618@sigill.intra.peff.net>
 <CAM0VKj=Qsbkog+rj94bZOk=G-XBsXAqQnRUo4eCXQq2LKjre-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=Qsbkog+rj94bZOk=G-XBsXAqQnRUo4eCXQq2LKjre-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 08:23:24PM +0100, SZEDER Gábor wrote:

> On Fri, Jan 26, 2018 at 7:50 PM, Jeff King <peff@peff.net> wrote:
> > On Fri, Jan 26, 2018 at 01:37:08PM +0100, SZEDER Gábor wrote:
> >
> >> When 'test_i18ngrep' can't find the expected pattern, it exits
> >> completely silently; when its negated form does find the pattern that
> >> shouldn't be there, it prints the matching line(s) but otherwise exits
> >> without any error message.  This leaves the developer puzzled about
> >> what could have gone wrong.
> >>
> >> Make 'test_i18ngrep' more informative on failure by printing an error
> >> message including the invoked 'grep' command and the contents of the
> >> file it had to scan through.
> >
> > I think this is an improvement. You can also use "-x" to get a better
> > sense of exactly which command failed,
> 
> Yeah, I know...  but I have some issues with running tests with '-x'; I
> suspect PEBKAC, but haven't yet got around to investigate.

Some tests absolutely fail with "-x", due to them caring about the
stderr output of shell functions. But with the BASH_XTRACEFD stuff, if
you run suite under bash it should al Just Work (and I recently added
TEST_SHELL_PATH to use bash just for the test suite without building all
of the scripts with it).

-Peff
