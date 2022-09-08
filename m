Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B71C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 05:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIHFEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 01:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIHFEs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 01:04:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51BD27CE9
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 22:04:46 -0700 (PDT)
Received: (qmail 24616 invoked by uid 109); 8 Sep 2022 05:04:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 05:04:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17954 invoked by uid 111); 8 Sep 2022 05:04:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 01:04:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 01:04:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [PATCH 2/3] upload-pack: skip parse-object re-hashing of "want"
 objects
Message-ID: <Yxl37LhGgCC+6J1K@coredump.intra.peff.net>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
 <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
 <xmqq1qsnugsu.fsf@gitster.g>
 <YxkAxutS+B8//0WF@coredump.intra.peff.net>
 <YxkG3A30vNfu55Sx@coredump.intra.peff.net>
 <xmqq8rmususl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rmususl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2022 at 03:07:22PM -0700, Junio C Hamano wrote:

> > Subject: [PATCH] t1060: check partial clone of misnamed blob
> [...]
> Thanks.  Let's queue it on top.

<sigh> This fails the leak-check CI job because of existing leaks in
"clone --filter". I think I found the (or perhaps "a") bottom of that
rabbit hole, though:

  https://lore.kernel.org/git/Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net/

-Peff
