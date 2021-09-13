Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FF3C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B800C603E8
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbhIMT2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:28:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:46506 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240628AbhIMT2k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:28:40 -0400
Received: (qmail 20990 invoked by uid 109); 13 Sep 2021 19:27:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Sep 2021 19:27:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13325 invoked by uid 111); 13 Sep 2021 19:27:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Sep 2021 15:27:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Sep 2021 15:27:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/4] difftool: use run_command() API in run_file_diff()
Message-ID: <YT+mGUkQAG7eVZp0@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
 <patch-v2-3.4-2b093bd71fc-20210913T033204Z-avarab@gmail.com>
 <YT+SkhLsfE/yIqhN@coredump.intra.peff.net>
 <87a6kg46xh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6kg46xh.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 09:13:43PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Yes, I had something like that in the earlier round, but decided to try
> to keep the diff minimal, churn and all that. So it would be nice, but
> let's do it as some later cleanup if someone's interested.

OK, let's leave it for now, then.

> Aside: I did most of that removal of "argv" from the child_process
> struct you suggested, it's in
> avar/run-command-use-less-argv-use-args-instead in my repo if you're
> curious / wanted to pick any of that up. I won't be submitting it any
> time soon for the reasons noted upthread.

Yeah, it's rather far-reaching, which is why I didn't do a
mass-conversion when I introduced "args" in c460c0ecdc (run-command:
store an optional argv_array, 2014-05-15). My plan was to clean up spots
over time as we touched them, but of course that's quite a slow process.

Mostly I just didn't want to see any sites going the _other_ direction,
as in your original version of the series. :)

I'm quite happy with what you ended up with here.

-Peff
