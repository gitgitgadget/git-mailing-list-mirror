Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAB1C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 20:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6736C20768
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 20:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgDHUF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:05:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:37412 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726550AbgDHUF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 16:05:28 -0400
Received: (qmail 13134 invoked by uid 109); 8 Apr 2020 20:05:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Apr 2020 20:05:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11607 invoked by uid 111); 8 Apr 2020 20:15:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2020 16:15:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Apr 2020 16:05:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
Message-ID: <20200408200526.GA2270445@coredump.intra.peff.net>
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
 <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
 <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
 <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
 <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 08, 2020 at 12:46:41PM -0700, Junio C Hamano wrote:

> Our features written with the intent to be useful for one purpose
> often end up being used for purposes other than what the feature was
> originally written for (the "--pickaxe" has always been a bitter
> example of this for me).
> 
> For that reason, I am a bit hesitant to endorse "audit" exactly
> because of the implication of "intent".

Yeah, I agree with this.

> I wonder if there is a simple-enough phrase to convey what the
> latter half of above sentence says.  "include" and "keep" are both
> good verbs---normally we discard these merges, because they do not
> contribute at the level of individual changes, but with the option,
> we "include" or "keep" these merges in the output.  It's not like
> we keep _all_ the merges, but selected merges only.  How do we
> decide which merges to keep?
> 
> I guess your "--first-merges" came from such a line of thought, and
> is the closest among the five to what I have in mind, but it drops
> too many words and loses too much meaning.  
> 
> "--keep-first-parent-merges", perhaps?

FWIW, this name left me more confused, because "first-parent merges"
isn't an already-defined term I knew. And it seems like all merges have
a first parent. Having read the patch description, I guess it's "a merge
which isn't TREESAME to its first-parent".

I can't think of a more succinct way to name that, though. And possibly
if we gave that definition in the documentation, that would be enough.
The name doesn't have to be a complete description; it only has to make
sense once you know what you're trying to do (and be memorable enough).

-Peff
