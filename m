Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5541C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C638160F57
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbhJHUEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:04:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:36114 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhJHUEo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:04:44 -0400
Received: (qmail 6169 invoked by uid 109); 8 Oct 2021 20:02:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 20:02:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16641 invoked by uid 111); 8 Oct 2021 20:02:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Oct 2021 16:02:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Oct 2021 16:02:48 -0400
From:   Jeff King <peff@peff.net>
To:     Alan Mackenzie <acm@muc.de>
Cc:     git@vger.kernel.org
Subject: Re: How do I get the file contents from an arbitrary revision to
 stdout?
Message-ID: <YWCj6NqMrxksN1V8@coredump.intra.peff.net>
References: <YWCFFcNeNVTYcELN@ACM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWCFFcNeNVTYcELN@ACM>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 08, 2021 at 05:51:17PM +0000, Alan Mackenzie wrote:

> I would like there to be a command something like:
> 
>     $ git cat bar-branch -- foo.c
> 
> ..  Is there such a command, and if so, what's it called and how do I use
> it?  I assumed it might be git cat-file, but I couldn't get it to work,
> and couldn't understand it's man page.

Konstantin pointed you at git-show, which is what I would have used. But
I just wanted to mention that you were on the right track. The
invocation you wanted was:

  git cat-file blob bar-branch:foo.c

or:

  git cat-file -p bar-branch:foo.c

(the "-p" is "pretty-print based on the object's type", so the two are
equivalent).

> Where might I have found this information for myself?

You found the cat-file manpage, which I agree is a bit thick. An
Examples section would probably help a lot.

The other thing that might have helped is the gitrevisions(7) page,
especially the <rev>:<path> entry. Your example above to use "<revs> --
<pathspec>" was a good thought, but the path there is for limiting diffs
and traversals. What you want here is to specify the name of a single
object, and gitrevisions gives all the ways to do that.

-Peff
