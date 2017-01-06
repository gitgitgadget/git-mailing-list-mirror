Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3694D205C9
	for <e@80x24.org>; Fri,  6 Jan 2017 04:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754752AbdAFERL (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 23:17:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:35815 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdAFERJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 23:17:09 -0500
Received: (qmail 12712 invoked by uid 109); 6 Jan 2017 04:15:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 04:15:44 +0000
Received: (qmail 14277 invoked by uid 111); 6 Jan 2017 04:16:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Jan 2017 23:16:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jan 2017 23:15:41 -0500
Date:   Thu, 5 Jan 2017 23:15:41 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] fixing some random blame corner cases
Message-ID: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are three fixes for some fairly obscure corner cases. I haven't
actually seen these in the wild. I came up with the final one while
discussing a hypothetical with somebody, then ran across the middle one
while trying to write a test for the third, which made me scratch my
head enough to yield the first one. Classic yak-shaving.

One other thing that surprised me while writing blame tests is that
"--root" is not the default for git-blame (though it has been for many
years in git-log). I'm not sure if it would be a good idea to change it,
or if blame is too plumbing-ish to allow that.

  [1/3]: blame: fix alignment with --abbrev=40
  [2/3]: blame: handle --no-abbrev
  [3/3]: blame: output porcelain "previous" header for each file

 builtin/blame.c             |  27 ++++++----
 t/t8002-blame.sh            |  32 ++++++++++++
 t/t8011-blame-split-file.sh | 117 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 10 deletions(-)
 create mode 100755 t/t8011-blame-split-file.sh

-Peff
