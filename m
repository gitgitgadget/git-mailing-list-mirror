Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE8ED1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 04:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbeCCE0B (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 23:26:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:45228 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750775AbeCCE0B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 23:26:01 -0500
Received: (qmail 3104 invoked by uid 109); 3 Mar 2018 04:26:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 04:26:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2900 invoked by uid 111); 3 Mar 2018 04:26:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Mar 2018 23:26:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2018 23:25:59 -0500
Date:   Fri, 2 Mar 2018 23:25:59 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 11/35] test-pkt-line: introduce a packet-line test
 helper
Message-ID: <20180303042558.GB27689@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-12-bmwill@google.com>
 <CAGZ79kbrm2Ei=spoDbjrwVFoF+mi0AAsXNLDBgCozFVoXM6+1w@mail.gmail.com>
 <20180223212231.GC234838@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180223212231.GC234838@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 01:22:31PM -0800, Brandon Williams wrote:

> On 02/22, Stefan Beller wrote:
> > On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:
> > 
> > > +static void pack_line(const char *line)
> > > +{
> > > +       if (!strcmp(line, "0000") || !strcmp(line, "0000\n"))
> > 
> > From our in-office discussion:
> > v1/v0 packs pktlines twice in http, which is not possible to
> > construct using this test helper when using the same string
> > for the packed and unpacked representation of flush and delim packets,
> > i.e. test-pkt-line --pack $(test-pkt-line --pack 0000) would produce
> > '0000' instead of '00090000\n'.
> > To fix it we'd have to replace the unpacked versions of these pkts to
> > something else such as "FLUSH" "DELIM".
> > 
> > However as we do not anticipate the test helper to be used in further
> > tests for v0, this ought to be no big issue.
> > Maybe someone else cares though?
> 
> I'm going to punt and say, if someone cares enough they can update this
> test-helper when they want to use it for v1/v0 stuff.

I recently add packetize and depacketize helpers for testing v0 streams;
see 4414a15002 (t/lib-git-daemon: add network-protocol helpers,
2018-01-24). Is it worth folding these together?

-Peff
