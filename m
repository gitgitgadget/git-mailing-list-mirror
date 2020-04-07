Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21076C2BB54
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 21:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002BE20748
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 21:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDGV6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:58:20 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:46180 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgDGV6U (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Apr 2020 17:58:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B51C6180A733B;
        Tue,  7 Apr 2020 21:58:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crime20_65b1ec1fcad57
X-Filterd-Recvd-Size: 2834
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue,  7 Apr 2020 21:58:18 +0000 (UTC)
Message-ID: <2afc201cea5fd59829ce818041b4290a0ec5bb8c.camel@perches.com>
Subject: Re: get_maintainer.pl sends bogus addresses to git send-email
From:   Joe Perches <joe@perches.com>
To:     Jeff King <peff@peff.net>
Cc:     Olaf Hering <olaf@aepfle.de>, linux-kernel@vger.kernel.org,
        git@vger.kernel.org
Date:   Tue, 07 Apr 2020 14:56:19 -0700
In-Reply-To: <20200407174449.GA1884106@coredump.intra.peff.net>
References: <20200407154046.GA15368@aepfle.de>
         <20200407170257.GA1844923@coredump.intra.peff.net>
         <2e6975d606846c834a387c07ee11cdce52356586.camel@perches.com>
         <20200407174449.GA1884106@coredump.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2020-04-07 at 13:44 -0400, Jeff King wrote:
> On Tue, Apr 07, 2020 at 10:18:41AM -0700, Joe Perches wrote:
> 
> > On Tue, 2020-04-07 at 13:02 -0400, Jeff King wrote:
> > > On Tue, Apr 07, 2020 at 05:40:46PM +0200, Olaf Hering wrote:
> > > 
> > > > For me sending patches via git send-email fails because email address
> > > > conversion is failing. Something appends a ')' to x86/lkml@kernel.org.
> > > > I suspect the double '))' in MAINTAINERS is confusing the command.
> > > > I tried to send the trivial patch from v5.0 and v5.6 tag.
> > > > 
> > > > Is this a failure in ./scripts/get_maintainer.pl,
> > > > or is this something git does internally?
> > > > I'm sure others use such command on a daily basis, so likely something on
> > > > my end became broken at some point in the past.
> > > 
> > > It's a bug in send-email's hand-rolled address parser, which was fixed
> > > in bd869f67b9 (send-email: add and use a local copy of Mail::Address,
> > > 2018-01-05). Upgrade to Git v2.17.0 or newer.
> > 
> > Not really.
> > You need to add --norolestats on the get_maintainer command line
> > 
> > git send-email expects bare email addresses, not ones annotated
> > with additional content.
> 
> I agree that dropping them from the output is even better, if you'd
> never want them to be sent.
> 
> Syntactically they are rfc822 comments, and send-email _should_ be able
> to handle them (and does in recent versions).

I'm not certain that comments are allowed _after_ a tld in an
email address.  In any case, I guess it's a good thing I used
parentheses for the get_maintainer rolestats block.

> > linux-kernel@vger.kernel.org (open list)
> 
> In this one, I think that the comment will be used as the name field,
> since there isn't one.

I think that slightly unexpected as the name field is not required.

cheers, Joe

