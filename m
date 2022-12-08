Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B63C3A5A7
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 07:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLHHBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 02:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHHBH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 02:01:07 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23766F0F9
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 23:01:06 -0800 (PST)
Received: (qmail 23252 invoked by uid 109); 8 Dec 2022 07:01:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Dec 2022 07:01:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9850 invoked by uid 111); 8 Dec 2022 07:01:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Dec 2022 02:01:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Dec 2022 02:01:05 -0500
From:   Jeff King <peff@peff.net>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
Message-ID: <Y5GLsZgmrxbBtLqo@coredump.intra.peff.net>
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com>
 <20221208011631.GH28810@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221208011631.GH28810@kitsune.suse.cz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2022 at 02:16:31AM +0100, Michal Suchánek wrote:

> > A "git gc" on a "live" repo is always racy in theory, but the odds that
> > you'll run into data corrupting trouble tends to approach zero as you
> > increase the gc.pruneExpire setting, with the default 2 weeks being more
> > than enough for even the most paranoid user.
> 
> And that two weeks expiration applies to what, exactly?
> 
> For commits there is author date and commit date but many other objecs
> won't have these I suppose. And the date when the object is pushed into
> the repository is unrelated to these two, anyway.

In this case it's the mtime on the object file (or the pack containing
it). But yes, it is far from a complete race-free solution.

-Peff
