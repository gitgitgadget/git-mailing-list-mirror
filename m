Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E554C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757B260EE2
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhGWGUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:20:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:55330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234136AbhGWGUg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 02:20:36 -0400
Received: (qmail 10064 invoked by uid 109); 23 Jul 2021 07:01:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 07:01:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22633 invoked by uid 111); 23 Jul 2021 07:01:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 03:01:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 03:01:09 -0400
From:   Jeff King <peff@peff.net>
To:     Angelo Borsotti <angelo.borsotti@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Extracting a file
Message-ID: <YPppNYOO26xAq2fn@coredump.intra.peff.net>
References: <CAB9Jk9AafnUQr6q8t=b4Dh0PZHUA=fKJmtXxxObuGpF_w-_2wQ@mail.gmail.com>
 <871r7qvhhr.fsf@evledraar.gmail.com>
 <CAB9Jk9DqCR8C9qx6-gZmpTQfBAKnEupQTb1WkJgN3YOqSO0=2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB9Jk9DqCR8C9qx6-gZmpTQfBAKnEupQTb1WkJgN3YOqSO0=2A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 11:46:01AM +0200, Angelo Borsotti wrote:

> Actually, I did not want to make git behave like a read-only filesystem,
> but only to be able to get what is stored in it using some easy to remember
> command.
> 
> I guess that:
> 
>     git mv A B &&
>     git checkout HEAD -- A
> 
> renames file A in the work, current, directory to B, and then recovers
> A from the
> repository. This changes the file on which I am working. After having
> read the old
> A, and understood what changes I make that are not correct, I should delete A,
> and rename B back to A.
> If something gets wrong with this, I risk to damage my original A.
> This is why it is
> better not to change it, and instead get a copy of the old one with
> another name,
> which is what
> 
> git show HASH:file/path/name.ext > some_new_name.ext

You might also like "git checkout -p HASH -- A", which will let you pick
individual hunks from HASH:A and apply them to your working tree.

-Peff
