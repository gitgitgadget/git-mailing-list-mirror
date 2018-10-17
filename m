Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930581F453
	for <e@80x24.org>; Wed, 17 Oct 2018 08:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeJQQdq (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 12:33:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:43204 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726112AbeJQQdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 12:33:46 -0400
Received: (qmail 16472 invoked by uid 109); 17 Oct 2018 08:39:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 08:39:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18203 invoked by uid 111); 17 Oct 2018 08:38:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 04:38:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 04:39:07 -0400
Date:   Wed, 17 Oct 2018 04:39:07 -0400
From:   Jeff King <peff@peff.net>
To:     Tao Qingyun <taoqy@ls-a.me>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] builtin/branch.c: remove useless branch_get
Message-ID: <20181017083906.GC31932@sigill.intra.peff.net>
References: <20181015171707.GB1301@sigill.intra.peff.net>
 <20181016145428.2901-1-taoqy@ls-a.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181016145428.2901-1-taoqy@ls-a.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 10:54:28PM +0800, Tao Qingyun wrote:

> branch_get sometimes returns current_branch, which can be NULL (e.g., if
> you're on a detached HEAD). Try:
> 
>   $ git branch HEAD
>   fatal: no such branch 'HEAD'
> 
>   $ git branch ''
>   fatal: no such branch ''
> 
> However, it seems weird that we'd check those cases here (and provide
> such lousy messages). And indeed, dropping that and letting us
> eventually hit create_branch() gives a much better message:
> 
>   $ git branch HEAD
>   fatal: 'HEAD' is not a valid branch name.
> 
>   $ git branch ''
>   fatal: '' is not a valid branch name.

This explanation is perfect, of course. ;)

I still wondered if you had another motivation hinted at in your
original mail, though (some weirdness with running branch_get early).
It's OK if there isn't one, but I just want to make sure we capture all
of the details.

Other than that question, the patch looks good to me.

-Peff
