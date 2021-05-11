Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A76C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369D861184
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhEKTM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:12:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:51124 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhEKTM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:12:58 -0400
Received: (qmail 24224 invoked by uid 109); 11 May 2021 19:11:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 19:11:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27047 invoked by uid 111); 11 May 2021 19:11:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 15:11:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 15:11:51 -0400
From:   Jeff King <peff@peff.net>
To:     Gregory Anders <greg@gpanders.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJrW98FZN/N6u7un@coredump.intra.peff.net>
References: <20210511183703.9488-1-greg@gpanders.com>
 <YJrTlXzuuMoxeJay@coredump.intra.peff.net>
 <YJrVBA4HP0HEqRLD@gpanders.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJrVBA4HP0HEqRLD@gpanders.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 01:03:32PM -0600, Gregory Anders wrote:

> I also noticed this after some quick testing and just sent a v2 right before
> seeing your reply.
> 
> Your (untested) implementation seems much cleaner than mine, and I'm happy
> to give that a try. Question: is it okay that we pass just a raw command
> name to exec instead of a full path? That is, is there any reason we need to
> first find the command in PATH *and then* pass it to exec (which is what my
> v2 implementation does)?

I don't think so. Perl's exec() should do the PATH lookup itself. I was
surprised not to see this mentioned explicitly in the documentation, but
it clearly does work. E.g., try:

  perl -e 'exec("ls")'

-Peff
