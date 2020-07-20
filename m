Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1AEC433E1
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BEE22B4E
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 17:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgGTRdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:33:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:33538 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgGTRdi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 13:33:38 -0400
Received: (qmail 23513 invoked by uid 109); 20 Jul 2020 17:33:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Jul 2020 17:33:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14668 invoked by uid 111); 20 Jul 2020 17:33:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Jul 2020 13:33:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Jul 2020 13:33:36 -0400
From:   Jeff King <peff@peff.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] git-send-email: die if sendmail.* config is set
Message-ID: <20200720173336.GC2045458@coredump.intra.peff.net>
References: <20200718202142.111015-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200718202142.111015-1-sir@cmpwn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 18, 2020 at 04:21:42PM -0400, Drew DeVault wrote:

> I've seen several people mis-configure git send-email on their first
> attempt because they set the sendmail.* config options - not
> sendemail.*. This patch detects this mistake and bails out with a
> friendly warning.

This basically claims the "sendmail.*" namespace for send-email. Not
strictly, but if we're going to warn about anything set in it, it
effectively shuts out other uses.

I'm OK with that, but if we're going to do so, should we perhaps just
say "sendmail.* is an alias for sendemail.*"? Then rather than getting a
warning, this mistake would Just Work.

-Peff
