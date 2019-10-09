Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866111F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 07:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfJIHmD (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 03:42:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49411 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfJIHmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 03:42:02 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iI6bg-0004Rs-Jq; Wed, 09 Oct 2019 09:42:00 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iI6bg-0004aU-9Y; Wed, 09 Oct 2019 09:42:00 +0200
Date:   Wed, 9 Oct 2019 09:42:00 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        entwicklung@pengutronix.de
Subject: Re: [PATCH v2] range-diff: don't segfault with mode-only changes
Message-ID: <20191009074200.crpjyajbaecaeza6@pengutronix.de>
References: <20191007110645.7eljju2h6g7ts7lf@pengutronix.de>
 <20191007134831.GA74671@cat>
 <20191008173843.GC74671@cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008173843.GC74671@cat>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 08, 2019 at 06:38:43PM +0100, Thomas Gummerer wrote:
> In ef283b3699 ("apply: make parse_git_diff_header public", 2019-07-11)
> the 'parse_git_diff_header' function was made public and useable by
> callers outside of apply.c.
> 
> However it was missed that its (then) only caller, 'find_header' did
> some error handling, and completing 'struct patch' appropriately.
> 
> range-diff then started using this function, and tried to handle this
> appropriately itself, but fell short in some cases.  This in turn
> would lead to range-diff segfaulting when there are mode-only changes
> in a range.
> 
> Move the error handling and completing of the struct into the
> 'parse_git_diff_header' function, so other callers can take advantage
> of it.  This fixes the segfault in 'git range-diff'.
> 
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

This patch also makes git work again for the originally problematic
usecase.

Tested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for your quick reaction to my bug report,
Uwe Kleine-König

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
