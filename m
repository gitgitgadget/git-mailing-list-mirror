Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA9C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 17:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEE560F42
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 17:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhG2R3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 13:29:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:32818 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhG2R3b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 13:29:31 -0400
Received: (qmail 9078 invoked by uid 109); 29 Jul 2021 17:29:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jul 2021 17:29:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23519 invoked by uid 111); 29 Jul 2021 17:29:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jul 2021 13:29:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Jul 2021 13:29:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Daniel Knittl-Frank <knittl89@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Using two-dot range notation in `git rebase`?
Message-ID: <YQLldzh5OEY+mPLY@coredump.intra.peff.net>
References: <b3b5f044-8c76-ec71-45d6-1c7fea93c519@iee.email>
 <CACx-yZ1Je+tnZdJ21gDPeuQa-QTuY2t9mDujNr7wqJWFMwwzxA@mail.gmail.com>
 <dc7668ff-37ad-1d9e-fc92-df432549b4e2@iee.email>
 <YQKBNXsMdroX3DfY@coredump.intra.peff.net>
 <xmqqr1fh59go.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1fh59go.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 10:13:59AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > long as there is only one negative tip given, that becomes the "--onto"
> > point).
> 
> So "git newbase [--options] A..B" would
> 
>  - checks if B names an existing branch or just a commit
> 
>  - detaches HEAD at commit A
> 
>  - replays commits in DAG A..B on top of it; the exact way the
>    history is replayed is affected by the options given (e.g. "-m"
>    and "-p" may try to preserve history shapes)
> 
>  - if B was determined to be a branch name, "git branch -f" to it;
>    otherwise leave the HEAD detached.
> 
> which all sounds OK, but I do not see a huge improvement over the
> current "git rebase [--options] A B" (other than that you can type
> double dot instead of a single space).

Yeah, I don't see it as a huge benefit either.

Potentially it opens the door for stuff like:

  git rebase ^A B C D

but I am not sure if that is helpful or horrifying. ;)

(To be clear, I am not necessarily advocating any of this, but just
thinking aloud of possibilities. And I'm definitely not planning to work
on it myself.)

-Peff
