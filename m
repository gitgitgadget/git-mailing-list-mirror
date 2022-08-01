Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC4EC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 17:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiHARqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiHARqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 13:46:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A342A435
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 10:46:10 -0700 (PDT)
Received: (qmail 654 invoked by uid 109); 1 Aug 2022 17:46:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Aug 2022 17:46:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23418 invoked by uid 111); 1 Aug 2022 17:46:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Aug 2022 13:46:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Aug 2022 13:46:08 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
Message-ID: <YugRYN6sbP+RpxlJ@coredump.intra.peff.net>
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
 <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
 <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
 <YuXLtIBXYG+JBKdV@coredump.intra.peff.net>
 <CAHk-=wi5pfUcuaAUz=rifon9d51mshE7k6bkpMXddog0On9jow@mail.gmail.com>
 <YugQqp4oN26OFOpt@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YugQqp4oN26OFOpt@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 01, 2022 at 01:43:06PM -0400, Jeff King wrote:

>   2. Your patch, but with ALLOW_ONELEVEL. This fixes nonsense like
>      "foo..bar", but doesn't break "FETCH_HEAD". Requires fixing t4202's
>      ".lock" example. Replaces the HEAD starts_with("refs/") check.
> 
>   3. Your patch as-is. Same as (2), but also breaks FETCH_HEAD.

Er, sorry, the starts_with() thing is the other way around. It is
redundant with your patch, but necessary to keep it for (2). Luckily
t1401 catches the problem if you dare to try it. ;)

-Peff
