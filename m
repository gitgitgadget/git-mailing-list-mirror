Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38A5C19F2B
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 01:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbiG3Bkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 21:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3Bkf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 21:40:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0142511A03
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 18:40:33 -0700 (PDT)
Received: (qmail 23244 invoked by uid 109); 30 Jul 2022 01:40:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 Jul 2022 01:40:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31824 invoked by uid 111); 30 Jul 2022 01:40:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 21:40:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 21:40:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] merge-file: fix build warning with gcc 4.8.5
Message-ID: <YuSL/2N29cCy9Dzd@coredump.intra.peff.net>
References: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
 <xmqqbkt7api9.fsf@gitster.g>
 <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
 <YuR5Jado2LrtZUjP@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuR5Jado2LrtZUjP@danh.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 30, 2022 at 07:19:49AM +0700, Đoàn Trần Công Danh wrote:

> > Tested on a debian jessie chroot using gcc-4.8 and 4.9. Though note that
> > you also need to manually specify -std=gnu99 to get it to work at all
> > with those compilers these days! So I kind of wonder if it's even worth
> > catering to their warnings automatically.
> 
> Well, config.mak.uname automatically adds -std=c99 for RHEL 7 and
> CentOS7. Can we add the same things for Debian? Or should we just
> remove both?

Ah, I didn't know about that. No, I don't think there's any reason to
remove them. If people are able to compile out of the box there, then my
patch to config.mak.dev may be worth doing.

As far as adding a similar config.mak.uname thing for Debian, I don't
have a strong opinion. Jessie is far beyond being supported, so I'd
probably wait to see if somebody who actually cares proposes a patch.

-Peff
