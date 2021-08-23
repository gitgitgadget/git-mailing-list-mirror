Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9A8C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED72613AD
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 18:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhHWSyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:54:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:56996 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhHWSyO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 14:54:14 -0400
Received: (qmail 13031 invoked by uid 109); 23 Aug 2021 18:53:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Aug 2021 18:53:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31471 invoked by uid 111); 23 Aug 2021 18:53:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Aug 2021 14:53:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Aug 2021 14:53:31 -0400
From:   Jeff King <peff@peff.net>
To:     Nikita Bobko <nikitabobko@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git read-tree doesn't accept tree-ish
Message-ID: <YSPuq/HmF3tnYHCA@coredump.intra.peff.net>
References: <CAMJzOtxMjEuAy2B3oJqOZEnipmC4OBWxhQLx_baXDHcQ1C7-+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMJzOtxMjEuAy2B3oJqOZEnipmC4OBWxhQLx_baXDHcQ1C7-+g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 07:31:29PM +0200, Nikita Bobko wrote:

> ```
> git init
> echo foo > foo
> git add --all
> git commit -m 'foo'
> 
> echo bar > foo
> git add --all
> git commit -m 'bar'
> 
> git read-tree HEAD~:foo
> ```
> EXP: Read information about file `foo` into index
> ACT: `fatal: failed to unpack tree object HEAD~:foo`
> 
> I expect it to work because manpage says that `git-read-tree` accepts
> `<tree-ish>`

In your example, "foo" is a blob, not a tree. And thus HEAD~:foo
is not a tree-ish. Just "HEAD~" would be.

What are you trying to do?

-Peff
