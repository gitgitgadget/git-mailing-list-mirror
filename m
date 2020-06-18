Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BD5C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 11:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434C6207E8
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 11:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgFRLpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:45:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:35912 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgFRLpc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 07:45:32 -0400
Received: (qmail 18042 invoked by uid 109); 18 Jun 2020 11:45:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Jun 2020 11:45:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12681 invoked by uid 111); 18 Jun 2020 11:45:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Jun 2020 07:45:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Jun 2020 07:45:30 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 01/12] fast-export: do anonymize the primary branch
 name
Message-ID: <20200618114530.GA41345@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <ebd10f73cd73a8fca84d1862e5a4b7b62a549bcd.1592225416.git.gitgitgadget@gmail.com>
 <20200616125833.GE666057@coredump.intra.peff.net>
 <xmqqmu51v9qy.fsf@gitster.c.googlers.com>
 <20200617212333.GB2809@coredump.intra.peff.net>
 <CABPp-BETyMYm=5APqAA3D1JmkurDFNkKLDrcF4MUgEfqEuVKFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BETyMYm=5APqAA3D1JmkurDFNkKLDrcF4MUgEfqEuVKFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 07:06:26PM -0700, Elijah Newren wrote:

> > That leaves us in the interim with a "fast-export --anonymize" that is a
> > little harder to use (you have no way to know which branch was which).
> 
> Why does fast-export special case on "master" rather than on HEAD?
> Isn't it more relevant to know the active branch than what _might_
> have been the initial branch?  It kind of feels like a bug to me that
> HEAD isn't the special case construct.

I don't really remember my exact thought at the time, but it was
probably along the lines of: "master" is special not because it's
inherently special, but because revealing it doesn't compromise the
anonymity, since it's not a user-selected name.

That's not true of other names we might see in HEAD. But if we're
turning it into "ref0" or some other special name anyway, then we
haven't revealed anything.

That said, I still lean towards just being able to dump the whole
mapping by request. That solves this problem and many more.

-Peff
