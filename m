Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7021C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 20:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiI0UB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 16:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiI0UB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 16:01:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522861D928F
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 13:00:46 -0700 (PDT)
Received: (qmail 481 invoked by uid 109); 27 Sep 2022 20:00:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Sep 2022 20:00:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22103 invoked by uid 111); 27 Sep 2022 20:00:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Sep 2022 16:00:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Sep 2022 16:00:44 -0400
From:   Jeff King <peff@peff.net>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2] tmp-objdir: skip clean up when handling a signal
Message-ID: <YzNWbGomhzI/fFMx@coredump.intra.peff.net>
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
 <pull.1348.v2.git.git.1664306341425.gitgitgadget@gmail.com>
 <YzNRMbaM40i/6tPa@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzNRMbaM40i/6tPa@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2022 at 03:38:26PM -0400, Jeff King wrote:

> > Since we can't do the cleanup in a portable and signal-safe way, skip
> > the cleanup when we're handling a signal.
> 
> Thanks, this looks fine to me, though I think there are a few extra
> cleanup opportunities that could be squashed in:

> -static int tmp_objdir_destroy_1(struct tmp_objdir *t)
> +static int tmp_objdir_destroy(struct tmp_objdir *t)

Whoops, you'd obviously want to drop the "static" here, as well.

-Peff
