Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D9F1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 23:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeJTHtk (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 03:49:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:47250 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725936AbeJTHtk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 03:49:40 -0400
Received: (qmail 10643 invoked by uid 109); 19 Oct 2018 23:41:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 23:41:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17553 invoked by uid 111); 19 Oct 2018 23:40:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 19:40:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 19:41:26 -0400
Date:   Fri, 19 Oct 2018 19:41:26 -0400
From:   Jeff King <peff@peff.net>
To:     steadmon@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix format detection when archiving remotely
Message-ID: <20181019234126.GA7326@sigill.intra.peff.net>
References: <cover.1539990488.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1539990488.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 04:19:27PM -0700, steadmon@google.com wrote:

> Currently, git-archive does not properly determine the desired archive
> format when both --output and --remote are provided, because
> run_remote_archiver() does not initialize the archivers prior to calling
> archive_format_from_filename(). This results in the remote archiver
> always returning a TAR file, regardless of the requested format.
> 
> This patch initializes the TAR and ZIP archivers before calling
> archive_format_from_filename(), which fixes format detection.

It seems like some of this content could be in the commit message of the
actual patch.

> Steps to reproduce:
> 
> ∫ git version
> git version 2.19.1.568.g152ad8e336-goog
> ∫ cd ~/src/git
> ∫ git archive --output ~/good.zip HEAD
> ∫ file ~/good.zip
> /home/steadmon/good.zip: Zip archive data, at least v1.0 to extract
> ∫ git archive --output ~/bad.zip --remote=. HEAD
> ∫ file ~/bad.zip
> /home/steadmon/bad.zip: POSIX tar archive

And this could be in a test script in the actual patch. :)

-Peff
