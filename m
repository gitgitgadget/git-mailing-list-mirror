Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5351D1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 16:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeIFUyd (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 16:54:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:41306 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726551AbeIFUyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 16:54:33 -0400
Received: (qmail 14136 invoked by uid 109); 6 Sep 2018 16:18:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 16:18:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31505 invoked by uid 111); 6 Sep 2018 16:18:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 12:18:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 12:18:17 -0400
Date:   Thu, 6 Sep 2018 12:18:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Tim Schumacher <timschumi@gmx.de>, git@vger.kernel.org,
        gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH v3] Allow aliases that include other aliases
Message-ID: <20180906161817.GA12705@sigill.intra.peff.net>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180906101658.1865-1-timschumi@gmx.de>
 <87pnxqrags.fsf@evledraar.gmail.com>
 <20180906145708.GA1209@sigill.intra.peff.net>
 <87musur7ar.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87musur7ar.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 05:10:04PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >   seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
> >   if (seen) {
> >           for (i = 0; i < cmd_list.nr; i++) {
> > 		struct string_list *item = cmd_list.items[i];
> >
> > 		strbuf_addf(&sb, "  %s", item->string);
> > 		if (item == seen)
> > 			strbuf_add(&sb, " <==");
> > 		strbuf_addch(&sb, '\n');
> > 	  }
> > 	  /* We never added this to the list, but we were about to */
> > 	  strbuf_addch("  %s\n", seen->string);
> > 	  die(...);
> >   }
> >
> > I guess it's not that far off of yours. Not using words to describe the
> > loop entry and exit points avoids translation, which avoids notes to
> > translators, which is most of what makes your patch long. ;)
> 
> This still needs translation for RTL languages. I.e. they'd want to
> print out the equivalent of "%s " followed by "==> %s ". We happen to
> (unfortunately) not carry such a language yet, but it's worth
> future-proofing output as we add it in case we get one.

I'd have thought even in an RTL language that something like an "I'm
pointing to this" sign wouldn't matter (i.e., an LTR language person,
I'd be fine with either "==> %s" or "%s <=="). But obviously I have no
experience in the matter, so I'd defer to people who read RTL (or at
least have handled i18n for it before).

-Peff
