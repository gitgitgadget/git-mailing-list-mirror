Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E8FECAAA1
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 05:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIKFI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 01:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIKFI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 01:08:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827D2356F7
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 22:08:25 -0700 (PDT)
Received: (qmail 18286 invoked by uid 109); 11 Sep 2022 05:08:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 11 Sep 2022 05:08:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31623 invoked by uid 111); 11 Sep 2022 05:08:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 01:08:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 01:08:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lana Deere <lana.deere@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch: add branch.*.merge to default ref-prefix
 extension
Message-ID: <Yx1tSF7Y9XU8eGQ2@coredump.intra.peff.net>
References: <YxpBMaIckimFJYEi@coredump.intra.peff.net>
 <YxpB0dbFTKp5L94k@coredump.intra.peff.net>
 <xmqq1qslpprv.fsf@gitster.g>
 <xmqqtu5hoamx.fsf@gitster.g>
 <YxqiJW4cSp4cBR22@coredump.intra.peff.net>
 <xmqqv8pxm880.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8pxm880.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2022 at 10:23:43PM -0700, Junio C Hamano wrote:

> Giving extra garbage to the set of prefixes does not hurt the
> correctness, but we didn't add the extra prefix for
> branch.<name>.merge before this fix, so not using
> expand_ref_prefix() is not breaking anybody who weren't broken
> before.  So I think it may be OK to support only the full refs at
> first.  It's just that folks who didn't have full refname as the
> value is not helped by our fix.

Right. My patch is a strict improvement. I just wasn't sure if we should
go further while we are here.

> If enough folks complain that they have handcrafted (or prepared by
> third-party tools) branch.<name>.merge that is not a full refname,
> we could switch to expand_ref_prefix() and as long as the refnames
> on the remote side is not ambiguous, things will still work
> correctly, but I'd prefer to keep it tight until we actually hear
> complaints.

OK, that matches my feeling, too. So I think the series as-is should be
fine.

-Peff
