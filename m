Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54F2C25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 07:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAVHuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 02:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVHuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 02:50:19 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9871E9C0
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 23:50:17 -0800 (PST)
Received: (qmail 4972 invoked by uid 109); 22 Jan 2023 07:50:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Jan 2023 07:50:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27798 invoked by uid 111); 22 Jan 2023 07:50:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Jan 2023 02:50:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Jan 2023 02:50:16 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] tree-walk: disallow overflowing modes
Message-ID: <Y8zquGar3rLyRdTp@coredump.intra.peff.net>
References: <d673fde7-7eb2-6306-86b6-1c1a4c988ee8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d673fde7-7eb2-6306-86b6-1c1a4c988ee8@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2023 at 10:36:09AM +0100, René Scharfe wrote:

> When parsing tree entries, reject mode values that don't fit into an
> unsigned int.

Seems reasonable. I don't think you can cause any interesting mischief
here, but it's cheap to check, and finding data problems earlier rather
than later is always good.

Should it be s/unsigned int/uint16_t/, though?

-Peff
