Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4132DC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 21:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 033B323A02
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 21:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbgLIVco (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 16:32:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:56154 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388045AbgLIVcn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 16:32:43 -0500
Received: (qmail 20372 invoked by uid 109); 9 Dec 2020 21:32:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Dec 2020 21:32:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20483 invoked by uid 111); 9 Dec 2020 21:32:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 16:32:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 16:32:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Julien Richard via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Julien Richard <jairbubbles@hotmail.com>,
        Julien Richard <julien.richard@ubisoft.com>
Subject: Re: [PATCH] doc: 'T' status code for git status
Message-ID: <X9FCUseRteZ1n7ec@coredump.intra.peff.net>
References: <pull.930.git.git.1607501616914.gitgitgadget@gmail.com>
 <X9ELRf7s9sBcs9CD@coredump.intra.peff.net>
 <xmqqsg8e20b8.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsg8e20b8.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 12:26:19PM -0800, Junio C Hamano wrote:

> A few things about the attached.
> 
>  - it drops "updated but" from the explanation of 'U' in the list.

Seems reasonable.

>  - after that, everything in the list becomes a single-word, so
>    instead of "type changed", it invents a verb "type-change" and
>    uses its pp. form when adding an entry for 'T'.

Also reasonable.

>  - it updates the table to add 'T' next to 'M'.

Yep, that was what I was thinking would make sense.

>  - "work tree changed since index" in the table was awkward; it
>    rephrases it to "modified in work tree relative to index",
>    because (1) these entries are not talking about the working tree
>    as a whole; it is one path in the working tree changing its
>    type. and (2) using "changed" and "updated" for the same 'M' in
>    different context was unnecessarily confusing.  Instead, it uses
>    'modified', which appears in the list before the table.

The first line seems funny to me now, though (diff abridged):

> -	 [AMD]   not updated
> +        [AMTD]   not changed

If the file is not changed, then why are we even mentioning it? Because
of course it _is_ changed in the filesystem, but the index was not
updated to reflect the change. And that's what I think the original was
getting at with "updated".

TBH, I find the whole table overly confusing. But then, I am completely
comfortable with the notion that it is really showing two diffs, with
their results collated. To me it is simpler to just discuss the two
sides of the diff independently, and then you do not even really need a
table at all ("M" means modified no matter which column it appears in).
But I may not be a representative Git user.

-Peff
