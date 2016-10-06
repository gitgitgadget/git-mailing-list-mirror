Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17094207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 16:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942299AbcJFQr2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 12:47:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:53477 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942309AbcJFQr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 12:47:27 -0400
Received: (qmail 22325 invoked by uid 109); 6 Oct 2016 16:47:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 16:47:26 +0000
Received: (qmail 29499 invoked by uid 111); 6 Oct 2016 16:47:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 12:47:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2016 12:47:24 -0400
Date:   Thu, 6 Oct 2016 12:47:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] fix infinite loop in ref resolution
Message-ID: <20161006164723.ocg2nbgtulpjcksp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes an infinite loop bug dating back to the v1.8.x era.
Triggering it requires creating a broken symbolic link in the .git
directory, so I don't think it's security-interesting. It should apply
cleanly on "maint".

  [1/2]: files_read_raw_ref: avoid infinite loop on broken symlinks
  [2/2]: files_read_raw_ref: prevent infinite retry loops in general

 refs/files-backend.c        | 14 +++++++++++++-
 t/t1503-rev-parse-verify.sh |  5 +++++
 2 files changed, 18 insertions(+), 1 deletion(-)
