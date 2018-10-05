Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589641F453
	for <e@80x24.org>; Fri,  5 Oct 2018 16:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbeJEXTJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 19:19:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:43108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728967AbeJEXTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 19:19:09 -0400
Received: (qmail 18085 invoked by uid 109); 5 Oct 2018 16:19:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 16:19:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12294 invoked by uid 111); 5 Oct 2018 16:19:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 12:19:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 12:19:43 -0400
Date:   Fri, 5 Oct 2018 12:19:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Is there some script to find un-delta-able objects?
Message-ID: <20181005161943.GA8816@sigill.intra.peff.net>
References: <87d0soh3v8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0soh3v8.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 04:20:27PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I.e. something to generate the .gitattributes file using this format:
> 
> https://git-scm.com/docs/gitattributes#_packing_objects
> 
> Some stuff is obvious, like "*.gpg binary -delta", but I'm wondering if
> there's some repo scanner utility to spew this out for a given repo.

I'm not sure what you mean by "un-delta-able" objects. Do you mean ones
where we're not likely to find a delta? Or ones where Git will not try
to look for a delta?

If the latter, I think the only rules are the "-delta" attribute and the
object size. You should be able to use git-check-attr and "git-cat-file"
to get that info.

If the former, I don't know how you would know. We can only report on
what isn't a delta _yet_.

-Peff
