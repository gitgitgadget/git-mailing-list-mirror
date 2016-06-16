Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1BB1FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbcFPJcy (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:32:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:55505 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750902AbcFPJcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:32:51 -0400
Received: (qmail 9808 invoked by uid 102); 16 Jun 2016 09:32:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:32:51 -0400
Received: (qmail 14355 invoked by uid 107); 16 Jun 2016 09:33:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:33:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 05:32:48 -0400
Date:	Thu, 16 Jun 2016 05:32:48 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] gpg-interface cleanups
Message-ID: <20160616093248.GA15130@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This started off with Michael's patch to sign_buffer, which is at the
tip, and then me trying to address the possible deadlocks there and in
verify_signed_buffer. While I was in the area, I took the opportunity to
do a few cleanups.

It's unclear to me whether the deadlocks are possible in practice; see
patch 5 for discussion. My guess is probably not, but the amount of code
to support doing it right is not all that much. But if we don't like it,
we can drop 4-6.

Patch 7 is still authored by Michael, but has been massaged greatly by
me. I'll comment more directly on the changes there.

  [1/7]: gpg-interface: use child_process.args
  [2/7]: verify_signed_buffer: drop pbuf variable
  [3/7]: verify_signed_buffer: use tempfile object
  [4/7]: run-command: add pipe_command helper
  [5/7]: verify_signed_buffer: use pipe_command
  [6/7]: sign_buffer: use pipe_command
  [7/7]: gpg-interface: check gpg signature creation status
