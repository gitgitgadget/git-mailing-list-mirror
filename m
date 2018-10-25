Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098BF1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 21:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJZFqX (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 01:46:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:54966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726387AbeJZFqX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 01:46:23 -0400
Received: (qmail 9573 invoked by uid 109); 25 Oct 2018 21:12:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Oct 2018 21:12:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22650 invoked by uid 111); 25 Oct 2018 21:11:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Oct 2018 17:11:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2018 17:12:04 -0400
Date:   Thu, 25 Oct 2018 17:12:04 -0400
From:   Jeff King <peff@peff.net>
To:     steadmon@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5] archive: initialize archivers earlier
Message-ID: <20181025211203.GA23050@sigill.intra.peff.net>
References: <39a4e7bf8f3ebc5803393f357d1ee7dc9806252f.1540251936.git.steadmon@google.com>
 <c85673cee76c1c4a7e2b2a489d6139f5c89ba88c.1540499413.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c85673cee76c1c4a7e2b2a489d6139f5c89ba88c.1540499413.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 01:32:14PM -0700, steadmon@google.com wrote:

> Initialize archivers as soon as possible when running git-archive.
> Various non-obvious behavior depends on having the archivers
> initialized, such as determining the desired archival format from the
> provided filename.
> 
> Since 08716b3c11 ("archive: refactor file extension format-guessing",
> 2011-06-21), archive_format_from_filename() has used the registered
> archivers to match filenames (provided via --output) to archival
> formats. However, when git-archive is executed with --remote, format
> detection happens before the archivers have been registered. This causes
> archives from remotes to always be generated as TAR files, regardless of
> the actual filename (unless an explicit --format is provided).
> 
> This patch fixes that behavior; archival format is determined properly
> from the output filename, even when --remote is used.

Thanks, this version looks great to me!

-Peff
