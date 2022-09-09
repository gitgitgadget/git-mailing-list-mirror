Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D45EECAAD5
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 02:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIICWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 22:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIICWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 22:22:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A075B0885
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 19:22:00 -0700 (PDT)
Received: (qmail 29718 invoked by uid 109); 9 Sep 2022 02:22:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Sep 2022 02:22:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27507 invoked by uid 111); 9 Sep 2022 02:22:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 22:22:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 22:21:58 -0400
From:   Jeff King <peff@peff.net>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        derrickstolee@github.com
Subject: Re: [PATCH] builtin/mv.c: fix possible segfault in add_slash()
Message-ID: <YxqjRphSqOHbBzGz@coredump.intra.peff.net>
References: <20220908230223.239970-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220908230223.239970-1-shaoxuan.yuan02@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2022 at 04:02:23PM -0700, Shaoxuan Yuan wrote:

> The purpose of add_slash() is adding a slash to the end of a string to
> construct a directory path. And, because adding a slash to an empty
> string is of no use here, and checking the string value without checking
> it is non-empty leads to segfault, we should make sure the length of the
> string is positive to solve both problems.

Thanks for picking this up. I had forgotten about it.

The patch looks obviously fine to me from the perspective of stopping
the segfault. I'll take your "of no use here" as a given, not being
familiar with the subtleties of mv's path handling. :) Assuming that's
correct, then everything looks good to me.

-Peff
