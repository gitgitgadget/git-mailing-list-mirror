Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F864C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 09:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjCJJFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 04:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCJJEz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 04:04:55 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0879AF2484
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 01:01:25 -0800 (PST)
Received: (qmail 19159 invoked by uid 109); 10 Mar 2023 09:01:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Mar 2023 09:01:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10368 invoked by uid 111); 10 Mar 2023 09:01:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Mar 2023 04:01:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Mar 2023 04:01:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] gpg-interface: lazily initialize and read the
 configuration
Message-ID: <ZArx5GvhuG8FSB3n@coredump.intra.peff.net>
References: <xmqqmt5orqgv.fsf@gitster.g>
 <xmqqh6vwrpce.fsf@gitster.g>
 <xmqqlel7rj9z.fsf_-_@gitster.g>
 <Y+Tr1g+HTn45rsTq@coredump.intra.peff.net>
 <xmqqwn4qokug.fsf@gitster.g>
 <xmqqpmaimvtd.fsf_-_@gitster.g>
 <Y/vf7n2+LN/3Nddi@coredump.intra.peff.net>
 <230308.86fsafzllu.gmgdl@evledraar.gmail.com>
 <ZAlSUYlDn7/9d2LQ@coredump.intra.peff.net>
 <xmqq1qlxdfh4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1qlxdfh4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 09:03:35AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Mar 08, 2023 at 09:34:15AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >
> >> As added review: This is the same patch diff as I sent on February 9th:
> >> https://lore.kernel.org/git/patch-1.2-d93c160dcbc-20230209T142225Z-avarab@gmail.com/;
> >> my local range-diff to my previously submitted topic & next being:
> >> [...]
> >> So this LGTM.
> >
> > Thanks, and sorry for stealing your patch. I forgot that yours existed
> > in that thread (and obviously I'm happy if either is applied).
> 
> I am not Ævar but the last time this happened what he said was that
> he did so not because he wanted to complain that somebody else stole
> his thunder but because he wanted to show his agreement to the patch
> by pointing at an indenendent invention of the same thing.
> 
> I personally do not appreciate that tactics, exactly because it can
> easily be misinterpreted as a complaint.  Saying "I read the patch
> and I think it is exactly how I would solve the problem, too.
> Looking good" would have been much safer in that regard and conveyed
> the same agreement.

I think you are being too hard on Ævar here. While I agree it can be
interpreted as passive aggressive sniping, I'd be a little frustrated,
too, if I had written a patch and then somebody submitted the exact same
thing later. (Hence my response that it was "oops" and not an
intentional slight).

If two people are independently doing the same work, we're wasting
effort, and it's worth thinking about how we can avoid that. In this
particular case, my opinion is that Ævar's original patch was OK by
itself, but it was coupled with an unwelcome change. Submitting the
cleanup to the now-empty callbacks on their own would have had a greater
chance of success. (As a maintainer, you can also split up patches after
the fact, but there is cognitive load in doing so. Minimizing that load
is something submitters can do to help the project scale).

-Peff
