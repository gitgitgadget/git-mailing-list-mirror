Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D6EC61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 17:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBPRbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 12:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBPRbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 12:31:50 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAEF4E5CB
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 09:31:49 -0800 (PST)
Received: (qmail 30209 invoked by uid 109); 16 Feb 2023 17:31:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Feb 2023 17:31:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5566 invoked by uid 111); 16 Feb 2023 17:31:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Feb 2023 12:31:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Feb 2023 12:31:48 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] shorten_unambiguous_ref(): avoid sscanf()
Message-ID: <Y+5ohGA6NKNi6Di6@coredump.intra.peff.net>
References: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
 <Y+z3RfhAxW/2iNYP@coredump.intra.peff.net>
 <20230216055641.brlx3os2ucj3ywer@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216055641.brlx3os2ucj3ywer@tb-raspi4>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 06:56:41AM +0100, Torsten Bögershausen wrote:

> Does it make sense to
> a) Use the local locale, what ever that is

It is always "C", because that's what our tests do. And we found that
wasn't particularly interesting to this case.

> b) Re-run with LC_ALL=en_US.UTF-8

That part's what we already do, and...

> c) Re-run with LANG=C (that is where I had suspected problems when using UTF-8)

This won't do anything, because we set LC_ALL in the test scripts, which
takes precedence over LANG. Eric used it in his real-world testing
because he quite sensibly does not have LC_ALL set in his usual shell. :)

> d) Mention MacOs here ?

Yup, discussed downthread.

-Peff
