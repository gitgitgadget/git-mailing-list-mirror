Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DD8C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 02:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4DD60FDA
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 02:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbhH0CFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 22:05:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:60334 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231588AbhH0CFr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 22:05:47 -0400
Received: (qmail 5325 invoked by uid 109); 27 Aug 2021 02:04:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Aug 2021 02:04:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11050 invoked by uid 111); 27 Aug 2021 02:04:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Aug 2021 22:04:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Aug 2021 22:04:58 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     git@vger.kernel.org
Subject: Re: How to interactively rebase-and-reword nth commit?
Message-ID: <YShISkyN7stYtkV2@coredump.intra.peff.net>
References: <eda317b080a2e75a170c051c339a76115cce5ad7.camel@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eda317b080a2e75a170c051c339a76115cce5ad7.camel@yandex.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 05:06:03PM +0300, Konstantin Kharlamov wrote:

> Any ideas, how can I tell `git` that I want to "reword" nth commit right away? Sure,
> I am not the first one to stumble upon it, am I? Any ideas?

Have you looked at the new --fixup options in 2.32? E.g.:

  git commit --fixup reword:HEAD~2

will immediately drop you in an editor to adjust the commit message. The
result is a new "fixup" commit which is then applied when you
autosquash. So you could do multiple such adjustments, and then:

  GIT_EDITOR=: git rebase -i --autosquash

to apply them all to the appropriate spots.

-Peff
