Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B668920248
	for <e@80x24.org>; Fri,  1 Mar 2019 13:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbfCANsC (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 08:48:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:34276 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387620AbfCANsC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 08:48:02 -0500
Received: (qmail 11744 invoked by uid 109); 1 Mar 2019 13:48:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 13:48:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29747 invoked by uid 111); 1 Mar 2019 13:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 08:48:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 08:48:00 -0500
Date:   Fri, 1 Mar 2019 08:47:59 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Manuel Guilamo <manuel.guilamo@publicis.com.do>,
        git@vger.kernel.org
Subject: Re: Prevent reset --hard from deleting everything if one doesn't
 have any commits yet
Message-ID: <20190301134759.GA13402@sigill.intra.peff.net>
References: <15568DDA-F501-48C9-A1C0-97C72C29DA23@publicis.com.do>
 <d1b34077-1c0e-7a2a-d2c7-da013dd56cd9@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1b34077-1c0e-7a2a-d2c7-da013dd56cd9@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 07:56:00AM +0100, Johannes Sixt wrote:

> Am 28.02.19 um 22:43 schrieb Manuel Guilamo:
> > I accidentally executed git reset —hard in a project that doesn’t
> > have any commits yet. git erased everything, everything I’ve worked
> > the past week, I believe this is not a desired behavior, considering
> > I’m not able to undo that action, because git doesn’t have any
> > history whatsoever.
> 
> I tested this, and it does not happen for me as long as I do not `git
> add` anything.
> 
> So, I assume you did `git add` your content and then you did a `git
> reset --hard`. In that case, I'm afraid Git behaved as designed and
> "doesn't have any commits" is a red herring.

Wouldn't that mean all of the file data is available in the object
database? Unfortunately without an index, there's nothing to mark which
file was which. But `git fsck --lost-found` should copy out all of the
file content into .git/lost-found.

-Peff
