Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBBEC64EDA
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 21:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355373AbjHQVjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355426AbjHQVjM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 17:39:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438FF3AA2
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 14:39:04 -0700 (PDT)
Received: (qmail 31009 invoked by uid 109); 17 Aug 2023 21:39:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Aug 2023 21:39:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1769 invoked by uid 111); 17 Aug 2023 21:39:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Aug 2023 17:39:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Aug 2023 17:39:02 -0400
From:   Jeff King <peff@peff.net>
To:     Patrik =?utf-8?B?SMOkZ2dsdW5k?= <patrik.h.hagglund@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: clone (single) commit id?
Message-ID: <20230817213902.GA3036503@coredump.intra.peff.net>
References: <CABtpZSGcL8hkk3HA3ECtt7KeLPOhuB0n7EKN1Tg5ZHpFBE0V0A@mail.gmail.com>
 <20230817195641.GD3032779@coredump.intra.peff.net>
 <CABtpZSFT2BLJpeDwizZiXB8+tRRLqz+iAFuWaXAiwH_EgS5gag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABtpZSFT2BLJpeDwizZiXB8+tRRLqz+iAFuWaXAiwH_EgS5gag@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2023 at 10:20:20PM +0200, Patrik Hägglund wrote:

> As said, I want to use a commit id for reproducability and
> performance. The CI flow starts several jobs, all using the same
> commit id. A remote branch may be updated, and therefore considered
> not good (reproducible) enough as the reference here.

Oh, sorry, I didn't realize that was the sticking point. No, sadly I
don't think there is any way to feed a direct oid to clone currently.
Clone does know how to end up on a detached HEAD (e.g., if you specify a
tag with "--branch"). IMHO that would be a useful feature to learn, but
I think most folks resort to init+fetch, since it's most often useful in
scripted situations (like CI) anyway.

-Peff
