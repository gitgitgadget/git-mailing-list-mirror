Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA85C433E3
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D42A2075D
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgG3Awq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:52:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:42186 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgG3Awp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:52:45 -0400
Received: (qmail 10945 invoked by uid 109); 30 Jul 2020 00:52:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Jul 2020 00:52:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13443 invoked by uid 111); 30 Jul 2020 00:52:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 20:52:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 20:52:43 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
Message-ID: <20200730005243.GD2996059@coredump.intra.peff.net>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
 <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
 <20200729205846.GA2992025@coredump.intra.peff.net>
 <CAHk-=wg7r=y_tYpWuRwNFP0JU5D4g=UN1puCzkvQP4bey0-Hmw@mail.gmail.com>
 <20200730002944.GB2996059@coredump.intra.peff.net>
 <CAHk-=wgdKi+Mhq3TKVKLKTm0RBxjHpg7C2co8xRnvPuV5sgJUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdKi+Mhq3TKVKLKTm0RBxjHpg7C2co8xRnvPuV5sgJUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 05:44:00PM -0700, Linus Torvalds wrote:

> On Wed, Jul 29, 2020 at 5:29 PM Jeff King <peff@peff.net> wrote:
> >
> > This is an interesting middle ground. I'm a little iffy on it just
> > because it complicates the very simple case of "should I mention the
> > destination branch",
> 
> No, you're absolutely right. After sending that message I went and
> looked at how nasty it would be, and it's not worth it.
> 
> If we were doing perl or shell or whatever (like the original scripts
> were), it would have been trivial. But as things are now, I'll retract
> that idea as being overly complicated.

Heh. For what it's worth, I wrote a paragraph that started with "if we
were doing this in perl..." in my response but deleted it. So I think we
are very much on the same page. :)

> It would solve my "rewrite repo name" thing, but I've solved that with
> a hook, and it's a bit hacky, but it's not horrendous or wrong. As you
> say, hooks are for special cases, and that hostname rewriting I do is
> very much a special case.

There might be room for an easy feature there, too. If we're given url A
on the command line and then we convert it to B with insteadOf, it's not
clear to me which one is the thing we should write into the merge
message. (I'd think "A", but it sounds from your example that we write
"B"). So possibly reversing that behavior, or adding an option to do so,
would help. Or providing an equivalent of insteadOf that applies to
writing URLs publicly.

And while it's definitely a special case, I suspect it may be one that
other folks have, too (e.g., mentioning https:// URLs is probably more
friendly than ssh for most people).

-Peff
