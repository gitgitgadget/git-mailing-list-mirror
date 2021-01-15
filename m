Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F94C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B55235F8
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbhAOTR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:17:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:57566 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbhAOTR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 14:17:27 -0500
Received: (qmail 3617 invoked by uid 109); 15 Jan 2021 19:16:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Jan 2021 19:16:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32376 invoked by uid 111); 15 Jan 2021 19:16:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Jan 2021 14:16:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Jan 2021 14:16:46 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Simon Ruderich <simon@ruderich.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v8 5/8] config: store "git -c" variables using more
 robust format
Message-ID: <YAHqHmGOUl53mfPa@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
 <36c2a51b13e463a4aa8e5316447336927153d99d.1610453228.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36c2a51b13e463a4aa8e5316447336927153d99d.1610453228.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 01:27:01PM +0100, Patrick Steinhardt wrote:

> The previous commit added a new format for $GIT_CONFIG_PARAMETERS which
> is able to robustly handle subsections with "=" in them. Let's start

It looks like this commit and 6 got flipped from the original ordering
(it's the "previous commit" talked about here). And indeed, running the
tests on the individual commits in this series shows that we fail at
this step (because we are writing the new format, but the reader is too
strict to accept it).

That doesn't matter to the end result, of course, but it hurts later
bisecting. Just flipping patches 5 and 6 makes it all work.

-Peff
