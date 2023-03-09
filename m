Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A0C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 09:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCIJxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 04:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCIJxU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 04:53:20 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087071EFDA
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 01:53:15 -0800 (PST)
Received: (qmail 7950 invoked by uid 109); 9 Mar 2023 09:53:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 09:53:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29627 invoked by uid 111); 9 Mar 2023 09:53:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 04:53:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 04:53:14 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] Add a CI for unsigned char system
Message-ID: <ZAmsikbYncUbNjD2@coredump.intra.peff.net>
References: <cover.1677850517.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1677850517.git.congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2023 at 08:46:02PM +0700, Đoàn Trần Công Danh wrote:

> Recently, we have a brokeness on system with unsigned char because most of
> people are working with x86_64 which has signed char.
> 
> This series tries to add a CI system for a widely used system with signed
> char, which is arm64 via circle-ci.

I like the overall goal, but I'm not wild about having another CI
provider. That requires people logging in there, and then dealing with
possible credit overages, etc.

I wonder what the timeline is for GitHub Actions getting arm64 support.
It looks like there are images for linux/arm64, but no runners yet,
according to:

  https://github.com/actions/runner-images/issues/5631

You can point it at your own runners, and some people in that thread
mentioned a third-party service which provides arm machines. That
doesn't get out of the "oops, credits" handling, but it would at least
keep the CI results all together.

I dunno. Another option I saw suggested is using qemu within a regular
GitHub runner. I have no idea if that would be painfully slow or what,
but it looks like people have even written actions to handle it:

  https://github.com/docker/setup-qemu-action

-Peff
