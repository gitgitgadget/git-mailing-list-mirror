Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CA3C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA9660E76
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhG3QNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:13:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:33894 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhG3QNF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 12:13:05 -0400
Received: (qmail 15573 invoked by uid 109); 30 Jul 2021 16:12:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Jul 2021 16:12:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3164 invoked by uid 111); 30 Jul 2021 16:12:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Jul 2021 12:12:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Jul 2021 12:12:58 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/7] merge-ort: switch our strmaps over to using
 memory pools
Message-ID: <YQQlCvqbCaJEHMy3@coredump.intra.peff.net>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
 <dd8839b284330892a3bbcafbc03d71489fc9b01f.1627531121.git.gitgitgadget@gmail.com>
 <YQLJOsvATnTBd9pB@coredump.intra.peff.net>
 <CABPp-BHzJ365Jed38s-VQb2PqRy7t=58sZwgmeVG=mqKeA2neg@mail.gmail.com>
 <YQMLBW6LAZmQ8nDz@coredump.intra.peff.net>
 <CABPp-BE8OEjcMrJO8uijLFsvvpQH9KA=a+p_6bH71Z6QxXLB6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE8OEjcMrJO8uijLFsvvpQH9KA=a+p_6bH71Z6QxXLB6w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 08:30:23PM -0600, Elijah Newren wrote:

> > What if there was a flags field? Then it could be combined with the
> > free_values parameter. The result is kind of verbose in two ways:
> >
> >  - now strset_clear(), etc, need a "flags" parameter, which they didn't
> >    before (and is just "0" most of the time!)
> >
> >  - now "strmap_clear(foo, 1)" becomes "strmap_clear(foo, STRMAP_FREE_VALUES)".
> >    That's a lot longer, though arguably it's easier to understand since
> >    the boolean is explained.
> >
> > Having gone through the exercise, I am not sure it is actually making
> > anything more readable (messy patch is below for reference).
> 
> Thanks for diving in.  Since it's not clear if it's helping, I'll just
> take your earlier suggestion to rename the "strmap_func" variable to
> "strmap_clear_func" instead.

That sounds just fine with me. Thanks for considering my tangent. :)

-Peff
