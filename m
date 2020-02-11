Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC2EC352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7438C2086A
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbgBKTqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:46:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:57800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728748AbgBKTqm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 14:46:42 -0500
Received: (qmail 9349 invoked by uid 109); 11 Feb 2020 19:46:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Feb 2020 19:46:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1379 invoked by uid 111); 11 Feb 2020 19:55:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 14:55:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 14:46:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eyal Soha <shawarmakarma@gmail.com>
Subject: Re: [PATCH v3 1/3] color.c: refactor color_output arguments
Message-ID: <20200211194640.GA2127797@coredump.intra.peff.net>
References: <20200121165623.151880-1-shawarmakarma@gmail.com>
 <20200211193625.231492-1-gitster@pobox.com>
 <20200211193625.231492-2-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211193625.231492-2-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 11:36:23AM -0800, Junio C Hamano wrote:

> +enum {
> +	COLOR_BACKGROUND_OFFSET = 10,
> +	COLOR_FOREGROUND_ANSI = 30,
> +	COLOR_FOREGROUND_RGB = 38,
> +	COLOR_FOREGROUND_256 = 38,
> +};

I had to double-check to make sure the duplication in the last two
wasn't a bug. It's correct, because "38" here is really "set the
foreground color", and they're followed by more magic for "256" or
"RGB".

So really this could be a single COLOR_FOREGROUND_EXTENDED or similar
that gets used in both places. But I don't know that it really matters
that much.

Other than that nitpick, the patches all looked OK to me. Thanks for
tying up this loose end.

-Peff
