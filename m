Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37DED1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 13:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeHCPB0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 11:01:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:41660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729924AbeHCPB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 11:01:26 -0400
Received: (qmail 2140 invoked by uid 109); 3 Aug 2018 13:05:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Aug 2018 13:05:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1351 invoked by uid 111); 3 Aug 2018 13:05:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 Aug 2018 09:05:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2018 09:05:09 -0400
Date:   Fri, 3 Aug 2018 09:05:09 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, gitster@pobox.com,
        sunshine@sunshineco.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] config: document git config getter return value.
Message-ID: <20180803130509.GB4671@sigill.intra.peff.net>
References: <20180802121308.17371-1-hanwen@google.com>
 <20180802121308.17371-2-hanwen@google.com>
 <20180803032948.GG197924@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180803032948.GG197924@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 08:29:48PM -0700, Jonathan Nieder wrote:

> (cc-ing peff, config whiz)

Actually, this is all about the configset caching layer, which I never
really worked on. This is mostly from Tanay Abhra <tanayabh@gmail.com>,
who was a GSoC student mentored by Matthieu Moy <Matthieu.Moy@imag.fr>.

That said...

> > +
> > +/*
> > + * These functions return 1 if not found, and 0 if found, leaving the found
> > + * value in the 'dest' pointer.
> > + */
> > +extern int git_configset_add_file(struct config_set *cs, const char *filename);
> 
> This function doesn't take a 'dest' argument.  Is the comment meant to
> apply to it?  If not, can the comment go below it?

This is returning the value of git_config_from_file(), which is 0/-1. I
think it should be left where it is in the original, and not part of
this block of functions.

Other than that, the patch seems sane to me (I think the 0/1 return
value from these "get" functions is unnecessarily inconsistent with the
rest of Git, but changing it would be a pain. Documenting it is at least
a step forward).

-Peff
