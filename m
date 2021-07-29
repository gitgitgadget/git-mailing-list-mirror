Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FC8C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4C560F21
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhG2ONS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:13:18 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:48399 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237988AbhG2OLs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 10:11:48 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m96lC-000Amm-Fr; Thu, 29 Jul 2021 15:11:43 +0100
Subject: Re: Using two-dot range notation in `git rebase`?
To:     Jeff King <peff@peff.net>
Cc:     Daniel Knittl-Frank <knittl89@googlemail.com>,
        Git List <git@vger.kernel.org>
References: <b3b5f044-8c76-ec71-45d6-1c7fea93c519@iee.email>
 <CACx-yZ1Je+tnZdJ21gDPeuQa-QTuY2t9mDujNr7wqJWFMwwzxA@mail.gmail.com>
 <dc7668ff-37ad-1d9e-fc92-df432549b4e2@iee.email>
 <YQKBNXsMdroX3DfY@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1d730e32-a41e-73a6-5f20-70a652a9f6a2@iee.email>
Date:   Thu, 29 Jul 2021 15:11:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQKBNXsMdroX3DfY@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/07/2021 11:21, Jeff King wrote:
> On Thu, Jul 29, 2021 at 10:58:15AM +0100, Philip Oakley wrote:
>
>> In summary, there are two aspect:
>> - first, being able to use a common short-form within the command, and
>> - second, that the documentation's description includes rather too many
>> tricky concepts to properly understand all the ramifications, leaving me
>> to think "why can't I just say `git rebase --onto here old..end` or `git
>> rebase --onto here start^..end` ? "
> I do think "git rebase --onto here old..end" is a sensible thing to ask
> for. If we were designing it today, I'd probably suggest that rebase
> take arbitrary revision sets (and either require "--onto", or perhaps as
> long as there is only one negative tip given, that becomes the "--onto"
> point).

Sensible.
>
> It might be possible to migrate to such a syntax, but we'd have to be
> careful of ambiguities with the current syntax. It might be possible to
> infer the intended use based on the presence or absence of negative tips

My first though was to limit it to just the double-dot itself (rather
than waiting for it's conversion to using the negative ref notation),
but that may be at the wrong part of the command line decoding.

> (so "git rebase foo bar" must be "foo is the upstream, and therefore
> base branch", whereas "git rebase foo..bar" is a range, though the two
> would do the same thing).
>
> I think we did something similar with cherry-pick, which originally took
> only a series of single commits.
>
> I admit that I haven't thought carefully through the details, though.
> There may be some gotchas in how "rebase" treats the base branch.

My main issue (beyond the nice to have) is simply decoding all of the
documentation's terminology, which starts complex, and stays pretty
complicated... It is rather easy to mess up.

Philip
