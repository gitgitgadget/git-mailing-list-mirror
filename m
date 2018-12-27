Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A5A211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeL0QYU (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:24:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:50266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727086AbeL0QYT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:24:19 -0500
Received: (qmail 20318 invoked by uid 109); 27 Dec 2018 16:24:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Dec 2018 16:24:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8013 invoked by uid 111); 27 Dec 2018 16:23:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Dec 2018 11:23:54 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Dec 2018 11:24:17 -0500
Date:   Thu, 27 Dec 2018 11:24:17 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erin Dahlgren <eedahlgren@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] Simplify handling of setup_git_directory_gently()
 failure cases.
Message-ID: <20181227162417.GA23147@sigill.intra.peff.net>
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
 <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
 <20181218175418.GB31070@sigill.intra.peff.net>
 <CAP_Smy14j4WK-mkqdKTKue=j7YoNjfaZVCBA-7S8xwNqX2rKhQ@mail.gmail.com>
 <20181219155928.GE14802@sigill.intra.peff.net>
 <xmqqftukq66o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftukq66o.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 26, 2018 at 02:22:39PM -0800, Junio C Hamano wrote:

> >> Side note: One of the secondary goals of my patch was to make it
> >> really obvious that neither the GIT_DIR_HIT_CEILING nor the
> >> GIT_DIR_HIT_MOUNT_POINT case can get us into the block protected by
> >> (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)). With
> >> your suggestion (and it's a fair one) I don't think that's feasible
> >> without more significant refactoring. Should I just settle with a
> >> comment that explains this?
> >
> > Yeah, I think a comment would probably be sufficient. Though we could
> > also perhaps make the two cases (i.e., we found a repo or not) more
> > clear. Something like:
> >
> >   if (!*nongit_ok || !*nongit_ok) {
> 
> WTH is (A || A)?

Heh, I should learn to cut and paste better. This should be:

  if (!nongit_ok || !*nongit_ok)

(which comes from the current code).

-Peff
