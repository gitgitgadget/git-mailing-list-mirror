Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBC141F453
	for <e@80x24.org>; Thu,  2 May 2019 15:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfEBPHD (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 11:07:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:47046 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726268AbfEBPHD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 11:07:03 -0400
Received: (qmail 18691 invoked by uid 109); 2 May 2019 15:07:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 May 2019 15:07:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31522 invoked by uid 111); 2 May 2019 15:07:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 May 2019 11:07:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 May 2019 11:07:01 -0400
Date:   Thu, 2 May 2019 11:07:01 -0400
From:   Jeff King <peff@peff.net>
To:     Aleksey Midenkov <midenok@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
Message-ID: <20190502150701.GA14906@sigill.intra.peff.net>
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
 <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
 <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
 <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com>
 <20190430174110.GA16729@sigill.intra.peff.net>
 <CAF8BazBBP53uhh+oOroFuVCEL-FaqJheSYX5Q5_NQxGRt=g_xA@mail.gmail.com>
 <20190501183638.GF4109@sigill.intra.peff.net>
 <CAF8BazAK_s89XY8-AAsSSbgOFgP03CLRZ50bLGPsc89bfnN7kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF8BazAK_s89XY8-AAsSSbgOFgP03CLRZ50bLGPsc89bfnN7kQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 02, 2019 at 04:45:36PM +0300, Aleksey Midenkov wrote:

> > Assuming that kdevelop is just running "git status" in the background,
> > though, there's an easier solution. If it uses "git --no-optional-locks
> > status" instead, that will instruct it not to take the index lock at
> > all.
> 
> And can we disable optional locks at git configuration level? Because
> changing source code of each application that is not aware of this
> option is not an easier solution.

Since the decision of whether to use the locks is dependent on the
operation being performed, it's an environment variable and not a config
option. You should be able to do:

  GIT_OPTIONAL_LOCKS=0 kdevelop

and any commands run by kdevelop will avoid taking locks when they can
(but for now, the only command which does this is git-status anyway).

-Peff
